Return-Path: <linux-kernel+bounces-2830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A686681628D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0A282914
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C7C495CF;
	Sun, 17 Dec 2023 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhTYy3DB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEA48CC3;
	Sun, 17 Dec 2023 21:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3011FC433C8;
	Sun, 17 Dec 2023 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702849484;
	bh=LU9qYbUuOegUoQ0y3keXt75Qy2ohN0DfQKRqKYnsRAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhTYy3DB43PQyqzftTGqTqeZ1Lkau+WzeJ8iQUXZQ7CjIMnDI3fdA5b1VN0vIJMO5
	 Zc+K7KHWigs6jL5waqcarnnYI4wV0TW5oFFXK5qzoslOJwMOTb+0OCuuqh5BLEJwoO
	 L+T/5UbiBg6cWaEw0X4OaSUYCvn7UdtwJgXGqZa8915/etyu6I5nmhYZn6pNPvz/w8
	 q2lO6NYw/0+1nE0ZpyHXzEFlRdTZYXNwXbvrX3RqGvLJu3ktiC2nzWjMXOt5EXf/qq
	 O32Sv7Gr1gmR23+bGrV9Qk8ISNIO23jsBAfJJjexieOMtdK7qTlsTtN/ywPkIE/1B8
	 70KksQvOVlFpg==
Date: Sun, 17 Dec 2023 21:44:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add AMS AS6200 temperature sensor
Message-ID: <20231217-disregard-buckshot-772429f0be34@spud>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <20231217-enlarged-mule-a594e472d007@spud>
 <fb0973e5-0249-4616-ad8a-0b19d8b73094@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qZyeBYZ//6gGoNwQ"
Content-Disposition: inline
In-Reply-To: <fb0973e5-0249-4616-ad8a-0b19d8b73094@roeck-us.net>


--qZyeBYZ//6gGoNwQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 01:39:37PM -0800, Guenter Roeck wrote:
> On 12/17/23 12:58, Conor Dooley wrote:
> > On Sat, Dec 16, 2023 at 11:39:29AM -0500, Abdel Alkuor wrote:
> > > as6200 is a temperature sensor with a range between -40=B0C to
> > > 125=B0C degrees and an accuracy of =B10.4=B0C degree between 0
> > > and 65=B0C and =B11=B0C for the other ranges.
> > >=20
> > > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> >=20
> > Is this not v3?
>=20
> FWIW, I don't recall seeing it.

Ah, I think this was originally submitted to iio, went through 2
iterations and then ended up here on Jonathan's advice.

>=20
> > Either way,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
>=20
> As I pointed out in my reply to the other patch, this chip is mostly
> compatible to lm75 and almost register-compatible to tmp112, the only
> difference being some configuration register bits.
>=20
> Bindings for this chip should be added to
> Documentation/devicetree/bindings/hwmon/lm75.yaml.

Ah. In that case, I would expect my tag not to be picked up by Abdel.

--qZyeBYZ//6gGoNwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9rxwAKCRB4tDGHoIJi
0lkBAQCylzdLHvlQOlEDKpH3j1rIuXMkpQGAwcKQXEo8sLT4QQEAtH+juq+C/R+n
Z+DW2zjHNRN3tGFvYL2FG7g36bK0TQg=
=O1+C
-----END PGP SIGNATURE-----

--qZyeBYZ//6gGoNwQ--

