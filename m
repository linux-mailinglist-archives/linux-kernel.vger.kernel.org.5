Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1026E7B6AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjJCNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJCNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:38:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0882A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:38:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b6559cbd74so171922466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696340285; x=1696945085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZL0fpU7SUxSjUWjOaSM2ClnW0D8Hw5y8svOxugFbj0=;
        b=TIAYM6yYWvmeqWtzTIytYxdDuJwEwB+epnga+92ItE6gc3Z6ReAONVpI1odWUSjd6J
         8aC+haeIkVZJrqAAB35rOT+61qer/3bwpT+WIs2p1cs6UWT24Cs6WZT0yTSyyu8Fyg0s
         tMFW/7p3WnBGvQODSk9pRzcgnwbMLPDl8IwSWib+rsqedGgOwTWbqThu4p1O8mybse/D
         vba/HCLGZOhiMgoxlRXsmyT8N4hAH/8v/drjkcHhV78E2Nbmav7YOO3jdFNN9NPANrtt
         lr5I9McwJr/mSaR+DRchkoT8EFhY2fkxjsMFXBjWIYBNjbQIpgDwltkcwn0QKjVhTRJM
         5wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340285; x=1696945085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZL0fpU7SUxSjUWjOaSM2ClnW0D8Hw5y8svOxugFbj0=;
        b=cTyH9uUdPyadYsXQaOLBetc35rhlukG1LX58oNGdpvi3r95Z/Ft1OdlSH0naOhUxCm
         7IyVpgY1NFZPSbDdVdWe2gKMV4o8ffEdbTtnyXCwVQk2ajjjteWZpMBQ771toUV+Jb8U
         8RULEBD9CHKSrIz3yuui15MFJ9g3VuPfTmiY/ZMioulDqawe2wiWKeQmiLBNjHrn4HAj
         /Chux1++r8w6lnALtzGNg9oXlnwMGY+PMXjWOE/5uOta84nYxKjLAhmzu1a7j62rseK5
         zzK5BAMiE61RiAuc44bLwBJeZ3lmHTjkBjPxmsjXGm1deDSw24wvKNLSHzxVNUk82GR3
         z+jA==
X-Gm-Message-State: AOJu0YyQaRprWi+UTBQrbiDQ3zjaOF54RN5vnQC0WYTp8xntTH8aabpP
        9w1mSBy/OQbbj3H90Bh6vrg=
X-Google-Smtp-Source: AGHT+IGU3Jotr1mMzqKdjDa/z2HYTE1QsbQ8HrXCW2Y8/0BrnsGqC1vqTFr1isrgKGVDYvryl2N5Sg==
X-Received: by 2002:a17:907:75fb:b0:9ae:6d0:84ec with SMTP id jz27-20020a17090775fb00b009ae06d084ecmr12136390ejc.25.1696340284815;
        Tue, 03 Oct 2023 06:38:04 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id kg8-20020a17090776e800b009b293d1f2eesm1087762ejc.107.2023.10.03.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:38:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 15:38:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
Message-ID: <ZRwZOtANkcwtL+5B@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
 <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
 <ZRrECdIoKCXALl39@gmail.com>
 <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > Maybe, but Linus's reluctance and caution is justified IMHO, and at 
> > minimum this feature needs some careful evaluation of long-time 
> > suitability [*] ...
> 
> I do have a proposal on how to introduce a new feature while minimising 
> risk as much as possible. I must admit that detecting the feature for all 
> released compilers that can handle __seg_gs seems quite risky (I have to 
> curb my enthusiasm somehow ;) ), so perhaps a staged approach with a 
> currently unreleased compiler is more appropriate. Using:
> 
> +config CC_HAS_NAMED_AS
> +       def_bool CC_IS_GCC && GCC_VERSION >= 140000
> 
> would enable the new feature only for currently unreleased experimental 
> GCC. This would allow to qualify the compiler and weed out any possible 
> problems, before the compiler is released. Please note, that the patch is 
> written in such a way, that the code reverts to the existing approach for 
> undefined CC_HAS_NAMED_AS.

So I don't think it's a good idea to restrict it to the devel GCC version 
only, the cross-section of devel-GCC and devel-kernel reduces testing 
coverage to near-zero in practice ...

Instead, if Linus doesn't disagree that is, how about restricting it to the 
freshest GCC minor version? Ie. GCC 13.1 and later. We could carry it in a 
separate branch in -tip for a while and not merge it into v6.7 but v6.8 or 
so.

That would at least give us *some* amount of test coverage, without any 
real upstream risk.

Thanks,

	Ingo
