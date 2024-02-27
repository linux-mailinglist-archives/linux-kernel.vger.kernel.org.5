Return-Path: <linux-kernel+bounces-83760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FDC869E29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E662910DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4883F4EB52;
	Tue, 27 Feb 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t8wHXz7J"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E44EB42;
	Tue, 27 Feb 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055882; cv=none; b=pSaUmfYhV5pSGtgJATZZQJR/BRaGhZefFvabnEd8HTy2NwICJplDfGfvziAzQ9IY+HwQvpNK3qnz1badABuS2jdbpHjSxIOa8kXOOb1VKNf0m3sCJpqQXCUf6uAgSSw11FS9LcSfUPGznnLRGcw5r0y3zSFOKX2I1HTqzXnbIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055882; c=relaxed/simple;
	bh=ame3ZCr51pCTG5C3GNlDBXa0lWl9X7PzVbFXFol4bxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dibuuSPc9WxKQb5OOiNgEo9bZz5asktC/IC65AFkGTXGmnaEL9wHa0A2K5r3kqsmfF0NKtttJ8aHuE/aV3I/zFLOQDuyNIrpH+tuzy0q+iCxWRlU6+QaxxCm6YdLhIgCmmrGiZEdcflcPyHSmD8b0Ks+G+3kX2hoDDkLUZLd0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t8wHXz7J; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RBiEqx010578;
	Tue, 27 Feb 2024 18:44:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=3oOYn9fqHnn7M0RHDt/MS+nsrtMqc3evNHXVNyiPS6I=; b=t8
	wHXz7JeQAifMNDqULYAFgvvBqRSefIg1Q+++G0XBCCRWj14cOFGdNx+ZTFP9BE0v
	xvaT+D/6JVhp8FZtYrvJ0Pu+6dnWsfSw0O0CjVDdnxxP52Zh8YvfqGL4D5rh/7cT
	XAOfhA5jj7zbeU7pidLbIykB2HxeC7MuDnljTJzxazaepRS+BMJd59xhAyFNQ72R
	yHT6bOgdajSGD4uTvq17uF2OUmmpzAzQVs7PAu2tPij1iQs112vrpn/yBFencShs
	FAuFNZexoT4wyIbrpP0FLSULKaHGtI5KWLjzNB944+vLdDPzdMw0t8bfcAewGQZi
	uKBq+femeXIQS50unEbw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4cscsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:44:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 32F5340044;
	Tue, 27 Feb 2024 18:44:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 352E62ADF48;
	Tue, 27 Feb 2024 18:43:44 +0100 (CET)
Received: from [10.252.26.109] (10.252.26.109) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 18:43:43 +0100
Message-ID: <454f8d0f-9801-4caf-a1a6-737525ad947b@foss.st.com>
Date: Tue, 27 Feb 2024 18:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] counter: stm32-timer-cnt: add support for
 overflow events
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-10-fabrice.gasnier@foss.st.com>
 <ZZxidRueG8H/O7pw@ubuntu-server-vm-macos>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZZxidRueG8H/O7pw@ubuntu-server-vm-macos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02

On 1/8/24 22:00, William Breathitt Gray wrote:
> On Wed, Dec 20, 2023 at 03:57:25PM +0100, Fabrice Gasnier wrote:
>> Add support overflow events. Also add the related validation and
>> configuration routine. Register and enable interrupts to push events.
>> STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
>> lines. Request only the necessary interrupt, e.g. either global interrupt
>> that can report all event types, or update interrupt only for overflow
>> event.
>>
>> Acked-by: Lee Jones <lee@kernel.org>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Hi Fabrice,

Hi William,

Sorry for the late reply,

> 
> I've CC'd Will and Peter in case they can provide some suggestions
> regarding my atomic_t comment inline below.

I simply changed the type of nb_ovf below to u64, which better fits with
the API IMHO. Please check in v4.

> 
>> @@ -44,6 +45,9 @@ struct stm32_timer_cnt {
>>  	bool has_encoder;
>>  	u32 idx;
>>  	unsigned int nchannels;
>> +	unsigned int nr_irqs;
>> +	u32 *irq;
> 
> Looks like we only need this 'irq' array for registering the ISR in
> stm32_timer_cnt_probe(). Since we won't need it anymore after that,
> let's use ddata->irq directly instead of defining priv->irq.

Ack.

> 
>> +	atomic_t nb_ovf;
>>  };
>>  
>>  static const enum counter_function stm32_count_functions[] = {
>> @@ -259,6 +263,29 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
>>  	return regmap_write(priv->regmap, TIM_PSC, psc);
>>  }
>>  
>> +static int stm32_count_nb_ovf_read(struct counter_device *counter,
>> +				   struct counter_count *count, u64 *val)
>> +{
>> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>> +
>> +	*val = atomic_read(&priv->nb_ovf);
>> +
>> +	return 0;
>> +}
>> +
>> +static int stm32_count_nb_ovf_write(struct counter_device *counter,
>> +				    struct counter_count *count, u64 val)
>> +{
>> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>> +
>> +	if (val != (typeof(priv->nb_ovf.counter))val)
>> +		return -ERANGE;
>> +
>> +	atomic_set(&priv->nb_ovf, val);
> 
> So you want to check that the atomic_t 'nb_ovf' is able hold the value
> provided by the u64 'val'. My understanding is that atomic_t should be
> treated as an opaque type, so I don't think we should be accessing the
> 'counter' member directly for this test (interrupt-cnt does this but I
> believe it's wrong to do so).
> 
> I don't know if we have any existing way to check for the value range of
> an atomic_t (I don't see anything under include/linux/limits.h
> specifically for it). However, you do use atomic_set() which takes an
> int parameter, so perhaps we should compare against INT_MAX instead.

Ack. Moving nb_ovf to u64 in v4 should address all these concerns.

> 
>> +static int stm32_count_events_configure(struct counter_device *counter)
>> +{
>> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>> +	struct counter_event_node *event_node;
>> +	u32 val, dier = 0;
>> +
>> +	list_for_each_entry(event_node, &counter->events_list, l) {
>> +		switch (event_node->event) {
>> +		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
>> +			/* first clear possibly latched UIF before enabling */
>> +			regmap_read(priv->regmap, TIM_DIER, &val);
>> +			if (!(val & TIM_DIER_UIE))
> 
> You can eliminate 'val' and the regmap_read() line like this:
> 
>     if (!regmap_test_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE))

Ack. Thanks for suggesting.

> 
>> +				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
>> +			dier |= TIM_DIER_UIE;
>> +			break;
>> +		default:
>> +			/* should never reach this path */
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	regmap_write(priv->regmap, TIM_DIER, dier);
> 
> Do you want to overwrite TIM_DIER completely, or did you mean to set
> only TIM_DIER_UIE and preserve the rest of the register? If the latter,
> you could redefine 'dier' as a bool and do:
> 
>     regmap_update_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE, dier);
> 
> There is also a regmap_update_bits_check() available if you want to
> combine the UIF latch check with the update; but I don't know if that
> will work in this case because it looks like you want to clear the UIF
> latch before enabling.

As you've noticed, the subsequent patch answers this.
Still I added a comment above this line.

> 
>>  static int stm32_count_clk_get_freq(struct counter_device *counter,
>> @@ -418,6 +491,35 @@ static struct counter_count stm32_counts = {
>>  	.num_ext = ARRAY_SIZE(stm32_count_ext)
>>  };
>>  
>> +static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
>> +{
>> +	struct counter_device *counter = ptr;
>> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>> +	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
>> +	u32 sr, dier;
>> +
>> +	regmap_read(priv->regmap, TIM_SR, &sr);
>> +	regmap_read(priv->regmap, TIM_DIER, &dier);
>> +	/*
>> +	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
>> +	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
>> +	 */
>> +	dier &= TIM_DIER_UIE;
>> +	sr &= dier;
>> +
>> +	if (sr & TIM_SR_UIF) {
> 
> Am I understanding this logic correctly? ANDing TIM_DIER_UIE with 'dier'
> will result in just the state of the TIM_DIER_UIE bit. Next, we AND that
> state with 'sr'; so sr is 0 when TIM_DIER_UIE state is low, but we get
> the respective SR bit when TIM_DIER_UIE state is high. Finally, we check
> the TIM_SR_UIF bit state in 'sr'.

Same, next patch makes it more clear.

> 
> If TIM_SR_UIF bit position is expected to match the TIM_DIER_UIE bit
> position, then (sr & TIM_SR_UIF) will only be true when the state of
> both the TIM_DIER_UIE bit and TIM_SR_UIF bit are high. That means you
> can eliminate 'sr', 'dier', and the two regmap_read() operations with
> this instead:
> 
>     if (regmap_test_bits(priv->regmap, TIM_SR, TIM_SR_UIF) &&
>         regmap_test_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE) {
> 
>> +		atomic_inc(&priv->nb_ovf);
> 
> I wonder what happens when atomic_inc() increments past the atomic_t max
> value. Does atomic_read() report back a negative value? Do we need to
> guard against that scenario somehow?

Ack, nb_ovf moved to u64 in patch v4. So negative value shouldn't be an
issue. Thanks for pointing this.

> 
>> +		counter_push_event(counter, COUNTER_EVENT_OVERFLOW_UNDERFLOW, 0);
>> +		dev_dbg(counter->parent, "COUNTER_EVENT_OVERFLOW_UNDERFLOW\n");
>> +		/* SR flags can be cleared by writing 0, only clear relevant flag */
>> +		clr &= ~TIM_SR_UIF;
> 
> You can use u32p_replace_bits(&clr, 0, TIM_SR_UIF) instead after
> including the include/linux/bitfield.h header.

Thanks for suggesting. I tried this here, it seems fine. However, in
subsequent patch, doing the same change with TIM_SR_CC_IF(i) macro gives
a build error. To be consistent in between the 2 patchs, I prefer to
keep simple bit ops here.

> 
>> @@ -511,6 +615,32 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>>  
>>  	platform_set_drvdata(pdev, priv);
>>  
>> +	/* STM32 Timers can have either 1 global, or 4 dedicated interrupts (optional) */
>> +	if (priv->nr_irqs == 1) {
>> +		/* All events reported through the global interrupt */
>> +		ret = devm_request_irq(&pdev->dev, priv->irq[0], stm32_timer_cnt_isr,
>> +				       0, dev_name(dev), counter);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to request irq %d (err %d)\n",
>> +				priv->irq[i], ret);
> 
> This should be irq[0], right?

Yes.
> 
> I would also recommend using ddata->irq instead so we can get rid of
> priv->irq outside of this probe function.

Done.

Thanks for reviewing
BR,
Fabrice

> 
>> +			return ret;
>> +		}
>> +	} else {
>> +		for (i = 0; i < priv->nr_irqs; i++) {
>> +			/* Only take care of update IRQ for overflow events */
>> +			if (i != STM32_TIMERS_IRQ_UP)
>> +				continue;
>> +
>> +			ret = devm_request_irq(&pdev->dev, priv->irq[i], stm32_timer_cnt_isr,
>> +					       0, dev_name(dev), counter);
>> +			if (ret) {
>> +				dev_err(dev, "Failed to request irq %d (err %d)\n",
>> +					priv->irq[i], ret);
>> +				return ret;
>> +			}
>> +		}
> 
> So we only execute the loop body once for this particular
> STM32_TIMERS_IRQ_UP iteration? Why have the loop at all rather than
> hardcode irq[STM32_TIMERS_IRQ_UP] for devm_request_irq()?
> 
> William Breathitt Gray

