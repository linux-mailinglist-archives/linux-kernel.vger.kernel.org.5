Return-Path: <linux-kernel+bounces-24676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5B82C0A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA34DB22604
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558946BB59;
	Fri, 12 Jan 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzsEtuiB"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7C6BB4F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso5624291276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705065298; x=1705670098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDWt7qNI0NuDiSYcTfV6CD0Gy7BpMOi0Lg0E40nc3b8=;
        b=RzsEtuiBHgLbdnur6za2Jfq9ltR3zu/AKjZxecR0ZkAVjR4XgCD16/wnkdcsTUal3h
         84i16XGAzwqI43+K1FEPmlvhqFWmzpgdWjpu0rhajk119MNw77d2F8JDmNjBm0bee3nz
         bJY+yjdcb20IoQ1NIKZB5qCk3nS9tx/gjbrSmunt6wqik4cIsruS5BeJNzfoehksoX0N
         auoeV/IW+fOC5DOiWduLMFjqVTQj45s0IiVuBfMkpN0Xt3Yq7XibLSqwqUBdLR4FW8R2
         8c+NTiCxJmJIBObu3oZ3yIcHD4QGLHbouv3SjCF0dxKtFKik7mxB9AAhXVeGetl729pk
         5QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705065298; x=1705670098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDWt7qNI0NuDiSYcTfV6CD0Gy7BpMOi0Lg0E40nc3b8=;
        b=GB9DdYH8r9vleVqQOFiLI+kzvZfh58rVpHK79Tti4EAlUbp0Y1zqkyyTehfEhtfx/a
         JFjQdAKeqxiH0ixRGu2uUDR2nI9B9P7zlsjTAz79LpECZQYWbbHwEwn3PJH21qaphoOc
         jBC259K47DVKs6zDONUa+ddT5wJKruvuYGlUFfLP9jJpabi172vJWGT8umu16oYnDZgZ
         NMjHuWzK/l4v+pSjv2YGf5gPxn93wScwZ2auw2+5zxs5fb7RmmaamtUZy/IQGc4EPutG
         YFxpzXFPUKcGKR7M0I0p83PaW5FTvPrrXBSWvvyU4XiK9yO/s4fHw1fy8uafo/dQhVUO
         MZ3w==
X-Gm-Message-State: AOJu0YxMKRXc8/Ju44w5YmomzkWXEnHGw7i6lgEOg2iMMK/LsxFov0oR
	1rlUWTPIe4Op2yanle9tcvBtThNE9o3wnFwJwb5/l4osVaZ9cw==
X-Google-Smtp-Source: AGHT+IH1RX2+oy5HazPnAb/xvxbNva+AvDgMRcaARltCKAQWsGN6VdkvcSbNWjOTJS9uBfPDKv4YUt2awYjUB1O3IEg=
X-Received: by 2002:a25:d20f:0:b0:d9a:b9fe:a318 with SMTP id
 j15-20020a25d20f000000b00d9ab9fea318mr713671ybg.58.1705065297965; Fri, 12 Jan
 2024 05:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com> <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com> <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
 <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org> <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
 <babd9514-6202-486f-a7c5-51ad793aaca6@linaro.org> <d7110cff-334f-40cd-9f11-62fafd8d722d@quicinc.com>
In-Reply-To: <d7110cff-334f-40cd-9f11-62fafd8d722d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Jan 2024 15:14:46 +0200
Message-ID: <CAA8EJpqO2vEQP3B3gpGHvMSiaMQspz+63WVVXbkd0Hrx-AFeCQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Pavan Kondeti <quic_pkondeti@quicinc.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 15:07, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 1/12/2024 3:31 PM, Konrad Dybcio wrote:
> >
> >
> > On 1/11/24 19:09, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 1/10/2024 11:26 PM, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 1/10/24 13:55, Bibek Kumar Patro wrote:
> >>>>
> >>>>
> >>>> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
> >>>>>
> >>>>>
> >>>>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>> @@ -274,6 +321,21 @@ static const struct of_device_id
> >>>>>>> qcom_smmu_client_of_match[] __maybe_unused = {
> >>>>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain
> >>>>>>> *smmu_domain,
> >>>>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>>>>>>   {
> >>>>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> >>>>>>> +    const struct actlr_variant *actlrvar;
> >>>>>>> +    int cbndx = smmu_domain->cfg.cbndx;
> >>>>>>> +
> >>>>>>> +    if (qsmmu->data->actlrvar) {
> >>>>>>> +        actlrvar = qsmmu->data->actlrvar;
> >>>>>>> +        for (; actlrvar->io_start; actlrvar++) {
> >>>>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
> >>>>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx,
> >>>>>>> actlrvar->actlrcfg);
> >>>>>>> +                break;
> >>>>>>> +            }
> >>>>>>> +        }
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>
> >>>>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
> >>>>>> the same. Possible to do some refactoring?
> >>>>>>
> >>>>>
> >>>>> I will check if this repeated blocks can be accomodated this into
> >>>>> qcom_smmu_set_actlr function if that would be fine.
> >>>>>
> >>>>
> >>>> Also adding to this, this might increase the number of indentation
> >>>> inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
> >>>> be an issue?
> >>>
> >>> By the way, we can refactor this:
> >>>
> >>> if (qsmmu->data->actlrvar) {
> >>>      actlrvar = qsmmu->data->actlrvar;
> >>>      for (; actlrvar->io_start; actlrvar++) {
> >>>          if (actlrvar->io_start == smmu->ioaddr) {
> >>>              qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
> >>>              break;
> >>>          }
> >>>      }
> >>> }
> >>>
> >>> into
> >>>
> >>> // add const u8 num_actlrcfgs to struct actrl_variant to
> >>> // save on sentinel space:
> >>> //   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)
> >>>
> >>
> >> Git it, Would it be better to add this in struct qcom_smmu_match_data ?
> >
> > Yes, right.
> >
>
> Actually, I noticed now, we can do both the actlr_config (num_actlrcfg
> is used) and actlr_var (num_smmu is used) in the similar by storing the
> number of elements in each of them.
> something like this:
>
> +static const struct actlr_config sc7280_apps_actlr_cfg[] = {
> +       { 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2000, 0x0163, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2080, 0x0461, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2100, 0x0161, PREFETCH_DEFAULT | CMTLB },
> +       { 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_config sc7280_gfx_actlr_cfg[] = {
> +       { 0x0000, 0x07ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_variant sc7280_actlr[] = {
> +       { .io_start = 0x15000000, .actlrcfg = sc7280_apps_actlr_cfg,
> .num_actlrcfg = 7 },
> +       { .io_start = 0x03da0000, .actlrcfg = sc7280_gfx_actlr_cfg,
> .num_actlrcfg = 1 },
> +};
> +
>   static const struct actlr_config sm8550_apps_actlr_cfg[] = {
>         { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>         { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> @@ -661,6 +680,13 @@ static const struct qcom_smmu_match_data
> sdm845_smmu_500_data = {
>         /* Also no debug configuration. */
>   };
>
> +static const struct qcom_smmu_match_data sc7280_smmu_500_impl0_data = {
> +       .impl = &qcom_smmu_500_impl,
> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> +       .cfg = &qcom_smmu_impl0_cfg,
> +       .actlrvar = sc7280_actlr,
> +       .num_smmu = 2,
> +};
>
> Just for note , there's a small hiccup here as we have to manually
> calculate and the number of elements in actlr_config size everytime we
> add this info for a new target, won't be an issue though but just a
> hindrance to automation (?)

Just use ARRAY_SIZE(sc7280_actlr).


-- 
With best wishes
Dmitry

