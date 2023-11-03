Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4841A7E0AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjKCWEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:04:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC0D55
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:04:09 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5af5b532d8fso29820477b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699049048; x=1699653848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnftwWj2fmumOnfc6sWWQOXUgHreNmOtpI7GXbZS8Gg=;
        b=Mnl/i9Dxgi2rGGpiYyrf8VU1UhsBrO4qpNDCgRYpUWyF7ENxP6/6Q3XZ+C2q8xQqRv
         eXLtee6LBirYUPvsfmGlFGaLtHn88BtnT4fzBmeGjfJwxo90HnDuV1LQ8YH5tGd7PlF0
         LkM+fhFgF9+L5liCxDJarTWkpH917oCJ4LuXG0Q57O+VTGnIh9ppGPb9f958kwzyXTWL
         Regubt3fOgRICoOuSd++j/eMCL6q4o5qpbFfoC73M0+wWTQmm3yxXwcnhmYWm3sI8FFu
         JMpIycyPVx6F6NMSeToex8j6qVyZ2m/H9dHF4ru4+Qr3v0nC4ZknO7ZIiAIiZBi0inEd
         nS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049048; x=1699653848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnftwWj2fmumOnfc6sWWQOXUgHreNmOtpI7GXbZS8Gg=;
        b=Ww9CjDDtzZfWANDVUZRiI4brnxUoOy7+DaydWKsxYp9Pc916VbekX4qpt5FZS4WItU
         loXH0m1ZglwJUFUcHfrJXsQjkW5+Z7j3dcyLc+34nWncDsnI3ffGknDXkKeuv7XOzvTA
         iVG/ABtcSO0eQbb5PSFrsPaV1LLdrttevenmvAY/KBjv/fl4ze03eHyVztPzQfKmV7U6
         DmRVXeLMDp1DJOntscPFYdFiug6C1qCBc6e84RSDQ0ywZLkJ2LiyCc73VA7P+4bqEB5C
         RdSczLOTN0p9f6xGswOk5/OCviEe93T2e9y/mX5UaP6/Jaayv2IsK+NDR9i3clpnvpXI
         Is1w==
X-Gm-Message-State: AOJu0Ywzzv4AetxBjBZ7IAbCUEqYTsKTvAIxiR/hDweLcx6rTO+9STsK
        Zg2X/ModLWWhUAk9Ov9x0JTjeZYNu68rMrPgBl9KmQ==
X-Google-Smtp-Source: AGHT+IEBKADZmcpxaBWv+My9vk2fj0c1No4HfAgNSeAdlKEBeiXKixwfvLL7peGAr9/x2dH+9RDFHoJF/vltu+YHb3Y=
X-Received: by 2002:a05:690c:ec8:b0:5a7:a817:be43 with SMTP id
 cs8-20020a05690c0ec800b005a7a817be43mr5192486ywb.6.1699049048248; Fri, 03 Nov
 2023 15:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com> <20231103215124.1095-2-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-2-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:03:57 +0200
Message-ID: <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_saipraka@quicinc.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        qipl.kernel.upstream@quicinc.com
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

On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
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
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++++
>  4 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index ae7cae015193..68c1f4908473 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,17 @@
>
>  #define QCOM_DUMMY_VAL -1
>
> +struct actlr_config {
> +       const struct actlr_data *adata;
> +       u32 size;

This should be size_t.

Also could you please drop the separate struct actlr_config and move
these two fields into struct qcom_smmu_config.

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
> @@ -270,6 +281,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +       const struct actlr_config *actlrcfg;
> +       struct arm_smmu_smr *smr = smmu->smrs;
> +       int idx = smmu_domain->cfg.cbndx;
> +       int i;
> +       u16 id;
> +       u16 mask;
> +
> +       if (qsmmu->actlrcfg) {
> +               actlrcfg = qsmmu->actlrcfg;
> +               for (i = 0; i < actlrcfg->size; ++i) {
> +                       id = actlrcfg->adata[i].sid;
> +                       mask = actlrcfg->adata[i].mask;
> +                       if (!smr_is_subset(*smr, id, mask))
> +                               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ACTLR,
> +                                               actlrcfg->adata[i].actlr);
> +               }
> +       }

Consider extracting this to a separate function. This way you can
reduce 4 indentation levels into a single loop.

> +
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>
>         return 0;
> @@ -459,6 +490,9 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
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
> index 4c79ef6f4c75..38ac1cbc799b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -992,9 +992,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
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
