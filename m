Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D077592EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGSK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGSKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:25:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3FD213F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:25:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991da766865so922413466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689762303; x=1692354303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvW9BI2IquIIK5/ESxOUpbcyvOL7cg8HykJWUcUvRUE=;
        b=S+dMyiiH4eASHEIeVz+33PuswEAUB7OTdSyEjkAx/70NcU74gPUdJLgIii+Xz8Hc4l
         V0TzNo4ykQ/XY8K6szeiDRJqEQtPUkkD097PdRpxpS5r8GfW8O9JRnQFKVh1/YAcE90m
         2qIlN2A/lFxmCb1X5s82osHnb+HEnToF5FIt0kS48H6AgHbVKdidqdbQlGz7MLXrWGd0
         H8XMlr+3fhn02HGBH8TgimAVsgtCxq1uxxk1ZA7f+oiNOVudM4nqXOtkImwn0Wme9K/J
         dNwhRrlCEOXlLYNB43d5KS30+Z5yNgwMWlW4GNL2zU/iA7nhDGHZd5pVnBChzMF+KjA0
         KB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762303; x=1692354303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvW9BI2IquIIK5/ESxOUpbcyvOL7cg8HykJWUcUvRUE=;
        b=ewAeWL4zmPkXbwoEgUCb19++Ng/rGHhHOI5W89HzCdzHYRko7MItB/BaBjDT2E6BNH
         85Sjrf6LsHXX1OKToNXUQ4dOQb2Svdp9PNs3jPFZZNsWs2dnn2OQzHR1sd4OBWeUuwPB
         leWgR9Is06FhX3aFRUBgpzJVkeZoQY8Br6NOieeupNvExhphTgoAtDX6lX2MpKll3YeJ
         BwFtGJ37j0ZmULhajZBjWe1Ox/9MeYUEFrMMsMASCFliN5JyRdu/TWGSW70Gj9ByZ+Py
         z6myQORJPlKrQavXQCSKbr6Nhat/P9it8Q+D4w1V2BtIC0T6tJV9MuIFgCgEhHw+oZoe
         HeJg==
X-Gm-Message-State: ABy/qLZRfE4f97YqZ+STqBQn1zMRXyUffJRbxp52ny7suLoiMsggPpIx
        RN6xT1LRmvrh2vGQ9JNjZm30jQ==
X-Google-Smtp-Source: APBJJlHvP7N/Okt5kwA+D0eVYQtSpZemQcLfso9sT0+XP8mRlqbmrVcyv4vaiRV7R8Mrvfeo8GYpEg==
X-Received: by 2002:a17:907:3c1e:b0:992:5135:4112 with SMTP id gh30-20020a1709073c1e00b0099251354112mr1604519ejc.32.1689762302804;
        Wed, 19 Jul 2023 03:25:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709067c9300b00992a9bd70dasm2195658ejo.10.2023.07.19.03.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:25:02 -0700 (PDT)
Message-ID: <43437691-b228-1078-8f00-9128c4be8c9e@linaro.org>
Date:   Wed, 19 Jul 2023 12:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] soc: qcom: socinfo: add SM4450 ID
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-6-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719100135.21325-6-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:01, Tengfei Fan wrote:
> Add the ID for the Qualcomm SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/soc/qcom/socinfo.c         | 1 +
>  include/dt-bindings/arm/qcom,ids.h | 2 ++

Bindings are always separate patches.

>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 4d49945b3a35..fa5e4c54207a 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -415,6 +415,7 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(IPQ5312) },
>  	{ qcom_board_id(IPQ5302) },
>  	{ qcom_board_id(IPQ5300) },
> +	{ qcom_board_id(SM4450) },
>  };
>  
>  static const char *socinfo_machine(struct device *dev, unsigned int id)
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index bcbe9ee2cdaf..6201bfb1405e 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022 Linaro Ltd
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
>   */
>  #ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
> @@ -259,6 +260,7 @@
>  #define QCOM_ID_IPQ5312			594
>  #define QCOM_ID_IPQ5302			595
>  #define QCOM_ID_IPQ5300			624
> +#define QCOM_ID_SM4450			568

No, come on...

Best regards,
Krzysztof

