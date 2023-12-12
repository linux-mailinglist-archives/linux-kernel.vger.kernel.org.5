Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B832280F779
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377159AbjLLUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:06:37 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADCB9;
        Tue, 12 Dec 2023 12:06:44 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5913922ab10so600965eaf.1;
        Tue, 12 Dec 2023 12:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411603; x=1703016403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8geil9tvbaN7HFo/6GZKxMiCtuP3jXSKj9KAGFYxaw=;
        b=GDEsMCkYTXCUUOY+Q7ePkTSVcVWhabWHLMnrgOSrulukGizDjszR8sWFfJsKtilvnR
         Le3Bqny8OkA7AyhNGztuJBaYdAgMpuOkYagqIrFK3g4iPzb3y9tTWQPLuNYsv6thKPmq
         N647WoR31+XWfLS1QaFaWBoLemdWM85ZvSex1/d8HfyRrp4oYM4kzBkI1VWJzSSWVT97
         GF8shdyJvvIubdBsWOxmFYeXQ7uC5Xfw+Ni1wckLOANZGRsaxQ7i9+8QSMmfTwk3g9YR
         FdZggsFGm5ircDv2UBRb82eMBPWecvcb2AN2LDUNAIzbzYuhaROzqpsHh+yf57QMkx17
         HwTQ==
X-Gm-Message-State: AOJu0YxkfAvdaBZ3WgVyzWG7LlPN9sCkbCt8L7jrzT7f6p8MqlPpgJOc
        TeyqOucRjZt+znBaQVFTdQ==
X-Google-Smtp-Source: AGHT+IH7jxGi5ypSPpeOqUsvcN4v2uWH6feiDoZUUpsKHHfmeUZ9aMS03ruIyRAily1J5bH3d1LoOg==
X-Received: by 2002:a05:6820:607:b0:590:97b9:5565 with SMTP id e7-20020a056820060700b0059097b95565mr4906684oow.12.1702411603276;
        Tue, 12 Dec 2023 12:06:43 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o14-20020a4a384e000000b0058dc4a5de5bsm2628979oof.14.2023.12.12.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:06:42 -0800 (PST)
Received: (nullmailer pid 2549596 invoked by uid 1000);
        Tue, 12 Dec 2023 20:06:41 -0000
Date:   Tue, 12 Dec 2023 14:06:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, robert.marko@sartura.hr,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <20231212200641.GA2331615-robh@kernel.org>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212115151.20016-6-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
> Update the yaml file for the new DTS properties.
> 
> 1. cmn-reference-clock for the CMN PLL source clock select.
> 2. clock-frequency for MDIO clock frequency config.
> 3. add uniphy AHB & SYS GCC clocks.
> 4. add reset-gpios for MDIO bus level reset.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++++-
>  1 file changed, 153 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 3407e909e8a7..9546a6ad7841 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -20,6 +20,8 @@ properties:
>            - enum:
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
> +              - qcom,ipq5332-mdio
>            - const: qcom,ipq4019-mdio

A driver can function without knowing about all these new registers and 
clocks? If not, then it can't be compatible with "qcom,ipq4019-mdio".

>  
>    "#address-cells":
> @@ -30,19 +32,71 @@ properties:
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
> +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for the CMN clock
> +      to select the reference clock.
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

These are all clock inputs to this h/w block and not some other clocks 
you want to manage?

>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: gcc_mdio_ahb_clk
> +      - const: gcc_uniphy0_ahb_clk
> +      - const: gcc_uniphy1_ahb_clk
> +      - const: gcc_uniphy0_sys_clk
> +      - const: gcc_uniphy1_sys_clk

"gcc" is presumably the name of the clock controller in QCom chips. 
Well, the clock source should not be part of the binding. The names 
should be local for what they are for. So drop 'gcc_'. And '_clk' is 
also redundant, so drop it too. Unfortunately you are stuck with the 
name of the 1st entry.

> +
> +  cmn-reference-clock:
> +    oneOf:
> +      - items:
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
> +          - enum:
> +              - 12500000
> +              - 6250000
> +              - 3125000
> +              - 1562500
> +              - 781250
> +              - 390625
> +    description:
> +      The MDIO bus clock that must be output by the MDIO bus hardware,
> +      only the listed frequecies above can be configured, other frequency
> +      will cause malfunction. If absent, the default hardware value is used.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  reset-assert-us:
> +    maxItems: 1
> +
> +  reset-deassert-us:
> +    maxItems: 1
>  
>  required:
>    - compatible
> @@ -61,6 +115,8 @@ allOf:
>                - qcom,ipq5018-mdio
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq5332-mdio
> +              - qcom,ipq9574-mdio
>      then:
>        required:
>          - clocks
> @@ -70,6 +126,40 @@ allOf:
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
> +          items:
> +            - const: mdio
> +            - const: eth_ldo1
> +            - const: eth_ldo2
> +            - const: cmn_blk

Perhaps cmn_blk should come 2nd, so all the variants have the same entry 
indices. Then you can move this to the top level and just say 'minItems: 
4' here.


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-mdio
> +    then:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: mdio
> +            - const: eth_ldo1
> +            - const: eth_ldo2
> +            - const: eth_ldo3
> +            - const: cmn_blk

And 'minItems: 5' here.

The ipq9574 adds the CMN block, but none of the clocks? Weird.

Rob
