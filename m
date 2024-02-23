Return-Path: <linux-kernel+bounces-77750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521A8609B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DD91F266AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A910971;
	Fri, 23 Feb 2024 04:05:32 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6945107B6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661132; cv=none; b=IOgsIL8aHzDkfAMtm5ohT/MtiPQzc+9UnKWxfm7SIyWFA1NoFF8MEgrBAqTe0KTSGbAdXwCWS1r0WtmvXmfJLXxgHzkGWnTPxVZAT+y+G7ndDw4sbHu/FNWZSnbydh6FAQm8ic6P+QD/35I5RPVxOwqWrac+tACG2HylFWqIogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661132; c=relaxed/simple;
	bh=ks0Rs58WJE7mCifr10cztbfqIM9cyzhVn/+zuSm5Ihg=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qd3YrVDx0xUxPWB04frZswoVS2eXK5leCko6izh4E0CGKIuBquJ34sitc9rjzpcImcF31cIWU/2KAIRDL5WxHCY1UNAykd67zUjouNN3CbkeWv6ZQeCHObue6RikiFHMivIHFyMC1k/kAt7A058hMyE/HM7VRJhOJDe4QwyWkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TgxFG5BsKz1X2sh;
	Fri, 23 Feb 2024 12:03:14 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 72D941A016B;
	Fri, 23 Feb 2024 12:05:25 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:05:25 +0800
Subject: Re: Re: [PATCH] drivers/perf: hisi: Enable HiSilicon Erratum
 162700402 quirk for UC PMU
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240207094245.34195-1-hejunhao3@huawei.com>
 <20240208105047.000023c7@Huawei.com>
CC: <will@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <2a6dde28-a74d-0992-3f9d-7346e36a0b9c@huawei.com>
Date: Fri, 23 Feb 2024 12:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208105047.000023c7@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)


On 2024/2/8 18:50, Jonathan Cameron wrote:
> On Wed, 7 Feb 2024 17:42:45 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>> HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
>> cannot be set due to the lack of clock under power saving mode. This will
>> lead to error or inaccurate counts. The clock can be enabled by the PMU
>> global enabling control.
>>
>> This patch tries to fix this by set the UC PMU enable before set event
>> period to turn on the clock, and then restore the UC PMU configuration.
>> The counter register can hold its value without a clock.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Hi.
>
> Some very minor comments about the comments inline.

Hi, Jonathan


Thanks for the comments.

>
> Jonathan
>
>> ---
>>   drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 40 ++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> index 636fb79647c8..8e7a9e1f419a 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> @@ -287,10 +287,48 @@ static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
>>   	return readq(uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>>   }
>>   
>> -static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
>> +static bool hisi_uc_pmu_get_glb_en_state(struct hisi_pmu *uc_pmu)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +	return !!FIELD_GET(HISI_UC_EVENT_GLB_EN, val);
>> +}
>> +
>> +static void hisi_uc_pmu_write_counter_quirk_hip09(struct hisi_pmu *uc_pmu,
>>   				      struct hw_perf_event *hwc, u64 val)
>>   {
>> +	bool enable = hisi_uc_pmu_get_glb_en_state(uc_pmu);
>> +
>> +	/* Set the UC PMU enable to turn on the clock. */
> Comment from below here but adjusted to say which path has the device
> already enabled.

This quirk function is simple. I'm going to consolidate all the comments
to annotate the quirk function.

Best regards,
Junhao.

>> +	if (!enable)
>> +		hisi_uc_pmu_start_counters(uc_pmu);
>> +
>>   	writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>> +
>> +	/*
>> +	 * The counter register can hold its value without a clock. We need
>> +	 * restore the UC PMU configuration. The irq handler will also call
>> +	 * the function to set period. At this time, PMU is still enabled and
>> +	 * we cannot directly disable the PMU.
> I think the comment is more relevant above...

Okay, I'm going to replace the comment with the following

        /*
         * Restore PMU enable status, the counter can hold its value
         * without a clock.
         */

>> +	 */
>> +	if (!enable)
>> +		hisi_uc_pmu_stop_counters(uc_pmu);
>> +}
>> +
>> +static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
>> +				      struct hw_perf_event *hwc, u64 val)
>> +{
>> +	/*
>> +	 * HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU
>> +	 * counter cannot be set due to the lack of clock under power saving
>> +	 * mode. This will lead to error or inaccurate counts. The clock can
>> +	 * be enabled by the PMU global enabling control.
> I'd move the comment to next to the quirk function so that people can immediately
> see what is being done.  Down here we just need to know there is a quirk.

I'd comment the quirk function.


>
>> +	 */
>> +	if (uc_pmu->identifier == HISI_PMU_V2)
>> +		hisi_uc_pmu_write_counter_quirk_hip09(uc_pmu, hwc, val);
>> +	else
>> +		writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>>   }
>>   
>>   static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,
>


