Return-Path: <linux-kernel+bounces-143996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8A8A4089
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059511C20D93
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918F1C6B9;
	Sun, 14 Apr 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IORocknP"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849E1BF27
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074984; cv=none; b=VD3tDaAehui0LU1jQVQTifnHVyJKazKtxeZwQkZbxxwokPyd0w24QIGhTap4ua2AZqsJj5Y0l86nrPqH9zaAnBnJ54ofizlwoAetN7ONnh4kGMfCqvIbDNPl0YJWtoazqSgCHg4cCOEPUYwEcNShOvgsCoP0qNWjWACjwMj4Qfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074984; c=relaxed/simple;
	bh=tV3iOEyquH0DhgcnL2VflNn8ea2xv5Iop9DT83BaobA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gu0oQws4VQ1MZkS9PAHRhgw0o0POV9K3WISYb4huI5/7iUn0NbzzVX8ENhZj91XTpR1Ig0nI627Rz8vBTTk2w+L71KkmP3t7EeFh6uPRU8l7Xs0p3Bm5f73cPPwfK2AfUCN4eYqZiGXgApNBkUu3ufH4m+n82bD+A2daL0pEyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IORocknP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5264dc9b17so8812766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713074981; x=1713679781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8h9MKD/isJ62SBrCUg7yXtxM3Ynk3rIOeGl2PTjk+hA=;
        b=IORocknPONU91g4pgJorckcvfSP0lDzTAmAAiThvsW6lvdqUZDpi8tWrGSVs3kOvHF
         SvhwbS23fKgAzS18zOnhLg2RMPl+OST5dzjBJZ5xB1bPpK/2W2bv3NGEKAKKF8tLgx7E
         Snk3lzA6o3VxKV7RibrkfGTqCy+qPWUaBASesKogFX6YUPimyNp9XQBYaOHV+10sZoI8
         mGgqszV2cMEgrGd58HEsqsA8773hQxSkYFa4/OJ+RKVgfufzBdGO//EaeWu8ETl6VUj9
         /gm3DiVWJ6SyZxIavugdtvplsi8Uoqq8DTI2QUYKrY1pvCGsTOduq9uDZMqZ0fi+z+Pz
         dhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713074981; x=1713679781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8h9MKD/isJ62SBrCUg7yXtxM3Ynk3rIOeGl2PTjk+hA=;
        b=MY4PPCh1a/WWA8Pw2jLuYUcgrBvTv/aK5UK+LAq9m6QZSjxchYkMMHjPid8W1AcvZn
         ZpXKxIpdhMSkuOgkYECaDqlfIL1UCDaaAVahwysGYrqWQ6sD6hwxJkVTWpTraykIf2RQ
         I+E9xr8wNm3xUne/7QXoKDM2+coT0aPE0+iAlJb7dZgyJOnqDJfno5m1mWSzC32BmTK1
         00OeLTdmBiFzXbL02rV4f7kS+DmoODeqh1OkpNL3477Y82/F4QVwsCG8EtPrBVZycS8d
         +GClIrUp/79RQ7S3591jP7uBsR2PwJYWPPXhPHr0qOqPmBMUt7GEJLeUls/MX5F+rwn+
         lDsA==
X-Forwarded-Encrypted: i=1; AJvYcCW3efu9jSSXTEgsXrE4P1T7sIFTiPQfmt6nV13FU1aeB2DFksOlosr8ZxOQVCbAmyu5yYe6IW4RfdK/oGypuL27uMO2rBDC7jDxabzm
X-Gm-Message-State: AOJu0YzTtQgq6+EO2En4px6CKiTqejb2l3mSFjh+bhjX/SlyVsOFZeoZ
	GLft49VUVIgw7AbpWILaJ5522q15T1dCWPY4Jfzyk+FKYjyzumO1UbUoOX0I3Uk=
X-Google-Smtp-Source: AGHT+IGgmpdwoSQjqLjimpUlEsQbnIPt+4kl1TSepb9xdUqyowlRA7NVI1ZBmUT3RUuTzG9n4FU5NA==
X-Received: by 2002:a17:907:6d0c:b0:a51:d49f:b6b5 with SMTP id sa12-20020a1709076d0c00b00a51d49fb6b5mr4397466ejc.49.1713074980868;
        Sat, 13 Apr 2024 23:09:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x26-20020a170906711a00b00a521591ffacsm3812011ejj.34.2024.04.13.23.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:09:40 -0700 (PDT)
Message-ID: <b3227721-1244-48eb-87b4-8aaac46885d1@linaro.org>
Date: Sun, 14 Apr 2024 08:09:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin
 controller
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 00:14, Andrea della Porta wrote:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Missing commit msg. We can't take empty commits. You have entire commit
msg to describe the hardware, why not doing this?


Plus, this wasn't even tested...

> ---
>  .../pinctrl/brcm,bcm2712-pinctrl.yaml         | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> new file mode 100644
> index 000000000000..2908dfe99f3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/brcm,bcm2712-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2712 pin controller
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description:
> +  Bindings for Broadcom's BCM2712 memory-mapped pin controller.

Drop "Bindings for" and describe hardware. Bindings do not have to tell
they are bindings, it's obvious. They cannot be anything else.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2712-pinctrl
> +      - brcm,bcm2712-aon-pinctrl
> +      - brcm,bcm2712c0-pinctrl
> +      - brcm,bcm2712c0-aon-pinctrl
> +      - brcm,bcm2712d0-pinctrl
> +      - brcm,bcm2712d0-aon-pinctrl
> +
> +  reg:
> +    items:
> +      - description: pin control registers
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  anyOf:
> +    - type: object  
> +      allOf:
> +        - $ref: pincfg-node.yaml#
> +        - $ref: pinmux-node.yaml#
> +
> +      properties:
> +        function: 
> +          enum: [ gpio, alt1, alt2, alt3, alt4, alt5, alt6, alt7, alt8,
> +                 aon_cpu_standbyb, aon_fp_4sec_resetb, aon_gpclk, aon_pwm,
> +                 arm_jtag, aud_fs_clk0, avs_pmu_bsc, bsc_m0, bsc_m1, bsc_m2,
> +                 bsc_m3, clk_observe, ctl_hdmi_5v, enet0, enet0_mii,
> +                 enet0_rgmii, ext_sc_clk, fl0, fl1, gpclk0, gpclk1, gpclk2,
> +                 hdmi_tx0_auto_i2c, hdmi_tx0_bsc, hdmi_tx1_auto_i2c,
> +                 hdmi_tx1_bsc, i2s_in, i2s_out, ir_in, mtsif, mtsif_alt,
> +                 mtsif_alt1, pdm, pkt, pm_led_out, sc0, sd0, sd2, sd_card_a,
> +                 sd_card_b, sd_card_c, sd_card_d, sd_card_e, sd_card_f,
> +                 sd_card_g, spdif_out, spi_m, spi_s, sr_edm_sense, te0, te1,
> +                 tsio, uart0, uart1, uart2, usb_pwr, usb_vbus, uui, vc_i2c0,
> +                 vc_i2c3, vc_i2c4, vc_i2c5, vc_i2csl, vc_pcm, vc_pwm0,
> +                 vc_pwm1, vc_spi0, vc_spi3, vc_spi4, vc_spi5, vc_uart0,
> +                 vc_uart2, vc_uart3, vc_uart4 ]
> +
> +        pins:
> +          items:
> +            pattern: "^((aon_)?s?gpio[0-6]?[0-9])|(emmc_(clk|cmd|dat[0-7]|ds))$"
> +
> +        bias-disable: true
> +        bias-pull-down: true
> +        bias-pull-up: true
> +      additionalProperties: false
> +
> +    - type: object
> +      additionalProperties:
> +        $ref: "#/additionalProperties/anyOf/0"
> +
> +examples:
> +  - |
> +    pinctrl: pinctrl@7d504100 {
> +      compatible = "brcm,bcm2712-pinctrl";
> +        reg = <0x7d504100 0x30>;
> +
> +        uarta_24_pins: uarta_24_pins {

Underscores are not allowed. Please observe the rules of DTS coding
style (see docs).

> +          pin_rts {
> +            function = "uart0";
> +            pins = "gpio24";
> +            bias-disable;
> +        };
> +
> +        pin_cts {
> +            function = "uart0";
> +            pins = "gpio25";
> +            bias-pull-up;
> +        };
> +      };
> +
> +      spi10_gpio2: spi10_gpio2 {
> +        function = "vc_spi0";
> +        pins = "gpio2", "gpio3", "gpio4";

Messed indentation. Keep 4 space.

> +        bias-disable;
> +      };
> +    };
> +...

Best regards,
Krzysztof


