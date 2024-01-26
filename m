Return-Path: <linux-kernel+bounces-40319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D383DE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0181C22B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029661D6BD;
	Fri, 26 Jan 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNAb6POM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E81CD3A;
	Fri, 26 Jan 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285817; cv=none; b=KHADTA1udrZGlyvw21FwRopMgh3palwRGcrUgdbrBIzCxRTvOWVIU5BTO/t/vvTDujK73zHnltes2EIP0E/euLEl4ShJqIvmF4D4jW4/Q6mYNcAe4JBqCkJQ2vPD5GY8T80QmZEbl9IK+lK4B1WLZPwsF2gEfjhkLW7ps8pV6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285817; c=relaxed/simple;
	bh=gwEC0mZ3wmaz41ZWSaPrbffP1dL0wcfSE1Ji9/A1WeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb86kpOBg7Mvyuux/E7vHrLaoZDwoPXaZR0coGuJGdxVPZuGbXhT0aeVjFFoidAUxCfVIKbWMipUbYTaoOeE+Ke2lawafW1V/Dx/Kffcvtq6mo2eR8QQfSegRGK5SCj89LndRsfzf5Wys0dyWpYrXh/CpOhmAyWNUXMLplgnlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNAb6POM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F2C433C7;
	Fri, 26 Jan 2024 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706285816;
	bh=gwEC0mZ3wmaz41ZWSaPrbffP1dL0wcfSE1Ji9/A1WeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNAb6POMddLb+6+2TnRFDDdm3RH0RanBaH+pOWI/j1l8qfSMXQic2dNC15xmUvYqf
	 lF6AXbKdR6psvdkwf7IghSgKttTN+lumUKNt+gpliIqF62c0bxRBjglioVQTguwrtm
	 zKrW97vKNKe/++9q2eCtv3F4j2+DA5iOkNYHbiptKCw4O1lGivv2qIi6VXaiTl1cLk
	 oKWiBUnAE+w9ZHLrGn5es4HvO9nezNERyWcAyiTQ0Fl8tOkNW5MtiSCA2/OKu4PPDy
	 VtbB6JkE8+fr7Ed9uJFegzjayN0oF+VT7eWICpXySLzCYZq/toy26kVd+RjtKauQLm
	 /YXisbX7mWTPg==
Date: Fri, 26 Jan 2024 16:16:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240126-cinnamon-flatware-e042b5773f17@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wvdRtw+17GEGpdoo"
Content-Disposition: inline
In-Reply-To: <20240126115509.1459425-1-naresh.solanki@9elements.com>


--wvdRtw+17GEGpdoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
> Add #io-channel-cells expected by driver. i.e., below is the message
> seen in kernel log:
> OF: /iio-hwmon: could not get #io-channel-cells for /voltage_divider1
>=20

> TEST=3DRun below command & make sure there is no error:
> make DT_CHECKER_FLAGS=3D-m dt_binding_check -j1

This shouldn't be in the commit message.

>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.ya=
ml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> index dddf97b50549..b4b5489ad98e 100644
> --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> @@ -39,6 +39,9 @@ properties:
>      description: |
>        Channel node of a voltage io-channel.
> =20
> +  '#io-channel-cells':
> +    const: 1

The example in this binding looks like the voltage-divider is intended
to be an "IIO consumer" but "#io-channels-cells" is an "IIO provider"
property.

Are you sure this is correct?

> +
>    output-ohms:
>      description:
>        Resistance Rout over which the output voltage is measured. See ful=
l-ohms.
>=20
> base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> --=20
> 2.42.0
>=20

--wvdRtw+17GEGpdoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPa9AAKCRB4tDGHoIJi
0h7+AP9saceOMyUzytSlRwVy5YzQaZ0LZvk31o2TRV06wkAmKAEAoI8Ut9mMne7U
uJOtKAI2Ng+E6A+XyIl9WbuaYrcXqwE=
=kzaD
-----END PGP SIGNATURE-----

--wvdRtw+17GEGpdoo--

