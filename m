Return-Path: <linux-kernel+bounces-142437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462D8A2B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF263B23D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B452F61;
	Fri, 12 Apr 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MlsbreRH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238D3A1DE;
	Fri, 12 Apr 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915370; cv=none; b=SgWNKd4lWhF/9IFOafHmrWtfv/y+k9Gn/MNf63i2Jx2V3jRmfhH+++iQV0aTIMjQuoRN25fvOWDl8cfPgEcyNEKI18k+KZWBMXUEJtnaQ6bXasvbZgGv1BrGI0PFRp6GiAOqdPQ4BwLUb26BVbe92IfbkJlhqu/ocmPzU/Fgfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915370; c=relaxed/simple;
	bh=6owmbQFyX2Ns1f9TuwGmcwHTt0ZOyFfydguyhh8Vl7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTzTqJXQ7OTp9JEt40yvbjNrx51zBLcJQ2myfH8o5VVe6wKIEiaSIvbuCARwtRIaq5hYIem/S42m/Zn+nNAZgIuD7UQO4QPv2GJbZPHQirZAGmCX2zTM1aYEdVClmCt8Rv4tddAzMR3GrHd0E9UKhgAEUzvny8yOIVRMK//6pDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MlsbreRH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712915368; x=1744451368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6owmbQFyX2Ns1f9TuwGmcwHTt0ZOyFfydguyhh8Vl7U=;
  b=MlsbreRHcmTInJvfw7m9oyvf/oE+jdJUK0/tBhurAjNmUIcEx5GjnMPW
   Q/h5TtbhJXoLiSQpkDldGysxcWcVZNc0hI2CAaPpxKGvi2qZNr0HkXLko
   5bIa5P+2A2E3a4By9l82X6mfE+fDJPGkT5yoxwmlRlnGjLMPAMiT1maGO
   sjPxiRG5gr19QyFBmdhlvHnzpBOjki9nBstfX3YmvRrjlN/oSV9fmnCmn
   K7KoTnXQ4NaME30qaDXkBvGAdOybF1uPHkuFM7E6wJlPOh0EcXaQHmyer
   GoC3WmfWuwuJTyiLxNLX7xrVR0EPLko0n10eG5jJwR6FENULp7Xf5c56G
   g==;
X-CSE-ConnectionGUID: CriWT839Tiya/FLJiLrKhg==
X-CSE-MsgGUID: W2UCeI60TdOdUEqyUVu4cg==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20722576"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 02:49:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:48:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 02:48:27 -0700
Date: Fri, 12 Apr 2024 10:47:36 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: <wefu@redhat.com>
CC: <jszhang@kernel.org>, <alexandre.belloni@bootlin.com>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<guoren@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 4/5] Kconfig: Enable APM X-Gene RTC for XuanTie TH1520
Message-ID: <20240412-ogle-daily-c18bc6e7ddd5@wendy>
References: <20240412080238.134191-1-wefu@redhat.com>
 <20240412080238.134191-5-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rrezwGm8P4r68fCr"
Content-Disposition: inline
In-Reply-To: <20240412080238.134191-5-wefu@redhat.com>

--rrezwGm8P4r68fCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 04:01:46PM +0800, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
>=20
> This patch enables APM X-Gene RTC for XuanTie TH1520.
>=20
> Signed-off-by: Wei Fu <wefu@redhat.com>
> ---
>  drivers/rtc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3a89f1e6095d..b219aeef4ce9 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1880,7 +1880,7 @@ config RTC_DRV_MT7622
>  config RTC_DRV_XGENE
>  	tristate "APM X-Gene RTC"
>  	depends on HAS_IOMEM
> -	depends on ARCH_XGENE || COMPILE_TEST
> +	depends on ARCH_XGENE || ARCH_THEAD || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for the APM X-Gene SoC real time
>  	  clock.

If I was configuring my system by reading menuconfig, I would have
absolutely no idea that this driver supports platforms other than the
X-Gene one. I think the Kconfig stuff for this likely needs an update to
convey that it's no longer just one SoC family that's supported here.

--rrezwGm8P4r68fCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkDOAAKCRB4tDGHoIJi
0mNyAP9KxQ4U9S5RMOVtCU2/kCBefOY/cpPKf8icvcFiSV8+zQEAtUzy/SD4CsMb
eHL+pw8s6mfIChq7hPkxKZlv8QtVrgk=
=nx9k
-----END PGP SIGNATURE-----

--rrezwGm8P4r68fCr--

