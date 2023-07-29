Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F735767DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjG2KD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2KDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3E10D0;
        Sat, 29 Jul 2023 03:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9DC60B4C;
        Sat, 29 Jul 2023 10:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D93DC433C7;
        Sat, 29 Jul 2023 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690625003;
        bh=tH6HkXTj7vZyB2CKhm/BhFXDdeVpU+cmFM24rbS0SRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPxkJS5p+gaRFMmFalXdtbjZ0iJjbs8ZMWjuFiD+fGVzdvcis32eabdJNfagQLe9L
         o/9zMoGT2rj3FZDQzBeX0OB7DWQE0i/xLu6UG4BOqEIPCVi3wfoVSylAq2TOGfgIv9
         htaG0Wrfwn45qlO4dq4skEMAZAol510akGq7oaZkRcdtyv6SE6NQPLpsU4u/JwEjPi
         X+s/nFwSoHG1tXIbMaXonJIlOsomD6WYTnyQIRDPERwivnvoFrw3qLffI+fOtq/BwW
         aIzZWXJAhZpWPtJUdXbqDH1wrbxOeSaCS573+OlR09JDeUEcV6SqhDTmtZZyDsfxF1
         S496Kc/HcX2OA==
Date:   Sat, 29 Jul 2023 11:03:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
Message-ID: <20230729-facecloth-trembling-3311ca245505@spud>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
 <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2K1RO/EOfI04+Lpw"
Content-Disposition: inline
In-Reply-To: <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2K1RO/EOfI04+Lpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 10:19:30PM +0500, Nikita Travkin wrote:
> Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
> Document it's DT binding.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  | 64 ++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-b=
ms-vm.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms=
-vm.yaml
> new file mode 100644
> index 000000000000..455973d46862
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.y=
aml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Voltage Mode BMS
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description:
> +  Voltage Mode BMS is a hardware block found in some Qualcomm PMICs
> +  such as pm8916. This block performs battery voltage monitoring.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,pm8916-bms-vm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: FIFO update done

You don't need items: here since you only have one - const: will do.

> +  interrupt-names:
> +    items:
> +      - const: fifo

Same here, but do you really need a name, when you have only one
interrupt?

Thanks,
Conor.

> +
> +  monitored-battery: true
> +
> +  power-supplies: true
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pmic {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      battery@4000 {
> +        compatible =3D "qcom,pm8916-bms-vm";
> +        reg =3D <0x4000>;
> +        interrupts =3D <0x0 0x40 4 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names =3D "fifo";
> +
> +        monitored-battery =3D <&battery>;
> +        power-supplies =3D <&pm8916_charger>;
> +      };
> +    };
>=20
> --=20
> 2.41.0
>=20

--2K1RO/EOfI04+Lpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMTj5gAKCRB4tDGHoIJi
0oahAQCSwWJg7aZBvUTIur8Z4PgY71M0Ikeuhh9dGoeau6YgIQEAkzx4NAJ8HRw4
qKmTkBUWif9t2TFV7tDbdWukQcTkbgc=
=VZBv
-----END PGP SIGNATURE-----

--2K1RO/EOfI04+Lpw--
