Return-Path: <linux-kernel+bounces-516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB12814256
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A64BB20CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098DD30E;
	Fri, 15 Dec 2023 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uj+t1/7y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71ED297
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67adc37b797so2993446d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702625231; x=1703230031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a18momHU0cA7dq8ixWwr9NxFTC1XlwJBWi3s0wx38Ck=;
        b=Uj+t1/7yB9WgP+SPm22ywNDkiKDukxByfXGFTWk7GgFMXrWKpqY7Zz9HthUuGc6K5C
         fHouF40ZADER0VWV8DDZSw7m3TL9Ivx5RL9WWhShVoSF/fZEUWDl0Za29/Htep92CeN8
         jlnT8TUyMSXm+wXIKVt9ZPkPvRwMvh/ja/g7iWt94cFjRpsok3xfZ84BDbbLJlXuzOe9
         YXNu5uxBtCBCWzmNaayxL0wKOciVVjYMsLyPpGa6oMUcbIqTluKu+myo/SHzB9sfI7To
         HfH8hi+gwrXHhlGVRLFXHJCCGrRecrdiefETjLcBZh8JFlBDMjCHwJ9lHo7Qpdso9XHw
         wn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625231; x=1703230031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a18momHU0cA7dq8ixWwr9NxFTC1XlwJBWi3s0wx38Ck=;
        b=s9XWWHCFgg+zVFoTtNYekS21vnAKZL9qhL38S8+t2RAVcxXVJ+9FiBcSBgl98p2bfE
         PZY/Sl+eSuo3c3DFu9c0GdijZ4xSCnRvqjMsOxinhN6DZp+YB5gHXCpDruAMan+B7IQf
         mEMIRmGom+FuT5y3R8HXDpe8MqCbqDSj617qbtqyuXXpsFosRvQP0Lj2ZOf70Y3A89dJ
         iZ0qQZOGmKtHXGWdt7zK3JY7/1hye3z+Ah+hSZK6aNHCrkALR+pr+eRruMqkkMpnEFW2
         eisrvd35Wx+4/L3Rg8k7tI8UJmLC1aW/RWOtW2wP4OWhFYiJomxwSwfNgEwoAQOwz0OC
         Zuog==
X-Gm-Message-State: AOJu0YxjmszjOOFtjKIZe/qYwWKUF7NVbnOUHIvG3dY9Ja+k9kg0U44Q
	geSTPmS1QAA9HR0XGrwEX7iuqA==
X-Google-Smtp-Source: AGHT+IFs1bJuKEwshcNjmdQYsyD+A+QhCMvOhqCCwOxNKejvnYpaG8Ht7MhZ3Ozi0Ff/AupocUpccA==
X-Received: by 2002:a05:6214:cc6:b0:67f:4c0:4f1a with SMTP id 6-20020a0562140cc600b0067f04c04f1amr5223444qvx.1.1702625230842;
        Thu, 14 Dec 2023 23:27:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id es12-20020a056214192c00b0067f1359da7bsm663879qvb.83.2023.12.14.23.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 23:27:10 -0800 (PST)
Message-ID: <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
Date: Fri, 15 Dec 2023 08:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
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
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231214090304.16884-6-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2023 10:03, Luo Jie wrote:
> Update the yaml file for the new DTS properties.
> 
> 1. cmn-reference-clock for the CMN PLL source clock select.
> 2. clock-frequency for MDIO clock frequency config.
> 3. add uniphy AHB & SYS GCC clocks.
> 4. add reset-gpios for MDIO bus level reset.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 +++++++++++++++++-
>  1 file changed, 139 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 3407e909e8a7..79f8513739e7 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -20,6 +20,8 @@ properties:
>            - enum:
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
> +              - qcom,ipq5332-mdio
>            - const: qcom,ipq4019-mdio
>  
>    "#address-cells":
> @@ -30,19 +32,77 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 5
>      description:
> -      the first Address and length of the register set for the MDIO controller.
> -      the second Address and length of the register for ethernet LDO, this second
> -      address range is only required by the platform IPQ50xx.
> +      the first Address and length of the register set for the MDIO controller,
> +      the optional second, third and fourth address and length of the register
> +      for ethernet LDO, these three address range are required by the platform
> +      IPQ50xx/IPQ5332, the last address and length is for the CMN clock to
> +      select the reference clock.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 5
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
> +  cmn-reference-clock:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Nothing improved here

> +    oneOf:
> +      - items:

So it is enum or not?

> +          - enum:
> +              - 0   # CMN PLL reference internal 48MHZ
> +              - 1   # CMN PLL reference external 25MHZ
> +              - 2   # CMN PLL reference external 31250KHZ
> +              - 3   # CMN PLL reference external 40MHZ
> +              - 4   # CMN PLL reference external 48MHZ
> +              - 5   # CMN PLL reference external 50MHZ
> +              - 6   # CMN PLL reference internal 96MHZ
> +
> +  clock-frequency:
> +    oneOf:
> +      - items:

Same questions

> +          - enum:
> +              - 12500000
> +              - 6250000
> +              - 3125000
> +              - 1562500
> +              - 781250
> +              - 390625
> +    description:
> +      The MDIO bus clock that must be output by the MDIO bus hardware,
> +      only the listed frequencies above can be supported, other frequency
> +      will cause malfunction. If absent, the default hardware value 0xff
> +      is used, which means the default MDIO clock frequency 390625HZ, The
> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
> +      register, there is higher clock frequency requirement on the normal
> +      working case where the MDIO slave devices support high clock frequency.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  reset-assert-us:
> +    maxItems: 1

This does not look related to ipq5332.

> +
> +  reset-deassert-us:
> +    maxItems: 1

Neither this.

>  
>  required:
>    - compatible
> @@ -61,6 +121,8 @@ allOf:
>                - qcom,ipq5018-mdio
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq5332-mdio
> +              - qcom,ipq9574-mdio
>      then:
>        required:
>          - clocks
> @@ -70,6 +132,20 @@ allOf:
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
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -100,3 +176,62 @@ examples:
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
> +      compatible = "qcom,ipq5332-mdio",
> +                   "qcom,ipq4019-mdio";
> +      cmn-reference-clock = <0>;
> +      clock-frequency = <6250000>;
> +
> +      reset-gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
> +      reset-assert-us = <100000>;
> +      reset-deassert-us = <100000>;
> +
> +      reg = <0x90000 0x64>,
> +            <0x9B000 0x800>,
> +            <0x7A00610 0x4>,
> +            <0x7A10610 0x4>;

Lowercase hex, wrong order of properties. Align it with coding style.



Best regards,
Krzysztof


