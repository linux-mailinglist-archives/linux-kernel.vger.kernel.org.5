Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C717A16D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjIOHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIOHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:04:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051DDE0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:04:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501be2d45e0so3067156e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761454; x=1695366254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHiiw2zLmDDKdBpJJDRZPiiiZQs08sZNPmWWWLIoN4o=;
        b=RrgEbkwA2AVjCwnK3qad1t0RKawdDXzgVP9FM1Q7Ebe7TGbAJd1nQVrWMMECDoMHJs
         rLrCD07B8W06Wy5bL8CDSN+EeBssTIuUbZRXA4+NNJrNtO7NB1DYNm6R795Ow5PA7OK0
         +3dFwej10XHCKjHr1BbRFp+XBa+xkVjXUcuOQl8NC1CFjbwidrDOkjIdoVLifBeUJakb
         YKXY4r1DHd9FZ4DmMrHZiyJItDjSE0WOmqCR8X271MBDcNfS65uYB1BiST7nojY9w+VS
         XS8GbcSjrXN1h2IgAvmgqcMZMnwGCqqFYvfbvEGnqAC2IfnZc/UiTTgykRoxAp6i0JaC
         28og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761454; x=1695366254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHiiw2zLmDDKdBpJJDRZPiiiZQs08sZNPmWWWLIoN4o=;
        b=JVMM0iKQLsE6Is3u1aVajsRelMjajmV+Tc3vgSUM8gDLRVz0cyxQVQJzRIubGtx0Jg
         Oo2y+StbKrkt3HBGSOgnZ6W2WYK0WjhDD1h5ZCNjnmwSYfIrGy3cxvcn9PJRaZNhN+2I
         mt/J4iBqRM+FPfg9HBLAnanyNsEED2RqoLNBd0DI3MVBsPDkRZd+n09+szTnlYwqkKG7
         QcTYrLgi7ef3sKagNCRpNqXOVPi3BL4knnUPxEPz148fuMVr3v6Jy9B9du0ugpTxPV2m
         gZUmF5VPC3J+QZpG9VNcPQlsUs1jQmnUhGw9Wx6R1W9OcfnXHg0/kYS5lHo0gK3Ezg/A
         jnTA==
X-Gm-Message-State: AOJu0Yy9iP3BHUC2DhV3vDl03eX3hsMYNKMrQOoHc8+daozpU4+n2VYk
        MKPt5RWm1fjx7EDCGomOC8TYgg==
X-Google-Smtp-Source: AGHT+IHg6sh6ARvRYSwuyoF2hmtnjsmopqC9TmkEeYtf8f4hqHAhSC4oiX7GDCdXqzTzoglQYBrSmQ==
X-Received: by 2002:a05:6512:2082:b0:4fb:772a:af12 with SMTP id t2-20020a056512208200b004fb772aaf12mr617044lfr.21.1694761454189;
        Fri, 15 Sep 2023 00:04:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7dbd5000000b005256771db39sm1818148edt.58.2023.09.15.00.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:04:13 -0700 (PDT)
Message-ID: <6f40ee72-b763-c58d-44df-ea40d1309820@linaro.org>
Date:   Fri, 15 Sep 2023 09:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915015808.18296-1-quic_tengfan@quicinc.com>
 <20230915015808.18296-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915015808.18296-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 03:58, Tengfei Fan wrote:
> Add device tree binding Documentation details for Qualcomm SM4450
> TLMM device.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

...

> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm4450-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sm4450-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sm4450-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +    unevaluatedProperties: false
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9])$"

This is still wrong. How many GPIOs do you have? Please open existing
bindings for recent device (e.g. sm8550) and look how it is done there.

...


> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    tlmm: pinctrl@f100000 {
> +      compatible = "qcom,sm4450-tlmm";
> +      reg = <0x0f100000 0x300000>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      gpio-ranges = <&tlmm 0 0 137>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;

Missing example pieces. Again, please base your work on other recent files.

> +    };
> +...

Best regards,
Krzysztof

