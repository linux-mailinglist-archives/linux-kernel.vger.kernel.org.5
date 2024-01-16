Return-Path: <linux-kernel+bounces-27173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2982EB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C441C22773
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D3212B89;
	Tue, 16 Jan 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IvdmDo/9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B212E42;
	Tue, 16 Jan 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705397484; x=1736933484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+e6Ln558idTWadRn1DXntGL0wDIyCZpJMPP2MxyNkHo=;
  b=IvdmDo/9x2r0RyR0dBmM+vU1fA4M8UhHYFIF5ZGW9Hr/ngzBKvFWaMkK
   v5cojJ5uf8zg0+5a4WXHL2Ju1L2CfPgFl8hrxUSc6hLaeCL3WAh/d9dE/
   i0yKxWvMwp1rYGTzpk8KYBQQ5evfNLpCO41MWzxMs3VQ1BwGRd9zGADHm
   ACbabhXgYI6Eh3dAFTYSdJcs/6vLV3MANX5uCTdkTGw/I5e+MKvrxbMsV
   3vbo8PYtQDtS2dQPW5ALj9KNL3EXZMr+OaqLD3G/Xd1WNiUu3hDLCzFNS
   qoj55trBOXJ2vqaY+kmRfyLP/5q46zJVmF2Dug4Hr2ng2iarUwHpSEHG2
   w==;
X-CSE-ConnectionGUID: WayHWkw8Q7O2gJ+Gskrx3A==
X-CSE-MsgGUID: 0aICPRxpQsWlKp7G71Bc1A==
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="asc'?scan'208";a="15990500"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 02:31:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:31:04 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Jan 2024 02:31:01 -0700
Date: Tue, 16 Jan 2024 09:30:25 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Frank Li <Frank.li@nxp.com>, <robh@kernel.org>,
	<alexandre.belloni@bootlin.com>, <conor.culhane@silvaco.com>,
	<gregkh@linuxfoundation.org>, <imx@lists.linux.dev>, <jirislaby@kernel.org>,
	<joe@perches.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<miquel.raynal@bootlin.com>, <zbigniew.lukwinski@linux.intel.com>,
	<devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <20240116-bleach-herbicide-48d636967134@wendy>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tU9usgt5JDc4MslD"
Content-Disposition: inline
In-Reply-To: <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>

--tU9usgt5JDc4MslD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 03:29, Frank Li wrote:
> >>> 	Patches were accepted after discussion, what you ponit to. So I
> >>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>> 	I plan send next version to fix auto build error. Any additional
> >>> comments about this?
> >>
> >> I still do not see how did you address Rob's comment and his point is
> >> valid. You just did not reply to it.
> >=20
> > See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-=
5810/
>=20
> First of all, that's not the answer to Rob's email, but some other
> thread which is 99% ignored by Rob (unless he has filters for
> "@Rob"...). Therefore no, it does not count as valid answer.
>=20
> Second, explanation does not make sense. There is no argument granting
> you exception from SoC specific compatibles.

The patch could have been applied two months ago had Frank done as
was requested (multiple times). I don't understand the resistance
towards doing so given the process has taken way way longer as a result.

--tU9usgt5JDc4MslD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaZMsQAKCRB4tDGHoIJi
0oXjAQD+n2/ohO6suxsrwD5Ou5eVTuKiCJW4yn6SzYminXj4UQEA5Z7Y5G8MfUrU
u49KfI9asa8Tjp9X2y7YIiNSAtP1Qg0=
=nQni
-----END PGP SIGNATURE-----

--tU9usgt5JDc4MslD--

