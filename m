Return-Path: <linux-kernel+bounces-65723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598278550D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E08428AA66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B261272D0;
	Wed, 14 Feb 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahkMHS9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735C86644;
	Wed, 14 Feb 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933108; cv=none; b=L8fWs24f6vvQGOP5+/mFIZVvFnnq1wdsCS7HGkU2O+t/kShpndJJv9PUdbN/mRcJ6IkAVfKkf4LNclfT0sneU2GCieYaAnxqDtpN2CTMPWOnAh3bS73dL7+EAX9tt+3V2kPm3D1G40KoO5OdrSAIm/wHldyAPXgG+Ti/hi0tGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933108; c=relaxed/simple;
	bh=D7ZXt13m5wJPpJvRrcstm/rrc9ZCgmeDjwqMNKdG5Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSWxIsrRwgKb7/P7BvXZBTMsc5Wp6hCsdelfx4FQ9y+N6QFhsa30aJqRw4JFabBE+fSQzAAco8SYZN6Lyb7w9XGSRIAvr2AWNLsUG/ww59c8Li0NVZ9VdxHUaYqGoDaU3HYs3nq4QZurLsocd6F5xiRc/MbkXMmK0ecRltPUDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahkMHS9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CC2C433C7;
	Wed, 14 Feb 2024 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933107;
	bh=D7ZXt13m5wJPpJvRrcstm/rrc9ZCgmeDjwqMNKdG5Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahkMHS9ijn3AOUwmUoMW3wlEWdyMxVbH9TLN+XkqI5eeIyTjFSfBImfBE2bTu0tpb
	 cK5eaPRpNrlMfTkBGwElJ4NTH/RNgRb1Esv+Q7W/UCpP4tg+3ThrEUcrOziDh4vZ0L
	 nGTG5OTAkjUD1lzDSikFwETwDskjISvEpAvzZXzil+smSPJfbQzOP61NTGFn/sOT3w
	 6OrDGL0/5j9XaKnk1iiA2KRvYnOZKMjbq8DveY+cfcQwNWvFWPP6oa0sXkZ1E622Lv
	 9gn20wp84DndxoCcaC6i0hvrGui9Pia81RNqOURAB+iVDdEX/LJV39geTzZXvyekQf
	 kNjMWxjBfHkbg==
Date: Wed, 14 Feb 2024 17:51:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Message-ID: <20240214-trinity-delouse-6dcd0b046895@spud>
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhWZ/akHVA7OeoZg"
Content-Disposition: inline
In-Reply-To: <20240214092504.1237402-1-naresh.solanki@9elements.com>


--nhWZ/akHVA7OeoZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:55:03PM +0530, Naresh Solanki wrote:
> Add properties for interrupt & regulator.
> Also update example.

I feel like a broken record. Your patches need to explain _why_ you're
doing what you're doing. I can read the diff and see this, but I do not
know what the justification for it is.

/30 seconds later
I really am a broken record, to quote from v1:
| Feeling like a broken record, given I am leaving the same comments on
| multiple patches. The commit message needs to explain why you're doing
| something. I can read the diff and see what you did!

https://lore.kernel.org/all/20240126-fleshed-subdued-36bae813e2ba@spud/

The patch itself does look better than the v1, with one minor comment
below.

Thanks,
Conor.

> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>=20
> ---
> Changes in v2:
> 1. Remove TEST=3D..
> 2. Update regulator subnode property as vout0
> 3. Restore commented line in example
> 4. blank line after interrupts property in example.
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.=
yaml
> index ded1c115764b..a93b3f86ee87 100644
> --- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -30,6 +30,23 @@ properties:
>        unconnected(has internal pull-down).
>      type: boolean
> =20
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller.
> +
> +    properties:
> +      vout0:

Why "vout0" if there's only one output? Is it called that in the
documentation? I had a quick check but only saw it called "vout".
Are there other related devices that would have multiple regulators
that might end up sharing the binding?

Thanks,
Conor.

> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -38,6 +55,7 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      i2c {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> @@ -45,5 +63,15 @@ examples:
>          tda38640@40 {
>              compatible =3D "infineon,tda38640";
>              reg =3D <0x40>;
> +
> +            interrupt-parent =3D <&smb_pex_cpu0_event>;
> +            interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
> +
> +            regulators {
> +                pvnn_main_cpu0: vout0 {
> +                    regulator-name =3D "pvnn_main_cpu0";
> +                    regulator-enable-ramp-delay =3D <200>;
> +                };
> +            };
>          };
>      };
>=20
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> --=20
> 2.42.0
>=20

--nhWZ/akHVA7OeoZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcz9rgAKCRB4tDGHoIJi
0gTzAQDjf5WWpV+Bz95OQla4FHrvbaTxNWagjMktSpIKUlPZwQD9HWA+ph4V+CXu
mI9iji9Fzt36AlQa4omQh4iJlu5A7A0=
=t3wm
-----END PGP SIGNATURE-----

--nhWZ/akHVA7OeoZg--

