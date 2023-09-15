Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF807A1702
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjIOHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjIOHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:12:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85BE19A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:12:07 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso2929338e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761926; x=1695366726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+1MAm8CUnGgXuX6co+0aREskJOB2spO/R6IQZ493/g=;
        b=nb4hkNhVBpz55nuhBksYMxXVm4INb4aJVBwb/pyC+/SslEwkCzD4QhqbokQYD8C9st
         tmKDIpY22+hdp54GKae3z0f2Jj+FbDCqYu6u0LmZpWC3hRy5kwdRqi/K+FZf8UYaaxlX
         BaKS5MnUK0/l4lcyHHrDbRdCynctBkFNcJN3qlRJvSid7ugX1lkmiX0GmvtxsEWLes7h
         i/zSRuOcQCEe76zbRDv8vrwLEEw0PD4BAPDY1Gi3rUQ7JodaZ+3cKNEy2xwTmA/Q/voV
         THw/fNS5XOl3vNeSObTFT5/OaBC9kMq73RCaQUjYwasvDrk9ZdHQ0hZKlE0nkfGGeYPI
         KsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761926; x=1695366726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+1MAm8CUnGgXuX6co+0aREskJOB2spO/R6IQZ493/g=;
        b=tLT/1nCYrOTPeG0XrsQG/yhiAW2cY2X0AroqtnNmA9Z1Chqhm6GUrb0/O6nBSiVhYB
         kvHvAE8zumNnkqk6BqFvfGcIxjN1em3drRudeWfDyl03EdTVc0UTpIvXeVpPhoJ+6ofB
         s5qipHSAP36EBFFYuVeLyCyDFhBJKJKuNaTvvuVvxE9JvI7nQnlDZ3PSdyxUERLCRqAM
         ZQFC0oKn2ZeFgjFoRUQueAvf7FgTRAJ5O6O/5NBWhiWr8neYN9B4vP6+OSrVTU6p1Ik1
         /6l4NoJxzh5SoWiqiyARZaEpKEDv68tJj6hwjhSTCLGQsFOKRyJi2cA2FmKFl6qmBPY2
         kYqw==
X-Gm-Message-State: AOJu0YzGKr/eFVp9dEkWiaKDxl9TREuD6m3orAA9vnYt656WfAoj+uu1
        37peEwMgEXFEY3gp72Esr+VeoA==
X-Google-Smtp-Source: AGHT+IHECa1brdHbyZ+RRYmTLFGKg3RSF3pozRwZjz4PFeKi2aM/YBgZ+azN8FxCn8uEPW/fu+Melw==
X-Received: by 2002:a19:f507:0:b0:502:acf2:88df with SMTP id j7-20020a19f507000000b00502acf288dfmr632313lfb.35.1694761925299;
        Fri, 15 Sep 2023 00:12:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402088600b00528dc95ad4bsm1829422edy.95.2023.09.15.00.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:12:04 -0700 (PDT)
Message-ID: <bab9dd29-9509-f724-bcba-040501851e5e@linaro.org>
Date:   Fri, 15 Sep 2023 09:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-6-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915021509.25773-6-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 04:15, Tengfei Fan wrote:
> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..b57751c8ad90 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -47,6 +47,7 @@ properties:
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
>                - qcom,sdx75-smmu-500
> +              - qcom,sm4450-smmu-500
>                - qcom,sm6115-smmu-500
>                - qcom,sm6125-smmu-500
>                - qcom,sm6350-smmu-500
> @@ -70,6 +71,7 @@ properties:
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
>                - qcom,sdm845-smmu-500
> +              - qcom,sm4450-smmu-500

Duplicated patch. Same problem.

Best regards,
Krzysztof

