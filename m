Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC07D23FB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:57:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473EAD6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 08:57:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859dee28cso9170155e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697990267; x=1698595067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N0HNTujzSTON/YO3D33TA/n0CfPJMm6x/GfcXkb7TcU=;
        b=ZkDxrlYDKi0j/kB2bEUHivKN/UdZCZT4vDzcuDroW4/37j+PPLfgxs9udHny/iztrz
         5a2M19cJM/zwIpB9j3g3rMsUz+7GdtDzTZyxYUxUXl7PBabfhCHjzsxAU4wdHVTqaZ7d
         kid0gErbP6FPDQYkL9n50S66f/jgbjEZG5tHxxs8ATb9YMwxbmpAnAqco6lhu0HmXZTt
         eKg0qJcaAIUV7+ROAyH6piDHHY/ORW+CPHnmnH3lB+BjhMM2zLv9EY5G3iunPzv7XVS+
         yRzFSYrZBNlHwyxrq0xEgqmvi5Jw+Y8CzRngoQr07n26VEquP0n22rmQERC1IsrWd7Cc
         Elhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697990267; x=1698595067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0HNTujzSTON/YO3D33TA/n0CfPJMm6x/GfcXkb7TcU=;
        b=AHd9qSqkVPLkF4IHavIGP2rkpgm5sVs1xkhIqGGV5Q3ODHiEJ+/pO1XsVZWw+8aF28
         Hba8IBz3n5HQV8fwYDnlZ5Bzf0RkjRrAzxLrBLML8dgUJBxGhKyWfQknfLtHJ+e5XLa9
         HdS4CnCtIw61n7TBG+m2QqlcttINwWEGeEWD4gS8/aTF/NBOmpt9xx8pEz4tvCrcK32U
         QZTTPxJ9qlSe4TMosTYGoRx7d7gEJaN9Xp0kZf/RSEAqNKHLonHiPQyZBK8dS6/4o10g
         T2o3NiU8M7ISZmvr+iuwoyxRQGtMkKoidWtbjF3SW71V+0BwyQVz+M0B3MT7Zq1jtvJU
         a5HA==
X-Gm-Message-State: AOJu0Yw7wjyx3oin5dALlT1N+Qq+vED6CVvkfdtE1/xRJ+W7gvG5jYRV
        x6YNPTlJpifRdjYa9hXCD1/8rg==
X-Google-Smtp-Source: AGHT+IEKbt1trMiFIIQwJdzggMnhHUiQiklKB1cLGYgTd6+OSvu5WLnXjpVGJ16JikvnmDewD3F/8A==
X-Received: by 2002:a05:600c:474b:b0:3fb:feb0:6f40 with SMTP id w11-20020a05600c474b00b003fbfeb06f40mr5305657wmo.11.1697990266470;
        Sun, 22 Oct 2023 08:57:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b004064741f855sm7121914wmb.47.2023.10.22.08.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 08:57:45 -0700 (PDT)
Message-ID: <0e6a3e08-4f66-4bc1-a8a0-a7bb40472136@linaro.org>
Date:   Sun, 22 Oct 2023 17:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: phy: ralink-usb-phy: convert to dtschema
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20231022131252.801090-1-sergio.paracuellos@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231022131252.801090-1-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2023 15:12, Sergio Paracuellos wrote:
> Convert the ralink-usb-phy bindings to DT schema.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2:
>  - Add missing SPDX License Identifier
> 
>  .../bindings/phy/ralink-usb-phy.txt           | 23 ------
>  .../bindings/phy/ralink-usb-phy.yaml          | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt b/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
> deleted file mode 100644
> index 9d2868a437ab..000000000000
> --- a/Documentation/devicetree/bindings/phy/ralink-usb-phy.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Mediatek/Ralink USB PHY
> -
> -Required properties:
> - - compatible: "ralink,rt3352-usbphy"
> -	       "mediatek,mt7620-usbphy"
> -	       "mediatek,mt7628-usbphy"
> - - reg: required for "mediatek,mt7628-usbphy", unused otherwise
> - - #phy-cells: should be 0
> - - ralink,sysctl: a phandle to a ralink syscon register region
> - - resets: the two reset controllers for host and device
> - - reset-names: the names of the 2 reset controllers
> -
> -Example:
> -
> -usbphy: phy {
> -	compatible = "mediatek,mt7628-usbphy";
> -	reg = <0x10120000 0x1000>;
> -	#phy-cells = <0>;
> -
> -	ralink,sysctl = <&sysc>;
> -	resets = <&rstctrl 22 &rstctrl 25>;
> -	reset-names = "host", "device";
> -};
> diff --git a/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml b/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml
> new file mode 100644
> index 000000000000..b05665f5b641
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ralink-usb-phy.yaml

Filename matching compatible. Missing vendor prefix, comma.


> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/ralink-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek/Ralink USB PHY
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ralink,rt3352-usbphy
> +      - mediatek,mt7620-usbphy
> +      - mediatek,mt7628-usbphy

Keep them ordered alphabetically, please.

Blank line here.


> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  ralink,sysctl:
> +    description:
> +      phandle to a ralink syscon register region.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  resets:
> +    items:
> +      - description: USB Host reset controller
> +      - description: USB Device reset controller
> +
> +  reset-names:
> +    items:
> +      - const: host
> +      - const: device
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt7628-usbphy
> +    then:
> +      required:
> +        - reg

else:
is it even valid?

Anyway, please put allOf: block after required: block.

> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - ralink,sysctl
> +  - resets
> +  - reset-names
> +


Best regards,
Krzysztof

