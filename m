Return-Path: <linux-kernel+bounces-10989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A881DFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F7E1C21941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534635F03;
	Mon, 25 Dec 2023 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhIdIX2h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB920315B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55504e8f4b9so50468a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 02:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703500166; x=1704104966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMtZPIBYa/8heH7pO7+DWMFBqswYdH3OLLD6M7Ba8/I=;
        b=VhIdIX2hK5wNmjTrKF/PMJuOUkQnKSJHY4jb963KU07urvNUuSKRqNiBeHPERCcNbD
         5qHS/sFQ3iQ5u/MBQAfQ9ciGNuXxzlkFTW8t7+nynH6amj6HZT5ZgVj9QqBcpWq8IFXX
         vlU5/seZeAj0AlyalhET+zwx1KA8Fd2Tpc3VOOho04AJQeWDshZNKQ2rGwxtpPcMbDLU
         mUBsAdNQdFDmE3U+z3hltkovGey6jzOBG18yBUTTMryJ78uKD9jUkuiJy3LDqlFoZFog
         trkEs96UAKEFAyeTfeQqo0c3u67lNVXD5dABnrH+j9powojrjF2BPIqnB44BxbD87uWC
         75jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703500166; x=1704104966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMtZPIBYa/8heH7pO7+DWMFBqswYdH3OLLD6M7Ba8/I=;
        b=awEp1zCmSFvlk4EjxkZWNc+gDudim61CRKz2xLqZ5gSRnlA9ML2Kqdg/i449z0SqyB
         Biqu6CeIejRm9KVVFje6weNkjWtky938ifjluh2+NQgOaSnCr61Jxm26Ols+0KvifeOm
         Oh2wjYSSobbegz57okw2qwYDBEVMwLP6IZPVR6Bin17W+Ru0Hfj5MHWMUA9qU/2faHqa
         5ucRHv1lR1vgrwymB2dGYFtX3/vOVFnqqL68mdoFTAq5uJ6n/iB+XIvb6DTX+Yu8zvms
         KkKRvWV+hJfXMfyLoj1ckxZUUbXzYLK5mUhRmKPcb4gEUDgbb6p5PB6V4I9j/xdSfOyk
         eMyg==
X-Gm-Message-State: AOJu0YzsB/zSN9zNNB/+SbEbFbIw6gsy91EHoUB5vS1mXi+FF4PKLJOG
	zx4jTdUGSlDLqKEldlyuSpPVvScY+eE0vg==
X-Google-Smtp-Source: AGHT+IGdVzxNr7gdGTcSOx5gxYzLss/EQDSCj88+P0YC2DCoMC7H1CH/WtVpWIJP8gfF4JB8DumQNQ==
X-Received: by 2002:a17:906:116:b0:a23:5e39:4628 with SMTP id 22-20020a170906011600b00a235e394628mr2900814eje.26.1703500166023;
        Mon, 25 Dec 2023 02:29:26 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id fg8-20020a1709069c4800b00a1fa7e39957sm4731383ejc.136.2023.12.25.02.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:29:25 -0800 (PST)
Message-ID: <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
Date: Mon, 25 Dec 2023 11:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231225084424.30986-6-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/12/2023 09:44, Luo Jie wrote:
> Update the yaml file for the new DTS properties.
> 
> 1. qcom,cmn-ref-clock-frequency for the CMN PLL source clock select.
> 2. clock-frequency for MDIO clock frequency config.
> 3. add uniphy AHB & SYS GCC clocks.

I see two new compatibles, so your list is missing main point.

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 +++++++++++++++++-
>  1 file changed, 136 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 3407e909e8a7..205500cb1fd1 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -18,8 +18,10 @@ properties:
>  
>        - items:
>            - enum:
> +              - qcom,ipq5332-mdio
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
>            - const: qcom,ipq4019-mdio
>  
>    "#address-cells":
> @@ -30,19 +32,76 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 2
> -    description:
> -      the first Address and length of the register set for the MDIO controller.
> -      the second Address and length of the register for ethernet LDO, this second
> -      address range is only required by the platform IPQ50xx.
> +    maxItems: 5
> +    description: |
> +      The first address and length of the register set for the MDIO controller,
> +      the optional second address and length of the register is for CMN block,
> +      the optional third, fourth and fifth address and length of the register
> +      for Ethernet LDO, the optional Ethernet LDO address range is required by

Wait, required? You said in in response to Rob these are not required!

> +      the platform IPQ50xx/IPQ5332.

So these are valid for all platforms or not? Looks not, but nothing
narrows the list for other boards.

Anyway, why do you add entries in the middle? LDO was the second, so it
cannot be now fifth.

> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: mdio
> +      - const: cmn_blk
> +      - const: eth_ldo1
> +      - const: eth_ldo2
> +      - const: eth_ldo3
>  
>    clocks:
> +    minItems: 1
>      items:
>        - description: MDIO clock source frequency fixed to 100MHZ
> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: gcc_mdio_ahb_clk
> +      - const: uniphy0_ahb
> +      - const: uniphy1_ahb
> +      - const: uniphy0_sys
> +      - const: uniphy1_sys
> +
> +  qcom,cmn-ref-clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 25000000
> +      - 31250000
> +      - 40000000
> +      - 48000000
> +      - 50000000
> +      - 96000000
> +    default: 48000000
> +    description: |
> +      The reference clock source of CMN PLL block is selectable, the
> +      reference clock source can be from wifi module or the external
> +      xtal, the reference clock frequency 48MHZ can be from internal
> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
> +      if the 48MHZ is specified, which means the external 48Mhz is used.

This does not resolve mine and Conor's concerns from previous version.
External clocks are defined as clock inputs.

> +
> +  clock-frequency:
> +    enum:
> +      - 390625
> +      - 781250
> +      - 1562500
> +      - 3125000
> +      - 6250000
> +      - 12500000
> +    default: 390625
> +    description: |
> +      The MDIO bus clock that must be output by the MDIO bus hardware,
> +      only the listed frequencies above can be supported, other frequency
> +      will cause malfunction. If absent, the default hardware value 0xff
> +      is used, which means the default MDIO clock frequency 390625HZ, The
> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
> +      register, there is higher clock frequency requirement on the normal
> +      working case where the MDIO slave devices support high clock frequency.
>  
>  required:
>    - compatible
> @@ -59,8 +118,10 @@ allOf:
>            contains:
>              enum:
>                - qcom,ipq5018-mdio
> +              - qcom,ipq5332-mdio
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
>      then:
>        required:
>          - clocks
> @@ -70,6 +131,20 @@ allOf:
>          clocks: false
>          clock-names: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5332-mdio
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5
> +        reg-names:
> +          minItems: 4

Why all other variants now have 5 clocks and 5 reg entries? Nothing of
it is explained in the commit msg.

> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -100,3 +175,59 @@ examples:
>          reg = <4>;
>        };
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mdio@90000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;

That's not the order of properties. compatible is always the first, reg
and reg-names follow. See DTS coding style.

> +      compatible = "qcom,ipq5332-mdio",
> +                   "qcom,ipq4019-mdio";
> +
> +      reg = <0x90000 0x64>,
> +            <0x9b000 0x800>,
> +            <0x7a00610 0x4>,
> +            <0x7a10610 0x4>;
> +

Drop blank line.

> +      reg-names = "mdio",
> +                  "cmn_blk",
> +                  "eth_ldo1",
> +                  "eth_ldo2";
> +
> +      clocks = <&gcc GCC_MDIO_AHB_CLK>,
> +               <&gcc GCC_UNIPHY0_AHB_CLK>,
> +               <&gcc GCC_UNIPHY1_AHB_CLK>,
> +               <&gcc GCC_UNIPHY0_SYS_CLK>,
> +               <&gcc GCC_UNIPHY1_SYS_CLK>;
> +

Drop blank line

> +      clock-names = "gcc_mdio_ahb_clk",
> +                    "uniphy0_ahb",
> +                    "uniphy1_ahb",
> +                    "uniphy0_sys",
> +                    "uniphy1_sys";
> +
> +      clock-frequency = <6250000>;
> +      reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
> +

Best regards,
Krzysztof


