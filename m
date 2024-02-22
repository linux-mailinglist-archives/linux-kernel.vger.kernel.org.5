Return-Path: <linux-kernel+bounces-76335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC985F5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC51C221DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70E3DB86;
	Thu, 22 Feb 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW9B5rlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD003CF6B;
	Thu, 22 Feb 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597796; cv=none; b=SLOV0jhnW5i2XABz8PVP7/2uBQE6w04E5+kbrM3/xL2xGKH6XPnbz9G3cNqAhbgqlXrn+Xlqxy5GWR6n4O2uBECFYTrET6B69dnhqy6bt6LCATBYVZknU2g/ECAsayQyQS6/xM0p7IybK9QvkxqhNk9oSFxaasheH7CB68tmeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597796; c=relaxed/simple;
	bh=afYuJSyH4RiPAE1WvxVP1Cil3M0pG313XkEHICNyg8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHDK71ME7BxSHO5QGx4vgxpvWtnQbxKsFX+gZ2VHsYddY4cqiUBvA8cCV3SlolkaR2DXy3kR/NVS2VBzyR55x5UU6mkNWEy2GHy58RbdURr0j/yQN4lx82iPfHkfmRLRnzHPHbPJIKZPSsb6MWSKmraoxe9qCu5xvAmstKvZ0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW9B5rlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18CEC43390;
	Thu, 22 Feb 2024 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597796;
	bh=afYuJSyH4RiPAE1WvxVP1Cil3M0pG313XkEHICNyg8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW9B5rlPPl5eawcAop2ve7LU3/6MAaYknJCqr38lGgRhKsfs5J79IBTheSjcbNMtA
	 NhO9WKjam+jcU9OHLqTknnaajMPieIFd8dtTRJhdBI5KPbNJMGCupBA0lmiagn4piM
	 kferNd5Idv7e5m+eYzZG7rAbNLsIQrLB5vJuJqhKdf2KSVBQMExjLX7kF/6NZ0oZqs
	 Bzgy1+ugtB9hdLQgL+vA+mJeCKM4dWp5+XkPPCXRbYyZFBzByT6ti/QSvuq0Q/qlyQ
	 YZdEuQdlMP3WPaQKTTGZpDNGzIafV/e9gJtu1BUzbPhp2liL/Q5MDOlPcNfMkAnn5/
	 MTWWYKprZh3Dw==
Date: Thu, 22 Feb 2024 10:29:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	denis.ciocca@st.com, linus.walleij@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Message-ID: <20240222-fretted-riches-bf15f5d63018@spud>
References: <20240221175810.3581399-1-m.felsch@pengutronix.de>
 <20240221-undecided-union-4078db711693@spud>
 <20240221191644.5r3ylr5w3cnfnrzj@pengutronix.de>
 <20240221-imitate-molar-81d93285ac77@spud>
 <20240221194518.3sm4o5i274ldpvzf@pengutronix.de>
 <20240221-lubricant-machine-79054f117eb0@spud>
 <20240222084717.rcckoyjeh4shmcxr@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahPoXcnEvQcnarTl"
Content-Disposition: inline
In-Reply-To: <20240222084717.rcckoyjeh4shmcxr@pengutronix.de>


--ahPoXcnEvQcnarTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:47:17AM +0100, Marco Felsch wrote:
> On 24-02-21, Conor Dooley wrote:
> > On Wed, Feb 21, 2024 at 08:45:18PM +0100, Marco Felsch wrote:
> > > On 24-02-21, Conor Dooley wrote:
> > > > On Wed, Feb 21, 2024 at 08:16:44PM +0100, Marco Felsch wrote:
> > > > > On 24-02-21, Conor Dooley wrote:
> > > > > > On Wed, Feb 21, 2024 at 06:58:10PM +0100, Marco Felsch wrote:

> > > > Besides, having fallback compatibles is the norm when one device ha=
s the
> > > > same programming model as another.
> > >=20
> > > Not for this binding according the driver.
> >=20
> > If they don't have the same programming model, then describing them as
> > "equivalent" wouldn't be correct. That said, they seem to use the same
> > sensor settings when alls said and done (see st_magn_sensors_settings),
> > so I think they are actually compatible even if the driver has separate
> > match data for each.
>=20
> I told you that I have checked the driver and skimed the datasheets and
> came to the exact same conclusion.

Did you tell me that? I did't see it.

Anyway, I think what happened is that I interpreted "Not for this
binding according the driver" as a comment about the programming model
being different, but you meant it in reference to the fallback. Since
they do have the same programming model the fallback is appropriate,
even if the driver knows about the iis2mdc compatible.
I'd squash in the following, similar to what was done for the
st,iis328dq that was added recently:

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Doc=
umentation/devicetree/bindings/iio/st,st-sensors.yaml
index ee593c8bbb65..ee6c3800436d 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -64,7 +64,6 @@ properties:
           - st,lsm9ds0-gyro
       - description: STMicroelectronics Magnetometers
         enum:
-          - st,iis2mdc
           - st,lis2mdl
           - st,lis3mdl-magn
           - st,lsm303agr-magn
@@ -73,6 +72,9 @@ properties:
           - st,lsm303dlhc-magn
           - st,lsm303dlm-magn
           - st,lsm9ds1-magn
+      - items:
+          - const: st,iis2mdc
+          - const: st,lis2mdl
       - description: STMicroelectronics Pressure Sensors
         enum:
           - st,lps001wp-press

--ahPoXcnEvQcnarTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdciHwAKCRB4tDGHoIJi
0rYLAP9zXNYPi9SZuObV9gQE3XitJbRNMbErzItFTaLr7pgDwgD+NA+JrD+s8dqv
AQAMzEvicv1YL6dcsEnWJJyJKjz4fgw=
=TXSE
-----END PGP SIGNATURE-----

--ahPoXcnEvQcnarTl--

