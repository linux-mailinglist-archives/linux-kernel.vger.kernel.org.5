Return-Path: <linux-kernel+bounces-24382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C541B82BBD2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47183288B17
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC55D726;
	Fri, 12 Jan 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnJD3sNI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A785D720
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e6275e897so11302915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705044750; x=1705649550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lZ5pNbtd5svoAtnRiRjmNP8aGu9v/OGDfR2LrQqfcI=;
        b=dnJD3sNIwk4k4EErbbgU4C+5JHsz1tEukZteDngy6OMS3ofJEVGPSEZ3ZQtDvE2+y/
         ki4mFEWTf7GQDOcwD8OyNrZg8NKMy0H0jo2BPgPpFiWTjBQfITrD7zpxp3flU9uPg4ss
         0e4RiOFejsGw7LCn4Yd8ryC6H7nDhePbpw6mFVZZmUy0V7ztYay0+6/WZYdAlg/onUg+
         BHvdGJx5OeoNlnhpifQV88xa6aZzlfreme69W9oyIxfT4fbjGHgmbwbPF3tee8FyJrJl
         Wq6MDNpX6SkFRYhgb+LeDoKkE0Jp2pm68ueUAXIXZFV9uPBu5g+HEpxtP003NPKIrieY
         SfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705044750; x=1705649550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lZ5pNbtd5svoAtnRiRjmNP8aGu9v/OGDfR2LrQqfcI=;
        b=HIVvMPdC0R33ok8NA2P7vLvHbre0oElGaq61RPro3Zp29svevAYMWNFOEiyNgxgfrY
         3OHBzEihPEyJXQuXkiU9tS+xDKF03+hbCKuyLOd8MmzlDOE2ZmA7L/+i5rQjsx+SsArn
         6ksZOXHIIPb+tWYVqJ3SJaz9bjwyB7LVKs0LeD3yzgXupdD6C/rXtaOcTiDJoqgfra7o
         /T3Wq5gdf10mIp5XZyoV5uqq8jakK3S3qjuq5ZIQpDgc/pbIFfFCWpd3EiEX35r7N/oI
         CaaeBZ74oR13e6X7DsDvwWev7fRx4D1KvBpHFYSo1rdRL6IOqPeRoIchUKCE/2H3Armn
         tG9A==
X-Gm-Message-State: AOJu0YxGT9SOjaB0yjd6KwP6fjDOVbNZ/mDvJQRq/nbMPwYsrYix2kLa
	l0n624CxdDyaiSSMTrjTsUYqTzWX6YIkFQ==
X-Google-Smtp-Source: AGHT+IGzrGPxGzNAZX6qZ4D5J6KUh7V9eHw2NVyhm5+yZevc/neWxyTrugEGlvWIOfMIm/tD6kzldQ==
X-Received: by 2002:a05:600c:512a:b0:40d:5a3f:8e90 with SMTP id o42-20020a05600c512a00b0040d5a3f8e90mr536073wms.20.1705044750092;
        Thu, 11 Jan 2024 23:32:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b0040d5a5c523csm8647963wms.1.2024.01.11.23.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 23:32:29 -0800 (PST)
Message-ID: <e0bf8667-cbb8-49ba-bb44-3edf93b019b8@linaro.org>
Date: Fri, 12 Jan 2024 08:32:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Content-Language: en-US
To: Julien Stephan <jstephan@baylibre.com>
Cc: Louis Kuo <louis.kuo@mediatek.com>, Phi-Bang Nguyen
 <pnguyen@baylibre.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Andy Hsieh <andy.hsieh@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Florian Sylvestre <fsylvestre@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Paul Elder <paul.elder@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-2-jstephan@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110141443.364655-2-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 15:14, Julien Stephan wrote:
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
> some Mediatek SoC, such as the mt8365
> 

..

> +  clock-names:
> +    items:
> +      - const: camsys
> +      - const: top_mux
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      phandle to the PHYs connected to CSI0/A, CSI1, CSI2 and CSI0B
> +
> +  phy-names:
> +    minItems: 1
> +    items:
> +      - const: csi0
> +      - const: csi1
> +      - const: csi2
> +      - const: csi0b

Why one hardware has flexible number of phys?

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0 or CSI0A port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI1 port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI2 port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0B port
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 2
> +
> +      port@4:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for cam0
> +
> +      port@5:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for cam1
> +
> +      port@6:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv0
> +
> +      port@7:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv1
> +
> +      port@8:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv2
> +
> +      port@9:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: connection point for camsv3
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - port@2
> +      - port@3
> +      - port@4
> +      - port@5
> +      - port@6
> +      - port@7
> +      - port@8
> +      - port@9
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +          #address-cells = <2>;
> +          #size-cells = <2>;

Use 4 spaces for example indentation.

> +
> +          seninf: seninf@15040000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                compatible = "mediatek,mt8365-seninf";
> +                reg = <0 0x15040000 0 0x6000>;
> +                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
> +                clocks = <&camsys CLK_CAM_SENIF>,
> +                         <&topckgen CLK_TOP_SENIF_SEL>;
> +                clock-names = "camsys", "top_mux";
> +
> +                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +
> +                phys = <&mipi_csi0 PHY_TYPE_DPHY>;
> +                phy-names = "csi0";
> +
> +                ports {
> +                      #address-cells = <1>;
> +                      #size-cells = <0>;
> +
> +                      port@0 {
> +                            reg = <0>;
> +                            seninf_in1: endpoint {
> +                              clock-lanes = <2>;
> +                              data-lanes = <1 3 0 4>;
> +                              remote-endpoint = <&isp1_out>;
> +                            };
> +                      };
> +
> +                      port@1 {
> +                          reg = <1>;
> +                      };
> +
> +                      port@2 {
> +                            reg = <2>;
> +                      };
> +
> +                      port@3 {
> +                            reg = <3>;
> +                      };
> +
> +                      port@4 {
> +                            reg = <4>;
> +                            seninf_camsv1_endpoint: endpoint {
> +                                remote-endpoint = <&camsv1_endpoint>;
> +                            };
> +                      };
> +
> +                      port@5 {
> +                            reg = <5>;
> +                      };
> +
> +                      port@6 {
> +                            reg = <6>;
> +                      };
> +
> +                      port@7 {
> +                            reg = <7>;
> +                      };
> +
> +                      port@8 {
> +                            reg = <8>;
> +                      };
> +
> +                      port@9 {
> +                            reg = <9>;
> +                      };
> +

Stray blank line

> +                };



Best regards,
Krzysztof


