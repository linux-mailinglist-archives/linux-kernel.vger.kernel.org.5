Return-Path: <linux-kernel+bounces-154525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF888ADD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28631F2241E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6A20B3E;
	Tue, 23 Apr 2024 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0dZjCTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBE208A5;
	Tue, 23 Apr 2024 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849696; cv=none; b=jntXCpcY+kPbz8tYgOqNS2DtyFa6TDzpxoCWD+mXEa2NGqU0rDHKwkISjJr76qXyux9JmgqSBeDRwLQRQYceSkfXGsoswKNLjTzhrT4eOw2+xs/232WSc+EyjnUM67X6ySfiq/fQxYiBeCJArRWwq4keu+odNgJ/d9NANkhn4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849696; c=relaxed/simple;
	bh=sK2sG+Yk1eyVMAcKz99M4hTNa4idEn6NIV5iSraAC4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zduh/cXqN7m+FmNzWemFGPltbraMDVTaDlVVpnaieDDAtS7jvzpDPArYwrFxllj6ftPQj/lrQ24C/qnpGYlKjwyulhmNMhCHIVfOG9oIq+Oi8W5RNs6ghIxkrc3Thrclk2n8pvnC9xvnlcxn2AnKWjhq0+E0cffAoHXOXVBJq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0dZjCTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0624C116B1;
	Tue, 23 Apr 2024 05:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713849696;
	bh=sK2sG+Yk1eyVMAcKz99M4hTNa4idEn6NIV5iSraAC4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0dZjCTVNT7p8HV9ZGzskhDCkihAvdGe94wKGKt9HsJbsHkS3GOv8jxCa65co+mLz
	 1iejjfkh0USAUWldBr/NQRjDEc0EzkDxaJVq+MpfYc91NoXS2Eu2Kg+A/XU1YoOc+n
	 iG4cIHRcVyrDg3zB6zbC6txkUlj/yXHjEMz0kv4aQgOSV6jLCq7aPw5fI066YXq2QI
	 4q0SlVvJPYLDqxxV3pl1Yd0zAeDT7Qrcgo/iiRn9kakevu/GYIuiSFXF5nx/uW9cDd
	 PtM8cGdJrrDAx/IvOZp30vmkxhlAzB3g0voSP6SjCjuWrJdUbOjdjyEtmsigZg56Iu
	 elZi3nrVCPDOQ==
Date: Tue, 23 Apr 2024 14:21:33 +0900
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
Subject: Re: [PATCH v4 5/5] regulator: rk808: Add RK816 support
Message-ID: <ZidFXYWsyF3dqKPc@finisterre.sirena.org.uk>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <20240416161237.2500037-6-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="edwkBWnAOkIWz+DT"
Content-Disposition: inline
In-Reply-To: <20240416161237.2500037-6-knaerzche@gmail.com>
X-Cookie: TANSTAAFL


--edwkBWnAOkIWz+DT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 06:12:37PM +0200, Alex Bee wrote:
> Add support for rk816 to the existing rk808 regulator driver.
>=20
> The infrastructure of the driver can be re-used as is. A peculiarity for
> this version is, that BUCK1/BUCK2 have a (common) bit which needs to
> toggled after a voltage change to confirm the change. Regulator regmap
> takes care of that by defining a apply_bit and apply_reg for those
> regulators.

Reviewed-by: Mark Brown <broonie@kernel.org>

--edwkBWnAOkIWz+DT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYnRVwACgkQJNaLcl1U
h9DTogf/Ykl5PY89uUB7zyb2xxrcTx3j8+lRI+1zjAK2APX8PJn7+Bzfkd1gklx8
4o/Z5S7wfOSbiesa+sz9Y+KR7annPhlFqp662aU/xnJY1kC5vZiBO4oUx0zQbcmz
9Il1QRtF3X2gpNPzjJxv9lc285D2vZHCG4Ub+UqFzvR5UoktXtxnpR+mY/zcxqH3
PYX4tmn7vPH1rp77UTYq+n6xxmpCXRrRRsAX3ZoiXrrohKKv42M8SbQgw0JpGb8Y
yM4RoyR/rZfMGV6y111xPcCSJ/FI/MuyQwpWJXHsiRVUWNLHv8N7qxy1AaDWLzAK
6zV0jAE+pNXxS5XLOSPO1HhLFI1A8g==
=O91/
-----END PGP SIGNATURE-----

--edwkBWnAOkIWz+DT--

