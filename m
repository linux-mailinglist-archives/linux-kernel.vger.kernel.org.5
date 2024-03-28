Return-Path: <linux-kernel+bounces-122983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAC8900AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E3B2353A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D283CA9;
	Thu, 28 Mar 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m79MW81C"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737E7BAE7;
	Thu, 28 Mar 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633463; cv=none; b=RM7d5wl3IbklrUTe8PuAWDXcgkxWuk7gxllhKMlvSWhInWZhHUzIVeK+ooQ8RTS2Nt8ROG2HMlizXM2VjEdSL8QTlIi/suHdyeQ/QuTsREO37iMSezgABuULtc7r9HifCCsG7Nkd+hb840VIObeZxruqGOvTkq7BAmzBbO5JKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633463; c=relaxed/simple;
	bh=1Zt/GNPnr+5CkPkwpfsrDaDy69KR996nG4gXgRgk1IE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bnk+gCF453imatwkGnkZEAA750+3/NQFdB63W6/usu1exejji33FhmBl+QiXCYkBsgyksgsAl6DB5Ehg0eASb20vrQIJhr5XXzBImKeFv9t0gAh/uBekiXADQs2I55gV3A6rT23zZlopLCYb8DBy+BEVV7IvER5SHD2O2+hGTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m79MW81C; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B70B40006;
	Thu, 28 Mar 2024 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711633452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfNHoYf2InNiPGVC9qzo7631eEUXZGyrHux3q5scrBc=;
	b=m79MW81COP1lStBzobUR/lbuPqe9Bta+GahxCqAPDJXqf6xKNvnwn6EHCJ+KIAHGsH74uq
	n9ThN05SXJKK1w0GaN4WMkycD04/4b0dc9i/UKqgGHrle44cw9y5QwpLhMfkU4gEqCSXP0
	ovVwtrPlnNVkR/JbR5V6vUcUfLqr+cias6g2pvNy6Cmt0z/A+Gah+z1Ntvw1X/uJ2adcxW
	UAf68E5WwOzt0y242sjZreyBhpeL60aEnSnKIcmYzgMqdPuoCEXPjoSEBUZbazgthzCiuN
	s5QdjnM2IuZymwUcS7W3HwkywqmjdisEzikegeNV+CvX8UkVecYgXtChPPFLBw==
Date: Thu, 28 Mar 2024 14:43:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240328144337.4456e596@kmaincent-XPS-13-7390>
In-Reply-To: <f3bafb50-406b-444a-8411-5ddae8d84c31@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-10-c1011b6ea1cb@bootlin.com>
	<f3bafb50-406b-444a-8411-5ddae8d84c31@lunn.ch>
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

On Thu, 28 Mar 2024 13:24:00 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +.. code-block::
> > +
> > +         +-------------+
> > +         |    PSE PI   |
> > + 8  -----+                             +-------------+
> > + 7  -----+                    Rail 1   |
> > + 6  -----+------+----------------------+
> > + 5  -----+      |                      |
> > + 4  -----+     /              Rail 2   |  PSE 1
> > + 3  -----+----?          +-------------+
> > + 2  -----+----+---------?              |
> > + 1  -----+---?                         +-------------+
> > +         |
> > +         +-------------+ =20
>=20
> Is ? a standard markup character? I don't remember seeing it used like
> this before.

It seems the Documentation copy-pasted from Oleksij mail bring me few weird
characters.
I will fix it.

> > +static int of_load_single_pse_pi_pairset(struct device_node *node,
> > +					 struct pse_pi *pi,
> > +					 int pairset_num)
> > +{
> > +	struct device_node *pairset_np;
> > +	const char *name;
> > +	int ret;
> > +
> > +	ret =3D of_property_read_string_index(node, "pairset-names",
> > +					    pairset_num, &name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!strcmp(name, "alternative-a")) {
> > +		pi->pairset[pairset_num].pinout =3D ALTERNATIVE_A;
> > +	} else if (!strcmp(name, "alternative-b")) {
> > +		pi->pairset[pairset_num].pinout =3D ALTERNATIVE_B;
> > +	} else {
> > +		pr_err("pse: wrong pairset-names value %s\n", name);
> > +		return -EINVAL; =20
>=20
> Maybe include the node path in the error message? For a 24 port
> switch, it will help find a typo in one of the ports. I would do this
> for all error messages in this code.

Ok, I will.
Thanks for your review!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

