Return-Path: <linux-kernel+bounces-5024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E42818578
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15483287061
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E514AA9;
	Tue, 19 Dec 2023 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlvQAZDK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371714AA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e74b4d5445so11527497b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702982656; x=1703587456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UhHMpNMfgbUMAhgoV28Lk3mFhziVxmC13GCk6Yqzxho=;
        b=FlvQAZDK2NGKqimF0d69b+vwqXwxF37k7NQZVMXpvKINr5W+oK+8bjWKhcCvHmrDHk
         En+7MvXISxLLkhlx7SzkC4qGW1lPLub0kYiUh8icMUE1mtfF8+uIibE2194ztrY5/rNa
         a2h+p6yMfjvx8DjPN48J0YlTUsArQ3A8msIzSccBB/cHte1aXJKb/OyRVl3QKmb9NVqR
         BY+KPneB9cK+4WH5Fcxtv7q+G5YgN4+iK1t3nwywEtSjJrwyY4mwtu5tnpYL+EhBD9YQ
         iOguKWpCVWmSDX/FvVprE8xcPcbC7HUmqnOX0PlNAyTAw1IKPYXlAGbXU9Eju6CERIAR
         VxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702982656; x=1703587456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhHMpNMfgbUMAhgoV28Lk3mFhziVxmC13GCk6Yqzxho=;
        b=ZEqO9N2MZ5rf+J4BX+t++fwYUcdMD1BrVaTcHjQLy2lC1V5uG9cedYyacN27I9m6Lq
         NrUXClOuzwn4Rkn05hI8kT9GgLTlEzsq6ZrPh0ofXyTpa6G54ltY2tUmlmKzm7ok5nHz
         Z/XOnkdTMZ6SgWf7e0KFhWia18inyiwSuLkdLiuHJ67cTGu8xWxnC1RoOPYw631l6F2M
         WMhSYdCEdNOSVQ/T5IMWcngV4sSRi9NVUgmx4YTRFQTNfX3PRLccfoC7V0/c3DdpabuG
         m2hl9Gym+P4NDSUIa/1oOwjiMuU0uB10WE+0nrvd8M6XWt23Uj+/SbJtLwLGOQzJuiE6
         mJXg==
X-Gm-Message-State: AOJu0Yze9o4fermH181GffOv8xAOKV4pW6fWqIB662vykzpLvBrw1eJa
	zT2AkNZCVloXdHiP/qp0TNmfuJY/X3sKYPlH/PmK0fV6t1uEhczC
X-Google-Smtp-Source: AGHT+IHTaEa7kOE3mg3Gh8oLBjIrqCu+lelBOtWFUHxSSfSOL8LGAFgO8agvUeI5nMN6QbzwB2QB/ReQX8tMrnZPcfw=
X-Received: by 2002:a25:d408:0:b0:dbc:fe47:36df with SMTP id
 m8-20020a25d408000000b00dbcfe4736dfmr4029713ybf.22.1702982655984; Tue, 19 Dec
 2023 02:44:15 -0800 (PST)
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
 <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com> <CAA8EJpoMwrwQ9wBZE6AcobLLkCchFtN23SnHhw3enNOfX3CzTQ@mail.gmail.com>
 <334bc814-07d2-4966-93e3-f2cfbabc15b2@quicinc.com>
In-Reply-To: <334bc814-07d2-4966-93e3-f2cfbabc15b2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:44:04 +0200
Message-ID: <CAA8EJprL8pHQyWcdHiS+GReJsTMrddL=SCgkPhePR_7HvsQpsQ@mail.gmail.com>
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

On Tue, 19 Dec 2023 at 12:37, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 12/19/2023 3:51 PM, Dmitry Baryshkov wrote:
> > On Tue, 19 Dec 2023 at 10:25, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/18/2023 7:51 PM, Dmitry Baryshkov wrote:
> >>> On 18/12/2023 13:23, Bibek Kumar Patro wrote:
> >>>>
> >>>>
> >>>> On 12/16/2023 9:45 PM, Dmitry Baryshkov wrote:
> >>>>> On 16/12/2023 02:03, Konrad Dybcio wrote:
> >>>>>> On 15.12.2023 13:54, Robin Murphy wrote:
> >>>>>>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
> >>>>>>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
> >>>>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>>>>>> same including SM8550 specific implementation operations.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>>>> ---
> >>>>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89
> >>>>>>>>>> ++++++++++++++++++++++
> >>>>>>>>>>     1 file changed, 89 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>> index cb49291f5233..d2006f610243 100644
> >>>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
> >>>>>>>>>>            u32 actlr;
> >>>>>>>>>>     };
> >>>>>>>>>>
> >>>>>>>>>> +/*
> >>>>>>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching
> >>>>>>>>>> in the
> >>>>>>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the
> >>>>>>>>>> prefetch
> >>>>>>>>>> + * buffer). The remaining bits are implementation defined and
> >>>>>>>>>> vary across
> >>>>>>>>>> + * SoCs.
> >>>>>>>>>> + */
> >>>>>>>>>> +
> >>>>>>>>>> +#define PREFETCH_DEFAULT       0
> >>>>>>>>>> +#define PREFETCH_SHALLOW       BIT(8)
> >>>>>>>>>> +#define PREFETCH_MODERATE      BIT(9)
> >>>>>>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
> >>>>>>>>>
> >>>>>>>>> I thin the following might be more correct:
> >>>>>>>>>
> >>>>>>>>> #include <linux/bitfield.h>
> >>>>>>>>>
> >>>>>>>>> #define PREFETCH_MASK GENMASK(9, 8)
> >>>>>>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
> >>>>>>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
> >>>>>>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
> >>>>>>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ack, thanks for this suggestion. Let me try this out using
> >>>>>>>> GENMASK. Once tested, will take care of this in next version.
> >>>>>>>
> >>>>>>> FWIW the more typical usage would be to just define the named
> >>>>>>> macros for the raw field values, then put the FIELD_PREP() at the
> >>>>>>> point of use. However in this case that's liable to get pretty
> >>>>>>> verbose, so although I'm usually a fan of bitfield.h, the most
> >>>>>>> readable option here might actually be to stick with simpler
> >>>>>>> definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really
> >>>>>>> a big deal either way, and I defer to whatever Dmitry and Konrad
> >>>>>>> prefer, since they're the ones looking after arm-smmu-qcom the most :)
> >>>>>> My 5 cents would be to just use the "common" style of doing this, so:
> >>>>>>
> >>>>>> #define ACTRL_PREFETCH    GENMASK(9, 8)
> >>>>>>    #define PREFETCH_DEFAULT 0
> >>>>>>    #define PREFETCH_SHALLOW 1
> >>>>>>    #define PREFETCH_MODERATE 2
> >>>>>>    #define PREFETCH_DEEP 3
> >>>>>>
> >>>>>> and then use
> >>>>>>
> >>>>>> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
> >>>>>>
> >>>>>> it can get verbose, but.. arguably that's good, since you really want
> >>>>>> to make sure the right bits are set here
> >>>>>
> >>>>> Sounds good to me.
> >>>>>
> >>>>
> >>>> Konrad, Dimitry, just checked FIELD_PREP() implementation
> >>>>
> >>>> #define FIELD_FIT(_mask, _val)
> >>>> ({                                                              \
> >>>>                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \
> >>>>                    ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); \
> >>>> })
> >>>>
> >>>> since it is defined as a block, it won't be possible to use FIELD_PREP
> >>>> in macro or as a structure value, and can only be used inside a
> >>>> block/function. Orelse would show compilation errors as following
> >>>>
> >>>> kernel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:94:20: note: in
> >>>> expansion of macro 'PREFETCH_SHALLOW'
> >>>>     { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>>                       ^
> >>>> kernel/include/linux/bitfield.h:113:2: error: braced-group within
> >>>> expression allowed only inside a function
> >>>>     ({        \
> >>>>     ^
> >>>>
> >>>> So as per my understanding I think, we might need to go ahead with the
> >>>> generic implementation only. Let me know if I missed something.
> >>>
> >>> Then anyway (foo << bar) is better compared to BIT(n) | BIT(m).
> >>>
> >>
> >> Sure Dmitry, (foo << bar) would be simpler as well as Robin mentioned
> >> earlier in his reply.
> >> I can implement the defines as:
> >>
> >> #define PREFETCH_DEFAULT       0
> >> #define PREFETCH_SHALLOW       (1 << 8)
> >> #define PREFETCH_MODERATE      (1 << 9)
> >
> > 2 << 8. Isn't that hard.
> >
>
> Ah, right. This is nice! .
> Will use 2 << 8 instead. Thanks for the suggestion.

It might still be useful to define the PREFETCH_SHIFT equal to 8.

>
> Thanks,
> Bibek
>
> >> #define PREFETCH_DEEP          (3 << 8)
> >>
> >> This should be okay I think ?
> >>
> >> Thanks,
> >> Bibek
> >>
> >
> >



-- 
With best wishes
Dmitry

