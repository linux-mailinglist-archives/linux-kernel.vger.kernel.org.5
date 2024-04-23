Return-Path: <linux-kernel+bounces-154524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67B8ADD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D991F2237F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57D20B12;
	Tue, 23 Apr 2024 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnImTPJK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D31C2AD;
	Tue, 23 Apr 2024 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849666; cv=none; b=Q+TzJ1Nnc3liS4baEcwY/Tx1KoQtgTAnD69VNbvJJtYFU+Fv+hVOFlMdrutgVwkItY0AsbITVBGZ5sBN6K3Mk/yYWpA+uJ3CIiw2guMpDk/XjheOprRQoziyV4JqFrJSBEP7tkOdYFXAD6Zzt/puhp3pgCBp59NFvkReuSgal6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849666; c=relaxed/simple;
	bh=ZswWhlTMmhko0aj4ivj2k/t60uuVf4PrmKJ7kTdBZeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+Yi177NLtPVkFYoX8hXDHqD6NbNq9MJmYGTwkaOQAu5k4gyE0jhIPwc6OjOnmNtvggHLrcHfYfcK6/U2gsy5HF1yENGTlEiz/QRDrfdSPIp+m6MpOai4J3KPiAx/5xoG/aQeqos3mKoLrGPTAJAnn9RFLu9Hw2Kvzp+xa1Epyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnImTPJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F16C116B1;
	Tue, 23 Apr 2024 05:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713849666;
	bh=ZswWhlTMmhko0aj4ivj2k/t60uuVf4PrmKJ7kTdBZeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnImTPJK9V2l9W1kMX9zxePnE2fgacYV46X5nbb7L1jGTqmCcw1ImUoCYc1V2CkNa
	 5ZuxQqwfAIPDQFAlyzCCst684a5xF1DbGDP2K/TLGiMY21AHsWgtlHM/ydeY2WUc2/
	 6bz6HIBH6JQkv9QnkRqTQ0oA6Ye7feWEP7tN3kP3KaLsBF1shsTURTmy9wDsa3OqBD
	 RhdSePRfYoK0cJdMKXWQKc8OJ7ocUn9zTZcBOqMEmytsdXDxaW19qQohz7xmVURmGl
	 BYYBdPUSNDhHGCQpNhLbu9hcBWKYSb53h9Z+CSwzj5BJXMJtdfd3DNjyNdXvzZUo4y
	 oKI4XqjNxpT5Q==
Date: Tue, 23 Apr 2024 14:21:01 +0900
From: Mark Brown <broonie@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/5] regulator: rk808: Support apply_bit for
 rk808_set_suspend_voltage_range
Message-ID: <ZidFPcN6Pf-sUKfi@finisterre.sirena.org.uk>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <20240416161237.2500037-5-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NUAfS35NA4QvAbRI"
Content-Disposition: inline
In-Reply-To: <20240416161237.2500037-5-knaerzche@gmail.com>
X-Cookie: TANSTAAFL


--NUAfS35NA4QvAbRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 06:12:36PM +0200, Alex Bee wrote:
> rk808_set_suspend_voltage_range currently does not account the existence =
of
> apply_bit/apply_reg.
>=20
> This adds support for those in same way it is done in
> regulator_set_voltage_sel_regmap and is required for the upcoming RK816
> support

Acked-by: Mark Brown <broonie@kernel.org>

--NUAfS35NA4QvAbRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYnRT0ACgkQJNaLcl1U
h9CQVgf/TrO/tVGh24ZFos9SFprJuo81/na0GQNHnAi/NhojgiUcivEkDIp7r27Z
N8OHQW09loPotWNYBsIJDDA9WCfymwrYjdRBn1QUxK7tIdOiyJomYZTZmhpPLxQ1
8z6qA8n0eWDKZ2ZXPfuEwBUpN2N7EkwYlvwZz16K4aRv4zQGBG467/k2zi2Uslco
49NHDMGgsDWOCWJtkjf6VjaMuXdjB51hAUws10GPBsD3RpKnKyLVuoViDPdu2DC0
6bjSqpVke4soIk5DOCLV4qpT6oJjVAVLYLELc0Z7dornlY3BZ81H6cQKGsJ1ZNXQ
ityIeEg8GJIyvUHJQqB4aN9gvERu3A==
=yn2Q
-----END PGP SIGNATURE-----

--NUAfS35NA4QvAbRI--

