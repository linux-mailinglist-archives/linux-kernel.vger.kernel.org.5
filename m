Return-Path: <linux-kernel+bounces-164428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B88B7D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C28287612
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25C17BB15;
	Tue, 30 Apr 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYw/+70G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602D3E478;
	Tue, 30 Apr 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495838; cv=none; b=O+jDpQ3ZdoSZrmQDOnz/mkGDjCCOLH/XZPHfN4fzd/OuGtVphadR53/dwme8idrp6PaH3JZrszEiPCo+r2dQey/4Z/WT6uMgpmSaGIK/nrV9oONtLpXlRYYji8Tlx9b0XheHlyc2yrmcqLe6bmiTnFRDYAujB62RrOR90qrRyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495838; c=relaxed/simple;
	bh=+8BHDhVWwVu3GS/P6257Ar2vN5PR5hR2kbbOEXpfh2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Thb/Bc3PKN5aZ1YwRkOXHC0H7xVZpTMH38qc8oAZ2I1avwmUB1Li0OQsA6zdt375UcbKNQRnj6fEBMzxLztJ+WXQnxQWNYSg33QSbtG/arTU/MMSTIK45DGC/MJ3Bz97Ymsy810WhpD25BMdBnjdzEkEguL2uJLVqEtcF+IKsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYw/+70G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C8C4AF19;
	Tue, 30 Apr 2024 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714495837;
	bh=+8BHDhVWwVu3GS/P6257Ar2vN5PR5hR2kbbOEXpfh2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYw/+70GS/6au2WPmHmgN6Thwkz1jyh5nzE0aVBcHp5R8AGFkbDg/60lLzUON2yOr
	 0AA7m/Ip0KSjiWokQcRrwufFC2GQiOyYI8peFJVct9i286zTth0Mx3Mj9cO6cYNz0y
	 SsnJgtdb2oTF9hYObwXKidRNrvCby7x/CqBtrcDEy0JuLqL9XefxqiWRls+HVTudYd
	 NCwaGXjTbF6CqXi0o++rYtH2vq+E4Q9L+3ZmetFrQsombmGf0Xw/J6tp2J7MTyt9MT
	 dDdtGCrNSnpPOZ789+Ya2cdSdmR+c4ngEMCL9aSMWZq0RbZWWCB0a/0/avw3rGCUUt
	 q+Zq1rc0nel8A==
Date: Tue, 30 Apr 2024 17:50:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240430-unnamable-wrench-16c9ad780df1@spud>
References: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7vbJGUJ6hTxURdMU"
Content-Disposition: inline
In-Reply-To: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>


--7vbJGUJ6hTxURdMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 05:27:20PM +0200, Petar Stoykov wrote:
> From 60f5cc7f65b07124f19428a713c3bc33b9e4a7a7 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 15 Jan 2024 14:29:25 +0100
> Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
>=20
> Sensirion SDP500 is a digital differential pressure sensor. It provides
> a digital I2C output. Add devicetree bindings requiring the compatible
> string and I2C slave address (reg).
>=20
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---
>  .../iio/pressure/sensirion,sdp500.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp=
500.yaml
> b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> new file mode 100644
> index 000000000000..3cdf17df7d52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sdp500/sdp510 pressure sensor with I2C bus interface
> +
> +maintainers:
> +  - Petar Stoykov <pd.pstoykov@gmail.com>
> +
> +description: |
> +  Pressure sensor from Sensirion with I2C bus interface.
> +  There is no software difference between sdp500 and sdp510.

I see no mention of the sdp510 elsewhere in this patch though..
If you're trying to add support for both, then add a compatible for the
sdp510 that falls back to the sdp500.

> +
> +properties:
> +  compatible:
> +    const: sensirion,sdp500
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Other than the fact that a fallback compatible might be required here,
this looks like a candidate for trivial-devices.yaml.

Cheers,
Conor.

> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      pressure@40 {
> +        compatible =3D "sensirion,sdp500";
> +        reg =3D <0x40>;
> +        vdd-supply =3D <&foo>;
> +      };
> +    };
> --=20
> 2.30.2

--7vbJGUJ6hTxURdMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEhWQAKCRB4tDGHoIJi
0iePAQCM8ZdEYabBqAZ3/N0J6SbfM2u1yiUsZg8ucnxWo5QYVAD/V4T5PyyBpItg
Cao4KMUjPMkbCG/iloziUb8n6okN8w4=
=tRMX
-----END PGP SIGNATURE-----

--7vbJGUJ6hTxURdMU--

