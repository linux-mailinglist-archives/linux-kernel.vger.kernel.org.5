Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C858063BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjLFA5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjLFA47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:56:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F53C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:57:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c239897895so2891167a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 16:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701824224; x=1702429024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWAAiSe8+A1VbsHX4/sTLd9FUASXF/9Ffo3lwz2GCx8=;
        b=buG2EXYHU5EdIAIxTic1R28zEFOINrhrgWvhi4kcfw+8aqORzssJjNqY779OyQaVCK
         nqivdADlKhnlmIo2kKl+LVTcHyPZX2inr1+ZhKcuTR7P7QytWxt3Bqx283SW/R/nJkut
         2784wxCnYf+yaHRthMvnFRtzgLwwbAVAjNF9QzT5VkmzdEkAfQaOjLzjh79vSqDbxAOy
         vftPIjMNM+Zh91iaLMVSox/ttzQnOKrYz/Vgjgxribq3f7bpYNFuGfQpS7E2MQoG8Eyz
         //DpOAXpnjrBffFpaZxHjjOVBSZ1+mfZaStg1rmi6gv8QkBOKmp4VfjG3FP9LoHEtLAK
         F7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701824224; x=1702429024;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWAAiSe8+A1VbsHX4/sTLd9FUASXF/9Ffo3lwz2GCx8=;
        b=q6+rwCSjZWp26ztjqsBVIEyMPOPQDQerYcgOI5utJb4ME4H+ZKw2uZ7uVKnA3HcY2P
         0crhrsR2aerp0AIQDfSQITxLLInLDn1VhYM2OLNZpISO2Ldl9FhkZKHhrWXHtJcD7UVw
         9d9WcDMmQdrVvjcRUAPc/EXf4hVUd4SLTH8zIyq6vmlqQBvcMVOnnHmHAK3p2Cz2ByKZ
         lE/EovVEi5PacoQ5UBtJBpXWJXtXageYizZjxUSs5pudgkebNktfu4N63jYuUD4JoPXd
         iplo+wNo++/SeWYTsVfpr2IeV9kZdvf57aSK+7N2m+kLkIijNvmxL3KthlzfdlzSj7sc
         eR/A==
X-Gm-Message-State: AOJu0Yw7SuYbQHcMHjipPaaJ4F2ljmHzWIK2gqJieUmCg2x+MLV8tFwM
        eWB/RgTt6hVcFgU1y1MLxws=
X-Google-Smtp-Source: AGHT+IGZHifqxyac6FpyylqwcZVy2fMmFBFiU9TY4T5h0BVUiNqz8GDECwupcB5WjfentWWxxLxorw==
X-Received: by 2002:a05:6a20:442a:b0:18b:37b4:cb6b with SMTP id ce42-20020a056a20442a00b0018b37b4cb6bmr43187pzb.27.1701824223851;
        Tue, 05 Dec 2023 16:57:03 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a801:efb7:8c5b:a158:7e49:e10])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902b78300b001d06b63bb98sm7291478pls.71.2023.12.05.16.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 16:57:03 -0800 (PST)
From:   leobras.c@gmail.com
X-Google-Original-From: leobras@redhat.com
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date:   Tue,  5 Dec 2023 21:56:44 -0300
Message-ID: <ZW_GzKUoqO4fD4Je@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9> <2a4f1f47e945772b9fbb53a51e148636e0ae6e48.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonardo Bras <leobras@redhat.com>

On Wed, Aug 30, 2023 at 06:59:46PM -0300, Leonardo Brás wrote:
> On Thu, 2023-08-10 at 09:23 -0700, Palmer Dabbelt wrote:
> > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > > xchg for variables of size 1-byte and 2-bytes is not yet available for
> > > > > riscv, even though its present in other architectures such as arm64 and
> > > > > x86. This could lead to not being able to implement some locking mechanisms
> > > > > or requiring some rework to make it work properly.
> > > > > 
> > > > > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
> > > > > architectures.
> > > > > 
> > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > 
> > > 
> > > Hello Arnd Bergmann, thanks for reviewing!
> > > 
> > > > Parity with other architectures by itself is not a reason to do this,
> > > > in particular the other architectures you listed have the instructions
> > > > in hardware while riscv does not.
> > > 
> > > Sure, I understand RISC-V don't have native support for xchg on variables of
> > > size < 4B. My argument is that it's nice to have even an emulated version for
> > > this in case any future mechanism wants to use it.
> > > 
> > > Not having it may mean we won't be able to enable given mechanism in RISC-V. 
> > 
> > IIUC the ask is to have a user within the kernel for these functions.  
> > That's the general thing to do, and last time this came up there was no 
> > in-kernel use of it -- the qspinlock stuff would, but we haven't enabled 
> > it yet because we're worried about the performance/fairness stuff that 
> > other ports have seen and nobody's got concrete benchmarks yet (though 
> > there's another patch set out that I haven't had time to look through, 
> > so that may have changed).
> > 
> > So if something uses these I'm happy to go look closer.
> 
> IIUC patches 4 & 5 will be used by qspinlock, which may not be done yet, so we
> don't have an use for them for the time being.
> 
> Otherwise, any comments on patches 1, 2 & 3?

ping

> 
> > 
> > > > Emulating the small xchg() through cmpxchg() is particularly tricky
> > > > since it's easy to run into a case where this does not guarantee
> > > > forward progress.
> > > > 
> > > 
> > > Didn't get this part:
> > > By "emulating small xchg() through cmpxchg()", did you mean like emulating an
> > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > 
> > > If so, yeah, it's a fair point: in some extreme case we could have multiple
> > > threads accessing given cacheline and have sc always failing. On the other hand,
> > > there are 2 arguments on that:
> > > 
> > > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomics)
> > > also seem to rely in this mechanism for every xchg size. Another archs like csky
> > > and loongarch use asm that look like mine to handle size < 4B xchg. 
> > >     
> > > 
> > > >  This is also something that almost no architecture
> > > > specific code relies on (generic qspinlock being a notable exception).
> > > > 
> > > 
> > > 2 - As you mentioned, there should be very little code that will actually make
> > > use of xchg for vars < 4B, so it should be safe to assume its fine to not
> > > guarantee forward progress for those rare usages (like some of above mentioned
> > > archs).
> > > 
> > > > I would recommend just dropping this patch from the series, at least
> > > > until there is a need for it.
> > > 
> > > While I agree this is a valid point, I believe its more interesting to have it
> > > implemented if any future mechanism wants to make use of this. 
> > > 
> > > 
> > > Thanks!
> > > Leo
> > 
> 
