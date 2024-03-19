Return-Path: <linux-kernel+bounces-107888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C588030C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A12283778
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295C17BA4;
	Tue, 19 Mar 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMdNq+SY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7D18C05;
	Tue, 19 Mar 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868013; cv=none; b=ogY1m9OKB+L/RtywgmUzrrlge20//dyxk10kCEocv+Sq17g0W+8+2dwWqJrshaodnKlE835cIyGKENK5VerS2Ji3E8niOkqzqGi8j5JhlILGoQAweDnH1IxttEp1XUVXfPqdKRjah+kIp+Gd5J8L6IBg7KoFvDYYkYNQ3UvXMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868013; c=relaxed/simple;
	bh=4sfHshxTfCzjYdFQoq9cTJXqvZmtR9W4NjZzxQaBRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZemrE64XEwvTJpEphdw+BUxyaYxJUrvM1HBKhSR3/8WwkXRMGTtuvFPxL22E/sPU9w+kMDB6F1Z+wU8B0xH7pkwDsHYrpvIfm44ar++cSQp3nKVDvahOKemx3A/gO8Tv47NfPpYqPDyHlN9kY29s+Ov+bJv2TVSc/zY3HVnREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMdNq+SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F547C433C7;
	Tue, 19 Mar 2024 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868013;
	bh=4sfHshxTfCzjYdFQoq9cTJXqvZmtR9W4NjZzxQaBRow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMdNq+SYrlw395jnqI4gXOzFdKI0cTTrjTlHx2fvU/T+Cs0RDSulUlb5283MsxYbQ
	 pe/nqzrLhZl+6e5cJbOQv9rIwxdtXilynchXZMJlC4TbuHddq93v3LmZo0PY1Ev19m
	 ycUaGfMf8ywgGunDRMQ6sOf3mYdcNPDx39r1a6dWebxYkdkPz6ZZ+2UUaWYygFe9KT
	 CeGfzJ88mzql6FS3/kYdKb6gNhIUASjZYkk3tlSwUdqC9wg6rc5d8WenekYbyq08IC
	 0yAKFJg2pydhVApat1qp/GB2aFD5r8C1ZgXrLYDbjO9aseSGCNuBxc8Iy1170O9rdb
	 ph9cHI9GP8okg==
Date: Tue, 19 Mar 2024 17:06:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bastian Hecht <hechtb@gmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Message-ID: <20240319-sympathy-vertigo-9bc884e5fef0@spud>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
 <20240119-feature-ts_virtobj_patch-v7-1-eda70985808f@wolfvision.net>
 <e373c2c7-0cd9-40d6-a19b-3b9a1a81feb2@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U9CU1yZFVMXNIoZu"
Content-Disposition: inline
In-Reply-To: <e373c2c7-0cd9-40d6-a19b-3b9a1a81feb2@wolfvision.net>


--U9CU1yZFVMXNIoZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:13:08PM +0100, Javier Carrasco wrote:
> On 1/19/24 08:43, Javier Carrasco wrote:
> > The touch-overlay encompasses a number of touch areas that define a
> > clipped touchscreen area and/or buttons with a specific functionality.
> >=20
> > A clipped touchscreen area avoids getting events from regions that are
> > physically hidden by overlay frames.
> >=20
> > For touchscreens with printed overlay buttons, sub-nodes with a suitable
> > key code can be defined to report key events instead of the original
> > touch events.
> >=20
> > Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> > ---
> >  .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++=
++++++++
> >  1 file changed, 119 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchs=
creen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscree=
n.yaml
> > index 431c13335c40..eb1e86fa86c6 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> > @@ -87,6 +87,125 @@ properties:
> >    touchscreen-y-plate-ohms:
> >      description: Resistance of the Y-plate in Ohms
> > =20
> > +  touch-overlay:
>=20
> Even though it has already been reviewed, just in case before it gets
> applied. Should it not be:
>=20
> 	description: |
> 	  List of nodes...
>=20
> instead, to keep formatting?

Yes.

--U9CU1yZFVMXNIoZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnGJwAKCRB4tDGHoIJi
0r+pAQCQN27PZoCuDBHZdZc6ygr5G/8Gjo17ikuaVKSOz2crTAD/e2nwlGPphrqJ
h1HPjRq7LLIXp5qwQEWUA2oFZPw0TQk=
=K3lV
-----END PGP SIGNATURE-----

--U9CU1yZFVMXNIoZu--

