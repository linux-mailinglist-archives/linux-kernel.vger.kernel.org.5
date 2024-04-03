Return-Path: <linux-kernel+bounces-130471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5597897894
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AB71C24889
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44F1552F4;
	Wed,  3 Apr 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="K+nl8soQ"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8D154BFB;
	Wed,  3 Apr 2024 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170146; cv=none; b=LJ5wXYwU1nbFKlm5nPAdMMUTAXy0syKGcbviCMuoLHrqDveV67ndHDpBNWv85EMIPj6aoZmapiJL17YO8G2slV3IiJUKeaHRXHAc6caJTpAavJJvu2RCLgS7nXVwYqr/zlPD825+wIY09JcJdhY5UQh4p2ocww0PdvfSjwlPLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170146; c=relaxed/simple;
	bh=xk1bmaMFZ19sGYjOre1kvwVFxkAM10lNnBLw+cdz2Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ05VSEAIFZYc9zB9X3Cy2rIjV/6wTWi5W/r1sEF3F2mqcPA9P+40XuU37utFQv1xxbxeQ6BmqsjjFYQNWu28ALhWIN+XZN2bJSIgsHqDMKPSevgEwfdU5WiNnKQXe3NjM6SkcPL9HxyjdrrBUHx1vemHXB+EF6rcq0M3DaqCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=K+nl8soQ; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7091C1C0087; Wed,  3 Apr 2024 20:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712170143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTvO7HSpvLPJAXcoan3sFBqY0yG42E91r1IgstP0bco=;
	b=K+nl8soQ3Kn3958hzmLx35/ZQUQNEoELSdrsJsgkwP+XHFS50PjSVJ+BM9MSX7qpx8pJGw
	tdaWerEKNpJVDlLclkIsvmjWQc8EjCaNP/hVXNRaJu4CpN2MvhZTCvQOd4+vSs0P+jsr+4
	jUEjz6A/u7/CcX5N7Mjlg3zlG7hnFHI=
Date: Wed, 3 Apr 2024 20:49:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 22/25] dt-bindings: media: imx258: Add binding for
 powerdown-gpio
Message-ID: <Zg2kn5/5T9ukP4nd@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-23-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aOh4Ga+TUReev6xf"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-23-git@luigi311.com>


--aOh4Ga+TUReev6xf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Luis Garcia <git@luigi311.com>
>=20
> Add powerdown-gpio binding as it is required for some boards

"." at end of sentence.

> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Luis Garcia <git@luigi311.com>

If the patch is from Ondrej, he should be in From:, I believe.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--aOh4Ga+TUReev6xf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2kngAKCRAw5/Bqldv6
8m6RAKCkdQdkoikkf2a9bOcvas6pB7XJxgCfWPBVx3InUnnTgSH9LEsRVa2yuDo=
=Tij2
-----END PGP SIGNATURE-----

--aOh4Ga+TUReev6xf--

