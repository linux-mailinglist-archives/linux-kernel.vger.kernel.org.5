Return-Path: <linux-kernel+bounces-146949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B38A6D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FC1F220B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E00E12D775;
	Tue, 16 Apr 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jj2pxoSk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88412D219;
	Tue, 16 Apr 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276568; cv=none; b=YcbfuKCSd8NeKWg+WTR1TdUvp1xy74bSfmVtiz+lDTOrbuQu02/MNfvnVkYJJNKoJrKtnWktGgj0GKP5dUxi6sKY3nF0n8Y/qEEX8tQ1tTMgfuiRfbdzV3sTOa+cieKqlBxZ/jzK7UnnKJ5hBdeuJnhhmVaEHsavsJPGb7cWYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276568; c=relaxed/simple;
	bh=xl5IPlI4/tfZkMhTro5AZJ5MrQh47xHxKI0qjQASmg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjVx5jSXSA4hs6q3ZB2iK3BrhpXt6zImeKZ3mr6j+D+Rig5GAOVIpOTCPg3ALufUEO1WV8aA5l0pdy3FSPtsDO/TUJNYWZ1ijqbk+fTrkv9EAnohtqLkaJhI6VedSc/AstI0PASTQODToNP8Ikwth6lI/JOAeZh3OVLhHTxkRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jj2pxoSk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713276567; x=1744812567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xl5IPlI4/tfZkMhTro5AZJ5MrQh47xHxKI0qjQASmg4=;
  b=jj2pxoSkSaJGYmjYF1jgqvS/9iIQ8MwvmLKZ4+/A+78E8ILqaLvoLXp+
   u46iXDSk6OIwUBeXid3HCsiE0xnzdPRzG2b0OOBOLw9v2QDMnKsUZfu88
   G0RVhFi2wFsjEUtkJW5r4DVioEMiWv0ic0/40Wc29IG0ItMYZ7b1AGnfD
   E6Q2bdu7Yx/5MCu6znJuRnSohex+JFi68+CJfQxvhWzO9d6B/Z57Vb67r
   8q2JZ+2HVrmj1sgScckAg9ez3QyPyD0T4BGj/i8tZjmUAYJnlLmTuBp/O
   YUj96O961DVgoOMMJBqNIV2mZNciAUy8ya7njK6I6rtVfJxrBeuvuke90
   Q==;
X-CSE-ConnectionGUID: G9/ymOaUT6WzS2/IZGABvg==
X-CSE-MsgGUID: c+jtJor0R4GzhmRSsXQrJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9268335"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="9268335"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:09:26 -0700
X-CSE-ConnectionGUID: D37ivQksQBauF6ebrBBz0w==
X-CSE-MsgGUID: 8CvRz0DHSZOhm7rXWB9uyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22333136"
Received: from sekosto-mobl.amr.corp.intel.com (HELO [10.213.183.148]) ([10.213.183.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:09:25 -0700
Message-ID: <35d9f59e-3cc1-41a7-bb1d-f482c004d323@linux.intel.com>
Date: Tue, 16 Apr 2024 08:51:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDIvMl0gQVNvQzogY2RuczogQWRk?=
 =?UTF-8?Q?_drivers_of_Cadence_Multi-Channel_I2S_Controller?=
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
 <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
 <NTZPR01MB0956BFADB4B3DA507D938F669F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <ef510647-c409-4da6-9cd4-ff4e54cbee74@linux.intel.com>
 <NTZPR01MB09567BE742A91B8C9E02EF4F9F08A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <NTZPR01MB09567BE742A91B8C9E02EF4F9F08A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/24 02:23, Xingyu Wu wrote:
> On 02/04/2024 21:57, Pierre-Louis Bossart wrote:
>>
>>
>>>>
>>>>> +#define PERIODS_MIN		2
>>>>> +
>>>>> +static unsigned int cdns_i2s_pcm_tx(struct cdns_i2s_dev *dev,
>>>>> +				    struct snd_pcm_runtime *runtime,
>>>>> +				    unsigned int tx_ptr, bool *period_elapsed,
>>>>> +				    snd_pcm_format_t format)
>>>>> +{
>>>>> +	unsigned int period_pos = tx_ptr % runtime->period_size;
>>>>
>>>> not following what the modulo is for, usually it's modulo the buffer size?
>>>
>>> This is to see if the new data is divisible by period_size and to
>>> determine whether it is enough for a period_size in the later loop.
>>
>> That didn't answer to my question, the position is usually between
>> 0..buffer_size.1.
> 
> Yes, this position will be used later in the cdns_i2s_pcm_pointer().
> But this cdns_i2s_pcm_tx() is called by I2S hardware interrupt which
> would be frequently called several times each period. The period_pos
> is used to determine whether there is enough a period_size to call
> snd_pcm_period_elapsed().
> 
>>
>> Doing increments on a modulo value then comparisons as done below seems
>> rather questionable.
>>
>>>>> +
>>>>> +		iowrite32(data[0], dev->base + CDNS_FIFO_MEM);
>>>>> +		iowrite32(data[1], dev->base + CDNS_FIFO_MEM);
>>>>> +		period_pos++;
>>>>> +		if (++tx_ptr >= runtime->buffer_size)
>>>>> +			tx_ptr = 0;
>>>>> +	}
>>>>> +
>>>>> +	*period_elapsed = period_pos >= runtime->period_size;
>>>>> +	return tx_ptr;
>>>>> +}
>>
>>>>> +	pm_runtime_enable(&pdev->dev);
>>>>> +	if (pm_runtime_enabled(&pdev->dev))
>>>>> +		cdns_i2s_runtime_suspend(&pdev->dev);
>>>>
>>>> that sequence looks suspicious.... Why would you suspend immediately
>>>> during the probe? You're probably missing all the autosuspend stuff?
>>>
>>> Since I have enabled clocks before, and the device is in the suspend
>>> state after pm_runtime_enable(), I need to disable clocks in
>>> cdns_i2s_runtime_suspend() to match the suspend state.
>>
>> That is very odd on two counts
>> a) if you haven't enabled the clocks, why do you need to disbale them?
>> b) if you do a pm_runtime_enable(), then the branch if
>> (pm_runtime_enabled) is always true.
>>
> 
> a) It must enable clocks first to read and write registers when I2S probe.
> Then it is done to probe, the clocks are still enabled and the state of pm
> is suspend. So it need to be disabled to match the state and will resume
> and be enabled by ALSA.

I think you are missing a pm_runtime_set_active() to reconcile the pm
state with the hardware state. The premise of pm_runtime is that on
probe your device is active and later on it will suspend. Having
pm_runtime_enabled with a suspended device without the framework
involved to trigger the transition to suspend is asking for trouble.

> b) Because CONFIG_PM would be disabled and pm_runtime_enabled()
> return false , then it is no need to disable clock and I2S still can work.

Again you are trying to make things more complicated than they need to
be. Don't try to actively manage and query states, let the framework do
it for you.

Try to probe and bring the device to an active state. Then use
pm_runtime_mark_last_busy(), use pm_runtime_enable and let autosuspend
do the work for you. If pm_runtime is not enabled the suspend will not
happen.

Also keep in mind that pm_runtime_enabled() will return false if the
user mucks with the power state in sysfs, it's not only a case of
CONFIG_PM being selected or not.
> 
>>
>>>
>>>>
>>>>> +
>>>>> +	dev_dbg(&pdev->dev, "I2S supports %d stereo channels with %s.\n",
>>>>> +		i2s->max_channels, ((i2s->irq < 0) ? "dma" : "interrupt"));
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err:
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int cdns_i2s_remove(struct platform_device *pdev) {
>>>>> +	pm_runtime_disable(&pdev->dev);
>>>>> +	if (!pm_runtime_status_suspended(&pdev->dev))
>>>>> +		cdns_i2s_runtime_suspend(&pdev->dev);
>>>>
>>>> ... and this one too. Once you've disabled pm_runtime, checking the
>>>> status is irrelevant...
>>>
>>> I think the clocks need to be always enabled after probe if disable
>>> pm_runtime, and should be disabled when remove. This will do that.
>>
>> if you are disabling pm_runtime, then the pm_runtime state becames invalid.
>> When pm_runtime_disable() is added in remove operations, it's mainly to
>> prevent the device from suspending.
> 
> Should I use the pm_runtime_enabled() before the pm_runtime_disable()?

It doesn't matter, the problem is the second part where you try to check
the status of pm_runtime *after* disabling it.



