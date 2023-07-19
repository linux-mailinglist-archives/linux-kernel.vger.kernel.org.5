Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECED2759288
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGSKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGSKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:16:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476281BFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso2558842e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689761793; x=1690366593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiVgxJX3yyrpHJnPl8ldz7R9Y+cEuev7AVNxZq6KcsE=;
        b=eHquvYXnaBq03T34kPhToH/NAr/R5RlFqWl4KU6K3VujJqjVxfmeR0UXNG7jGwF+HH
         /bZ0xQBIYT0vU4TZp2hp1Du6H18O62z2e0/mGMUMpeeiKEnEL8eEzRuSkdz/jn6lZMmQ
         3m5M7p4SJRK0UTdJcvj1IS4BGafU0udiYzDvbNAJow59pC5YhRTLzVm+ucP2hMn41CdZ
         FmBsfbIqUY6LVoLj+hU4+j6Z0uI5fM+nc/3FI5hTBSQj4sw+r6y+rsfpo75h4+5xVAT6
         bPZt3DORXH3L3V/iFZ0tgAJTqJx2ViYkOT39frwem3Y1PkhNZoe/I2uBrRv+pAnXD9g0
         +uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761793; x=1690366593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiVgxJX3yyrpHJnPl8ldz7R9Y+cEuev7AVNxZq6KcsE=;
        b=IDJEtZSL2RMaGrjmvlrucRBNqsKvcf7+A5qvxRNZeTNkD4+aDRrvbUsx7rg28DhF/K
         VJawk7wmuDx9OlwO8YIFu3eWtntPapped8vCe4xeBLcFYwE3pYMDnIIXWNtCPl+Fp0QC
         1vxf0+TlplxKi+GsWH0ZVtMa0fxrwIYHp6kj/Fez3fFPQgW4L2+TV1mHqM/+iaSMJnk+
         JptkEsGJGIVy/n57ld8IjlK0pWD32UUllYkPhGmZna7q1EVGcBbGi3Ba7M92XShibe2k
         eCe7ZJGqw7FtgdFvCZETSsksObUyzAcxNKSNXmy3ZwKBI7KtIAb4pBq1cd05OWbOAoAd
         OHdA==
X-Gm-Message-State: ABy/qLYZk3JsiBxnCHOjNBSUiEONhf2SSFcA3c8OSc3ygY9YypTlskC6
        2KtQaHcGoPqPUPUNaF10QOYgkQ==
X-Google-Smtp-Source: APBJJlHbngaS1/4535Rc2GuT16xjcfjx1k9dWj04jYEg0B0NjQBEONnTM0y0mFMkWENrI8mIDgA7aA==
X-Received: by 2002:ac2:5f71:0:b0:4f9:92c7:4026 with SMTP id c17-20020ac25f71000000b004f992c74026mr1649908lfc.1.1689761793692;
        Wed, 19 Jul 2023 03:16:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w12-20020ac2598c000000b004fdc9ee07d3sm870553lfn.156.2023.07.19.03.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:16:33 -0700 (PDT)
Message-ID: <af35e6fe-c360-fc13-1f1b-3f00ca0bdf85@linaro.org>
Date:   Wed, 19 Jul 2023 13:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] dt-bindings: firmware: scm: Add SM4450
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-4-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230719100135.21325-4-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 13:01, Tengfei Fan wrote:
> Add compatible for SM4450 SoCs.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index bdbee58a542b..f02f0815bece 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -62,6 +62,7 @@ properties:
>             - qcom,scm-sm8450
>             - qcom,scm-sm8550
>             - qcom,scm-qcs404
> +          - qcom,scm-sm4450

Please keep this list sorted.

>         - const: qcom,scm
>   
>     clocks:

-- 
With best wishes
Dmitry

