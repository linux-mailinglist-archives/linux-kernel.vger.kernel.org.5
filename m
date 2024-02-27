Return-Path: <linux-kernel+bounces-83146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682C868F77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3160D2835AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AB13A250;
	Tue, 27 Feb 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZTsDYbfT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C311386D4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034790; cv=none; b=r46mJv02Idr2n8UoFHoK/EeL4OwN9RBw1ni2rQ/H46V2nTYrbVIyIH6AH5IPHRp2rRfWene9EBWVWBntyyOubggcbmLcG2HlCG20gNsjteJroxZNC4gTfowNNT6AQD64dfx167m3mT/K9b8ZAK0yOtxLZ6pwz/qMK2UqCX1FFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034790; c=relaxed/simple;
	bh=QpM2Gj+iE1842oLmR/JSz14T461jLNYwC4WotBRHz8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4a4qcQGk0jv+VM57MUXo8TIoAmGlGZ2ogKD9davfpzSA+Z5IiV87U6Ro+Rx2Rx3uvHKBdmHeVdto/AiDFT5H6IV295aFPCk4bOWnB+qZ6no0GBGCypYwzqLyWjEBpomjtUwjgNNRhf5k4ub+7L5/XVeadfv+9DWYcgYC/4JlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZTsDYbfT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709034789; x=1740570789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QpM2Gj+iE1842oLmR/JSz14T461jLNYwC4WotBRHz8w=;
  b=ZTsDYbfTO+AsrHOaIejSbOlZ+tDEZ2deusk0O/Ki7tO9jD9Rw0BD70E0
   t/bk1b5SLcdLbDIAnv9gYef5+ZIXyfU+9qVU+UkIMk0LJH5NhPFf8U5Jt
   FvbDZVokMfyy0Tqm1jKgbj437fWHhALRzGshyZItrJwy8ByUZr7g8Zena
   oRjT62sMwEfEl2P6tYIsGFNuRGnmCMydRN5ojRbAQFtWFcEJA9SSNgzfP
   ccTsu3RETNefv/NzRJ+7jV7+p7SjifDnlOsWACm8U3dQQA93CtdL/6Eot
   kvVHjsbdnlMwunlgjFWE+AJkOE8HEM8/wH4jz6ac5Tf8Tm9rspw9dOZ5a
   w==;
X-CSE-ConnectionGUID: OPUfXbZxS9CqWDIW5F1xSQ==
X-CSE-MsgGUID: RWzb322QQCeBS6neIPwO3w==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="16885482"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 04:53:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:52:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:52:41 -0700
Date: Tue, 27 Feb 2024 11:51:58 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] riscv: Remove MMU dependency from Zbb and Zicboz
Message-ID: <20240227-bonehead-stonework-d56052265b35@wendy>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MVkIfoCLD1B37PLh"
Content-Disposition: inline
In-Reply-To: <20240227003630.3634533-4-samuel.holland@sifive.com>

--MVkIfoCLD1B37PLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 04:34:48PM -0800, Samuel Holland wrote:
> The Zbb and Zicboz ISA extensions have no dependency on an MMU and are
> equally useful on NOMMU kernels.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
>  arch/riscv/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..ef53c00470d6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -581,7 +581,6 @@ config TOOLCHAIN_HAS_ZBB
>  config RISCV_ISA_ZBB
>  	bool "Zbb extension support for bit manipulation instructions"
>  	depends on TOOLCHAIN_HAS_ZBB
> -	depends on MMU
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> @@ -613,7 +612,6 @@ config RISCV_ISA_ZICBOM
> =20
>  config RISCV_ISA_ZICBOZ
>  	bool "Zicboz extension support for faster zeroing of memory"
> -	depends on MMU
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> --=20
> 2.43.0
>=20

--MVkIfoCLD1B37PLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3M3gAKCRB4tDGHoIJi
0iVOAP4xnKemNhs85COxEne/mehKUX1aV+ACJN779DXpaUB2ywD+KRmu/SwerYwl
Ooozck02olX3pPxzIw9S73glhdreTA4=
=1ooj
-----END PGP SIGNATURE-----

--MVkIfoCLD1B37PLh--

