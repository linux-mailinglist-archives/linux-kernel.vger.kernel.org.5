Return-Path: <linux-kernel+bounces-108567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A54880C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630D9B21722
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26324A19;
	Wed, 20 Mar 2024 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CntIZw8p"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE729409;
	Wed, 20 Mar 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920792; cv=none; b=lOgovI0QOkeBQFVsEsh0PCHJvqDqymxQFFkAKwP0yAPcUIJmKgCCfIV0NsDkXWxThguRY6/1y3WH+AEU5XEkG7z2CGhCucWdr3WR2hXpt1GAtASLhBwGxOsh8w+MZsLcetFVJNuimE8JDuOFpKYpAE3JnRlOli/ucHq5tZAgFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920792; c=relaxed/simple;
	bh=Ib1YGi6+k7//xZhCELUHLMN5Yymzlzl+jC3TmZzQS9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBAeM9DHk0pFsUlk/BKeeuWN/0XG41FWt/577JcpQudrvurAyNAJC7SDtUs7TXpsfIduRR50pdtP56CkM9FdPJ0r+wJC5LRWdCMsscNk04IWl+LXvP2NpO74ztSxFsWju+CrMMKf6hye50hezajPjboSm/VAtokm/evYqYuvpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CntIZw8p; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92281FF807;
	Wed, 20 Mar 2024 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710920781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5e54mRdfjOEsN/nbRi2WZI4kTVdEISox3uake09K72s=;
	b=CntIZw8pN/VwkZVAO2SKwwcoAtquLsqesAgaQpn/KPk1iEZfAC8HeTtQHdijlfn6YGgsSx
	RQos6KXPFCJ4c+Xi5wqSS70s9jR4Zxwn5dareb5xQLoAPE3QoIrSICgKBVpvUdicaLz7tL
	wIKiOyqdbu88jmtnChKDI3UnAImFTS9B0/OAy9UvC3GUyqh3zn31c+5JvDi0HKX2kPTeQS
	7kalN+DfuBkBhSOnaZj3grj22/4vg70ATfphQ174JcteuOWhGa1BD317xg1aOTsUa0uI9O
	+ak0xuplA037PBZYHBDJJhmMdYh6XEXakJ5DiuGKbgj0s4IakIvCwG1PAHS++g==
Message-ID: <773cd098-0678-4edc-aea3-0418bedebc13@bootlin.com>
Date: Wed, 20 Mar 2024 08:46:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] ASoC: dt-bindings: davinic-mcbsp: Add the
 'ti,drive-dx' property
Content-Language: en-US
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
 <20240315112745.63230-13-bastien.curutchet@bootlin.com>
 <6e120eee-5cec-460c-87d2-40ef776efc3d@gmail.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <6e120eee-5cec-460c-87d2-40ef776efc3d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,


On 3/19/24 19:02, Péter Ujfalusi wrote:
> 
> 
> On 15/03/2024 13:27, Bastien Curutchet wrote:
>> McBSP is able to handle capture and playback stream.
>> The McBSP's DX pins that outputs serial data during playback streams can
>> be used to output a chosen pattern during capture streams. For instance,
>> this can be useful to drive an active-low signal during capture streams
>> (by choosing <0> as pattern)
> 
> or configure the MCBSPx.DX pin as GPO and use it as a GPIO?

In my use case, DX pin is connected to the ADC chip select pin so I want
the DX pin to toggle the closest possible to capture's start. That's
why I introduced this feature over configuring the pin as GPO.

> 
> Quite novel use of the hardware, no doubt about it. If you don't have
> DMA servicing the TX, it will just re-transmit the word from from the
> DXR register when the transmitter is pulled out of reset.
> 
> Interesting, but I'm not sure if this belongs to DT.
> 
>> Add a 'ti,drive-dx' property that can be used to repeatedly output a
>> chosen pattern on DX pin while capture stream is ON.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
>> index d8d4e7ea6e02..f4d1fc6bcd61 100644
>> --- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
>> @@ -80,6 +80,13 @@ properties:
>>         Enable synchronisation error detections when an unexpected frame pulse is
>>         received. If not present, unexpected frame pulses are ignored.
>>   
>> +  ti,drive-dx:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      If the property is present, McBSP will repeatedly output the selected
>> +      value on DX pin during capture streams. For instance, if set to 0, this
>> +      can be used to drive an active-low signal.
>> +
>>   required:
>>     - "#sound-dai-cells"
>>     - compatible
> 

Best regards,
Bastien

