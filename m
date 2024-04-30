Return-Path: <linux-kernel+bounces-164500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D00888B7E47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A8B1F22C40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04A17BB19;
	Tue, 30 Apr 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJMHgM0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D917B4E1;
	Tue, 30 Apr 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497340; cv=none; b=sOmm1psmO8EN2ZeA2ULpLT1WCOdgxsIMPeEDwirhANXbGl0WwJXYIyL7W0Qx1OWUvnHFUdaX29yoYSKygvWCA2aBqOYlKz1O1gzC1idvPb8DsWUL8xD/THFiF9mUvJksFbEmF7e4xM5BpPprQ/4+sYOyHmRb/dGTz2U7u+KQ7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497340; c=relaxed/simple;
	bh=LczTJ/3+u06tFbxHtG5qj/8oZxiYyIFvCajsFk4vFgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm3d8doeaBpEE1lJ5gQgi9L0vUG8as/OZZKt7v9s5OuC9UESrGVp4XFlKy3rcMbIjcFcEORa0vCZ5lpq/OSsOd9sk45cs9rGEOFyh3DkPNjSOqVFakoZran6eokw8dxrcy2pClLBoM5rlnS+JSRvpYAPp+zd/LG+tinBlKuDeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJMHgM0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCC7C2BBFC;
	Tue, 30 Apr 2024 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497340;
	bh=LczTJ/3+u06tFbxHtG5qj/8oZxiYyIFvCajsFk4vFgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJMHgM0Q0yyZYiaxgiGeYgaz0/y19jSOAE5eh6VN/SWIMPHanu8Q042ONIs/1BNdv
	 dYclRiMV/z5QXOknvSez2A2H3QL5LrXoXB4wBYoCJG0KEXrt4bZTkcEvXY5yvh+V2F
	 L2RVs+XHEfeOC+PWV+sQR7gJmBNww97ZyItQhNWhn+/9/FYdB95NE/SEswt6l2nLlr
	 em7Lspwnwa59wmhI0xVZTLSAdKS2MN3cKnORIWTDuL7bR4a6pNnnVxRZtouZMIXLjk
	 RYDPWAJXB1sKhdgyiy5ia0gcJoVWoUX88eJKzlZcLItA9PAGsMaPSDh3NVy4Qf6Y2S
	 dIwltWt7ZmN0g==
Date: Tue, 30 Apr 2024 18:15:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v7 4/6] dt-bindings: iio: adc: Add single-channel property
Message-ID: <20240430-perplexed-obedience-91e4bbc158e5@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PDQmOlRp3irkveLm"
Content-Disposition: inline
In-Reply-To: <20240430162946.589423-5-alisa.roman@analog.com>


--PDQmOlRp3irkveLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 07:29:44PM +0300, Alisa-Dariana Roman wrote:
> Devices that have both single-ended channels and differential channels
> cause a bit of confusion when the channels are configured in the
> devicetree.
>=20
> Clarify difference between these two types of channels for such devices
> by adding single-channel property alongside diff-channels. They should
> be mutually exclusive.

I think that this mutual exclusion and the requirement for reg in the
absence of either property should be enforced by the binding, not
described in a commit message or free-form text in the property
description.

>=20
> Devices that have only single-ended channels can still use reg property
> to reference a channel like before.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documen=
tation/devicetree/bindings/iio/adc/adc.yaml
> index 36775f8f71df..0c3eae580732 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -38,6 +38,14 @@ properties:
>        The first value specifies the positive input pin, the second
>        specifies the negative input pin.
> =20
> +  single-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:

> +      When devices combine single

s/single/single-ended/, no?

Cheers,
Conor.

> and differential channels, allow the channel
> +      for a single element to be specified, independent of reg (as for
> +      differential channels). If this and diff-channels are not present =
reg
> +      shall be used instead.
> +
>    settling-time-us:
>      description:
>        Time between enabling the channel and first stable readings.
> --=20
> 2.34.1
>=20

--PDQmOlRp3irkveLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEnMgAKCRB4tDGHoIJi
0nmFAP0SFmFJ06QVr/ZUb8POUYIM+y3lJg9ACZUMhkbdpdaIbgEAlT+Fr0iOnvsi
3Fopg90rdUWM/dPtiohMVjLK6+URqA0=
=6E9G
-----END PGP SIGNATURE-----

--PDQmOlRp3irkveLm--

