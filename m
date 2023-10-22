Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971817D24EF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjJVRaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:30:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D1E5;
        Sun, 22 Oct 2023 10:30:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B516C433C7;
        Sun, 22 Oct 2023 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697995809;
        bh=+cy7JrdQOmAKxt5f/1oHsfduy+/ecpkdk3TsslBEOTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cAI+FdqiohNObLN8vZFnXApengck5oXzAl/+SYEG5mKg/HGiYc+DR/Z+N1y9OArMq
         52RpK8oTCSc8RjZIByTPrPXBs355+Zze/yyrb6EGu6wpK7z/cMK5lPy7fQs67YZ48q
         RTp98LC7Erz/rDuIvFUByM6QK3SAO2LU8p+mcuthYOTFvXYnrEXFoEq0w7Eochi4rz
         Bf6kFBclcMktn9ZxCzJWaJD92yV6opUYMIGQJDtWZmjmI44e5qgs7YhSenDGA8vHj/
         fYm84jrgHKGvXDp/EIbtz9B/N5F+uwWbwLothAO7IHrERVg7cWcvMxA/GUdoHCmg53
         XcBMomOmBR01g==
Date:   Sun, 22 Oct 2023 18:30:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, baruch@tkos.co.il,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: cnxt,cx92755-wdt: convert txt to
 yaml
Message-ID: <20231022-perish-ample-e8c009664a19@spud>
References: <20231022120328.137788-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zVdCFydyJvbEUsVE"
Content-Disposition: inline
In-Reply-To: <20231022120328.137788-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zVdCFydyJvbEUsVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 02:03:28PM +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add maintainers list. Took from Documentation/devicetree/bindings/arm/dig=
icolor.yaml file.=20

That seems like a bit of an odd reasoning, but Baruch was the submitter
for the original txt form binding for this watchdog , per the git history.

>=20
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> ---
>  .../bindings/watchdog/cnxt,cx92755-wdt.yaml   | 49 +++++++++++++++++++
>  .../bindings/watchdog/digicolor-wdt.txt       | 25 ----------
>  2 files changed, 49 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cnxt,cx927=
55-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-=
wdt.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
> new file mode 100644
> index 000000000000..acd2d30b20f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/cnxt,cx92755-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Conexant Digicolor SoCs Watchdog timer
> +
> +description: |
> +  The watchdog functionality in Conexant Digicolor SoCs relies on the so=
 called
> +  "Agent Communication" block. This block includes the eight programmabl=
e system
> +  timer counters. The first timer (called "Timer A") is the only one tha=
t can be
> +  used as watchdog.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  compatible:
> +    const: cnxt,cx92755-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      specifies the clock that drives the timer

This can just be:
  clocks:
    maxItems: 1

as clocks is a generic property & if there's only one clock, describing
it is usually needless.

Otherwise this conversion looks okay to me.

Cheers,
Conor.

> +
> +  timeout-sec: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@f0000fc0 {
> +        compatible =3D "cnxt,cx92755-wdt";
> +        reg =3D <0xf0000fc0 0x8>;
> +        clocks =3D <&main_clk>;
> +        timeout-sec =3D <15>;
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt=
 b/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
> deleted file mode 100644
> index a882967e17d4..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Conexant Digicolor SoCs Watchdog timer
> -
> -The watchdog functionality in Conexant Digicolor SoCs relies on the so c=
alled
> -"Agent Communication" block. This block includes the eight programmable =
system
> -timer counters. The first timer (called "Timer A") is the only one that =
can be
> -used as watchdog.
> -
> -Required properties:
> -
> -- compatible : Should be "cnxt,cx92755-wdt"
> -- reg : Specifies base physical address and size of the registers
> -- clocks : phandle; specifies the clock that drives the timer
> -
> -Optional properties:
> -
> -- timeout-sec : Contains the watchdog timeout in seconds
> -
> -Example:
> -
> -	watchdog@f0000fc0 {
> -		compatible =3D "cnxt,cx92755-wdt";
> -		reg =3D <0xf0000fc0 0x8>;
> -		clocks =3D <&main_clk>;
> -		timeout-sec =3D <15>;
> -	};
> --=20
> 2.34.1
>=20

--zVdCFydyJvbEUsVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTVcGAAKCRB4tDGHoIJi
0u4nAQDbfwbOCduGR4mJFXl7eEwdSLF3zenXhEc5OBaGfw4rXwD/RcUcNDtbgrK9
h2Ia6oTdJyJ2mf5wa0SlZO72g3zlGwA=
=8fe0
-----END PGP SIGNATURE-----

--zVdCFydyJvbEUsVE--
