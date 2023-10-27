Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB447D9C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjJ0Or6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJ0Or5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:47:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08428DE;
        Fri, 27 Oct 2023 07:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A4CC433C9;
        Fri, 27 Oct 2023 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698418073;
        bh=nAT3vIPkBRzhyPX82SokqF71iDQhFT4SJJaMDT239ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gX32qHm6ZUcjL0sknP6o//EXBUfac7BH/NfcEJY1l3zjatt9wB/LQZSwbFvwQINM2
         95mgLCnh2GizDwkzxJ5CfJWGdbaz+bF0kku2ebe+mn7VmT1AOUMR+4ubLvGXoVjEwz
         M98+u3i6mPUquauB0CLrM0oykM8mApjPuXm9aULR9+eaY7iME4xxb4aU6StmrP8FFb
         5OFheyjh1LTW+gqwhMyyOs0ENaBckhwb4wOiMiQcfiUuujAYfh62AvXs4AjHUopXx/
         DfGGSAJzQX7YaCREiPzAcygKuvGNOAuzErmib2ZDJUhmnhyzL/KqfkU8dSx02t/Z/9
         EVQaIyCio9W8Q==
Date:   Fri, 27 Oct 2023 15:47:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clock: brcm,kona-ccu: convert to YAML
Message-ID: <20231027-bulldog-component-5b84e4660465@spud>
References: <ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PpgCk1CqQ30xHt9p"
Content-Disposition: inline
In-Reply-To: <ZTf0oWfOqnyMEKbF@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpgCk1CqQ30xHt9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 06:45:21PM +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family clock controller unit (CCU) bindings
> to DT schema.

I didn't cross-check the clock-output-names, but this conversion mostly
looks good to me.

> Changes during conversion:
>   - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
>     it is not used in DT nor the dt-bindings
>   - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
>     it is not used in DT nor the dt-bindings

This I'm not sure about - they _were_ documented in the text-form
dt-binding, even if they weren't used in the dts. If the clock
controller does actually produce these clocks, removing them doesn't
make sense to me.

Cheers,
Conor.

>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>=20
> Changes in V2:
>   - remove the table copied from the old txt bindings, replace it with if=
-then
>     blocks individually listing the allowed clock-output-names per compat=
ible
>   - remove "dmac" from clock-output-names for brcm,bcm11351-master-ccu,
>     it is not used in DT nor the dt-bindings
>   - remove "uartb4" from clock-output-names for brcm,bcm21664-slave-ccu,
>     it is not used in DT nor the dt-bindings
>   - move allOf: after required:
>   - Link to V1: https://lore.kernel.org/lkml/ZTUIJrTc6KKyT4xj@standask-GA=
-A55M-S2HP/
>=20
>  .../bindings/clock/brcm,kona-ccu.txt          | 138 -------------
>  .../bindings/clock/brcm,kona-ccu.yaml         | 181 ++++++++++++++++++
>  2 files changed, 181 insertions(+), 138 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu=
=2Etxt
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,kona-ccu=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt b/=
Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
> deleted file mode 100644
> index 8e5a7d868557..000000000000
> --- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.txt
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -Broadcom Kona Family Clocks
> -
> -This binding is associated with Broadcom SoCs having "Kona" style
> -clock control units (CCUs).  A CCU is a clock provider that manages
> -a set of clock signals.  Each CCU is represented by a node in the
> -device tree.
> -
> -This binding uses the common clock binding:
> -    Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Required properties:
> -- compatible
> -	Shall have a value of the form "brcm,<model>-<which>-ccu",
> -	where <model> is a Broadcom SoC model number and <which> is
> -	the name of a defined CCU.  For example:
> -	    "brcm,bcm11351-root-ccu"
> -	The compatible strings used for each supported SoC family
> -	are defined below.
> -- reg
> -	Shall define the base and range of the address space
> -	containing clock control registers
> -- #clock-cells
> -	Shall have value <1>.  The permitted clock-specifier values
> -	are defined below.
> -- clock-output-names
> -	Shall be an ordered list of strings defining the names of
> -	the clocks provided by the CCU.
> -
> -Device tree example:
> -
> -	slave_ccu: slave_ccu {
> -		compatible =3D "brcm,bcm11351-slave-ccu";
> -		reg =3D <0x3e011000 0x0f00>;
> -		#clock-cells =3D <1>;
> -		clock-output-names =3D "uartb",
> -				     "uartb2",
> -				     "uartb3",
> -				     "uartb4";
> -	};
> -
> -	ref_crystal_clk: ref_crystal {
> -		#clock-cells =3D <0>;
> -		compatible =3D "fixed-clock";
> -		clock-frequency =3D <26000000>;
> -	};
> -
> -	uart@3e002000 {
> -		compatible =3D "brcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
> -		reg =3D <0x3e002000 0x1000>;
> -		clocks =3D <&slave_ccu BCM281XX_SLAVE_CCU_UARTB3>;
> -		interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift =3D <2>;
> -		reg-io-width =3D <4>;
> -	};
> -
> -BCM281XX family
> ----------------
> -CCU compatible string values for SoCs in the BCM281XX family are:
> -    "brcm,bcm11351-root-ccu"
> -    "brcm,bcm11351-aon-ccu"
> -    "brcm,bcm11351-hub-ccu"
> -    "brcm,bcm11351-master-ccu"
> -    "brcm,bcm11351-slave-ccu"
> -
> -The following table defines the set of CCUs and clock specifiers for
> -BCM281XX family clocks.  When a clock consumer references a clocks,
> -its symbolic specifier (rather than its numeric index value) should
> -be used.  These specifiers are defined in:
> -    "include/dt-bindings/clock/bcm281xx.h"
> -
> -    CCU     Clock           Type    Index   Specifier
> -    ---     -----           ----    -----   ---------
> -    root    frac_1m         peri      0     BCM281XX_ROOT_CCU_FRAC_1M
> -
> -    aon     hub_timer       peri      0     BCM281XX_AON_CCU_HUB_TIMER
> -    aon     pmu_bsc         peri      1     BCM281XX_AON_CCU_PMU_BSC
> -    aon     pmu_bsc_var     peri      2     BCM281XX_AON_CCU_PMU_BSC_VAR
> -
> -    hub     tmon_1m         peri      0     BCM281XX_HUB_CCU_TMON_1M
> -
> -    master  sdio1           peri      0     BCM281XX_MASTER_CCU_SDIO1
> -    master  sdio2           peri      1     BCM281XX_MASTER_CCU_SDIO2
> -    master  sdio3           peri      2     BCM281XX_MASTER_CCU_SDIO3
> -    master  sdio4           peri      3     BCM281XX_MASTER_CCU_SDIO4
> -    master  dmac            peri      4     BCM281XX_MASTER_CCU_DMAC
> -    master  usb_ic          peri      5     BCM281XX_MASTER_CCU_USB_IC
> -    master  hsic2_48m       peri      6     BCM281XX_MASTER_CCU_HSIC_48M
> -    master  hsic2_12m       peri      7     BCM281XX_MASTER_CCU_HSIC_12M
> -
> -    slave   uartb           peri      0     BCM281XX_SLAVE_CCU_UARTB
> -    slave   uartb2          peri      1     BCM281XX_SLAVE_CCU_UARTB2
> -    slave   uartb3          peri      2     BCM281XX_SLAVE_CCU_UARTB3
> -    slave   uartb4          peri      3     BCM281XX_SLAVE_CCU_UARTB4
> -    slave   ssp0            peri      4     BCM281XX_SLAVE_CCU_SSP0
> -    slave   ssp2            peri      5     BCM281XX_SLAVE_CCU_SSP2
> -    slave   bsc1            peri      6     BCM281XX_SLAVE_CCU_BSC1
> -    slave   bsc2            peri      7     BCM281XX_SLAVE_CCU_BSC2
> -    slave   bsc3            peri      8     BCM281XX_SLAVE_CCU_BSC3
> -    slave   pwm             peri      9     BCM281XX_SLAVE_CCU_PWM
> -
> -
> -BCM21664 family
> ----------------
> -CCU compatible string values for SoCs in the BCM21664 family are:
> -    "brcm,bcm21664-root-ccu"
> -    "brcm,bcm21664-aon-ccu"
> -    "brcm,bcm21664-master-ccu"
> -    "brcm,bcm21664-slave-ccu"
> -
> -The following table defines the set of CCUs and clock specifiers for
> -BCM21664 family clocks.  When a clock consumer references a clocks,
> -its symbolic specifier (rather than its numeric index value) should
> -be used.  These specifiers are defined in:
> -    "include/dt-bindings/clock/bcm21664.h"
> -
> -    CCU     Clock           Type    Index   Specifier
> -    ---     -----           ----    -----   ---------
> -    root    frac_1m         peri      0     BCM21664_ROOT_CCU_FRAC_1M
> -
> -    aon     hub_timer       peri      0     BCM21664_AON_CCU_HUB_TIMER
> -
> -    master  sdio1           peri      0     BCM21664_MASTER_CCU_SDIO1
> -    master  sdio2           peri      1     BCM21664_MASTER_CCU_SDIO2
> -    master  sdio3           peri      2     BCM21664_MASTER_CCU_SDIO3
> -    master  sdio4           peri      3     BCM21664_MASTER_CCU_SDIO4
> -    master  sdio1_sleep     peri      4     BCM21664_MASTER_CCU_SDIO1_SL=
EEP
> -    master  sdio2_sleep     peri      5     BCM21664_MASTER_CCU_SDIO2_SL=
EEP
> -    master  sdio3_sleep     peri      6     BCM21664_MASTER_CCU_SDIO3_SL=
EEP
> -    master  sdio4_sleep     peri      7     BCM21664_MASTER_CCU_SDIO4_SL=
EEP
> -
> -    slave   uartb           peri      0     BCM21664_SLAVE_CCU_UARTB
> -    slave   uartb2          peri      1     BCM21664_SLAVE_CCU_UARTB2
> -    slave   uartb3          peri      2     BCM21664_SLAVE_CCU_UARTB3
> -    slave   uartb4          peri      3     BCM21664_SLAVE_CCU_UARTB4
> -    slave   bsc1            peri      4     BCM21664_SLAVE_CCU_BSC1
> -    slave   bsc2            peri      5     BCM21664_SLAVE_CCU_BSC2
> -    slave   bsc3            peri      6     BCM21664_SLAVE_CCU_BSC3
> -    slave   bsc4            peri      7     BCM21664_SLAVE_CCU_BSC4
> diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b=
/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
> new file mode 100644
> index 000000000000..e5656950b3bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
> @@ -0,0 +1,181 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona family clock control units (CCU)
> +
> +maintainers:
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +  - Ray Jui <rjui@broadcom.com>
> +  - Scott Branden <sbranden@broadcom.com>
> +
> +description: |
> +  Broadcom "Kona" style clock control unit (CCU) is a clock provider that
> +  manages a set of clock signals.
> +
> +  All available clock IDs are defined in
> +  - include/dt-bindings/clock/bcm281xx.h for BCM281XX family
> +  - include/dt-bindings/clock/bcm21664.h for BCM21664 family
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm11351-aon-ccu
> +      - brcm,bcm11351-hub-ccu
> +      - brcm,bcm11351-master-ccu
> +      - brcm,bcm11351-root-ccu
> +      - brcm,bcm11351-slave-ccu
> +      - brcm,bcm21664-aon-ccu
> +      - brcm,bcm21664-master-ccu
> +      - brcm,bcm21664-root-ccu
> +      - brcm,bcm21664-slave-ccu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 10
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clock-output-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm11351-aon-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: hub_timer
> +            - const: pmu_bsc
> +            - const: pmu_bsc_var
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm11351-hub-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          const: tmon_1m
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm11351-master-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: sdio1
> +            - const: sdio2
> +            - const: sdio3
> +            - const: sdio4
> +            - const: usb_ic
> +            - const: hsic2_48m
> +            - const: hsic2_12m
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm11351-root-ccu
> +              - brcm,bcm21664-root-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          const: frac_1m
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm11351-slave-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: uartb
> +            - const: uartb2
> +            - const: uartb3
> +            - const: uartb4
> +            - const: ssp0
> +            - const: ssp2
> +            - const: bsc1
> +            - const: bsc2
> +            - const: bsc3
> +            - const: pwm
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm21664-aon-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          const: hub_timer
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm21664-master-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: sdio1
> +            - const: sdio2
> +            - const: sdio3
> +            - const: sdio4
> +            - const: sdio1_sleep
> +            - const: sdio2_sleep
> +            - const: sdio3_sleep
> +            - const: sdio4_sleep
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm21664-slave-ccu
> +    then:
> +      properties:
> +        clock-output-names:
> +          items:
> +            - const: uartb
> +            - const: uartb2
> +            - const: uartb3
> +            - const: bsc1
> +            - const: bsc2
> +            - const: bsc3
> +            - const: bsc4
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@3e011000 {
> +      compatible =3D "brcm,bcm11351-slave-ccu";
> +      reg =3D <0x3e011000 0x0f00>;
> +      #clock-cells =3D <1>;
> +      clock-output-names =3D "uartb",
> +                           "uartb2",
> +                           "uartb3",
> +                           "uartb4",
> +                           "ssp0",
> +                           "ssp2",
> +                           "bsc1",
> +                           "bsc2",
> +                           "bsc3",
> +                           "pwm";
> +    };
> +...
> --=20
> 2.34.1
>=20

--PpgCk1CqQ30xHt9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTvNlAAKCRB4tDGHoIJi
0jYIAQCUJq9VPOfJ8GqCoKw0wOrV4eSRvP1LpFvKlJLMdmkJtQD+P8riU4F8BNVM
Qjf3aEc3xvojkrRD4IP7/6xEFYnhcAE=
=TpuJ
-----END PGP SIGNATURE-----

--PpgCk1CqQ30xHt9p--
