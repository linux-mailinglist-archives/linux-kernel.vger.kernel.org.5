Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6967FA4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjK0Pdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjK0Pdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:33:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E2B1A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:33:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso5918023e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099231; x=1701704031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5pj3woLlVzQJZC1DHmBekzs9Hlj3z5FIn7Gwi4atXo=;
        b=L21IXiDk+HlNqS2VD+5Pcey4VrefqgKwzWL/HeeSibwzcAhQhnerBncTyg7U5tWIKT
         KHewIT/rKNJXWGMsRMzud9Jw9oVBovEFqQN5ystO+/yyUaCLgTlu+xS1InX9J49tUTru
         KqGlIl+4i61Jd1mHUJ6KbOZblK1fRtuyAis+y/07p568juVipIIMfajzsRfXXN8Kp+JX
         wuPv12da6YVMVtdacZQPDRhTaLfWc/yKHue95UBOMocnrqvjGpjY2lfUWp+v5y3W/tw2
         WZ7X2fVDR4Mp4U2MinngOCtTSMqMHQuTg1101JQzejBD3k4kLCbWuabtKk0PM98QBq6e
         meaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099231; x=1701704031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5pj3woLlVzQJZC1DHmBekzs9Hlj3z5FIn7Gwi4atXo=;
        b=EodmZExMszMnnWHiFttlVzNCpJqKPOkZJTYW3n1VVbjiY6H842cuC3MF5qcQSJ7dGQ
         pokObLnTtOWL35y8XMxA/9Mel8ggL/5dI9PsFe1DF+pgKbO2x0lO3H/HZhlfW82t9DTr
         +zHeZd1eyS/NUN2oRAU2xzPvXqRWhJczqqyD8br+EvpGvK4L+9wr2edi/zcx37qLYZBE
         vBMu3BzHkZ/j1xiijEPMBrcMvGXSazTi5JuYTWgZsIkWpcG1Jx1hC7gdMtqdkboFfBFh
         P4uc1Hb5FRr4V/ksJzwT/iTzS1nwwnD6b0JhhRYRDaUgIZ01AIJ+eDl3QwJcpBLP0lAy
         lj7w==
X-Gm-Message-State: AOJu0YwjtoX2HMnPTXNBQrhsuvF1LAczL4/YYV4gmYfHocbsXar1Tec8
        ctsoBnfczFQrHmezLHngD2u4Ng==
X-Google-Smtp-Source: AGHT+IFE6+jIwgjV+bU6S8pWzC8Ho1QeLM8bL4PoJmcfpwr0byT6KC7IHAVksPuxSd74itzjrPt+mA==
X-Received: by 2002:a05:6512:33cf:b0:503:1783:d5a9 with SMTP id d15-20020a05651233cf00b005031783d5a9mr10561182lfg.3.1701099230916;
        Mon, 27 Nov 2023 07:33:50 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id h9-20020a056402280900b0054aeece37cesm4370406ede.52.2023.11.27.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:33:50 -0800 (PST)
Message-ID: <cfbf33cd-0faf-47c6-8e0f-b13c088670df@linaro.org>
Date:   Mon, 27 Nov 2023 16:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
        a39.skl@gmail.com, quic_bjorande@quicinc.com, mani@kernel.org,
        quic_eberman@quicinc.com, robdclark@chromium.org,
        u.kleine-koenig@pengutronix.de, robh@kernel.org,
        vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231127145412.3981-1-quic_bibekkum@quicinc.com>
 <20231127145412.3981-2-quic_bibekkum@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231127145412.3981-2-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.2023 15:54, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch
> the next set of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 56 +++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7f52ac67495f..4a38cae29be2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,12 @@
> 
>  #define QCOM_DUMMY_VAL	-1
> 
> +struct actlr_config {
> +	u16 sid;
> +	u16 mask;
> +	u32 actlr;
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>  	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -205,10 +211,40 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>  	return true;
>  }
> 
> +static void arm_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
> +		const struct actlr_config *actlrcfg, size_t actlrcfg_size)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct arm_smmu_smr *smr;
> +	int i;
> +	int j;
> +	u16 id;
> +	u16 mask;
> +	int idx;
> +
> +	for (i = 0; i < actlrcfg_size; ++i) {
> +		id = (actlrcfg + i)->sid;
> +		mask = (actlrcfg + i)->mask;
actrlcfg[i].id?

> +
> +		for_each_cfg_sme(cfg, fwspec, j, idx) {
> +			smr = &smmu->smrs[idx];
> +			if (smr_is_subset(*smr, id, mask))
Any reason for this value to be a pointer?

> +				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> +						(actlrcfg + i)->actlr);
ditto

> +		}
> +	}
> +}
> +
>  static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
>  	struct adreno_smmu_priv *priv;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_config *actlrcfg;
> +	size_t actlrcfg_size;
> +	int cbndx = smmu_domain->cfg.cbndx;
Reverse-Christmas-tree sorting, please

> 
>  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> 
> @@ -238,6 +274,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->set_stall = qcom_adreno_smmu_set_stall;
>  	priv->resume_translation = qcom_adreno_smmu_resume_translation;
> 
> +	if (qsmmu->data->actlrcfg_gfx) {
> +		actlrcfg = qsmmu->data->actlrcfg_gfx;
> +		actlrcfg_size = qsmmu->data->actlrcfg_gfx_size;
These can be passed directly s arm_smmu_set_actrl arguments

> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
> +	}
> +
>  	return 0;
>  }
> 
> @@ -263,6 +305,18 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +	const struct actlr_config *actlrcfg;
> +	size_t actlrcfg_size;
> +	int cbndx = smmu_domain->cfg.cbndx;
> +
> +	if (qsmmu->data->actlrcfg) {
> +		actlrcfg = qsmmu->data->actlrcfg;
> +		actlrcfg_size = qsmmu->data->actlrcfg_size;
> +		arm_smmu_set_actlr(dev, smmu, cbndx, actlrcfg, actlrcfg_size);
ditto

Konrad
