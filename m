Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629B7EAE29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjKNKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjKNKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:36:36 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69493183
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:36:32 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a877e0f0d8so52563047b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699958191; x=1700562991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+mYxg8yeNyXvEJhMKcImbb1nPDH3wdsA1PNHlvuqoE=;
        b=Mlaf0+iqTx6Xs4hppWIhBjO0CcmXsWh3/VKgf5xgaw/krtHAZmlee2ZydHiKlhYUwR
         RudQbUDg7ocTkR0iE6nh3is8IYQnWiFFdMstSQQn5JKh4IBfZTP0ZguAzx7Z9Yp7RW66
         /S7I+peSkxN0sMdY4X5OtAJyyJ+k3y7fR7m8h+fL05gOaQGPfqIm7AuAst7Sd7kgzBZw
         fGknLMCqMxzXK+CcDOVDN9St/8x6j7zuq9A9e3uuq2Ks+JHOnnIxN73GwoqQisu4ncvc
         inhsCcqvUkh0N1xrxeG/uxiQMHZGLasWDrYAq7PMKnqt4lab11appQQg8nxc82PScdo5
         jcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699958191; x=1700562991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+mYxg8yeNyXvEJhMKcImbb1nPDH3wdsA1PNHlvuqoE=;
        b=Ie58DJaE+GiFd0QH2k4+QWxXoX35DfrEODu6cHmeOtSOHYp1qtBin23+1rlrZXABh5
         bYgucQba5+IL0rrG6bo8jLckgs34Unp2uTYCvDNg44MwxJUfOAU9YoklIs6KO37DVUto
         wVSjNyfTLm2CDD57BVtdPLt6HMRWW+zyIUfks5yTCC3ul1XWEqd0hv4ixLakSPyCqzy2
         Y/w0BFMzU4zHodSfSUFakKxAM00QZWoTYLhDoWcqUyhiUGOise4j0DOVPTujOC69uQHa
         QFL2eOBzTHDkJC73z5HgvJJJIi0/MaAFLBIARcobGWJmm3Evp/p+f7wdtH3SN1mcEwKu
         PaIA==
X-Gm-Message-State: AOJu0Yw9TQuvGP/+V96ry+k7KDMWZLUXmPB2hIemo32+YI80HYHhIsGD
        ggibKmeBkvQBGFaWzb9COmE461Rmfp42QFITbYWnJw==
X-Google-Smtp-Source: AGHT+IHBLqIwnNji9x/C2A7OOFkpd8B5O6cpKHp3du95OlDoVuqX5AQIlEV33+qzxDm9Xve1jTPw9PsRzk+uRRnGtY8=
X-Received: by 2002:a25:2f81:0:b0:da0:81da:e4df with SMTP id
 v123-20020a252f81000000b00da081dae4dfmr1652405ybv.13.1699958191562; Tue, 14
 Nov 2023 02:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-2-quic_bibekkum@quicinc.com> <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
 <212c4f7f-4b22-4e21-9848-906bbfd69f0e@quicinc.com> <3e1e38ed-8e5f-455e-8ab9-e5be2fb9a493@quicinc.com>
In-Reply-To: <3e1e38ed-8e5f-455e-8ab9-e5be2fb9a493@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 12:36:19 +0200
Message-ID: <CAA8EJprYEnchpxd36mDJyUQTY3VBLdkVL_9MfBY8VKeJysr7Cg@mail.gmail.com>
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

On Tue, 14 Nov 2023 at 12:20, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/6/2023 11:42 AM, Bibek Kumar Patro wrote:
> >
> >
> > On 11/4/2023 3:33 AM, Dmitry Baryshkov wrote:
> >> On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> >> <quic_bibekkum@quicinc.com> wrote:
> >>>
> >>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which
> >>> allows
> >>> the TLB to fetch just the next page table. MMU-500 features ACTLR
> >>> register which is implementation defined and is used for Qualcomm SoCs
> >>> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch
> >>> the next set of page tables accordingly allowing for faster
> >>> translations.
> >>>
> >>> ACTLR value is unique for each SMR (Stream matching register) and stored
> >>> in a pre-populated table. This value is set to the register during
> >>> context bank initialisation.
> >>>
> >>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>> ---
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++++++++++++
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++--
> >>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++++
> >>>   4 files changed, 44 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> index ae7cae015193..68c1f4908473 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>> @@ -14,6 +14,17 @@
> >>>
> >>>   #define QCOM_DUMMY_VAL -1
> >>>
> >>> +struct actlr_config {
> >>> +       const struct actlr_data *adata;
> >>> +       u32 size;
> >>
> >> This should be size_t.
> >>
> >> Also could you please drop the separate struct actlr_config and move
> >> these two fields into struct qcom_smmu_config.
> >>
> >
> > Ack, will address both these inputs in the next patch.
> >
>
> Dimitry, Tried moving both fields to qcom_smmu_config but since
> actlr_data need to be a pointer to array and not scalar, size needs
> to be calculated dynamically for each SoC data in a loop which is
> doable.But readily available implementations like ARRAY_SIZE cannot be
> used, so I think this extra struct indirection of actlr_config would be
> beneficial.

This should work fine from my point of view:

static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
 .impl = &sm8550_smmu_500_impl,
 .adreno_impl = &qcom_adreno_smmu_500_impl,
 .cfg = &qcom_smmu_impl0_cfg,
 .actlrcfg = &sm8550_apps_actlr_data,
 .actlrcfg_size = ARRAY_SIZE(sm8550_apps_actlr_data),
};



> Some drivers like llcc (drivers/soc/qcom/llcc-qcom.c) is also using
> similar implementation, I believe for the same reason.
>
> regards,
> Bibek
> >>> +};
> >>> +
> >>> +struct actlr_data {
> >>> +       u16 sid;
> >>> +       u16 mask;
> >>> +       u32 actlr;
> >>> +};
> >>> +
> >>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>>   {
> >>>          return container_of(smmu, struct qcom_smmu, smmu);
> >>> @@ -270,6 +281,26 @@ static const struct of_device_id
> >>> qcom_smmu_client_of_match[] __maybe_unused = {
> >>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >>>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>>   {
> >>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> >>> +       const struct actlr_config *actlrcfg;
> >>> +       struct arm_smmu_smr *smr = smmu->smrs;
> >>> +       int idx = smmu_domain->cfg.cbndx;
> >>> +       int i;
> >>> +       u16 id;
> >>> +       u16 mask;
> >>> +
> >>> +       if (qsmmu->actlrcfg) {
> >>> +               actlrcfg = qsmmu->actlrcfg;
> >>> +               for (i = 0; i < actlrcfg->size; ++i) {
> >>> +                       id = actlrcfg->adata[i].sid;
> >>> +                       mask = actlrcfg->adata[i].mask;
> >>> +                       if (!smr_is_subset(*smr, id, mask))
> >>> +                               arm_smmu_cb_write(smmu, idx,
> >>> ARM_SMMU_CB_ACTLR,
> >>> +
> >>> actlrcfg->adata[i].actlr);
> >>> +               }
> >>> +       }
> >>
> >> Consider extracting this to a separate function. This way you can
> >> reduce 4 indentation levels into a single loop.
> >>
> >
> > Ack, thanks for this sugestion. Will move this entire for loop into a
> > separate function for simplicity reduced indent levels.
> >
> >>> +
> >>>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> >>>
> >>>          return 0;
> >>> @@ -459,6 +490,9 @@ static struct arm_smmu_device
> >>> *qcom_smmu_create(struct arm_smmu_device *smmu,
> >>>          qsmmu->smmu.impl = impl;
> >>>          qsmmu->cfg = data->cfg;
> >>>
> >>> +       if (data->actlrcfg && (data->actlrcfg->size))
> >>> +               qsmmu->actlrcfg = data->actlrcfg;
> >>> +
> >>>          return &qsmmu->smmu;
> >>>   }
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >>> index 593910567b88..4b6862715070 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >>> @@ -9,6 +9,7 @@
> >>>   struct qcom_smmu {
> >>>          struct arm_smmu_device smmu;
> >>>          const struct qcom_smmu_config *cfg;
> >>> +       const struct actlr_config *actlrcfg;
> >>>          bool bypass_quirk;
> >>>          u8 bypass_cbndx;
> >>>          u32 stall_enabled;
> >>> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
> >>>   };
> >>>
> >>>   struct qcom_smmu_match_data {
> >>> +       const struct actlr_config *actlrcfg;
> >>>          const struct qcom_smmu_config *cfg;
> >>>          const struct arm_smmu_impl *impl;
> >>>          const struct arm_smmu_impl *adreno_impl;
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> index 4c79ef6f4c75..38ac1cbc799b 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> @@ -992,9 +992,10 @@ static int arm_smmu_find_sme(struct
> >>> arm_smmu_device *smmu, u16 id, u16 mask)
> >>>                   * expect simply identical entries for this case,
> >>> but there's
> >>>                   * no harm in accommodating the generalisation.
> >>>                   */
> >>> -               if ((mask & smrs[i].mask) == mask &&
> >>> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> >>> +
> >>> +               if (smr_is_subset(smrs[i], id, mask))
> >>>                          return i;
> >>> +
> >>>                  /*
> >>>                   * If the new entry has any other overlap with an
> >>> existing one,
> >>>                   * though, then there always exists at least one
> >>> stream ID
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> index 703fd5817ec1..b1638bbc41d4 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >>> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct
> >>> arm_smmu_device *smmu, int page,
> >>>                  writeq_relaxed(val, arm_smmu_page(smmu, page) +
> >>> offset);
> >>>   }
> >>>
> >>> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id,
> >>> u16 mask)
> >>> +{
> >>> +       return (mask & smrs.mask) == mask && !((id ^ smrs.id) &
> >>> ~smrs.mask);
> >>> +}
> >>> +
> >>>   #define ARM_SMMU_GR0           0
> >>>   #define ARM_SMMU_GR1           1
> >>>   #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> >>> --
> >>> 2.17.1
> >>>
> >>
> >>



-- 
With best wishes
Dmitry
