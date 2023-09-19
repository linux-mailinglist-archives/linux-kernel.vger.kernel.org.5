Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090CC7A6BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjIST6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjIST6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:58:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D29D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:57:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596BDC433C7;
        Tue, 19 Sep 2023 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695153474;
        bh=xHCh98iOkChUThPKdLQGQweaVZPtykZ08GJEQBsDwbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4dlbFfTh4KP61zpzZex9vqa15C6MwxIvBmC0o/U0M098yBH/0QFSec5l0mI3L2+x
         TaeBviCfDfUL/ZCXXrQkehJIyyZIB3I6/uWWut7gpQxcy5ttTaHPzwsCbqT+AT6/1x
         64i+djh5xqlBVZsbYkEubDoqBk8NcUKtlBteCeGenDn9ZY7JP/bXfCkh1Lk6j9Ahp5
         klf1x8Q8N+UwXIRtgdEk0yU7RnL9L0gdER15F4qV4MF9Ewu/1s2lmS7pvH20cui3PG
         UdrFtr16rms8Y4MUxoLa8PkQ0dqT9+qSr97dTN3j5AqXhCJPcXUjxzq9dYthiylS6h
         Q5cdC9DO5hH+g==
Received: (nullmailer pid 93910 invoked by uid 1000);
        Tue, 19 Sep 2023 19:57:52 -0000
Date:   Tue, 19 Sep 2023 14:57:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 05/12] regulator: dt-bindings: mt6358: Add MT6366 PMIC
Message-ID: <20230919195752.GA85007-robh@kernel.org>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-6-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919104357.3971512-6-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 06:43:48PM +0800, Chen-Yu Tsai wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
> 29 LDO regulators, not counting ones that feed internally and basically
> have no controls. The regulators are named after their intended usage
> for the SoC and system design, thus not named generically as ldoX or
> dcdcX, but as vcn33 or vgpu.
> 
> The differences compared to the MT6358 are minimal:
> - Regulators removed: VCAMA1, VCAMA2, VCAMD, VCAMIO, VLDO28
> - Regulators added: VM18, VMDDR, VSRAM_CORE
> 
> Add a binding document describing all the regulators and their supplies.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> [wens@chromium.org: major rework and added commit message]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Merged all the propertyPatterns together; the if-then sections now
>   only block out invalid properties
> 
> Changes since v1:
> - Replaced underscores in supply names to hyphens
> - Merged with MT6358 regulator binding
> - Added MT6358 fallback compatible to MT6366 regulator
> 
> Changes since Zhiyong's last version (v4) [1]:
> - simplified regulator names
> - added descriptions to regulators
> - removed bogus regulators (*_sshub)
> - merged vcn33-wifi and vcn33-bt as vcn33
> - added missing regulators (vm18, vmddr, vsram-core)
> - cut down examples to a handful of cases and made them complete
> - expanded commit message a lot
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
> 
>  .../regulator/mediatek,mt6358-regulator.yaml  | 120 +++++++++++++++---
>  1 file changed, 104 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> index c5f336318ec2..05e381899d08 100644
> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> @@ -16,14 +16,18 @@ description:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt6358-regulator
> +    oneOf:
> +      - const: mediatek,mt6358-regulator
> +      - items:
> +          - const: mediatek,mt6366-regulator
> +          - const: mediatek,mt6358-regulator

Would the mt6366 regulator driver(s) function with the mt6358 driver 
unchanged? If not, then not really much point in having the fallback.

>  
>    vsys-ldo1-supply:
>      description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
>    vsys-ldo2-supply:
> -    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
> +    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, vmch, vsim2
>    vsys-ldo3-supply:
> -    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
> +    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), vemc, vibr
>    vsys-vcore-supply:
>      description: Supply for buck regulator vcore
>    vsys-vdram1-supply:
> @@ -43,18 +47,20 @@ properties:
>    vsys-vs2-supply:
>      description: Supply for buck regulator vs2
>    vs1-ldo1-supply:
> -    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
> +    description:
> +      Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358 only), vio18, vm18 (MT6366 only)
>    vs2-ldo1-supply:
> -    description: Supply for LDOs vdram2
> +    description: Supply for LDOs vdram2, vmddr (MT6366 only)
>    vs2-ldo2-supply:
>      description: Supply for LDOs vrf12, va12
>    vs2-ldo3-supply:
> -    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
> +    description:
> +      Supply for LDOs vsram-core (MT6366 only), vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
>    vs2-ldo4-supply:
>      description: Supply for LDO vcamd
>  
>  patternProperties:
> -  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
> +  "^(buck_)?v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
>      description: Buck regulators
>      type: object
>      $ref: regulator.yaml#
> @@ -69,7 +75,7 @@ patternProperties:
>            enum: [0, 1]
>      unevaluatedProperties: false
>  
> -  "^ldo_v(a|rf)12$":
> +  "^(ldo_)?v(a|rf)12$":
>      description: LDOs with fixed 1.2V output and 0~100/10mV tuning
>      type: object
>      $ref: regulator.yaml#
> @@ -77,15 +83,16 @@ patternProperties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_v((aux|cn|io|rf)18|camio)$":
> -    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
> +  "^(ldo_)?v((aux|cn|io|rf)18|camio)$":
> +    description:
> +      LDOs with fixed 1.8V output and 0~100/10mV tuning (vcn18 on MT6366 has variable output)
>      type: object
>      $ref: regulator.yaml#
>      properties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_vxo22$":
> +  "^(ldo_)?vxo22$":
>      description: LDOs with fixed 2.2V output and 0~100/10mV tuning
>      type: object
>      $ref: regulator.yaml#
> @@ -93,7 +100,7 @@ patternProperties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_v(aud|bif|cn|fe|io)28$":
> +  "^(ldo_)?v(aud|bif|cn|fe|io)28$":
>      description: LDOs with fixed 2.8V output and 0~100/10mV tuning
>      type: object
>      $ref: regulator.yaml#
> @@ -101,7 +108,7 @@ patternProperties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_vusb$":
> +  "^(ldo_)?vusb$":
>      description: LDOs with fixed 3.0V output and 0~100/10mV tuning
>      type: object
>      $ref: regulator.yaml#
> @@ -109,7 +116,7 @@ patternProperties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_vsram_(gpu|others|proc1[12])$":
> +  "^(ldo_)?vsram[_-](core|gpu|others|proc1[12])$":
>      description: LDOs with variable output
>      type: object
>      $ref: regulator.yaml#
> @@ -117,7 +124,7 @@ patternProperties:
>        regulator-allowed-modes: false
>      unevaluatedProperties: false
>  
> -  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
> +  "^(ldo_)?v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|m18|mc|mch|mddr|sim[12])$":
>      description: LDOs with variable output and 0~100/10mV tuning
>      type: object
>      $ref: regulator.yaml#
> @@ -130,11 +137,50 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: mediatek,mt6358-regulator
> +    then:
> +      patternProperties:
> +        # Old regulator node name scheme (with prefix and underscores) only
> +        # ([^y-] is used to avoid matching -supply
> +        "^(?<!buck_)(?<!ldo_)v.*[^y-](?!-supply)$": false
> +        "^ldo_vsram-": false
> +        # vsram_core regulator doesn't exist on MT6358
> +        "^ldo_vsram[-_]core$": false
> +
> +      properties:
> +        # vm18 and vmddr regulators don't exist on MT6358
> +        ldo_vm18: false
> +        ldo_vmddr: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt6366-regulator
> +    then:
> +      patternProperties:
> +        # Prefer cleaned up regulator node names
> +        "^(buck|ldo)_": false
> +        # Don't allow underscores
> +        "^vsram_": false
> +        # vcam* regulators don't exist on MT6366
> +        "^vcam": false
> +
> +      properties:
> +        # vldo28 regulator doesn't exist on MT6366
> +        vldo28: false
> +        # vs2_ldo4 supply pin doesn't exist on MT6366
> +        vs2-ldo4-supply: false
> +
>  examples:
>    - |
>      #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
>  
> -    regulator {
> +    mt6358-regulator {

regulator or regulators is preferred.

>          compatible = "mediatek,mt6358-regulator";
>  
>          buck_vgpu {
> @@ -156,4 +202,46 @@ examples:
>          };
>      };
>  
> +    mt6366-regulator {
> +        compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
> +
> +        vdram1 {
> +            regulator-name = "pp1125_emi_vdd2";
> +            regulator-min-microvolt = <1125000>;
> +            regulator-max-microvolt = <1125000>;
> +            regulator-ramp-delay = <12500>;
> +            regulator-enable-ramp-delay = <0>;
> +            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
> +                                       MT6397_BUCK_MODE_FORCE_PWM>;
> +            regulator-always-on;
> +        };
> +
> +        vproc11 {
> +            regulator-name = "ppvar_dvdd_proc_bc_mt6366";
> +            regulator-min-microvolt = <600000>;
> +            regulator-max-microvolt = <1200000>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
> +                                       MT6397_BUCK_MODE_FORCE_PWM>;
> +            regulator-always-on;
> +        };
> +
> +        vmddr {
> +            regulator-name = "pm0750_emi_vmddr";
> +            regulator-min-microvolt = <700000>;
> +            regulator-max-microvolt = <750000>;
> +            regulator-enable-ramp-delay = <325>;
> +            regulator-always-on;
> +        };
> +
> +        vsram-proc11 {
> +            regulator-name = "pp0900_dvdd_sram_bc";
> +            regulator-min-microvolt = <850000>;
> +            regulator-max-microvolt = <1120000>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <240>;
> +            regulator-always-on;
> +        };
> +    };
>  ...
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
