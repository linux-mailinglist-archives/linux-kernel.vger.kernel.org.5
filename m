Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC507CF660
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbjJSLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJSLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:13:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FFE124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:13:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40790b0a224so23786115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714015; x=1698318815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POZqwrn3QOIkuNwW6uoa6fDBdqF1NUX/ckhVqnX/nGM=;
        b=LnfDtTrXD+yj+uVRr8qunQ0kIOafx0qb8DABRt8tNjPpYjTdTcOvG5n6HP6sImfmxw
         6wpjIFWq8SV9PODmf3K/oM8Z++Zifc1HIJ+qrsItCshl2KtKP0FKzV/8NyMBWhHox4aL
         5uEi3u2H3V9bZJE9ZoFDwLQux8Y7L5yAcbZM2rTGfHEKMivz7O+WxPdShPu2RL/Wk7PU
         BvXZjLz00igiX0SWJPnkeZhnzhPkJ1SGzQsbx4lXwwVlseA8G8DUuekgLc8SA9bNjvq5
         UnSReHkaid1fEb8SzP016IjineELQ61fveMzZKFPpJUJ1dvXd4BUkrlYqyzOaRe+z2As
         rR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714015; x=1698318815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POZqwrn3QOIkuNwW6uoa6fDBdqF1NUX/ckhVqnX/nGM=;
        b=PzlbBicHR/I4YYHlOqLDmpEXAw0lSNg1otx4muAzM8rDFO48faLV9/6lgSd+gDEMiZ
         noAJh4GY5qfIuydYl4hO45liB4Wt/Z9fIwz0rwOTpVthJ1MHuSUg9QquUDixKOQ3eM81
         tfVYWnrB8V30YtCtCzOvm3ed8a0ZSyBNYYtev/dsfIfhEBFFFyu4vQm/ikVVJX8ibvU7
         YWIM6GyGsHvcZqcBp+RWu0DKf2Z4cD+jfZkE7O0ahMLJYSrsbwr9YU8wNPKvptJV9egD
         gYmSdaXqBUJAVufwjqVVCLPaxhm2peVtjBODvrcowftntPzoEJhm4kanQQLUo2xG1PN2
         8JEA==
X-Gm-Message-State: AOJu0YzhIzId43hYW51tKl+eU2mmvywGRms1b5hRha/7C35/Zos5St6C
        TlValKu6YMFMO5xaMqjAPE94Sg==
X-Google-Smtp-Source: AGHT+IESelDfNhrhBDzW3Tww8D/Nax8XajqTmvOsjCQY9+TpZo5BfDRDQhEygSKOyZRhdOccwizXEA==
X-Received: by 2002:a05:600c:a0a:b0:408:3c10:ad47 with SMTP id z10-20020a05600c0a0a00b004083c10ad47mr1531323wmp.40.1697714014660;
        Thu, 19 Oct 2023 04:13:34 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm4089784wmf.39.2023.10.19.04.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:13:34 -0700 (PDT)
Message-ID: <1cdc2a68-a1e8-4cf2-8a1a-899d14f8db80@linaro.org>
Date:   Thu, 19 Oct 2023 13:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iommu/arm-smmu-qcom: Add support for TBUs
Content-Language: en-US
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     devicetree@vger.kernel.org, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com,
        quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
        djakov@kernel.org
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-3-quic_c_gdjako@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231019021923.13939-3-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 04:19, Georgi Djakov wrote:
> The ARM MMU-500 implements a Translation Buffer Unit (TBU) for each
> connected master besides a single TCU which controls and manages the
> address translations.
> 
> Allow the Qualcomm SMMU driver to probe for any TBU devices that can
> provide additional debug features like triggering transactions, logging
> outstanding transactions, snapshot capture etc. The most basic use-case
> would be to get information from the TBUs and print it during a context
> fault.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 ++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  4 +++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7f52ac67495f..655c7f50ca84 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -1,12 +1,14 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved
>    */
>   
>   #include <linux/acpi.h>
>   #include <linux/adreno-smmu-priv.h>
>   #include <linux/delay.h>
>   #include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   
>   #include "arm-smmu.h"
> @@ -466,6 +468,16 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>   	qsmmu->smmu.impl = impl;
>   	qsmmu->cfg = data->cfg;
>   
> +	/* Populate TBU devices if such are present in DT */
> +	if (np && of_device_is_compatible(np, "arm,mmu-500")) {
I'd say this can be unconditional.

> +		int ret;
> +
> +		INIT_LIST_HEAD(&qsmmu->tbu_list);
This list is unused.

Konrad
