Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1647D3CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjJWRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjJWRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:02:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3010A;
        Mon, 23 Oct 2023 10:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CC6C433C8;
        Mon, 23 Oct 2023 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698080533;
        bh=Hjxt3UNHk7mN7xk4om2aylJ6B/YJuO6RHdbXaOIwbBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyiBfL2Pf7Ti/aTVz+dqkq6nYBv1uNk8QkIhuA0W/t5CEnWmP/3rfzwSXim29uXy9
         RhkPK49EH9Xz+CRbtMXIQDKNXphQL5TdGoHPjTodtbva7CSH+VS0Vg1tp0CZlUtxFH
         TDI4q57ru1698B4qsAgC6fElhcki8IczBJkT4mDXyND2dIZBg6iz4SEGYLhWPU0FZW
         SFZqPiSAtRl85cZg1ybJg/fIbVQiFW7Mfwnd2bN8SMzQPrM49gCSDYRJMWN9TJD23o
         xiCTVBd1RvLCXWo0p0oN5m47Ow2YcHUmsn+BlyR/Hceaw/34UoVRsNASwhP2UvuiKe
         G20ZHF11Uxq6A==
Date:   Mon, 23 Oct 2023 18:02:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, t-kristo@ti.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: davinci-wdt: convert txt to yaml
Message-ID: <20231023-sanitizer-blank-44916ffa043b@spud>
References: <20231021171323.113208-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X3tQ7ddhw5q0jZ4V"
Content-Disposition: inline
In-Reply-To: <20231021171323.113208-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X3tQ7ddhw5q0jZ4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd swear I replied here already, but I checked on lore and saw
nothing...

On Sat, Oct 21, 2023 at 07:13:23PM +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add maintainers list. Took from ti,rti-wdt.yaml file.=20
>=20
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> ---
>  .../bindings/watchdog/davinci-wdt.txt         | 24 ---------
>  .../bindings/watchdog/ti,davinci-wdt.yaml     | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/davinci-wd=
t.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ti,davinci=
-wdt.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b=
/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> deleted file mode 100644
> index aa10b8ec36e2..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
> -
> -Required properties:
> -- compatible : Should be "ti,davinci-wdt", "ti,keystone-wdt"
> -- reg : Should contain WDT registers location and length
> -
> -Optional properties:
> -- timeout-sec : Contains the watchdog timeout in seconds
> -- clocks : the clock feeding the watchdog timer.
> -	   Needed if platform uses clocks.
> -	   See clock-bindings.txt
> -
> -Documentation:
> -Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> -Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
> -
> -Examples:
> -
> -wdt: wdt@2320000 {
> -	compatible =3D "ti,davinci-wdt";
> -	reg =3D <0x02320000 0x80>;
> -	timeout-sec =3D <30>;
> -	clocks =3D <&clkwdtimer0>;
> -};
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.ya=
ml b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
> new file mode 100644
> index 000000000000..357c1effff49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/ti,davinci-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
> +
> +description: |
> +  Documentation:
> +  Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> +  Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a
> +
> +maintainers:
> +  - Tero Kristo <t-kristo@ti.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,davinci-wdt
> +      - ti,keystone-wdt
> +
> +  reg:
> +    maxItems: 1
> +

> +  timeout-sec: true

Cos of the unevaluatedProperties below, and the reference to
watchdog.yaml, setting timeout-sec: true here is not required.

> +
> +  clocks:
> +    description:
> +      the clock feeding the watchdog timer.
> +      Needed if platform uses clocks.
> +      See clock-bindings.txt

This can just be

clocks:
  maxItems: 1

Although I suspect there are no platforms that do not actually use
clocks, and really this should be required...

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@2320000 {
> +        compatible =3D "ti,davinci-wdt";
> +        reg =3D <0x02320000 0x80>;
> +        timeout-sec =3D <30>;
> +        clocks =3D <&clkwdtimer0>;
> +    };
> --=20
> 2.34.1

--X3tQ7ddhw5q0jZ4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTanEAAKCRB4tDGHoIJi
0mQaAP9A4TK/CBCX6Ir6DZ1eCafwhuyw7HWa+1g4SRj1zy/LLAEA73ujQKZh+r0N
X68LLwGttrCyvRoA30SXB3/VVtZ3SQk=
=2s0k
-----END PGP SIGNATURE-----

--X3tQ7ddhw5q0jZ4V--
