Return-Path: <linux-kernel+bounces-28804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893D83032E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702431C20901
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE314296;
	Wed, 17 Jan 2024 10:03:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2E14285
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485806; cv=none; b=jEfeVS3zL4gc3zweVE5hJZXDcOJ2NrgPFg4dntlLLrFsygvJYMKwfV/5l830Y7KqZUwakiITOZcVPQhXzK3Q7H72kuU/D/N6KtPByUVWce0ZMQFvDj3/jAl5D6DvHQvfOJJBJ9uZsxdEOQOU0KcjMAwslUVmZw8+AUVuU/xgcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485806; c=relaxed/simple;
	bh=2/Pg19mJk7/OgRvVH7Stv2YWNsahvj/2T/Oj3wiLOh4=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=O+pLDaCaBitCsHrA0RS+BN2gmizGFFb4TlhxQdxLhgbP3GWhx22ooq08YJp6jBBKxcCuFKyDzrV7450xc7sv0ho9KNr0wb+VcaSPY4NFLBqPUc6KDYiBkfSqiqLa1DyQbOsi4rUgbrMr8MG5pLC/mdJ6TAOT0fQk5EoP4jgobhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2lR-000651-VN; Wed, 17 Jan 2024 11:03:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2lQ-000RMX-RA; Wed, 17 Jan 2024 11:03:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2lQ-001aYu-2O;
	Wed, 17 Jan 2024 11:03:16 +0100
Date: Wed, 17 Jan 2024 11:03:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
Message-ID: <awxboh3nv4r5p7v7vcgwttu2m74fws47johb73c5f7econ2qqu@zl5xbnoeyclq>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbfbzv6eijurrhvz"
Content-Disposition: inline
In-Reply-To: <20231222111658.832167-2-jbrunet@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bbfbzv6eijurrhvz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:16:49PM +0100, Jerome Brunet wrote:
> s4 has been added to the compatible list while converting the Amlogic PWM
> binding documentation from txt to yaml.
>=20
> However, on the s4, the clock bindings have different meaning compared to
> the previous SoCs.
>=20
> On the previous SoCs the clock bindings used to describe which input the
> PWM channel multiplexer should pick among its possible parents.
>=20
> This is very much tied to the driver implementation, instead of describing
> the HW for what it is. When support for the Amlogic PWM was first added,
> how to deal with clocks through DT was not as clear as it nowadays.
> The Linux driver now ignores this DT setting, but still relies on the
> hard-coded list of clock sources.
>=20
> On the s4, the input multiplexer is gone. The clock bindings actually
> describe the clock as it exists, not a setting. The property has a
> different meaning, even if it is still 2 clocks and it would pass the che=
ck
> when support is actually added.
>=20
> Also the s4 cannot work if the clocks are not provided, so the property no
> longer optional.

s/no/is no/

> Finally, for once it makes sense to see the input as being numbered
> somehow. No need to bother with clock-names on the s4 type of PWM.
>=20
> Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding=
")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 67 ++++++++++++++++---
>  1 file changed, 58 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 527864a4d855..a1d382aacb82 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -9,9 +9,6 @@ title: Amlogic PWM
>  maintainers:
>    - Heiner Kallweit <hkallweit1@gmail.com>
> =20
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -43,12 +40,8 @@ properties:
>      maxItems: 2
> =20
>    clock-names:
> -    oneOf:
> -      - items:
> -          - enum: [clkin0, clkin1]
> -      - items:
> -          - const: clkin0
> -          - const: clkin1
> +    minItems: 1
> +    maxItems: 2
> =20
>    "#pwm-cells":
>      const: 3
> @@ -57,6 +50,55 @@ required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8-pwm
> +              - amlogic,meson8b-pwm
> +              - amlogic,meson-gxbb-pwm
> +              - amlogic,meson-gxbb-ao-pwm
> +              - amlogic,meson-axg-ee-pwm
> +              - amlogic,meson-axg-ao-pwm
> +              - amlogic,meson-g12a-ee-pwm
> +              - amlogic,meson-g12a-ao-pwm-ab
> +              - amlogic,meson-g12a-ao-pwm-cd
> +    then:
> +      # Historic bindings tied to the driver implementation
> +      # The clocks provided here are meant to be matched with the input
> +      # known (hard-coded) in the driver and used to select pwm clock
> +      # source. Currently, the linux driver ignores this.

I admit I didn't understand the relevant difference between the old and
the new binding yet. (The driver currently doesn't support the s4,
right?) Is it possible to detect if the dt uses the old or the new
binding? If yes, I suggest to drop the old one from the binding and only
keep it in the driver for legacy systems.

> +      properties:
> +        clock-names:
> +          oneOf:
> +            - items:
> +                - enum: [clkin0, clkin1]
> +            - items:
> +                - const: clkin0
> +                - const: clkin1
> +
> +  # Newer IP block take a single input per channel, instead of 4 inputs
> +  # for both channels
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson-s4-pwm

The expectation is that this list contains all compatibles that are not
included in the "historic" list above, right? Then maybe use "else:"
instead of another explicit list?

> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: input clock of PWM channel A
> +            - description: input clock of PWM channel B
> +        clock-names: false
> +      required:
> +        - clocks
> +
>  additionalProperties: false

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bbfbzv6eijurrhvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWnpeMACgkQj4D7WH0S
/k7D8ggArnaDEUYvcg/pgZL5jLaqhKI+CoViERryuLi+QxBL1eWhFvl6XyVCjS7N
FV4h2WdLIV3wdMGKYdCdv9hzleWVaVx1hJDLmOPunTO9QZUmMu6vRYVpsZcpuSpg
T1LNgkK3uEcHBSt6YXynKssZK72/ydv0dDIZ6WZy5+dkdJfWxxCaXubS7Pd6lF8Y
bnOKgErPh/7F0d17TOgIcrwUViGdVt6+d4NbgymqWCueJt/sqX5e81lTn+V3/knM
NypPZ7UqCNgJ/zL9vJpJZsKQYNNM4yA5n0HlHgDZBlzLeYttXHUKhHqnArC4/PWF
CTJ4QZ5qA38yQXWFHypZkl5dLHlniA==
=ZKMp
-----END PGP SIGNATURE-----

--bbfbzv6eijurrhvz--

