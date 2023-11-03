Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B387E0AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjKCV61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:58:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12913A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 14:58:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so2626844276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699048702; x=1699653502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvHqC7poFx7BMy+LdsPLJ3AAQCZp3Oo4BjaZBQGHt+E=;
        b=LOT0XksP+myBzb+k3dHDN+KY5lmDAzACgCEayy/2Jnmqlll9O6d8LvDnAj1lHddYxP
         wTV9bzWHVf2uwrzDWAmw5gv3daePNhbJox6LRbHQDByYpqRApN3HmtplzVDArS7B8YBN
         VmJw+kZ+ijRQSEWCZkuP9Xq+VY7WU9HD/bi3CY+to8kIq16piCB49kMeZBzwppqaFZtD
         ty8MfN5oH4y8AQs/skdiAOLKz9qGHo5QGzqPdw3BP4t+QcPmKcaGXD6eyxP7l6JFexRH
         qiCwyS2IvXrDNNs2VeQY1Li8wUDHXBge65VVr6o6MQxw5PRFDQPC/SlMttOJuCqri6RO
         tFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048702; x=1699653502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvHqC7poFx7BMy+LdsPLJ3AAQCZp3Oo4BjaZBQGHt+E=;
        b=ks2ZEsDUoY710bInd7X95kpn2CRiLmSrxPe2McvqSTDC5wEgCjp8A2wTYtc1M+Mf4y
         79Xc/Elb4Jm7l2YM75cLk4rN14OufbG5GGjo9m20au/ODA+++ST8Z6JnZ7mHBDTBkqah
         xpAfAWqLxoqk296mhxgHIUzaUOYrnpcD7Pb4WZ5HfFns7Iyii9P1zrIOqTcjYe/GGvtz
         t/t2zUUd/QRD8cLOm2AHh5ikEmQ6ApRxQGG4JGBXdCk3yN5nd7Gz8D+eMPao3txC6Vqu
         20RVV/YXmybJ0n4Ig5PdTEg2eYZ6OAFlZTspH6OdGiGuKyV5l2ZiVme7GVOQQnXV8ZKx
         VRHA==
X-Gm-Message-State: AOJu0YzoMiOY5qlM5pmaWgbYCKn+ZaacbBryd/xQYCY9Nk5sJzGujezI
        aGNXXmhUeREX2T4CUDvHu2oskZpFtNvdngRQJySB5w==
X-Google-Smtp-Source: AGHT+IF5gUp+7xxZKnIAFc/I7tU2TZuKdJ2oRYSWVhPhAw4M4QREQZCd20nAXGPp+8q9cUWkMFn5AXFBmAAF/PIQNNU=
X-Received: by 2002:a5b:9d2:0:b0:d81:5d20:97b9 with SMTP id
 y18-20020a5b09d2000000b00d815d2097b9mr21018506ybq.31.1699048701977; Fri, 03
 Nov 2023 14:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com> <20231103215124.1095-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-4-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 3 Nov 2023 23:58:10 +0200
Message-ID: <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
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

On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 590b7c285299..f342b4778cf1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>         return match ? IOMMU_DOMAIN_IDENTITY : 0;
>  }
>
> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> +
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +       u32 reg;
> +
> +       arm_mmu500_reset(smmu);
> +
> +               for (i = 0; i < smmu->num_context_banks; ++i) {
> +                       reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +                       reg |= ARM_MMU500_ACTLR_CPRE;
> +                       arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> +               }

Wrong indentation. Did you run your patches through checkpatch.pl?

> +
> +       return 0;
> +}
> +
>  static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>         int ret;
>
> -       arm_mmu500_reset(smmu);
> +       qcom_smmu500_reset(smmu);
>
>         /*
>          * To address performance degradation in non-real time clients,
> @@ -488,7 +506,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -507,7 +525,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -523,7 +541,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>  static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>         .init_context = qcom_adreno_smmu_init_context,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>         .write_sctlr = qcom_adreno_smmu_write_sctlr,
>         .tlb_sync = qcom_smmu_tlb_sync,
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
