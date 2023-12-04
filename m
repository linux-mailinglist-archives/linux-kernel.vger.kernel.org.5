Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4374803DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjLDS5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjLDS4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:56:46 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A46F0;
        Mon,  4 Dec 2023 10:56:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00c200782dso664720166b.1;
        Mon, 04 Dec 2023 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716210; x=1702321010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pri3ddujsFeLv389wEODEb2MJ2HdQA1JC0+3zG94NUY=;
        b=eqvi8LpMVitvQwbWXo87t+Q4K7GdL9VfM0r9MZsi3anI6hFrV6GVFZRBC2COCJssXY
         FOvhCWfIl8svXsNVFe12IrGAY2VB4oWBC0cq5nuMK+9MHQxomm+nYLlzysLh8ji6kJ4U
         TgFHlWepNtN/v1nSIOIlHCq2rVkX/GeYnC8Y6vTkKaJb24gRY7BkSfpFjNRzVJ7GUvhL
         F4mwiPK2y+0wNtilt0AcvX9H+pv24QOCPTfu3RXkmJiY17d/9v0Vgu7yWCey2yVoJa8K
         eYVdnvS5/WrQvzY+ehedUtfymR/NYSHryRr3a75JI8t7Bbfl5smmPFjPCXNEaONsrH9A
         aKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716210; x=1702321010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pri3ddujsFeLv389wEODEb2MJ2HdQA1JC0+3zG94NUY=;
        b=waYgd53I9B7zgMrKQJued/xOCHvfzmix2W8fi/5f0cfQnkMzTwKgWs49z52WhWwv81
         2DUdKER/ZlkwJE0UAbaorcHrqZH/gxI7ULmVT7cOZbgH0o6Jc5NMV/Dw7qCZzbDtvDQx
         NdYruaGX05SMmcYYW8PDSiIUep0sxPiiK1rYeZjMczII1aDc3qd0lYHm0khxx4QSsdTR
         6IjYp2qrwzKtnmevkAtwCXOHHRQu2x9Yk1VgxVKfbmtXXNj2oCNRIgvP4VJqFl7yy2PI
         NaYsWD4/SBscOf0mw7CZtyeKsFMRvA9slnnynqOdkobW6HFabHv791QcU/xcgUYY1dhs
         U6jw==
X-Gm-Message-State: AOJu0YyBQdCrZNb49KIjDi9xwFj5GNGeQnIHbjisvsi+hiSrXjV5ITbZ
        NoSm5W4L9CYxTkJ7AgA7pBbCcpUiKw==
X-Google-Smtp-Source: AGHT+IGnP+vNUpVLS/Ix1nYmpgtRz3wo5KT/7n9jXzwcrtYk1AyMn8XyPfIEuOuPjnH3bC3jQwA37Q==
X-Received: by 2002:a17:906:d797:b0:a19:5e12:d570 with SMTP id pj23-20020a170906d79700b00a195e12d570mr1718314ejb.64.1701716210062;
        Mon, 04 Dec 2023 10:56:50 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:55ff:210b:5393:c9d7? ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id di16-20020a170906731000b00a1b6d503e7esm1847680ejc.157.2023.12.04.10.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:56:49 -0800 (PST)
Message-ID: <3f235189-da75-4e9d-ad68-8cbebca12f6d@gmail.com>
Date:   Mon, 4 Dec 2023 19:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: drm: rockchip: convert
 inno_hdmi-rockchip.txt to yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        hjc@rock-chips.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,
Am 04.12.23 um 18:39 schrieb Johan Jonker:
> Convert inno_hdmi-rockchip.txt to yaml.
Nice - I'm having something very similar on my queue :)
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Note for rob+dt:
>    Used enum to "soon" be able to add "rockchip,rk3128-inno-hdmi"
Yeah, actually I'm planning to submit it really soon (if timne allows).
> 
> Changed V1:
>    Rename file to more common layout
>    Add/fix hdmi_out port example
> ---
>   .../display/rockchip/inno_hdmi-rockchip.txt   |  49 ---------
>   .../display/rockchip/rockchip,inno-hdmi.yaml  | 103 ++++++++++++++++++
>   2 files changed, 103 insertions(+), 49 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
> deleted file mode 100644
> index cec21714f0e0..000000000000
> --- a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Rockchip specific extensions to the Innosilicon HDMI
> -================================
> -
> -Required properties:
> -- compatible:
> -	"rockchip,rk3036-inno-hdmi";
> -- reg:
> -	Physical base address and length of the controller's registers.
> -- clocks, clock-names:
> -	Phandle to hdmi controller clock, name should be "pclk"
> -- interrupts:
> -	HDMI interrupt number
> -- ports:
> -	Contain one port node with endpoint definitions as defined in
> -	Documentation/devicetree/bindings/graph.txt.
> -- pinctrl-0, pinctrl-name:
> -	Switch the iomux of HPD/CEC pins to HDMI function.
> -
> -Example:
> -hdmi: hdmi@20034000 {
> -	compatible = "rockchip,rk3036-inno-hdmi";
> -	reg = <0x20034000 0x4000>;
> -	interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&cru  PCLK_HDMI>;
> -	clock-names = "pclk";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&hdmi_ctl>;
> -
> -	hdmi_in: port {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		hdmi_in_lcdc: endpoint@0 {
> -			reg = <0>;
> -			remote-endpoint = <&lcdc_out_hdmi>;
> -		};
> -	};
> -};
> -
> -&pinctrl {
> -	hdmi {
> -		hdmi_ctl: hdmi-ctl {
> -			rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
> -					<1 9  RK_FUNC_1 &pcfg_pull_none>,
> -					<1 10 RK_FUNC_1 &pcfg_pull_none>,
> -					<1 11 RK_FUNC_1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -};
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
> new file mode 100644
> index 000000000000..96889c86849a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,inno-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Innosilicon HDMI controller
> +
> +maintainers:
> +  - Sandy Huang <hjc@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3036-inno-hdmi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
The interrupts/clock description exists already in the txt-bindings - so 
how about:

+    items:
+      - descrition: ....
> +
> +  clock-names:
> +    const: pclk
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Port node with one endpoint connected to a vop node.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Port node with one endpoint connected to a hdmi-connector node.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - pinctrl-0
> +  - pinctrl-names
> +  - ports
> +
> +additionalProperties: false
Did you check that with dtbs_check? RK3036's SoC dtsi also contains a

  rockchip,grf = <&grf>;

and I'm not seeing this removed in this series.

It would be great if that would added here to as requirement
for RK3036 too  (and updated in the example)
Even if it is beyond a pure txt to yaml conversion: RK3036 needs to set 
HDMI polarities in GRF.

Regards,
Alex
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3036-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    hdmi: hdmi@20034000 {
> +      compatible = "rockchip,rk3036-inno-hdmi";
> +      reg = <0x20034000 0x4000>;
> +      interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru  PCLK_HDMI>;
> +      clock-names = "pclk";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&hdmi_ctl>;
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hdmi_in: port@0 {
> +          reg = <0>;
> +          hdmi_in_vop: endpoint {
> +            remote-endpoint = <&vop_out_hdmi>;
> +          };
> +        };
> +
> +        hdmi_out: port@1 {
> +          reg = <1>;
> +          hdmi_out_con: endpoint {
> +            remote-endpoint = <&hdmi_con_in>;
> +          };
> +        };
> +      };
> +    };
> +
> +    pinctrl {
> +      hdmi {
> +        hdmi_ctl: hdmi-ctl {
> +          rockchip,pins = <1 RK_PB0 1 &pcfg_pull_none>,
> +                          <1 RK_PB1 1 &pcfg_pull_none>,
> +                          <1 RK_PB2 1 &pcfg_pull_none>,
> +                          <1 RK_PB3 1 &pcfg_pull_none>;
> +        };
> +      };
> +    };
> --
> 2.39.2
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

