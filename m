Return-Path: <linux-kernel+bounces-68544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A599D857C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408FEB22DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118F677F3E;
	Fri, 16 Feb 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="epNhjbBq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C477F25;
	Fri, 16 Feb 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084130; cv=none; b=X4CPs/PdleSeqLFOuJcdzZOp63CNejn9NlTAt7PgXlz0/LSlgXUAT7kn9Sf+g7+kA2SPcJsazoDP7oEAqwb/07vAY4cqsd/9iMx39y05tUtIhMwGk89DJM+py4F+lBI0P1BeUBTLYAgizKONb1rBh59gBONUSFrD6WOHW9Q7bmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084130; c=relaxed/simple;
	bh=HE05TzfEZrrnkB1kCqRHu3E2zaW9wifB6ce770hI6X0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osEmE2mnEd6Sf65REkDRbeAVk+6N8EMKD4FDl3BQuGL5n2z27mW9e1P0d19tkk9xjP1reMfNFWJssru8kpLpca1j6OiIH9gtzDtmvun4wo0V/QC85QlLBFa4ozdUv1HB9P5RBszEmBe4KOzZkIen0AGibxXhSBD+iNW1XbGCnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=epNhjbBq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708084128; x=1739620128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HE05TzfEZrrnkB1kCqRHu3E2zaW9wifB6ce770hI6X0=;
  b=epNhjbBqNacbiyJhFpONhtBep+TKPBabb4q6JW/ZW88iWvu6k01c/Gjt
   FP0nXs+G0B0ceDgP0OCZGfNb2+PJW3rdWB1idONVfcQWN9isllIO8WeIi
   ApywNfkTRYBj0w+MS81Uf3Q96QgO4ysJChoDEPk8lVkAYQmvP/Ii9ZSKI
   yT3Zl+R04L7YCEkEaF/S4MfjV59vzRbgeUm3Q4LDOvTPh/VyUY3U31u+z
   SduwDCruFgfjBP3tTNtNX2ZRoeqs699laUA3h+ZDp4nYqprGJHhLxWkoG
   4LOla7tT4gjWIICB6Pu+89S5+o/Rqm56WR7f+FZ9t6rl6Hg2d3SlK48NV
   g==;
X-CSE-ConnectionGUID: nS8tL4sATTW93mVbDhuZ3A==
X-CSE-MsgGUID: Hq4gR43pRG+wXwups3OzJg==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="16350556"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 04:48:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 04:48:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 04:48:22 -0700
Date: Fri, 16 Feb 2024 11:47:41 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <linux-kernel@vger.kernel.org>, <m.nirmaladevi@ltts.com>,
	<lee@kernel.org>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <jpanis@baylibre.com>, <devicetree@vger.kernel.org>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <linus.walleij@linaro.org>,
	<linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240216-prefix-shortly-74105965f88c@wendy>
References: <20240208105343.1212902-1-bhargav.r@ltts.com>
 <20240208105343.1212902-4-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VzoHkGA7xItmTx7o"
Content-Disposition: inline
In-Reply-To: <20240208105343.1212902-4-bhargav.r@ltts.com>

--VzoHkGA7xItmTx7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
> TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> regulators, it includes additional features like GPIOs, watchdog, ESMs
> (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
> managing the state of the device.

> TPS6594 and TPS65224 have significant functional overlap.

With this updated to mention what makes the devices incompatible,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti,tps6594.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Docu=
mentation/devicetree/bindings/mfd/ti,tps6594.yaml
> index 9d43376be..6341b6070 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> @@ -21,6 +21,7 @@ properties:
>        - ti,lp8764-q1
>        - ti,tps6593-q1
>        - ti,tps6594-q1
> +      - ti,tps65224-q1
> =20
>    reg:
>      description: I2C slave address or SPI chip select number.
> --=20
> 2.25.1
>=20

--VzoHkGA7xItmTx7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc9LXQAKCRB4tDGHoIJi
0gLwAP0VEothXhBbZPq6Lg9NhxeXussiysjuJZ138upAnwBeOwD8CI11Vp1f9UzS
yJrlB7cKzuzMABMhh+vG9b3ZqaZJRAE=
=frNM
-----END PGP SIGNATURE-----

--VzoHkGA7xItmTx7o--

