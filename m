Return-Path: <linux-kernel+bounces-30333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAFC831D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AF3285CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDE28E0B;
	Thu, 18 Jan 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOOwysb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120D2C18F;
	Thu, 18 Jan 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594193; cv=none; b=P2Xnmy0PWtuPAZi2spYaeMG4w1z+0504hZ6QYQYVlC+CywSrz15UkHX9Clv+96g0pZSSqTwGI480Zv63jQuDcuNSQEitlLnMGkphYaq1+Zus3gUtt1LlDy+inXk5sQxg93UDjI937Q88sv7R1w4b2+uV6cI9rV5m+ACcBcCLWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594193; c=relaxed/simple;
	bh=MhRgs4SfId0IliF1C6eg+0vnzN3x0xDMakUJ9MxoW+U=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=YwcsdmamPZPVCAyTB7FEhzwYObfktm7uiGrpIFY/bYVuCAAdDLRsjsyLFal7+ceKagQXlIKiKOwQBXEtrUa/b4s6kBb/qmp5kxAOhO1XKhQHZqs2x5hu4Ty7sK8NpLhsHGX+8AffnQ0In75j1zgofUt32YjrUYkmEsbyWboH+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOOwysb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472AEC433F1;
	Thu, 18 Jan 2024 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705594193;
	bh=MhRgs4SfId0IliF1C6eg+0vnzN3x0xDMakUJ9MxoW+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOOwysb2saJ3EFaZXFxosNe9UNtVudcOvkatUxZo2Yg8vaqhHUtK/9tyVcFy1UEB7
	 8ouvns+SVlkqj5JW/fkEFsMu+oAuXKM1duNgSBdY/6pqqFHRJtyh5Ll6k6aYhrt6OS
	 xvnuZpCM4OlvW+eEZ4RwQGtN+zxu4/lU8ej8CqF0pwUvwXAmu6aFaGc0cWwEYPeGSz
	 hSxaxzXKm8QSKLtf9zLQlMztOG1FOxiza5lgvxCPem/j5ilDD509LODn7+EVMsaZV3
	 LxMTTFN21gdQv9C0nlPwjv9Z059wXehasApwVqouWT6G9Sd0qNkp1HbNaXm4m2p7Ng
	 fJ4+HvnBrf2hA==
Date: Thu, 18 Jan 2024 16:09:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240118-steadily-coauthor-de8275118901@spud>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
 <20240118085856.70758-2-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+4Loj8oukG31gb2"
Content-Disposition: inline
In-Reply-To: <20240118085856.70758-2-kimseer.paller@analog.com>


--L+4Loj8oukG31gb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 18, 2024 at 04:58:55PM +0800, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V5 -> V6: Moved array of switch and attenuation GPIOs to the channel node.
>           Changed pin coords with friendly names. Removed Reviewed-by tag.
> V4 -> V5: Added Reviewed-by tag.
> V3 -> V4: Updated the description of the properties with multiple entries=
 and
>           defined the order.
> V2 -> V3: Adjusted indentation to resolve wrong indentation warning.=20
>           Changed node name to converter. Updated the descriptions to cla=
rify
>           the properties.
> V1 -> V2: Removed '|' after description. Specified the pins connected to
>           the GPIOs. Added additionalProperties: false. Changed node name=
 to gpio.
>           Aligned < syntax with the previous syntax in the examples.
>=20
>  .../bindings/iio/frequency/adi,admfm2000.yaml | 129 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmfm2000.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm200=
0.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000000..6f2c91c38666
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  Dual microwave down converter module with input RF and LO frequency ra=
nges
> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each=
 down
> +  conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    type: object
> +    description: Represents a channel of the device.
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 1
> +
> +      adi,mode:
> +        description:
> +          RF path selected for the channel.
> +            0 - Direct IF mode
> +            1 - Mixer mode
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]

How come this is an enum, rather than a boolean property such as
"adi,mixer-mode"?

Cheers,
Conor.

--L+4Loj8oukG31gb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalNSwAKCRB4tDGHoIJi
0qUEAP4wbPpsMMqtWJOb6/QiW0MysXXQK+sUEvHTlHRvuvRArwD/ZLMdTg0x8lnf
WkfJ4ASDBBU6gUzxhaCqkRYPQxWwkQs=
=GfIu
-----END PGP SIGNATURE-----

--L+4Loj8oukG31gb2--

