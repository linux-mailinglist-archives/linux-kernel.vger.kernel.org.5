Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BF763F51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjGZTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:15:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C26131;
        Wed, 26 Jul 2023 12:15:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QJFIWk004269;
        Wed, 26 Jul 2023 14:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690398918;
        bh=8viffkmdRSAqQiaZaiNfDsEAp9acwNHcv0i3edBkfKE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rH7yYTVYSJyfwEyZkA+5eolnhSvQtkWqyE2CDBTaQ4Ba9P0sjwymvDxPgb4s9y0IB
         pMTABBAxV9xlWDtbHs5sqCLKtL3uhXB111kvr5/yNonU9l/3Q6+njwznJM8Wd97NR9
         KzxIU0CHrNnAe8p26L/dJ8EZL+7pLpQMiV8QWX0E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QJFIao026530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 14:15:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 14:15:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 14:15:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QJFIrl009402;
        Wed, 26 Jul 2023 14:15:18 -0500
Date:   Wed, 26 Jul 2023 14:15:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/5] dt-bindings: opp: Convert ti-omap5-opp-supply.txt to
 yaml binding
Message-ID: <20230726191518.xmx72pwon6lgd2kh@stoning>
References: <20230724153911.1376830-1-nm@ti.com>
 <20230724153911.1376830-5-nm@ti.com>
 <20230726171056.GA1593547-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726171056.GA1593547-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:10-20230726, Rob Herring wrote:
> On Mon, Jul 24, 2023 at 10:39:10AM -0500, Nishanth Menon wrote:
> > Rename ti-omap5-opp-supply to be bit more generic omap-opp-supply and
> > convert the binding to yaml.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  .../bindings/opp/ti,omap-opp-supply.yaml      | 108 ++++++++++++++++++
> >  .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ----------
> >  2 files changed, 108 insertions(+), 63 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> > new file mode 100644
> > index 000000000000..ff1b3d8fea31
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/opp/ti,omap-opp-supply.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments OMAP compatible OPP supply description
> 
> Drop "description"

OK.

> 
> > +
> > +description: |
> > +  OMAP5, DRA7, and AM57 family of SoCs have Class0 AVS eFuse registers which
> > +  contain data that can be used to adjust voltages programmed for some of their
> > +  supplies for more efficient operation. This binding provides the information
> > +  needed to read these values and use them to program the main regulator during
> > +  an OPP transitions.
> > +
> > +  Also, some supplies may have an associated vbb-supply which is an Adaptive Body
> > +  Bias regulator which much be transitioned in a specific sequence with regards
> > +  to the vdd-supply and clk when making an OPP transition. By supplying two
> > +  regulators to the device that will undergo OPP transitions we can make use
> > +  of the multi regulator binding that is part of the OPP core described
> > +  to describe both regulators needed by the platform.
> > +
> > +maintainers:
> > +  - Nishanth Menon <nm@ti.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^opp-supply(@[0-9a-f]+)?$'
> > +
> > +  compatible:
> > +    oneOf:
> > +      - description: Basic OPP supply controlling VDD and VBB
> > +        items:
> > +          - const: ti,omap-opp-supply
> > +      - description: OMAP5+ optimized voltages in efuse(Class 0) VDD along with
> > +          VBB.
> > +        items:
> > +          - const: ti,omap5-opp-supply
> > +      - description: OMAP5+ optimized voltages in efuse(class0) VDD but no VBB
> > +        items:
> > +          - const: ti,omap5-core-opp-supply
> > +
> > +  reg:
> > +    description: Address and length of the efuse register set for the device
> 
> Drop

Ack.

> 
> > +    maxItems: 1
> > +
> > +  ti,absolute-max-voltage-uv:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Absolute maximum voltage for the OPP supply
> > +
> > +  ti,efuse-settings:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description: An array of u32 tuple items providing information about
> > +      optimized efuse configuration. Each item consists of the following
> > +      voltage_in_uV - reference voltage (OPP Voltage)
> > +      efuse_offset - efuse offset fromr eg where the optimized voltage is
> > +        stored.
> > +    items:
> > +      minItems: 2
> > +      maxItems: 2
> 
> Constraints on the values?

As I recollect (been a while), it was variant per device. Did you have
something in mind or a reference for me to look at?

> 
> > +    minItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - ti,absolute-max-voltage-uv
> > +
> > +allOf:
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: ti,omap-opp-supply
> > +    then:
> > +      required:
> > +        - reg
> > +        - ti,efuse-settings
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    opp_supply_mpu_iva_hd: opp-supply {
> 
> Drop unused labels.

Will do.

> 
> > +        compatible = "ti,omap-opp-supply";
> > +        ti,absolute-max-voltage-uv = <1375000>;
> > +    };
> > +  - |
> > +    opp_supply_mpu: opp-supply@4a003b20 {
> > +        compatible = "ti,omap5-opp-supply";
> > +        reg = <0x4a003b20 0x8>;
> > +        ti,efuse-settings =
> > +            /* uV   offset */
> > +            <1060000 0x0>,
> > +            <1160000 0x4>,
> > +            <1210000 0x8>;
> > +        ti,absolute-max-voltage-uv = <1500000>;
> > +    };
> > +  - |
> > +    opp_supply_mpu2: opp-supply@4a003b00 {
> > +        compatible = "ti,omap5-core-opp-supply";
> > +        reg = <0x4a003b00 0x8>;
> > +        ti,efuse-settings =
> > +            /* uV   offset */
> > +            <1060000 0x0>,
> > +            <1160000 0x4>,
> > +            <1210000 0x8>;
> > +        ti,absolute-max-voltage-uv = <1500000>;
> > +    };
> 
> The 3rd example doesn't add anything. It's just different values.

True, Thanks for catching.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
