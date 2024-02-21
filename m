Return-Path: <linux-kernel+bounces-75322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2785E682
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9147D1F27784
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B958564D;
	Wed, 21 Feb 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="t4uZdl6f"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129581ABB;
	Wed, 21 Feb 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540843; cv=none; b=seiPW6UjyvJoyO15iKRKo2ulYvBHS6DxauhDDcGS8rciS42j1ZgAn5caHvaa1agI9LjDCgOuEKf4SLGYFMVu2QQ/P94HdDAzOwt/8HblDCPt0wiEgpjp4Bzj5BUgXhFuZWXTk10C2JUtguKYflcXa/21k9wbiN2dw9A0Hf1NRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540843; c=relaxed/simple;
	bh=k1eDqaIswTgqD5OS5/G29+FmITqSVxJ/03sfK8QmKRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdqzlpomUvXPK3ADYzsh8cc58/xYNu6nVN7MBh2nhVtD+LE7jaCBjaOZHIHFwoCX+t7Kfr05Soxe3HqWFDT5bFMkBk8HM4ou7qseM6f4jTNrKBamzidB3gIWV2meWh5sTWB6V7vEAMt8WyN0c49SsYCUGCcBPXurm/SN6/nWs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=t4uZdl6f; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708540831; bh=BnNqiTWshd0XTpZyAA+9BD6N6F5j6YPYc5Nmrd2/5Xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=t4uZdl6fkRhcOwnoXeDRYcUWI78Yp1r6+4UaiqEws09JVtE5Kn6EE94U0rp562qMW
	 pCNntZrUGz+R9aSEDfaleSbYWDnHsC/e7bvAbjeIORlANQkUQa5hpoSWnL7dfk+FMW
	 wBW20tld8fERtQbM/YGVLP1uKOxDtdPoC5oITjbM=
Received: from [127.0.0.1] ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id A1D29E0D; Thu, 22 Feb 2024 02:40:29 +0800
X-QQ-mid: xmsmtpt1708540829tiz3vhnjy
Message-ID: <tencent_EA82189210BC461F3E4541476D2F47555C07@qq.com>
X-QQ-XMAILINFO: NYXSVuwhoxRbvxR8nz1n/FNs0zoLS8oMF8dqAIBq+L3Lkwn9NjAg8C9ZYPpxIV
	 qsOolB2+bM7HUZIT+JfIC2SRtNLBxA1pkpOCumZeTW0w6jleM6/G9mxc8W38a+hpVIveD1vNcj/6
	 OYE36jLYIw0nnSVR5iVRlTr/5Yxn8C7QssV5YhtGoW4GoDi3G+7PumpwZgI/LWODtp+lKykSCwM7
	 +ZjTQBie+QcSjtacl2t2f4PygqwBW4CTAeZJxdKDuJV96qSLrW6X/2tvaSc4Jzh7sqV+Bu3PZWrh
	 6PUrqBpPY9XCRJXPiLeQ8F7Cg8UVg6ND5xHd+fnYfxGfqujTB0fMSOTEx26e5J6QfYAj5cxpZTnl
	 jbXPiGt92pL8cRIjecVt1pB22SpjXH3LpvNyTYSC2/9x43kIjIRPbyDQ0xXIShiD4iQHktgcctUv
	 cs24y41K2LVz0XjPqncWf1S2G+Zd9SEbVguT0O8JOfxoMoKOt/2qHEP4M/d4ivtj+/0RXstsFPkK
	 XQveNaa/GuxF1kRLLwupsN2tfmG+F/DHaHL9TOU7UPyd76lbulrAX81R2lpN5GnYZPpByZD9wcRJ
	 sORkhXUdvi6lRDgxq/1OEJ5g1CUQL2o8ft3DrlD5/ChI9HYmCjcHjXS4Zc/3rW1Fu66icnqgQ6Ny
	 tnlRoaKTjmoMtAunWpp2Rmjklq5HUsjJTSWhI3P3qiaQ1t6qlF0neKQs+YjH9mzk1UAwBLVR4Ror
	 fXNwMlOmzcqVWloQYEJqSyaSZxTRUgWfUl8A/uOSbnY1E0FXfXQbQrXUaZ+ZgtInIH/EwHIKAbZa
	 h2C+aSybAzL5C2GP+/Yv9EWH7hWjuBz+8gW37XYrEeVPYZ1oTuWRmnlbYqrWG+A7Ib2CxgAmNNbp
	 7IUh6sgF7+H5sAyF/8QIYULVAeKKXtX+YjeL/uLFsdW8f7fT241nvksIdYCs2KXQuYSImU/TcBVe
	 IRPZAQDkCQAmbSHhIQ6oHDkua9k1sDJGQXh2rIa/GBQ9saI2ipfkYMmpmdWt+d
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <c082eff537d9a2998b3474eabd6bbf1c002f3ba9.camel@cyyself.name>
Subject: Re: [RFC PATCH 1/1] riscv: dts: Allow BUILTIN_DTB for all socs
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
	 <conor@kernel.org>, linux-kernel@vger.kernel.org, Masahiro Yamada
	 <masahiroy@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring
	 <robh+dt@kernel.org>, devicetree@vger.kernel.org
Date: Thu, 22 Feb 2024 02:40:29 +0800
In-Reply-To: <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
	 <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
Autocrypt: addr=cyy@cyyself.name; prefer-encrypt=mutual;
 keydata=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
	0mslfht1JyMf5dUi38RQI/fOO0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 03:03 +0800, Yangyu Chen wrote:
> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only.
> This
> patch moved this configuration to entire riscv.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
> =C2=A0arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++-
> =C2=A0arch/riscv/Kconfig.socs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 ---------------------------
> --
> =C2=A0arch/riscv/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0arch/riscv/boot/dts/canaan/Makefile |=C2=A0 2 --
> =C2=A04 files changed, 16 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b49016bb5077..23d501561e64 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -996,7 +996,21 @@ config RISCV_ISA_FALLBACK
> =C2=A0config BUILTIN_DTB
> =C2=A0	bool "Built-in device tree"
> =C2=A0	depends on OF && NONPORTABLE
> -	default y if XIP_KERNEL
> +	default y if XIP_KERNEL || SOC_CANAAN
> +	help
> +	=C2=A0 Build a device tree into the Linux image.
> +	=C2=A0 This option should be selected if no bootloader is being
> used.
> +	=C2=A0 If unsure, say Y.
> +
> +
> +config BUILTIN_DTB_SOURCE
> +	string "Built-in device tree source"
> +	depends on BUILTIN_DTB
> +	default "canaan/k210_generic" if SOC_CANAAN
> +	help
> +	=C2=A0 DTS file path (without suffix, relative to
> arch/riscv/boot/dts)
> +	=C2=A0 for the DTS file that will be used to produce the DTB
> linked into the
> +	=C2=A0 kernel.
> =C2=A0
> =C2=A0endmenu # "Boot options"
> =C2=A0
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e08e91c49abe..623de5f8a208 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -84,36 +84,4 @@ config SOC_CANAAN
> =C2=A0	help
> =C2=A0	=C2=A0 This enables support for Canaan Kendryte K210 SoC platform
> hardware.
> =C2=A0
> -if ARCH_CANAAN
> -
> -config ARCH_CANAAN_K210_DTB_BUILTIN
> -	def_bool SOC_CANAAN_K210_DTB_BUILTIN
> -
> -config SOC_CANAAN_K210_DTB_BUILTIN
> -	bool "Builtin device tree for the Canaan Kendryte K210"
> -	depends on ARCH_CANAAN
> -	default y
> -	select OF
> -	select BUILTIN_DTB
> -	help
> -	=C2=A0 Build a device tree for the Kendryte K210 into the Linux
> image.
> -	=C2=A0 This option should be selected if no bootloader is being
> used.
> -	=C2=A0 If unsure, say Y.
> -
> -config ARCH_CANAAN_K210_DTB_SOURCE
> -	string
> -	default SOC_CANAAN_K210_DTB_SOURCE
> -
> -config SOC_CANAAN_K210_DTB_SOURCE
> -	string "Source file for the Canaan Kendryte K210 builtin
> DTB"
> -	depends on ARCH_CANAAN
> -	depends on ARCH_CANAAN_K210_DTB_BUILTIN
> -	default "k210_generic"
> -	help
> -	=C2=A0 Base name (without suffix, relative to
> arch/riscv/boot/dts/canaan)
> -	=C2=A0 for the DTS file that will be used to produce the DTB
> linked into the
> -	=C2=A0 kernel.
> -
> -endif # ARCH_CANAAN
> -
> =C2=A0endmenu # "SoC selection"
> diff --git a/arch/riscv/boot/dts/Makefile
> b/arch/riscv/boot/dts/Makefile
> index 72030fd727af..318239d9423b 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -8,4 +8,4 @@ subdir-y +=3D sophgo
> =C2=A0subdir-y +=3D starfive
> =C2=A0subdir-y +=3D thead
> =C2=A0
> -obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> +obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix .dtb.o,
> $(CONFIG_BUILTIN_DTB_SOURCE))
> \ No newline at end of file
> diff --git a/arch/riscv/boot/dts/canaan/Makefile
> b/arch/riscv/boot/dts/canaan/Makefile
> index 520623264c87..987d1f0c41f0 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
> =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
> =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
> =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maixduino.dtb
> -
> -obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) +=3D $(addsuffix .dtb.o,
> $(CONFIG_ARCH_CANAAN_K210_DTB_SOURCE))

After carefully reviewing the code from the kernel I found that
`arch/riscv/boot/dts/sifive(microchip)/Makefile` will also build the
dtb object file and finally link to the kernel. This results in
multiple dtb inside the kernel but the kernel always takes the first to
use as someone mentioned before [1]. So only applying this patch to the
mainline kernel does not work for choosing one dtb. I should also
revert the modification on commit 0ddd7eaffa64 ("riscv: Fix BUILTIN_DTB
for sifive and microchip soc") to prevent building these files and let
them be managed by `arch/riscv/boot/dts/Makefile`.

I'm also waiting for other review comments on this idea before
submitting patch v2.

[1]
https://lore.kernel.org/linux-riscv/CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GC=
sfa=3DqXy=3D8Lrg@mail.gmail.com/


