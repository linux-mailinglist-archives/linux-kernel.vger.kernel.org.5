Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9C76472B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjG0GrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG0GrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:47:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA94CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:47:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-997c4107d62so73006966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690440432; x=1691045232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AfkdTx8aDEG/J6ohJF19yNL93fMDwOc4t4zIdlBZ2E=;
        b=Bzs4dNELholCLNzpl389GsKTcETPJzgOXzC6mps/0jrWoaqs7nkzk4SX2lF2esiL8h
         mYUXjzHNOvJVXZEWG4NF+TvVjKGXK9O25Gu5Bg0Mz6HhABuf6RiyTJEyu5B3DFceI4iY
         GN8a7sly9NkDEMj0P8l6U9nRpBZXyvWH+WxJ847rFr4S+FVx+TVxormi1OTPzuCj4m2t
         N4wrMZTL4lIDah735Zz0ZfAGoOeuhsJt5RljXqpp0OIpICD0XuOuQyUz0yG3S6DhKax6
         MDDpL/LeMEUDlAfpTi8qjY4t4SLBNUguCYd3q4hsikp/m70RGXtN3ctniZYm1MCGL2og
         sx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440432; x=1691045232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AfkdTx8aDEG/J6ohJF19yNL93fMDwOc4t4zIdlBZ2E=;
        b=CDRT1jDBltpp2+DfadJYL1wkOGZlSO6XfdEu6NenEmvU/OBsyjOWwzCZz26teeUPcF
         DTp76uV/XionD9JLJKn1i80aHeZzltg1DA7ktIrPlvKg47N5QBBhsQUIOlmFGK5kOfZO
         c2JW6n5XCv84f50bcYou6omHoF/mLXN5cDtVPOaDoQ0YYNOsXp45d+osjuV+kX0AYja8
         7xerN4KafLOMbouXhGMj0sZsDo05YB8ADaqTo877Xi/SK5WJwDBd9XMQSUUSgS4MWzsK
         WUMX9eVfkUAiEXll0krby8h5H6gAA7gmGeB+uPeiZcuY1by1WsTn8NZ/ydJdK4O2gu3G
         We7A==
X-Gm-Message-State: ABy/qLbPTILjcIq2djnKvOqcTggm9QhRKU196JOLF1EdNky7G+MOmMQi
        llAygUz5R8rt29shUNd5bhy8sA==
X-Google-Smtp-Source: APBJJlHaOtaQXLEUMwD7ynqgJvlhwXcmtHFmtE3VQA+fsZRixVtmPQJwQX+Ask+KjivM6u5LV3s4Vg==
X-Received: by 2002:a17:907:761b:b0:99b:4aa3:6480 with SMTP id jx27-20020a170907761b00b0099b4aa36480mr1310855ejc.40.1690440430456;
        Wed, 26 Jul 2023 23:47:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b009786ae9ed50sm380391ejj.194.2023.07.26.23.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:47:09 -0700 (PDT)
Message-ID: <5288c817-3cf8-2b8c-6187-30283353060f@linaro.org>
Date:   Thu, 27 Jul 2023 08:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/5] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, john.garry@huawei.com,
        peng.fan@nxp.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1690439352.git.quic_varada@quicinc.com>
 <f88d5add717e90e136a701f39fe80d00f1052692.1690439352.git.quic_varada@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f88d5add717e90e136a701f39fe80d00f1052692.1690439352.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 08:33, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---


> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    items:
> +      - const: qcom,ipq5332-usb-hsphy

Please keep compatible as first property.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: cfg_ahb
> +
> +  resets:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Phandle to 5V regulator supply to PHY digital circuit.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +    usb2-phy@7b000 {

This was actually better before as usb-phy, I don't know why did you
changed. Especially that you already changed once to usb-phy and this
got review tag. It's fine. If there is going to be resubmit then fix
these two issues.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

