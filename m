Return-Path: <linux-kernel+bounces-22033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEC829837
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770091C21C55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2A4439B;
	Wed, 10 Jan 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/dSOAFw"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DA41205
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso5109980e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704884440; x=1705489240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfeKeWELsUXSOsoX/4w9IRfss9fiLzU6vIaJLnkhKk8=;
        b=H/dSOAFwvou2rKPgvKuitSKE7egPG9TAs/Uo9L0LPZt7LR05d2IyDHbS/QWbnOfH2b
         +ba2tcq/QkjdNY04fuMHG4BkQiT7GLGv0Q3fZCoLlqZWxyIzYTynC6cS2R2RedlTHE7V
         fbV7WeKKDJlEzhMFDE47Tvq2SK05v+fMIFHl+JSoSQFfsLK2FMKxkCsmYRaow96dMRrg
         ZePhGjrZ9WfpEx6hqr/YGKgEaFX7FjkzFcBQsPpnG+ZbkTinRM6M0Y9QaL/pwHaKGrGJ
         o0gRN+CHi/O+Qe2EUOxOSeZ+XM6S0ewy7UZ3FHqRELSglNf/35twUalWuKqB/wk2GyVB
         UtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704884440; x=1705489240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfeKeWELsUXSOsoX/4w9IRfss9fiLzU6vIaJLnkhKk8=;
        b=sxp8DIavWJgOuw2NocRXzC3b5w9KX2LyaMWrb1cyok6+AMKsWAYjovNvI8rhJa9Nqd
         2Dc044Y39LRna1Jeqb14wNputCCXJxzumq/ORoKLHYxiL3oEO4oN//GUzoI+mCkbn5jE
         PsGZuL5pnQXxf0em7GhfyybjhuvyG/ac+lmvveUmzg4zGtEQPXVQRuVy5WGyBcJQkX28
         j3fz5z4DUpQwyI1DHdgNTLULfH1wbA+l9H+ANi5elVfsn04U9JiZ2oJFn3IWWqF0h2b4
         ZDIWW+oe6atWopMCS/pcV0bbYk7Aid3efytVvRrivbSPJxPoVZ1wAwuCs4ObZjXr/K8B
         pHag==
X-Gm-Message-State: AOJu0Yy4JYhfD6CXxhpj894uth/ZigddZtIBoivvFHdERVSrAAdrT2a7
	RfFYNE+0cDQW8bPguqzW+M1OdmfjJUNXUQ==
X-Google-Smtp-Source: AGHT+IHxHBhrhaM+rqV9BsRHT6XAftzD06A/BcYSyyty/0KA0tCunnAFj1XF5aWGoLi7Er3fmNTdWg==
X-Received: by 2002:a19:9117:0:b0:50e:7be9:52fb with SMTP id t23-20020a199117000000b0050e7be952fbmr326167lfd.82.1704884439955;
        Wed, 10 Jan 2024 03:00:39 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id eo30-20020a056512481e00b0050e7ed9585asm617280lfb.233.2024.01.10.03.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:00:39 -0800 (PST)
Message-ID: <36f9eac0-3086-4d18-9879-02738e99d262@linaro.org>
Date: Wed, 10 Jan 2024 12:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-2-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240109114220.30243-2-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 12:42, Bibek Kumar Patro wrote:
> Default MMU-500 reset operation disables context caching in
> prefetch buffer. It is however expected for context banks using
> the ACTLR register to retain their prefetch value during reset
> and runtime suspend.
> 
> Replace default MMU-500 reset operation with Qualcomm specific reset
> operation which envelope the default reset operation and re-enables
> context caching in prefetch buffer for Qualcomm SoCs.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 ++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..000e207346af 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,16 @@
> 
>   #define QCOM_DUMMY_VAL	-1
> 
> +/*
> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> + * buffer). The remaining bits are implementation defined and vary across
> + * SoCs.
> + */
> +
> +#define CPRE			(1 << 1)
> +#define CMTLB			(1 << 0)
> +
>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>   {
>   	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -376,11 +386,32 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>   }
> 
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +	u32 val;
> +	int i;
> +
> +	ret = arm_mmu500_reset(smmu);
> +
> +	if (ret)
Weird empty line.. Please remove it in the next revision since you're
already going to send a new one..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

