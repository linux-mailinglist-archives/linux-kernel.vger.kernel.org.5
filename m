Return-Path: <linux-kernel+bounces-35310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE8838F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2021B268D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29395FB97;
	Tue, 23 Jan 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctr0fBBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A475FDB0;
	Tue, 23 Jan 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015127; cv=none; b=ZRub9tmvXgZU8E/HTY8+OweYTX1kR80Yf38Ot4yxPWp+yYBTycVB2W8eEqAnq14/bC9pn3iIdhA5M4hyBNbgq+Ka6tpCqL5s18vulTQ1kfcARcAPVJPWfy9ojMzbtOVq5bHXDJh1WWM98OBWrov2yZWrfIZ23IQYVU9ABcwvIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015127; c=relaxed/simple;
	bh=NC2SBjf4G4LZDr8Uy1pZIztgxM81v01wdVZC8CaieWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t15RK8quLp7MzNNRYtXv6YdMYPw8B33cjEiBI7Up2U7WyS5fodAvHJTDQyJuMlQCyr4Bbr43zgE6tvsSVcHgQe4iADsTghexfWuMfg8XsOIWrEdbCSPGvYD2U6ifyiw3m9a07rs3qLqW37nGqeme90Tn0z1TflDRef5O7JFnp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctr0fBBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1CBC32782;
	Tue, 23 Jan 2024 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015126;
	bh=NC2SBjf4G4LZDr8Uy1pZIztgxM81v01wdVZC8CaieWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctr0fBBH7qw/d81eOGdjaoGoJLrOTMoko1RFXnVe1w4UD8O38W2UFMNfPoIGFN2Hw
	 9qEY7yeNv9BIMnnjCV7h9Kxomlcfg/FSDUYbICnxB5IabrU7qTyeum9WdRbz3zyilU
	 KiuQ2Fo1CnXHf7GlyqnXtVBbRhP6vMXTvmToh2+CVnlxLqwtTVqfpE5n3w9sjYRi67
	 uPljZxLusAMZKADs/9xUd59GiosAT1HIBThb3bZD8HyKEYXFmwXHNFs5d4MbArkYdX
	 5X+U4r6UGz3lWHtLbTYS9TT0IT0rj/EEn3KP7I6JS3qJCHUSDmRMnLT+qUTdKf0EWI
	 +BCCQoce5ORnw==
Date: Tue, 23 Jan 2024 13:05:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-ID: <93fee0e1-ce92-4aba-8e4b-0861f78c32c9@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
 <Za9xnEXYczA5rsw3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f373qjpYXgEyzeWN"
Content-Disposition: inline
In-Reply-To: <Za9xnEXYczA5rsw3@hovoldconsulting.com>
X-Cookie: Stay together, drag each other down.


--f373qjpYXgEyzeWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 08:58:20AM +0100, Johan Hovold wrote:

> Could you consider applying at least patches 1/4 and 3/4 for 6.8 as
> well?

Please check git and resend anything you think has been missed.  When
you resent the whole series rather than just the problematic patch that
most likely confused b4.

--f373qjpYXgEyzeWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvuZAACgkQJNaLcl1U
h9ArUQf/fqtc9mZcxQYwBT78ghoI6k7z1q3af7Iqh0gpSRanrp2nFO0pSY0zQBDy
9+/cFUdlbrSqX2ldPE0vNIgM79WOp7nAUyVQfY6qntqSgYEaLbl+W50m8n8pknyt
tnF1tCz9LWsEr4qw/9p3G/aNM2znSQamjXyiNVAXHSjDR3oe713e+OtpTMsJq8D9
6x5c7K0I2FGmNEfvcjp3zn51GWp2jfnkbO/x3ikbKJsKFYbfzoic3RXFXlRHmAz4
/ptS3k4pB0iInw/a2E2ma59NxxvzkUjzJVzRHLlAC51FqhBHags2j5jFWfD9lAV2
7dnlGWlAbdS0kExjFwxAwc33hzkjVA==
=Be7j
-----END PGP SIGNATURE-----

--f373qjpYXgEyzeWN--

