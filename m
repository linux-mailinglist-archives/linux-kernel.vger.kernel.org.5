Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BF778D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjHKLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjHKLKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:10:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC6E77
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:10:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so16050855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691752248; x=1692357048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H0MQJH4+pITYkHBLtS+BCOJ0qhFoL1psieZswN4tkhU=;
        b=JoodpZ+jub5G5ZkW/LLA0aZ04zeEZUuOXIVCoqwSG9rKD0dob9tE4ZLTbVBjLRdrwy
         2HejF139lcZzPXQc3D4Z+zZmQ5KlIAKA9k0GlWe/qc4mTbknw9NVHEdhYTrsZff/bNh9
         DSR31yAQtoH7XjDr8qskzPU4gn+gZoKdJaml+84f0bOl7vthmkMwMfRV6sFZu1U5belg
         G0oQ+PSRdw9Ze/YUMJQzS6mN/jL1+4RqYAlRR39jK2UNcHxh6fzpktNfJ1ky4wSqKm+A
         r08yV3XlZ2ftzWY5S9W3q8hwHKsWmT0rcOJRc4WOovsYjwE/63ewyK4S1CxxpT5qkqAS
         pH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691752248; x=1692357048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0MQJH4+pITYkHBLtS+BCOJ0qhFoL1psieZswN4tkhU=;
        b=KMwasBf3yjUXt+DwHo6o9sfbL8nSkYZ2oweO3MC0v+xMdZXIfrYoLrNnVUuj2A0q0c
         wem387x/YCelX/q+Qzcex9ki01hPllBya9MHeXz2Sv5Pltr9XeULYWuMLRDJNl3fhgpF
         M6xZNGkIodvQtHPl+nYO4uylOmKdIv7d4+E9YVfNstHjJp3ZdEHDJaEW5bTL0P0tNYIQ
         tCnSiTnwUMEuQyAKJXZPkK88wodwGV8GTLH+n3/Gxjc9OO3PO1snafAwL/WcbIdQKqr2
         6/FKOfr+Z3FOKKRETaBwVGXkO2xbtqeX4AQlrHEsDdONIhp3CfhCAOnbksl19ol+cttO
         EiDQ==
X-Gm-Message-State: AOJu0YyD4edYTVJoXmEuxzRByWE6q+tuSTSy/Ya4tBOPCX5sbatYHV2C
        zrI6ReGAK+psD9O3N4ZWIFC6hxsguorouVjo/qeMs7nh
X-Google-Smtp-Source: AGHT+IFbQjtZWxIg18iTlDgX3Z2owGZPVaikc674RSqcYVvMq2CXbMCbvCe+psPnv6sY+apM2fcoeg==
X-Received: by 2002:a05:600c:3797:b0:3f7:678c:74b0 with SMTP id o23-20020a05600c379700b003f7678c74b0mr1229864wmr.12.1691752247252;
        Fri, 11 Aug 2023 04:10:47 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c22da00b003fbb618f7adsm4860871wmg.15.2023.08.11.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:10:46 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:10:45 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, leobras@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
Message-ID: <20230811-bd73721199b8699c9d7da564@orel>
References: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com>
 <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
 <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:40:30AM +0800, Guo Ren wrote:
> On Fri, Aug 11, 2023 at 12:23 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > >> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > >> > xchg for variables of size 1-byte and 2-bytes is not yet available for
> > >> > riscv, even though its present in other architectures such as arm64 and
> > >> > x86. This could lead to not being able to implement some locking mechanisms
> > >> > or requiring some rework to make it work properly.
> > >> >
> > >> > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
> > >> > architectures.
> > >> >
> > >> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > >>
> > >
> > > Hello Arnd Bergmann, thanks for reviewing!
> > >
> > >> Parity with other architectures by itself is not a reason to do this,
> > >> in particular the other architectures you listed have the instructions
> > >> in hardware while riscv does not.
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
> Conor doesn't agree with using an alternative as a detour mechanism
> between qspinlock & ticket lock. So I'm preparing V11 with static_key
> (jump_label) style. Next version, I would separate paravirt_qspinlock
> & CNA_qspinlock from V10. That would make it easy to review the
> qspinlock patch series. You can review the next version V11. Now I'm
> debugging a static_key init problem when load_modules, which is
> triggered by our combo_qspinlock.

We've seen problems with static keys and module loading in the past. You
may want to take a look at commit eb6354e11630 ("riscv: Ensure isa-ext
static keys are writable")

Thanks,
drew

> 
> The qspinlock is being tested on the riscv platform [1] with 128 cores
> with 8 NUMA nodes, next, I would update the comparison results of
> qspinlock & ticket lock.
> 
> [1]: https://www.sophon.ai/
> 
> >
> > So if something uses these I'm happy to go look closer.
> >
> > >> Emulating the small xchg() through cmpxchg() is particularly tricky
> > >> since it's easy to run into a case where this does not guarantee
> > >> forward progress.
> > >>
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
> > >>  This is also something that almost no architecture
> > >> specific code relies on (generic qspinlock being a notable exception).
> > >>
> > >
> > > 2 - As you mentioned, there should be very little code that will actually make
> > > use of xchg for vars < 4B, so it should be safe to assume its fine to not
> > > guarantee forward progress for those rare usages (like some of above mentioned
> > > archs).
> > >
> > >> I would recommend just dropping this patch from the series, at least
> > >> until there is a need for it.
> > >
> > > While I agree this is a valid point, I believe its more interesting to have it
> > > implemented if any future mechanism wants to make use of this.
> > >
> > >
> > > Thanks!
> > > Leo
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
