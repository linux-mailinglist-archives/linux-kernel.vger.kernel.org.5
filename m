Return-Path: <linux-kernel+bounces-540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77E8142A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CC2B21C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983F17744;
	Fri, 15 Dec 2023 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV+IhtlY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EE18039
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso385143a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702625984; x=1703230784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agoRo2mbV6EcQfr+pR1Y40cC9u9vGwA9AsmLL7KV7sU=;
        b=JV+IhtlYSjAzrKEZOudcxHtgvN2XLoOSGwJAspC/J2PTeWFFdsFaKNpr5P9VKw124d
         5JxRmJHAgLFSW0cI6xiuBSXy3tUvzIKngTWsxGZpDzcGv/IpLc9tShElaYSyS8eFYnIA
         YkEKqjNWHLf+/dFbtYSiIyDTR2i1y0APJI5+N8YqoB8Okg/XGc/jnNjuseKIQDjubNIe
         D9qdIQ+na7GOZNlvSanDq5M2vFyYQo6g/nZi3aqxQQ1w7Z+0eDosRmMCax2ICDYsGiEH
         xXNg/qngybTah0ZslGour/abBtxjE9u8wi+0djll5ulNFxQcaaDoSigisIaHsELJTH2b
         poMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625984; x=1703230784;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agoRo2mbV6EcQfr+pR1Y40cC9u9vGwA9AsmLL7KV7sU=;
        b=CbYUO21cmwRH6UlOEpS+4U6Gwp5fBR7OcXMC/V2T2ZxnuFofMY92eo/ei3jkS2tPYk
         ENI32pZGAne0ENsIv8rGzmGQ2h5IyJ/MWQM081JAKZ3qADlf8iSoItBwP8yxQ6G2LIsM
         bhJUCcUfAblLWcqbBJdVHnAfhQ58mS52eEiq0cnYrHyfHLwus+Z5n2jFbm1toW1QRC37
         v2T9fON0nDOoKjMa811WWmPMqaiZo9mPI5I0rPFUF3DSAgVLCaIlFSdfXzKuTA3gdTG3
         O/XzWANveYcynbLcjppF+H6HCo1nflMcHWB/Ugtu6/TeDFfUVljGQfPNHp71Ukymbfb7
         n2lg==
X-Gm-Message-State: AOJu0YwPIyVR5bfZyrIzlkFJAZucSP2ALFgUd/dCCHFzld1ZEQlIxdHe
	johUhcCvmEutz5iT/4WxXwIE4w==
X-Google-Smtp-Source: AGHT+IEiUR23XzrGSDW6M6qYv/YkPmGftSDu+tJRAV+kw5oNpHwlAd5Agd9tOUpmRGBMdgcBDBx8Yw==
X-Received: by 2002:a17:906:b0c9:b0:a1f:6433:798c with SMTP id bk9-20020a170906b0c900b00a1f6433798cmr4715879ejb.106.1702625984288;
        Thu, 14 Dec 2023 23:39:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ub27-20020a170907c81b00b00a1df4387f16sm10576725ejc.95.2023.12.14.23.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 23:39:43 -0800 (PST)
Message-ID: <52400d96-6ce0-47af-8f25-0b95f9aa9bec@linaro.org>
Date: Fri, 15 Dec 2023 08:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 propetry
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
 p.zabel@pengutronix.de, f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
 <20231214094813.24690-15-quic_luoj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231214094813.24690-15-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2023 10:48, Luo Jie wrote:
> The following properties are added for qca8084 PHY.
> 
> 1. add the compatible string "ethernet-phy-id004d.d180" since
>    the PHY device is not accessible during MDIO bus register.
> 2. add property "qcom,phy-addr-fixup" for customizing MDIO address.

Why? Commit msg must explain why, not "what".

> 3. add property "qcom,phy-work-mode" for specifying qca8084 PHY
>    work mode.

Why?

> 4. add the initial clocks and resets.
Why only initial, not final?

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/net/qca,ar803x.yaml   | 158 +++++++++++++++++-
>  1 file changed, 155 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> index 3acd09f0da86..febff039a44f 100644
> --- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> +++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> @@ -14,9 +14,6 @@ maintainers:
>  description: |
>    Bindings for Qualcomm Atheros AR803x PHYs
>  
> -allOf:
> -  - $ref: ethernet-phy.yaml#
> -
>  properties:
>    qca,clk-out-frequency:
>      description: Clock output frequency in Hertz.
> @@ -85,6 +82,161 @@ properties:
>      $ref: /schemas/regulator/regulator.yaml
>      unevaluatedProperties: false
>  
> +  qcom,phy-addr-fixup:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Why no constraints?

> +    description:
> +      MDIO address for 4 PHY devices and 3 PCS devices


Why do you need to change MMIO address?

> +
> +  qcom,phy-work-mode:
> +    description: PHY device work mode.

Your description copies property name. Tell us something we don't
know... like the meaning of the vcalues.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  clocks:
> +    items:
> +      - description: APB bridge clock
> +      - description: AHB clock
> +      - description: Security control clock
> +      - description: TLMM clock
> +      - description: TLMM AHB clock
> +      - description: CNOC AHB clock
> +      - description: MDIO AHB clock
> +      - description: MDIO master AHB clock
> +      - description: PCS0 system clock
> +      - description: PCS1 system clock
> +      - description: EPHY0 system clock
> +      - description: EPHY1 system clock
> +      - description: EPHY2 system clock
> +      - description: EPHY3 system clock
> +    description: PHY initial common clock configs
> +
> +  clock-names:
> +    items:
> +      - const: apb_bridge
> +      - const: ahb
> +      - const: sec_ctrl_ahb
> +      - const: tlmm
> +      - const: tlmm_ahb
> +      - const: cnoc_ahb
> +      - const: mdio_ahb
> +      - const: mdio_master_ahb
> +      - const: srds0_sys
> +      - const: srds1_sys
> +      - const: gephy0_sys
> +      - const: gephy1_sys
> +      - const: gephy2_sys
> +      - const: gephy3_sys
> +
> +  resets:
> +    items:
> +      - description: PCS0 system reset
> +      - description: PCS1 system reset
> +      - description: EPHY0 system reset
> +      - description: EPHY1 system reset
> +      - description: EPHY2 system reset
> +      - description: EPHY3 system reset
> +      - description: EPHY0 software reset
> +      - description: EPHY1 software reset
> +      - description: EPHY2 software reset
> +      - description: EPHY3 software reset
> +      - description: Ethernet DSP reset
> +    description: PHY initial common reset configs
> +
> +  reset-names:
> +    items:
> +      - const: srds0_sys
> +      - const: srds1_sys
> +      - const: gephy0_sys
> +      - const: gephy1_sys
> +      - const: gephy2_sys
> +      - const: gephy3_sys
> +      - const: gephy0_soft
> +      - const: gephy1_soft
> +      - const: gephy2_soft
> +      - const: gephy3_soft
> +      - const: gephy_dsp
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ethernet-phy-id004d.d180
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: APB bridge clock
> +            - description: AHB clock
> +            - description: Security control clock
> +            - description: TLMM clock
> +            - description: TLMM AHB clock
> +            - description: CNOC AHB clock
> +            - description: MDIO AHB clock
> +            - description: MDIO master AHB clock
> +            - description: PCS0 system clock
> +            - description: PCS1 system clock
> +            - description: EPHY0 system clock
> +            - description: EPHY1 system clock
> +            - description: EPHY2 system clock
> +            - description: EPHY3 system clock
> +        clock-names:
> +          items:
> +            - const: apb_bridge
> +            - const: ahb
> +            - const: sec_ctrl_ahb
> +            - const: tlmm
> +            - const: tlmm_ahb
> +            - const: cnoc_ahb
> +            - const: mdio_ahb
> +            - const: mdio_master_ahb
> +            - const: srds0_sys
> +            - const: srds1_sys
> +            - const: gephy0_sys
> +            - const: gephy1_sys
> +            - const: gephy2_sys
> +            - const: gephy3_sys

?!? Why do you duplicate properties?

> +        resets:
> +          items:
> +            - description: PCS0 system reset
> +            - description: PCS1 system reset
> +            - description: EPHY0 system reset
> +            - description: EPHY1 system reset
> +            - description: EPHY2 system reset
> +            - description: EPHY3 system reset
> +            - description: EPHY0 software reset
> +            - description: EPHY1 software reset
> +            - description: EPHY2 software reset
> +            - description: EPHY3 software reset
> +            - description: Ethernet DSP reset
> +        reset-names:
> +          items:
> +            - const: srds0_sys
> +            - const: srds1_sys
> +            - const: gephy0_sys
> +            - const: gephy1_sys
> +            - const: gephy2_sys
> +            - const: gephy3_sys
> +            - const: gephy0_soft
> +            - const: gephy1_soft
> +            - const: gephy2_soft
> +            - const: gephy3_soft
> +            - const: gephy_dsp
> +      required:
> +        - qcom,phy-addr-fixup
> +        - qcom,phy-work-mode
> +        - clocks
> +        - clock-names
> +        - resets
> +        - reset-names
> +    else:
> +      properties:
> +        qcom,phy-addr-fixup: false
> +        qcom,phy-work-mode: false

And what about clcoks and resets for other variants? Your patch now
defined them for all variants without any explanation in commit msg.

> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof


