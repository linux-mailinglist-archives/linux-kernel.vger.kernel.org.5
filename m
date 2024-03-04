Return-Path: <linux-kernel+bounces-90419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3686FEDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315B2B24174
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2735894;
	Mon,  4 Mar 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vshu1amp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9C2574F;
	Mon,  4 Mar 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547596; cv=none; b=W3fjcLsQHId5tCY74vS9aFWq/UxSI7jH0W1Rm/LhhSeSOeqDck2eFhPPNtyTX7bGwzY76dxBfAwoAjtm+alLAMlC4AMZKzNj7EVxgkdIpSKTh4O6PlFeX1xKZniWDNv1ZxqN+GA1ioEV26TNsJvddY946M3t+2DnHu6HDrLiqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547596; c=relaxed/simple;
	bh=oAwVOvhNSYIJcvi3KYz9lODQVXjEBbjFSOCNDTXHkGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/GKxd+5BlGqmJ7xoAZE/BisF8EI2MDesMY3sxvlKYq+H53se571voHbuouyT5fNBPnmLKe5Yywv9PQAxO9vpuAFnmZTY2GL4IUrBeyDr7uxDJ/g38VC0PVJutpUJZ7V0QXq05Kugje+VZaHyVqYvJQ9FXMDCNerv2PhXlaeYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vshu1amp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709547594; x=1741083594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAwVOvhNSYIJcvi3KYz9lODQVXjEBbjFSOCNDTXHkGU=;
  b=Vshu1ampPiqd+WHO3renK91BhvwSJfSxsz8kYUpG//zOWSqmjeL367A4
   xHsaPSRGyF9KMMCKFbF5a5qpToHYwAfk5O6oRHotPapa98GaKnMJNLX3W
   81ZyGFpOjCwIxd5tNoSgPh5qHRoHqmOVFR1A8NTuajd5u9i4hlKJuRdEr
   A7++Jhy0yKosGnIkoSvevP1t2hd1ExipqbHbgcl0wgRW3dl07iDzBtgcQ
   xZPZ5fi911h/uaI1JU5HcfhF88CXS8xZeZHDcZKXyYd4EAKx53YZbGwvd
   iRK4RlT16fFxXOvKR4R7DD9doStSZvZKckK6iAH7FD1AxB2OPMeIWtopN
   w==;
X-CSE-ConnectionGUID: GTh8GKPTQM2QJHexAl2qug==
X-CSE-MsgGUID: qt1xL4hmQbGjG2oZQGGyKQ==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="asc'?scan'208";a="17693872"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 03:19:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 03:19:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 03:19:34 -0700
Date: Mon, 4 Mar 2024 10:18:50 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
Message-ID: <20240304-henna-verbalize-c206ba771a9e@wendy>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_4F1B21F8A605B7B4091DBB70B5635442BE09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jHXxCXVHqhS+kbK3"
Content-Disposition: inline
In-Reply-To: <tencent_4F1B21F8A605B7B4091DBB70B5635442BE09@qq.com>

--jHXxCXVHqhS+kbK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2024 at 09:26:25PM +0800, Yangyu Chen wrote:
> Since K230 was released, SOC_CANAAN is no longer only referred to the K21=
0.
> Remove it depends on !MMU will allow building dts for K230 and remove the
> K210 string from the help message.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/Kconfig.socs | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 623de5f8a208..b4e9b7f75510 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>  	def_bool SOC_CANAAN
> =20
>  config SOC_CANAAN
> -	bool "Canaan Kendryte K210 SoC"
> -	depends on !MMU
> +	bool "Canaan Kendryte SoC"
>  	select CLINT_TIMER if RISCV_M_MODE
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select PINCTRL
>  	select COMMON_CLK
>  	help
> -	  This enables support for Canaan Kendryte K210 SoC platform hardware.
> +	  This enables support for Canaan Kendryte SoC platform hardware.
> =20
>  endmenu # "SoC selection"
> --=20
> 2.43.0
>=20

--jHXxCXVHqhS+kbK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeWgCgAKCRB4tDGHoIJi
0vUCAQD0CoV1uSDQ7JiawSnX85ZEZiRg4TPZmr77Rl0SGLt59QD/f9B6sx7gnPhW
rqAFj5vm3UQ/ZofMS/3ltXvO8/WkNA4=
=vnEB
-----END PGP SIGNATURE-----

--jHXxCXVHqhS+kbK3--

