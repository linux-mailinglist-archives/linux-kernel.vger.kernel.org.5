Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15A58074C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbjLFQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:19:03 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E8112F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:19:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b8b0b75445so3488827b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701879545; x=1702484345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+keYVVg9QUAM5emaaLbfpon4BhbEQnmzZtHaeEa1QSk=;
        b=XVSdPCvUMtEMoGqXMAxJFizzKR7lrwGDwjLC4n+oLPmYM+c+heVgMnhOwvOARCGtZ3
         lJFDUFXzklmUDUryWWF/0YciCxVLAMBEFq1d7Y75OWdp8f2kcW5DcqRDdg6ogZTTV5f1
         Tq02nPK0K3e+7r+4zdsfhU8bz/LDmbl/uR1ZrEsRMdr9bp0W6b8t6B0yRswmkP6trSmo
         /edmWr3wQECghggkC/bkt+oxy+hu1CxMf43yeWErtM64AFXa+Ubq1JsUl8spgO4w3+7i
         vhKkHj0ROqk+4ny2BKU83wF99LsOFQac7oIBmsTF3OxS0i4V+2ftL4Vu/eM7MZAHo/9R
         8l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879545; x=1702484345;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+keYVVg9QUAM5emaaLbfpon4BhbEQnmzZtHaeEa1QSk=;
        b=U0izJiUHHRD+0bMbIa0Bdh9ZOing7YzDSTC8iLQ/rCT49X44v0+8vyPaJJOuvn7TYC
         3aNONKWGoOKB5O0i35j/tYvXaRsazYg81+rFFtobkhhcefGznIN1+hv4qZ7cEWlzWxS4
         FojqG4K9mvR+DQGO6KLR88qtPf9FYTz7Isfol7++b5wR9ye82RXjwhPBOLETbU+zs8DU
         y5kVQQKdLNAzaeV55vSiUXARDhlCF3KDAr1yHMOXPS9cidwOYH039p/w3Szr3mkGRdtx
         aMaysVo1q3ic9tbQe0LW3/QYPokglrltZPDgXmvqylctbUzndt2OWnkKX2/iPgs0e+y0
         sgbg==
X-Gm-Message-State: AOJu0Yz19snNaRK8EdA7n+tAMMKYJrT3r3deDcwalOQCIFa03tWRfcEG
        YEP/v9C0B65bKNeXYtvQOdsCHg==
X-Google-Smtp-Source: AGHT+IHQdBGicDEd76OIg7GieuoxgilhJd8ujkiO+3l7mCoCs4BDXkJlBUImDbzqYtL+75g/5MIINQ==
X-Received: by 2002:a05:6808:164e:b0:3b8:b063:a1dd with SMTP id az14-20020a056808164e00b003b8b063a1ddmr1652811oib.103.1701879545455;
        Wed, 06 Dec 2023 08:19:05 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id z10-20020a056808064a00b003b2daf09267sm41295oih.48.2023.12.06.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:19:04 -0800 (PST)
Date:   Wed, 06 Dec 2023 08:19:04 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 08:19:01 PST (-0800)
Subject:     Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <CAGu26P9KiZQhTGO1TrRzGV86GjivmC7_HQaE5p_kNemx+euaEQ@mail.gmail.com>
CC:     charlie@rivosinc.com, jszhang@kernel.org, ebiggers@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     lohr85@gmail.com
Message-ID: <mhng-bdcdb066-aef0-4fc8-818e-7a63d2a5ad92@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 16:05:27 PST (-0800), lohr85@gmail.com wrote:
> The automatic detection code has become a bit of a thorn both for
> folks like me who use the kernel for some fast-spin up aodr
> virtualization (where check_unaligned_access soaks up 1/4 to 1/3 of
> the total boot time and unaligned accesses are always fast) as well as
> causing issues for the FPGA soft core development where they easily
> know ahead of time what the situation is going to be.  It would be
> extremely welcome if the access could always be overridden with a
> config value that could either force on or force off unaligned access
> and avoid execution of the check function permanently.  I don't see a
> world where for some of us, we would ever want autodetection on.  In
> the RISC-V arena, many times we're dealing with very small systems
> where the marginal cost of dead code is rather high.

That seems generally reasonable to me.

We'd talked about putting misaligned access performance informaiton in 
the DT at some point, but we went with the probing instead.  So I think 
our options are a Kconfig or a kernel command line argument, both seem 
generally useful to me so I'd be fine with either (or both).

So I think someone should send a patch... ;)

Also: I think it's not really a blocker for this patch set, as the 
probing behavior is there already.  IIUC it's really the probing that's 
the problem here due to the boot time performance impact, so even if we 
did nothing with the probed information it'd still be causing your 
issues.

> On Tue, Dec 5, 2023 at 12:57 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
>>
>> On Tue, Dec 05, 2023 at 09:53:50PM +0800, Jisheng Zhang wrote:
>> > On Mon, Dec 04, 2023 at 06:14:06PM -0800, Eric Biggers wrote:
>> > > On Mon, Dec 04, 2023 at 11:15:28AM -0800, Charlie Jenkins wrote:
>> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > > > index 7f8aa25457ba..0a76209e9b02 100644
>> > > > > --- a/arch/riscv/Kconfig
>> > > > > +++ b/arch/riscv/Kconfig
>> > > > > @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
>> > > > >           load/store for both kernel and userspace. When disable, misaligned
>> > > > >           accesses will generate SIGBUS in userspace and panic in kernel.
>> > > > >
>> > > > > +config RISCV_EFFICIENT_UNALIGNED_ACCESS
>> > > >
>> > > > There already exists hwprobe for this purpose. If kernel code wants to
>> > > > leverage the efficient unaligned accesses of hardware, it can use static
>> > > > keys. I have a patch that will set this static key if the hardware was
>> > > > detected to have fast unaligned accesses:
>> > > >
>> > > > https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com/
>> > >
>> > > Is the plan to make the get_unaligned* and put_unaligned* macros expand to code
>> > > for both cases, and select between them using a static key?  Note that there are
>> > > a very large number of callers of these macros in the kernel.  And what about
>> > > kernel code that checks CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS directly?
>> > >
>> > > AFAIK, no other Linux architecture supports kernel images where the unaligned
>> > > access support is unknown at compile time.  It's not clear to me that such an
>> > > approach is feasible.  A static key can easily be provided, but it's unclear
>> > > what code would use it, given that currently lots of kernel code assumes that
>> > > unaligned access support is known at compile time.

I agree we won't be able to get everything, but there's some focused 
routines like memcpy() where having runtime-variant behavior can make 
things measurably faster.  I'd guess there's some of this in crypto land 
as well.  We'd have to really look into the benefits, though: not only 
do we end up with a bunch of complexity, but also using ALTERNATIVE() 
tends to cause lower quality codegen because of all the inline assembly 
trickery.

All of that is really based on replacing a whole function at runtime, 
though.  I don't think we're going to be able to do anything dynamic for 
the more general case of misaligned access support, though -- that's 
really in the relm of fine-grained compiler code generation, and trying 
to do that at runtime with the alternative-type approach is just going 
to lead to a bunch of poor quality codegen and patched-in NOPs.  We'd 
essentially be trying to build a full JIT inside the kernel at that 
point.

It essentially the same problem as things like CMOV and bitmanip.

>> > > Meanwhile, there are people building kernels they know will only be deployed on
>> > > systems where unaligned accesses are supported.  To me, it seems useful to
>> > > provide a kconfig option for them to build a more efficient kernel.

I agree.  We've got a bit of a mess in Kconfig land where we don't 
differentiate between "build a kernel that tries to probe for $FEATURE" 
and "build a kernel that requires HW that supports $FEATURE".  We need 
to clean that up at some point, but there's enough of them I'm OK taking 
one more.

>> > Generally, I agree with Eric's above points. Various subsystem such as net, mm,
>> > lib and so on have different code path for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
>> > while Charlie's patch only touch partial code of arch/riscv, and even if those
>> > subsystem maintainers agree with dynamic code patching(I still believe
>> > persuading those subsystem maintainers is not easy), that's still a
>> > huge task which needs to be done step by step. So before that, we'd
>> > better let this series merged and benefit all efficient unaligned access
>> > riscv systems. When the huge task is completed, we can remove the config
>> > option.
>> >
>> > Thanks
>>
>> It would be best to enable all of the paths that leverage
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS at runtime (using hwprobe)
>> instead of using a compile-time flag to do so. However, as you say, that
>> is large task and doesn't need to be done immediately. For now I agree
>> it is sufficient to use this new RISCV_EFFICIENT_UNALIGNED_ACCESS
>> config.

We've got a lot more JIT-ish stuff in the RISC-V port than other ports 
do, it's kind of ugly but that's just the nature of the ISA.
It's kind of the same spot we're in with things like CMOV or the 
bitmanip extensions: there'll be some specific routines where the 
feature makes a big difference and we can provide an alternative (string 
and crypto stuff, for example), but trying to do it everywhere is just 
going to lead to chaos (and probably worse performance).

So I don't know exactly where the line is, but we're always going to 
have some amount of compile-time performance tuning -- at least until we 
just replace the whole kernel with BPF ;)

>>
>> - Charlie
>>
>> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
