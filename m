Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B57CD916
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjJRKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjJRKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:22:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3BCEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:22:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso689483066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697624545; x=1698229345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vRlhn6zJXKGhkaRHFdbQmiYpJ9J9KHu/JlP2a3//gU=;
        b=kTjNX1+/MtxzUAcig7R33bXUkXSieuj0RKvPFwFtZPbVXsP/+Qg7nacvqoPpan5wPw
         gxgyMPW80jWfvIT37TUVlbY642ti9IO9SF05HV6hwtnzViPX6RFI0aEMqJ0qqP0B8TOH
         MGBX6MLpEbCik1E+cw4AUiZ9ytOmqQC+VpP8u+6EBGsJYAp2nbNu+CGotLZVZLM47FJa
         OE72KLzHkcLyXg18P2Unbz4/1NWWtpI9RSB6zSkYzKImNTwwsbo4goQ38ySi4swW/iaD
         1TGG3E7tHhqssUar37CfbbeAVjkjLHUCZ9U+7oQ18UaRyK+BkFeiIvcBPYchicLFFnuC
         KU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624545; x=1698229345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vRlhn6zJXKGhkaRHFdbQmiYpJ9J9KHu/JlP2a3//gU=;
        b=EB3Y+KJl/hlogw8STJ73JVT4zaY+eARNEbmpBv7onc535mQ+9yaMt0TNlfXBWppJY1
         QRtqIP3Ss5RiXWK+3bFGF/JG+N0yG/bW7NkJgn7F67T/UB2x3SebZPlV5ly+ohsUUI6A
         kisPFUvZ84dcZDflSuYYrkz29Njd2XTum81MbjzkRj9p5FpWl0vjE87pUfa+Bk3s45nS
         cFK00vZYiTlB0MIQyG1iuFAgJOBkw5LUBuBaJbtBBFtF+VGMAU106s7o0/drmZfF1yp4
         CeOXovyJ03c4cx385hlUwxgr2tzJUOQKf4+sGGYoHm8QPOez11k9ZySDsnBiRUALmMM/
         jS0A==
X-Gm-Message-State: AOJu0YyPVGlsyRhFqllXFtfuvylNtqDDhoJ8ww6SMfv/kgDHE73kALtK
        Q9wXMRhqioi6QEWu+/GyyNk=
X-Google-Smtp-Source: AGHT+IGzGWucR9AqXhPj7ajEWS2SbU8ETXcoq6xPSqSMzFvzMHyNnrZ3IV0hx/dKqSE+x1/PGqhf6g==
X-Received: by 2002:a17:906:dc8b:b0:99b:ed44:1a79 with SMTP id cs11-20020a170906dc8b00b0099bed441a79mr3988509ejc.3.1697624544984;
        Wed, 18 Oct 2023 03:22:24 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906224200b009c6e58437dasm1387420ejr.37.2023.10.18.03.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:22:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 12:22:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Rutherford <srutherford@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] x86/sme: Mark the code as __head in
 mem_encrypt_identity.c
Message-ID: <ZS+x3oi0N6d3MZ8b@gmail.com>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
 <ZS6DngTm9ILei4dM@gmail.com>
 <874jip58pp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jip58pp.ffs@tglx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Oct 17 2023 at 14:52, Ingo Molnar wrote:
> > * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >> -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> >> -static inline void __init sme_enable(struct boot_params *bp) { }
> >> +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
> >> +static inline void sme_enable(struct boot_params *bp) { }
> >
> > So I think we should preserve the previous convention of marking functions 
> > __init in the header-declaration and at the definition site as well, and do 
> > the same with __head as well?
> 
> I'm not convinced about the value of prototype annotations, but have no
> strong preference either.

So it has some minor documentation purpose: when someone looks up a 
function via the header only (I do that frequently), __init-alike 
annotations really show the intended boot-only limitations of the API.

But that's a really minor Nth order benefit, I have no strong preference 
either.

Thanks,

	Ingo
