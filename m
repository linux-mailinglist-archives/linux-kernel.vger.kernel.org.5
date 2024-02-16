Return-Path: <linux-kernel+bounces-68171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322018576CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BD31C21F55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F107179A7;
	Fri, 16 Feb 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVhwxfTc"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611CFC01
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068292; cv=none; b=mHpSsCO2NIG+rJLnYLFtPby7YcxjALQYfmCeXvHMzKhJvZ/U3CVieZzmUfXgF+t619CaOFmMm+VVOPPQRDlM4FXhLBiENr+v1hfcEwCh/BZtvlEsymOTU4YTloqvUcmTeFHVzOeHw++gTpnhGET/TQF9Y5o/qby5it7zY7Vt+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068292; c=relaxed/simple;
	bh=/SqVhQgpKI1E4RyEInDbXFAp8/tWhZz4DQurd8+5o88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3gPM2TtzK+s7rE8ziV06LXr6nKyp8+j9EMVxiR+azgQ/DRRoq+Re2VO+XIcJlpyCLSGJxNtcfAMfZI0mB6wIilQikGBbBr3mPALFoW+KUbbPhsB1JO9X3vBw2Q4aoT4tzFrGxn1KG0oq8kFpyyiibxxtmZfdMOnv7McsK7Ctzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVhwxfTc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2a17f3217aso214223866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708068288; x=1708673088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOq/eZHJxAkxfersOyBhj802ukljFhVCw6Zcj8NrWz4=;
        b=DVhwxfTcA1rik4bxLQiiriwqkhW5TnkeQA8g5QgDHtdIIvlc7UJrZdTGuF0icytrlP
         zI1XwT5dNbX+6tqOx902PqaVJbrbXDEz+Lu4UnT4erUoTn9rcK+y5NiGmZCRyZ1n4IRL
         zcOM4CYpSjdohnLpFm7nhqd884XZ0OjROeOT4rhMgLLa3tbeMVrXKwXRacHqRGKCs+T+
         UwGfEAnTrRQavbXJ88g4C+MjckmKht4ZP3oVMccoldwoRl7/iZ88xDvkvUBcn0BgZyIH
         aXI8IeExyztoStSoEUdl1KcGK7mOZQzZaJYolwnDhBFvN7kPzX/oc3hxhM6sBfRZ+CnE
         7gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068288; x=1708673088;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOq/eZHJxAkxfersOyBhj802ukljFhVCw6Zcj8NrWz4=;
        b=banyiAAZgaAK4y8I+a1d0ebOTwVrOxkVbO1hSeePGR09/v44csy6iHlYsJyUZy4a02
         I4jLijhA+AVn8kLLefPsuIx35AKyz37XZXvgHN22dtzT6IVbKGeipHrJPeDZzjEKM3mQ
         khWNpENauhVjxZYZv4EpcqDt35xOUlLDXnBNgRJxErGILcZdytNS3m4IQePTatJrbORC
         xuTpIczF+bEDfNbfi88ECwFU2AvzCeRzE59f047jL6HA7pOVVgajZ4o+QNIdA4n2r9L/
         ZdN0DZK15LnEogRrioslxYR/9GDrSGSP8258ykziGRjeJbRkuQQtpe0iyQh2J9dQnBwO
         cWxA==
X-Forwarded-Encrypted: i=1; AJvYcCVrTSpweWVVPxmFWGnzvpz2LutR/+bsEf7XDX0YfF5QniiEiFTKvAUZDPEWPqUbvkVJbb5mFYtuq8KX90BJaX2T/2002idQXswTnWLc
X-Gm-Message-State: AOJu0Yxvodou4fdYSjBLxh6Jr1++cX8F9o19o8IGATpVlRN0aLj4ggxA
	lDevIJ9257qxbbOPsOGt3Dhx6c1AchEvzUQUmAdsM8sFNI+5ZWxq2XnKuEV3lgY=
X-Google-Smtp-Source: AGHT+IH00fY3pDmriKm0vafpOiv3E31lLLtOrIG6O+VhYiBAdSJd35VMyPu4aLiMDB27OTwGj1p2qQ==
X-Received: by 2002:a17:907:119c:b0:a3d:4037:73e7 with SMTP id uz28-20020a170907119c00b00a3d403773e7mr2434396ejb.48.1708068287700;
        Thu, 15 Feb 2024 23:24:47 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709065ad600b00a3d68aad90dsm1282264ejs.97.2024.02.15.23.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 23:24:47 -0800 (PST)
Message-ID: <5cecd33c-7436-4b2a-84c2-8a28c87b26b3@linaro.org>
Date: Fri, 16 Feb 2024 08:24:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Content-Language: en-US
To: forbidden405@outlook.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-net-v1-4-e0ad972cda99@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> This binding gets rewritten. Compared to previous txt based binding doc,
> the following changes are made:
> 
> - No "hisi-femac-v1/2" binding anymore
> - Remove unused Hi3516 SoC, add Hi3798MV200
> - add MDIO subnode
> - add phy clock and reset

I don't understand why conversion you make in two commits. Please
perform proper conversion and then propose changes to the binding.

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml
> new file mode 100644
> index 000000000000..008127e148aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon-femac.yaml

Use compatible as filename.

> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hisilicon-femac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Fast Ethernet MAC controller
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@foxmail.com>
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3798mv200-femac
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      The first region is the MAC core register base and size.
> +      The second region is the global MAC control register.

Just items: - description: instead of all this.

> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

Drop

> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: mac
> +      - const: macif
> +      - const: phy
> +
> +  resets:
> +    minItems: 2

Drop

> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: mac
> +      - const: phy
> +
> +  hisilicon,phy-reset-delays-us:
> +    minItems: 3
> +    maxItems: 3
> +    description: |
> +      The 1st cell is reset pre-delay in micro seconds.
> +      The 2nd cell is reset pulse in micro seconds.
> +      The 3rd cell is reset post-delay in micro seconds.

items:
 - description:

Anyway, isn't this property of the phy?


> +
> +patternProperties:
> +  '^mdio@[0-9a-f]+$':
> +    type: object
> +    description: See ./hisi-femac-mdio.txt

No, please first convert other file and then reference it here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phy-connection-type
> +  - phy-handle
> +  - hisilicon,phy-reset-delays-us
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/histb-clock.h>
> +
> +    #ifndef HISTB_ETH0_PHY_CLK
> +    #define HISTB_ETH0_PHY_CLK 0
> +    #endif

Drop these defines.

> +    femac: ethernet@9c30000 {

Drop label.

> +        compatible = "hisilicon,hi3798mv200-femac";
> +        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
> +        ranges = <0x0 0x9c30000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&crg HISTB_ETH0_MAC_CLK>,
> +                 <&crg HISTB_ETH0_MACIF_CLK>,
> +                 <&crg HISTB_ETH0_PHY_CLK>;
> +        clock-names = "mac", "macif", "phy";
> +        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
> +        reset-names = "mac", "phy";
> +        phy-handle = <&fephy>;
> +        phy-connection-type = "mii";
> +        // To be filled by bootloader
> +        mac-address = [00 00 00 00 00 00];
> +        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
> +        status = "okay";

Drop

> +
> +        mdio: mdio@1100 {

Drop label

> +            compatible = "hisilicon,hisi-femac-mdio";
> +            reg = <0x1100 0x20>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            status = "okay";

Drop

> +
> +            fephy: ethernet-phy@1 {

Drop label


> +                reg = <1>;
> +                #phy-cells = <0>;
> +            };
> +        };
> +    };
> 

Best regards,
Krzysztof


