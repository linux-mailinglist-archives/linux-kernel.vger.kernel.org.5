Return-Path: <linux-kernel+bounces-36741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6383A5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB58AB2FA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CB182A1;
	Wed, 24 Jan 2024 09:48:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760518036
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089707; cv=none; b=hFz/QcdpNDxKAo9E6tG66c4x3uk370k25D9cJvbS7J2NJSbO8XJnQLjxK9zUqYEHOhEjDjTtEs+kDwqSDCnsclySw3EkkHBPx5CKu265olzcgW8OyzdixnBXT6V3AWsC/qs4mxy9nDRn5kwqgRXsraP/MuJpyyKYvUxw5usi6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089707; c=relaxed/simple;
	bh=y22HqRzsmOQsYLr4WGwc3QzMljL/aweeW4ciyd4mkKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szcbj+dv18qiY4xWQUcMzhLD8KBMKxkMNH1ZAhwME9+X0R2j+4byPE5TePJ510LQvZXUjJVEATVW2qSK0m+ClnpGopBzP1NQP+ZRBCaqW4T3DcVSwOoXB135fhBEc+9H0wE6B193uRwEmFgRcHju6H48tazbyMVV9JkXI+6yNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZrk-0004BM-78; Wed, 24 Jan 2024 10:48:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZrj-0021hH-Cn; Wed, 24 Jan 2024 10:48:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZrj-0071yh-0x;
	Wed, 24 Jan 2024 10:48:15 +0100
Date: Wed, 24 Jan 2024 10:48:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 5/6] pwm: meson: don't carry internal clock elements
 around
Message-ID: <jlrptw2norojxgpfmsybv6b5aq3epkdkqvri2l2rkvtx5qofjd@q4ggezt47a42>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-6-jbrunet@baylibre.com>
 <gyhea42rtydw3g45lfkfbxfm6xcbwibz67vw7xke2sm7powz2a@i33g4pyanu4l>
 <1jttn3w0ja.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bi3q4dz4cz4stt46"
Content-Disposition: inline
In-Reply-To: <1jttn3w0ja.fsf@starbuckisacylon.baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bi3q4dz4cz4stt46
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jerome,

On Wed, Jan 24, 2024 at 10:16:17AM +0100, Jerome Brunet wrote:
> On Wed 24 Jan 2024 at 10:02, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutro=
nix.de> wrote:
> > On Fri, Dec 22, 2023 at 12:16:53PM +0100, Jerome Brunet wrote:
> >> @@ -442,6 +439,13 @@ static int meson_pwm_init_channels(struct device =
*dev)
> >>  		struct meson_pwm_channel *channel =3D &meson->channels[i];
> >>  		struct clk_parent_data div_parent =3D {}, gate_parent =3D {};
> >>  		struct clk_init_data init =3D {};
> >> +		struct clk_divider *div;
> >> +		struct clk_gate *gate;
> >> +		struct clk_mux *mux;
> >> +
> >> +		mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> >> +		if (!mux)
> >> +			return -ENOMEM;
> >
> > I don't like this change. While it doesn't increase the memory used, it
> > fragments the used memory and increases the overhead of memory
> > management and the number of devm allocations.
> >
> > Are these members of meson_pwm_channel in the way for anything later?
>=20
> Not really. It is just not useful on the SoCs which do use it and not
> used at all starting from s4/a1.

This remembers me about the old pwm-imx driver. This was essentially a
single file containing two drivers just because both types appeared on
imx machines. Later it was split into imx1 and imx27.

I didn't look at the relevant differences between the existing driver
and the changes needed for s4, but please don't repeat this issue for
meson. Not sure this fear is justified, just saying ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bi3q4dz4cz4stt46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWw3N4ACgkQj4D7WH0S
/k4dMAgAozpZ4OhSVfUnrblhtpzwr4SXMznUu/lW+ZcUZ39z8nQi29MQxtKkYOnJ
UmUDaTwxqWcWOCGOuIL7XksK2uJOhIpH/kRatrulGYfDznloAAhSN/TSrpQ/BPuX
4P+kRVTDpJggZ6AjKnPZgRqxNOxIpdFhRcKbgpCMuA7FKRNZhB7FzB5qJPn1VM3D
ghXMcPWD8wH1gG4q/4bVk2vnpZFekLy14qP2MNYk+uEptXHM6bFtHhhxyWaCx/lQ
Jd6oR9jeQLudBE0oel+3dHv4rPLV4bc3XSKZBzK5xT5rv2ZXk8IgRoZpRopCkz4O
apNjdhV0xQJvpJ5gDWpPw1TLQVFVxA==
=SWXC
-----END PGP SIGNATURE-----

--bi3q4dz4cz4stt46--

