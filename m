Return-Path: <linux-kernel+bounces-30906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7E8325C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB571F232DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BE61E497;
	Fri, 19 Jan 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kip935Gy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D632CA7;
	Fri, 19 Jan 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653148; cv=none; b=LEZCV4VHzNSb8rkDX/dq95yZCczlr6p8uqqOtDRtWlGspwVYRQv0K3YfFgAZ0hnYsB52wym2Oc0BbS2qsmae6u12qJ+TgNUgjK/IB7MlgeA/cImLJc7ZbqstbU1FmSDoxlfam9n5ei2284pR9IQ0kclnWlQffE3HgmBtZTZPX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653148; c=relaxed/simple;
	bh=B5EZST53kdv1abDam+dx9qrQWlq0k0yCCk7H82NH+Ow=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR94M4iomufghXPTXXmVE9G+R8RbWLo9bIb8oRm/NVKFA/dFWyst2TnFpIEn4X+g6S5jj4XEbY/2pQjMBdyXssoHzPv5uCYWcMMC1OnQvwZhJt0A1jSgcXPhL/gScJojLK0jf5S2aKsFr+9pquT1pzuutAWm33aKOWxnSgczBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kip935Gy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705653146; x=1737189146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5EZST53kdv1abDam+dx9qrQWlq0k0yCCk7H82NH+Ow=;
  b=Kip935Gy72IezI6pzq6yDXAdW+ZWQjuBElVnsQetK8EtTpXeMBNeuVwh
   M4qtKIK9KdrHgVkXJJ9rgbw6q9POTgoEDb5MFhBSw1PH3u4z/PsteE2YV
   SSdfhBvrOgrrOX7to/KVTPVI7stnAgwlVL5PuTwUQdu9FRXZ/QnU3kSpO
   +GZLG1fyyoHEN62MWAwglf1jPiEwMTMkMfNJaUzOa0H3bHmiDVJxlDxct
   bYS31fbYZ9OPB8dD/cp1V1wFSRMErNzWXfvXhXu8bXbFpy3+7StvacxiR
   i7Hi6jrIm4PBs4qmk/+T4oCkCuxk+RMrdVEnA+RV9t895HL49fYuizgn/
   Q==;
X-CSE-ConnectionGUID: FsUBvfRcQ/m00ADIAbdE4Q==
X-CSE-MsgGUID: fLNLkafhTbKnyfpWrMpurQ==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="asc'?scan'208";a="16207405"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 01:32:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:32:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jan 2024 01:32:21 -0700
Date: Fri, 19 Jan 2024 08:31:28 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Conor Dooley
	<conor@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240119-squad-unflawed-934627f0e394@wendy>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
 <20240118085856.70758-2-kimseer.paller@analog.com>
 <20240118-steadily-coauthor-de8275118901@spud>
 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
 <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TvBkcpPOR1z02xqE"
Content-Disposition: inline
In-Reply-To: <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>

--TvBkcpPOR1z02xqE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 09:20:01AM +0100, Nuno S=E1 wrote:
> Hi Kim,
>=20
> On Fri, 2024-01-19 at 00:30 +0000, Paller, Kim Seer wrote:
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Friday, January 19, 2024 12:10 AM
> > > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Lars-Pet=
er
> > > Clausen <lars@metafoo.de>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Rob Herring <robh+dt@kernel.org>;
> > > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Crt Mori <cmo@melexis.com>; Linus Walleij
> > > <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> > > Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
> > >=20
> > > [External]
> > >=20
> > > Hey,
> > >=20
> > > On Thu, Jan 18, 2024 at 04:58:55PM +0800, Kim Seer Paller wrote:
> > > > Dual microwave down converter module with input RF and LO frequency
> > > > ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1=
 to
> > > > 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> > > > for each down conversion path.
> > > >=20
> > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > > ---
> > > > V5 -> V6: Moved array of switch and attenuation GPIOs to the channe=
l node.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 Changed pin coords with friendly names.=
 Removed Reviewed-by tag.
> > > > V4 -> V5: Added Reviewed-by tag.
> > > > V3 -> V4: Updated the description of the properties with multiple e=
ntries and
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 defined the order.
> > > > V2 -> V3: Adjusted indentation to resolve wrong indentation warning.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 Changed node name to converter. Updated=
 the descriptions to clarify
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 the properties.
> > > > V1 -> V2: Removed '|' after description. Specified the pins connect=
ed to
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 the GPIOs. Added additionalProperties: =
false. Changed node name to
> > > gpio.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 Aligned < syntax with the previous synt=
ax in the examples.
> > > >=20
> > > > =A0.../bindings/iio/frequency/adi,admfm2000.yaml | 129 ++++++++++++=
++++++
> > > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +
> > > > =A02 files changed, 136 insertions(+)
> > > > =A0create mode 100644
> > > Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > >=20
> > > > diff --git
> > > a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > > new file mode 100644
> > > > index 000000000000..6f2c91c38666
> > > > --- /dev/null
> > > > +++
> > > b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> > > > @@ -0,0 +1,129 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2023 Analog Devices Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yam=
l#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: ADMFM2000 Dual Microwave Down Converter
> > > > +
> > > > +maintainers:
> > > > +=A0 - Kim Seer Paller <kimseer.paller@analog.com>
> > > > +
> > > > +description:
> > > > +=A0 Dual microwave down converter module with input RF and LO freq=
uency
> > > ranges
> > > > +=A0 from 0.5 to 32 GHz and an output IF frequency range from 0.1 t=
o 8 GHz.
> > > > +=A0 It consists of a LNA, mixer, IF filter, DSA, and IF amplifier =
for each down
> > > > +=A0 conversion path.
> > > > +
> > > > +properties:
> > > > +=A0 compatible:
> > > > +=A0=A0=A0 enum:
> > > > +=A0=A0=A0=A0=A0 - adi,admfm2000
> > > > +
> > > > +=A0 '#address-cells':
> > > > +=A0=A0=A0 const: 1
> > > > +
> > > > +=A0 '#size-cells':
> > > > +=A0=A0=A0 const: 0
> > > > +
> > > > +patternProperties:
> > > > +=A0 "^channel@[0-1]$":
> > > > +=A0=A0=A0 type: object
> > > > +=A0=A0=A0 description: Represents a channel of the device.
> > > > +
> > > > +=A0=A0=A0 additionalProperties: false
> > > > +
> > > > +=A0=A0=A0 properties:
> > > > +=A0=A0=A0=A0=A0 reg:
> > > > +=A0=A0=A0=A0=A0=A0=A0 description:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 The channel number.
> > > > +=A0=A0=A0=A0=A0=A0=A0 minimum: 0
> > > > +=A0=A0=A0=A0=A0=A0=A0 maximum: 1
> > > > +
> > > > +=A0=A0=A0=A0=A0 adi,mode:
> > > > +=A0=A0=A0=A0=A0=A0=A0 description:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 RF path selected for the channel.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 - Direct IF mode
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 - Mixer mode
> > > > +=A0=A0=A0=A0=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > > +=A0=A0=A0=A0=A0=A0=A0 enum: [0, 1]
> > >=20
> > > How come this is an enum, rather than a boolean property such as
> > > "adi,mixer-mode"?
> >=20
> > I used an enum, perhaps because it was easier to implement. However, th=
is
> > could be changed if a boolean property might be more suitable in this c=
ase.
> > Is that the preferred option?
> >=20
>=20
> Hmmm, How is the enum easier than a boolean property :)? I guess the devi=
ce has a
> default mode. So, if it is Direct IF mode you have 'adi,mixer-mode' to en=
able that
> mode and that's it. So the code is pretty much just:
>=20
> if (device_property_read_bool()) {

device_property_present() is preferred I think.

> 	/* enable mixer mode */
> }
>=20
> Also remember that from a bindings point of view being easier to implemen=
t or not in
> the driver does not matter much. Take for an example, properties with wel=
l know units
> like 'microamp'. It would be much easier to just have an enum with the de=
vice
> register values but that's not how we should do it since it wouldn't be i=
ntuitive at
> all for people reading devicetrees.
>=20
> - Nuno S=E1
>=20

--TvBkcpPOR1z02xqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaozYAAKCRB4tDGHoIJi
0pavAPoCJxw0q0VL+DDLV0NYkjNzXod1GC2lFDHLMpKrRKWX+wEAgIJpzCS0HH5X
05uzZuJptrminBMC61fwPGckHGVTJAs=
=Pwxk
-----END PGP SIGNATURE-----

--TvBkcpPOR1z02xqE--

