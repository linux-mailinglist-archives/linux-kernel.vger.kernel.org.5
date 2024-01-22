Return-Path: <linux-kernel+bounces-32633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B629A835E33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EAC1C2224D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D739ADE;
	Mon, 22 Jan 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLz1SGly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC633CF4;
	Mon, 22 Jan 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915837; cv=none; b=MdGC/JAnyb/fw1PLXyneZibYsTWJ3rywhhXW8DlfxfuhccuxZFHac3SPFu5b7k4v02+AIIb0ZMML9Nsp4872GjpxuEeyoXtpiYl2H89ZVpyWCvWox56OhZrOnnnVeM3JCaNjTe7h5IXv5WOVvZoYHpkDQHu+4+wMltwsEX0i2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915837; c=relaxed/simple;
	bh=SJtjf/MjCZMy1nILFBzhSsTgmBycvKPPCEOzUiIZXq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyh+KOFZbJQM1gvjBBDWVC0D28V0q69Jg/DK6SHixbGq3ZwsAHo1u+L9pjW6W0qPgDFRRYwZxQ6sbyA8rjgKyrvKCoqVNg+/XIShkzMvEsW3vPf0Ns0Yb6WGo/+8ibJmTZwo9DHeiiWmI3WQhq50wocADgNpS+7rrdOxocX9UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLz1SGly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220EBC433C7;
	Mon, 22 Jan 2024 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705915837;
	bh=SJtjf/MjCZMy1nILFBzhSsTgmBycvKPPCEOzUiIZXq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLz1SGlyW/V7sosoILQzQs6r1oZu3ccVD80whrCRYZyJ5XeiZjWgmjtxZF2NSWlzI
	 qGntkI3APRdufc+JOFaKvAe01Qw2jVnpo08IXlJKbdb8gAhy5bmZ8jrhTB7z1kAUGt
	 bF1AHjIl+5EfLXmO5h2C+RVMtBoVbwJM94SyMbh6c1mGw/PA3wxNO/GLgW5Jler6oj
	 UcJh695leXcYCsOhnpF4CvIZQkzzjEJOTlc7ATZyyqEAMxRgzwNm5chYHnxBRHoV2i
	 ywC37MO51S0o3fHoA0w7bDR+TFVflLrlVF7WZUqLN3i4JJIZPcvrwOI+gjsSDYMi4d
	 WmELyOV2byBmg==
Date: Mon, 22 Jan 2024 09:30:31 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, conor+dt@kernel.org,
	davem@davemloft.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Message-ID: <20240122-asleep-turtle-1dbfdc28e5f2@spud>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fIzGgUpo0CFbCRpv"
Content-Disposition: inline
In-Reply-To: <20240122091738.2078746-1-peng.fan@oss.nxp.com>


--fIzGgUpo0CFbCRpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:17:38PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX95 flexcan which is compatible i.MX93 flexcan
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 4162469c3c08..f197d9b516bb 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -38,6 +38,9 @@ properties:
>                - fsl,imx6ul-flexcan
>                - fsl,imx6sx-flexcan
>            - const: fsl,imx6q-flexcan
> +      - items:
> +          - const: fsl,imx95-flexcan
> +          - const: fsl,imx93-flexcan
>        - items:
>            - enum:
>                - fsl,ls1028ar1-flexcan
> --=20
> 2.37.1
>=20

--fIzGgUpo0CFbCRpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa41twAKCRB4tDGHoIJi
0rJfAQC+h0zwH4TAxjx76Fgcbl4D8wnEY3ewf+cklyIyFygXigEAwWTyBbRgsMyi
AYPezcii4mAB9kXmAvcXuJlqgM5ZeA8=
=JFrG
-----END PGP SIGNATURE-----

--fIzGgUpo0CFbCRpv--

