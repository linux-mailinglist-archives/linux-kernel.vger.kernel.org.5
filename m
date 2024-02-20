Return-Path: <linux-kernel+bounces-73585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6485C48A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7828375E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F5137C51;
	Tue, 20 Feb 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avH2Kmj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA5612D7;
	Tue, 20 Feb 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456868; cv=none; b=iWbdHBrKqrFQZZrGJwnLBnTWk5qVQ2aDXyQDkswU7/Hk+dPq2X7LZpFMe1DCfVDvVYWeqgPqrMjAZ0MpcDICPlHLGDef4viSnKk/RIF5v3L8+bCPQmkGLap0q772hQQwEXahXEuHo3Yps9o9+Ul6Fhh9TV5sC9ygT5whLkk+68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456868; c=relaxed/simple;
	bh=/8B+SVqWi9/8HEqD87v2d6g2SFTWC7Ca3KdPMEZ4hJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVJ3+Rr+aVTqtkVtlFllYHrNYmklUeZtLeq+1QIRkDI7EBwn7omcpWVyHH03gFrMatfP9OuKrkxNnNgV6kKjq93UugnALm/mj+jK9fzd+QyKt1+zMGnWVZOU6GuqxD3Lbct1xzKHSovBvLe/AwKZ7rug9JOiIdhOCcWZvKMMDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avH2Kmj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C468C433F1;
	Tue, 20 Feb 2024 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456868;
	bh=/8B+SVqWi9/8HEqD87v2d6g2SFTWC7Ca3KdPMEZ4hJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avH2Kmj6V6pPV3DJYLy/6Q6Fd8qpMmAZnbeSs6qPatt2gZe4JKwM9xm9ttLszoNkB
	 9i4jdv+jycnTa7sHbthKxGgaT0jpiDsrGp/epBZQ7YvDqAzp2Mt97GcbXzN7/eKG+u
	 BmAdO32WMEtMlKvrmDdTDxuAO8sXnGdiOZea2GRhniwwh9+9blCYB7KlxP5Cx6lVkj
	 bVaq+vnjJwv4G7+e5ESyZooi67F4ghdUGfFy3XCSef93zHAwuIi62lKMYjuWTa0TYZ
	 21HWhEl3eBL8AVemu1ZbKIPItCpEdXtHA7bsGYd+KUrHMpCa0ZZ/I2l8z9WMsIBU8x
	 uW8uMD1xBonwQ==
Date: Tue, 20 Feb 2024 19:21:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: antoniu.miclaus@analog.com, alexandre.belloni@bootlin.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <20240220-unified-payback-13b0964c8c29@spud>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
 <20240219221827.3821415-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lr0x75LRIzBUufR/"
Content-Disposition: inline
In-Reply-To: <20240219221827.3821415-3-chris.packham@alliedtelesis.co.nz>


--Lr0x75LRIzBUufR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chris,

On Tue, Feb 20, 2024 at 11:18:24AM +1300, Chris Packham wrote:
> From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>=20
> Add devicetree binding documentation for Analog Devices MAX313XX RTCs.
> This combines the new models with the existing max31335 binding.
>=20
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/rtc/adi,max31335.yaml |  70 --------
>  .../devicetree/bindings/rtc/adi,max313xx.yaml | 167 ++++++++++++++++++

There's no need to do this rename. Having the filename matching one of
the compatibles is our preference.

In addition, it makes it difficult to see what your actual additions are
here. Fortunately, applying the patch locally allows me to use colour
moved and all that jazz, so I can see that the underlying changes to the
file actually look pretty good.

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@68 {
> +            reg =3D <0x68>;
> +            compatible =3D "adi,max31329";
> +            clocks =3D <&clkin>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
> +            aux-voltage-chargeable =3D <1>;
> +            trickle-resistor-ohms =3D <6000>;
> +            adi,tc-diode =3D "schottky";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@68 {
> +            compatible =3D "adi,max31335";
> +            reg =3D <0x68>;
> +            pinctrl-0 =3D <&rtc_nint_pins>;
> +            interrupts-extended =3D <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
> +            aux-voltage-chargeable =3D <1>;
> +            trickle-resistor-ohms =3D <6000>;
> +            adi,tc-diode =3D "schottky";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        rtc@68 {
> +            reg =3D <0x68>;
> +            compatible =3D "adi,max31331";
> +            #clock-cells =3D <0>;
> +        };
> +    };

The one thing I do want the comment on is the number of examples.
I don't really see what we gain from having 3 - I'd roll the clock
provider example into with one of the other ones I think.

Cheers,
Conor.

--Lr0x75LRIzBUufR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT7ngAKCRB4tDGHoIJi
0gcVAQCUm3UGEM+Z/9EWoRiY+5d63k/n2Hnz9XUiLW/AZJehEwEArBjG41/eCY1Z
LV4ymimhjQsiORRNpOuiTwJItdYREgY=
=hOoo
-----END PGP SIGNATURE-----

--Lr0x75LRIzBUufR/--

