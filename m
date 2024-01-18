Return-Path: <linux-kernel+bounces-30292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24F831CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B78A1F218AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C568286B1;
	Thu, 18 Jan 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HduugTlS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F331DDC0;
	Thu, 18 Jan 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592422; cv=none; b=f4ztdunDxSC402azaVWdU4GWFPlExFjDI0/j++8/9oBrQA8qdqs69tRT3hOixdK2RgYWyp5n/YU0ExZBizsmScYC+SAEFFS0PGMIsHGtngCxhZPzZejAounhimn0Y9dr0aZD2RWE5lqeRap3YzC6WBHJjl2n4PBbC/0V+eB79qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592422; c=relaxed/simple;
	bh=B0JbzjhM5BaOxmyfPcfGKeh0DLRt1nowj3SyUrIVfxo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Sf0ADkzh1RHMxeOIdS+B/dfeVoMwxXuJlpvWviw1+ADoLO+WZLchrIwkfgPQhk+2fp8+0qYb0XJzOUHYRA2p8dyuHhS0YobcoHroUq9za/oNoqypy4xECshTXxJqPYXhM4DK8s3s3YaEfhvSAhdIkK6EkApODGzfdMf1IPLNaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HduugTlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B13C433C7;
	Thu, 18 Jan 2024 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705592422;
	bh=B0JbzjhM5BaOxmyfPcfGKeh0DLRt1nowj3SyUrIVfxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HduugTlSrhzT936r5EfEIhbIuJhdmDk8svGQsU7hxffyxq68q4Zduc66qWY6AE5Yw
	 +Iq/+M0U4IFXZcxxJ0x/PzAjXp0INpVnLoTzL+FXcqcQ9y7cIvMz2h/MN6sq/BigSU
	 9GyPUsa7ULneyhVUbBJKlGqktlCnpkr1IINOtlmyNZwIFybZgeCEk6qoBehTtSkWcV
	 2j89dytolHJxj5ykuwJR4qA9c+FppmFRqP8f0S/7wfiVHILCMdTXyKWsWNI/oHETKh
	 tORxBAIguMNqVvDTIojMHKQsdr1nw0mHckZ2GXjYhPKYnOVBZ8hd5BXJptLaObXUyP
	 tTMUSg0gFmDUg==
Date: Thu, 18 Jan 2024 15:40:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	linux4microchip@microchip.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240118-recent-glorified-fd35d72e006e@spud>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-4-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o+4Qxw6Z8JF2FunJ"
Content-Disposition: inline
In-Reply-To: <20240118092612.117491-4-dharma.b@microchip.com>


--o+4Qxw6Z8JF2FunJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 02:56:12PM +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
>=20
> Adjust the clock-names property to clarify that the LCD controller expects
> one of these clocks (either sys_clk or lvds_pll_clk to be present but not
> both) along with the slow_clk and periph_clk. This alignment with the act=
ual
> hardware requirements will enable accurate device tree configuration for
> systems using the HLCDC IP.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v2 -> v3
> - Rename hlcdc-display-controller and hlcdc-pwm to generic names.
> - Modify the description by removing the unwanted comments and '|'.
> - Modify clock-names simpler.
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify title (not include words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Add details of lvds_pll addition in commit message.
> - Ref endpoint and not endpoint-base.
> - Fix coding style.
> ...
>  .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 97 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
>  2 files changed, 97 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Doc=
umentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> new file mode 100644
> index 000000000000..eccc998ac42c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCD Controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description:
> +  The Atmel HLCDC (HLCD Controller) IP available on Atmel SoCs exposes t=
wo
> +  subdevices, a PWM chip and a Display Controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9n12-hlcdc
> +      - atmel,at91sam9x5-hlcdc
> +      - atmel,sama5d2-hlcdc
> +      - atmel,sama5d3-hlcdc
> +      - atmel,sama5d4-hlcdc
> +      - microchip,sam9x60-hlcdc
> +      - microchip,sam9x75-xlcdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3

Hmm, one thing I probably should have said on the previous version, but
I missed somehow: It would be good to add an items list to the clocks
property here to explain what the 3 clocks are/are used for - especially
since there is additional complexity being added here to use either the
sys or lvds clocks.

Thanks,
Conor.

> +
> +  clock-names:
> +    items:
> +      - const: periph_clk
> +      - enum: [sys_clk, lvds_pll_clk]
> +      - const: slow_clk

--o+4Qxw6Z8JF2FunJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalGXgAKCRB4tDGHoIJi
0n63APwO3PcryW3m5qmOtCPUmCER5xFofHNE9C4ok35HJXY0RwD/WhbDDGMDO/jO
SfTZ40mYL4OX63fbti7nK939wPrXXAc=
=lFW+
-----END PGP SIGNATURE-----

--o+4Qxw6Z8JF2FunJ--

