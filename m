Return-Path: <linux-kernel+bounces-78986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84238861BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243DA1F27AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFC5CDF0;
	Fri, 23 Feb 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGZ0A8It"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074331118D;
	Fri, 23 Feb 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713284; cv=none; b=MORTJUYrk3UTpE7Tqu45rf2CdsMrph2XntmWAL2uB/sD95VxkruqC8kmLzh4KsaTB2vMDJRXpmsI3+PadP/3HrecaRjrVKnjS1uClNEKua2JlSvFo6c5EJQD7k3+WuIONC+jcwQzi7ePGbYfySFa2eT7UZT6JjArRqA/j/BacZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713284; c=relaxed/simple;
	bh=zlETi33+CFuv5hwQm5WZx5u7wTiSlx0umoUQhthd1h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTBSu0vAiO41YQF25Vpu4AWKAYwxs9Fv2Lyf6SpfBatypZPO7hXv5Ya8YYp/UtqBv3BX0pkXICt8VCnJbZsiQgS610xmm6G1A2m7x+Kj5p1NlIN1uWNhJWZogeemzaAPc+IO+cFpjMl5Xy7E9UMN+4T3GCuTOzgmXeWqfEyabTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGZ0A8It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C657C433C7;
	Fri, 23 Feb 2024 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713283;
	bh=zlETi33+CFuv5hwQm5WZx5u7wTiSlx0umoUQhthd1h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGZ0A8ItVnGR6BJDHdNbPYcsFSCvlZxjxY1naGW64VV2gZJCv+ym2Ftd9J035b/77
	 qHrWNpD3fJeO37pLMUDtp/yf1yu2aeMFXNApNM+1qcHHHU5HbUBen1A/WA5p6qrLiH
	 qc2a8GOmToCUIFgejcGnJ8HKhPLeEzfVoIep7Rn93nleAVl36gUjXr2NaNxdX1F73o
	 Tcu165EQGhcd9L4cBidbegOZc1BGsZEF0YY3cyjr6Lwaz4wcdjNLCM0X47VpJXLQon
	 7uLYMJj8UZnCmpAy1mzV0BN2YJnextedsuIf3oWUtTIvwE9egOFLb4HSWEWLmL/Uif
	 K1hE1pzk8jKig==
Date: Fri, 23 Feb 2024 18:34:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: vishay,veml6075: make
 vdd-supply required
Message-ID: <20240223-niece-shakily-7e18b90f30e7@spud>
References: <20240223-veml6075_vdd-v1-1-ac76509b1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hgz/JpkIdG8P36dD"
Content-Disposition: inline
In-Reply-To: <20240223-veml6075_vdd-v1-1-ac76509b1998@gmail.com>


--Hgz/JpkIdG8P36dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 02:01:33PM +0100, Javier Carrasco wrote:
> The VEML6075 requires a single supply to operate. The property already
> exists in the bindings and it is used in the example, but it is still
> not on the list of required properties.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The driver and bindings for the VEML6075 UV sensor were merged in the
> merge window for v6.8 i.e. they have not been released yet beyond rc.
>=20
> Applying this patch as a fix now would avoid an ABI break like the
> recently discussed here:
>=20
> https://lore.kernel.org/linux-iio/8409a5bc71b995e3b738b817a074cfb131c3b2b=
5.camel@gmail.com/
>=20
> On the other hand, from the same discussion it can be concluded that the
> major risk would be a potential warning with dtbs_check, in case this
> patch is applied during the next merge window.

I don't care if it introduces a dtbs_check problem, we can fix those.
The device clearly needs power and at least for linux it being missing
gets handled perfectly fine. I think it's pretty reasonable to do this.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> The VEML6075 driver already handles the power supply with
> devm_regulator_get_enable().
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.=
yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> index abee04cd126e..91c318746bf3 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -21,6 +21,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - vdd-supply
> =20
>  additionalProperties: false
> =20
>=20
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240223-veml6075_vdd-e2220158ffda
>=20
> Best regards,
> --=20
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>=20

--Hgz/JpkIdG8P36dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjlPwAKCRB4tDGHoIJi
0tYTAQC1+0IEYywpMoCMXpgH+lW/sykjfmPF82FwRnlmLuEcYgEAwShTG/cWRfqw
evhM0yVbHRI14c70ha4vcyKGg8SStQM=
=S2Pw
-----END PGP SIGNATURE-----

--Hgz/JpkIdG8P36dD--

