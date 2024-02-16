Return-Path: <linux-kernel+bounces-68336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E38578EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6881C225C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2F1B974;
	Fri, 16 Feb 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cjjn3E9n"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AB1B946;
	Fri, 16 Feb 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076194; cv=none; b=S48KUKGdPHBPKlyZIcW7rFq1cYLKkYbMAOzsL9Aq/tie3SrNga+Xb1efaQ0MVPTyYz1XE/1v7b40PpmiX9ZshCTmbKXD9Ei+Nmvq/wxkoftNxxI3rQEfpXvQ2t7lRtO87AMIP0R9XlCpCo+my8eIE3GESX9NNK0bvh8tMcmGpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076194; c=relaxed/simple;
	bh=tr1J8WOC+2p8ubr8+eCJujXILeG2ySFEIqEf0ShF1JM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJBS1FO5qgn57P0gVv1PH9q3+rziXFLVzEGp1Vz31qZ92VNmiD6dth+67+jD9SRDaTRSSPFSVLJYSomkVLO2EvdvewdZIG22en8jQfLg0DgYZviCz/rZe7XT6VJ/ZYRqRM/+jMgZKooz3emE8R2WWpoPB1f2xrAC9FeUrrPscK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cjjn3E9n; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708076192; x=1739612192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tr1J8WOC+2p8ubr8+eCJujXILeG2ySFEIqEf0ShF1JM=;
  b=cjjn3E9nRtPtgddcQqH2g67on38hasd6kobIkUrmn4w2kUB81q9+KLLX
   9A4JGawIXL08hZQTNENIf9VhPceuJoztIYcXN2OfQOeL2LwvWwTwTYZPO
   8gv6seVRkJ7IJgL+cJ31/77I0NzYLfrx2D1os6Zn+BLlMQTBTnJSfRitR
   pq9uBtIw2ZL7ZNVV2a8QHuK8PT6lYKFPL2GxqrqFXIxhILdcGna2aBe6x
   MixkQH9q/IeNbBR9gMY3P4/AmCPPEPSvAmDfCGRKbItqbmZe2JEXHZfDQ
   8GagMkHtWEjGuGC0lG6tQg73g84qwEI+/ICrlyIfP80Mc+rKABN8evS9v
   w==;
X-CSE-ConnectionGUID: pJWeZjTqROyJuezpZWgBKQ==
X-CSE-MsgGUID: UNF4OwJ9RUK/tyZzz1Kpmw==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="247085294"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 02:36:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 02:36:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 02:36:22 -0700
Date: Fri, 16 Feb 2024 09:35:42 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<Mihai.Sain@microchip.com>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <andre.przywara@arm.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Message-ID: <20240216-eleven-exposure-dde558e63aaf@wendy>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
 <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240216075609e58aeee4@mail.local>
 <cfafd563-1387-4775-bcb0-434ce3774827@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sduO+pYooNnUEhXl"
Content-Disposition: inline
In-Reply-To: <cfafd563-1387-4775-bcb0-434ce3774827@tuxon.dev>

--sduO+pYooNnUEhXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:24:13AM +0200, claudiu beznea wrote:
> On 16.02.2024 09:56, Alexandre Belloni wrote:
> > On 16/02/2024 06:58:10+0000, Mihai.Sain@microchip.com wrote:
> >>> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot=
/dts/microchip/sama7g5.dtsi
> >>> index 269e0a3ca269..c030b318985a 100644
> >>> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> >>> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> >>> @@ -958,6 +958,30 @@ i2c9: i2c@600 {
> >>>  			};
> >>>  		};
> >>> =20
> >>> +		flx10: flexcom@e2820000 {
> >>> +			compatible =3D "atmel,sama5d2-flexcom";
> >>
> >> My comment here was ignored:
> >> https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spud/
> >>
> >> The SAMA7G5 has the same flexcom controller as SAMA5D2 MPU.
> >>
> >=20
> > Still, it needs its own compatible plus a fallback to
> > atmel,sama5d2-flexcom
>=20
> I agree with this. Though, flexcom documentation is subject to YAML
> conversion (a patch has been re-posted these days [1] and *maybe* it will
> be integrated this time). And there are multiple SoC DTs that need to be
> updated with their own flexcom compatible (lan966x, sam9x60, sama7g5).
>=20
> To avoid conflicting with the work at [1] and postponing this series we m=
ay
> do the update after the [1] is done.
>=20
> Let me know your thoughts. Either way is fine by me.

I'd be inclined to say that if we are gonna take a shortcut here, then
this patch should add a specific compatible so that when the yaml
conversion goes through you'll get a warning about this being
undocumented rather than silence.

A resend on the flexcom patch is required though, the rebase was not
done correctly, so maybe Balakrishnan could "atmel,sama7g5-flexcom"
add with a fallback to "atmel,sama5d2-flexcom" while they're fixing
it up?

Cheers,
Conor.

--sduO+pYooNnUEhXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc8sbgAKCRB4tDGHoIJi
0vQ+AP4oW1fosffEhtquR/gVVNyOSQhkI7iXCEoFlMivSaXXeAD/ZK1WNHbDzFWQ
IbUslS4h6+t6778C+cxayxDTTfVIpAk=
=nBtH
-----END PGP SIGNATURE-----

--sduO+pYooNnUEhXl--

