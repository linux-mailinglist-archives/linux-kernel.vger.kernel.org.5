Return-Path: <linux-kernel+bounces-92755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FD87258D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D4B27D55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51A168DD;
	Tue,  5 Mar 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLh68MSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6914AA8;
	Tue,  5 Mar 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659263; cv=none; b=N7lkYFVFXTUC45ibFCz/Tj/AvY5f8tsMDTvWBNo3ZVHa38Bmn0mLsL8No/+7D3YOg0JkBLinbSr6x3uxGMAL28fxqKowkyVNZ4a/13aORzcC66uBsVIJ0UeaVQO9/expmN2wiU/GsQNH92pcgtQG9NLHfohXRGhEDUjE3JqXWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659263; c=relaxed/simple;
	bh=u/5agPX/lDQGtNbFvNrArovCNgzjSoaqePko/71LzPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlDP2swwrhFqGC6HoU1xbzr+4jKHOjfi8yLQwf6gYNsbo7UiwQNa+DOxK3UDc36Ao92jb0O+GQbDRxcQVDjTfsS8Wc47UeVoMAYo6r8A2ax9k/0w87JWpiMlXPBYvReaf+VDWZDTy555N5lIvGgTD60mNNHy4GAjk4hln9vC2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLh68MSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADEAC43390;
	Tue,  5 Mar 2024 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709659263;
	bh=u/5agPX/lDQGtNbFvNrArovCNgzjSoaqePko/71LzPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLh68MSAY+lVY1J2FtZLY48K1b81meFAuTM98dQCDx/YN8N8VdfVtxT1fwI6ZEBTH
	 kmXVOwXzXuoC/fKP+poyLcgqsH1MVL0JExkC5jZdgoGEV94kG7Whw2oGB9Sb0/va/i
	 sPom6z6JzJENMaaZMWFNlmXkbwY9oSCWEjrEUnu0jDtgd7WNgq36ld5OLZRXf1h+Vs
	 +uVjvKqF+1Z0nRHxf0cZgLMVagOXc6c74/+dPJeYsgJO6ObDWXVsB/dpH6/wfw0V0q
	 eqm5suN4eKt4cFETc6ZVGggx+JROVMqGCEN0NO/d6TqX6RGKv6bgdQGJn9SVEmskHw
	 BiJv3YSN0VM5A==
Date: Tue, 5 Mar 2024 17:20:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-riscv@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU
 for K230
Message-ID: <20240305-fascism-enrich-06483ddeb149@spud>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kCqjEWLK9A+dep2C"
Content-Disposition: inline
In-Reply-To: <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>


--kCqjEWLK9A+dep2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:47:15PM +0800, Yangyu Chen wrote:
> On 2024/3/5 07:46, Damien Le Moal wrote:
> > On 3/5/24 06:05, Yangyu Chen wrote:
> > > Since K230 was released, SOC_CANAAN is no longer only referred to the=
 K210.
> > > Remove it depends on !MMU will allow building dts for K230 and remove=
 the
> > > K210 string from the help message.
> > >=20
> > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >   arch/riscv/Kconfig.socs | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index 623de5f8a208..b4e9b7f75510 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -75,13 +75,12 @@ config ARCH_CANAAN
> > >   	def_bool SOC_CANAAN
> > >   config SOC_CANAAN
> > > -	bool "Canaan Kendryte K210 SoC"
> > > -	depends on !MMU
> >=20
> > This seems wrong to me. The k210 support does require no-mmu. So why re=
move
> > this ?
>=20
> It just allows SOC_CANAAN to be selected when MMU=3Dy. With this patch,
> nommu_k210_defconfig still works.

I think the concern here is that this would allow people to build a
kernel for the k120 with the MMU enabled, not that the existing nommu
build will be affected.

Maybe you could squash in something like the following?

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index b4e9b7f75510..75d55059163f 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -72,15 +72,19 @@ config SOC_VIRT
 	  This enables support for QEMU Virt Machine.
=20
 config ARCH_CANAAN
-	def_bool SOC_CANAAN
+	bool "Canaan Kendryte SoCs"
+	help
+	  This enables support for Canaan Kendryte SoC platform hardware.
=20
 config SOC_CANAAN
-	bool "Canaan Kendryte SoC"
+	bool "Canaan Kendryte K210 SoC"
+	depends on !MMU
+	depends on ARCH_CANAAN
 	select CLINT_TIMER if RISCV_M_MODE
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	select COMMON_CLK
 	help
-	  This enables support for Canaan Kendryte SoC platform hardware.
+	  This enables support for Canaan Kendryte K210 SoC platform hardware.
=20
 endmenu # "SoC selection"

(Which reminds me, I really need to go and finish sorting out the ARCH_
stuff)

--kCqjEWLK9A+dep2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZedUegAKCRB4tDGHoIJi
0mvGAP46YoIzshNQyc4YEgagEXQXzIwdeALQV+PKRlM2tCe2FQEAvnZO3VGbXelI
c9WuUEV6/uQa3XYyXDrSIxQdWFWinQo=
=oH7D
-----END PGP SIGNATURE-----

--kCqjEWLK9A+dep2C--

