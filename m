Return-Path: <linux-kernel+bounces-27456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF8D82F055
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5C1C234AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DB1BF24;
	Tue, 16 Jan 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0314XBI"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80C1BF21;
	Tue, 16 Jan 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D4541C0004;
	Tue, 16 Jan 2024 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705414328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOCRlvdGfX4al4ZItqxCkVlf8liyb3/Akd8IILM1iBU=;
	b=O0314XBIHPKlYZCptjyxPtClQlYhlBjMrlKqvbvkLIqSXfBWlc/M/SUmSsuLJnS0wf781u
	uQT9P3sltuloK12tsj9AuKraoap9M2QzgnSVLLvLX/39QZ/4H49tClOd0XW4/xIMk9K1b2
	sGf2CQvGfYRIfncJmMmBhpOYJl5wsbOH8qQggABfKwVu8y7IN5/oo8+BTATQLc9BzOcpDd
	mP3xEnUXqbV+WCv5xZT+Dpk9O8gEz/43oYNxRx0zNhmNTTVe7kQaJmFQ9oYH5Xl8g/ut1z
	oJpzPclUUTR3wbuIV9cNJiN1txMz8sy3RXxznix2s2naB7NIFH81ipunwd0rSQ==
Date: Tue, 16 Jan 2024 15:12:05 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20240116151205.0bf44181@kmaincent-XPS-13-7390>
In-Reply-To: <64f30166-58cc-409d-ba5b-9ea3fb8ead88@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
	<639c5222-043f-4e27-9efa-ce2a1d73eaba@lunn.ch>
	<20240116104949.12708cd5@kmaincent-XPS-13-7390>
	<64f30166-58cc-409d-ba5b-9ea3fb8ead88@lunn.ch>
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

On Tue, 16 Jan 2024 14:18:04 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> >  =20
> > > > +static int pd692x0_fw_get_next_line(const u8 *data,
> > > > +				    char *line, size_t size)
> > > > +{
> > > > +	size_t line_size;
> > > > +	int i;
> > > > +
> > > > +	line_size =3D min_t(size_t, size,
> > > > (size_t)PD692X0_FW_LINE_MAX_SZ); +
> > > > +	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
> > > > +	for (i =3D 0; i < line_size - 1; i++) {
> > > > +		if (*data =3D=3D '\r' && *(data + 1) =3D=3D '\n') {
> > > > +			line[i] =3D '\r';
> > > > +			line[i + 1] =3D '\n';
> > > > +			return i + 2;
> > > > +		}   =20
> > >=20
> > > Does the Vendor Documentation indicate Windoze line endings will
> > > always be used? Motorola SREC allow both Windows or rest of the world
> > > line endings to be used.  =20
> >=20
> > All the firmware lines end with "\r\n" but indeed it is not specifically
> > written that the firmware content would follow this. IMHO it is implicit
> > that it would be the case as all i2c messages use this line termination.
> > Do you prefer that I add support to the world line endings possibility?=
  =20
>=20
> No need, just hack an SREC file, and test the parser does not explode
> with an opps, and you get an sensible error message about the firmware
> being corrupt. I would not be too surprised if there are some mail
> systems still out there which might convert the line ending.

Ok I will do so.

>=20
> > > > +static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload
> > > > *fwl) +{
> > > > +	struct pd692x0_priv *priv =3D fwl->dd_handle;
> > > > +	const struct i2c_client *client =3D priv->client;
> > > > +	struct pd692x0_msg_ver ver;
> > > > +	int ret;
> > > > +
> > > > +	priv->fw_state =3D PD692X0_FW_COMPLETE;
> > > > +
> > > > +	ret =3D pd692x0_fw_reset(client);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ver =3D pd692x0_get_sw_version(priv);
> > > > +	if (ver.maj_sw_ver !=3D PD692X0_FW_MAJ_VER) {   =20
> > >=20
> > > That is probably too strong a condition. You need to allow firmware
> > > upgrades, etc. Does it need to be an exact match, or would < be
> > > enough? =20
> >=20
> > The major version is not compatible with the last one, the i2c messages
> > content changed. I supposed a change in major version would imply a cha=
nge
> > in the i2c messages content and would need a driver update that's why I
> > used this strong condition. =20
>=20
> Do you know the next major version will change the message contents?

No.

> Is this documented somewhere? If so add a comment. Otherwise, i would
> allow higher major versions. When the vendor breaks backwards
> compatibility, its going to need code changes anyway, and at that
> point the test can be made more strict.
>=20
> We try to make vendors not make firmware ABI breaking changes, and we
> have pushed back against a number of vendors who do. So i think its
> best we assume they won't break the ABI.

Alright, thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

