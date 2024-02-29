Return-Path: <linux-kernel+bounces-86604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E386C7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C230E1F25063
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A4E7AE5B;
	Thu, 29 Feb 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CabQp1nJ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386E62808;
	Thu, 29 Feb 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204957; cv=none; b=SRGxPYdPVlOI48yvG/qOqir2uNI5HwvFzV4Haa4r0OXDe+hNnSaP9Xvlq/wNWCc/P4yQ5AF4rHrnOaK1qqaU59rFs7w9MUuPEj8/+cVCUfW8nCRcozoNyBKqosaAtoMjL5uchC5P4jPkySMMDMp+93fscg85vyYXS7mJ0oeJmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204957; c=relaxed/simple;
	bh=rZLStquWue5yNAK1HofFQEjYZk7A0wlwP3ZnA08cIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDJKasRp8y1FKVzVMhliuE9OV/jVAeQCM82bXWroc4RUY+CpfSQRvHzdwHT73wo38s2m/rzyktAVvn2weycpwEBLgnk9vKzYCqxQ3QgZnTdSJNkm9nDDcv0RzfiNiBzV6dgWBAx5RFCG/e23h96bnCF/JP0X2kqTvOU17ouk3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CabQp1nJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 277532000A;
	Thu, 29 Feb 2024 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709204946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RH+aBH/pXXu05f9M4mzdSZ7M/454fi9vbzLuC8bcSEs=;
	b=CabQp1nJVruJAy+rC86OljQhe9ceHgmJKPR0CvAHsHe7Kt6+7EAm6dBCfCzvJxWHjI1Ygr
	7XYnCyubBTeml4mDicw6GsMowdlJvr/LeLjDnL1unbEeQti7j5ZWNrH5zQxlZkvMWLHg11
	vTVZK5hTmxxbZO/67joTHG41UGu3v+LF/2voLiqYrl6ZVzYvmoUPENnMfnJOVDhW5DJ003
	dp8KARtPj7zKGhjXuMrF2NzlkU6JLULIyB+QdQqSMCxrmS/D7cJ41JtZT26UHCQUDj5giw
	I4IeHhwih8L/+Mb/gVxImMTGACpY9OYjEAt8inPy3pvh3JjddNrd6RoxKBeoKw==
Date: Thu, 29 Feb 2024 12:09:03 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <20240229120903.2589d112@kmaincent-XPS-13-7390>
In-Reply-To: <20240228125344.GD292522@kernel.org>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-17-28f0aa48246d@bootlin.com>
	<20240228125344.GD292522@kernel.org>
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

On Wed, 28 Feb 2024 12:53:44 +0000
Simon Horman <horms@kernel.org> wrote:

> On Tue, Feb 27, 2024 at 03:42:59PM +0100, Kory Maincent wrote:
> > Add a new driver for the TI TPS23881 I2C Power Sourcing Equipment
> > controller.
> >=20
> > This patch is sponsored by Dent Project <dentproject@linuxfoundation.or=
g>.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> ...
>=20
> > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > +				  const char *fw_name,
> > +				  const struct tps23881_fw_conf *fw_conf)
> > +{
> > +	const struct firmware *fw =3D NULL;
> > +	int i, ret;
> > +
> > +	ret =3D request_firmware(&fw, fw_name, &client->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(&client->dev, "Flashing %s\n", fw_name);
> > +
> > +	/* Prepare device for RAM download */
> > +	while (fw_conf->reg) {
> > +		ret =3D i2c_smbus_write_byte_data(client, fw_conf->reg,
> > +						fw_conf->val);
> > +		if (ret < 0) =20
>=20
> Hi Kory,
>=20
> Should fw be released here.

Hello Simon,

Indeed I have missed it, thanks.=20

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

