Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F957763F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHIPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjHIPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:35:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120130E6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:34:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so2359824a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691595275; x=1692200075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ay4rOaVl7rQWfxgs/lZW3TV6yN7gvT00cFA2eir0n/8=;
        b=u9PFlZVoW/AeylJwTNSDMKr2sZeGySeDeMwi5mwqjbqfdrrbPBECV/5CDVHgtPF7uC
         a1gTFv+rRWNQr1wqQ98GKn52t/q1/lu/gRxFGdGoBv6dCQoFDHMtS51JxoqfM+dM/o9X
         DAskVeuxU/eNHljkfUVOsqzdM0tigmAqgz9YENjVW8BGqSlhZJ+txcW7a3WUyF6qRaWa
         SPMLxqfiadLvyjRsGhc++uCZtbUOaQQWj6LzypQ74YfbEfqFAuGhtitlzcoAb8eIX8rV
         DaerDqHt4ba+gm78c/JkmajrMmTYBLBSpUaaixqKnLaH7ZSHbjLv6vUow3RE3BCKk5up
         G8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595275; x=1692200075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ay4rOaVl7rQWfxgs/lZW3TV6yN7gvT00cFA2eir0n/8=;
        b=YlagxYQGSiCuI5Ix2RItfFVJN11bZqXSQcnwsPZJLJNBZYxlKAOPr+WUCd+EKtf+2N
         yyCdGuInaKHjpKp2PKt5oePKgn33lliVcvS8xV2EeDM+4XeEojV+wGgnGX+vxI5v4CMB
         fX+5T2xAbCCI0vouEuZMwY3AzP+c67Yn4txugLHG8Q0pFzJCWnvQOJF65yUL1nqXU+Q7
         4sb7Kmb0vLYDLIlTkZiRAHDEBf7WRWe+nT0PoFeNZjghCK8xgwxlzcrR6ELL+zpz77/2
         f+KQVSoWNrKePQjme1COlDdjbHOy5Ol/QD9EbYiEYf9uNhVVRHEv904PGJlJxqt/p1Wj
         7AZQ==
X-Gm-Message-State: AOJu0YySs1b59vKtG8BuXIBHE1YpqYVcJ0DeBL9S7rlb7ynJdqGOdWIe
        S2+pg6EBH81fy3PIyaJiZFYIHA==
X-Google-Smtp-Source: AGHT+IEyn98eEWe724oKDhZcUo28dwdN4dtQOxLsYiPlUt37JKU4TwvEnkGLy99Wzn2+cnMbA16/Jg==
X-Received: by 2002:aa7:d44f:0:b0:523:20ca:de55 with SMTP id q15-20020aa7d44f000000b0052320cade55mr2457669edr.22.1691595274932;
        Wed, 09 Aug 2023 08:34:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x22-20020aa7cd96000000b0051e26c7a154sm8179068edv.18.2023.08.09.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:34:34 -0700 (PDT)
Message-ID: <19d885aa-3740-1287-715c-5ecb913c8a72@linaro.org>
Date:   Wed, 9 Aug 2023 17:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-3-quic_luoj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809080047.19877-3-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 10:00, Luo Jie wrote:
> QCA8386/QCA8084 includes the clock & reset controller that is
> accessed by MDIO bus. Two work modes are supported, qca8386 works
> as switch mode, qca8084 works as PHY mode.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,qca8084-nsscc
> +      - items:
> +          - enum:
> +              - qcom,qca8085-nsscc
> +              - qcom,qca8082-nsscc
> +              - qcom,qca8386-nsscc
> +              - qcom,qca8385-nsscc
> +              - qcom,qca8384-nsscc

Please keep this enum sorder alphanumerically.

> +          - const: qcom,qca8084-nsscc
> +
> +  clocks:
> +    items:
> +      - description: Chip XO source
> +      - description: UNIPHY0 RX 312P5M/125M clock source
> +      - description: UNIPHY0 TX 312P5M/125M clock source
> +      - description: UNIPHY1 RX 312P5M/125M clock source
> +      - description: UNIPHY1 TX 312P5M/125M clock source
> +      - description: UNIPHY1 RX 312P5M clock source
> +      - description: UNIPHY1 TX 312P5M clock source
> +
> +  reg:
> +    items:
> +      - description: MDIO bus address for Clock & Reset Controller register
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      clock-controller@800000 {
> +        compatible = "qcom,qca8084-nsscc";
> +        reg = <24>;

I think changes from your previous version... Unit address must match
it, so clock-controller@24


> +        clocks = <&qca8k_xo>,
> +                 <&qca8k_uniphy0_rx>,


Best regards,
Krzysztof

