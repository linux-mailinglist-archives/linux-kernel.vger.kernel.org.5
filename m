Return-Path: <linux-kernel+bounces-83759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C18869E23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580A11F24DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2494C63D;
	Tue, 27 Feb 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GTW7VrNV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE262557F;
	Tue, 27 Feb 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055879; cv=none; b=o0jc+KvG9yIX1WEKHh5lsfgBD0YBsBtpG8YH4VPp0TMj8GPw+4vXkDmImxYXHPbxe+c9eti8+e45MbqKyJN/8CO483fDdCa+05ZeLRzZgpeZU+Q5cO18uXE93cpxnoxY06Gbk76z2sv85u86lG4sFJvd3vZDssfvMzEOcJsWKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055879; c=relaxed/simple;
	bh=kdp5O1cIEITIktgt384DfDxhL1geSIF8EMcBpT5bIc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ukwW0ZqLFRFBSqo8BUUHkAeKiY4Bro3ykohJ17tBl/0n97iiyKryloQIuTdTKtg+VRsRB/1j1jcXBsFWon/MpdJqbF9wSriekY4S9bekyGQuWdasHkBaq7eQFPihC3KZhWGG4lF1BM2N8VnNIokZBqTDf6dYFzyjwgEomWFLJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GTW7VrNV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBi3K0029671;
	Tue, 27 Feb 2024 18:44:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=ZKduf9VukNB9GBil78oMEdLFb1eDrPFu/obW2gUDxi8=; b=GT
	W7VrNVOHVlekUom1ghEc7syzR22wSOzNMR4KhEH6FnUfWVy3FAUsauLzn/u5LW8B
	qrYNf5siWD0a6Ya7l5iByf2o+DW2VqV+oHHyPCYZZd0V+DLjTDxBbVfmpkO0elSm
	OWrC0vVO4oLDpYbyX1foWxyZAlEEVVZh7ydyUFpsIZa0fE0X9woJbQEwBEuEF80x
	YowXwha/s2fdw30aFR8Z6mY8ccUNxKvayeK2YSzh1whgNgjj3aDukUsYk0EIoLkp
	SN7gOXNR1hCJj+hnOxE/yAKzFRc63cZ7I8DiNH30qRU3xqXlI4S1RIzPkUFbnHRt
	APtvf4GpWfarRqEzTc4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4b9dpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:44:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D992F4002D;
	Tue, 27 Feb 2024 18:44:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4474F2ADF56;
	Tue, 27 Feb 2024 18:43:52 +0100 (CET)
Received: from [10.252.26.109] (10.252.26.109) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:43:49 +0100
Message-ID: <09262390-388f-402f-99e6-ea6229107119@foss.st.com>
Date: Tue, 27 Feb 2024 18:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] counter: stm32-timer-cnt: add support for
 capture events
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-11-fabrice.gasnier@foss.st.com>
 <ZZxyDbYC9oHNKcGF@ubuntu-server-vm-macos>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZZxyDbYC9oHNKcGF@ubuntu-server-vm-macos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02

On 1/8/24 23:07, William Breathitt Gray wrote:
> On Wed, Dec 20, 2023 at 03:57:26PM +0100, Fabrice Gasnier wrote:
>> +	/*
>> +	 * configure channel in input capture mode, map channel 1 on TI1, channel2 on TI2...
>> +	 * Select both edges / non-inverted to trigger a capture.
>> +	 */
> 
> I suggest defining a new local variable 'cc' to point to stm32_cc[ch]. I
> think that's make the code look nicer here to avoid all the array index
> syntax every time you access stm32_cc[ch].

Hi William,

Thanks for suggesting.
Done.

> 
>> +	if (enable) {
>> +		/* first clear possibly latched capture flag upon enabling */
>> +		regmap_read(priv->regmap, TIM_CCER, &ccer);
>> +		if (!(ccer & stm32_cc[ch].ccer_bits)) {
> 
> Try regmap_test_bits() here instead of using regmap_read().

Done,

> 
>> +			sr = ~TIM_SR_CC_IF(ch);
>> +			regmap_write(priv->regmap, TIM_SR, sr);
> 
> Eliminate 'sr' by regmap_write(priv->regmap, TIM_SR, ~TIM_SR_CC_IF(ch)).
> 
>> @@ -366,6 +460,12 @@ static int stm32_count_events_configure(struct counter_device *counter)
>>  				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
>>  			dier |= TIM_DIER_UIE;
>>  			break;
>> +		case COUNTER_EVENT_CAPTURE:
>> +			ret = stm32_count_capture_configure(counter, event_node->channel, true);
>> +			if (ret)
>> +				return ret;
>> +			dier |= TIM_DIER_CC_IE(event_node->channel);
> 
> Ah, now I understand why the previous patch OR'd TIM_DIER_UIE to dier.
> Apologies for the noise.
> 
>> @@ -374,6 +474,15 @@ static int stm32_count_events_configure(struct counter_device *counter)
>>  
>>  	regmap_write(priv->regmap, TIM_DIER, dier);
>>  
>> +	/* check for disabled capture events */
>> +	for (i = 0 ; i < priv->nchannels; i++) {
>> +		if (!(dier & TIM_DIER_CC_IE(i))) {
>> +			ret = stm32_count_capture_configure(counter, i, false);
>> +			if (ret)
>> +				return ret;
>> +		}
> 
> Would for_each_clear_bitrange() in linux/find.h work for this loop?

I had a look, but it requires to add some variables, for start and stop
bit in the bitmap. For now, I've kept the simple BIT macro and bit ops.

> 
>> @@ -504,7 +620,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
>>  	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
>>  	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
>>  	 */
>> -	dier &= TIM_DIER_UIE;
>> +	dier &= (TIM_DIER_UIE | TIM_DIER_CC1IE | TIM_DIER_CC2IE | TIM_DIER_CC3IE | TIM_DIER_CC4IE);
> 
> Again, sorry for the noise on the previous patch; this makes sense now.
> 
>> @@ -515,6 +631,15 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
>>  		clr &= ~TIM_SR_UIF;
>>  	}
>>  
>> +	/* Check capture events */
>> +	for (i = 0 ; i < priv->nchannels; i++) {
>> +		if (sr & TIM_SR_CC_IF(i)) {
> 
> Would for_each_set_bitrange() in linux/find.h work for this loop?

same.

> 
>> +			counter_push_event(counter, COUNTER_EVENT_CAPTURE, i);
>> +			clr &= ~TIM_SR_CC_IF(i);
> 
> Perhaps u32p_replace_bits(&clr, 0, TIM_SR_CC_IF(i)) is clearer here.

I've hit some build issue with TIM_SR_CC_IF(i) macro, e.g.:
/include/linux/bitfield.h:165:17: error: call to ‘__bad_mask’ declared
with attribute error: bad bitfield mask
  165 |                 __bad_mask();

So I've kept the simple bit operation here.

Thanks & Best Regards,
Fabrice

> 
>> @@ -627,8 +752,11 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>>  		}
>>  	} else {
>>  		for (i = 0; i < priv->nr_irqs; i++) {
>> -			/* Only take care of update IRQ for overflow events */
>> -			if (i != STM32_TIMERS_IRQ_UP)
>> +			/*
>> +			 * Only take care of update IRQ for overflow events, and cc for
>> +			 * capture events.
>> +			 */
>> +			if (i != STM32_TIMERS_IRQ_UP && i != STM32_TIMERS_IRQ_CC)
>>  				continue;
> 
> Okay, I see now why you have this check. This should be fine as it'll
> makes adding support in the future for the other IRQs a less invasive
> change.
> 
> William Breathitt Gray

