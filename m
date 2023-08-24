Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5F787782
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbjHXSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbjHXSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:10:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC71BE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:10:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso7881666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692900614; x=1693505414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6mGu+vItjjNV4zY7FbQDAFgR7t3lk2A3umS/8njaFE=;
        b=v/D/sQP8ng02i4fU6asAERGx6yOf5H7v3AbLPE9b3NasxOqZ9eZJgzGyXJGJ1RqREa
         AqtPe1PZUo1K71fnZZfDyoH4c8/12D+WYnU67PgwC73050uZnFPKnmbRU8+tlOU6VmfQ
         FBTzH+T6qraEzSTKkxvwoQoZn/HYFCCGwpYK/GgEBjl8kNfG07oJMu9ibapWMKHTVj3e
         6OX8fEDRZaQdsrC1FKSN4rug9Nk22v7KdFGHmTxSjonOp8BsrbjSoc20Ezi09dFEBvlM
         AlaHvvySwgmH4pr9rye32UrMeU6cru8vmTPdqleaDZ9DkWamN1AGPY1+tAD6biSBz0WC
         8zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900614; x=1693505414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6mGu+vItjjNV4zY7FbQDAFgR7t3lk2A3umS/8njaFE=;
        b=bbPycSXc5o8SEuFInEB/4q5vhBRWXCDWbmxXMMHXSxwD4j/fMUSGRff7fRO+jocZFG
         V6yqhhha7K4E3OjMmzQe9GyPrSkaxQGXGZwjDLDmvUbI9Rbx9sBfFXk2sQo6vFJREVVT
         I83V1rYhZ1cL+9Z/hYPmlgjtxPd2oQDGB0CCuJchAFCnUxTyVnpsMcuekwLEVBi7lcLP
         Gc8crODKXvY4SzanlS0MwZIececOxU45TRd/9Uzh2lQF+JDmL83Xfax6GMYytrj9vK0G
         UXAs7On6ZpEs3sJWiQknpuVSyV/C8mHUALVYH68XuqNJAEdGxykPTpopkgMyVFEu3KGz
         3BVA==
X-Gm-Message-State: AOJu0YzwDpu+kEodFNuydQEI8Z/mGcd4NwjbC65kenOQ0xTUYG+4YXjc
        H1aSdDzedtwXoUT38C6Z9IzaxA==
X-Google-Smtp-Source: AGHT+IHC03VZHX6r8eAXA6FznTMk+aaRDkAzn7su3T/xEtwghxzqA0FrMAgHLLnd8EHBJz2gAPTFEQ==
X-Received: by 2002:a17:907:789a:b0:99c:e037:e4b8 with SMTP id ku26-20020a170907789a00b0099ce037e4b8mr13152361ejc.72.1692900613819;
        Thu, 24 Aug 2023 11:10:13 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063e1400b00992b71d8f19sm11272711eji.133.2023.08.24.11.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:10:13 -0700 (PDT)
Message-ID: <161de126-87b0-3440-8517-330b529c3fb6@linaro.org>
Date:   Thu, 24 Aug 2023 20:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/4] dt-bindings: clock: qcom: Add GCC clocks for SM4450
Content-Language: en-US
To:     Ajit Pandey <quic_ajipan@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-4-quic_ajipan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824173410.550126-4-quic_ajipan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 19:34, Ajit Pandey wrote:
> Add support for qcom global clock controller bindings for SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm4450-gcc.yaml       |  54 +++++
>  include/dt-bindings/clock/qcom,sm4450-gcc.h   | 197 ++++++++++++++++++
>  2 files changed, 251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
> new file mode 100644
> index 000000000000..8c767bdf7f9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm4450-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on SM4450
> +
> +maintainers:
> +  - Ajit Pandey <quic_ajipan@quicinc.com>
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on SM4450
> +
> +  See also:: include/dt-bindings/clock/qcom,sm4450-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm4450-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
> +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
> +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)

I doubt that these are really optional clocks. They are set as parents
of your clocks in the controller, so if these clocks are physically
missing, how does the clock controller work?


Best regards,
Krzysztof

