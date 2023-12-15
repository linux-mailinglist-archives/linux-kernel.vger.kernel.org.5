Return-Path: <linux-kernel+bounces-1407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B5814E89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7533BB2421D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5C82EDA;
	Fri, 15 Dec 2023 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fwWY7QMm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890A82EC9;
	Fri, 15 Dec 2023 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BFEfQZm028431;
	Fri, 15 Dec 2023 18:13:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=EmFNRv3LoVGaci59g9h+fN2FkreeIA99LXaRAwQkDis=; b=fw
	WY7QMm9y2J9BqlZgw1Gjtb+o+dYxNk+k6LUcHD2rb6emZrVf8VKPuuCVpdYheO7e
	+Am366SCNznJJ8AwW84KBgnd4IU9J9KAF5FS99iPkqDXveQo5MYzy4j1aUdhu0oJ
	C+Fl5TncBsTXJRrK3pB+IEbsLL+RtNC7/oaxlrLZZcL4omd1Rh8GXoojLht/6mgH
	r1r4wcZDi7HNxj5dWKNJcMyIsIjEqZFFZl30vdCluRgPvlf/C3HaB0q8I8cVyEEW
	iEGG7j9eftlHB5c3kqLKpJyd8VhCTmjGArGaqp1Hp7wcSXLZPzJ32rquIgHKyfzk
	x/0DMfPfilFvHpq9eBZg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmu8pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 18:13:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BE69100052;
	Fri, 15 Dec 2023 18:13:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11CD823BE1E;
	Fri, 15 Dec 2023 18:13:53 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 18:13:52 +0100
Message-ID: <997c056e-c4e1-4bd8-9fcd-9f1b4bd45929@foss.st.com>
Date: Fri, 15 Dec 2023 18:13:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] counter: stm32-timer-cnt: populate capture
 channels and check encoder
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
 <20230922143920.3144249-6-fabrice.gasnier@foss.st.com>
 <ZSnJR2yfYsBNHu/4@fedora>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZSnJR2yfYsBNHu/4@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02

On 10/14/23 00:48, William Breathitt Gray wrote:
> On Fri, Sep 22, 2023 at 04:39:19PM +0200, Fabrice Gasnier wrote:
>> This is a precursor patch to support capture channels on all possible
>> channels and stm32 timer types. Original driver was intended to be used
>> only as quadrature encoder and simple counter on internal clock.
>>
>> So, add ch3 and ch4 definition. Also add a check on encoder capability,
>> so the driver may be probed for timer instances without encoder feature.
>> This way, all timers may be used as simple counter on internal clock,
>> starting from here.
> 
> Hi Fabrice,
> 
> Let's split the encoder capability probing code, detect number of
> channels code, and channel introduction code to their own patches in
> order to simplify things.
> 
>> Encoder capability is retrieved by using the timer index (originally in
>> stm32-timer-trigger driver and dt-bindings). The need to keep backward
>> compatibility with existing device tree lead to parse aside trigger node.
>> Add diversity as STM32 timers with capture feature may have either 4, 2,
>> 1 or no cc (capture/compare) channels.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> I think this patch is more complicated than it needs to be.
> 
>> @@ -400,13 +558,47 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>>  	priv->clk = ddata->clk;
>>  	priv->max_arr = ddata->max_arr;
>>  
>> +	ret = stm32_timer_cnt_probe_encoder(pdev, priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	stm32_timer_cnt_detect_channels(pdev, priv);
>> +
>>  	counter->name = dev_name(dev);
>>  	counter->parent = dev;
>>  	counter->ops = &stm32_timer_cnt_ops;
>> -	counter->counts = &stm32_counts;
>>  	counter->num_counts = 1;
>> -	counter->signals = stm32_signals;
>> -	counter->num_signals = ARRAY_SIZE(stm32_signals);
> 
> Keep this the same.
> 
>> +
>> +	/*
>> +	 * Handle diversity for stm32 timers features. For now encoder is found with
>> +	 * advanced timers or gp timers with 4 channels. Timers with less channels
>> +	 * doesn't support encoder.
>> +	 */
>> +	switch (priv->nchannels) {
>> +	case 4:
>> +		if (priv->has_encoder)
>> +			counter->counts = &stm32_counts_enc_4ch;
>> +		else
>> +			counter->counts = &stm32_counts_4ch;
>> +		counter->signals = stm32_signals;
>> +		counter->num_signals = ARRAY_SIZE(stm32_signals);
>> +		break;
>> +	case 2:
>> +		counter->counts = &stm32_counts_2ch;
>> +		counter->signals = stm32_signals;
>> +		counter->num_signals = 3; /* clock, ch1 and ch2 */
>> +		break;
>> +	case 1:
>> +		counter->counts = &stm32_counts_1ch;
>> +		counter->signals = stm32_signals;
>> +		counter->num_signals = 2; /* clock, ch1 */
>> +		break;
>> +	default:
>> +		counter->counts = &stm32_counts;
>> +		counter->signals = stm32_signals;
>> +		counter->num_signals = 1; /* clock */
>> +		break;
>> +	}
> 
> Rather than adjusting the number of counts and signals, keep the
> configuration static and use a single stm32_counts array. The reason is
> that in the Counter subsystem paradigm Signals do not necessary
> correlate to specific hardware signals but are rather an abstract
> representation of the device behavior at a high level. In other words, a
> Synapse with an action mode set to COUNTER_SYNAPSE_ACTION_NONE can be
> viewed as representing a Signal that does not affect the Count (i.e. in
> this case equivalent to an unconnected line).
> 
> What you'll need to do instead is check priv->nchannels during
> stm32_action_read and stm32_count_function_read calls in order to return
> the correct synapse action and count function for the particular
> channels configuration you have. In stm32_count_function_write you would
> return an -EINVAL (maybe -EOPNOTSUPP would be better?) when the channels
> configuration does not support a particular count function.

Hi William,

Sorry for the long delay to address your comments here. Many thanks for
these guidelines.

I'm preparing a v3, to address these. I'll probably send it soon, so we
can start to review also the capture part of it. Still there are few
things here I'm wondering about (as an anticipation task).

Basically, removing all the diversity here means the most featured timer
model will be represented here (with all possible signals).
When I wrote the various configuration arrays, I'd have been tempted to
allocate them dynamically upon probing to avoid having all these
variants described as const arrays. This may have eased other signals
additions later. But that's not the direction. So, this simplifies the
description here, clearly, to describe the full-featured timer/counter,
and handle the ("unconnected") variants by returning errors.

I still have in mind the replacement of the last IIO_COUNT device [1]
(not addressed in this series), e.g. in
drivers/iio/trigger/stm32-timer-trigger.c. Here, there are
"valids_table" that are used to cascade two timers (one timer output
being the input to another timer). With this table currently, an IIO
user knows the name of the signal it selects (then the driver looks up
the 'valids' table to set SMCR / TS bits, e.g. trigger select). Each
individual timer has a different input mapping, so called peripheral
interconnect in STM32.
What bothers me here is: with an abstracted full-featured timer, without
any diversity on the signal names, I fear the userland has no clue on
which signal would be used. Abstracting the timer this way would mean
the user only knows it selects "Internal Trigger 0" for example, without
knowing which internal signal in the SoC it has selected.

Even if this is out of scope for this series, would you have some clue
so I can anticipate it ? Or if we stick with abstract names? In which
case the userland may need to be aware of the signals mapping (where
currently in IIO_COUNT driver, the signal names are privided). I'd be
glad to get some direction here.

Please advise,
Best Regards,
Fabrice

[1] https://lore.kernel.org/linux-arm-kernel/Y0vzlOmFrVCQVXMq@fedora/

> 
> William Breathitt Gray

