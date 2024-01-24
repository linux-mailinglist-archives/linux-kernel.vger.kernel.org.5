Return-Path: <linux-kernel+bounces-37342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248483AE86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E601C22BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9077CF3D;
	Wed, 24 Jan 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxTA1Uf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F857CF1C;
	Wed, 24 Jan 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114464; cv=none; b=b/ei2LtHt199LXjsCkb8rPYQTdW3S6XkCP2DkiQlzuh2/rktn9h15xXqlc9T5H5BD40Bkt0epgM5LclCo5pjcEwJ4Sg1VIOmrYUUKzV6LS360VZ07lU5ahP4bk9QK4vAZkF8jrKyVk80yo1sYpXxwYiiFZbcUGOvJdtUFZxKcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114464; c=relaxed/simple;
	bh=ONOtItDiqerRu78BREMGnu+yeJ0zfW2JVHtYWZ249aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfQm7lP41q6k20FGCP076Dzw1Zo1G4AXXz/Zw22sU9v3F1O4SWYXalLu4A52dabQ/lk2FNcvNSFB1i82zP5h9eNmhDjD+d3sYQnUtmKDdLwXa90ZZapuO5dKcCwbtKbP1AAD+An/6QSfXODuTHYx0mw62iXO4DEmCnKvjiEtXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxTA1Uf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B26C433C7;
	Wed, 24 Jan 2024 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706114464;
	bh=ONOtItDiqerRu78BREMGnu+yeJ0zfW2JVHtYWZ249aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxTA1Uf3IlC2Ga4JaHA7FL9yZn+M+pCSiqz/jNZtCCDjl75Wgk9+Ko4xV3jMhAv0a
	 B18AS49vKQaWw+2bmtlz3pD4YrdPCOLKMQBO85IqYXNLVMIpYKh+XoBQwCd62VeIay
	 VdGE370zKZClitEpeQccu2i/S8WD5CXZ328SjyMjiU/r1ZgsCSy+LPIpmYuOGxIpH0
	 dUSPn7l26mQZXbsQmYO3Mcp6MXzp9PDr/chvKuCAeq4Ru6uOO2JaYC56Hnemi97fW+
	 omnd3qAW1v0JffnytEC3tzY9kMPm/8Wuu4l7cqycUY+4J4xDAZ1l4zoB8mj/9NHKBE
	 qEmqCJMhRyjEg==
Date: Wed, 24 Jan 2024 16:40:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240124-portal-sputter-f5207ac206ee@spud>
References: <20240124100019.290120-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PFa2V87EteAGYYHw"
Content-Disposition: inline
In-Reply-To: <20240124100019.290120-1-dharma.b@microchip.com>


--PFa2V87EteAGYYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 03:30:16PM +0530, Dharma Balasubiramani wrote:
> Converted the text bindings to YAML and validated them individually using=
 following commands
>=20
> $ make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindin=
gs/
> $ make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/
>=20
> changelogs are available in respective patches.
>=20
> As Sam suggested I'm sending the PWM binding as it is in this patch serie=
s, clean up patch
> will be sent as separate patch.

Please give discussion on the previous version some time to complete
before sending a new one. I've still got questions about the clocks
there.

Thanks,
Conor.


--PFa2V87EteAGYYHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE9mQAKCRB4tDGHoIJi
0sx+AQCWoBw03P0+i3/9lXINUcT6usQ2ObrMgRBpWhf2k6/JzgEAmCmKoq8qb8N1
/umMvdxtM/qUvSySnYx/ozU4sQrHYA4=
=BgZl
-----END PGP SIGNATURE-----

--PFa2V87EteAGYYHw--

