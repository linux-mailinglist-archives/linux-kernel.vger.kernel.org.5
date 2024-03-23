Return-Path: <linux-kernel+bounces-112307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23C887827
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCC41F21D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBB14ABA;
	Sat, 23 Mar 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqZ1IbBP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BF1A38DB;
	Sat, 23 Mar 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711191385; cv=none; b=ll6MAfbpVRUFQVQYdxZcFYcW29pBtMPNOSx1ivpoFzPMPYRpXWNpnaIBdQ1FhyvpUweddhlOwOq26K/99lkrROk0sGhsWCkMePkNBjrsVrjynzdHaTIVBod+QzYa70FUdtoM/s+JIMdTo4hf5xFwE4TgN7f93y16PIWYpr0XIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711191385; c=relaxed/simple;
	bh=SnC5QYv4/0iB65yGcdAqdyXKRmvTsETFl9oSsReXIH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pToPRN0El+KY+Y4AbMu17XwQfTfdsmYK9q0P81vdwbQPH/eyT/92g3pXrEkvAyVDPbx2/x9U7g5GV8QsFPGfI4pScdtPcXausohaVA8PLaNx9QAsffR6danJzBV+yD+nsi9jqvpJRMCIlPkiJich0raQpYp7SuHd11rdirzWKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqZ1IbBP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41400a9844aso22812725e9.0;
        Sat, 23 Mar 2024 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711191382; x=1711796182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T89lugZZm+sK/OwQC/VrSH4+YBlryHzMWMY+9vJ7rZ4=;
        b=kqZ1IbBPAvWocySEvSCjXAZDGmHNwWXPGzffhh/EHYVefq0jPddvWyOwLAUmiVt6a6
         Ha1ocjAgzbsbeEaMaD9Cp+L9QqiIlP6cxKiciQVNJjqvwjDsCDJeafayMuTG3J3pbMjy
         RjqoKNJYboO83N2MbRJ/iqI6Iv1caSasEU3D0Ms5rVP+Aetnl+YMUjn31XD28ENqXqan
         m7SvZRNZ0nj6n7aUPKLjOYvVOFcYGwbnf9SUlBdn0+vaPZmE9+QSAby03yWnt4vdcpQY
         0M/yMDTTfmmbBy2wkW41NG1ghrpCiHzoryuS/ygzwUAoWxR55sRrIxZxW75+Ms2XtPY9
         decQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711191382; x=1711796182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T89lugZZm+sK/OwQC/VrSH4+YBlryHzMWMY+9vJ7rZ4=;
        b=dgSK2VS1V8lJn2e6dvAuCo9qpCZZX5M9VtpfVCDpTGhY1rPq7n3deI7lNxQOTwgatI
         iPLn6j5LYjJK5R0rjvNjlOOsNo2sJTy1raZz34Okey9lwex69u3FDu89Uug5L+ZNsKmy
         PucXSv+NMltPlb3oRkB46TbMvRoI6TAAgMVWBXQISasftIIRo5ePYKgPUvX3pAqe4o9K
         Hx4dYhtXEtBNYpQNCVAEiBjPirUAVw6TO5N6aFO8EvRhHvubzaLoFJ/QcOrQ7G+X0ubx
         wNHH+2sXI2Z1hC9vBTkv14tvIP3VywuS1O8vFxh9zx6XkQ/207/UzcD/EqFeohmZBpbv
         jBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSl7L0776+ypi07SorlQYOIa2ZO1mPNOe87P+BR0y7vF9Mg57CJJXJhcJFHVdg1vz1IQFL32W+8s3qTU7Fz849nicYJudh3tsxfdygPMq3hqyiZpYUO11aAzOxjuRc3ebW7mOnujHLBgTVuKK8PcrLFxZdfRax/RwvFamQFVYP1CGyuyc=
X-Gm-Message-State: AOJu0Yw/XDj2Jd03n7y2jrqKsV1F6k5dXlVqPYbSbX2KdXjz2jysbqM4
	ErF/bJjqTAZ6/vBoYaxqrXzV/lhlZlfcnKcHBrj/nsyi1A12qFw=
X-Google-Smtp-Source: AGHT+IFjvMTxrAPgAxiFi0hukZKVkQEPlqo+pP4JejA5ZZnSvnrZv+lDfiAlrQrGGNVKjpgzQkOaGQ==
X-Received: by 2002:adf:fb4a:0:b0:33e:6760:5298 with SMTP id c10-20020adffb4a000000b0033e67605298mr1287289wrs.29.1711191381500;
        Sat, 23 Mar 2024 03:56:21 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:fbb8:7547:139d:a40f? ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d51ce000000b0033e9fca1e49sm4160326wrv.60.2024.03.23.03.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:56:21 -0700 (PDT)
Message-ID: <3c0d5aa2-55fb-4827-bcd4-256e6ae55ee9@gmail.com>
Date: Sat, 23 Mar 2024 11:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: Add rk816 binding
Content-Language: en-US, de-DE
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240323085852.116756-1-knaerzche@gmail.com>
 <20240323085852.116756-2-knaerzche@gmail.com>
 <bfe79f3d-1615-45a4-81f7-7e30740308d7@linaro.org>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <bfe79f3d-1615-45a4-81f7-7e30740308d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Am 23.03.24 um 11:32 schrieb Krzysztof Kozlowski:
> On 23/03/2024 09:58, Alex Bee wrote:
>> Add DT binding document for Rockchip's RK816 PMIC
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>> changes since v1:
>>    - lowercase/hyphens for regulator node names
>>    - rename "-reg" to "-regulator" to make node names generic
> I don't understand why did you do it. I did not ask for it. If you want
> to rename, drop redundant regulator or reg suffix from node names.
You didn't ask for that, thats true.

I did it regardless, since node names should be generic and the "-reg"
suffix is not. They are all subnodes of "regulators", indeed, but I don't
think dropping the suffix completely makes the binding any better, since
there is a boost(-switch) and an otg-switch which are also subnodes of
"regulators" and they are just switches.

Alex
>
>>    - dropped superfluous description for clock-output-names and
>>      wakeup-source
>>    - dropped "|" for text blocks that don't require to preserve formatting
>>    - use full path for `$ref`s
>>    - added pins description to the binding
>>    - added charger function to description
>>   
>>   .../bindings/mfd/rockchip,rk816.yaml          | 269 ++++++++++++++++++
>>   1 file changed, 269 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
>> new file mode 100644
>> index 000000000000..9664162f4f75
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
>> @@ -0,0 +1,269 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/rockchip,rk816.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: RK816 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Chris Zhong <zyw@rock-chips.com>
>> +  - Zhang Qing <zhangqing@rock-chips.com>
>> +
>> +description:
>> +  Rockchip RK816 series PMIC. This device consists of an i2c controlled MFD
>> +  that includes regulators, a RTC, a GPIO controller, a power button, and a
>> +  battery charger manager with fuel gauge.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk816
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    description:
>> +      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
>> +    const: 1
>> +
>> +  clock-output-names:
>> +    maxItems: 2
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  system-power-controller:
>> +    type: boolean
>> +    description:
>> +      Telling whether or not this PMIC is controlling the system power.
>> +
>> +  wakeup-source:
>> +    type: boolean
>> +
>> +  vcc1-supply:
>> +    description:
>> +      The input supply for dcdc1-regulator.
>> +
>> +  vcc2-supply:
>> +    description:
>> +      The input supply for dcdc2-regulator.
>> +
>> +  vcc3-supply:
>> +    description:
>> +      The input supply for dcdc3-regulator.
>> +
>> +  vcc4-supply:
>> +    description:
>> +      The input supply for dcdc4-regulator.
>> +
>> +  vcc5-supply:
>> +    description:
>> +      The input supply for ldo1-regulator, ldo2-regulator, and ldo3-regulator.
>> +
>> +  vcc6-supply:
>> +    description:
>> +      The input supply for ldo4-regulator, ldo5-regulator, and ldo6-regulator.
>> +
>> +  vcc7-supply:
>> +    description:
>> +      The input supply for boost.
>> +
>> +  vcc8-supply:
>> +    description:
>> +      The input supply for otg-switch.
>> +
>> +  regulators:
>> +    type: object
>> +    patternProperties:
>> +      "^(boost|dcdc[1-4]-regulator|ldo[1-6]-regulator|otg-switch)$":
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        unevaluatedProperties: false
>> +    unevaluatedProperties: false
>> +
>> +patternProperties:
>> +  '-pins$':
> Keep consistent quotes, so either ' or ".
>
>> +    type: object
>> +    additionalProperties: false
>> +    $ref: /schemas/pinctrl/pinmux-node.yaml
>> +
>> +    properties:
>> +      function:
>> +        enum: [pin_fun_gpio, pin_fun_thermistor]
> gpio, thermistor
> (pin_fun is redundant)
>
>> +
>> +      pins:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        const: gpio0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/pinctrl/rockchip.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rk816: pmic@1a {
>> +            compatible = "rockchip,rk816";
>> +            reg = <0x1a>;
>> +            interrupt-parent = <&gpio0>;
>> +            interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
>> +            clock-output-names = "xin32k", "rk816-clkout2";
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pmic_int_l>;
>> +            gpio-controller;
>> +            system-power-controller;
>> +            wakeup-source;
>> +            #clock-cells = <1>;
>> +            #gpio-cells = <2>;
>> +
>> +            vcc1-supply = <&vcc_sys>;
>> +            vcc2-supply = <&vcc_sys>;
>> +            vcc3-supply = <&vcc_sys>;
>> +            vcc4-supply = <&vcc_sys>;
>> +            vcc5-supply = <&vcc33_io>;
>> +            vcc6-supply = <&vcc_sys>;
> Add pins node to the example.
>
> Best regards,
> Krzysztof
>

