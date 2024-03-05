Return-Path: <linux-kernel+bounces-93115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78960872B34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1BC1C23283
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9812DD8F;
	Tue,  5 Mar 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH9VvmT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7679953;
	Tue,  5 Mar 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681945; cv=none; b=Qf6AncSdkXSObOaODSafjcKj0UideGUZu/JVAYxAQBIKmw1nwbHnzI4nLMXJ8f+2LPgiqhQspkXDxHJnfAXujlhr3wzBtfIflZvDmWn2GYFEtJEZ2LzR6SLiEpHRmSpCvrxmq3sBvynowv2srZPeKtP/xOXt8FOTi1PqigmsP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681945; c=relaxed/simple;
	bh=eF6fEU4NsP+4MAw9M3fSpU7V560O2SKhvnGSecXMnuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfOTV/tHNnGUg7ToevDdwZUvh7iMxeDzgM+rzAdzN/S1oZZQB1MjjArnYoIr2eVQOJjO4rQdvEd1YNIs4+t90HD2iF5g4IZ+txvwE9xW3GOgBzBZjjP2ygtgoq2FP+nLSsHjHZR2B2xx1KclOYWLrRk2y+FR2hvukSR5Wa5w8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH9VvmT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62632C43390;
	Tue,  5 Mar 2024 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681945;
	bh=eF6fEU4NsP+4MAw9M3fSpU7V560O2SKhvnGSecXMnuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OH9VvmT66ki9cMYzzhwzkUmwlR3zTOBZDex5hAZj7d6jfQEeGMQ+2ez9DMY7DZcIl
	 oNQS/InP7o2qHDblRo9602FBLdFTZ8J26VuP0Bz7AD7+s3xwS3//CCzhbxi0TnRs4i
	 nHHAeMkhISa+2GtgY0lkTAsvJseEDZ4GZIipXP2Lq7NeUMdLLRBnegXeNyUQOdh9D1
	 0PwU3Gdxx38Ti9AiFgV/i9DFTYXJuVuIMPK4TkP8y0INqKREaL+RWhG947UWSbOs4m
	 9qnxlRtDYuw7hfi6hlUG3Ot4UyOytXPJwm5h5f0/W1Cqwwbkcifd013frP4Zt1SnQi
	 7Y9IuPHi1Wv4g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so423851a12.0;
        Tue, 05 Mar 2024 15:39:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbPqfZWYSGZeNcuRP0m71gYWE5oGZFrJL4A5A5RNrBDr5g1Zht88a2fl0P2dM60rWGEt83Xe57gabtcwtWRnC3sRbbXy7ow3Jb6r3ufbiunaQuJKxmvrqW8FGxvFGx3WlwD+sumh6ufQ==
X-Gm-Message-State: AOJu0YwnmLp9vwqBWx1p+Z04BEOfACyz94yQgakGHmhmjS1r7G5yFh9q
	q/fi4+GyxNkIqXWwWEwhIvsc6MM5//jjSnF2XKVNvIk9Vf0KAL9v+NHHq+EELHyvJPOF3LfUZ96
	4UHnku/TsZ39Tu3bmTWwSakLJKz8=
X-Google-Smtp-Source: AGHT+IFuKxZwO7MsecCyojmGn06y7zA3qnEWqqCGWBGTqq07pyDG36n7t4pykLYIeRX5yUWIoibpmr6Lcd385o8uwjU=
X-Received: by 2002:a05:6402:35d5:b0:566:ff31:7974 with SMTP id
 z21-20020a05640235d500b00566ff317974mr9185801edc.34.1709681943723; Tue, 05
 Mar 2024 15:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com> <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
In-Reply-To: <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 6 Mar 2024 07:38:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
Message-ID: <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch cross so many subsystems, I am not sure about it. If I were
you, I would keep SOC_CANAAN and just add SOC_CANAAN_K230.

On Wed, Mar 6, 2024 at 7:04=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> Since we have Canaan Kendryte K230 with MMU now. The use of SOC_CANAAN
> is no longer only referred to K210. Split them and add _K210 suffix
> to the name for old SOC_CANAAN. And allows ARCH_CANAAN to be selected
> for other Canaan SoCs.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/Kconfig.socs                        | 8 +++++---
>  arch/riscv/Makefile                            | 2 +-
>  arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
>  drivers/clk/Kconfig                            | 4 ++--
>  drivers/pinctrl/Kconfig                        | 4 ++--
>  drivers/reset/Kconfig                          | 4 ++--
>  drivers/soc/Makefile                           | 2 +-
>  drivers/soc/canaan/Kconfig                     | 4 ++--
>  9 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 623de5f8a208..5710aee456ac 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -72,11 +72,13 @@ config SOC_VIRT
>           This enables support for QEMU Virt Machine.
>
>  config ARCH_CANAAN
> -       def_bool SOC_CANAAN
> +       bool "Canaan Kendryte SoC"
> +       help
> +         This enables support for Canaan Kendryte SoC platform hardware.
>
> -config SOC_CANAAN
> +config SOC_CANAAN_K210
>         bool "Canaan Kendryte K210 SoC"
> -       depends on !MMU
> +       depends on !MMU && ARCH_CANAAN
>         select CLINT_TIMER if RISCV_M_MODE
>         select ARCH_HAS_RESET_CONTROLLER
>         select PINCTRL
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 252d63942f34..fa6c389c3986 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -154,7 +154,7 @@ vdso-install-y                      +=3D arch/riscv/k=
ernel/vdso/vdso.so.dbg
>  vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/compat=
_vdso.so.dbg:../compat_vdso/compat_vdso.so
>
>  ifneq ($(CONFIG_XIP_KERNEL),y)
> -ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> +ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
>  KBUILD_IMAGE :=3D $(boot)/loader.bin
>  else
>  ifeq ($(CONFIG_EFI_ZBOOT),)
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs=
/nommu_k210_defconfig
> index 7e75200543f4..2552e78074a3 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -27,7 +27,8 @@ CONFIG_EXPERT=3Dy
>  CONFIG_SLUB=3Dy
>  CONFIG_SLUB_TINY=3Dy
>  # CONFIG_MMU is not set
> -CONFIG_SOC_CANAAN=3Dy
> +CONFIG_ARCH_CANAAN=3Dy
> +CONFIG_SOC_CANAAN_K210=3Dy
>  CONFIG_NONPORTABLE=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D2
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/=
configs/nommu_k210_sdcard_defconfig
> index 0ba353e9ca71..8f67fb830585 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -19,7 +19,8 @@ CONFIG_EXPERT=3Dy
>  CONFIG_SLUB=3Dy
>  CONFIG_SLUB_TINY=3Dy
>  # CONFIG_MMU is not set
> -CONFIG_SOC_CANAAN=3Dy
> +CONFIG_ARCH_CANAAN=3Dy
> +CONFIG_SOC_CANAAN_K210=3Dy
>  CONFIG_NONPORTABLE=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D2
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 50af5fc7f570..7517a0dfd15c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -451,8 +451,8 @@ config COMMON_CLK_FIXED_MMIO
>
>  config COMMON_CLK_K210
>         bool "Clock driver for the Canaan Kendryte K210 SoC"
> -       depends on OF && RISCV && SOC_CANAAN
> -       default SOC_CANAAN
> +       depends on OF && RISCV && SOC_CANAAN_K210
> +       default SOC_CANAAN_K210
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 8163a5983166..837b3bac8aac 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -217,13 +217,13 @@ config PINCTRL_INGENIC
>
>  config PINCTRL_K210
>         bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
> -       depends on RISCV && SOC_CANAAN && OF
> +       depends on RISCV && SOC_CANAAN_K210 && OF
>         select GENERIC_PINMUX_FUNCTIONS
>         select GENERIC_PINCONF
>         select GPIOLIB
>         select OF_GPIO
>         select REGMAP_MMIO
> -       default SOC_CANAAN
> +       default SOC_CANAAN_K210
>         help
>           Add support for the Canaan Kendryte K210 RISC-V SOC Field
>           Programmable IO Array (FPIOA) controller.
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index ccd59ddd7610..6499da7ecc3b 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -94,9 +94,9 @@ config RESET_INTEL_GW
>
>  config RESET_K210
>         bool "Reset controller driver for Canaan Kendryte K210 SoC"
> -       depends on (SOC_CANAAN || COMPILE_TEST) && OF
> +       depends on (SOC_CANAAN_K210 || COMPILE_TEST) && OF
>         select MFD_SYSCON
> -       default SOC_CANAAN
> +       default SOC_CANAAN_K210
>         help
>           Support for the Canaan Kendryte K210 RISC-V SoC reset controlle=
r.
>           Say Y if you want to control reset signals provided by this
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index ba8f5b5460e1..fb2bd31387d0 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -7,7 +7,7 @@ obj-y                           +=3D apple/
>  obj-y                          +=3D aspeed/
>  obj-$(CONFIG_ARCH_AT91)                +=3D atmel/
>  obj-y                          +=3D bcm/
> -obj-$(CONFIG_SOC_CANAAN)       +=3D canaan/
> +obj-$(CONFIG_ARCH_CANAAN)      +=3D canaan/
>  obj-$(CONFIG_ARCH_DOVE)                +=3D dove/
>  obj-$(CONFIG_MACH_DOVE)                +=3D dove/
>  obj-y                          +=3D fsl/
> diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
> index 43ced2bf8444..3121d351fea6 100644
> --- a/drivers/soc/canaan/Kconfig
> +++ b/drivers/soc/canaan/Kconfig
> @@ -2,9 +2,9 @@
>
>  config SOC_K210_SYSCTL
>         bool "Canaan Kendryte K210 SoC system controller"
> -       depends on RISCV && SOC_CANAAN && OF
> +       depends on RISCV && SOC_CANAAN_K210 && OF
>         depends on COMMON_CLK_K210
> -       default SOC_CANAAN
> +       default SOC_CANAAN_K210
>         select PM
>         select MFD_SYSCON
>         help
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren

