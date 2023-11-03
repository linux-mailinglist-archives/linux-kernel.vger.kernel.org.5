Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833F7E0B35
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjKCWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjKCWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:41:45 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76437D61
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:41:42 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d84c24a810dso2619141276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699051301; x=1699656101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C7wKTbP4+PWwal1QTdQ2ITkf1D6U26LSd6WF4wGwDWo=;
        b=LgtHktBiyonqC/Z4x0gt3r4M4w3vdQuFBAoEwQ5aigokXBFIWCi6C3x5DKTqCE6wWx
         eI40/2jWMI8bt7SuvjCDcC3ADd2HRMH/AARwJ5cVmL513cFgkYTQDx61+vKJXYSSkPHB
         a5fiXoYS4l3UuJMEkG6aSZyn2Cn+eQ8ZG21xO6D2D7uy2PIlJRtFZl8QI0kEk4mlNma3
         5m9Le2XixxZG8khvsMTX9DmPy5cPm1Ss3jJujW0f0DOjHL3BZrI5ouHI7AtHJGk1qqFq
         6ZGJ74sh+1CpSnKWqwMeN+OPj6g+YT4YeoRF9QI6Ssf9H9afH06kfhOCmAtD5DsLhlmh
         +hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699051301; x=1699656101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7wKTbP4+PWwal1QTdQ2ITkf1D6U26LSd6WF4wGwDWo=;
        b=k7Bcoea8YmeSzIZZr9yq7TFajQo8/zNp9AYWL4XHzbhrLfMQtk6FXo821scfu37jUg
         ytTlecw4zVzRRxw3PcdnT959Yejy5IdowDhlKetTG4jxn3EWvZ3WORZ6GlmmVRKL0se/
         R94UDBlOorI9A5GuUO4S22+dzDnXl6B01HUBfw5oTzTQJB+1IbqLJUF2x6x3yD7HRlIn
         07kDgfuQjlokJjZaN/oDbuKv+TONgolBcb+1j6xsOLHef0ZP9oMJ2zijwAj0ouRQDZu5
         f/TRN7sutzt3Ov92BLYZNf5na14/nd8XPIcJ7gVnVYe6RsFAQbocvq1uBfdCH+kfFg7Q
         3rKQ==
X-Gm-Message-State: AOJu0Yy5Ga+TQ+h4xSAjALh1ER4qHKROidjwGi0Jo7e8+YZ8oIKCRb1C
        TZsD76zFOjCOb++v54AypUJGo6bv+6aw/dIckah4TA==
X-Google-Smtp-Source: AGHT+IE+HalO1qHEQzWIgF0nkD0hqU8oc0TI/ojoKfl4qVPsqPLMVyEFpuVCeJmalwiE9wY6RjT2FkOnHVdyUwkKtIQ=
X-Received: by 2002:a25:5097:0:b0:d9a:5aa0:7a30 with SMTP id
 e145-20020a255097000000b00d9a5aa07a30mr19651404ybb.39.1699051301614; Fri, 03
 Nov 2023 15:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-3-quic_bibekkum@quicinc.com> <CAA8EJpqWdHwF_mZoXt8wpYeKLWQEFs3H83c-OsLVYVGYmi5mkQ@mail.gmail.com>
 <fff5184b-3bf6-4f40-b99f-e77c01342fcc@quicinc.com>
In-Reply-To: <fff5184b-3bf6-4f40-b99f-e77c01342fcc@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 4 Nov 2023 00:41:30 +0200
Message-ID: <CAA8EJprkO=XZ=4na-JAKDsoKOxLt_AG42HQ4JTVNTZ2BSu8YdQ@mail.gmail.com>
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

On Sat, 4 Nov 2023 at 00:38, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/4/2023 3:31 AM, Dmitry Baryshkov wrote:
> > On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Add ACTLR data table for SM8550 along with support for
> >> same including SM8550 specific implementation operations.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
> >>   1 file changed, 81 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 68c1f4908473..590b7c285299 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -25,6 +25,64 @@ struct actlr_data {
> >>          u32 actlr;
> >>   };
> >>
> >> +static const struct actlr_data sm8550_apps_actlr_data[] = {
> >> +       { 0x18a0, 0x0000, 0x00000103 },
> >> +       { 0x18e0, 0x0000, 0x00000103 },
> >> +       { 0x0800, 0x0020, 0x00000001 },
> >> +       { 0x1800, 0x00c0, 0x00000001 },
> >> +       { 0x1820, 0x0000, 0x00000001 },
> >> +       { 0x1860, 0x0000, 0x00000001 },
> >> +       { 0x0c01, 0x0020, 0x00000303 },
> >> +       { 0x0c02, 0x0020, 0x00000303 },
> >> +       { 0x0c03, 0x0020, 0x00000303 },
> >> +       { 0x0c04, 0x0020, 0x00000303 },
> >> +       { 0x0c05, 0x0020, 0x00000303 },
> >> +       { 0x0c06, 0x0020, 0x00000303 },
> >> +       { 0x0c07, 0x0020, 0x00000303 },
> >> +       { 0x0c08, 0x0020, 0x00000303 },
> >> +       { 0x0c09, 0x0020, 0x00000303 },
> >> +       { 0x0c0c, 0x0020, 0x00000303 },
> >> +       { 0x0c0d, 0x0020, 0x00000303 },
> >> +       { 0x0c0e, 0x0020, 0x00000303 },
> >> +       { 0x0c0f, 0x0020, 0x00000303 },
> >> +       { 0x1961, 0x0000, 0x00000303 },
> >> +       { 0x1962, 0x0000, 0x00000303 },
> >> +       { 0x1963, 0x0000, 0x00000303 },
> >> +       { 0x1964, 0x0000, 0x00000303 },
> >> +       { 0x1965, 0x0000, 0x00000303 },
> >> +       { 0x1966, 0x0000, 0x00000303 },
> >> +       { 0x1967, 0x0000, 0x00000303 },
> >> +       { 0x1968, 0x0000, 0x00000303 },
> >> +       { 0x1969, 0x0000, 0x00000303 },
> >> +       { 0x196c, 0x0000, 0x00000303 },
> >> +       { 0x196d, 0x0000, 0x00000303 },
> >> +       { 0x196e, 0x0000, 0x00000303 },
> >> +       { 0x196f, 0x0000, 0x00000303 },
> >> +       { 0x19c1, 0x0010, 0x00000303 },
> >> +       { 0x19c2, 0x0010, 0x00000303 },
> >> +       { 0x19c3, 0x0010, 0x00000303 },
> >> +       { 0x19c4, 0x0010, 0x00000303 },
> >> +       { 0x19c5, 0x0010, 0x00000303 },
> >> +       { 0x19c6, 0x0010, 0x00000303 },
> >> +       { 0x19c7, 0x0010, 0x00000303 },
> >> +       { 0x19c8, 0x0010, 0x00000303 },
> >> +       { 0x19c9, 0x0010, 0x00000303 },
> >> +       { 0x19cc, 0x0010, 0x00000303 },
> >> +       { 0x19cd, 0x0010, 0x00000303 },
> >> +       { 0x19ce, 0x0010, 0x00000303 },
> >> +       { 0x19cf, 0x0010, 0x00000303 },
> >> +       { 0x1c00, 0x0002, 0x00000103 },
> >> +       { 0x1c01, 0x0000, 0x00000001 },
> >> +       { 0x1920, 0x0000, 0x00000103 },
> >> +       { 0x1923, 0x0000, 0x00000103 },
> >> +       { 0x1924, 0x0000, 0x00000103 },
> >> +       { 0x1940, 0x0000, 0x00000103 },
> >> +       { 0x1941, 0x0004, 0x00000103 },
> >> +       { 0x1943, 0x0000, 0x00000103 },
> >> +       { 0x1944, 0x0000, 0x00000103 },
> >> +       { 0x1947, 0x0000, 0x00000103 },
> >> +};
> >
> > This is nearly impossible to handle.
> > Please add defines for 0x1, 0x103 and 0x303. Also please consider
> > adding comments for the devices.
> >
>
> Ack, Initially added the comments for devices, but since only driver is
> handling this data, and clients won't refer this so removed it. Will
> consider adding it back.

It will help developers / porters who will try matching the SID and the device.

>  This actlr field value might different (other
> than 0x1,0x103,0x303) in other platforms as per my anticipation,
> depending on the bit settings, so won't the defines change with
> different platforms? Hence this register setting value might be apt?

It is simple. 0x1, 0x103 and 0x303 are pure magic values. Please
provide sensible defines so that we can understand and review them.

Other platforms might use new defines.

>
> >> +
> >>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> >>   {
> >>          return container_of(smmu, struct qcom_smmu, smmu);
> >> @@ -444,6 +502,16 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >>
> >> +
> >> +static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >> +       .init_context = qcom_smmu_init_context,
> >> +       .cfg_probe = qcom_smmu_cfg_probe,
> >> +       .def_domain_type = qcom_smmu_def_domain_type,
> >> +       .reset = arm_mmu500_reset,
> >> +       .write_s2cr = qcom_smmu_write_s2cr,
> >> +       .tlb_sync = qcom_smmu_tlb_sync,
> >> +};
> >> +
> >>   static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
> >>          .init_context = qcom_adreno_smmu_init_context,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> @@ -507,6 +575,11 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
> >>          .reg_offset = qcom_smmu_impl0_reg_offset,
> >>   };
> >>
> >> +static const struct actlr_config sm8550_actlrcfg = {
> >> +       .adata = sm8550_apps_actlr_data,
> >> +       .size = ARRAY_SIZE(sm8550_apps_actlr_data),
> >> +};
> >> +
> >>   /*
> >>    * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
> >>    * there are not enough context banks.
> >> @@ -530,16 +603,20 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
> >>          /* Also no debug configuration. */
> >>   };
> >>
> >> +
> >> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
> >> +       .impl = &sm8550_smmu_500_impl,
> >> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> >> +       .cfg = &qcom_smmu_impl0_cfg,
> >> +       .actlrcfg = &sm8550_actlrcfg,
> >> +};
> >
> > This structure doesn't seem to be linked. Did you test your patches?
> >
>
> Apologies Dmitry, just checked back my patches, I tested it but while
> refining the patches I somehow missed this link
> { .compatible = "qcom,sm8550-smmu-500", .data =
> &sm8550_smmu_500_impl0_data };
> in below qcom_smmu_500_impl0_data structure.
> I will take care of this in next version.
>
> >> +
> >>   static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
> >>          .impl = &qcom_smmu_500_impl,
> >>          .adreno_impl = &qcom_adreno_smmu_500_impl,
> >>          .cfg = &qcom_smmu_impl0_cfg,
> >>   };
> >>
> >> -/*
> >> - * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
> >> - * special handling and can not be covered by the qcom,smmu-500 entry.
> >> - */
> >
> > Leave the comment in place.
> >
>
> Thanks for this comment which helped me to note the above mentioned
> mistake.
>
> >>   static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >>          { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
> >>          { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
With best wishes
Dmitry
