Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160547E0B07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjKCWXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:23:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2CD4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:23:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso2623370276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699050198; x=1699654998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HcUuruGNVY3TMumh0gyBypYNry0wGNm/0WZhCQih1rY=;
        b=kzB3zticvnmTAtNreN52ygb2rrixtgodCEVhOVEpPASU15vR6No1llFJeds6oNIUKr
         DZbqhj+qedg/BQL2rADHBofQg0koPl8huU2bZFg+kUtXd34pUtsqh8HdPIUokKulkFOA
         PylpAMQO7R/PxQicyFlfDtJSc8aCCJrgeNp6WeyJE9NFT4ttz7IOrjSpCmWBmizZIrzG
         VCd2v5CyrarhzanI44R0mnMS86cKQcz0N7q8VhQhVrR6O7Ess4dnq6IZ7y8GreUujkuA
         0rrktS+pvQfuj5jZZm0aB8yAnkOMmCoCv+rxpPc95LU0wpfTcl9uYgbLi1nJGxPG1NkF
         kp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050198; x=1699654998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcUuruGNVY3TMumh0gyBypYNry0wGNm/0WZhCQih1rY=;
        b=hiwHooUpIbyNrPiFAFmrJglQk4CS5HbIYdWWbB8C3NUEqlUqD+E3DXtLyi0PFqyPik
         S37DltUyF+Qkc8U9OHJLZe7oTytJWSH7x/9WaDSjCq9oIqSR9QOxnhZuQsXLCp5I0w1r
         lkkAAMnWKZVwDRPVaPcghqndXVNh/Szo5r60ojz4qp9ZinWgDORALw78U9X9cyg2PEFB
         PMrjiWxhmP42+uiy0g6lx4BvFn3oCOb1ZHMCxT5jCKN8WcvPHmEwnAGSyxXxoy9OrVGH
         NytnF9cTGLtisDXZjhsRTTzdjAYRTQEJiRiSO4MAhoaB1PxM4FQhOm5B3pDj9tAk8F+R
         J00A==
X-Gm-Message-State: AOJu0Yw53ZZIIVTyTrwhnqSS32bml0c8Hx8Pu+Id8MHfOI6JdewNhYP2
        j7+misgwKU4oVsdt5NN3cHOFjN3sWafCkdfhd5YHcleH2xxsjBxs
X-Google-Smtp-Source: AGHT+IEAfObYIKaAE2Ni9quS5PIsAcwlJsD8mRWs4gcac4hASb1dlb4aKBTt5fgpwDbs9FOdYjjCo020CJJz5c+gxGw=
X-Received: by 2002:a25:504d:0:b0:d9b:dfea:bc94 with SMTP id
 e74-20020a25504d000000b00d9bdfeabc94mr20062761ybb.31.1699050198097; Fri, 03
 Nov 2023 15:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com> <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
 <981deaf3-c7e2-4bbc-86b8-2151bf0b6e00@quicinc.com>
In-Reply-To: <981deaf3-c7e2-4bbc-86b8-2151bf0b6e00@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:23:07 +0200
Message-ID: <CAA8EJprG_=p=F7BCUG6gBwHAP3VHQxYnx91fYSOKwBV_nJ3HAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
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

On Sat, 4 Nov 2023 at 00:07, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/4/2023 3:28 AM, Dmitry Baryshkov wrote:
> > On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> >> through SoC specific reset ops, which is disabled in the default MMU-500
> >> reset ops, but is expected for context banks using ACTLR register to
> >> retain the prefetch value during reset and runtime suspend.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
> >>   1 file changed, 22 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 590b7c285299..f342b4778cf1 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> >>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
> >>   }
> >>
> >> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> >> +
> >> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> >> +{
> >> +       int i;
> >> +       u32 reg;
> >> +
> >> +       arm_mmu500_reset(smmu);
> >> +
> >> +               for (i = 0; i < smmu->num_context_banks; ++i) {
> >> +                       reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> >> +                       reg |= ARM_MMU500_ACTLR_CPRE;
> >> +                       arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> >> +               }
> >
> > Wrong indentation. Did you run your patches through checkpatch.pl?
> >
>
> Yes Dmitry, I did run checkpatch.pl script on this patch as well as
> others, got 0 errors and 0 warnings. With -f option as well. Did not
> get any related errors and warnings.

Ack, I beg your pardon. checkpatch indeed doesn't warn about this
indentation. Though it is still incorrect.

>
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
> >>
> >>          /*
> >>           * To address performance degradation in non-real time clients,
> >> @@ -488,7 +506,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -507,7 +525,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -523,7 +541,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
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
