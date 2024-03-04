Return-Path: <linux-kernel+bounces-90328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08486FDAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049CE28317C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2539AE9;
	Mon,  4 Mar 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TtzfGG8V"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B55249FC;
	Mon,  4 Mar 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544444; cv=none; b=JckD8HGOSIg8pDi5ZBrbnpI9fQNOAzhYzzhw/LJHKNptoNYdzrASjmg2aPzM2ZKm6/H1kLcZr2Fll184i3z26IDCYQxunqOYcHDO9krjIQEKzhIk/exdy6XCHKUHSPhg4yAwqacF6U+XuyhTFiDXOsGD+oRHxQQLdIpxkQFysiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544444; c=relaxed/simple;
	bh=qhFdqSydGSsppwd8DaxhNL3l1o72Wmw7l9pkEKo/Koc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjMPBMNrpFRp1xMAm5Dt6xFghtPmEjxNq37uli9C/rVrXtCfXtiQi5AXtkwDD1jcLvq3XV8UJ8VmB+lI/uANWiEHskD9rvs2vZQm6JaA2XBZeAy39ncUqI514OMPfmIRuX2PZlS0H8aYr38iScbbsJ/8JNg2U5l9q9lzJaMpFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TtzfGG8V; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E437FF809;
	Mon,  4 Mar 2024 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709544433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wolDcJ6Q1CiVR4J5B28NP8D0LpJaueSBID98he3qx1c=;
	b=TtzfGG8VxWH+WRUXrSiNp7K0+o+Jqpvf1s8NzHlDVWHY74G8Qo/nbyOtiyoyiytLdI0cFQ
	pmY6ddcDPsvvsUhKv+4wnqzzoweEgr5Z1KRTRv33dOxG4LsU67FefXMgIEBVI2meEVvVHj
	OD7jsxY5oZfb5szZ4waK7VUSCEOrtSsTkCUpsuk2/Ryz+m22awQXYLVU9moYH2pq17QGyp
	CMaFHDpfJO7uQholWmNfS6Mixf+9LzEOUApEwfFfq3/upoV1cdHPMcY2T8yXD2XdTvh/FZ
	pZjjBbitSPAdM8YZm86tDfUjZ6En1qLNcLfpQqu0ZPspWsZvXGu70yw6rzVGxA==
Date: Mon, 4 Mar 2024 10:27:08 +0100
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
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
In-Reply-To: <ZeObuKHkPN3tiWz_@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<ZeObuKHkPN3tiWz_@pengutronix.de>
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

Hello Oleksij,

Thanks for your review!!

On Sat, 2 Mar 2024 22:35:52 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Feb 27, 2024 at 03:42:55PM +0100, Kory Maincent wrote:
> > Integrate the regulator framework to the PSE framework for enhanced
> > access to features such as voltage, power measurement, and limits, which
> > are akin to regulators. Additionally, PSE features like port priorities
> > could potentially enhance the regulator framework. Note that this
> > integration introduces some implementation complexity, including wrapper
> > callbacks and nested locks, but the potential benefits make it worthwhi=
le.
> >=20
> > Regulator are using enable counter with specific behavior.
> > Two calls to regulator_disable will trigger kernel warnings.
> > If the counter exceeds one, regulator_disable call won't disable the
> > PSE PI. These behavior isn't suitable for PSE control.
> > Added a boolean 'enabled' state to prevent multiple calls to =20
>=20
> Please rename rename "enabled" to "admin_state_enabled". This variable
> do not reflect real device state, it reflects only user configuration.

Right,

>=20
> ... =20
> > @@ -120,15 +118,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bu=
s,
> >  	u32 phy_id;
> >  	int rc;
> > =20
> > -	psec =3D fwnode_find_pse_control(child);
> > -	if (IS_ERR(psec))
> > -		return PTR_ERR(psec);
> > -
> >  	mii_ts =3D fwnode_find_mii_timestamper(child);
> > -	if (IS_ERR(mii_ts)) {
> > -		rc =3D PTR_ERR(mii_ts);
> > -		goto clean_pse;
> > -	}
> > +	if (IS_ERR(mii_ts))
> > +		return PTR_ERR(mii_ts);
> > =20
> >  	is_c45 =3D fwnode_device_is_compatible(child,
> > "ethernet-phy-ieee802.3-c45"); if (is_c45 || fwnode_get_phy_id(child,
> > &phy_id)) @@ -161,6 +153,12 @@ int fwnode_mdiobus_register_phy(struct
> > mii_bus *bus, goto clean_phy;
> >  	}
> > =20
> > +	psec =3D dev_find_pse_control(&phy->mdio.dev);
> > +	if (IS_ERR(psec)) {
> > +		rc =3D PTR_ERR(psec);
> > +		goto unregister_phy;
> > +	}
> > + =20
>=20
> I do not think it is a good idea to make PSE controller depend on
> phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
> here was the missing port abstraction.

I totally agree that having port abstraction would be more convenient.
Maxime Chevallier is currently working on this and will post it after his
multi-phy series get merged.
Meanwhile, we still need a device pointer for getting the regulator. The
phy->mdio.dev is the only one I can think of as a regulator consumer.
Another idea?

> ...
> > +static int
> > +devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
> > +			       char *name, int id)
> > +{
> > +	struct regulator_config rconfig =3D {0};
> > +	struct regulator_desc *rdesc;
> > +	struct regulator_dev *rdev;
> > +
> > +	rdesc =3D devm_kzalloc(pcdev->dev, sizeof(*rdesc), GFP_KERNEL);
> > +	if (!rdesc)
> > +		return -ENOMEM;
> > +
> > +	/* Regulator descriptor id have to be the same as its associated
> > +	 * PSE PI id for the well functioning of the PSE controls.
> > +	 */
> > +	rdesc->id =3D id;
> > +	rdesc->name =3D name;
> > +	rdesc->type =3D REGULATOR_CURRENT;
> > +	rdesc->ops =3D &pse_pi_ops;
> > +	rdesc->owner =3D pcdev->owner;
> > +
> > +	rconfig.dev =3D pcdev->dev;
> > +	rconfig.driver_data =3D pcdev;
> > +	rconfig.init_data =3D &pse_pi_initdata; =20
>=20
> Please add input supply to track all dependencies:
>         if (of_property_present(np, "vin-supply"))
> config->input_supply =3D "vin";
>=20
> May be better to make it not optional...

Does the "vin-supply" property be added at the pse-pi node level or the
pse-controller node level or at the hardware port node level or the manager=
 node
level for the pd692x0?
Maybe better at the pse-pi node level and each PIs of the manager will get =
the
same regulator?
What do you think?
=20
> Should be tested, but if, instead of "vin-supply", we will use
> "pse-supply" it will make most part of pse_regulator.c obsolete.

Don't know, if it is done at the pse-pi node level it may not break
pse_regulator.c. Not sure about it.

> .... =20
> > @@ -310,6 +452,20 @@ pse_control_get_internal(struct pse_controller_dev
> > *pcdev, unsigned int index) return ERR_PTR(-ENODEV);
> >  	}
> > =20
> > +	psec->ps =3D devm_regulator_get_exclusive(dev,
> > +
> > rdev_get_name(pcdev->pi[index].rdev));
> > +	if (IS_ERR(psec->ps)) {
> > +		kfree(psec);
> > +		return ERR_CAST(psec->ps);
> > +	}
> > +
> > +	ret =3D regulator_is_enabled(psec->ps);
> > +	if (ret < 0) {
> > +		kfree(psec);
> > +		return ERR_PTR(ret);
> > +	}
> > +	pcdev->pi[index].enabled =3D ret; =20
>=20
> If I see it correctly, it will prevent us to refcount a request from
> user space. So, the runtime PM may suspend PI.

I don't think so as the regulator_get_exclusive() does the same and refcoun=
t it:
https://elixir.bootlin.com/linux/v6.7.8/source/drivers/regulator/core.c#L22=
68

> > +	switch (config->c33_admin_control) {
> > +	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
> > +		if (!psec->pcdev->pi[psec->id].enabled)
> > +			err =3D regulator_enable(psec->ps);
> > +		break;
> > +	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
> > +		if (psec->pcdev->pi[psec->id].enabled)
> > +			err =3D regulator_disable(psec->ps);
> > +		break;
> > +	default:
> > +		err =3D -EOPNOTSUPP;
> >  	} =20
>=20
> This change seems to break PoDL support

Oh that's totally true sorry for that mistake.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

