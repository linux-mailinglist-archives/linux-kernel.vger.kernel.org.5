Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C042C8082D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378143AbjLGIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjLGIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:22:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51B71991
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:21:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so3450405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701937303; x=1702542103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fPwpR6cjf4gl+iJ2edVyQ5QVngSHrLLuTQ/c3n689y0=;
        b=gsZOY8Zn0ideRDd9HHr79zcFHqDozcDbDOTgxAquY5gEHSO6V6fJ12fPPM6PzpDp7v
         +NZM4sNSM6oQQ4IAmi+i1MnF7gJswiy/jrbHifYDhqIHeLLPayCSxOCeLwaFxYF+Pa9e
         bKv7roa50OmlW6vXvM4r9G3fWTt2gBc3HcFc3AIp1zpVDZ7N5hmoTXrRUmVn0In9jAUd
         n/XsGyZP9DhYUEJ6TlekI5bdoA2BmdrjURPwT2RNoRaJGxdlQuj3aiV8tVdxtLUgE+y5
         3vhXthn0qAymrygnYQqyO/DrCPYd2HQHuUI0nTJwtECJczJt+ExqPTJPTsD//QkU5Oax
         LiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937303; x=1702542103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPwpR6cjf4gl+iJ2edVyQ5QVngSHrLLuTQ/c3n689y0=;
        b=EvNdOinuDxvU/Lpg5LMGZv9DnMEzfvm74/f/zGTphlJLs/Ig0Grqrr6qWB4dWJdajo
         fGQBEY2L4uh00S1wfT/nkDPxri6Sg/t5/jFy/gLvLenUdHGcdhjXnIi+iaKlAm01DwKf
         fo3qy+nem0CZ7L+FRQPbvsDbPiN2OgHLS3guHwhI9w2IZVkMmf17c+LD9S2Fvsme+loO
         ECSfHWbVR7iUmdI/q8dgidrL1a2plETIXIvu39aZd3yHLcLxJ8zubmNkSX20Ir66aqkj
         8LOx9RuIVnmlSGV3tfxtZ1MveTHieGWOhEUNdGJJmeUTXBF9Xa0pKwRIJMVhxVWlnU4V
         D01A==
X-Gm-Message-State: AOJu0Ywh7yJrgRDzOQd3w6AIMMNl0rv4tBZXD586wGWh1V9cbODSY/M/
        zr/BJm8E+cNquS4aYYOs69NKdQ==
X-Google-Smtp-Source: AGHT+IGG7QLYaH+Oo1cYq79KdJYAiV++XaIXXAxgTVSDkn3fzotgBZNT5mlR7KvgyOGB6p+b8hzpww==
X-Received: by 2002:a05:600c:d4:b0:40c:2698:db59 with SMTP id u20-20020a05600c00d400b0040c2698db59mr535004wmm.11.1701937303017;
        Thu, 07 Dec 2023 00:21:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b003333a0da243sm777924wrq.81.2023.12.07.00.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:21:42 -0800 (PST)
Message-ID: <a7a9a204-cfd2-4510-890d-ce3f72d5fcda@linaro.org>
Date:   Thu, 7 Dec 2023 09:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
To:     Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     shengnan.wang@mediatek.com, yaya.chang@mediatek.com,
        10572168@qq.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com,
        hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com,
        gerald.loacker@wolfvision.net, andy.shevchenko@gmail.com,
        bingbu.cao@intel.com, dan.scally@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-3-zhi.mao@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231207052016.25954-3-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 06:20, Zhi Mao wrote:
> Add YAML device tree binding for GC08A3 CMOS image sensor,
> and the relevant MAINTAINERS entries.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  .../bindings/media/i2c/galaxycore,gc08a3.yaml | 127 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> new file mode 100644
> index 000000000000..1802ff1c8a12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
> +
> +maintainers:
> +  - Zhi Mao <zhi.mao@mediatek.com>
> +
> +description:
> +  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
> +  interface and CCI (I2C compatible) control bus. The output format
> +  is raw Bayer.
> +
> +properties:
> +  compatible:
> +    const: galaxycore,gc08a3
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      External clock for the sensor.
> +    maxItems: 1

Items must be defined or just drop the property. How did it even appear?
Who asked for this? Your changelog is so vague that anything can happen
with this code and you will claim "it was review fix". No, you must
explain the changes.

Go back to previous review and implement all the changes requested.

> +
> +  clock-frequency:
> +    description:
> +      Frequency of the clock in Hz.

Drop property


> +
> +  dovdd-supply: true
> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  enable-gpios:
> +    description: Reference to the GPIO connected to the RESETB pin. Active low.

That's not enable, but reset-gpios.

> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +    description:
> +      Output port node, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            oneOf:
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +
> +          link-frequencies: true
> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-frequency
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - enable-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor0@31 {
> +            status = "okay";

Drop. Do you see it anywhere in the bindings examples?

> +            compatible = "galaxycore,gc08a3";
> +            reg = <0x31>;
> +
> +            clocks = <&gc08a3_clk>;
> +            clock-names = "xvclk";

Drop

> +            clock-frequency = <24000000>;

Drop

> +
> +            enable-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
> +
> +            avdd-supply = <&gc08a3_avdd>;
> +            dovdd-supply = <&ogc08a3_dovdd>;
> +            dvdd-supply = <&gc08a3_dvdd>;
> +
> +            port {
> +                sensor0_out_2: endpoint {
> +                    data-lanes = <1 2 3 4>;
> +                    link-frequencies = /bits/ 64 <336000000 207000000>;
> +                    remote-endpoint = <&seninf_csi_port_0_in_2>;
> +                };
> +            };
> +        };
> +

Drop stray blank line.

> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index b752f8902367..1a16a94fb202 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -502,6 +502,8 @@ patternProperties:
>      description: Fujitsu Ltd.
>    "^fxtec,.*":
>      description: FX Technology Ltd.
> +  "^galaxycore,.*":
> +    description: GalaxyCore Inc.

That's a duplicated patch... how many of this people are going to send?

Drop and rebase on top of previous work of people.


Best regards,
Krzysztof

