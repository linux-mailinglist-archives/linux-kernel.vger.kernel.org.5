Return-Path: <linux-kernel+bounces-74191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546C85D0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF052860A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A73AC01;
	Wed, 21 Feb 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ay+Fjig2"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFA3A278;
	Wed, 21 Feb 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499393; cv=none; b=RhpKTPxlrfjEan38b8pLLJJu/lgEb2SgtvJD8T27DX+pUr7SXSfofupr0+vl2FM9b653Vhhc0I9Rg2X4+A71XvM2fYWE59gKVt4wAUuEU7+0jZMFDJgFV5HtnsEvVldBR2O/5OIXz8eTEFt4YN9usv3HIHDlEGidGkIHT2g2gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499393; c=relaxed/simple;
	bh=yux/Vsxzv5oB5Pxe0I+9HoxEbTT1akUSmVUFak3qdNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjT9Cb6P9G6whbcCbqsS3bHnpkeeyDimlF5yjoyCEYzsu3OjXPQatd+dGmQDkkAuncK+MNbryICPWV2URcuIfuqIWwb+8sfpDGIFnhp8TLWWCdPxkuWi8yaCC3+MRweZilrZZtw2huqBelsoZEdf0RSE6dRoVlBNUxeMDl6bfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ay+Fjig2; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708499378; bh=Aojxs4UURNiotTkCGFMzfVtE9OMZyWgHkto+sH1Fy5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ay+Fjig2MZ2JYheoXCkabneg/W/PjFmGg6Q3WMdYglFC/C8XcwnHMk7CXmdETYglX
	 p0nbzb/rjmgK1SLn30c26hjma/V2Ql6bfU+ml1oDiccyd9jvn5s9RGQTXvBDCmLUZR
	 Mcq2GkNMAnIKKVEsUbzaI/KPkfbkpKG/hLYy0A08=
Received: from [127.0.0.1] ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 4A206F9; Wed, 21 Feb 2024 15:01:10 +0800
X-QQ-mid: xmsmtpt1708498870tb5gcf7em
Message-ID: <tencent_5FFF7CF58292DA298E35B86C3196212E8D08@qq.com>
X-QQ-XMAILINFO: NMCsm0XXqhsS+/VErxGmnDcWLmBhlbPOCkGBYjPas2uxgBmm3ZOdaEuOpZd83U
	 BH5GPogQwUKLXsvVFPqnqu9Uf73tMGgedLpau39FuxibdBLyKQVQL16diDZhi4jRp+K+y+FaOK6N
	 wUoJgxnzSggAjeJwzkglaBCsrByK7Q0VCPlgaAjGhoeqceW3+EufIyrbB91Ivpab4p8w284S0r9j
	 fnHDitd6g9LudfIwrhDDa0VPkbK1OZW2EizZLcusNTu6FZwx1r87YDkxbcuBwisPq3ENYjbxwMVb
	 6RhGbxS1DDDaK3CYwAG6DeLzKFzAfJNN5ZyJEEtiR3+YEoy3iuQe5Y8J2KJub8CTNUNFMlw6YHBZ
	 mjhYYNzWlOoGTfTgAqbCbq9boXBwSfyMzDQzixsBayYoakcb5Mf5p66n3unhV1Mv8WEYxYFiZsPq
	 zggh9orxdrZn3YSQlZJ/RrZXs3Yd6vEiyTjA/Q5DgcqxNA+IcEpy9S0CeAEmDw1r0uE6izPPwyPe
	 FLfFdHX9MjCzaG6DBph2KMkP0XtON7+IYLsUFhEHb7lzvf+cI/RrMVd64I/ZDLj9T0SlGsiwxWDG
	 CFKT9zyZSj1S6b4zUz9+GDRyt5Jd3IdoZBrEcDll63MKXRBuc6gAGmB7Wo3zwXZb6IU8k3GB3uI7
	 v7ER5cNK29Vo363qRbbaCZOWhSH/wn2z3xcrhwyAdVylSeODu6v7tn0mB+eXavIdmStRy004zAl8
	 1etbOL7vssbNqLu++wuk7jlC9IBPOtJ+cwOPZfjVaMmRke/ijXuXNtZx69Rx/dGJPdm5ASTXzM8u
	 dLwcmhra5IkspK47qxNuAz/XxxiJhrSIiq1ZXj+Zw4erMu7I4HDcVl0AcnBjT8yelENH8MimhxXo
	 qvgAmBa7AHiUHiWNdCzQp9MzT4qFvrz0Nb8gQGGfchBmdqbsRTZC/oVjsdypAD9BWtPlJoLbUsC2
	 HOgmTiSk7S3xTUiwC9IpoQGLgZJzw+KST9T6lr1G2u2asygg5DraxTzFqlZ1kZIEvrxzLw1pk=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <1596f5b2bd40e9a26d537eec963a156b09471194.camel@cyyself.name>
Subject: Re: [RFC PATCH 1/1] riscv: dts: Allow BUILTIN_DTB for all socs
From: Yangyu Chen <cyy@cyyself.name>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring
 <robh+dt@kernel.org>,  devicetree@vger.kernel.org
Date: Wed, 21 Feb 2024 15:01:10 +0800
In-Reply-To: <20240221-numerator-grill-1e5603841a8d@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
	 <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
	 <20240221-numerator-grill-1e5603841a8d@spud>
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

On Wed, 2024-02-21 at 01:11 +0000, Conor Dooley wrote:
> On Wed, Feb 21, 2024 at 03:03:57AM +0800, Yangyu Chen wrote:
> > The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC
> > only. This
> > patch moved this configuration to entire riscv.
> >=20
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> A passing remark here only:
> The detail in the cover letter belongs in the commit message. There's
> very little value in a cover letter for a one patch "series" - it
> either will duplicate information from the commit message (and is
> therefore useless) or, as in this case, splits information that
> should
> be in the commit message away from it.
>=20
> Thanks,
> Conor.
>=20

Thanks. I will move these detailed reasons to commit message. I am
waiting for other review comments before submitting patch v2.

> > ---
> > =C2=A0arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++=
++-
> > =C2=A0arch/riscv/Kconfig.socs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 -------------------------
> > ----
> > =C2=A0arch/riscv/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
> > =C2=A0arch/riscv/boot/dts/canaan/Makefile |=C2=A0 2 --
> > =C2=A04 files changed, 16 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b49016bb5077..23d501561e64 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -996,7 +996,21 @@ config RISCV_ISA_FALLBACK
> > =C2=A0config BUILTIN_DTB
> > =C2=A0	bool "Built-in device tree"
> > =C2=A0	depends on OF && NONPORTABLE
> > -	default y if XIP_KERNEL
> > +	default y if XIP_KERNEL || SOC_CANAAN
> > +	help
> > +	=C2=A0 Build a device tree into the Linux image.
> > +	=C2=A0 This option should be selected if no bootloader is being
> > used.
> > +	=C2=A0 If unsure, say Y.
> > +
> > +
> > +config BUILTIN_DTB_SOURCE
> > +	string "Built-in device tree source"
> > +	depends on BUILTIN_DTB
> > +	default "canaan/k210_generic" if SOC_CANAAN
> > +	help
> > +	=C2=A0 DTS file path (without suffix, relative to
> > arch/riscv/boot/dts)
> > +	=C2=A0 for the DTS file that will be used to produce the DTB
> > linked into the
> > +	=C2=A0 kernel.
> > =C2=A0
> > =C2=A0endmenu # "Boot options"
> > =C2=A0
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index e08e91c49abe..623de5f8a208 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -84,36 +84,4 @@ config SOC_CANAAN
> > =C2=A0	help
> > =C2=A0	=C2=A0 This enables support for Canaan Kendryte K210 SoC
> > platform hardware.
> > =C2=A0
> > -if ARCH_CANAAN
> > -
> > -config ARCH_CANAAN_K210_DTB_BUILTIN
> > -	def_bool SOC_CANAAN_K210_DTB_BUILTIN
> > -
> > -config SOC_CANAAN_K210_DTB_BUILTIN
> > -	bool "Builtin device tree for the Canaan Kendryte K210"
> > -	depends on ARCH_CANAAN
> > -	default y
> > -	select OF
> > -	select BUILTIN_DTB
> > -	help
> > -	=C2=A0 Build a device tree for the Kendryte K210 into the Linux
> > image.
> > -	=C2=A0 This option should be selected if no bootloader is being
> > used.
> > -	=C2=A0 If unsure, say Y.
> > -
> > -config ARCH_CANAAN_K210_DTB_SOURCE
> > -	string
> > -	default SOC_CANAAN_K210_DTB_SOURCE
> > -
> > -config SOC_CANAAN_K210_DTB_SOURCE
> > -	string "Source file for the Canaan Kendryte K210 builtin
> > DTB"
> > -	depends on ARCH_CANAAN
> > -	depends on ARCH_CANAAN_K210_DTB_BUILTIN
> > -	default "k210_generic"
> > -	help
> > -	=C2=A0 Base name (without suffix, relative to
> > arch/riscv/boot/dts/canaan)
> > -	=C2=A0 for the DTS file that will be used to produce the DTB
> > linked into the
> > -	=C2=A0 kernel.
> > -
> > -endif # ARCH_CANAAN
> > -
> > =C2=A0endmenu # "SoC selection"
> > diff --git a/arch/riscv/boot/dts/Makefile
> > b/arch/riscv/boot/dts/Makefile
> > index 72030fd727af..318239d9423b 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -8,4 +8,4 @@ subdir-y +=3D sophgo
> > =C2=A0subdir-y +=3D starfive
> > =C2=A0subdir-y +=3D thead
> > =C2=A0
> > -obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> > +obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix .dtb.o,
> > $(CONFIG_BUILTIN_DTB_SOURCE))
> > \ No newline at end of file

I should keep the newline at EOF, I will fix this for patch v2.

> > diff --git a/arch/riscv/boot/dts/canaan/Makefile
> > b/arch/riscv/boot/dts/canaan/Makefile
> > index 520623264c87..987d1f0c41f0 100644
> > --- a/arch/riscv/boot/dts/canaan/Makefile
> > +++ b/arch/riscv/boot/dts/canaan/Makefile
> > @@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maixduino.dtb
> > -
> > -obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) +=3D $(addsuffix .dtb.o,
> > $(CONFIG_ARCH_CANAAN_K210_DTB_SOURCE))
> > --=20
> > 2.43.0
> >=20
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv


