Return-Path: <linux-kernel+bounces-71400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E508385A497
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9023A1F22F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07036134;
	Mon, 19 Feb 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="YMLsfnrS"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24882E419
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349194; cv=none; b=ODB6huVh/rtu7dAur4tyWQMxBK1b1WzMBq4VSkVrN5DE0rF0QIFJjjRr88PzKRvY21gcCbeVCXRDK1egTfrIBF/BjjPROpFu8u2RZ42ueoyL+Py+6wgXzGiCxID73SSSd2eOCfZQ4h3HHmGzMEfTdKADhrYHrQ97EipOAeSa21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349194; c=relaxed/simple;
	bh=DmXfhNNa4p9DS5Y9vKc8A9iqo7N58OEkUnvPWf30quo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=TeMam+9+GNflS7zhEpFqxZpRty+UCjdJq4f6Kc/LMq0XlGIi2vHrqt6UDtr0SYqnfcCMrtJgkQW2Kt+M8MNBsENyJkbAlwwhPhsHOKiL9vLbecWfMB/2pAo9kQWN9yxSxy44BvHFQt9ZNq0v7TKzNyDgOUf2sCPNJw0BGIQvfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=YMLsfnrS; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 62092D4B;
	Mon, 19 Feb 2024 14:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1708349183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=3goiUfn8w3t5SmwT7BNMO9ZLi9SIvXz1B37HAHXy168=;
	b=YMLsfnrSrY4bAu2cw7WQDxprkuP2+L6O7Rb3YAGQyRiFTOnjk1zDva9BfpMygySCzD9egp
	hDjesE0DYscg4l0oRKszc6w6rZgNiGyuxN2aTtvhOCDJkeC0cP+VHzlms6khUjCMly/XWC
	mKK712t1vB/V4YRpy2i4gr6+v8ihGvT7u2ALig4yKpLPG+rRKyjLwG8e2ZW+ZvmSDGhSSu
	fqckLBMGiKwURMyVC8QziUEdPxoxLNY/tVi7WRlKYFoAtIGBQU6bCinv0EP9uek9j2Qx71
	A3QUglNyIsw14kQbY9NoHF49GOVt0cp0oC5DpspFn3nSJ78eV4yQ1CBOSXmsWw==
Content-Type: multipart/signed;
 boundary=4d612e85c44be11edd360cd91b974ed96a303e8b11425e6de3e0efa4c955;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 19 Feb 2024 14:26:16 +0100
Message-Id: <CZ938PEUZ1JQ.2DJE7C03HI9OO@walle.cc>
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Cc: <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
 <rafal@milecki.pl>, <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
From: "Michael Walle" <michael@walle.cc>
To: "Marco Felsch" <m.felsch@pengutronix.de>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.16.0
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
 <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
 <20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
 <20240219120414.32395299@xps-13>
 <20240219115358.xui5fpoisvsubdyb@pengutronix.de>
In-Reply-To: <20240219115358.xui5fpoisvsubdyb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--4d612e85c44be11edd360cd91b974ed96a303e8b11425e6de3e0efa4c955
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Feb 19, 2024 at 12:53 PM CET, Marco Felsch wrote:
> On 24-02-19, Miquel Raynal wrote:
> > Hi Marco,
> >=20
> > m.felsch@pengutronix.de wrote on Fri, 16 Feb 2024 11:07:50 +0100:
> >=20
> > > Hi Michael,
> > >=20
> > > On 24-02-16, Michael Walle wrote:
> > > > Hi,
> > > >=20
> > > > On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote: =20
> > > > > @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct =
nvmem_device *nvmem)
> > > > >  	struct bin_attribute **cells_attrs, *attrs;
> > > > >  	struct nvmem_cell_entry *entry;
> > > > >  	unsigned int ncells =3D 0, i =3D 0;
> > > > > +	umode_t mode;
> > > > >  	int ret =3D 0;
> > > > > =20
> > > > >  	mutex_lock(&nvmem_mutex);
> > > > > @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struc=
t nvmem_device *nvmem)
> > > > >  		goto unlock_mutex;
> > > > >  	}
> > > > > =20
> > > > > +	mode =3D nvmem_bin_attr_get_umode(nvmem);
> > > > > +
> > > > >  	/* Initialize each attribute to take the name and size of the c=
ell */
> > > > >  	list_for_each_entry(entry, &nvmem->cells, node) {
> > > > >  		sysfs_bin_attr_init(&attrs[i]);
> > > > >  		attrs[i].attr.name =3D devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> > > > >  						    "%s@%x", entry->name,
> > > > >  						    entry->offset);
> > > > > -		attrs[i].attr.mode =3D 0444; =20
> > > >=20
> > > > cells are not writable if there is a read post process hook, see
> > > > __nvmem_cell_entry_write().
> > > >=20
> > > > if (entry->read_post_processing)
> > > > 	mode &=3D ~0222; =20
> > >=20
> > > good point, thanks for the hint :) I will add this and send a non-rfc
> > > version if write-support is something you would like to have.
> >=20
> > I like the idea but, what about mtd devices (and soon maybe UBI
> > devices)? This may only work on EEPROM-like devices I guess, where each
> > area is fully independent and where no erasure is actually expected.
>
> For MTD I would say that you need to ensure that you need to align the
> cells correctly. The cell-write should handle the page erase/write cycle
> properly. E.g. an SPI-NOR need to align the cells to erase-page size or
> the nvmem-cell-write need to read-copy-update the cells if they are not
> erase-paged aligned.
>
> Regarding UBI(FS) I'm not sure if this is required at all since you have
> an filesystem. IMHO nvmem-cells are very lowelevel and are not made for
> filesystem backed backends.
>
> That beeing said: I have no problem if we provide write support for
> EEPROMs only and adapt it later on to cover spi-nor/nand devices as
> well.

Agreed. Honestly, I don't know how much sense this makes for MTD
devices. First, the operation itself, seems really dangerous, as
you'll have to delete the whole sector. Second, during initial
provisioning, I don't think it will make much sense to use the sysfs
cells because you cannot combine multiple writes into one. You'll
always end up with unnecessary erases.

What's your use case here?

Just my two cents..
-michael

--4d612e85c44be11edd360cd91b974ed96a303e8b11425e6de3e0efa4c955
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdNW+BEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+1uSAQCkmDcFY4GzAsY7ha1lKvgSSJRCqLkydobm
qqzwyMMsFwEA65edy4y9PaiLDA1aM8sL5Npr1cskJtyTGNMcmDHKXws=
=bNfX
-----END PGP SIGNATURE-----

--4d612e85c44be11edd360cd91b974ed96a303e8b11425e6de3e0efa4c955--

