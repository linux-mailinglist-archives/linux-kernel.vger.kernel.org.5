Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025E97EC358
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbjKONLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjKONLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:11:14 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B412E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:11:09 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5af6c445e9eso78831717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700053869; x=1700658669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nUQCAFuaxTyoLD7UNNjsKWWroEqjiHXlZ64gbEbsUu4=;
        b=cGUHsfFQPjDmVBE9UCW+TvfNyGl3fMLzZmUaGfYP4QYefxaUUhSOHLoTuGxnVmHORA
         bli2Qosi7Bg3s+8o2F2o1C457YGtLkJwOvn8u3h6PbILr6dbr/xVNCPL+gi+CN8ud1Ue
         7cYFj/Hxy/Xstd2AmQu1THkgcxy40i/5XQsAxrvyp5Wz7M400ncN8JQIU+PmNKxie+ty
         d/qBJhB8ZRuhhuFiKsaoOeda2Zl8rd4wAu7WlrpgVluOVxPaFlmSOHbaquxpW9UG3/Vr
         kBUzWWUvhjfLADddfInZtgpe89ylqRPNKtIGw15HXvVon6tGTqBitPcp51yhaJ/gF8UV
         ZgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053869; x=1700658669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUQCAFuaxTyoLD7UNNjsKWWroEqjiHXlZ64gbEbsUu4=;
        b=F7fgE54RMQ/xTyKK31e87UO7ty4F6InFE72smZ+8rSgbFyrCssONP+kJf703kjn9Yc
         c5x3LNObgptlRuPnObE1h6at1Af1Kuz7iy21f+5+RAUIePBh9UrKW7xUH6sxOzyu8DZb
         Yt6jDr67xCgMaBMUGMKrR60E7kYfasU5cnvsQ/m/Do8IUK+1XV3XwN8wbQ4Iw0xB2HoA
         nBAWX4I5sFRpA3kLPSPPysbyvp6unZHEEBUr2/UPxJBHTpPoAcsxMsl9yurhzqOfthG4
         vwfbQ/Ah5PDtg6pAFoEx4f3/zWs4aM0+OrRyLawawbCDR+zeEzfFbPvSR2/CchzJvPe4
         E+IQ==
X-Gm-Message-State: AOJu0YxPum1vwNKZJ6Mghs1YhPaPRx7HEn5s6ItVEd3mHjhI1QrMjT5d
        9aLZARZVcvTuY0pHmWolKA1uUPbTxH2Rt1gwy49p9Q==
X-Google-Smtp-Source: AGHT+IE27QoHAd9yPBCePxIWbaxkxONJy9FLcjaOoJ9YA8XjjrnCyqh9x8JdYwE8Cvx7AQpmB+AOGFCj1489G09wQjk=
X-Received: by 2002:a81:a504:0:b0:5a8:204c:5c9b with SMTP id
 u4-20020a81a504000000b005a8204c5c9bmr13301987ywg.18.1700053868675; Wed, 15
 Nov 2023 05:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com> <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com> <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com> <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
In-Reply-To: <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 15:10:57 +0200
Message-ID: <CAA8EJpp6=EGd4j7w+P5v0_PCzUdtty4p30q0bAD2rc2oCWnwfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 14:49, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
> > On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
> >>> <quic_bibekkum@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> >>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>
> >>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>> same including SM8550 specific implementation operations.
> >>>>>>
> >>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>> ---
> >>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 +++++++++++++++++++++-
> >>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
> >>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
> >>>>>>            u32 actlr;
> >>>>>>     };
> >>>>>>
> >>>>>> +#define PRE_FETCH_1    0
> >>>>>> +#define PRE_FETCH_2    BIT(8)
> >>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
> >>>>>
> >>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
> >>>>> PRE_FETCH_1? Are these real numbers that refer to some amount / count
> >>>>> or just dummy names?
> >>>>>
> >>>>
> >>>> No,these are not real numbers, but prefetch settings for a particular
> >>>> perfect configuration.
> >>>
> >>> Then I'd ask for some better names or descriptions.
> >>>
> >>
> >> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
> >> in the following case. Would it be okay to use this name instead?
> >
> > Not really.
> >
>
> Any suggestion you have in mind, if not this nomenclature?

PREFETCH_something, PREFETCH_do_other_thing and PREFETCH_something_else

>
> >>
> >>>>
> >>>>>> +#define CPRE           BIT(1)          /* Enable context caching in the prefetch buffer */
> >>>>>> +#define CMTLB          BIT(0)          /* Enable context caching in the macro TLB */
> >>>>>> +
> >>>>>> +static const struct actlr_data sm8550_apps_actlr_data[] = {
> >>>>>> +       { 0x18a0, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x18e0, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x0800, 0x0020, PRE_FETCH_1 | CMTLB },
> >>>>>> +       { 0x1800, 0x00c0, PRE_FETCH_1 | CMTLB },
> >>>>>> +       { 0x1820, 0x0000, PRE_FETCH_1 | CMTLB },
> >>>>>> +       { 0x1860, 0x0000, PRE_FETCH_1 | CMTLB },
> >>>>>> +       { 0x0c01, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c02, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c03, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c04, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c05, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c06, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c07, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c08, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c09, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c0c, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c0d, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c0e, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x0c0f, 0x0020, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1961, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1962, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1963, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1964, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1965, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1966, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1967, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1968, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1969, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x196c, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x196d, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x196e, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x196f, 0x0000, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c1, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c2, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c3, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c4, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c5, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c6, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c7, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c8, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19c9, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19cc, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19cd, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19ce, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x19cf, 0x0010, PRE_FETCH_3 | CPRE | CMTLB },
> >>>>>> +       { 0x1c00, 0x0002, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1c01, 0x0000, PRE_FETCH_1 | CMTLB },
> >>>>>> +       { 0x1920, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1923, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1924, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1940, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1941, 0x0004, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1943, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1944, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +       { 0x1947, 0x0000, PRE_FETCH_2 | CPRE | CMTLB },
> >>>>>> +};
> >>>>>> +
> >>>>>>     static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>>>>>     {
> >>>>>>            return container_of(smmu, struct qcom_smmu, smmu);
> >>>>>> @@ -459,6 +523,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
> >>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
> >>>>>>     };
> >>>>>>
> >>>>>> +
> >>>>>> +static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >>>>>> +       .init_context = qcom_smmu_init_context,
> >>>>>> +       .cfg_probe = qcom_smmu_cfg_probe,
> >>>>>> +       .def_domain_type = qcom_smmu_def_domain_type,
> >>>>>> +       .reset = arm_mmu500_reset,
> >>>>>> +       .write_s2cr = qcom_smmu_write_s2cr,
> >>>>>> +       .tlb_sync = qcom_smmu_tlb_sync,
> >>>>>
> >>>>> What is the difference between this one and qcom_smmu_500_impl ?
> >>>>>
> >>>>
> >>>> Noted, will remove this and use qcom_smmu_500_impl instead.
> >>>> Thanks for pointing this out.
> >>>> Since inititally the reset ops was different to reset CPRE bit only for
> >>>> sm8550 SoC hence sm8550_smmu_500_impl is defined, but now default reset
> >>>> ops is modified to set CPRE bit for all SoCs ([PATCH v2 3/3]) so it
> >>>> should be fine to use qcom_smmu_500_impl as there's no difference now.
> >>>>
> >>>>>> +};
> >>>>>> +
> >>>>>>     static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
> >>>>>>            .init_context = qcom_adreno_smmu_init_context,
> >>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
> >>>>>> @@ -522,6 +596,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
> >>>>>>            .reg_offset = qcom_smmu_impl0_reg_offset,
> >>>>>>     };
> >>>>>>
> >>>>>> +static const struct actlr_config sm8550_actlrcfg = {
> >>>>>> +       .adata = sm8550_apps_actlr_data,
> >>>>>> +       .size = ARRAY_SIZE(sm8550_apps_actlr_data),
> >>>>>> +};
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
> >>>>>>      * there are not enough context banks.
> >>>>>> @@ -545,16 +624,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
> >>>>>>            /* Also no debug configuration. */
> >>>>>>     };
> >>>>>>
> >>>>>> +
> >>>>>> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> >>>>>> +       .impl = &sm8550_smmu_500_impl,
> >>>>>> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> >>>>>> +       .cfg = &qcom_smmu_impl0_cfg,
> >>>>>> +       .actlrcfg = &sm8550_actlrcfg,
> >>>>>> +};
> >>>>>> +
> >>>>>>     static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
> >>>>>>            .impl = &qcom_smmu_500_impl,
> >>>>>>            .adreno_impl = &qcom_adreno_smmu_500_impl,
> >>>>>>            .cfg = &qcom_smmu_impl0_cfg,
> >>>>>>     };
> >>>>>>
> >>>>>> -/*
> >>>>>> - * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
> >>>>>> - * special handling and can not be covered by the qcom,smmu-500 entry.
> >>>>>> - */
> >>>>>
> >>>>> NAK, leave this in place.
> >>>>>
> >>>>
> >>>> Ack, will address this in next version.
> >>>>
> >>>>>>     static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >>>>>>            { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
> >>>>>>            { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
> >>>>>> @@ -579,6 +662,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >>>>>>            { .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
> >>>>>>            { .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
> >>>>>>            { .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
> >>>>>> +       { .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
> >>>>>>            { .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
> >>>>>>            { }
> >>>>>>     };
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>>
> >>>>>
> >>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry
