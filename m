Return-Path: <linux-kernel+bounces-24537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E282BE03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E85EB249AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21D57864;
	Fri, 12 Jan 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5GRtRoC"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0557328
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so7212124e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705053683; x=1705658483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6BjmcfWjZQ9/+4cG+gO0wA5RcUkVwPj/srDhWTeVkw=;
        b=V5GRtRoCbV0UdeRaGPrx1hssWP2IkGtm9X1OiS3/2BfzJMH6EhsC5hhpdx/VDg7zVq
         enTu9Xzt7ckmL2JByPXWkGtbDufp0k8zlFi6iV6CAJs5q2CTACYMD98AmpwhMOxHrq7Q
         NMB2SPKznzpwer5TpjobKdso3u5JjHw6CuIyAROv40j4/LVhgBp9f5gwvN6mcep8HIsN
         tQeWdNwzuK+NpP9baoVTNp5ZkcCRz73ZrARumsZk0vyc0AqNqJFqolxGCfqQ7U9skz5u
         9C+0eskPZ273MO57LY3VRO3XLJpeq5MO9FopY/rB4OMEDDTrmwiACcgtIuHQnu+6CSoE
         7kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053683; x=1705658483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BjmcfWjZQ9/+4cG+gO0wA5RcUkVwPj/srDhWTeVkw=;
        b=rI6LQkgK/MCpE0WH6Ip4zo9+FIlf79sSSbVrBph4LgGxHiGNRchip/YAMKbAF8hIq5
         gUhv9mM9+Up+UDABgTLLBfj5x856Wk34U+FOJA0bH6fKUCa8aU1XK9KRYT4j0CtT8meQ
         jEyDIpQCJ+rDhbd7D2tRY5WOs5Vjy/uF8t5KaaLaC9vznlyEaz7iz1WwoTLxxUMz1Yq7
         jw6jYRdGE2585QzwUWGbZuj/FXTZxKx37SXryhGn9VmFJYq/s/4+axpyI7lf+yV+zBR1
         0Kj851EXzKTfVpJfzZ0beFoazDVZBYlSTqN/u+mqWOljJPqr+Pfneappq5PzvLiZ3Ceo
         SmVQ==
X-Gm-Message-State: AOJu0Ywxtl4oLwoMFTqGRLs135UQLNKwyQnDaJMSDteA3deKxeSr62yn
	7n1FSXeXXP8fWsMXDsH+s9Rbt5HLTjVIHg==
X-Google-Smtp-Source: AGHT+IFdf6AxtBCMz972hyGa8aRUo2uXDlIRk0LRgwUwwY0TdQHup04VCkl99x6SMm/BPp1uDhJs3g==
X-Received: by 2002:a2e:8007:0:b0:2cd:63e4:75ff with SMTP id j7-20020a2e8007000000b002cd63e475ffmr517106ljg.35.1705053682887;
        Fri, 12 Jan 2024 02:01:22 -0800 (PST)
Received: from [172.30.204.205] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x7-20020a2e9c87000000b002cd0435c50bsm407024lji.72.2024.01.12.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 02:01:22 -0800 (PST)
Message-ID: <babd9514-6202-486f-a7c5-51ad793aaca6@linaro.org>
Date: Fri, 12 Jan 2024 11:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 dmitry.baryshkov@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com,
 mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
 <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
 <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
 <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org>
 <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/24 19:09, Bibek Kumar Patro wrote:
> 
> 
> On 1/10/2024 11:26 PM, Konrad Dybcio wrote:
>>
>>
>> On 1/10/24 13:55, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
>>>
>>> [...]
>>>
>>>>>> @@ -274,6 +321,21 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>>>   {
>>>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>>>> +    const struct actlr_variant *actlrvar;
>>>>>> +    int cbndx = smmu_domain->cfg.cbndx;
>>>>>> +
>>>>>> +    if (qsmmu->data->actlrvar) {
>>>>>> +        actlrvar = qsmmu->data->actlrvar;
>>>>>> +        for (; actlrvar->io_start; actlrvar++) {
>>>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
>>>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>>>>> +                break;
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
>>>>> the same. Possible to do some refactoring?
>>>>>
>>>>
>>>> I will check if this repeated blocks can be accomodated this into qcom_smmu_set_actlr function if that would be fine.
>>>>
>>>
>>> Also adding to this, this might increase the number of indentation inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
>>> be an issue?
>>
>> By the way, we can refactor this:
>>
>> if (qsmmu->data->actlrvar) {
>>      actlrvar = qsmmu->data->actlrvar;
>>      for (; actlrvar->io_start; actlrvar++) {
>>          if (actlrvar->io_start == smmu->ioaddr) {
>>              qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>              break;
>>          }
>>      }
>> }
>>
>> into
>>
>> // add const u8 num_actlrcfgs to struct actrl_variant to
>> // save on sentinel space:
>> //   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)
>>
> 
> Git it, Would it be better to add this in struct qcom_smmu_match_data ?

Yes, right.

> Posted a sample below.
> 
>>
>> [declarations]
>> const struct actlr_variant *actlrvar = qsmmu->data->actlrvar;
>> int i;
>>
>> [rest of the functions]
>>
>> if (!actlrvar)
>>      return 0;
>>  > for (i = 0; i < actrlvar->num_actrlcfgs; i++) {
>>      if (actlrvar[i].io_start == smmu->ioaddr) {
>>          qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>>          break;
>>      }
>> }
>>  > Saving both on .TEXT size and indentation levels :)
>>
> Thanks for this suggestion Konrad, will try to implement this, as it would reduce the indent levels to good extent.
> Would something like this be okay?
> 
> static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>       const struct actlr_variant *actlrvar;
>       int cbndx = smmu_domain->cfg.cbndx;
> +    int i;
> 
> +    actlrvar = qsmmu->data->actlrvar;
> +
> +    if (!actlrvar)
> +        goto end;
> +
> +    for (i = 0; i < qsmmu->data->num_smmu ; i++) {
> +        if (actlrvar[i].io_start == smmu->ioaddr) {
> +            qcom_smmu_set_actlr(dev, smmu, cbndx,
> +                        actlrvar[i].actlrcfg);
> +            break;
>           }
>       }
> 
> +end:
>       smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

If you move this assignment before the actlrvar checking (there's no
dependency between them), you will get rid of the goto.

I also noticed that qcom_smmu_match_data.actlrvar could likely be
const struct actlr_variant * const (const pointer to a const
resource), similarly for actlr_variant.actlrcfg

Konrad

