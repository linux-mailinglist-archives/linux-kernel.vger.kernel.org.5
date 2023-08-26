Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8201578949D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjHZIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHZIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:01:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F81991
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:01:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so15340825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693036869; x=1693641669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zeI6AUjlRlAi0IA4zOJ4FhSx5m+2z7V0zbKgXgsP9A=;
        b=R57hJHNjTKj/VEVKSt8dYUPyyXeow2ml98lOSYDxkU7RHCFR5yDkFFmWRViV5/GByr
         uDOekwb5fbx+0Gti3DO6w1UJiFJ5nf0b7H+Us29Odze8jV4uXk1OWUA+xhfazzeyRyv6
         Zaix3hDh8kwgFoEfVJtJBFXkG9/YfBvOf15xqjo8d+bjbn3j8+21pnDXBj/2YGyXYgyw
         4z1y3pHgYUTmcPtOi3ETJr3T4XefMDk9UlEXz92H7Htvb2ZYPt3zCifw/KFuuJGuhKX0
         L45CD620XAp0ovJ3thFCrG3p6Hms29c8HJG6hCtuvium7AAbq437AVeyrtCxl18AEnV8
         IFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693036869; x=1693641669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zeI6AUjlRlAi0IA4zOJ4FhSx5m+2z7V0zbKgXgsP9A=;
        b=S8VF4Py4VeCFCzvIoVRhxjfiLCWLjoHuiXldHwmdNA1BhEylQNNEafvcNg+A9/i+x1
         w1k6VDnd37aA8aMHJamAC1FtnbQFgNhcanQugor7Wr+tidfXxkgx+r8BgJ3pCSqHyC0g
         7yTrzOhZLRMkTnBM3xLQ9vgTqUwti8UfBSYeQgTvUZTaQm6GlfESmSwoSIvei2SdEGfn
         5v4dIBYEprsTRYQdclmV9ARlIxpoPCmq9NOQCXOhBMcTehGVgWHfPu5xZkDbe+sbEniM
         UVMp9/98Qlu7AgLPkeCkVHytWDqkNza9M1LPZbpt/gaDocdyNp3MW3drusP7r31fPV0T
         FJOQ==
X-Gm-Message-State: AOJu0YxxMJMi1YI1CgFoghid53Fp46iMemJMT3d/xz0V/8kYzx6SSQr0
        9/QwLOMCDEnYr2K7wKJjLmpn2vqJ+sJiR1UOziImUw==
X-Google-Smtp-Source: AGHT+IFip3zr5PD+wLFjohJxk2E8ZxQQ84TpALHTFZrixS+eOIyqK8L89Dze85NSTr4EcwqXulYF6A==
X-Received: by 2002:a7b:c413:0:b0:3ff:ca80:eda3 with SMTP id k19-20020a7bc413000000b003ffca80eda3mr7191670wmi.10.1693036868537;
        Sat, 26 Aug 2023 01:01:08 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm4253440wmf.16.2023.08.26.01.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 01:01:07 -0700 (PDT)
Date:   Sat, 26 Aug 2023 10:01:06 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230826-3869468d499caf2850681d08@orel>
References: <20230711201831.2695097-1-evan@rivosinc.com>
 <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud>
 <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
 <20230825-374a82446ed3eea02fcb41e6@orel>
 <CALs-HstfA29DDrmVemP6bZe+kON9JDKYR3p132gG_WefA6d7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HstfA29DDrmVemP6bZe+kON9JDKYR3p132gG_WefA6d7eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:51:28PM -0700, Evan Green wrote:
> On Fri, Aug 25, 2023 at 1:16 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> > > On Thu, Aug 24, 2023 at 10:29 AM Conor Dooley <conor@kernel.org> wrote:
> > ...
> > > > Do you want to have this new thing in cpuinfo tell the user "this hart
> > > > has xyz extensions that are supported by a kernel, but maybe not this
> > > > kernel" or to tell the user "this hart has xyz extensions that are
> > > > supported by this kernel"? Your text above says "understood by the
> > > > kernel", but I think that's a poor definition that needs to be improved
> > > > to spell out exactly what you mean. IOW does "understood" mean the
> > > > kernel will parse them into a structure, or does it mean "yes you can
> > > > use this extension on this particular hart".
> > >
> > > I'm imagining /proc/cpuinfo being closer to "the CPU has it and the
> > > kernel at least vaguely understands it, but may not have full support
> > > for it enabled". I'm assuming /proc/cpuinfo is mostly used by 1)
> > > humans wanting to know if they have hardware support for a feature,
> > > and 2) administrators collecting telemetry to manage fleets (ie do I
> > > have any hardware deployed that supports X).
> >
> > Is (2) a special case of (1)? (I want to make sure I understand all the
> > cases.)
> 
> More or less, yes. In bucket two are also folks wondering things like
> "are all these crash reports I'm getting specific to machines with X".
> 
> >
> > > Programmers looking to
> > > see "is the kernel support for this feature ready right now" would
> > > ideally not be parsing /proc/cpuinfo text, as more direct mechanisms
> > > like specific hwprobe bits for "am I fully ready to go" would be
> > > easier to work with. Feel free to yell at me if this overall vision
> > > seems flawed.
> > >
> > > I tried to look to see if there was consensus among the other
> > > architectures. Aarch64 seems to go with "supported and fully enabled",
> > > as their cpu_has_feature() directly tests elf_hwcap, and elements in
> > > arm64_elf_hwcaps[] are Kconfig gated. X86 is complicated, but IIRC is
> > > more along the lines of "hardware has it". They have two macros,
> > > cpu_has() for "raw capability" and cpu_feature_enabled() for "kernel
> > > can do it too", and they use cpu_has() for /proc/cpuinfo flags.
> > >
> >
> > I'd lean more towards the way AArch64 goes, because, unless /proc/cpuinfo
> > is just a blind regurgitation of an isa string from DT / ACPI, then the
> > kernel must at least know something about it. Advertising a feature which
> > is known, but also known not to work, seems odd to me. So my vote is that
> > only features which are present and enabled in the kernel or present and
> > not necessary to be enabled in the kernel in order for userspace or
> > virtual machines to use be advertised in /proc/cpuinfo.
> >
> > We still have SMBIOS (dmidecode) to blindly dump what the hardware
> > supports for cases (1) and (2) above.
> 
> Yeah, there's an argument to be made for that. My worry is it's a
> difficult line to hold. The bar you're really trying to describe (or
> at least what people might take away from it) is "if it's listed here
> then it's fully ready to be used in userspace". But then things get
> squishy when there are additional ways to control the use of the
> feature (prctls() in init to turn it on, usermode policy to turn it
> off, security doodads that disable it, etc). I'm assuming nobody wants
> a version of /proc/cpuinfo that changes depending on which process is
> asking. So then the line would have to be more carefully described as
> "well, the hardware can do it, and the kernel COULD do it under some
> circumstances, but YMMV", which ends up falling somewhat short of the
> original goal. In my mind keeping /proc/cpuinfo as close to "here's
> what the hardware can do" seems like a more defensible position.
> -Evan

I agree with that. I was actually even trying to say the same thing,
but only by bringing up virtual machines. Once we decide we'll expose
extensions to VMs, whether or not the host kernel enables them, then
none of the other host kernel configurations matter with respect to
advertising the feature, since the guest kernel may have a completely
different set of configurations.

So I think we should only be filtering out extensions that are disabled
because they're broken (have a detected erratum), have been "hidden"
(have a kernel command line allowing them to be treated as if not
present), or cannot be used at all due to missing accompanying hardware
descriptions (such as block size info for CBO extensions). In all cases,
I presume we'd wire checks up in riscv_isa_extension_check() and no
checks would be gated on Kconfigs or anything else. And, since
/proc/cpuinfo gets its list from the bitmap that's already filtered by
riscv_isa_extension_check(), then, long story short, we're good to go :-)

But maybe we can try to spell that policy out a bit more in
Documentation/riscv/uabi.rst.

Thanks,
drew
