Return-Path: <linux-kernel+bounces-125099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450C892012
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C549D280C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231114AD17;
	Fri, 29 Mar 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZDMwcWW"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BB4A0A;
	Fri, 29 Mar 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724143; cv=none; b=FY7cKhSTVoCq4q+JIoN+IKT/zwQ/S6uoh8yRNJvcErhoczBDyPwofxEDQhWrJ0V12vexihNk4bds5Irhk9W0SaayZSylWiMRYJqKIgkhqQOOCA0AaJyp7/Ze6Z95mhT/GHFfiUfHrytYOg0iLPPikPwgWQbc/o6at6WpkxQUjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724143; c=relaxed/simple;
	bh=T8BNxaHXO7JTfIjDjaQZY7GeuN5pVFvIqxiQyV2J3EU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvAFwuExmf7jav6qB+eR5IoWNUzBgZk3hk7YYB87Q3py6UKNuwlptTjYZbnOFlxAoZkarUeqla4gMYI+E1LxZ/xoHrc9DNpDSNr0cmF1TO48ivgIBEH/zJpuc+rUCQlFydM77EwIG9InhaMkPMjLgV4q7zZYlKzZcB4RWVALnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SZDMwcWW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFCA6FF803;
	Fri, 29 Mar 2024 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCUwrIMp7HXs+dtloBRIzPq+G9ld6MDNTIcOpzNWDXw=;
	b=SZDMwcWWM869fsD9v3HSQq/0fV1d+LhqjiqbOrsWZOA1YoAoSiCu2qJKPYKlxoKDoexdcX
	G/cUYuBa2qrZGSSEleeu/8a0NKN0fEyYdIgAjuoNyqPx3H9RsPSz4cd0uOqYHMbyF8IZ8F
	J6ZZzPfPrN1cp+nqphlUMEY0p1hi4G6wryNeuRzyKEq4kUgM3qLPbQ8E/rwEmU1oMG0HsN
	vZ8jFvCKrdlNvdJi7raaG5UwnFaME0vvJVe78tGKjwxzExvdXUFUC7dpl5lxrs7PlvUqRD
	w6PqUtpirxHV5cSf6GYWYO46lTtJFBx95IdhVwST321Jsbw2YZBz2LBEBGEjVg==
Date: Fri, 29 Mar 2024 15:55:35 +0100
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
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <20240329155535.6228ba86@kmaincent-XPS-13-7390>
In-Reply-To: <0cc9923f-2907-471e-81b0-2ca01a6e8c79@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
	<0cc9923f-2907-471e-81b0-2ca01a6e8c79@lunn.ch>
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

On Thu, 28 Mar 2024 17:17:43 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +
> > +	/* Set operating mode */
> > +	ret =3D i2c_smbus_write_word_data(client, TPS23881_REG_OP_MODE,
> > 0xaaaa); =20
>=20
> Could you add some #defines here? This is semiauto i think?

Yes

> > +	/* Enable detection and classification */
> > +	val =3D 0;
> > +	for (i =3D 0; i < TPS23881_MAX_CHANS; i++) {
> > +		if (!port_matrix[i].exist)
> > +			continue;
> > +
> > +		val |=3D BIT(port_matrix[i].lgcl_chan[0]) |
> > +		       BIT(port_matrix[i].lgcl_chan[0] + 4);
> > +		if (port_matrix[i].is_4p)
> > +			val |=3D BIT(port_matrix[i].lgcl_chan[1]) |
> > +			       BIT(port_matrix[i].lgcl_chan[1] + 4);
> > +	}
> > +	ret =3D i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN,
> > 0xffff); =20
>=20
> This looks odd. You calculate val, and then don't use it?

Oh indeed, you are right! Thanks for spotting the issue.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

