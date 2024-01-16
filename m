Return-Path: <linux-kernel+bounces-27202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BF82EC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530B61F244B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9991134C5;
	Tue, 16 Jan 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jj8uWuf3"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57A134A1;
	Tue, 16 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8298960008;
	Tue, 16 Jan 2024 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705398592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNLdp9OGT7c+u1pDg4x54qzMqUrUFue68oAXfluzQf8=;
	b=jj8uWuf3K5Xess1XfSDF0tFuHfWoDK9MVLNU8+7NpsL4xMJCjG5w0z9GRxsz65rEnvnJCL
	iebfqOgabeh0/fxq5jjO831LiWI+XaXAtxZNd/iLDUsC3MuDUlOZC5/hTcfNRUZyhXi8h6
	C3ERJoUPzPHXKbvTWGhNA7MterclVbej9jrhqFI12rfbWoYqOJQL9q6Va0v4yiuvrpikY+
	RhkkiWZp71gkItHSgd7OfIMUKBTPKrc6G770jOHDSVyHIZxtlwC+KnBi76bPIFafJvRjBT
	sGkpn92LHh/3Q/MMGlsRDhh51PnCgKWciErinnXMYldLJLVJCRTdmkp3FY84Cg==
Date: Tue, 16 Jan 2024 10:49:49 +0100
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
Message-ID: <20240116104949.12708cd5@kmaincent-XPS-13-7390>
In-Reply-To: <639c5222-043f-4e27-9efa-ce2a1d73eaba@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
	<639c5222-043f-4e27-9efa-ce2a1d73eaba@lunn.ch>
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

Hell Andrew,

Thanks for your reviews and sorry for replying so late, I was working on the
core to fit the new bindings and requirements lifted by Oleksij.

On Sun, 3 Dec 2023 20:34:54 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int pd692x0_try_recv_msg(const struct i2c_client *client,
> > +				struct pd692x0_msg *msg,
> > +				struct pd692x0_msg *buf)
> > +{
> > +	msleep(30);
> > +
> > +	memset(buf, 0, sizeof(*buf));
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> > +	if (buf->key)
> > +		return 1;
> > +
> > +	msleep(100);
> > +
> > +	memset(buf, 0, sizeof(*buf));
> > +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> > +	if (buf->key)
> > +		return 1;
> > +
> > +	return 0; =20
>=20
> Maybe make this function return a bool? Or 0 on success, -EIO on
> error?

Indeed, I will move on to bool.

> > +static int pd692x0_update_matrix(struct pd692x0_priv *priv)
> > +{
> > +	struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS];
> > +	struct device *dev =3D &priv->client->dev;
> > +	int ret;
> > +
> > +	ret =3D pd692x0_get_of_matrix(dev, port_matrix);
> > +	if (ret < 0) {
> > +		dev_warn(dev,
> > +			 "Unable to parse port-matrix, saved matrix will
> > be used\n");
> > +		return 0;
> > +	}
> > +
> > +	ret =3D pd692x0_set_ports_matrix(priv, port_matrix);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +#define PD692X0_FW_LINE_MAX_SZ 0xff =20
>=20
> That probably works. Most linkers producing SREC output do limit
> themselves to lines of 80 charactors max. But the SREC format actually
> allows longer lines.

I set it to SREC limit but indeed the firmware lines does not exceed 80
characters except the comments. 0xff line size limit won't break anything
though.

> > +static int pd692x0_fw_get_next_line(const u8 *data,
> > +				    char *line, size_t size)
> > +{
> > +	size_t line_size;
> > +	int i;
> > +
> > +	line_size =3D min_t(size_t, size, (size_t)PD692X0_FW_LINE_MAX_SZ);
> > +
> > +	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
> > +	for (i =3D 0; i < line_size - 1; i++) {
> > +		if (*data =3D=3D '\r' && *(data + 1) =3D=3D '\n') {
> > +			line[i] =3D '\r';
> > +			line[i + 1] =3D '\n';
> > +			return i + 2;
> > +		} =20
>=20
> Does the Vendor Documentation indicate Windoze line endings will
> always be used? Motorola SREC allow both Windows or rest of the world
> line endings to be used.=20

All the firmware lines end with "\r\n" but indeed it is not specifically
written that the firmware content would follow this. IMHO it is implicit th=
at
it would be the case as all i2c messages use this line termination.
Do you prefer that I add support to the world line endings possibility?=20

> > +static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *f=
wl)
> > +{
> > +	struct pd692x0_priv *priv =3D fwl->dd_handle;
> > +	const struct i2c_client *client =3D priv->client;
> > +	struct pd692x0_msg_ver ver;
> > +	int ret;
> > +
> > +	priv->fw_state =3D PD692X0_FW_COMPLETE;
> > +
> > +	ret =3D pd692x0_fw_reset(client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ver =3D pd692x0_get_sw_version(priv);
> > +	if (ver.maj_sw_ver !=3D PD692X0_FW_MAJ_VER) { =20
>=20
> That is probably too strong a condition. You need to allow firmware
> upgrades, etc. Does it need to be an exact match, or would < be
> enough?

The major version is not compatible with the last one, the i2c messages
content changed. I supposed a change in major version would imply a change =
in
the i2c messages content and would need a driver update that's why I used t=
his
strong condition.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

