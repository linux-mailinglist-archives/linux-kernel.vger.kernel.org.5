Return-Path: <linux-kernel+bounces-111172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD578868B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B293B1C220D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70021A286;
	Fri, 22 Mar 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yo8VsMbD"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A518057;
	Fri, 22 Mar 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097938; cv=none; b=LQNpljS7wIolvz6+xwEOsyU/4H+j9SvbbmxiCOAd0QXdQqyzYxl1EfFtAAjp3ejqGY8iolNuE6rASIuLxkjGMUpz4tj8svJ/WHOskuBNAKmN7mUDEZan8knvxXxdU+0D1Wzp9gvPucH6g4h7iC73rLGCd7mqiWd+1YMGOWZEOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097938; c=relaxed/simple;
	bh=P0dr0dBCvvvUpslvPwKlG6vn+eNquMJf7JhYBVBNQQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUXMs6i0qiPZFErGxdPksvabWVoKJzrywYd772HfGM83w8FvrUnh4+EVCS2RI2JT9gdcfQb55lOLFF2/wBS+3A3/tGoCEfRkchmV+R1fSdD7eWiLZghuRJeFkB2dulyOSk9Y1od11Qb/k8n/XpVs9bnGJRsE+DfunA2nyXZ3xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yo8VsMbD; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32255FF807;
	Fri, 22 Mar 2024 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711097934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/uxx5AdFXNV6za9HAZhGhTPRrtGXUVryUFqmL6/+ic=;
	b=Yo8VsMbDGjdd/vpgx8agJbI6GMKOf/aAiUzJqOH05A/UxeYb0EdRvZ6bR7TGTVa5Sj3c4E
	JbRrqP9lz61Fzh9YZAlk5lBWWv2e/8eoDOtQDnCGZ8BK+lzTP/5gaymkYvzhY1Lsb+AUUJ
	vL12A2FJdmkYaZQYmYKu187UJ0qhck87rmYMjW2yF4wmj1PVGuEXy0tvhB7oaPqqqUqDb6
	FFfVf1eK1ZhU/o2zs5uo8gXueHSUkRnL4FZkm8AdNZMgTHeaOHZpOJ9tAgT+Ro/VmaRrFI
	0n5nUtONT8KkK+wqRct6I6W99vFEHtgFFY+cbdAudMkkI0Lc1JnJnHnd3Gtz8Q==
Message-ID: <16e6cded-33c1-408c-9bfc-b0b9a8da4cbf@bootlin.com>
Date: Fri, 22 Mar 2024 09:58:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
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
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
 <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
 <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
 <5467add6-0099-4e54-a4f7-12aa149d03c7@bootlin.com>
 <e6994ff1-6c32-4dac-846a-5f4f18b2f996@gmail.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <e6994ff1-6c32-4dac-846a-5f4f18b2f996@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,

On 3/21/24 19:31, Péter Ujfalusi wrote:
> Hi Bastien,
> 
> On 3/21/24 17:14, Bastien Curutchet wrote:
>>>> I think the definition of the 'ti,drive-dx' is somehow odd. It allows
>>>> you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
>>>> 32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
>>>> If you have 4 channel capture then I won't speculate what will be on the
>>>> DX pin ;)
>>>>
>>>> Would not be better to say that the DX pin will be driven low or high
>>>> during capture _and_ disable the playback support?
>>>
>>> After some thinking, it might be still better to use the DX pin as GPIO
>>> and either have a custom machine driver which would handle it (set low
>>> when a capture trigger happens) or connect it in DAPM as a supply, bias
>>> or something and ASoC would handle it automagically.
>>>
>>> I think that would be cleaner in many ways. What do you think?
>>>
>> I agree, that would be cleaner. I ran a few tests to see if that would
>> work on my hardware. It doesn't ... So I looked back to the schematics
>> and found two reasons :
>>   * the DX pin needs to be in sync with the clock.
> 
> I'm not sure what this means, sync with which clock?
> 

Sorry, that was not very clear, I meant sync with the bit block that is
output on McBSP.CLKR pin.

>>   * the DX pin needs to be in a high-impedance state between two frames
>>     so a pull-up can drive it back up. Actually, the DX pin is also
>>     linked to the FSR pin so it provides the frame clock to the capture
>>     stream.
> 
> Hrm, you are using the DX pin as FSR for the capture? Why not McBSP.FSR pin >

The McBSP.FSR pin is used for the capture but is driven by the McBSP.DX
pin. Both pins are linked together.

> Looking back to the patch, one thing stood out: you are setting the
> XDATDLY to 2.
> You have some sort of T1 framing on the bus? The pullup will make the DX
> line high in for the framing bit, right? > Or you simulate another FSR line with T1 framing DX?
> 

Yes the goal is to simulate an FSR.

> The 'ti,drive-dx' sounds like a bad property for sure, you have T1
> framing and driving the DX to certain level.
> It is like DSP_A (1 bit delay) playing constant 0x2 ?
> 
> Can you use aplay /dev/zero and a DT property to select T1 framing for
> the playback? Or that would be too coarse for timing the start of
> playback and capture?
> 

That's a good idea, thank you. I'll try this and come back to you.


Best regards,
Bastien


