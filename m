Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D67E0F1F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjKDLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjKDLa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:30:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05283D4E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:30:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d2c54482fbso450568266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699097455; x=1699702255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViIC/HSzRl49SaVz7Ic3OZfsB5CjZfB5vtLnKKRw0ic=;
        b=bN37xAMLBydVthpkcYcuqR8RA/51gq3HIAdsWyB4uB1kKNtZR4cVN52Q8I5mEI8z8U
         DTyt4kfdcOkAARrYqU5awhEktFiPF1aWLiJAN3G0FnPfpU9CjaU1IsXts+LcCwCs+KqT
         bu5gJBTPQ3tpQTx5Gnl89OoO1C13nuwn4N6QNWvCp/KRIcFuVkqGWh1tBNCsNGpRKqk7
         cnWtwnI/HEVpMIiFQ4FFA1VwjzlYU9Mh3XxO6DSV0R0cABSQrJ8C37Lb+XRQctikKiKi
         DabmrpRX9Hww9Vpxhw7VOXghOAj+y62xfbCtcDlTAzF7X5tFdhawyi7gLtELlgdmYIUe
         98YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097455; x=1699702255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViIC/HSzRl49SaVz7Ic3OZfsB5CjZfB5vtLnKKRw0ic=;
        b=r4hf1+3JskGGqh7dubAj0J0sdZNTMYt5LSsMtFradEbRzVMPx4VQEkyPqUa0cXAOtU
         LwkUW/iiEwYbEJk+99287cDtV3uyxxRnRdVE58nHu5uBIK3p92gfaJL43/07A7J39HOR
         Eomk66zz3P0aME7zV2hr5Tye1+VWFhjcs6PfetsEQ1zc+NP7G6uw5J/zb/1DMRiQYpcN
         sP8ydy96PiXBjhL773oE+IHbjKe8a4jKVy7SCrLLfsJnQyTf+wGCn6OwTKo6K9iKdp+F
         xkIEW5JIvuuAoTcuPp4uStnQfdmT9BMvy7VA45Fwf6lsE4bORpR4FslTVVip1rI4tnmF
         bR2w==
X-Gm-Message-State: AOJu0YybnogmN96FCEAaZD1SBzZ/YXloXpieKYL+jy/8nXN33RoutOKy
        9nKPgKakgdB1pk0c223zo8vnX0A/I+HQat1JX7Q=
X-Google-Smtp-Source: AGHT+IG7+PVg2+j7nGj7tYNTi4rQ5slXe9O1zzNFrQ+IoKAC5ivvACWeQEyqrrRa0PtPlKH+b4ylJQ==
X-Received: by 2002:a17:907:70b:b0:9d2:20ee:b18b with SMTP id xb11-20020a170907070b00b009d220eeb18bmr8758416ejb.42.1699097455299;
        Sat, 04 Nov 2023 04:30:55 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b009c7608eb499sm1878707ejq.94.2023.11.04.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:30:55 -0700 (PDT)
Message-ID: <26af3ecc-8b3f-4b10-b594-eae57de501cb@linaro.org>
Date:   Sat, 4 Nov 2023 12:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
        a39.skl@gmail.com, quic_saipraka@quicinc.com,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103215124.1095-4-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 22:51, Bibek Kumar Patro wrote:
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 590b7c285299..f342b4778cf1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>   }
> 
> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> +
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int i;
> +	u32 reg;
> +
> +	arm_mmu500_reset(smmu);
> +
> +		for (i = 0; i < smmu->num_context_banks; ++i) {
This loop deserves a comment above it like

/* Re-enable context caching after reset */

Konrad
