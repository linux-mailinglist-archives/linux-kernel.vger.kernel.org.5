Return-Path: <linux-kernel+bounces-108543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A5880C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB81F23DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C72209F;
	Wed, 20 Mar 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q1cBSxYK"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284722F0D;
	Wed, 20 Mar 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919876; cv=none; b=c4oGtv477w3mbJqRT5/ux/Cw9so/onwquMpRY0jsvDdEvCPdfFHs0pducLjAdXmvUDQOA6z2jkUU2Vw96xfDxBIGwoq/W7p4icAJipyuIe7/VaOXHxS9lUN+CJMmyqvj0fMTO+p3kFlViOw6WKrWUPWwjQOaKynlMj5sA3tooUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919876; c=relaxed/simple;
	bh=Ik5ahjZmxjfQ1FR/v6ZDPMYWeeijut/xAT0hg7CxjZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRq1t4efoQhAssGahkeYiv/rwk9IARHR5V0SMlk/8ZX2cHvrd+FTS9yPS1ANv4+DH2JemN9/nXn1Tq8cKtQk3Wr9DqbdVgnNskBWk9EmXRWVwFZbf0he06HMEjc7+SzX0pa+9eEqEgXpJkphgjrhl+bi64DGuXTROuCDgSSf4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q1cBSxYK; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68F241BF20A;
	Wed, 20 Mar 2024 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710919871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voBe4cnKC0PYia7ms5iUQbaUgT546itFPRtdPkNE1ao=;
	b=Q1cBSxYKQaIltFJkiNRkwe6YV7E7uUhmWbptRl2p/i0RABaEw6LCltBs36y+/AFubbLIoI
	Gm2n0LiHp+5jjpd7Ux+FiS6cQfihpFUlZuH5uqTXDDmejoDNW7Hpg8ku5vt7sfsVzszS2C
	HMOZ2ydoyDCJT6i8PqzsNXNMe27Y6ArMipnHj7rDltqswrI48QRV4v716Ay18bxoAkzimR
	uwKKDIkLQtJ/DDeNbbAsHpAJEFXACx1sRL6UePnwjfqnQWoT3NMwHx6ocx8grfkdymdzfE
	VFWAH2+u8OLiNA8UfJIbY6iTIrolrARnTn8ZBx+owPUttl1KIXsf1lN13sIPeA==
Message-ID: <f2d8715d-a1ad-45a4-952f-a702b29740be@bootlin.com>
Date: Wed, 20 Mar 2024 08:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ASoC: ti: davinci-i2s: Add TDM support
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-8-bastien.curutchet@bootlin.com>
 <9d123584-1feb-404b-890f-2da694cf56d5@gmail.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <9d123584-1feb-404b-890f-2da694cf56d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,

>> +static int davinci_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
>> +				    unsigned int tx_mask,
>> +				    unsigned int rx_mask,
>> +				    int slots, int slot_width)
>> +{
>> +	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> +	dev_dbg(dev->dev, "%s - slots %d, slot_width %d\n", __func__, slots, slot_width);
> 
> The __func__ can be ommited, it is better to leave it for dynamic
> debugging by adding "dyndbg=+pmf" module parameter if needed.
> 

True, I'll remove the __func__.

>> +
>> +	if (slots > 128 || !slots) {
>> +		dev_err(dev->dev, "Invalid number of slots\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (rx_mask != (1 << slots) - 1) {
>> +		dev_err(dev->dev, "Invalid RX mask (0x%08x) : all slots must be used by McBSP\n",
>> +			rx_mask);
>> +		return -EINVAL;
> 
> This is only a restriction for RX?
> 

Nope you're right, I'll add the same for tx_mask.

>> +	}
>> +
>> +	if (davinci_i2s_tdm_word_length(slot_width) < 0) {
>> +		dev_err(dev->dev, "%s: Unsupported slot_width %d\n", __func__, slot_width);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev->tdm_slots = slots;
>> +	dev->slot_width = slot_width;
>> +
>> +	return 0;
>> +}
>> +
>>   #define DEFAULT_BITPERSAMPLE	16
>>   
>>   static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>> @@ -228,6 +282,13 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>>   		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
>>   
>>   	dev->fmt = fmt;
>> +
>> +	if ((dev->tdm_slots || dev->slot_width) &&
>> +	    ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_BP_FC)) {
>> +		dev_err(dev->dev, "TDM is only supported for BP_FC format\n");
>> +		return -EINVAL;
> 
> I think this is not a valid statement, Fsync can be generated internally
> or coming from external source in TDM mode also.
> 

My hardware allow me to only test BP_FC so I wished to put some
'barriers' in front of untested things.


Best regards,
Bastien

