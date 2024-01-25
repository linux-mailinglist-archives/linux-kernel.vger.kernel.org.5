Return-Path: <linux-kernel+bounces-38176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D883BBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FA2B21820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7474179AB;
	Thu, 25 Jan 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t5h14y6l"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8445175B4;
	Thu, 25 Jan 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171322; cv=none; b=YQkwZsXZKoF7xwGrWqR6ApF/N6CLldorKyK556qbFOg/j7EntcRXPw7UKCJmuysNzSwPSzZbsRELWxYC14p2aNnEaMW3nrCacG9q9YRzE2qUCgmCXjIPiB0abZcyDStYKw3EcmmdJN6G9St2ZJyIE5nFbl9qey6KWPHvz4BB8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171322; c=relaxed/simple;
	bh=0o18t8f3/iC5wQSPwN+S8bs8VJQ/VDGiBZsmcwU/bDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guWQ21QytdC0/xR0H3QoIQ+6YjmEVKZcPF5D1f1e+c3vjqjYlVxhDi+mX8ORMIJMd+YS4LGInnfjvsmjexndOVGmEaBikfoQINOKvNd9sVR/yD7dIYnwE2eRjrC5T5ivwFgDHmyxFYnru0F4zqJO50L4eMtc+45O1PdbKBQRVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t5h14y6l; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706171320; x=1737707320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0o18t8f3/iC5wQSPwN+S8bs8VJQ/VDGiBZsmcwU/bDw=;
  b=t5h14y6lHFOYRbzFgZXIcxelOhEUWdmsz/gfdVmr8gnEk6MKHcwwP5aL
   dEFbwGz00l2O6jzVEyUsb12wsSImVS06oSCWEu2erARSUFxSux8yFllZv
   htrkJG0eFuU1iC887mXWI+m6hL1GOL+HSVn7FR02GVtffm8ruthlqf08Z
   onxDTDQTcHci/+5Q/bjkoIXkSwaPLJxPKtz8R2TGZDeqi2R5a4eru9Jsp
   L6IrIClV2CPVg3RToiy8C/1/hoSYR7gGia8wanS+i7IRCAtK6PoKzuv2Z
   FX39Q6W4wyXywj81Irr/FamKyQ0fx3QTKhh2GCGxgrllPLIkPwqEAgdNe
   w==;
X-CSE-ConnectionGUID: yWKH6XeGSSC8CBa5MkUWWA==
X-CSE-MsgGUID: /2Vw4AgiQCK4jHQhEACeAA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="15276256"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 01:28:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:28:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jan 2024 01:28:32 -0700
Date: Thu, 25 Jan 2024 08:27:55 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: <Dharma.B@microchip.com>
CC: <conor@kernel.org>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
	<Linux4Microchip@microchip.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240125-proved-passage-7fa128f828db@wendy>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-4-dharma.b@microchip.com>
 <20240118-recent-glorified-fd35d72e006e@spud>
 <c33868c8-dc42-4800-885c-5e5f24c2044e@microchip.com>
 <20240119-character-mardi-43571d7fe7d5@wendy>
 <da60f9f3-f955-4a87-a020-5710185953c0@microchip.com>
 <20240122-stark-duress-2f59294dcf27@spud>
 <4906b7e2-0ddb-4d3c-a48b-e16278f2d649@microchip.com>
 <20240124-lend-emerald-1028fe65cc39@spud>
 <c3c30bf2-e7c2-4861-bfdf-519a7afde476@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KV2dTBGvLz55uW11"
Content-Disposition: inline
In-Reply-To: <c3c30bf2-e7c2-4861-bfdf-519a7afde476@microchip.com>

--KV2dTBGvLz55uW11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > If the lvds pll is an input to the hlcdc, you need to add it here.
> >  From your description earlier it does sound like it is an input to
> > the hlcdc, but now you are claiming that it is not.
>=20
> The LVDS PLL serves as an input to both the LCDC and LVDSC

Then it should be an input to both the LCDC and LVDSC in the devicetree.

> with the=20
> LVDS_PLL multiplied by 7 for the Pixel clock to the LVDS PHY, and=20

Are you sure? The diagram doesn't show a multiplier, the 7x comment
there seems to be showing relations?

> LVDS_PLL divided by 7 for the Pixel clock to the LCDC.

> I am inclined to believe that appropriately configuring and enabling it=
=20
> in the LVDS driver would be the appropriate course of action.

We're talking about bindings here, not drivers, but I would imagine that
if two peripherals are using the same clock then both of them should be
getting a reference to and enabling that clock so that the clock
framework can correctly track the users.

> > I don't know your hardware, so I have no idea which of the two is
> > correct, but it sounds like the former. Without digging into how this
> > works my assumption about the hardware here looks like is that the lvds
> > controller is a clock provider,
>=20
> It's a PLL clock from PMC.
>=20
> > and that the lvds controller's clock is
> > an optional input for the hlcdc.
>=20
> Again it's a PLL clock from PMC.
>=20
> Please refer Section 39.3=20
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductD=
ocuments/DataSheets/SAM9X7-Series-Data-Sheet-DS60001813.pdf

It is not the same exact clock as you pointed out above though, so the
by 7 divider should be modelled.

> > Can you please explain what provides the lvds pll clock and show an
> > example of how you think the devictree would look with "the lvds pll in
> > the lvds dt node"?
>=20
> Sure, Please see the below example
>=20
> The typical lvds node will look like
>=20
>                  lvds_controller: lvds-controller@f8060000 {
>                          compatible =3D "microchip,sam9x7-lvds";
>                          reg =3D <0xf8060000 0x100>;
>                          interrupts =3D <56 IRQ_TYPE_LEVEL_HIGH 0>;
>                          clocks =3D <&pmc PMC_TYPE_PERIPHERAL 56>, <&pmc=
=20
> PMC_TYPE_CORE PMC_LVDSPLL>;
>                          clock-names =3D "pclk", "lvds_pll_clk";
>                          status =3D "disabled";
>                  };

In isolation, this looks fine.

Cheers,
Conor.

--KV2dTBGvLz55uW11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbIbiwAKCRB4tDGHoIJi
0h+8AQCpYI71+drl2FDrbEGThmMOFS/iz1jS+CPJczvYePVUqwD/ZilClwywAcjj
BSSdZJ4KLwpHGZIe4dxZJbifZWhXPAY=
=rMTy
-----END PGP SIGNATURE-----

--KV2dTBGvLz55uW11--

