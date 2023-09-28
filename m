Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2839F7B1767
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjI1Jc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Jc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:32:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C035139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:32:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso4054917a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695893574; x=1696498374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxR1dOglbqgOOVzmGfNgT0ZpKUrM6pUaXGLXhw2gBvg=;
        b=HBetAdiOcbQP3yYiebtdB/aw9UMy7+cRaTkRAKTEx8MwtSHsdRJ4cdOCP5RnMoRhBM
         iQmUavn5LwTeFBSh58gGFl5czJ9VHSOD26AD7juYnJ09HjMq0flzY6CDqUPlSS4kdtga
         qnRLJnoi6k+9kkAQS6PU4073OTbxwUVJ/EqDHAWiCGoMEC8B8eB9vZGqwjb6UkhyRS/d
         rXJYo/96ttE0oZDuFyMyBZZKlDK1V1cb9HxB7FIqxD0AA4qKA36f3MlGD4v8aZFkp3B+
         HdHU5u6CAmZyBV7ov4DC1BwPE4ILp6mNkS8gQcy8Ns0FkgO5bgZToK4wcZ92rMutWMeN
         N83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893574; x=1696498374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxR1dOglbqgOOVzmGfNgT0ZpKUrM6pUaXGLXhw2gBvg=;
        b=Gx9D52sO/Wt6Ip870ylB1iceCxMj9oH1h/fa63pLlywbnbeuSo0nsFf/1H7MWdwHoq
         61JyN3QTFUQR0TN4sdd/GVY65MmXgJMqZiA9GL7EZNinC1xUA4Va6p3sDG9ZLJN21b/x
         FIDxjimbCzSIBLTOCEs18mE70qXB83l9o8rD3Kbd9G1h0eLlWq2ZnwGg7AAUwA4nf3ZW
         Rx3FlGhp4f2m89+Fduo3tROlTHt9H+jD2RKbnwORd85Aep6wmDA8sVC8DEV3JfcrogIK
         oiivgtPFvnKfxLHQ7NLSmZwFid0/h0gTYLBf3Cm1nvptch4KOJ2nASKXtHKHq/VwkEgx
         t08A==
X-Gm-Message-State: AOJu0Yz2QUmEIzSal7u9n6VFBzeDLi2Zpz4XKnHHwWZ5/h6Bcvd/uE2I
        yaTmeg7iFU81P6N9vMCF9Og=
X-Google-Smtp-Source: AGHT+IHSMdzgAS/LXfX5kP/w0rHMmkfz9FRgkCZUfAhh2IcZxxvQiENiM7rj7RSyoE9MiOCE0CrrtA==
X-Received: by 2002:a05:6402:34c3:b0:530:ec02:babd with SMTP id w3-20020a05640234c300b00530ec02babdmr605003edc.9.1695893573788;
        Thu, 28 Sep 2023 02:32:53 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0564020b6900b00533ec6c617asm6074738edb.54.2023.09.28.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:32:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 11:32:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRVIQwkYO5XYhRtD@gmail.com>
References: <20230926040526.957240-1-aik@amd.com>
 <ZRP6cd6rEymUaiL+@gmail.com>
 <20230927112259.GAZRQQk78aJN85ULm1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927112259.GAZRQQk78aJN85ULm1@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Sep 27, 2023 at 11:48:33AM +0200, Ingo Molnar wrote:
> > Not sure how this was supposed to work - there's no 'ghcb' passed in to
> > snp_cpuid_postprocess(). Does this patch have a dependency perhaps, that
> > I missed?
> 
> Yes, it is explained above the diffstat. I'll take care of it when I get back.

Erm, yes indeed - I checked the first dependency which had the wrong SHA1
listed and which dependency is already upstream as 8dbe33956d96, but I missed
the second dependency:

> > > plus:
> > > https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/

Alexey, for the v3 submission, instead of sending a standalone patch
that relies on a yet unmerged patch that was last submitted about two
months ago, please send a full series of patches that is self-consistent.

Ie. it should look something like this:

  [PATCH 0/2] x86: Misc SEV-SNP fixes
    [PATCH 1/2] x86/sev: Fix SNP CPUID requests to the hypervisor
    [PATCH 2/2] x86/compressed/64: Reduce #VC nesting for intercepted CPUID for SEV-SNP guest

( You can add your SOB to Tom's first patch, to signal that you
  tested it and are forwarding it, and that your fix relies on that fix. )

Thanks,

	Ingo
