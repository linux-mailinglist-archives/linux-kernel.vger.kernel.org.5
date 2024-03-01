Return-Path: <linux-kernel+bounces-88668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA886E509
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92C21F231FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AA6F534;
	Fri,  1 Mar 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pbva1Ex4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E941C7A;
	Fri,  1 Mar 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309413; cv=none; b=jnC3xb1aGJJHHRUh9EaRqYP/abv4+8D+r3HSiFamID3x8E95ssWu6e9CVAWQXo/71dnqhD+Uv0UjgnGkrFrNuNxCZoJlQbAzLwc3snLML/QC5TvAu2FkA+amdlXTqH5IJiLCv/MULxBuUFTnn/ENQc+eLoKp2bS+QwmVwq7dBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309413; c=relaxed/simple;
	bh=ZfWPAHRMQ4AV1/EmBLZZvxi+ZiKHtDAYbU0vxjHvS+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYVRmzOmebzyS4EUjH4tzfU3RlPkSqQQk0wRXrlBdW2inVp/AOt6C8LLO3kmhMdix7EOLdNmXcLfTJBid1eMK/ogaNNrK2bBCRC8WUgaj0QMHdNUEbiHo4uI8D0f2YKlI6+9LpaIBOcqlbco1ArxIcduQmF51gsDC+F/wZYzezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pbva1Ex4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 116C620008;
	Fri,  1 Mar 2024 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709309408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y/1rcI5WNB1I1M/cu+SE5UCu5kGQ0fc3QK9NH0VpIo=;
	b=Pbva1Ex4/Wg84CrwIHwBfQh1USib/V/EEcBXecMJuMXt7tVkm1STF5m+fqMDRtGu/ysDbc
	tuzEbouoCe5W2iDBywLAuOMaj6d+b5hsFyMJW731CcttscM3uXPKcKTy9mEqRTY3c1A8IW
	lswFTLcOod9Cwy9OYwEmmF5m+8iOxd0yAGCKnhXmb/au1eDyHvGisDwsqlvapDFtTeZ0dJ
	drn3E7U7sPKY0VO0jdLiqdzH3oxZ9Dt1M9MQ6D2Da+uz+VvWYNU/hninzYICa9ulnyiWBb
	WabfSaCHltjbwwxg5uQGxRlk3ijBuDGHxv0zhoVN18B63gENMr6BeE1cKCVmPw==
Date: Fri, 1 Mar 2024 17:10:05 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240301171005.43188d02@kmaincent-XPS-13-7390>
In-Reply-To: <ZeHlB8DLEqWxBRYH@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-10-28f0aa48246d@bootlin.com>
	<ZeHlB8DLEqWxBRYH@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleskij,

Thanks you for the review.

On Fri, 1 Mar 2024 15:24:07 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> > -static int of_pse_simple_xlate(struct pse_controller_dev *pcdev,
> > -			       const struct of_phandle_args *pse_spec)
> > +static int of_load_pse_pis(struct pse_controller_dev *pcdev)
> >  {
> > -	if (pse_spec->args[0] >=3D pcdev->nr_lines)
> > -		return -EINVAL;
> > +	struct device_node *np =3D pcdev->dev->of_node;
> > +	struct device_node *node, *pis;
> > +	int ret, i;
> > =20
> > -	return pse_spec->args[0];
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	pcdev->pi =3D kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi),
> > GFP_KERNEL);
> > +	if (!pcdev->pi)
> > +		return -ENOMEM;
> > +
> > +	pis =3D of_get_child_by_name(np, "pse-pis");
> > +	if (!pis) { =20
>=20
> Do we need to allocate pcdev->pi if there are no pse-pis?

In fact it is not needed in this patch but in the patch 13 which use regula=
tor
framework, as the regulator is described on each pi structure.

I will update them accordingly.

> > +		/* Legacy OF description of PSE PIs */
> > +		pcdev->of_legacy =3D true; =20
>=20
> It is not "legacy" :) PoDL do not providing definition of PSE PI since th=
ere
> is only one pair. May be: single_pair, no_pse_pi or any other idea.

You right it is not needed for PoDL. Maybe no_pse_pi is better according to=
 the
following thoughts.

Just wondering, how a pse controller that support PoE and PoDL simultaneous=
ly
would be exposed in the binding. In that case I suppose all the PIs (PoE and
PoDL) need to use the pse-pi subnode. Then the "alternative pinout" and
"polarity" parameter would not be requested for PoDL PIs.

> > +			dev_err(pcdev->dev, "wrong id of pse pi: %u\n",
> > +				id);
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		ret =3D of_property_count_strings(node, "pairset-names");
> > +		if (ret <=3D 0) =20
>=20
> if (ret < 0)
>    error: can't get "pairset-names" property: %pe
> if (ret < 1 || ret > 2)
>    error: wrong number of pairset-names. Should be 1 or 2, got %i

Need to modify this to be able to have PoDL PIs without pairset description.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

