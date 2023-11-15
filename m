Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029E7EC8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjKOQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjKOQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:42:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A018E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:42:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a0907896so9808603e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700066522; x=1700671322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5FiyfL45nK0ILrQvVCbcGAZ+fU64odztAJCZA6s8wQ=;
        b=w8JTp+Q55DB8fIErRIQl66qzDKUi8oR0HOplYEqwpzXkFZGGSsLeS2SSxAv9yYiweT
         fZVIbHq7i9UR3e+9tya5DSmUayK5QEp8kkTIkQD6biYq4L4SzRG3bTIEsnhkMtLnFlaI
         q6bbnOvhEgQ1RYQxZVhUMbDCQC0b7pVi2kyM9fWz7v+NUwdE1H0xk5SjC2DejRzsVVG1
         AX4ggUTB4IRvNe034wjRUP8vXAOOlCN+S+Mow7jK/QhC/+ZbACekgduWoBUJst8kCcnK
         dx6aKD/Pog7O8hnrGbSxUfGt/Rk9Vo6rRbKCf81RT5f1sGBHeY7MpT42H7Ff2arprLWf
         Lddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066522; x=1700671322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5FiyfL45nK0ILrQvVCbcGAZ+fU64odztAJCZA6s8wQ=;
        b=n+tq+ORqbkDdP9v+9csqwSF4bMUJ7zJDSL40YV0ku/EHEWKFcJ3mofJAjzwi7LLsHH
         6Ex1O6NIGELi7pYq6zNncPB46f5VJvY6Z26jkqwC4KeoogwgoeVBYBLEyfE1HDaBV3UN
         GOsBq7HwJpfoE/yy9lnAVqTl3fACxfCsr5gRCRHA1pCeOVKgrAnoWrt5V3LK61jQJp1k
         GKOE50ww/u985gLYlUUCnHJ+eHlt8AXAzS+SLl06MRqDS2V9W8zIgOIPqF96d1R+6V8L
         qKazaS4h6UU3uNfqQq51v1B1YS7ZmH/Im80oT94BVe6dM3exPvOnvnHGBB9smnV2t3Dn
         LAjw==
X-Gm-Message-State: AOJu0YzgNL/LQSwvPFbQkOT9w52K4v9b1X693D2X1mKbig6/fNniF/r3
        C9iKxRDGsO6gH7rQAnZXX7BYEg==
X-Google-Smtp-Source: AGHT+IFWMZo39Dt217xz3YvNvg1OMFxweVuoh5j1w9Sgi0b6RPHP9gLOt/PkYJVEHjLB5ztGS8bf8Q==
X-Received: by 2002:a05:6512:234d:b0:508:268b:b087 with SMTP id p13-20020a056512234d00b00508268bb087mr11812039lfu.26.1700066522540;
        Wed, 15 Nov 2023 08:42:02 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d27-20020a19385b000000b0050a026d3a26sm1705739lfj.227.2023.11.15.08.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:42:01 -0800 (PST)
Message-ID: <be9675a6-a01e-4cf7-95b3-174220d4a042@linaro.org>
Date:   Wed, 15 Nov 2023 17:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-3-quic_bibekkum@quicinc.com>
 <CAA8EJpr1NzqiuNVZ0YcLpJ=yeOYFbLouAFgN9VMOiKpmoGVdtQ@mail.gmail.com>
 <7edad996-f148-42d5-8e72-0334d3b9101f@quicinc.com>
 <CAA8EJpqzEvC-LEjJrOk6Ed8utFNnqgP=qkb0mq-dOfMZd5ij4Q@mail.gmail.com>
 <dba223a1-0456-40b8-b295-ea960867dcf9@quicinc.com>
 <CAA8EJpqvXb_Zdmq0O0KEA8mn5UkSriCZ02w16dts7Gd84R30oQ@mail.gmail.com>
 <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <aebdf7f6-48b7-43d3-95af-83859ddc593f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 13:49, Bibek Kumar Patro wrote:
> 
> 
> On 11/15/2023 4:15 PM, Dmitry Baryshkov wrote:
>> On Wed, 15 Nov 2023 at 11:51, Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 11/15/2023 3:08 PM, Dmitry Baryshkov wrote:
>>>> On Wed, 15 Nov 2023 at 11:22, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/14/2023 7:42 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>
>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 +++++++++++++++++++++-
>>>>>>>     1 file changed, 88 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index 578c662c7c30..0eaf6f2a2e49 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -25,6 +25,70 @@ struct actlr_data {
>>>>>>>            u32 actlr;
>>>>>>>     };
>>>>>>>
>>>>>>> +#define PRE_FETCH_1    0
>>>>>>> +#define PRE_FETCH_2    BIT(8)
>>>>>>> +#define PRE_FETCH_3    (BIT(9) | BIT(8))
>>>>>>
>>>>>> What is the difference between PRE_FETCH_3 and PRE_FETCH_2? And
>>>>>> PRE_FETCH_1? Are these real numbers that refer to some amount / count
>>>>>> or just dummy names?
>>>>>>
>>>>>
>>>>> No,these are not real numbers, but prefetch settings for a particular
>>>>> perfect configuration.
>>>>
>>>> Then I'd ask for some better names or descriptions.
>>>>
>>>
>>> Noted, PREFETCH_SETTING_n / PREFETCH_OPTION_n sounds like a better name
>>> in the following case. Would it be okay to use this name instead?
>>
>> Not really.
>>
> 
> Any suggestion you have in mind, if not this nomenclature?
Dmitry's concern seems to be that you provide:

PRE_FETCH_1 /* prefetcher with settings preset no. 1 */
PRE_FETCH_2 /* prefetcher with settings preset no. 2 */
PRE_FETCH_3 /* prefetcher with settings preset no. 3 */

whereas it would be both useful and interesting to see what these
settings mean, i.e. what differences there are between all of
these presets.

Konrad
