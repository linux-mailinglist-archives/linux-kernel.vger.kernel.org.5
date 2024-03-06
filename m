Return-Path: <linux-kernel+bounces-93459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009B887302B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C41C22A69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FC5D461;
	Wed,  6 Mar 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NiGJOdJe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0F5C8F2;
	Wed,  6 Mar 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712231; cv=none; b=R/7PpuIN+6KMM9TZUATftLu4vZBtbIK7ZcqOMx0pwFWU393r51b5chdf2TSbJ84h2Jrei4Nn5s1pGEwuCicMX6yQh92xBW6CsUqHxL3uRVEqLIar3asdx6mBleGPqqJCKr6P8uhYWHwpEZkCXeriU3jyJ44M0/MZz2Bp0TaNcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712231; c=relaxed/simple;
	bh=PyZhw+aI3BqVpB4+q9ngRHTHPtwZjPrXz+aw8UuF9/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV83NyIpmxt98Yd5K5HH0UX075K+oWpqRd+NeRhjpfKEAmR8yNv7stsSmyyWl6EoapReCEiwTPkTqFxcYAwbcs5khhWEBUVT/yd9d89u28MDflNeKey6V9SYH5SYDJp+b1LNf1iNPYzq4yP7IZBoXQgqw684mlIO/i2XxZ6dxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NiGJOdJe; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709712230; x=1741248230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyZhw+aI3BqVpB4+q9ngRHTHPtwZjPrXz+aw8UuF9/Y=;
  b=NiGJOdJezlQkLwAJ3PG5AG2GalMPiqvfY3e6hD6s8x7eR9FYbtnj/246
   NeWcdwDE5bj3UQ46iggtGyfqLU7PYKfei3lVzCJo5AciTP0kQP5/kBL8L
   sbUEH4GTlO27rCRL6rqy27RfTq2Vt1whgLcdqnITQAbgNGRec9t13oxSD
   Quf3FeEm4CIKQ03lDVC//2r9FptnYmmWVGwnKTub87cLG5//SvPItyrI/
   i69GVVUOvgJ0VVr/+H4J3johANcvGoOteTNs2iwroLdbiQDNsVq6m9Qq1
   Qdf+3tEmEgYLHvAcvrgduLlBD7mpiQmGu88ijsjFG25oo2WRG1QQpR7+C
   Q==;
X-CSE-ConnectionGUID: MPFPpQYySGyjzSC0A1Svkg==
X-CSE-MsgGUID: 0/8Xm/nUTT6EzsMZTZoIbw==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="asc'?scan'208";a="17263119"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 01:02:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 01:02:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 01:02:22 -0700
Date: Wed, 6 Mar 2024 08:01:38 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Guo Ren <guoren@kernel.org>
CC: Yangyu Chen <cyy@cyyself.name>, <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
Message-ID: <20240306-scowling-mortify-9b427c80e8ab@wendy>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
 <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
 <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ZekCWx4C9PPAhdA"
Content-Disposition: inline
In-Reply-To: <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>

--2ZekCWx4C9PPAhdA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 07:38:52AM +0800, Guo Ren wrote:

> On Wed, Mar 6, 2024 at 7:04=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wro=
te:
> >
> > Since we have Canaan Kendryte K230 with MMU now. The use of SOC_CANAAN
> > is no longer only referred to K210. Split them and add _K210 suffix
> > to the name for old SOC_CANAAN. And allows ARCH_CANAAN to be selected
> > for other Canaan SoCs.
> >
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > ---
> >  arch/riscv/Kconfig.socs                        | 8 +++++---
> >  arch/riscv/Makefile                            | 2 +-
> >  arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
> >  arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
> >  drivers/clk/Kconfig                            | 4 ++--
> >  drivers/pinctrl/Kconfig                        | 4 ++--
> >  drivers/reset/Kconfig                          | 4 ++--
> >  drivers/soc/Makefile                           | 2 +-
> >  drivers/soc/canaan/Kconfig                     | 4 ++--
> >  9 files changed, 19 insertions(+), 15 deletions(-)

> This patch cross so many subsystems, I am not sure about it. If I were
> you, I would keep SOC_CANAAN and just add SOC_CANAAN_K230.

Right. That is why I didn't try to rename the symbol, and just left it
as SOC_CANAAN, but if the relevant people ack it, the chances of a
significant conflict are low.


--2ZekCWx4C9PPAhdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZegi3gAKCRB4tDGHoIJi
0hUrAPwJw0mn86N4pL5jjPftSxkk1HRIW7D9bLGyzFSPhfqi7gD+O8rzCHK7bdQn
//+uIN+fxPUGG42+2OKOFsoxgvVF3AU=
=bXTQ
-----END PGP SIGNATURE-----

--2ZekCWx4C9PPAhdA--

