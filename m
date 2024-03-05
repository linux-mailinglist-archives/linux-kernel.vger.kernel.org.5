Return-Path: <linux-kernel+bounces-92962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA98728AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12DF1F2BB2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869312A144;
	Tue,  5 Mar 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VodZSlly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262F129A66;
	Tue,  5 Mar 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670327; cv=none; b=Jn5u/ESm2nN3S2tbGwVYZhGUYApfo81YfHQbiOKTyoPKldn3rhsx+UA6olRzLRO9S1YaSLkZWRqR22ctsIgX2aOEKeCzKU6j6C9l71Ht8ksselZLgbPZT9ygna18TFu4J2hdbcXTxhVJf2XeH/t3dyN5IwF1xlJM5ehUMO8g6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670327; c=relaxed/simple;
	bh=j7E+4ilNyI2ogqO9xhojvzYBsle7e7wsgBy4bElHkbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcTjwJZMPJDDpLqccucgwOay0jblyXZUhcMEKgShUWVjbvot3ri5zLfKoMl0B1w14CMLR70x8TL3sH/wnWp742l9nL7TUMXY8YHb7nRJInKDGJakQy+LdOmoiDWCgion9CNi+XtVEO2nmOOgy5ONW8pVWYa+sDUs9veQ5lk/2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VodZSlly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F29C43390;
	Tue,  5 Mar 2024 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709670326;
	bh=j7E+4ilNyI2ogqO9xhojvzYBsle7e7wsgBy4bElHkbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VodZSlly5fm4dpOGfW8UXP9Sqzd7xlx3YIeZ2atQCQw2EnmvyU8sYtWMGsvZOaB8P
	 20UOrJ97Y9+2xaTtJdoFAi2wrEZ6n9WEbPE0KlIkYMrOiqkY4fEj7mhSqWsu81KEQR
	 tbTEMPCSZkAZki6sJ8PhTLWOtHK6DqfNAF/0JQmFLQsVxzPhUfDLx4GyGXifW8Y1L8
	 a+j0KcgiHi9zPJcDGvLrPV/ZAVuWSGRDKQhQgoTgx11Vf7TzxadU2FHxXO4VURTpWA
	 WKYfJNuacU/2leQ06iQDkdlw55pqn24CPuw/M3DEoN+qbU0kB5T+HRtKsLDQB6mkPT
	 VJQhb7E+H9Img==
Date: Tue, 5 Mar 2024 20:25:21 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear
 CMT430B19N00
Message-ID: <20240305-hacked-udder-6d8396015ad5@spud>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
 <20240304-drivable-property-feaeba782880@spud>
 <5c3acbaa-dc95-4f8a-87cf-c62b6ccc442c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OnU1VrWnwRjDQ5qV"
Content-Disposition: inline
In-Reply-To: <5c3acbaa-dc95-4f8a-87cf-c62b6ccc442c@bootlin.com>


--OnU1VrWnwRjDQ5qV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 10:48:56AM +0100, J=E9r=E9mie Dautheribes wrote:
> Hi Conor,
>=20
> On 04/03/2024 20:29, Conor Dooley wrote:
> > On Mon, Mar 04, 2024 at 05:04:51PM +0100, J=E9r=E9mie Dautheribes wrote:
> > > Hello everyone,
> > >=20
> > > This patch series add support for the Crystal Clear Technology
> > > CMT430B19N00 4.3" 480x272 TFT-LCD panel.
> > > It also adds Crystal Clear Technology to vendor-prefixes.yaml.
> > >=20
> > > Please note that unfortunately there is no public datasheet available
> > > for this panel.
> > >=20
> > > Changes in v2:
> > >    - add link to the Crystal Clear Technology website in commit messa=
ge, as
> > >    suggested by Conor Dooley and Neil Armstrong.
> >=20
> > You forgot however to add the acks that I gave you for the two
> > dt-binding patches.
>=20
>=20
> Oops you are right, I'm sorry. Should I send a v3 containing these acks?

I was going to just provide them here, I just wanted to make sure you
didn't intentionally drop them first. But in the interim you got some
=66rom Krzysztof, making some from me redundant anyway :)
I wouldn't bother adding the forgotten acks or resending, I don't care
about my ack count :)

--OnU1VrWnwRjDQ5qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZed/sAAKCRB4tDGHoIJi
0vLvAQDO/sy0qtDDk88ASr2plItuCqG83Rp3/buiOkwrdMYpAwEAqhujH3JiXO3I
7dfR2aeehYrL5n3pZkBJD/b4l8QCSgM=
=HgAm
-----END PGP SIGNATURE-----

--OnU1VrWnwRjDQ5qV--

