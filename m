Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B178BA69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjH1Vjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjH1Vje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:39:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6B106
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:39:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0db66af1bso17923015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693258770; x=1693863570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHdUO+lDNPOvPW+3NlnVX1ng1CqewzDf9giLaK2K5LM=;
        b=Wb6H3zIuPpR8Lq5VDhwqijTbRB6Kf5ZByIt9Toiaz/d8/hbHOohkKJegF/hH5dPnUI
         KNwN94Ns94WWmg08zSo5bQiQZM4H0zYxd2Y0oQn5jIIrZIq7mBIRm2cK+1gToDLQO2Ls
         ZTFlbQFLQdfWaaWrsv6rgVOj1n3O9lg2XqWn5wGhJmn4mpPHnx7SkMF/uZtIfhkpNfrE
         WukdoHUIfKg0aGt2KAfmB4wwR8CNtQVoOIFW+HeISbem1cyyFwX2FqIuaHNjJBgu4aE0
         GwDr7kn1H+7fmGOsLDDHC1NQnzhbcIj7GZ5fz9MWjRkOOxqXriOFc1rW/j2hN56ISmHD
         znTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258770; x=1693863570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHdUO+lDNPOvPW+3NlnVX1ng1CqewzDf9giLaK2K5LM=;
        b=I0SQEeI/HBJxms5w7e6KFpl8PFvGhnkkaD7K9LeL9CBi/CoDn4KpL/8Gb0pU94bGcn
         mMXjE8o1V2auc6RJJ0idpPU5EKEIFtGnta9O0RD3t35BRrxNDg70IjQgid9zupfdbxWK
         GCXRv/AxEV4AAAbUdXKA4UeT/m0VmITZjkpHlFLHb5mnm6L0Mg/4LeIZF5kt4a8EFYKy
         N1crjlzJb8opkLL3KtBx6EwkZ/OUOBox7bFUkXTCH/vf6P7XBbGbrnQXRlp6H61EwdUl
         HXBRnI1qy6EmH32ghTRmaZKgpuHQoUlzqg9ZkdW0adK3aNxhpp7rUoEWX3INvDrP+gxe
         wIGg==
X-Gm-Message-State: AOJu0Yy7ZQssW98A21JzoFw6V65hNAc+xGbWqr3+/mp1SjPTsVR47wh9
        9oPgX/hArX7aUOXX5CIUVVj0RQ==
X-Google-Smtp-Source: AGHT+IFVLmk6Rdlv8hXXucmdwmu2DNBKVOmjpfe7MLkr+PNUxQE2kQu2zLgbt0LhtVq9J3QJDMGthA==
X-Received: by 2002:a17:903:428c:b0:1c0:d8bc:dcf1 with SMTP id ju12-20020a170903428c00b001c0d8bcdcf1mr7500990plb.23.1693258770324;
        Mon, 28 Aug 2023 14:39:30 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001bc445e249asm8045428pln.124.2023.08.28.14.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:39:29 -0700 (PDT)
Date:   Mon, 28 Aug 2023 14:39:27 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
Subject: Re: [PATCH 1/5] riscv: Checksum header
Message-ID: <ZO0UD1+pmkjMDjvv@ghost>
References: <20230827-turf-parched-b965bc697882@spud>
 <mhng-d43dc0a3-7985-4195-9611-5ca0c38390e7@palmer-ri-x1c9>
 <20230827-primer-conceal-b6f24b29e692@spud>
 <20230827-divisive-happy-cf93058c49bf@spud>
 <ZOzRlerSNjfzMYGH@ghost>
 <20230828-deserve-paging-25666290e312@spud>
 <ZOzld28wZjLpl4Hp@ghost>
 <20230828-stonewall-eloquence-8940f33bd2f0@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-stonewall-eloquence-8940f33bd2f0@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:56:13PM +0100, Conor Dooley wrote:
> On Mon, Aug 28, 2023 at 11:20:39AM -0700, Charlie Jenkins wrote:
> > On Mon, Aug 28, 2023 at 06:08:40PM +0100, Conor Dooley wrote:
> > > On Mon, Aug 28, 2023 at 09:55:49AM -0700, Charlie Jenkins wrote:
> > > > On Sun, Aug 27, 2023 at 01:25:27PM +0100, Conor Dooley wrote:
> > > > > On Sun, Aug 27, 2023 at 11:28:33AM +0100, Conor Dooley wrote:
> > > > > > On Sat, Aug 26, 2023 at 07:00:47PM -0700, Palmer Dabbelt wrote:
> > > > > > > On Sat, 26 Aug 2023 18:42:41 PDT (-0700), Conor Dooley wrote:
> > > > > > > > On Sat, Aug 26, 2023 at 06:26:06PM -0700, Charlie Jenkins wrote:
> > > > > > > > > Provide checksum algorithms that have been designed to leverage riscv
> > > > > > > > > instructions such as rotate. In 64-bit, can take advantage of the larger
> > > > > > > > > register to avoid some overflow checking.
> > > > > > > > > 
> > > > > > > > > Add configuration for Zba extension and add march for Zba and Zbb.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > > > ---
> > > > > > > > >  arch/riscv/Kconfig                | 23 +++++++++++
> > > > > > > > >  arch/riscv/Makefile               |  2 +
> > > > > > > > >  arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  3 files changed, 111 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > > > index 4c07b9189c86..8d7e475ca28d 100644
> > > > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > > > @@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> > > > > > > > >  	  If you don't know what to do here, say Y.
> > > > > > > > > +config TOOLCHAIN_HAS_ZBA
> > > > > > > > > +	bool
> > > > > > > > > +	default y
> > > > > > > > > +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
> > > > > > > > > +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> > > > > > > > > +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> > > > > > > > > +	depends on AS_HAS_OPTION_ARCH
> > > > > > > > > +
> > > > > > > > > +config RISCV_ISA_ZBA
> > > > > > > > > +	bool "Zba extension support for bit manipulation instructions"
> > > > > > > > > +	depends on TOOLCHAIN_HAS_ZBA
> > > > > > > > > +	depends on MMU
> > > > > > > > > +	depends on RISCV_ALTERNATIVE
> > > > > > > > > +	default y
> > > > > > > > > +	help
> > > > > > > > > +	   Adds support to dynamically detect the presence of the ZBA
> > > > > > > > > +	   extension (basic bit manipulation) and enable its usage.
> > > > > > > > > +
> > > > > > > > > +	   The Zba extension provides instructions to accelerate a number
> > > > > > > > > +	   of bit-specific address creation operations.
> > > > > > > > > +
> > > > > > > > > +	   If you don't know what to do here, say Y.
> > > > > > > > > +
> > > > > > > > >  config TOOLCHAIN_HAS_ZBB
> > > > > > > > >  	bool
> > > > > > > > >  	default y
> > > > > > > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > > > > > > index 6ec6d52a4180..51fa3f67fc9a 100644
> > > > > > > > > --- a/arch/riscv/Makefile
> > > > > > > > > +++ b/arch/riscv/Makefile
> > > > > > > > > @@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
> > > > > > > > >  riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
> > > > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> > > > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
> > > > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
> > > > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
> > > > > > > > 
> > > > > > > > AFAICT, this is going to break immediately on any system that enables
> > > > > > > > RISCV_ISA_ZBA (which will happen by default) but does not support the
> > > > > > > > extension. You made the option depend on RISCV_ALTERNATIVE, but I do
> > > > > > > > not see any use of alternatives in the code to actually perform the
> > > > > > > > dynamic detection of Zba.
> > > > > > > 
> > > > > > > I guess we kind of have an ambiguity here: for stuff like C we just
> > > > > > > unconditionally use the instructions, but for the rest we probe first.  We
> > > > > > > should probably have three states for each extension: disabled, dynamically
> > > > > > > detected, and assumed.
> > > > > > 
> > > > > > You mean, just add some comments to the makefile surrounding each
> > > > > > section or to some rst documentation?
> > > > > 
> > > > > Also, the code here doesn't build w/
> > > > > 	warning: invalid argument to '-march': '_zba_zbb_zicsr_zifencei_zihintpause'
> > > > > so there's something else wrong with TOOLCHAIN_HAS_ZBA :)
> > > > It is odd that this is missing 'rv64ima' or 'rv32ima' at the beginning of
> > > > this string. What configuration are you using that could cause that to
> > > > be left off?
> > > 
> > > I don't know, but that configuration is pretty pervasive. The patchwork
> > > CI blew up too & that is using kernel.org toolchains built by Arnd:
> > > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > > 
> > > > Compiling with defconfig automatically enables Zba and appears to not
> > > > cause this issue. I realized that I put the header definitions for
> > > > do_csum and csum_ipv6_magic in this patch instead of the next one so the
> > > > code will fail to compile from this but not due to march settings.
> > > > > 
> > > > > > 
> > > > > > > > Note that for fd & v, we add it to riscv-march-y, but then immediately
> > > > > > > > remove it again before passing to the compiler, only allow them in
> > > > > > > > AFLAGS:
> > > > > > > > 	# Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
> > > > > > > > 	# matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
> > > > > > > > 	KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> > > > > > > > 
> > > > > > > > What am I missing?
> > > > > > > 
> > > > > > > FD and V both have state that can be saved lazily, so we can't let arbitrary
> > > > > > > code use them.  The extensions formally known as B don't add state, so they
> > > > > > > are safe to flip on in arbitrary places (aside from the issues you pointed
> > > > > > > out above).
> > > > > > 
> > > > > > I probably went about this badly since you missed the point. I was
> > > > > > trying to point out that for anything other than the compressed
> > > > > > extensions in the block above that we only pass them in march to the
> > > > > > assembler, and not to the compiler, in contrast to this patch which just
> > > > > > always passes them. I should have pointed to how we handled the
> > > > > > in-kernel Zbb stuff & asked how this was any different, would probably
> > > > > > have been clearer.
> > > > > > 
> > > > I supposed it might be better if I submit these changes in a different
> > > > patch so we can have more discussion there. Zbb was previously only used
> > > > by assembly files (arch/riscv/lib/strcmp.S, arch/riscv/lib/strlen.S,
> > > > arch/riscv/lib/strncmp.S). I wanted to add them to the compiler so that
> > > > that C programs could leverage these extensions. However, I neglected to
> > > > consider machines that compile the kernel with these extensions but have
> > > > cores without these extensions.
> > > 
> > > Less so cores, since we don't support heterogeneous stuff, and moreso
> > > platforms that do not support the extensions. It's expected that the
> > > same kernel could in theory be used across a wide variety of systems.
> > > 
> > > > The purpose of using these extensions is
> > > > to save a couple of clock cycles, so if it is necessary to first
> > > > check if the extension is enabled it may not be worth it for these
> > > > functions.
> > > 
> > > That's still possible, it's what the alternatives mechanism exists for.
> > > During boot the codepaths are patched to use what works for a given
> > > machine, check out the code that makes use of Zbb or
> > > riscv_has_extension_[un]likely(). You'd need to do something like the
> > > existing users of Zbb instructions does, with an alternative used to
> > > avoid the custom asm implementations when the hardware does not support
> > > them. (That's what the CONFIG_ALTERNATIVE & CONFIG_AS_HAS_OPTION_ARCH
> > > options you made the TOOLCHAIN_HAS_ZBA depend on are for).
> > 
> > I can see how to get this to work if I port this code into assembly and
> > write two different versions (one with Zbb and one without), but
> > I don't see how this would work in C. Unless I am mistaken, there would
> > need to be some sort of wrapper around the C code that told the compiler
> > to compile it multiple times for different extension combinations and
> > then use the riscv_has_extension_[un]likely() functions to determine
> > which version to use at runtime. Is this feasible?
> 
> IIRC, if you put all the code using Zbb etc into a compilation unit of
> its own then you can set march for that unit alone, but it may well just
> be easier to write a custom asm one for the Zbb case & use the c
> implementation from this patch for the non-Zbb case.
In include/linux/bitops.h there are implementations of rotations (i.e.
ror32, ror16). Do you think it would be an acceptable solution to move
those definitions into asm-generic and have riscv implement these
functions in assembly with Zbb and non-Zbb versions and use the
alternatives macro? Every other architecture would just use the
existing definitions but could implement their own if they wanted. The
code that would benefit from Zbb is a rotation.
