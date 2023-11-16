Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479557EDBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPGwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPGwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:52:12 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AB196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:52:08 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59b5484fbe6so4878777b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700117527; x=1700722327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oc5E6kIcla/Or4QU1XuvIaiW9BS0HQZyOIehNU3S8rI=;
        b=JKPA8XAzdAdGTJOuaT4K7qsHLB1F/NWQTD09BuxtbWnpcYajOZduXcgNWyCE8REp5Q
         V/0yxlsCnJnr1ACDz86vudGvbzhNYOGYTjPVxje9oFSoE05ZW777SwbA/uvNz1U270Db
         nkU8ygjZrPxdVYH7B2ep6LVYm5vn3TMWsiBltDhHwOtQObQKYMv2cvHRDfZKalbzjmmb
         9t/U9HdNY8PmOlKtJUBN4UDfXB0KGxUo9PixlyXxDd5arf+KUAPxtjeOv96NjiBRxxht
         fGm8icxjiVGA6ye+vWaMIweB71Yjs+wpXO95Y+UqRPCEtztBI82AC7aJeesIOq3j3+kG
         6YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700117527; x=1700722327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oc5E6kIcla/Or4QU1XuvIaiW9BS0HQZyOIehNU3S8rI=;
        b=NIUFwskb4qyWBXevi+sxpvum7SMZB8Wi1zY71+76HftLQ0Xqmi5f1C5RuGAyN/P3Cz
         sZLTmx+6c/3l9KspNfQS80zdFjbGL11GRJLRWsOUH6W6ey2l2EOwa5Fm/BFhgQyOHDeX
         59dIkwXVzp2iFAfEVVpl25USIarGBwjPLCFnhvQZ8O7wE21KHbnzJtuhT6ijfuHKF1+Y
         6wavAAaQCBSUvt6O7fSGMH4BrTotI6GRD8tLQyaPa43en6zD22h0yqy2bsHy7K3pL3+M
         sbH5zl5W1H1oOeoebvS85EJgeiG14WSVYcxhbQLxWGPR0cgwX2OATPzBOeechpRv0Qyo
         NmsQ==
X-Gm-Message-State: AOJu0YxZDMag1zTtPDg6YLqdgP8bRy9r5KDUN02QqYoHtY5+uNLSfPxl
        AiQtlH4bTAPGDchrqiQHpNiI2Y1lfrwfSq7DhJCOtw==
X-Google-Smtp-Source: AGHT+IF9xl+Hc9uyP+mSbdRq22l1klxH1FdSfYmdGQLsuU3qAhFB8KEVx7+2dM8/7H2WMf9mXaTnItbCGUXlosfWtoc=
X-Received: by 2002:a81:a549:0:b0:57a:cf8:5b4 with SMTP id v9-20020a81a549000000b0057a0cf805b4mr14384806ywg.51.1700117527207;
 Wed, 15 Nov 2023 22:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com> <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com> <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com> <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com> <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
 <61d2885a-50f9-419f-8473-10308baed493@quicinc.com>
In-Reply-To: <61d2885a-50f9-419f-8473-10308baed493@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 08:51:55 +0200
Message-ID: <CAA8EJpoTeonht4S5JkW=1VJmKsSFm5iCb_Tz-ZempaRufnjmHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 08:10, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/15/2023 10:12 PM, Konrad Dybcio wrote:
> >
> >
> > On 11/15/23 13:49, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
> >>> <quic_bibekkum@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
> >>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> >>>>>>> <quic_bibekkum@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>> Add ACTLR data table for SM8550 along with support for
> >>>>>>>> same including SM8550 specific implementation operations.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>>>>>> ---
> >>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92
> >>>>>>>> +++++++++++++++++++++-
> >>>>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
> >>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
> >>>>>>>>            u32 actlr;
> >>>>>>>>     };
> >>>>>>>>
> >>>>>>>> +#define PRE_FETCH_1    0
> >>>>>>>> +#define PRE_FETCH_2    BIT(8)
> >>>>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
> >>>>>>>
> >>>>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
> >>>>>>> PRE_FETCH_1? Are these real numbers that refer to some amount /
> >>>>>>> count
> >>>>>>> or just dummy names?
> >>>>>>>
> >>>>>>
> >>>>>> No,these are not real numbers, but prefetch settings for a particular
> >>>>>> perfect configuration.
> >>>>>
> >>>>> Then I'd ask for some better names or descriptions.
> >>>>>
> >>>>
> >>>> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
> >>>> in the following case. Would it be okay to use this name instead?
> >>>
> >>> Not really.
> >>>
> >>
> >> Any suggestion you have in mind, if not this nomenclature?
> > Dmitry's concern seems to be that you provide:
> >
> > PRE_FETCH_1 /* prefetcher with settings preset no. 1 */
> > PRE_FETCH_2 /* prefetcher with settings preset no. 2 */
> > PRE_FETCH_3 /* prefetcher with settings preset no. 3 */
> >
> > whereas it would be both useful and interesting to see what these
> > settings mean, i.e. what differences there are between all of
> > these presets.
> >
>
> Ah, okay got it now from Dimitry and yours' response.
> But we exactly won't be able to reveal what each of these settings
> mean, as this might risk of revealing IP as ACTLR bits are
> implementation defined (except CPRE and CMTLB) which other SoC vendors
> might be using it in different manner(or different purpose) in their
> downstream implementation.
> We can name it like (e.g PREFETCH_DISABLE, PREFETCH_SHALLOW,
> PREFETCH_DEEP) to indicate the behaviour, but won't be exactly
> name/describe it to explain what it does with a particular setting.

This is already better than 1,2,3.

-- 
With best wishes
Dmitry
