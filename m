Return-Path: <linux-kernel+bounces-775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9D8145DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92941F22B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF91A730;
	Fri, 15 Dec 2023 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtHBB3a0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD891A70D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dafe04717baso302310276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702637105; x=1703241905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j+anytNbzLKr/hZaB/jo1ZzNY0cUwX1gFBg2jJO9eUE=;
        b=HtHBB3a0E0nrQwDMS195cjvZNbyjAXX0oZQ/phzb8zP7RFwJRmoxXTqwsvHwYaKKeN
         1OW7c3QeqmRL4/DXTYdtFiFoRmMFQp/W8RRtK3fV4k8bAPhRC8K2PJzPE3/rSwP74EFy
         fy7Tipyv5opIMX/wmaJ1imCHLkTuBbxNFsyB9k6BungY/l6yRPWrXSdwL4jGcyIjAOKz
         rdGiX4E2BwmFtGwrQsYrVVmdyXMzOEj7DmrxluXRRxTj28LNMwWiXE8qRGo8L2XkWknU
         n1R2VK6EmkhbXi2p2pzeED+27HBei7XtUlS6YqZfSLMpo/o6dVlaalnBf/Iep0GVF7pC
         nHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702637105; x=1703241905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+anytNbzLKr/hZaB/jo1ZzNY0cUwX1gFBg2jJO9eUE=;
        b=NvpK1Z3tz8zhffz01eEjTiuLNF8TZZVirJq5ydF74f9p9+2koNanmnSKfW1dKVQ5iK
         B/j73Spw+G6Bpdt1RkuIBu2MBa19Nt3HOoQXyu1qHEKLqtViMMFBn+VRTKhIS2Sf803F
         Wbjw0H0nd8u6CksoyIf8EFvVE3X00LGOKO7zSPdc7U+gOvo9Zdqtr1zIX4NzpVBdjeZD
         2vhadmsa7/X+DjfXdvqSVoTXF3SlsXocBzACe023wlVJS+aTQduHXWhjQhwJU8Eep2XJ
         sOsA/VHqLNRRL7FA6E/m7LY+/odbfW3YWyZog0rgeKJtBi7r12BSMrL5ZmEpe6Nw213B
         wuXg==
X-Gm-Message-State: AOJu0Yw5LbbvNojaSpNy3rmvAt1xMtZrNiV9yxGPXmRE0Jt8YXzI3R+5
	oFWst/2iTPZNgWu0a+h+6bqFH6kxYA7VsHDDCYlLdA==
X-Google-Smtp-Source: AGHT+IGiTe9kk2PlGDSuALiVJRUN9a3crbBbVedHPKvVf1yfIfthmxwIYUB50hc8NPSjBZmc1C1l0kkNarUBoGDc3d4=
X-Received: by 2002:a5b:7d0:0:b0:db7:52f8:1381 with SMTP id
 t16-20020a5b07d0000000b00db752f81381mr7794079ybq.52.1702637104689; Fri, 15
 Dec 2023 02:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com> <20231215101827.30549-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231215101827.30549-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Dec 2023 12:44:53 +0200
Message-ID: <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for SM8550
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

On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index cb49291f5233..d2006f610243 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -20,6 +20,85 @@ struct actlr_config {
>         u32 actlr;
>  };
>
> +/*
> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> + * buffer). The remaining bits are implementation defined and vary across
> + * SoCs.
> + */
> +
> +#define PREFETCH_DEFAULT       0
> +#define PREFETCH_SHALLOW       BIT(8)
> +#define PREFETCH_MODERATE      BIT(9)
> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))

I thin the following might be more correct:

#include <linux/bitfield.h>

#define PREFETCH_MASK GENMASK(9, 8)
#define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
#define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
#define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
#define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)

> +#define PREFETCH_SWITCH_GFX    (BIT(5) | BIT(3))
> +#define CPRE                   BIT(1)
> +#define CMTLB                  BIT(0)
> +
> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
> +       { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
> +       { 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +       { 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       {},
> +};
> +
> +static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
> +       { 0x0000, 0x03ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
> +       {},
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -549,6 +628,15 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>         /* Also no debug configuration. */
>  };
>
> +
> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> +       .impl = &qcom_smmu_500_impl,
> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> +       .cfg = &qcom_smmu_impl0_cfg,
> +       .actlrcfg = sm8550_apps_actlr_cfg,
> +       .actlrcfg_gfx = sm8550_gfx_actlr_cfg,
> +};
> +
>  static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>         .impl = &qcom_smmu_500_impl,
>         .adreno_impl = &qcom_adreno_smmu_500_impl,
> @@ -583,6 +671,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>         { .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +       { .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
>         { .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { }
>  };
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

