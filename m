Return-Path: <linux-kernel+bounces-125102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49D892023
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6ED1C20EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831441327F3;
	Fri, 29 Mar 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsLKCdEz"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051811182;
	Fri, 29 Mar 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724223; cv=none; b=gXp3zlRMUqkH/2PDGYjWA938/qYdLIw1+2IxhQxNlt2HWYJLO/jU665OsnQyAHvBhqiWk7a+iL0+nLIDYdaVz1cfjC3d1R0O4axdSAfglTd6YDBnq1Qsgboh27EbBDP+v+F8SKYDJiwirUAu/BPQijywNth+M8JD0zWzlegrsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724223; c=relaxed/simple;
	bh=yj+WaMPcDC4PmfXN0UoEz2VQHz+OShndoiecKuggxIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZZwbJypHJ90HcynK/LyTNRtNNwAOtfc0qP98AP1/f5Aokqcgf2LK6ysTeFSGET2z5LR+riWYwiJXnpc07dQtwFA37NHlXn8Db0/x+VL/TQhmk7XZ9f84Wn71e8hZpGZRh8Z8wkkD75uxWfj5Sw3ZQRrWGESzX/Ba9s0kO0uH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsLKCdEz; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 677A5FF807;
	Fri, 29 Mar 2024 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTj4FeukY1YJcV4SBWzPdB8d+BFYvBZVOFx5d16Wyso=;
	b=hsLKCdEzurQ82WXwjX3trgShtaiIxve5JRIeTgufUAUg96HSmVjf3GLNFOw2wJ8GvgvaSd
	b0mU4AoOQLevyKJnFqcOsGkDwk08wrNu63+mVz99bKlMk8VS5EZie5FX+ZDSnZ0arG9dwB
	phQl/UrHgMwqjuSCgEittZC/OxKtBOzfRthhfl62A+kobnJUR5DBEVOg5Zq1ZDoIh/zdar
	R1lmEA7QFAOTC/gCtAhhUnSAokZ/Hohztelg5K57xIXzWrFQqEQZfOefK5pqKjZpEq0W0g
	Xv8KYUT/ikok1azhPDUxITboub1F2nE/5s1kZ4HMFqmQHrp2n9vwPDf9XO+FRw==
Date: Fri, 29 Mar 2024 15:56:57 +0100
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
Message-ID: <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
In-Reply-To: <6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
	<6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
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

On Thu, 28 Mar 2024 17:24:17 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > +				  const char *fw_name,
> > +				  const struct tps23881_fw_conf *fw_conf) =20
>=20
> Does the device actually have flash? Or is this just downloading to
> SRAM?

It is downloading to SRAM.

>=20
> > +{
> > +	const struct firmware *fw =3D NULL;
> > +	int i, ret;
> > +
> > +	ret =3D request_firmware(&fw, fw_name, &client->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(&client->dev, "Flashing %s\n", fw_name); =20
>=20
> If this is a one-time thing whenever there is a new firmware version
> dropped into /lib/firmware, this would be O.K. However, if this
> happens every boot, i would use dev_dbg().

Ok I will change to dev_dbg then.
Thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

