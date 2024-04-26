Return-Path: <linux-kernel+bounces-160392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58518B3CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E01C221AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970915AD8A;
	Fri, 26 Apr 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3f8wcIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B9F1DFED;
	Fri, 26 Apr 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149498; cv=none; b=B7NTQTa9afGDYGjXlLIsCi8b1o5Z8FtA7UXJY7vqRbHKZVLJFsFeGQhTKxWca2AQCf8Mw3QkME06/Rr+Tb6C6MrWJrY63ocLz9UwIM6eR99AltAiLcic4mcr4MxdKoZc1MSCEHgbj4YgAhlmOunL7RdWh8mKHbdFaUPgl+uJ+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149498; c=relaxed/simple;
	bh=Uecbo/6shl3q0S3AL6aRW8DkOSBrWxej2E2gH1SLHkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoOqMRkbJXqkm8V4wh5nfJlOvq9oLRQhzEjhESfOoBTpKTeG1i6yjS9oguOSTXgLzGM/kkMbKlc2qzVujeJNAP6BG2e1nAakopNakL2cXfvZDHehRIvwyXFNBLpd52SFxFd6nRKjLqa9fMQ/mOlW4C9S5yEdOKcOF0KSoLMfu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3f8wcIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E3CC113CD;
	Fri, 26 Apr 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714149497;
	bh=Uecbo/6shl3q0S3AL6aRW8DkOSBrWxej2E2gH1SLHkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3f8wcIhNMPjl1V2HRhlaXZ3i8UJFsDTD1o0/gLChhJeUwCuA/lTpDEtYE2x28su4
	 8xaoWGIzeghSRFLZRLCigYAzTD6cOQIpBvY3TJ5XoSeLTzE5JTQrncOHk0PimILt71
	 C3zcL/ioOO0BQuilMLD2+wWedOLmaMD8+q38hA7GC7zA8BK3CO+rwU95EVO1R40kc9
	 JLMvW6IqzUQdM62cwgq+m0Llvr++moJDd5po+LaABqhU7PkD2gu/FL27SBoLqMfSO7
	 Sk9KdRxw3tW3IcCY1z+Dw4Uz2rrHLKDZtXrR843Bdxu15hzg2n+59mKVVbEEsEXHXm
	 K3H8dgVGCK/pQ==
Date: Fri, 26 Apr 2024 17:38:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH 6/7] dt-bindings: iio: imu: Add ADIS1657X family devices
 compatibles
Message-ID: <20240426-museum-sanitary-b3dd62191b99@spud>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
 <20240426135339.185602-7-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rnxiZPdD0LG8bJTm"
Content-Disposition: inline
In-Reply-To: <20240426135339.185602-7-ramona.bolboaca13@gmail.com>


--rnxiZPdD0LG8bJTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 04:53:38PM +0300, Ramona Gradinariu wrote:
> Add ADIS1657X family devices compatibles and specify the according
> maximum SPI baudrate.
> Similarly to other ADIS1650X devices, ADIS1657X supports sync-mode
> values [0,2].
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
>  .../bindings/iio/imu/adi,adis16475.yaml       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> index db52e7063116..9d185f7bfdcb 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -37,6 +37,12 @@ properties:
>        - adi,adis16507-1
>        - adi,adis16507-2
>        - adi,adis16507-3
> +      - adi,adis16575-2
> +      - adi,adis16575-3
> +      - adi,adis16576-2
> +      - adi,adis16576-3
> +      - adi,adis16577-2
> +      - adi,adis16577-3

I'm not checking all of the structs for these ones against eachother,
please explain why fallback compatible are not suitable.

Thanks,
Conor.

> =20
>    reg:
>      maxItems: 1
> @@ -98,6 +104,12 @@ allOf:
>                - adi,adis16507-1
>                - adi,adis16507-2
>                - adi,adis16507-3
> +              - adi,adis16575-2
> +              - adi,adis16575-3
> +              - adi,adis16576-2
> +              - adi,adis16576-3
> +              - adi,adis16577-2
> +              - adi,adis16577-3
> =20
>      then:
>        properties:
> @@ -114,6 +126,23 @@ allOf:
>        dependencies:
>          adi,sync-mode: [ clocks ]
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adis16575-2
> +              - adi,adis16575-3
> +              - adi,adis16576-2
> +              - adi,adis16576-3
> +              - adi,adis16577-2
> +              - adi,adis16577-3
> +
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 15000000
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--rnxiZPdD0LG8bJTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivYdQAKCRB4tDGHoIJi
0p4yAPwPb/81Q1NSAN/X2c3n9FKJGnGEQJzfDTgBp192eJfvYQD7B3LGSK50dfTT
tvUIg3/Cly+rUJ28rhowym1FqAlkUwQ=
=FWbY
-----END PGP SIGNATURE-----

--rnxiZPdD0LG8bJTm--

