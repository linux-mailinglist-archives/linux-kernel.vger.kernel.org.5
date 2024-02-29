Return-Path: <linux-kernel+bounces-86899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380686CC78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3525F1C22740
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA1141995;
	Thu, 29 Feb 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmSRlCLC"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B01384A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219498; cv=none; b=LcfE9QPzy4+LrD0TiB7RaF3Hqivca0pSU5bbJkk4jjedJpgKqdM7MS6XkIlbxmOJR9mKTI24FfGvUFtMGVtnWwVk7m4QxTOD2PbydJdbTQY5dhN2nPtp28Q/82LT+hiH2M9XUVx0Vwxr1/Gw4cym8dNkTxqfbwNi1LDRSIV/n1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219498; c=relaxed/simple;
	bh=w8RgmSUsKfxgjlFRR4JwCsw2zCiDB0oUV0wyBvExuyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzUqOFbk2YLOVuUlON0ccCGU1FSJ+Q5Uk6VEspR0N6zkG4UYQppwK+2KPbXFrOiFxJfrwd2zQdM2CAxsuuFSTex2cgB5GCr7l8PPLPlaJyu0x1byOWiGsDjckXxAwhjsvwyOz3Hc8oWnPG4epWXaxkl8HiuvMbBELgEYPQyYfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmSRlCLC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a446478b04bso44433366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709219494; x=1709824294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SK4DmlZ3UR4ujEwkyL5L+rK5LKG8WLdzwFtgogC9zZs=;
        b=NmSRlCLCZUq7qRfgs8PZbdzFeereTs95bkA0mbG54jDp9iaJJwUjPVlMY2ZO0XQFI/
         Q1b5WtLaj3GQMHDnNfWQtPoW4eOTZpKJSyjEtTo9dcJpAaXs+ZK+emprJUjUNAmxScTz
         jdWGx6TulXo/JYfDhuOWouLPMbwEWPBUPzPODsGcwXC81em3djz8RpH8IZ+iPXNnp0cm
         zpRq8rWfEJ/zReo8BR+O1dJe2HTbEZAp7wsFRo7uqv5PHNvV2bS1CslI2ri1Zl3pHVmc
         fL4oYDRCobVogqIZMD/r46w5KL29xhUa6IhxFqgHfoBpFbYg7IVfuLD1iV/YvVECTji0
         IvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219494; x=1709824294;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SK4DmlZ3UR4ujEwkyL5L+rK5LKG8WLdzwFtgogC9zZs=;
        b=TRtc/R/d9wCQkCunRerG7D6YLogQLG6q6RGanFZJjHgXhWr8jxbyq/Ix/f/bS1vpxf
         GJSJODpW1E4Z3L1iwGzp1GlhGnoZP1/1OW6tAzNj8EhmhyncJFu7BlWJflan0ssGStMW
         aCWikFxboKb/cILSMyucBFG9uHjhr+8YfdhlR2sEg76jRSbgKEDmCBLawr17ZmaIDWZf
         IhCzs1RR8ahL8tElj0Dz5PcwAy0uaw7bGngrO3wKwht/ZteDKq2K5QLSe9BAu4WoELbo
         j8Bemh/AZ5JEGY54uflqYWSz7ea5NWnLC6kx7Ph2K7SAufaSnOHrA1m4+fG7tvQ2zFoo
         abjw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1bZjg9oazzn/lOxqCciVDGMfNJFViHcfDEElfVbW3jfHCGUsnJjgzEnmvSyYL85dAntwsAX18nvCfqIYPIuJ7LdeqPSdxoJL5oRE
X-Gm-Message-State: AOJu0Yyiu3HmovfA+8zwxRYceD7y0yrF9eVC6UAhF/CC+vxSQiC1qfmk
	1kJwqbXe41THKyKPdtA+nS0EeTMjT0l1ptdFRx2Z34cts8++nMxxwppZro8fpTU=
X-Google-Smtp-Source: AGHT+IHO8MpWatF0eM1SVYEmepa9c2vRxDwXdOky56bw/phOygpP3Z2PPOzUWJkXPmUxWsJISbMH4Q==
X-Received: by 2002:a17:906:48da:b0:a44:5538:efd3 with SMTP id d26-20020a17090648da00b00a445538efd3mr1128996ejt.37.1709219494496;
        Thu, 29 Feb 2024 07:11:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a4439b7756bsm771333ejc.6.2024.02.29.07.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:11:33 -0800 (PST)
Message-ID: <1a626f74-4559-4403-9d88-6a9a462b54c1@linaro.org>
Date: Thu, 29 Feb 2024 16:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] dt-bindings: usb: ci-hdrc-usb2-imx: move imx
 parts to dedicated schema
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
 conor+dt@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, peter.chen@kernel.org, jun.li@nxp.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-4-xu.yang_2@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228113004.918205-4-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 12:29, Xu Yang wrote:
> As more and more NXP i.MX chips come out, it becomes harder to maintain
> ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
> this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
> a new schema for NXP ChipIdea USB2 Controller, also add a common schema.
> 
> 1. Copy common ci-hdrc-usb2.yaml properties to a new shared
>    ci-hdrc-usb2-common.yaml schema.
> 2. Move fsl,* compatible devices and imx spefific properties
>    to dedicated binding file ci-hdrc-usb2-imx.yaml.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - not remove ci-hdrc-usb2.yaml and move imx parts to ci-hdrc-usb2-imx.yaml
> ---
>  .../bindings/usb/ci-hdrc-usb2-common.yaml     | 197 ++++++++++++++++++
>  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 197 ++++++++++++++++++
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 186 -----------------
>  3 files changed, 394 insertions(+), 186 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml
> new file mode 100644
> index 000000000000..9f8f2f343dd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-common.yaml

Use compatible style for filenames. chipidea,hdrc-usb2-common.yaml
(assuming that "ci" was a shortcut of chipidea)


> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB2 ChipIdea USB controller Common Properties
> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>
> +
> +properties:
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  dr_mode: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  phy_type: true
> +
> +  itc-setting:
> +    description:
> +      interrupt threshold control register control, the setting should be
> +      aligned with ITC bits at register USBCMD.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ahb-burst-config:
> +    description:
> +      it is vendor dependent, the required value should be aligned with
> +      AHBBRST at SBUSCFG, the range is from 0x0 to 0x7. This property is
> +      used to change AHB burst configuration, check the chipidea spec for
> +      meaning of each value. If this property is not existed, it will use
> +      the reset value.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x7
> +
> +  tx-burst-size-dword:
> +    description:
> +      it is vendor dependent, the tx burst size in dword (4 bytes), This
> +      register represents the maximum length of a the burst in 32-bit
> +      words while moving data from system memory to the USB bus, the value
> +      of this property will only take effect if property "ahb-burst-config"
> +      is set to 0, if this property is missing the reset default of the
> +      hardware implementation will be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x20
> +
> +  rx-burst-size-dword:
> +    description:
> +      it is vendor dependent, the rx burst size in dword (4 bytes), This
> +      register represents the maximum length of a the burst in 32-bit words
> +      while moving data from the USB bus to system memory, the value of
> +      this property will only take effect if property "ahb-burst-config"
> +      is set to 0, if this property is missing the reset default of the
> +      hardware implementation will be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x20
> +
> +  extcon:
> +    description:
> +      Phandles to external connector devices. First phandle should point
> +      to external connector, which provide "USB" cable events, the second
> +      should point to external connector device, which provide "USB-HOST"
> +      cable events. If one of the external connector devices is not
> +      required, empty <0> phandle should be specified.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    items:
> +      - description: vbus extcon
> +      - description: id extcon
> +
> +  phy-clkgate-delay-us:
> +    description:
> +      The delay time (us) between putting the PHY into low power mode and
> +      gating the PHY clock.
> +
> +  non-zero-ttctrl-ttha:
> +    description:
> +      After setting this property, the value of register ttctrl.ttha
> +      will be 0x7f; if not, the value will be 0x0, this is the default
> +      value. It needs to be very carefully for setting this property, it
> +      is recommended that consult with your IC engineer before setting
> +      this value.  On the most of chipidea platforms, the "usage_tt" flag
> +      at RTL is 0, so this property only affects siTD.
> +
> +      If this property is not set, the max packet size is 1023 bytes, and
> +      if the total of packet size for previous transactions are more than
> +      256 bytes, it can't accept any transactions within this frame. The
> +      use case is single transaction, but higher frame rate.
> +
> +      If this property is set, the max packet size is 188 bytes, it can
> +      handle more transactions than above case, it can accept transactions
> +      until it considers the left room size within frame is less than 188
> +      bytes, software needs to make sure it does not send more than 90%
> +      maximum_periodic_data_per_frame. The use case is multiple
> +      transactions, but less frame rate.
> +    type: boolean
> +
> +  mux-controls:
> +    description:
> +      The mux control for toggling host/device output of this controller.
> +      It's expected that a mux state of 0 indicates device mode and a mux
> +      state of 1 indicates host mode.
> +    maxItems: 1
> +
> +  mux-control-names:
> +    const: usb_switch
> +
> +  pinctrl-names:
> +    description:
> +      Names for optional pin modes in "default", "host", "device".
> +      In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
> +      In this case, the "idle" state needs to pull down the data and
> +      strobe pin and the "active" state needs to pull up the strobe pin.
> +    oneOf:
> +      - items:
> +          - const: idle
> +          - const: active
> +      - items:
> +          - const: default
> +          - enum:
> +              - host
> +              - device
> +      - items:
> +          - const: default
> +
> +  pinctrl-0:
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: usb-phy
> +
> +  vbus-supply:
> +    description: reference to the VBUS regulator.
> +
> +  usb-phy:
> +    description: phandle for the PHY device. Use "phys" instead.
> +    maxItems: 1
> +    deprecated: true
> +
> +  port:
> +    description:
> +      Any connector to the data bus of this controller should be modelled
> +      using the OF graph bindings specified, if the "usb-role-switch"
> +      property is used.
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +dependencies:
> +  port: [ usb-role-switch ]
> +  mux-controls: [ mux-control-names ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

I don't see where you remove the properties from the existing schema, so
you now just duplicated a lot.

So again let me describe the task:
1. Create common schema by MOVING the common pieces from the existing
schema. The common schema MUST be referenced by other existing schemas.

2. Create IMX specific schema by moving IMX specific bits. New schema
references common schema.

3. The remaining old ci-hdrc-usb2.yaml does not have as a result common
properties and IMX bits.


> +
> +allOf:
> +  - $ref: usb-hcd.yaml#
> +  - $ref: usb-drd.yaml#
> +
> +additionalProperties: true
> \ No newline at end of file

You have patch errors, fix them.

> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> new file mode 100644
> index 000000000000..50494ce06d07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-imx.yaml#

Filename like compatible.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP USB2 ChipIdea USB controller
> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx23-usb
> +              - fsl,imx25-usb
> +              - fsl,imx28-usb
> +              - fsl,imx35-usb
> +              - fsl,imx50-usb
> +              - fsl,imx51-usb
> +              - fsl,imx53-usb
> +              - fsl,imx6q-usb
> +              - fsl,imx6sl-usb
> +              - fsl,imx6sx-usb
> +              - fsl,imx6ul-usb
> +              - fsl,imx7d-usb
> +              - fsl,vf610-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx8dxl-usb
> +              - fsl,imx8ulp-usb
> +          - const: fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usb
> +              - fsl,imx8mn-usb
> +          - const: fsl,imx7d-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx6sll-usb
> +              - fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +          - const: fsl,imx27-usb
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3


No need to, it's already in common. Drop clocks.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3

Drop property.

> +
> +  fsl,usbmisc:
> +    description:
> +      Phandler of non-core register device, with one argument that
> +      indicate usb controller index
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to usbmisc node
> +          - description: index of usb controller
> +
> +  fsl,anatop:
> +    description: phandle for the anatop node.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  disable-over-current:
> +    type: boolean
> +    description: disable over current detect
> +
> +  over-current-active-low:
> +    type: boolean
> +    description: over current signal polarity is active low
> +
> +  over-current-active-high:
> +    type: boolean
> +    description:
> +      Over current signal polarity is active high. It's recommended to
> +      specify the over current polarity.
> +
> +  power-active-high:
> +    type: boolean
> +    description: power signal polarity is active high
> +
> +  external-vbus-divider:
> +    type: boolean
> +    description: enables off-chip resistor divider for Vbus
> +
> +  samsung,picophy-pre-emp-curr-control:
> +    description:
> +      HS Transmitter Pre-Emphasis Current Control. This signal controls
> +      the amount of current sourced to the USB_OTG*_DP and USB_OTG*_DN
> +      pins after a J-to-K or K-to-J transition. The range is from 0x0 to
> +      0x3, the default value is 0x1. Details can refer to TXPREEMPAMPTUNE0
> +      bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0x3
> +
> +  samsung,picophy-dc-vol-level-adjust:
> +    description:
> +      HS DC Voltage Level Adjustment. Adjust the high-speed transmitter DC
> +      level voltage. The range is from 0x0 to 0xf, the default value is
> +      0x3. Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0xf
> +
> +  fsl,picophy-rise-fall-time-adjust:
> +    description:
> +      HS Transmitter Rise/Fall Time Adjustment. Adjust the rise/fall times
> +      of the high-speed transmitter waveform. It has no unit. The rise/fall
> +      time will be increased or decreased by a certain percentage relative
> +      to design default time. (0:-10%; 1:design default; 2:+15%; 3:+20%)
> +      Details can refer to TXRISETUNE0 bit of USBNC_n_PHY_CFG1.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    default: 1
> +
> +  fsl,usbphy:
> +    description: phandle of usb phy that connects to the port. Use "phys" instead.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    deprecated: true

Missing required: block here.

> +
> +allOf:
> +  - $ref: ci-hdrc-usb2-common.yaml#
> +  - if:
> +      properties:
> +        phy_type:
> +          const: hsic
> +      required:
> +        - phy_type
> +    then:
> +      properties:
> +        pinctrl-names:
> +          items:
> +            - const: idle
> +            - const: active
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx7d-clock.h>
> +
> +    usb@30b10000 {
> +        compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
> +        reg = <0x30b10000 0x200>;
> +        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX7D_USB_CTRL_CLK>;
> +        fsl,usbphy = <&usbphynop1>;
> +        fsl,usbmisc = <&usbmisc1 0>;
> +        phy-clkgate-delay-us = <400>;
> +    };
> +
> +  # Example for HSIC:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +
> +    usb@2184400 {
> +        compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
> +        reg = <0x02184400 0x200>;
> +        interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +        fsl,usbphy = <&usbphynop1>;
> +        fsl,usbmisc = <&usbmisc 2>;
> +        phy_type = "hsic";
> +        dr_mode = "host";
> +        ahb-burst-config = <0x0>;
> +        tx-burst-size-dword = <0x10>;
> +        rx-burst-size-dword = <0x10>;
> +        pinctrl-names = "idle", "active";
> +        pinctrl-0 = <&pinctrl_usbh2_idle>;
> +        pinctrl-1 = <&pinctrl_usbh2_active>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@1 {
> +            compatible = "usb424,9730";
> +            reg = <1>;
> +        };
> +    };
> +
> +...


Best regards,
Krzysztof


