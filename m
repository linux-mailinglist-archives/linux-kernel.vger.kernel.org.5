Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6947EC111
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjKOLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:04:13 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0518D95
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:04:10 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a84204e7aeso77070877b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700046249; x=1700651049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naTuhSl69LmFBC+TpFtD+Qgn0vKBo/uscYCgy85Lk+g=;
        b=h16MTw/CzEh3U9vn2wlgSU6Kh+N1Q4ukLCSTtDwn9INHcuoaRBajvj/XfTn69vO+8W
         6yHhHPlIl7eqcJqP7g4dJGrQgbdz0PGsuDifQPJ3aHX3LNBItrDqNAHqzOdt6ni/fAnz
         sK/tBlnSKxn0t9gg/FPdwGdaMhHI7c4vZpta1z4ianK3+FIHL209g7bmkVnjXhlZ9J8E
         hv0Xjd4N7jSj1etKr9jz5pOrrB4eDnFAf8IG6IMj68EHdLUmXHaEkoajuaa9nN9m0CEg
         0P7U3OVlxb8eRMGAHv4UEwJERu7cuCZkpqKvPPKukRxBgF6fES3caBfT/3R4Q+PoE/V1
         AIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700046249; x=1700651049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naTuhSl69LmFBC+TpFtD+Qgn0vKBo/uscYCgy85Lk+g=;
        b=RGwUzj/QkzGmtFRV0DEEjITxyKd0Q3okwziIkMqsyMNkETbZe87JaCbMv/jWIFTyUW
         fI3TNXABwvw1D9DubgCP2erBmSF5hEmlSyExDdxwwwfzMsajibwqtfLAqJt3nRX6h0Wg
         kIAJ05Qy/AoNwSciTLdgcLAx6hKKuQqwm37wIFlP0Mh9lqpKHOcgrPnZXDfL4t40ZjCw
         oWl1dSN9R03iGqUj2LxonX/ZtPeNhoBBQeipRqNG7trodzV4rO1WoBC2i5HkZjKR9m80
         /mY3oDnPLcHN9Bat4aXCTYOGrLma1LTjMbM0l8Fnk3xzYTSUsEGVeT1M+28SQrZ0wm3Y
         j79Q==
X-Gm-Message-State: AOJu0Yxi8o8OQ3tr5NVI+oD9lPOQqYhDxkUGuT8O7FAedIar/RX81NU7
        keiu1Y+IvMoK9ptj6FV3WbiBGwLxgPOv1Q6Xkf+iRQ==
X-Google-Smtp-Source: AGHT+IEr2PGPjbSKTkTzH1/sICNyy5m4ckXBm6eCcrurokOSqbFt2CeaPrvTeBNYrypV1H0PIIom5bkymgTTKPBOHZA=
X-Received: by 2002:a81:8357:0:b0:5ad:cd52:d6f0 with SMTP id
 t84-20020a818357000000b005adcd52d6f0mr13994365ywf.45.1700046249148; Wed, 15
 Nov 2023 03:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com> <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
 <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
In-Reply-To: <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 13:03:58 +0200
Message-ID: <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
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

On Wed, 15 Nov 2023 at 11:45, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
> > On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> >> through SoC specific reset ops, which is disabled in the default MMU-500
> >> reset ops, but is expected for context banks using ACTLR register to
> >> retain the prefetch value during reset and runtime suspend.
> >
> > Please refer to Documentation/process/submitting-patches.rst and
> > rephrase this following the rules there.
> >
>
> Noted, will go through the description once and rephrase it
> in next version complying with rules.
>
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
> >>   1 file changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 0eaf6f2a2e49..fa867b1d9d16 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> >>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
> >>   }
> >>
> >> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> >> +{
> >> +       int i;
> >> +       u32 reg;
> >> +
> >> +       arm_mmu500_reset(smmu);
> >> +
> >> +       /* Re-enable context caching after reset */
> >> +       for (i = 0; i < smmu->num_context_banks; ++i) {
> >> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> >> +               reg |= CPRE;
> >> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> >>   {
> >>          int ret;
> >>
> >> -       arm_mmu500_reset(smmu);
> >> +       qcom_smmu500_reset(smmu);
> >
> > Is this applicable for sdm845? For all other platforms supported by
> > qcom_smmu_500 implementation?
> >
>
> In arm_mmu500_reset operation drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> CPRE bit is reset for all SoC based on mmu500 platform, hence for all
> Qualcomm SoCs including sm845 we are setting back the CPRE bit.

The errata for the CoreLink MMU-500 requires CPRE to be disabled for
all revisions before r2p2. Do we know whether these SoC used CoreLink
MMU-500 and which version of it?

>
> >>
> >>          /*
> >>           * To address performance degradation in non-real time clients,
> >> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
> >>   static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
> >>          .init_context = qcom_adreno_smmu_init_context,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
> >>          .write_sctlr = qcom_adreno_smmu_write_sctlr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >> --
> >> 2.17.1
> >>
> >
> >



--
With best wishes
Dmitry
