Return-Path: <linux-kernel+bounces-112454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB8887A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8588282071
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697A258AA7;
	Sat, 23 Mar 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1bhn+Lm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABC53361;
	Sat, 23 Mar 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711220390; cv=none; b=tQpJD7RZbxWXVUuEAizNLjnKYd5XRLC0ghX/N4Xha9+343SQLwuPbcfWwDBzO8cw70HT+Cy89k4f5XkP7pkVZ1KCNhaX78CSsfFojkhvZTtt3hWUfWJgwCjrkGNssvb7801cFw0aTZGAf5+QgK8wWFZKy/O/aXpCXi10jZygQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711220390; c=relaxed/simple;
	bh=Y/htR2XugPbloOUL0n/2gOxXFOGMv0kVDQBoVfgT2TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmbHQAWp1irr1v47nokt3adSd5UzkoifR+wmBlZXUfs7DBqt1x6Q0sT9mYjdN6Ui7MCWYyIehRGDkrHnj6aK6uVS3nOMYOE9bGvVzQRdMXGWhF5QX6zy0IV5IPE3lmGN7e/1bKc6DG0mdO8NtLKIAVBaUfPuPfk6XrMkfY9cX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1bhn+Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD17C433F1;
	Sat, 23 Mar 2024 18:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711220390;
	bh=Y/htR2XugPbloOUL0n/2gOxXFOGMv0kVDQBoVfgT2TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1bhn+Lmw87ktBbgrEHn0K/f54NNoP0SfqmY8VEXpjlvCmeTXuTmotSHWkYJUicSf
	 Y+0m6D0fo6P9ucbGIK3RoELXZtjxkRkfHGWZNkDTgFQca1qT1LYrafaSo/wyPe9zRe
	 5OieBzBkWaZeH+n5v+ydxZF0tBGOyp1A7Gk5BOt7ai8rHgmc8lEI4LzUtlvGZhMgY3
	 w1YyRUOExNZncKmyZKno3xuykECUO5iKCoNixBNtR7s0uicH/yZ4oEevwUXuKt6RNi
	 E1cXMX/EY5eHUENxSRlO5hSUfDjpbLw6QZ/quvjVHtVzeQVtKDPrHz8UcWONSt1Rbb
	 0B9VYIn0Vsgnw==
Date: Sat, 23 Mar 2024 18:59:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robert.marko@sartura.hr,
	ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: net: ipq4019-mdio: add IPQ9574
 compatible
Message-ID: <20240323-subsidy-thrash-4860285fadfc@spud>
References: <20240323160935.2848095-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZTU7TAzTO40/oK9T"
Content-Disposition: inline
In-Reply-To: <20240323160935.2848095-1-mr.nuke.me@gmail.com>


--ZTU7TAzTO40/oK9T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 11:09:34AM -0500, Alexandru Gagniuc wrote:
> Add a compatible property specific to IPQ9574. This should be used
> along with the IPQ4019 compatible. This second compatible serves the
> same purpose as the ipq{5,6,8} compatibles. This is to indicate that
> the clocks properties are required.
>=20
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml=
 b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 0029e197a825..a94480e819ac 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -20,6 +20,7 @@ properties:
>            - enum:
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
>            - const: qcom,ipq4019-mdio
> =20
>    "#address-cells":
> @@ -76,6 +77,7 @@ allOf:
>                - qcom,ipq5018-mdio
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
>      then:
>        required:
>          - clocks
> --=20
> 2.40.1
>=20

--ZTU7TAzTO40/oK9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf8moQAKCRB4tDGHoIJi
0hEGAQDf59+J7anuJNNdHglpOi0I+Mnh3MREBiFZuCoCIfijIAEAq8Ljd4BcvdIg
nmWddEf+CIj4Go4q+NJnSj+kvoOqlgI=
=bXI/
-----END PGP SIGNATURE-----

--ZTU7TAzTO40/oK9T--

