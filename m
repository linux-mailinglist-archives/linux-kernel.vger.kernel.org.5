Return-Path: <linux-kernel+bounces-5011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E54818540
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F42B1F226FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA414A81;
	Tue, 19 Dec 2023 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gN4ljEoZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02E14A98
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e7db780574so2002277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702981330; x=1703586130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWtv0nvouCX5fIsmZ0v0oxZW/THrMx3EmTdh8M6/xgA=;
        b=gN4ljEoZAbB06gJ/52s08hzejsx1gG8TSUfD9FSqvMrcjDXT293NyaEQ/yw1p/cIo7
         f098Z0rIfNm6kleOtNCMlqgK+BTMHtrJ7RUULdvv4DVGHCyPn27zMYNTESVhygfkJDca
         IirkJGPuqKsj7DnLl333n8FpUBxS3SvWFRtmbU6rNQJ1FalkUg2BkY9M1mAujK7y/D9z
         eu+iuHRYq378VVM90keAA1n4VSJloxxMl1TJmqH7TOJAsCjz2MAnDWK25iTFIgDSE4gk
         An4IF//3Up6cDPhV9oCUCKa3dqmDS2R2t3RUd8eanksEAEsNO9kfO9sLeMaytFWtrvqM
         IJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981330; x=1703586130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWtv0nvouCX5fIsmZ0v0oxZW/THrMx3EmTdh8M6/xgA=;
        b=S5pn7+6ybp598DXtK8EIgjAV4DNnZOdCvjM70Sira1TV+j9TTKwFLvgpECTl+sDVn1
         wHxdB/ysj2Dn9q4mf75yCZtJZX6DTU3tz5g/nOqnz9DhFU/55m9Rv0JQSJhugYlrUDz6
         bEofF/25u2kRoxt6jB2KdOaNLyzi/om3YEWcKWnrOGoCroRSe0WCgBDABByccx4eUIZy
         yq0X5gHn3RicM+wKfRIk8Vm/MfxZKIc0rlhbPIC5aVqs3f3RQdA9oXeFwirhYYSbl8Ol
         eHwoMU4vcPNX+nJSYshTUYLaMNCflnX6FwfNqHVjKCyvwQyGfHKyZI5QbUkQqfiowNVE
         UrXw==
X-Gm-Message-State: AOJu0Yw9aPCdC68yaHUl79fiTZ4huq81tGRpC4ALyY4I7698vKhisCMC
	9mfK4u4RNEpYWSxlbvK56F1t2PLuAlTfER7qQCgxSg==
X-Google-Smtp-Source: AGHT+IFhpDdAZ1lxMc9AEtbpDAW0YBFm8qR1mzenXUm1MTWc17RrIWYgD0L/pXRE448LohDI8TSYdryTZupOBG6uO14=
X-Received: by 2002:a81:62d5:0:b0:5e4:d68a:310 with SMTP id
 w204-20020a8162d5000000b005e4d68a0310mr481678ywb.36.1702981329841; Tue, 19
 Dec 2023 02:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com> <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
 <c9493c5f-ccf8-4e21-b00c-5fbc2a5f2edb@quicinc.com> <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
 <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org> <42d627af-164b-4b50-973e-fa71d86cb84c@linaro.org>
 <aa8b2ccd-33da-404b-9a93-3d88cf63ec77@quicinc.com> <8338db1e-0216-4fc5-b6ab-ddf43adf3648@linaro.org>
 <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com>
In-Reply-To: <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:21:58 +0200
Message-ID: <CAA8EJpoMwrwQ9wBZE6AcobLLkCchFtN23SnHhw3enNOfX3CzTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Robin Murphy <robin.murphy@arm.com>, will@kernel.org, 
	joro@8bytes.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 10:25, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 12/18/2023 7:51 PM, Dmitry Baryshkov wrote:
> > On 18/12/2023 13:23, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 12/16/2023 9:45 PM, Dmitry Baryshkov wrote:
> >>> On 16/12/2023 02:03, Konrad Dybcio wrote:
> >>>> On 15.12.2023 13:54, Robin Murphy wrote:
> >>>>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
> >>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>>>> same including SM8550 specific implementation operations.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89
> >>>>>>>> ++++++++++++++++++++++
> >>>>>>>>    1 file changed, 89 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> index cb49291f5233..d2006f610243 100644
> >>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
> >>>>>>>>           u32 actlr;
> >>>>>>>>    };
> >>>>>>>>
> >>>>>>>> +/*
> >>>>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching
> >>>>>>>> in the
> >>>>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the
> >>>>>>>> prefetch
> >>>>>>>> + * buffer). The remaining bits are implementation defined and
> >>>>>>>> vary across
> >>>>>>>> + * SoCs.
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#define PREFETCH_DEFAULT       0
> >>>>>>>> +#define PREFETCH_SHALLOW       BIT(8)
> >>>>>>>> +#define PREFETCH_MODERATE      BIT(9)
> >>>>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
> >>>>>>>
> >>>>>>> I thin the following might be more correct:
> >>>>>>>
> >>>>>>> #include <linux/bitfield.h>
> >>>>>>>
> >>>>>>> #define PREFETCH_MASK GENMASK(9, 8)
> >>>>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
> >>>>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
> >>>>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
> >>>>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
> >>>>>>>
> >>>>>>
> >>>>>> Ack, thanks for this suggestion. Let me try this out using
> >>>>>> GENMASK. Once tested, will take care of this in next version.
> >>>>>
> >>>>> FWIW the more typical usage would be to just define the named
> >>>>> macros for the raw field values, then put the FIELD_PREP() at the
> >>>>> point of use. However in this case that's liable to get pretty
> >>>>> verbose, so although I'm usually a fan of bitfield.h, the most
> >>>>> readable option here might actually be to stick with simpler
> >>>>> definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really
> >>>>> a big deal either way, and I defer to whatever Dmitry and Konrad
> >>>>> prefer, since they're the ones looking after arm-smmu-qcom the most :)
> >>>> My 5 cents would be to just use the "common" style of doing this, so:
> >>>>
> >>>> #define ACTRL_PREFETCH    GENMASK(9, 8)
> >>>>   #define PREFETCH_DEFAULT 0
> >>>>   #define PREFETCH_SHALLOW 1
> >>>>   #define PREFETCH_MODERATE 2
> >>>>   #define PREFETCH_DEEP 3
> >>>>
> >>>> and then use
> >>>>
> >>>> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
> >>>>
> >>>> it can get verbose, but.. arguably that's good, since you really want
> >>>> to make sure the right bits are set here
> >>>
> >>> Sounds good to me.
> >>>
> >>
> >> Konrad, Dimitry, just checked FIELD_PREP() implementation
> >>
> >> #define FIELD_FIT(_mask, _val)
> >> ({                                                              \
> >>                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \
> >>                   ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); \
> >> })
> >>
> >> since it is defined as a block, it won't be possible to use FIELD_PREP
> >> in macro or as a structure value, and can only be used inside a
> >> block/function. Orelse would show compilation errors as following
> >>
> >> kernel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:94:20: note: in
> >> expansion of macro 'PREFETCH_SHALLOW'
> >>    { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>                      ^
> >> kernel/include/linux/bitfield.h:113:2: error: braced-group within
> >> expression allowed only inside a function
> >>    ({        \
> >>    ^
> >>
> >> So as per my understanding I think, we might need to go ahead with the
> >> generic implementation only. Let me know if I missed something.
> >
> > Then anyway (foo << bar) is better compared to BIT(n) | BIT(m).
> >
>
> Sure Dmitry, (foo << bar) would be simpler as well as Robin mentioned
> earlier in his reply.
> I can implement the defines as:
>
> #define PREFETCH_DEFAULT       0
> #define PREFETCH_SHALLOW       (1 << 8)
> #define PREFETCH_MODERATE      (1 << 9)

2 << 8. Isn't that hard.

> #define PREFETCH_DEEP          (3 << 8)
>
> This should be okay I think ?
>
> Thanks,
> Bibek
>


-- 
With best wishes
Dmitry

