Return-Path: <linux-kernel+bounces-8209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004581B3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349C31C23545
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280926E5AF;
	Thu, 21 Dec 2023 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVOO1AJj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB39675BC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e840338607so4832457b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703154745; x=1703759545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QH0RrHp3BbVq3x0TcnWEn70gx4fcFHG3l/rgwq9Zzao=;
        b=xVOO1AJjClx6ZInQssG5VCKwRF4w3qH0es/wR3uGCPeIUvpzwOhZAjyPjSFjUXFtlU
         oHOZKt4VD2DjT1GSbme8jvsfjWjhskGgDA/Xe82bup2M03ESEPLeDb6lr9yi25vIJiET
         zUoxzrcs9LbrRAmcRHxWa1RlbcyxfsaoogS7ew6SLZZ8D3RzW8sWdOA0u32mTh6ZlzrR
         8mF8y11INy6wkqj7aYRabshqkP4mLGueA0LlYCRXP2jilTIElqdxjICrw91BXXjv0eCI
         VMfzbku/fqXTy4zTNGLxI9UTQiSQEnnjg9Y/lxPVlu1FYW4mDrS2C7UCis32cjsuqBjH
         2M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154745; x=1703759545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QH0RrHp3BbVq3x0TcnWEn70gx4fcFHG3l/rgwq9Zzao=;
        b=DHZ/iGpzUh3oqQaxhUDwDVIwlMEZuKGYPBw5GEZ0lBJeZxKPEKhm2S4Jjewv+6HrF8
         vh7CxJ5s25rd6FWYUuPMWt58jDZH+5cjvKkqb1qJduvM56W+x+WG34Jfli98vlnlg40t
         DjAs8ijz7WlOdlIg0TekfBU5qzkW4vh5j2w2hrt3b1yKRJLMEtBXp3LQCuaB4f79ap5o
         ij2+pOcib99+BE1sISCeYUm/Mabh21MR1qeX4mfwOgOqbCechNVYgxb5hIG2ta3bLwtc
         JYoI58nlBRD5Xh/Fm71zHepT+n3F9ac+yvW0Kk1YyN1iI68YyigOUvPeVxvi8Uv0wFpY
         pFZg==
X-Gm-Message-State: AOJu0Yxyf61pEdbP8LLsVweLJ79XfPg35Zt+ScGDw3CE2aicDgiZOH34
	zGZdbQjU3hOWvbyiDilohgRKB7h5JHkZBc1fVObDtA==
X-Google-Smtp-Source: AGHT+IEDCA6TTwRZViV0lqKVy39Uwh2vsaYqgEwFHnRhf+6Q177re6i4SkHhOtg0CPX6CtP0tEwle+bwjnGkABKknC8=
X-Received: by 2002:a0d:e84c:0:b0:5e6:81f8:b2ea with SMTP id
 r73-20020a0de84c000000b005e681f8b2eamr723855ywe.96.1703154744760; Thu, 21 Dec
 2023 02:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220133808.5654-1-quic_bibekkum@quicinc.com>
 <20231220133808.5654-4-quic_bibekkum@quicinc.com> <CAA8EJpo8X+jfi20N9P7kUshxe6_7pwQe8G0Q02JDuB8ozH7hLA@mail.gmail.com>
 <7b32b7a7-bc64-4102-a6bf-3c3fc8d979ac@quicinc.com>
In-Reply-To: <7b32b7a7-bc64-4102-a6bf-3c3fc8d979ac@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 12:32:13 +0200
Message-ID: <CAA8EJpo6LdBQm5q=r2+ETBwhKL3YkUsPDuzA2MGCqb-1R_9b7w@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 12:02, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 12/21/2023 6:06 AM, Dmitry Baryshkov wrote:
> > On Wed, 20 Dec 2023 at 15:39, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> >> the TLB to fetch just the next page table. MMU-500 features ACTLR
> >> register which is implementation defined and is used for Qualcomm SoCs
> >> to have a custom prefetch setting enabling TLB to prefetch the next set
> >> of page tables accordingly allowing for faster translations.
> >>
> >> ACTLR value is unique for each SMR (Stream matching register) and stored
> >> in a pre-populated table. This value is set to the register during
> >> context bank initialisation.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++++
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++-
> >>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++
> >>   4 files changed, 58 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 20c9836d859b..1cefdd0ca110 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -24,6 +24,12 @@
> >>   #define CPRE                   (1 << 1)
> >>   #define CMTLB                  (1 << 0)
> >>
> >> +struct actlr_config {
> >> +       u16 sid;
> >> +       u16 mask;
> >> +       u32 actlr;
> >> +};
> >> +
> >>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>   {
> >>          return container_of(smmu, struct qcom_smmu, smmu);
> >> @@ -215,9 +221,38 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
> >>          return true;
> >>   }
> >>
> >> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
> >> +               const struct actlr_config *actlrcfg)
> >> +{
> >> +       struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> >> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >> +       struct arm_smmu_smr *smr;
> >> +       u16 mask;
> >> +       int idx;
> >> +       u16 id;
> >> +       int i;
> >> +
> >> +       for (; actlrcfg->sid || actlrcfg->mask || actlrcfg->actlr; actlrcfg++) {
> >> +               id = actlrcfg->sid;
> >> +               mask = actlrcfg->mask;
> >> +
> >> +               for_each_cfg_sme(cfg, fwspec, i, idx) {
> >> +                       smr = &smmu->smrs[idx];
> >> +                       if (smr_is_subset(smr, id, mask)) {
> >> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> >> +                                               actlrcfg->actlr);
> >> +                               break;
> >> +                       }
> >> +               }
> >> +       }
> >> +}
> >> +
> >>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>   {
> >> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> >> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> >> +       int cbndx = smmu_domain->cfg.cbndx;
> >>          struct adreno_smmu_priv *priv;
> >>
> >>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> >> @@ -248,6 +283,9 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >>          priv->set_stall = qcom_adreno_smmu_set_stall;
> >>          priv->resume_translation = qcom_adreno_smmu_resume_translation;
> >>
> >> +       if (qsmmu->data->actlrcfg_gfx)
> >> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg_gfx);
> >
> > There was a feedback point against v4 that there can be more than two
> > (apps + gpu) SMMU devices. No, we can not use additional compat
> > strings, the SMMU units are compatible with each other.
>
> Just to understand better, did you mean if in the below check
> [inside arm-smmu-qcom.c file during qcom_smmu_create()], "else" has two
> things? (Currently adreno_impl for gpu smmu, else for only
> apps smmu)

qcom,adreno-smmu is quite unique here, this is the only distinctive
substring. We do not have such compat strings for any other of SMMU
nodes.

>
>           if (np && of_device_is_compatible(np, "qcom,adreno-smmu"))
>                   impl = data->adreno_impl;
>           else
>                   impl = data->impl;
>
> > Please add
> > matching between the smmu and particular actlr table using the IO
> > address of the SMMU block.
> >
>
> The ACTLR table for each smmu will have A IO address attached, so based
> on IO address we can apply ACTLR.
> Is this your proposal((IMO hardcoding IO in driver won't be viable,
> isn't it?), or in smmu DT we would need to set the IO?

Unfortunately, I meant exactly that: hardcoding addresses of the SMMU
register spaces. see drivers/gpu/drm/msm/dsi_cfg.c
Then during device probe the driver can match the IO address to the
list of the per-platform ACTLR tables and select the correct one.
Then you don't even need a special actlrcfg_gfx. The GFX will fall
into the main schema.

>
>
> Thanks & regards,
> Bibek
>
> >> +
> >>          return 0;
> >>   }
> >>
> >> @@ -274,6 +312,13 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >>                  struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>   {
> >> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> >> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> >> +       int cbndx = smmu_domain->cfg.cbndx;
> >> +
> >> +       if (qsmmu->data->actlrcfg)
> >> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg);
> >> +
> >
> > One issue occured to me, while I was reviewing the patchset. The ACTLR
> > settings are related to the whole SMMU setup, but we are applying them
> > each time there is an SMMU context init (in other words, one per each
> > domain). Is that correct? Or it's just that there is no better place
> > for initialising the global register set? Would it be better to
> > reprogram the ACTLR registers which are related just to this
> > particular domain?
> >
> >>          smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> >>
> >>          return 0;
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >> index f3b91963e234..cb4cb402c202 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> >> @@ -1,6 +1,6 @@
> >>   /* SPDX-License-Identifier: GPL-2.0-only */
> >>   /*
> >> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >>    */
> >>
> >>   #ifndef _ARM_SMMU_QCOM_H
> >> @@ -24,7 +24,11 @@ struct qcom_smmu_config {
> >>          const u32 *reg_offset;
> >>   };
> >>
> >> +struct actlr_config;
> >> +
> >>   struct qcom_smmu_match_data {
> >> +       const struct actlr_config *actlrcfg;
> >> +       const struct actlr_config *actlrcfg_gfx;
> >>          const struct qcom_smmu_config *cfg;
> >>          const struct arm_smmu_impl *impl;
> >>          const struct arm_smmu_impl *adreno_impl;
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> index d6d1a2a55cc0..0c7f700b27dd 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
> >>                   * expect simply identical entries for this case, but there's
> >>                   * no harm in accommodating the generalisation.
> >>                   */
> >> -               if ((mask & smrs[i].mask) == mask &&
> >> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> >> +
> >> +               if (smr_is_subset(&smrs[i], id, mask))
> >>                          return i;
> >> +
> >>                  /*
> >>                   * If the new entry has any other overlap with an existing one,
> >>                   * though, then there always exists at least one stream ID
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> index 703fd5817ec1..2e4f65412c6b 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
> >>                  writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
> >>   }
> >>
> >> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
> >> +{
> >> +       return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
> >> +}
> >> +
> >>   #define ARM_SMMU_GR0           0
> >>   #define ARM_SMMU_GR1           1
> >>   #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
With best wishes
Dmitry

