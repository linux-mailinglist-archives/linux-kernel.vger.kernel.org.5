Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E433C7EB18C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjKNOIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:08:38 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF8CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:08:32 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce353df504so3199895a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699970911; x=1700575711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjAiWper4EmA3pvt9j0eaa7+wl6BN0Lp2H3inIav8/k=;
        b=L3IInXjDojyxDEOVLCwg7oqxoG1ilDnoSohTh5m0R7cqmBvmi2sBUlrgiOyTa8SBib
         CL0Am8UAMCWhBHWHSMa1EnDihoolA/9v8dHlTW5dlbok4K7CwJ08Ews/YM3BUhoWjsm4
         Lv9jxkyGTVIZlJdqLNceyLUXcFpygv3ILuKUROZZHZkNB9dhdT9SZotLu6tckYu1UtWd
         fIQzu+Vn5mvRgkNW7DIGVJDAS4cIQtKPrWwNarSb+3lNtEihA1bowGo4tRcDwcnemO4K
         MD5lduEgXWQz6szO6uWQMIbIMpw9FQbg4alc+oLYKOLSjOPn2DM5usoEfWjVJ8C2yXR0
         RQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970911; x=1700575711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjAiWper4EmA3pvt9j0eaa7+wl6BN0Lp2H3inIav8/k=;
        b=S7ESFc0W7md+a6jIX9j6kCuXHgpXoF66O1mVVqlq5e10Y6cGKBKaC0sOu9/mtvrk9R
         Unq1VY0orp1kd6hw/qJSr9piLrgQQBe8lYUjK6txo7yk0X8R00SAOcXZJ9ahvnjux9pV
         RMeD8tUFLPI0AXblR3E+QwnRdcP3b84TZ0+5grP0ZLSkopo0GhF1nTMZNPODt9564H4Q
         pyx6mpeu3blTKjB5ncIvMcbOMbx+F9lcEUcQLBTmP67J2QQnCi1PpFUkh4wUYvQSTm4p
         gp3TjHmrXM963ujbwKp92/rNCqKgkoK5cLrbCiPr5P3GrDCkIT83jm/xXFSbqxdgXqNm
         n6qg==
X-Gm-Message-State: AOJu0Yxxza8Zfo4UCcTV53f1eAE5dcjJi/qdCgb6+mnlqihFjF3sZkoC
        3kMHwJ2yvBUJqMGwk3XIHxcta6qFkKMiw1d0Sf1DsXlxtucmUs/NRNM=
X-Google-Smtp-Source: AGHT+IGheGPFwlNqJJEH/WORIFBCKmms3UOq5jRzXBddTa4BEzn5aECd1nyIvy5WAKGiDc4/D/Z3vb9LDXKsJIQxCTA=
X-Received: by 2002:a05:6830:144a:b0:6bd:63b:4b21 with SMTP id
 w10-20020a056830144a00b006bd063b4b21mr2337006otp.15.1699970903591; Tue, 14
 Nov 2023 06:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com> <20231114135654.30475-2-quic_bibekkum@quicinc.com>
In-Reply-To: <20231114135654.30475-2-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 16:08:12 +0200
Message-ID: <CAA8EJpoNttUbxNvU0xC2kQjLV==wK_te2x=Kxrw0O+joGBipOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
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
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 41 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +--
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++
>  4 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..578c662c7c30 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,17 @@
>
>  #define QCOM_DUMMY_VAL -1
>
> +struct actlr_config {
> +       const struct actlr_data *adata;
> +       size_t size;

Merge this into struct qcom_smmu_match_data.

> +};
> +
> +struct actlr_data {
> +       u16 sid;
> +       u16 mask;
> +       u32 actlr;
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -261,9 +272,36 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>         { }
>  };
>
> +static void arm_smmu_set_actlr(struct arm_smmu_device *smmu, int idx,
> +               const struct actlr_config *actlrcfg)
> +{
> +       struct arm_smmu_smr *smr = smmu->smrs;
> +       int i;
> +       u16 id;
> +       u16 mask;
> +
> +       for (i = 0; i < actlrcfg->size; ++i) {
> +               id = actlrcfg->adata[i].sid;
> +               mask = actlrcfg->adata[i].mask;
> +               if (!smr_is_subset(*smr, id, mask))
> +                       arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ACTLR,
> +                                       actlrcfg->adata[i].actlr);
> +       }
> +}
> +
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +       const struct actlr_config *actlrcfg;
> +       int idx = smmu_domain->cfg.cbndx;
> +
> +       if (qsmmu->actlrcfg) {
> +               actlrcfg = qsmmu->actlrcfg;
> +               arm_smmu_set_actlr(smmu, idx, actlrcfg);
> +       }
> +
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>
>         return 0;
> @@ -467,6 +505,9 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         qsmmu->smmu.impl = impl;
>         qsmmu->cfg = data->cfg;
>
> +       if (data->actlrcfg && (data->actlrcfg->size))
> +               qsmmu->actlrcfg = data->actlrcfg;
> +
>         return &qsmmu->smmu;
>  }
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index 593910567b88..4b6862715070 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -9,6 +9,7 @@
>  struct qcom_smmu {
>         struct arm_smmu_device smmu;
>         const struct qcom_smmu_config *cfg;
> +       const struct actlr_config *actlrcfg;
>         bool bypass_quirk;
>         u8 bypass_cbndx;
>         u32 stall_enabled;
> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
>  };
>
>  struct qcom_smmu_match_data {
> +       const struct actlr_config *actlrcfg;
>         const struct qcom_smmu_config *cfg;
>         const struct arm_smmu_impl *impl;
>         const struct arm_smmu_impl *adreno_impl;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..8e4faf015286 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>                  * expect simply identical entries for this case, but there's
>                  * no harm in accommodating the generalisation.
>                  */
> -               if ((mask & smrs[i].mask) == mask &&
> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +               if (smr_is_subset(smrs[i], id, mask))
>                         return i;
> +
>                 /*
>                  * If the new entry has any other overlap with an existing one,
>                  * though, then there always exists at least one stream ID
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..b1638bbc41d4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>                 writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
>
> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id, u16 mask)
> +{
> +       return (mask & smrs.mask) == mask && !((id ^ smrs.id) & ~smrs.mask);
> +}
> +
>  #define ARM_SMMU_GR0           0
>  #define ARM_SMMU_GR1           1
>  #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> --
> 2.17.1
>


--
With best wishes
Dmitry
