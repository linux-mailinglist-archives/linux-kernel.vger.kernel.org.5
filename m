Return-Path: <linux-kernel+bounces-110207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA001885B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27212B25EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7D8624A;
	Thu, 21 Mar 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YbLWQ2wj"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789ED85952;
	Thu, 21 Mar 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034056; cv=none; b=ktLr2Z8ijOWj43k9zEgNIQepAtP8tSRU0+aaV5nm9KE8QbHrdrPwwx5tk5xBWgBqodBjvmlVN6h2PS7Y8jg935usJ1Q7FlWfkQv/h/nXUjMsb90WWep+AOFbNWz5F7wsT+QmWa39/TUyipbmTjJEpeeBB/Hus0V2InjMVgOgXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034056; c=relaxed/simple;
	bh=FJDfFUiyTJXJm+o9DzdVsd9q4EWWb/PQk1TE73FXUGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmju0i5flMqWYFrNhXxtF6nrX9UkeWcqvemb34IoB89rpkt+ac/lQAi8KY3K6KFz6QqTdlDJyONl/5Zc7vV0RJ7l21QoacD326020TGJYKiX8A73GuPzz5icnD2hpBTwcVMUDifb44C2z9XZuCnBtY/OT/tQScpDsHByjmU4d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YbLWQ2wj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE8911BF20C;
	Thu, 21 Mar 2024 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711034045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0SqObXdIaAiz8b63yEz0WL2gHCtn7ExtuiZ1KSSPzM=;
	b=YbLWQ2wjXQHGg1G42dbskBhClkYaOV309PxaBzoEypCb5JhC1qla6nnH+L6aebMZVNT1E4
	f9PKSYDrJEs/v2rc1gGgXYmcTlL6nHXibcDXg6s4ugoMA8PzC32JsqjnXjW4xIFgUMlNYX
	DZxXFhQhEQ0cjKK5NBqogEER1Hp5a4FqF734sbxWDKeZ/7l8Afta8H2fbhLrOGeCqD9lkf
	P583S/uZz6CFhwHnkLo2M+X+ucHr/lhBnymoQ1dq9P0/xFrv+boXJ/aSbltIcbK0OmaVCZ
	49abQzySFOE4rcqUXevHhfVY8JPJVgF8dRgwn6qslcP+mFIGg44dso9PZpOn0Q==
Message-ID: <5467add6-0099-4e54-a4f7-12aa149d03c7@bootlin.com>
Date: Thu, 21 Mar 2024 16:14:04 +0100
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,

On 3/20/24 21:30, Péter Ujfalusi wrote:
> 
> 
> On 20/03/2024 17:42, Péter Ujfalusi wrote:
>>>> On 15/03/2024 13:27, Bastien Curutchet wrote:
>>>>> The McBSP's DX pin that outputs serial data during playback streams can
>>>>> be used during capture streams to repeatedly output a chosen pattern.
>>>>> For instance, this can be useful to drive an active-low signal during
>>>>> captures (by choosing <0> as output pattern).
>>>>
>>>> Are there really any other use of this than to pull down or up the DX
>>>> pin (0 or 0xffff)
>>>
>>> I don't know, indeed today I can only think about these two patterns.
>>> I tried to do something in a 'generic' way so it can evolve if needed.
>>
>> I think the definition of the 'ti,drive-dx' is somehow odd. It allows
>> you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
>> 32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
>> If you have 4 channel capture then I won't speculate what will be on the
>> DX pin ;)
>>
>> Would not be better to say that the DX pin will be driven low or high
>> during capture _and_ disable the playback support?
> 
> After some thinking, it might be still better to use the DX pin as GPIO
> and either have a custom machine driver which would handle it (set low
> when a capture trigger happens) or connect it in DAPM as a supply, bias
> or something and ASoC would handle it automagically.
> 
> I think that would be cleaner in many ways. What do you think?
> 
I agree, that would be cleaner. I ran a few tests to see if that would
work on my hardware. It doesn't ... So I looked back to the schematics
and found two reasons :
  * the DX pin needs to be in sync with the clock.
  * the DX pin needs to be in a high-impedance state between two frames
    so a pull-up can drive it back up. Actually, the DX pin is also
    linked to the FSR pin so it provides the frame clock to the capture
    stream.

Bast regards,
Bastien

