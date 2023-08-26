Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076878951E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHZJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjHZJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:28:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997401BD4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:28:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99d937b83efso212313466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693042132; x=1693646932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgOfZl7JHb6cCD/AKyPsLjM9BY1ctg0ixsZpth8YBeI=;
        b=c2E/gdAQe91sf2BmUkEExRGXyvJPerR6C4gVCzeO1Wpy+F6ERLyrIGBWQfNFl1hDsE
         +jtXUfeaHHLPDHDFFQp2oBHMl5Q6u3LdRqsjiUi/OvpKVV/Ut4A3tlf+VqCX7Wjzan73
         I9TIFuTg6Tmo2AQxpibSP+K/DLr7Qb+chMQZuoc3nF1tAIx4FVSHbgdCktmo2zLNyyOo
         W3iHuah96IfaFi5f4KC3bvlR3pOab0vJsBEvlS6EU7XaBWryLRBl7JBJaTu8f7LrHdPh
         O7ukCp2W0qSjqebwt2cKmvVoRxSs3VKDAjXRI66LnNUNz135/MOyq9rmFIMjYOPZOhj2
         3Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693042132; x=1693646932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgOfZl7JHb6cCD/AKyPsLjM9BY1ctg0ixsZpth8YBeI=;
        b=MqoT0/hY2CrqpPgCu3lPUQPr9QKRlKhVLpSR8zU7J4+dWDq5if5X3gRjAHU9Hnag9M
         RDZL+uLKT/BdN634Xot+RgJDzhFysty0cwXrxDJ81Wocmti9/uy2xMzhaY6fF1KL6oRp
         2kyZ5gC+ZkbMfRO+WTVhBPF6HmkA8Q6/6UJCKtYLZu/uLZUBE6qqnGRsTsjxnzQ/uCuM
         Q6txzNcB/yC3m5gF1QPSaPCDKFRL/ISG7ZKxis9dqjipA4KoAXncz8uD11CIyHFODsRM
         8mT5cX5UjSch/wFkqXcfwAIxKt0W1bcILpeSY0mhavltq4VdrB9julBCiW4QMik/mbEB
         nMlQ==
X-Gm-Message-State: AOJu0Yz+fkRN6y6H4X6+ytDzC+dOVHCwNkKsA7L1sRUtu0cUyH469N+l
        lUkSYmkz8gUMfTkZO4dChdLjZQ==
X-Google-Smtp-Source: AGHT+IHampEn40bTeySzDL6q556qVYdc+Oz1VH1bNwaZdJ5z5SxNdkz3aM00eL75fotqqo2CJA0Q0g==
X-Received: by 2002:a17:906:5187:b0:9a1:b5fc:8c56 with SMTP id y7-20020a170906518700b009a1b5fc8c56mr10159086ejk.55.1693042132066;
        Sat, 26 Aug 2023 02:28:52 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906144400b00992eabc0ad8sm1944551ejc.42.2023.08.26.02.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:28:51 -0700 (PDT)
Message-ID: <40fd108a-86e3-e68e-04bc-caab45a3381e@linaro.org>
Date:   Sat, 26 Aug 2023 11:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: Add Qualcomm SM6115 LPASS clock
 controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
 <20230825-topic-6115_lpasscc-v1-1-d4857be298e3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825-topic-6115_lpasscc-v1-1-d4857be298e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 20:13, Konrad Dybcio wrote:
> SM6115 (and its derivatives or similar SoCs) have a LPASS clock
> controller block which provides audio-related resets.
> 
> Add bindings for it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/clock/qcom,sm6115-lpasscc.yaml        | 53 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm6115-lpasscc.h    | 15 ++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
> new file mode 100644
> index 000000000000..58ee84aed073
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6115-lpasscc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm LPASS Core & Audio Clock Controller on SM6115

Everything here looks the same as sc8280xp, so this could be just added
there as enum. The overall LPASS block version is different, but the
resets/clock controller look similar, doesn't it?

> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm LPASS core and audio clock controllers provide audio-related resets
> +  on SM6115 and its derivatives.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,sm6115-lpasscc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6115-lpassaudiocc
> +      - qcom,sm6115-lpasscc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lpass_audiocc: clock-controller@a6a9000 {
> +        compatible = "qcom,sm6115-lpassaudiocc";
> +        reg = <0x0a6a9000 0x1000>;
> +        #reset-cells = <1>;
> +    };
> +
> +  - |
> +    lpasscc: clock-controller@a7ec000 {
> +        compatible = "qcom,sm6115-lpasscc";
> +        reg = <0x0a7ec000 0x1000>;
> +        #reset-cells = <1>;

Also second example is not really needed. The difference is only in the
compatible.


Best regards,
Krzysztof

