Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD237E0AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjKCWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjKCWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:01:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC252D63
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:01:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a8ee23f043so30190427b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699048881; x=1699653681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYqhTmNXb9G7gJbSyD6id2o7LS6FWzJ6rtOkac47hAw=;
        b=F+nQTkWYdGekP9o/iDDA4tFarQP8SEwwFszzGtEVB6btmxDJHV9KA0yGhXhdeAJVjA
         7KuOPrF+S4cGGqXNy9Fd74Z7W7f0039BPdow/+VSUU4ZmY6XHkPy86KjpnHBxv3lxhiK
         gOe+5/Nps0Gn9QvruYNBKLCFP9U/S9bu0ZivTol1U9hdkKETXS2DGWe/0NBNMWb3R0Lf
         DgaG+eFhl4leRrYOXKMszHHe/fgViGnwNnmmP0pU88qTkjnZKG7bryS0KXiaZVw+v+wm
         j7w8OoPycAdxA/wqhUVbCOW4os+bdIjK2yRFI9Sj47dG04n6oRkSyqFUO0meWQh2OdWr
         UP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048881; x=1699653681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYqhTmNXb9G7gJbSyD6id2o7LS6FWzJ6rtOkac47hAw=;
        b=XKt+GWn5glv+QXeAkSUtAzVusXozvZhscfANyUsTsWiLSm/5JJluNgm0IradA5Nmsr
         4xRLtnmvwUBPD2HlYFxhiHzePupSH0sMWcKZ6SdutqTI5pmAM+MvYtNJsdtl3eaxIayj
         Rk/Z/wCoktfHTEAy9eBgW+t1CyHV5jF9K08AXBmXNmMV27EhMjIQR7daQgWzztRfwjaD
         8XzUaRfpBbyfSoL1Vd+edBHa2NPzmMiZgpBXGM/gyNQrdrvSPPWe4MGGrdozodOiOOUK
         A6ntHrwQ6Ib2mnWYMPyiAUb9LhsxX5zcT4oXMrEJrCweVLnhsI6uV2iZLZLJck1Cx+ls
         tz4w==
X-Gm-Message-State: AOJu0YwXbO5yKFWvSMd8uM2e+LqcLbmCAXmzOwy7iNnl8QZiqWkjSwDn
        vxqttuu0a/Xw4E4e8vlzt1GfsPMv1NxZzcVyn3sxwA==
X-Google-Smtp-Source: AGHT+IHBmpng10V/3ZppWAw0mb3tfwjNCUoY2XY/FhvN123GIZ3qKWwR9YYBDbSST6Fc1QMmALfW0xflp+636V3zadc=
X-Received: by 2002:a5b:e8c:0:b0:da0:cc14:b66 with SMTP id z12-20020a5b0e8c000000b00da0cc140b66mr20480553ybr.9.1699048880909;
 Fri, 03 Nov 2023 15:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com> <20231103215124.1095-3-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-3-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:01:09 +0200
Message-ID: <CAA8EJpqWdHwF_mZoXt8wpYeKLWQEFs3H83c-OsLVYVGYmi5mkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
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
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 68c1f4908473..590b7c285299 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,6 +25,64 @@ struct actlr_data {
>         u32 actlr;
>  };
>
> +static const struct actlr_data sm8550_apps_actlr_data[] = {
> +       { 0x18a0, 0x0000, 0x00000103 },
> +       { 0x18e0, 0x0000, 0x00000103 },
> +       { 0x0800, 0x0020, 0x00000001 },
> +       { 0x1800, 0x00c0, 0x00000001 },
> +       { 0x1820, 0x0000, 0x00000001 },
> +       { 0x1860, 0x0000, 0x00000001 },
> +       { 0x0c01, 0x0020, 0x00000303 },
> +       { 0x0c02, 0x0020, 0x00000303 },
> +       { 0x0c03, 0x0020, 0x00000303 },
> +       { 0x0c04, 0x0020, 0x00000303 },
> +       { 0x0c05, 0x0020, 0x00000303 },
> +       { 0x0c06, 0x0020, 0x00000303 },
> +       { 0x0c07, 0x0020, 0x00000303 },
> +       { 0x0c08, 0x0020, 0x00000303 },
> +       { 0x0c09, 0x0020, 0x00000303 },
> +       { 0x0c0c, 0x0020, 0x00000303 },
> +       { 0x0c0d, 0x0020, 0x00000303 },
> +       { 0x0c0e, 0x0020, 0x00000303 },
> +       { 0x0c0f, 0x0020, 0x00000303 },
> +       { 0x1961, 0x0000, 0x00000303 },
> +       { 0x1962, 0x0000, 0x00000303 },
> +       { 0x1963, 0x0000, 0x00000303 },
> +       { 0x1964, 0x0000, 0x00000303 },
> +       { 0x1965, 0x0000, 0x00000303 },
> +       { 0x1966, 0x0000, 0x00000303 },
> +       { 0x1967, 0x0000, 0x00000303 },
> +       { 0x1968, 0x0000, 0x00000303 },
> +       { 0x1969, 0x0000, 0x00000303 },
> +       { 0x196c, 0x0000, 0x00000303 },
> +       { 0x196d, 0x0000, 0x00000303 },
> +       { 0x196e, 0x0000, 0x00000303 },
> +       { 0x196f, 0x0000, 0x00000303 },
> +       { 0x19c1, 0x0010, 0x00000303 },
> +       { 0x19c2, 0x0010, 0x00000303 },
> +       { 0x19c3, 0x0010, 0x00000303 },
> +       { 0x19c4, 0x0010, 0x00000303 },
> +       { 0x19c5, 0x0010, 0x00000303 },
> +       { 0x19c6, 0x0010, 0x00000303 },
> +       { 0x19c7, 0x0010, 0x00000303 },
> +       { 0x19c8, 0x0010, 0x00000303 },
> +       { 0x19c9, 0x0010, 0x00000303 },
> +       { 0x19cc, 0x0010, 0x00000303 },
> +       { 0x19cd, 0x0010, 0x00000303 },
> +       { 0x19ce, 0x0010, 0x00000303 },
> +       { 0x19cf, 0x0010, 0x00000303 },
> +       { 0x1c00, 0x0002, 0x00000103 },
> +       { 0x1c01, 0x0000, 0x00000001 },
> +       { 0x1920, 0x0000, 0x00000103 },
> +       { 0x1923, 0x0000, 0x00000103 },
> +       { 0x1924, 0x0000, 0x00000103 },
> +       { 0x1940, 0x0000, 0x00000103 },
> +       { 0x1941, 0x0004, 0x00000103 },
> +       { 0x1943, 0x0000, 0x00000103 },
> +       { 0x1944, 0x0000, 0x00000103 },
> +       { 0x1947, 0x0000, 0x00000103 },
> +};

This is nearly impossible to handle.
Please add defines for 0x1, 0x103 and 0x303. Also please consider
adding comments for the devices.

> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -444,6 +502,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
>
> +
> +static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> +       .init_context = qcom_smmu_init_context,
> +       .cfg_probe = qcom_smmu_cfg_probe,
> +       .def_domain_type = qcom_smmu_def_domain_type,
> +       .reset = arm_mmu500_reset,
> +       .write_s2cr = qcom_smmu_write_s2cr,
> +       .tlb_sync = qcom_smmu_tlb_sync,
> +};
> +
>  static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>         .init_context = qcom_adreno_smmu_init_context,
>         .def_domain_type = qcom_smmu_def_domain_type,
> @@ -507,6 +575,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
>         .reg_offset = qcom_smmu_impl0_reg_offset,
>  };
>
> +static const struct actlr_config sm8550_actlrcfg = {
> +       .adata = sm8550_apps_actlr_data,
> +       .size = ARRAY_SIZE(sm8550_apps_actlr_data),
> +};
> +
>  /*
>   * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
>   * there are not enough context banks.
> @@ -530,16 +603,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>         /* Also no debug configuration. */
>  };
>
> +
> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> +       .impl = &sm8550_smmu_500_impl,
> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> +       .cfg = &qcom_smmu_impl0_cfg,
> +       .actlrcfg = &sm8550_actlrcfg,
> +};

This structure doesn't seem to be linked. Did you test your patches?

> +
>  static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>         .impl = &qcom_smmu_500_impl,
>         .adreno_impl = &qcom_adreno_smmu_500_impl,
>         .cfg = &qcom_smmu_impl0_cfg,
>  };
>
> -/*
> - * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
> - * special handling and can not be covered by the qcom,smmu-500 entry.
> - */

Leave the comment in place.

>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>         { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>         { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
