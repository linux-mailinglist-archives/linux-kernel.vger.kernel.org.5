Return-Path: <linux-kernel+bounces-83392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707788697CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC4528F899
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51877145324;
	Tue, 27 Feb 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jty0/eUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103F13EFE9;
	Tue, 27 Feb 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043909; cv=none; b=nhxT/vDo3PAXXYSVXukDffAj7hGrBhvBsOdC0Cg5J93iaPhBcavAPDmkxPNM7uYRSOfRScPRL5G3NKnt+mIdyFZ+lgPxJQWqsj2osoXGfdo74UDwW9AfM8zA3Q5orU0v1mvmR/xDx50sY+t8tt1nTcFTVUK5DyytyWZcEf4mvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043909; c=relaxed/simple;
	bh=Ii+Ho6CxHIlrZTO4o1HBgxNTSNqhaO8bIqEauARTdlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvjXTe9/YExVHNu12Lkt/DcKREQVjq/dZAeQqDv5MLyvJe4Zmw39VCLx20xyqJ4hJSxpFM9u0bYHd9OabfBVmDvzI/FswpnYyQVJLsP3mkyaL1jwHt4aOnwPVu94Q0zp0P0QY5W9iaZXWtAZZyD5nsiuWR2U/B6j+DeshOvfPfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jty0/eUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD14EC433C7;
	Tue, 27 Feb 2024 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709043909;
	bh=Ii+Ho6CxHIlrZTO4o1HBgxNTSNqhaO8bIqEauARTdlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jty0/eUVkVtElFMg1Dm1Vd6uKmffzl0oGroT20ZNUfvSjK/ZenDgzH41U8Yuh9c7P
	 JGVlhj5IZ9edIXS0j+1up7K1I2ZtQnXUbgS8J167R5WyLgGfxvu4BH6K6CWG8XR8gB
	 9pAoxvqhJvjN+1YqPO4OUsk5xtK/LDy5XF6JMlM989f0mSdw2AgDJQyfWop2nJvcAJ
	 d075tNFgN7zPa4ySgMKL91sG5uoKds39u3mq1XFtRBCdE9vqHmClfiATvKzeSqZitA
	 PdKynwDvEw/vv37fAiza4D7UlFi0AEgAadI5Gp9EZsCCSkAjbXTu6z4TsiauF+BM2p
	 PMDiU4J6l70gw==
Date: Tue, 27 Feb 2024 14:25:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
Message-ID: <f02f1784-123d-44f8-afca-63a593c9d1da@sirena.org.uk>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <3b8e947c-51fb-461e-bb9e-7bc1bb547471@sirena.org.uk>
 <67c59e4a-7f2f-4d74-a9fc-24346233c8c0@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6PkmX3O9usm2B74U"
Content-Disposition: inline
In-Reply-To: <67c59e4a-7f2f-4d74-a9fc-24346233c8c0@opensynergy.com>
X-Cookie: Please go away.


--6PkmX3O9usm2B74U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 03:12:55PM +0100, Harald Mommer wrote:
> On 13.02.24 18:49, Mark Brown wrote:
> > On Tue, Feb 13, 2024 at 02:53:50PM +0100, Harald Mommer wrote:

> > > +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
> > > +				   struct spi_controller *ctrl,
> > > +				   struct spi_message *msg,
> > > +				   struct spi_transfer *xfer)
> > > +	/*
> > > +	 * Got comment: "The virtio spec for cs_change is *not* what the Li=
nux
> > > +	 * cs_change field does, this will not do the right thing."
> > > +	 * TODO: Understand/discuss this, still unclear what may be wrong h=
ere
> > > +	 */

> > > +	th->cs_change =3D xfer->cs_change;

> I got the comment originally from you, Mark Brown. After some digging sti=
ll
> unclear what should be wrong and in the meantime I think nothing is wrong=
 at
> all. To point you with the nose on the pending issue I added this comment
> here.

Without going and checking the spec IIRC cs_change only applies within a
message in the virtio spec but it has effects on the final transfer in
Linux. =20

>=20
> I'll remove the comment because I think there is no problem. Please prote=
st
> if I'm wrong.
>=20
> > > +static int virtio_spi_transfer_one_message(struct spi_controller *ct=
rl,
> > > +					   struct spi_message *msg)
> > > +{
> > > +	struct virtio_spi_priv *priv =3D spi_controller_get_devdata(ctrl);
> > > +	struct virtio_spi_req *spi_req;
> > > +	struct spi_transfer *xfer;
> > > +	int ret =3D 0;
> > > +
> > > +	spi_req =3D kzalloc(sizeof(*spi_req), GFP_KERNEL);
> > > +	if (!spi_req) {
> > > +		ret =3D -ENOMEM;
> > > +		goto no_mem;
> > > +	}
> > Why not just allocate this once, it's not like it's possible to send
> > more than one message simultaneously?
> Will be done, struct virtio_spi_req spi_req will become a member of struct
> virtio_spi_priv.
> > > +	/*
> > > +	 * Simple implementation: Process message by message and wait for e=
ach
> > > +	 * message to be completed by the device side.
> > > +	 */
> > > +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > This is processing transfers within a message rather than messages.
> Obviously I did not get the terminology of messages and transfers not
> correct which made the comment wrong. Comment to be corrected (and
> shortened).
> > > +		ret =3D virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
> > > +		if (ret)
> > > +			goto msg_done;
> > > +
> > > +		virtqueue_kick(priv->vq);
> > > +
> > > +		wait_for_completion(&spi_req->completion);
> > > +
> > > +		/* Read result from message */
> > > +		ret =3D (int)spi_req->result.result;
> > > +		if (ret)
> > > +			goto msg_done;
> > It's not clear why this isn't within _spi_transfer_one() and then we
> > don't just use a transfer_one() callback and factor everything out to
> > the core?
>=20
> Lack of experience. I saw one way of doing the job which missing the more
> simple way. Therefore we have reviews. Using now the alternative callback
> which shortens and simplifies the code.
>=20
> Applied code changes, have to run some more tests.
>=20
>=20

--6PkmX3O9usm2B74U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd8L4ACgkQJNaLcl1U
h9AaHAgAhBmpwymQNbLcXJ6oSG8Ft2jRG56FDmXOnjNtuyzElqXU7Bb9fqv2zxi0
YciewdNgHM18s8m7USmne8F9eMHOyHsM91UqgSKfIE1UwZ2ugLYxcdoqNDOj808x
qt7etMjNgE8e7wuHrNxtFfcCnX6RH4OX3+HQffFc9gvtQDZguA+y/PrZE0HG6p67
b6CwpBRkkxzfRZelQrXFN3h/fpa+YkM6YXZowlrPiQwYoVlCkjAjXKpmVEDvGAkt
S8ELc1Kpvn+T2Ef1coFWwPOgBPjUa/u/wxgYcTQ1vPdUEAvmzn4r6MlK3YjjGLo9
UNJfcMmERF8YwfagFciRcVOkXAfxqQ==
=fBqF
-----END PGP SIGNATURE-----

--6PkmX3O9usm2B74U--

