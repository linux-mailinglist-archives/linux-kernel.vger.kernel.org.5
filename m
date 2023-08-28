Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF678B730
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjH1SU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjH1SUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:20:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925541A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:20:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso2462091b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693246843; x=1693851643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FN5cReRcE/IqZFfedM5lG8adhDURm6Zmxuc1ut1q7kk=;
        b=WeAqtd1ntNS0YgTuYZvuwkU6ZM/B/cG/JTeGYaHbuwa0edGOkauQbjP9QUfPvy4HfV
         V/dqiEUmTwtNGzDHpMLZfIfMKUuvWcBXOpPYUQXJScPwiKH5J2vjubVyl429W6rsHOlg
         7grzBQjC/I1RSDdlZ8OR3H9Wfiuwp58UNWUe1N7PghhbLznb8OY8i3kA7um87TT5WD65
         nSmShNf71KD8ueXVatdu9MqAK5eny/zPGYWLSsOzFt7YNsZ3NizZdDLnoWwkmwJiGX4u
         bt281fUeocyL5evTiyh3ngIgkF02EH7ttH9l6H5s3i901Y7wEy2KrcN0Sz4biRp/5N05
         EhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693246843; x=1693851643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN5cReRcE/IqZFfedM5lG8adhDURm6Zmxuc1ut1q7kk=;
        b=I2btH7DA38X2XyJKwc1qGRWM5zUOmHszKdaE0qGXZHeMKN3CXNAGuu9aLS7KT8shNk
         8Y70PeOYRce7mT0n2aNwhOoCN2boRGktGZBF/k45TTWcOe1VfaW9MfLt4k7g04JTdd67
         kodNsDdTatF4VXVIuTHWFJlqry13Iz7o4G4seuUB2ClDvx+DEfSzeMb8ZKLEKuS2CyDV
         StEu7WUM/WyQVNVATH2lE8tDj4WgtwyqIpXBLFyhXfhDkP2St3t4McFL2Mr3ygvAoB98
         P/jMhh/1f8ReT5YJv9entVy4ZetgNFgrGvLv0Slrs3Hv38RFEvGa6cZYIlDZq+FgS1nW
         u7Gw==
X-Gm-Message-State: AOJu0Yz7qU8EAzO8o+HY7zafJ7SU4u7Z+6Mn7pjw1urOTRS8xSG21gPd
        HyC3/KDyV4fZ51ebK/u5So51Dw==
X-Google-Smtp-Source: AGHT+IEBimujj4zlefxpuPomvv7iKDMVCw90Uhnkx9mm6W0jEamQc5Z5CAG92cyNacoMQoOSbNKXGw==
X-Received: by 2002:a05:6a00:1a4e:b0:68a:553a:c0da with SMTP id h14-20020a056a001a4e00b0068a553ac0damr20938442pfv.24.1693246842918;
        Mon, 28 Aug 2023 11:20:42 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1499:9915:c376:361b])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79117000000b00686ec858fb0sm6887959pfh.190.2023.08.28.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:20:42 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:20:39 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
Subject: Re: [PATCH 1/5] riscv: Checksum header
Message-ID: <ZOzld28wZjLpl4Hp@ghost>
References: <20230827-turf-parched-b965bc697882@spud>
 <mhng-d43dc0a3-7985-4195-9611-5ca0c38390e7@palmer-ri-x1c9>
 <20230827-primer-conceal-b6f24b29e692@spud>
 <20230827-divisive-happy-cf93058c49bf@spud>
 <ZOzRlerSNjfzMYGH@ghost>
 <20230828-deserve-paging-25666290e312@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-deserve-paging-25666290e312@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:08:40PM +0100, Conor Dooley wrote:
> On Mon, Aug 28, 2023 at 09:55:49AM -0700, Charlie Jenkins wrote:
> > On Sun, Aug 27, 2023 at 01:25:27PM +0100, Conor Dooley wrote:
> > > On Sun, Aug 27, 2023 at 11:28:33AM +0100, Conor Dooley wrote:
> > > > On Sat, Aug 26, 2023 at 07:00:47PM -0700, Palmer Dabbelt wrote:
> > > > > On Sat, 26 Aug 2023 18:42:41 PDT (-0700), Conor Dooley wrote:
> > > > > > On Sat, Aug 26, 2023 at 06:26:06PM -0700, Charlie Jenkins wrote:
> > > > > > > Provide checksum algorithms that have been designed to leverage riscv
> > > > > > > instructions such as rotate. In 64-bit, can take advantage of the larger
> > > > > > > register to avoid some overflow checking.
> > > > > > > 
> > > > > > > Add configuration for Zba extension and add march for Zba and Zbb.
> > > > > > > 
> > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > ---
> > > > > > >  arch/riscv/Kconfig                | 23 +++++++++++
> > > > > > >  arch/riscv/Makefile               |  2 +
> > > > > > >  arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 111 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > index 4c07b9189c86..8d7e475ca28d 100644
> > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > @@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> > > > > > >  	  If you don't know what to do here, say Y.
> > > > > > > +config TOOLCHAIN_HAS_ZBA
> > > > > > > +	bool
> > > > > > > +	default y
> > > > > > > +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
> > > > > > > +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
> > > > > > > +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> > > > > > > +	depends on AS_HAS_OPTION_ARCH
> > > > > > > +
> > > > > > > +config RISCV_ISA_ZBA
> > > > > > > +	bool "Zba extension support for bit manipulation instructions"
> > > > > > > +	depends on TOOLCHAIN_HAS_ZBA
> > > > > > > +	depends on MMU
> > > > > > > +	depends on RISCV_ALTERNATIVE
> > > > > > > +	default y
> > > > > > > +	help
> > > > > > > +	   Adds support to dynamically detect the presence of the ZBA
> > > > > > > +	   extension (basic bit manipulation) and enable its usage.
> > > > > > > +
> > > > > > > +	   The Zba extension provides instructions to accelerate a number
> > > > > > > +	   of bit-specific address creation operations.
> > > > > > > +
> > > > > > > +	   If you don't know what to do here, say Y.
> > > > > > > +
> > > > > > >  config TOOLCHAIN_HAS_ZBB
> > > > > > >  	bool
> > > > > > >  	default y
> > > > > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > > > > index 6ec6d52a4180..51fa3f67fc9a 100644
> > > > > > > --- a/arch/riscv/Makefile
> > > > > > > +++ b/arch/riscv/Makefile
> > > > > > > @@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
> > > > > > >  riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
> > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
> > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
> > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
> > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
> > > > > > 
> > > > > > AFAICT, this is going to break immediately on any system that enables
> > > > > > RISCV_ISA_ZBA (which will happen by default) but does not support the
> > > > > > extension. You made the option depend on RISCV_ALTERNATIVE, but I do
> > > > > > not see any use of alternatives in the code to actually perform the
> > > > > > dynamic detection of Zba.
> > > > > 
> > > > > I guess we kind of have an ambiguity here: for stuff like C we just
> > > > > unconditionally use the instructions, but for the rest we probe first.  We
> > > > > should probably have three states for each extension: disabled, dynamically
> > > > > detected, and assumed.
> > > > 
> > > > You mean, just add some comments to the makefile surrounding each
> > > > section or to some rst documentation?
> > > 
> > > Also, the code here doesn't build w/
> > > 	warning: invalid argument to '-march': '_zba_zbb_zicsr_zifencei_zihintpause'
> > > so there's something else wrong with TOOLCHAIN_HAS_ZBA :)
> > It is odd that this is missing 'rv64ima' or 'rv32ima' at the beginning of
> > this string. What configuration are you using that could cause that to
> > be left off?
> 
> I don't know, but that configuration is pretty pervasive. The patchwork
> CI blew up too & that is using kernel.org toolchains built by Arnd:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> > Compiling with defconfig automatically enables Zba and appears to not
> > cause this issue. I realized that I put the header definitions for
> > do_csum and csum_ipv6_magic in this patch instead of the next one so the
> > code will fail to compile from this but not due to march settings.
> > > 
> > > > 
> > > > > > Note that for fd & v, we add it to riscv-march-y, but then immediately
> > > > > > remove it again before passing to the compiler, only allow them in
> > > > > > AFLAGS:
> > > > > > 	# Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
> > > > > > 	# matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
> > > > > > 	KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> > > > > > 
> > > > > > What am I missing?
> > > > > 
> > > > > FD and V both have state that can be saved lazily, so we can't let arbitrary
> > > > > code use them.  The extensions formally known as B don't add state, so they
> > > > > are safe to flip on in arbitrary places (aside from the issues you pointed
> > > > > out above).
> > > > 
> > > > I probably went about this badly since you missed the point. I was
> > > > trying to point out that for anything other than the compressed
> > > > extensions in the block above that we only pass them in march to the
> > > > assembler, and not to the compiler, in contrast to this patch which just
> > > > always passes them. I should have pointed to how we handled the
> > > > in-kernel Zbb stuff & asked how this was any different, would probably
> > > > have been clearer.
> > > > 
> > I supposed it might be better if I submit these changes in a different
> > patch so we can have more discussion there. Zbb was previously only used
> > by assembly files (arch/riscv/lib/strcmp.S, arch/riscv/lib/strlen.S,
> > arch/riscv/lib/strncmp.S). I wanted to add them to the compiler so that
> > that C programs could leverage these extensions. However, I neglected to
> > consider machines that compile the kernel with these extensions but have
> > cores without these extensions.
> 
> Less so cores, since we don't support heterogeneous stuff, and moreso
> platforms that do not support the extensions. It's expected that the
> same kernel could in theory be used across a wide variety of systems.
> 
> > The purpose of using these extensions is
> > to save a couple of clock cycles, so if it is necessary to first
> > check if the extension is enabled it may not be worth it for these
> > functions.
> 
> That's still possible, it's what the alternatives mechanism exists for.
> During boot the codepaths are patched to use what works for a given
> machine, check out the code that makes use of Zbb or
> riscv_has_extension_[un]likely(). You'd need to do something like the
> existing users of Zbb instructions does, with an alternative used to
> avoid the custom asm implementations when the hardware does not support
> them. (That's what the CONFIG_ALTERNATIVE & CONFIG_AS_HAS_OPTION_ARCH
> options you made the TOOLCHAIN_HAS_ZBA depend on are for).

I can see how to get this to work if I port this code into assembly and
write two different versions (one with Zbb and one without), but
I don't see how this would work in C. Unless I am mistaken, there would
need to be some sort of wrapper around the C code that told the compiler
to compile it multiple times for different extension combinations and
then use the riscv_has_extension_[un]likely() functions to determine
which version to use at runtime. Is this feasible?
