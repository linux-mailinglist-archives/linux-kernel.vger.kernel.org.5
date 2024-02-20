Return-Path: <linux-kernel+bounces-73521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C23E85C3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57271C221BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6401339A6;
	Tue, 20 Feb 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6yoiswL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FA12F5AA;
	Tue, 20 Feb 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454471; cv=none; b=jK2kfH6Gy2azKb8Qo7v2ITcr0Ra4Od1VxAb5jtlsufLdjf2zsWMp/2bOBs7jA2JIxdJn4XXCcpmgkhaemndtAMKBNZABBoNQ76hGGN6R52oFVcnhtRuNXPqfbz1Yk+fkrfNWjkJ4JlhcOCTF+MuBSjKa5v7P2k6Y4KWN+rDU1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454471; c=relaxed/simple;
	bh=15wVNh60n0mKgmlzygAoNpmkEvxBvaqNjKfNeAsjQ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ueb46aWJ3x00zNeV1FVSzKmGyY6RPudqvvngIULgg11YRZoJ7mvp7JoxtY/LYQj23h86zQ3wiG9nRurKXOZTiVNkypuNuzyZlWYIi6JxStYH7skOlAkvKdpymXP0TusQxUw8W0CRCGqHZ48DKo5E3cVzf6+VQ6eUGe7tBVj4kpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6yoiswL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B2AC433F1;
	Tue, 20 Feb 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708454471;
	bh=15wVNh60n0mKgmlzygAoNpmkEvxBvaqNjKfNeAsjQ4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6yoiswLuwvRkTOyHtca4QBI0nxQq61xnDFGgF7WkbRQhu0MCSk8+YurXOGrdIiMl
	 3d5XPZ2nvg4A7VQjpqyNT995DJFhhfoW2gQKyrdhURCr+NNitthjAHKDQRccYbqH1B
	 /t9BEYBB+YUfEE87SvH+CPIhYMKMy6KWPiDinKDiyTU7f5dB/o6FU4Q/7xt9V12D88
	 SVpDh/lkadi34h2cIfqSiewK74H6QYjNthXd5VwPI4r5TazIMDnqQbrBuo5BECsrxi
	 gj0kd9p7/av53ieW5iBv48Xs/P8gZcj/EXu/1tZYkg9+JSk7Ofg4lON/xG1wSFGDu7
	 IU94Fw4NbtDbg==
Date: Tue, 20 Feb 2024 18:41:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Message-ID: <20240220-splinter-jackpot-ac1571af5b2d@spud>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-1-02cb139a4931@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NyfVgNR6xsvZmS5r"
Content-Disposition: inline
In-Reply-To: <20240220-aspire1-ec-v3-1-02cb139a4931@trvn.ru>


--NyfVgNR6xsvZmS5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rob,

On Tue, Feb 20, 2024 at 04:57:12PM +0500, Nikita Travkin wrote:
> Add binding for the EC found in the Acer Aspire 1 laptop.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 69 ++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-=
ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.ya=
ml
> new file mode 100644
> index 000000000000..984cf19cf806
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Acer Aspire 1 Embedded Controller
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description:
> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
> +  and charging as well as to provide a set of misc features such as the
> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
> +
> +properties:
> +  compatible:
> +    const: acer,aspire1-ec
> +
> +  reg:
> +    const: 0x76
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  acer,fn-selects-media-keys:
> +    description: Configure the keyboard layout to invert the Fn key.
> +      By default the function row of the keyboard inputs media keys
> +      (i.e Vol-Up) when Fn is not pressed. With this option set, pressing
> +      the key without Fn would input function keys (i.e. F11). The
> +      firmware may choose to add this property when user selects the fn
> +      mode in the firmware setup utility.
> +    type: boolean

We both had some comments on this property, and Nikita tried to follow
up on yours (which was much more substantive than mine) but got no
response:
https://lore.kernel.org/all/20231214220210.GA988134-robh@kernel.org/

Reading what you said, I'm not entirely sure what you were looking for,
my guess is that you were wanted something controllable from userspace,
but I'm not sure how you figured that should work where the firmware
alone is able to control this.

Cheers,
Conor.

> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        embedded-controller@76 {
> +            compatible =3D "acer,aspire1-ec";
> +            reg =3D <0x76>;
> +
> +            interrupts-extended =3D <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
> +
> +            connector {
> +                compatible =3D "usb-c-connector";
> +
> +                port {
> +                    ec_dp_in: endpoint {
> +                        remote-endpoint =3D <&mdss_dp_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
>=20
> --=20
> 2.43.0
>=20

--NyfVgNR6xsvZmS5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdTyQgAKCRB4tDGHoIJi
0uv6AP9Hs2QQv/YYHGYhhHhpqKqfT4EvP4wIJ2I3XnFPTLp7TAEAlyyHmfzBrCjD
AgFzbLCEjTAQEJtMRKbH3EJ7Q9jMRwk=
=2TYU
-----END PGP SIGNATURE-----

--NyfVgNR6xsvZmS5r--

