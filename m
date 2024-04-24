Return-Path: <linux-kernel+bounces-156836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259FB8B08EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581791C22534
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C3415ADA4;
	Wed, 24 Apr 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdnEjJzj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F413DDD9;
	Wed, 24 Apr 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960495; cv=none; b=IjroSLY1uKJ+jeh0rg1mDfrTigp1WSudXz4A5bQDhcW7vQ7krADpucEaaB1NDwyKJjOTU+eNBxvKIQ0EJ6yvwfXXGt81luKrRZP5AKeBGgQBkWFdyoW/Qf1AiiX+G1hSFsR3MPd6FcWTmqFy23CTgiLlILbwUbH14z+2UJxpHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960495; c=relaxed/simple;
	bh=XIDRIdvM6seDLp5rS9urHwiVla14vdnVG5FbNeLWF9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVQDkI+es4Q2x0ejhvCdiYV1aCZtPxEzD1Viqdn2O/+PrJsIOxtG/KSWbCrWbDfhm2g93CSeTiQYtFpneHukdhY+kdGTYW/jwjqOI1eUkTWNlqIyip6BQVMFkkhAtP8qI9Bv720nRmCNij4snbO69+liBh1xvNTvtphAnYiWFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdnEjJzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF6BC113CE;
	Wed, 24 Apr 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713960494;
	bh=XIDRIdvM6seDLp5rS9urHwiVla14vdnVG5FbNeLWF9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdnEjJzjaMwTbabFNNrhDkLC6z+lrldg8wq05SR18LT/OPdT+SBJv18zIMYA5oQoh
	 8bqLo0v2AUKxk2Xf6hxwemSumoEw7mTEi6gDi4dsOpBhgv5ruNuI+Z5P5fvCu1BXgd
	 FRzVQpfR4F4krOtS0TIXQ2LTJhWDMmNTYC1wiyaADjzjZHTYPmS53Rwe9D2GjLQjIa
	 owmB5lI8GfRTrovkXwakF/TxkeNHNVp+UZHAMkFMgJ91rZLo0FIbIxGNup+DEtSk1f
	 e8yO/0jXDCe0jMwH9d14bJDYJ+ENpU8ziiGkCL8rpq+Oq4G0o3HCJ306GBrTWVMnPL
	 HrOnskZccep1w==
Date: Wed, 24 Apr 2024 13:08:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: George Stark <gnstark@salutedevices.com>,
	u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
	khilman@baylibre.com, martin.blumenstingl@googlemail.com,
	thierry.reding@gmail.com, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 pwm
Message-ID: <20240424-word-scoring-830983094ff5@spud>
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-2-gnstark@salutedevices.com>
 <20240423-wildcard-smoking-90b50f00da50@spud>
 <1jr0ewezvc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="47Y2FJ9ZWeX1qYH+"
Content-Disposition: inline
In-Reply-To: <1jr0ewezvc.fsf@starbuckisacylon.baylibre.com>


--47Y2FJ9ZWeX1qYH+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 07:44:35PM +0200, Jerome Brunet wrote:
>=20
> On Tue 23 Apr 2024 at 17:56, Conor Dooley <conor@kernel.org> wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On Tue, Apr 23, 2024 at 07:10:05PM +0300, George Stark wrote:
> >> The chip has 3 dual channel PWM modules AB, CD, EF.
> >>=20
> >> Signed-off-by: George Stark <gnstark@salutedevices.com>
> >> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >
> > a would sort before s.
> >
> > With the re-order,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Thanks,
> > Conor.
> >
> >> ---
> >>  Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/=
Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> index 1d71d4f8f328..ef6daf1760ff 100644
> >> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> @@ -37,6 +37,7 @@ properties:
> >>        - enum:
> >>            - amlogic,meson8-pwm-v2
> >>            - amlogic,meson-s4-pwm
> >> +          - amlogic,meson-a1-pwm
>=20
> AFAICT, the a1 interface is exactly as the s4 interface.
> So a1 should list s4 as a fallback and the driver should match on the s4.

Crap, I should have checked. Please make use of the fallback :)

--47Y2FJ9ZWeX1qYH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZij2KQAKCRB4tDGHoIJi
0gnuAP0b+BgwJoXOj4siqxBf/5EczpoJGS7AHdX0u3bkL+a90gEA0jrhT5vIgfb0
hE7m80/W2o2Z0D7i7qG2yePTa/lmwAA=
=2KkJ
-----END PGP SIGNATURE-----

--47Y2FJ9ZWeX1qYH+--

