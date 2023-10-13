Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FF7C8516
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJMLy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJMLy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:54:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6644A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:54:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a645e54806so314990966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697198063; x=1697802863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKLEA3divMcZLeIf86n04Km9WdnU1oZ/u+W4h88qtWs=;
        b=nB6ey6fUDbI7QzW5AKtyr8Y92a8uINNhihSj6gFCsp0eH+aKTzjSGx5+DtMTK/uTNG
         3vu9TjSlR+BXACmgxkq2ZwYMK1ZXt/atM3N2Gjp1dOC6dUZO6Im18ri6/0yBpExmC5PJ
         dMsqQ5MmLjko7USRgKtqOXJGU/ydPdp+L3pOySZ6rtE1hZ/+FWQxitN142G7GfFMMECU
         yDLHXbPdZIidSvxVfzDBPg4W21skpfW0qyAjHzq/hyMgRNYLoLZAu3NB98piCagCk1PT
         m4fCDSSa+6LiNLbsylCl4aht1vBX4kSL3ymT4/PCHHZmAQGEHxa9S0x6eTLdvDP+t65Y
         nAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697198063; x=1697802863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKLEA3divMcZLeIf86n04Km9WdnU1oZ/u+W4h88qtWs=;
        b=iLhh02GEp2pm1TOmiHCC1dYnWkK/Iy49k0ZjC8WQqdZ1lIYoEtXcV5mQ9KaKxCKizl
         BBjZTf47v5iUkzT4FI47nHdJ2ObCtEnSMSaAFDpa6XLool7xq6x/XrJVvZ/fsR0Tdxrt
         GbR/jEy6tiS3ux/kDpDw4JSnctB6/k7kZxGydVqnl2R0hnW+gxkI/L76AgTZHPPwNJAv
         OsrJ7pR509BPGOK1KCo8Zq5+tW1z9jojvw63X6Rr1vKHpHUGHTKVBxi76uZQf1fvdynE
         2pc5U6fNUpRczmxtqjUt4sem6aNxy5LZX9GebiIrJBpCvSi29Mj7+IzkJ5CZg4H4DxUI
         gYig==
X-Gm-Message-State: AOJu0YyPtvkSnIm+3zTeZo5vXERWOmFCRspdnEztE7YWdWevhHv13Bxi
        mcNI6XFOPpoo1RiF1RhILjeP+FO+YOEW7qS6vyQ=
X-Google-Smtp-Source: AGHT+IEXpHWsGLHyfvc3vO3zQdKet2gx1uHyxnIcLnVDI4OEWtXF7JdhjS+f4HxaAMbZoAMHPY/WPA==
X-Received: by 2002:a17:907:75e2:b0:9ba:14a3:721f with SMTP id jz2-20020a17090775e200b009ba14a3721fmr12902046ejc.2.1697198063233;
        Fri, 13 Oct 2023 04:54:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id cw11-20020a170906c78b00b0099e12a49c8fsm12532791ejb.173.2023.10.13.04.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 04:54:22 -0700 (PDT)
Message-ID: <071a9a8d-695d-4569-b656-76a825938cee@linaro.org>
Date:   Fri, 13 Oct 2023 13:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: arm: mediatek: convert audsys and
 mt2701-afe-pcm to yaml
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20231013065924.478369-1-eugen.hristev@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231013065924.478369-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 08:59, Eugen Hristev wrote:
> Convert the mediatek,audsys binding to YAML, together with the associated
> binding bindings/sound/mt2701-afe-pcm.yaml .
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v4:

Thank you for your patch. There is something to discuss/improve.

...

> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  audio-controller:
> +    $ref: /schemas/sound/mt2701-afe-pcm.yaml#
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg

clock-cells were required before.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        audsys: clock-controller@11220000 {
> +            compatible = "mediatek,mt7622-audsys", "syscon";
> +            reg = <0 0x11220000 0 0x2000>;
> +            #clock-cells = <1>;
> +
> +            afe: audio-controller {
> +                compatible = "mediatek,mt2701-audio";
> +                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +                             <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +                interrupt-names = "afe", "asys";
> +                power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +
> +                clocks = <&infracfg CLK_INFRA_AUDIO>,
> +                         <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +                         <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +                         <&topckgen CLK_TOP_AUD_48K_TIMING>,
> +                         <&topckgen CLK_TOP_AUD_44K_TIMING>,
> +                         <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> +                         <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> +                         <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> +                         <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> +                         <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> +                         <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> +                         <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> +                         <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> +                         <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> +                         <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> +                         <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> +                         <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> +                         <&audsys CLK_AUD_I2SO1>,
> +                         <&audsys CLK_AUD_I2SO2>,
> +                         <&audsys CLK_AUD_I2SO3>,
> +                         <&audsys CLK_AUD_I2SO4>,
> +                         <&audsys CLK_AUD_I2SIN1>,
> +                         <&audsys CLK_AUD_I2SIN2>,
> +                         <&audsys CLK_AUD_I2SIN3>,
> +                         <&audsys CLK_AUD_I2SIN4>,
> +                         <&audsys CLK_AUD_ASRCO1>,
> +                         <&audsys CLK_AUD_ASRCO2>,
> +                         <&audsys CLK_AUD_ASRCO3>,
> +                         <&audsys CLK_AUD_ASRCO4>,
> +                         <&audsys CLK_AUD_AFE>,
> +                         <&audsys CLK_AUD_AFE_CONN>,
> +                         <&audsys CLK_AUD_A1SYS>,
> +                         <&audsys CLK_AUD_A2SYS>,
> +                         <&audsys CLK_AUD_AFE_MRGIF>;
> +
> +                clock-names = "infra_sys_audio_clk",
> +                              "top_audio_mux1_sel",
> +                              "top_audio_mux2_sel",
> +                              "top_audio_a1sys_hp",
> +                              "top_audio_a2sys_hp",
> +                              "i2s0_src_sel",
> +                              "i2s1_src_sel",
> +                              "i2s2_src_sel",
> +                              "i2s3_src_sel",
> +                              "i2s0_src_div",
> +                              "i2s1_src_div",
> +                              "i2s2_src_div",
> +                              "i2s3_src_div",
> +                              "i2s0_mclk_en",
> +                              "i2s1_mclk_en",
> +                              "i2s2_mclk_en",
> +                              "i2s3_mclk_en",
> +                              "i2so0_hop_ck",
> +                              "i2so1_hop_ck",
> +                              "i2so2_hop_ck",
> +                              "i2so3_hop_ck",
> +                              "i2si0_hop_ck",
> +                              "i2si1_hop_ck",
> +                              "i2si2_hop_ck",
> +                              "i2si3_hop_ck",
> +                              "asrc0_out_ck",
> +                              "asrc1_out_ck",
> +                              "asrc2_out_ck",
> +                              "asrc3_out_ck",
> +                              "audio_afe_pd",
> +                              "audio_afe_conn_pd",
> +                              "audio_a1sys_pd",
> +                              "audio_a2sys_pd",
> +                              "audio_mrgif_pd";
> +
> +                assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +                                  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +                                  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> +                                  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
> +                assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
> +                                         <&topckgen CLK_TOP_AUD2PLL_90M>;
> +                assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
> deleted file mode 100644
> index f548e6a58240..000000000000
> --- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
> +++ /dev/null
> @@ -1,146 +0,0 @@
> -Mediatek AFE PCM controller for mt2701
> -
> -Required properties:
> -- compatible: should be one of the following.
> -	      - "mediatek,mt2701-audio"
> -	      - "mediatek,mt7622-audio"
> -- interrupts: should contain AFE and ASYS interrupts
> -- interrupt-names: should be "afe" and "asys"
> -- power-domains: should define the power domain
> -- clocks: Must contain an entry for each entry in clock-names
> -  See ../clocks/clock-bindings.txt for details
> -- clock-names: should have these clock names:
> -		"infra_sys_audio_clk",
> -		"top_audio_mux1_sel",
> -		"top_audio_mux2_sel",
> -		"top_audio_a1sys_hp",
> -		"top_audio_a2sys_hp",
> -		"i2s0_src_sel",
> -		"i2s1_src_sel",
> -		"i2s2_src_sel",
> -		"i2s3_src_sel",
> -		"i2s0_src_div",
> -		"i2s1_src_div",
> -		"i2s2_src_div",
> -		"i2s3_src_div",
> -		"i2s0_mclk_en",
> -		"i2s1_mclk_en",
> -		"i2s2_mclk_en",
> -		"i2s3_mclk_en",
> -		"i2so0_hop_ck",
> -		"i2so1_hop_ck",
> -		"i2so2_hop_ck",
> -		"i2so3_hop_ck",
> -		"i2si0_hop_ck",
> -		"i2si1_hop_ck",
> -		"i2si2_hop_ck",
> -		"i2si3_hop_ck",
> -		"asrc0_out_ck",
> -		"asrc1_out_ck",
> -		"asrc2_out_ck",
> -		"asrc3_out_ck",
> -		"audio_afe_pd",
> -		"audio_afe_conn_pd",
> -		"audio_a1sys_pd",
> -		"audio_a2sys_pd",
> -		"audio_mrgif_pd";
> -- assigned-clocks: list of input clocks and dividers for the audio system.
> -		   See ../clocks/clock-bindings.txt for details.
> -- assigned-clocks-parents: parent of input clocks of assigned clocks.
> -- assigned-clock-rates: list of clock frequencies of assigned clocks.
> -
> -Must be a subnode of MediaTek audsys device tree node.
> -See ../arm/mediatek/mediatek,audsys.txt for details about the parent node.
> -
> -Example:
> -
> -	audsys: audio-subsystem@11220000 {
> -		compatible = "mediatek,mt2701-audsys", "syscon";
> -		...
> -
> -		afe: audio-controller {
> -			compatible = "mediatek,mt2701-audio";
> -			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> -				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> -			interrupt-names	= "afe", "asys";
> -			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> -
> -			clocks = <&infracfg CLK_INFRA_AUDIO>,
> -				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> -				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> -				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> -				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
> -				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> -				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> -				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> -				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> -				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> -				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> -				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> -				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> -				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> -				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> -				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> -				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> -				 <&audsys CLK_AUD_I2SO1>,
> -				 <&audsys CLK_AUD_I2SO2>,
> -				 <&audsys CLK_AUD_I2SO3>,
> -				 <&audsys CLK_AUD_I2SO4>,
> -				 <&audsys CLK_AUD_I2SIN1>,
> -				 <&audsys CLK_AUD_I2SIN2>,
> -				 <&audsys CLK_AUD_I2SIN3>,
> -				 <&audsys CLK_AUD_I2SIN4>,
> -				 <&audsys CLK_AUD_ASRCO1>,
> -				 <&audsys CLK_AUD_ASRCO2>,
> -				 <&audsys CLK_AUD_ASRCO3>,
> -				 <&audsys CLK_AUD_ASRCO4>,
> -				 <&audsys CLK_AUD_AFE>,
> -				 <&audsys CLK_AUD_AFE_CONN>,
> -				 <&audsys CLK_AUD_A1SYS>,
> -				 <&audsys CLK_AUD_A2SYS>,
> -				 <&audsys CLK_AUD_AFE_MRGIF>;
> -
> -			clock-names = "infra_sys_audio_clk",
> -				      "top_audio_mux1_sel",
> -				      "top_audio_mux2_sel",
> -				      "top_audio_a1sys_hp",
> -				      "top_audio_a2sys_hp",
> -				      "i2s0_src_sel",
> -				      "i2s1_src_sel",
> -				      "i2s2_src_sel",
> -				      "i2s3_src_sel",
> -				      "i2s0_src_div",
> -				      "i2s1_src_div",
> -				      "i2s2_src_div",
> -				      "i2s3_src_div",
> -				      "i2s0_mclk_en",
> -				      "i2s1_mclk_en",
> -				      "i2s2_mclk_en",
> -				      "i2s3_mclk_en",
> -				      "i2so0_hop_ck",
> -				      "i2so1_hop_ck",
> -				      "i2so2_hop_ck",
> -				      "i2so3_hop_ck",
> -				      "i2si0_hop_ck",
> -				      "i2si1_hop_ck",
> -				      "i2si2_hop_ck",
> -				      "i2si3_hop_ck",
> -				      "asrc0_out_ck",
> -				      "asrc1_out_ck",
> -				      "asrc2_out_ck",
> -				      "asrc3_out_ck",
> -				      "audio_afe_pd",
> -				      "audio_afe_conn_pd",
> -				      "audio_a1sys_pd",
> -				      "audio_a2sys_pd",
> -				      "audio_mrgif_pd";
> -
> -			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> -					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> -					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> -					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
> -			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
> -						 <&topckgen CLK_TOP_AUD2PLL_90M>;
> -			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml
> new file mode 100644
> index 000000000000..70821c37e728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml

mediatek,mt2701-audio.yaml

> @@ -0,0 +1,229 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt2701-afe-pcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Audio Front End (AFE) PCM controller for mt2701
> +
> +description:
> +  The AFE PCM node must be a subnode of the MediaTek audsys device tree node.
> +  # $ref: /schemas/arm/mediatek/mediatek,audsys.yaml#

Drop comment.

> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@collabora.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-audio
> +      - mediatek,mt7622-audio
> +
> +  interrupts:
> +    items:
> +      - description: AFE interrupt
> +      - description: ASYS interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: afe
> +      - const: asys
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: audio infra sys clock
> +      - description: top audio mux 1
> +      - description: top audio mux 2
> +      - description: top audio sys a1 clock
> +      - description: top audio sys a2 clock
> +      - description: i2s0 source selection
> +      - description: i2s1 source selection
> +      - description: i2s2 source selection
> +      - description: i2s3 source selection
> +      - description: i2s0 source divider
> +      - description: i2s1 source divider
> +      - description: i2s2 source divider
> +      - description: i2s3 source divider
> +      - description: i2s0 master clock
> +      - description: i2s1 master clock
> +      - description: i2s2 master clock
> +      - description: i2s3 master clock
> +      - description: i2so0 hopping clock
> +      - description: i2so1 hopping clock
> +      - description: i2so2 hopping clock
> +      - description: i2so3 hopping clock
> +      - description: i2si0 hopping clock
> +      - description: i2si1 hopping clock
> +      - description: i2si2 hopping clock
> +      - description: i2si3 hopping clock
> +      - description: asrc0 output clock
> +      - description: asrc1 output clock
> +      - description: asrc2 output clock
> +      - description: asrc3 output clock
> +      - description: audio front end pd clock
> +      - description: audio front end conn pd clock
> +      - description: top audio a1 sys pd
> +      - description: top audio a2 sys pd
> +      - description: audio merge interface pd
> +
> +  clock-names:
> +    items:
> +      - const: infra_sys_audio_clk
> +      - const: top_audio_mux1_sel
> +      - const: top_audio_mux2_sel
> +      - const: top_audio_a1sys_hp
> +      - const: top_audio_a2sys_hp
> +      - const: i2s0_src_sel
> +      - const: i2s1_src_sel
> +      - const: i2s2_src_sel
> +      - const: i2s3_src_sel
> +      - const: i2s0_src_div
> +      - const: i2s1_src_div
> +      - const: i2s2_src_div
> +      - const: i2s3_src_div
> +      - const: i2s0_mclk_en
> +      - const: i2s1_mclk_en
> +      - const: i2s2_mclk_en
> +      - const: i2s3_mclk_en
> +      - const: i2so0_hop_ck
> +      - const: i2so1_hop_ck
> +      - const: i2so2_hop_ck
> +      - const: i2so3_hop_ck
> +      - const: i2si0_hop_ck
> +      - const: i2si1_hop_ck
> +      - const: i2si2_hop_ck
> +      - const: i2si3_hop_ck
> +      - const: asrc0_out_ck
> +      - const: asrc1_out_ck
> +      - const: asrc2_out_ck
> +      - const: asrc3_out_ck
> +      - const: audio_afe_pd
> +      - const: audio_afe_conn_pd
> +      - const: audio_a1sys_pd
> +      - const: audio_a2sys_pd
> +      - const: audio_mrgif_pd
> +
> +  assigned-clock-parents: true
> +  assigned-clock-rates: true
> +  assigned-clocks: true

Drop all three.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents
> +  - assigned-clock-rates
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        audsys: audio-subsystem@11220000 {

Drop example. You are duplcating the other one and it is enough if one
binding has full picture.



Best regards,
Krzysztof

