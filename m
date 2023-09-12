Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17979D655
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbjILQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjILQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:30:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCEE7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:30:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso102564766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694536252; x=1695141052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2auG8foOocIuOhvl2TVEXZ5ad6D4FgqQPWyc6fW1H0=;
        b=FyvVahDnGYHe2EKlCDSUiryfdLU1zUCCvejNOoEg1KjT370xYhb4PX8ITE/Aw7Ysgf
         0BOoaNNPCZTctKkSrvuuyvJpsUu8tfYAlbBdKkqZjeFAy1QRjmQEO4lrMLv9nLebHnE9
         2ZZkTbGBti8Yp+3rKSxwt0Krx7HijEF05IMIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536252; x=1695141052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2auG8foOocIuOhvl2TVEXZ5ad6D4FgqQPWyc6fW1H0=;
        b=DilHuc0JFBdS2rIOxJbgY40sg5mUJ2cSz+PJDkiCC08o0Dw0lwzxeL3yHjeWwjEnY4
         AmfeKemOrYqMEBcIw0h89t2SVO4TakNboN3cgZKwMvqw8MVXC4GWGw0DImR4TNyzDeLx
         WLn0ITq114X1mRTaLXQP+DGOcRHU21AR4ZIj4MI9pIBQMJnkZiHR0ad2OlgiUyR2o9Eb
         /rtaz7iiyR+2eQ34/oLsIE+370KRSoVXOOZKxy+uyoZl3Ztmj53Zh39QJE1U2RUHOmwb
         WfSzWMBelDnNubDhoB1wJ57EnkWtsMG4dl6ZYbIrb6IGltaOiiTsS4DkUH/ejzFYcBbZ
         X/EA==
X-Gm-Message-State: AOJu0YwXotg2+BXHx4VYHVYDncIheIf8ZIvUNYBafr4bV0jHR9i6SS/E
        XsAFm6Lu+1TIsDh81AjsFdRYDIUIV3s9E39BoBXrYVdZ
X-Google-Smtp-Source: AGHT+IEQ9Fp8zdmwC/BVUzj9JtFGLnOSSOTJ4cEfG2SNGH+MFSkW977OizxSu0UduuVkVG4RVwMcSA==
X-Received: by 2002:a17:906:3189:b0:9a5:ceab:f496 with SMTP id 9-20020a170906318900b009a5ceabf496mr11305973ejy.58.1694536252282;
        Tue, 12 Sep 2023 09:30:52 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id hb19-20020a170906b89300b009a1fd22257fsm7015071ejb.207.2023.09.12.09.30.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 09:30:51 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9ad810be221so142824066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:30:50 -0700 (PDT)
X-Received: by 2002:a17:906:214:b0:9a2:86b:bb18 with SMTP id
 20-20020a170906021400b009a2086bbb18mr13138181ejd.26.1694536250111; Tue, 12
 Sep 2023 09:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home> <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
 <20230911182012.7f1f35c1@gandalf.local.home>
In-Reply-To: <20230911182012.7f1f35c1@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 09:30:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq+Nf0O1ddCCaReEsMcMcSbSCG16L5uM=jZfxY-V5+8w@mail.gmail.com>
Message-ID: <CAHk-=wgq+Nf0O1ddCCaReEsMcMcSbSCG16L5uM=jZfxY-V5+8w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 15:20, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Going out on a crazy idea, I wonder if we could get the compiler to help us
> here. As all preempt disabled locations are static, and as for functions,
> they can be called with preemption enabled or disabled. Would it be
> possible for the compiler to mark all locations that need preemption disabled?

Definitely not.

Those preempt-disabled areas aren't static, for one thing. Any time
you take any exception in kernel space, your exception handles is all
dynamically preemtible or not, possibly depending on architecture
details)

Yes, most exception handlers then have magic rules: page faults won't
get past a particular point if they happened while not preemptible,
for example. And interrupts will disable preemption themselves.

But we have a ton of code that runs lots of subtle code in exception
handlers that is very architecture-dependent, whether it is things
like unaligned fixups, or instruction rewriting things for dynamic
calls, or a lot of very grotty code.

Most (all?) of it could probably be made to be non-preemptible, but
it's a lot of code for a lot of architectures, and it's not the
trivial kind.

And that's ignoring all the code that is run in just regular process
context with no exceptions that is sometimes run under spinlocks, and
sometimes not. There's a *lot* of it. Think something as trivial as
memcpy(), but also kmalloc() or any number of stuff that is just
random support code that can be used from atomic (non-preemtible)
context.

So even if we could rely on magic compiler support that doesn't exist
- which we can't - it's not evenb *remotely* as static as you seem to
think it is.

                 Linus
