Return-Path: <linux-kernel+bounces-23590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33ED82AEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A801C21AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3915AE4;
	Thu, 11 Jan 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q4WNmi89"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EF15AC2;
	Thu, 11 Jan 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704976278;
	bh=UUJgjJ0RgrkopwyiH7EhfQcUXFSjaBg0zxcp09P632c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q4WNmi89YstZXiLPgOt1dwpk1nC+RqlIiraEbHug2sZN/WZv1iufJk2WCqLRpXyYi
	 B81nVXtd3/nzdec2qroxhgcV+EJqtWUonK6E6foQttzg2pBk9B6BW0JaRBBCqrDgYm
	 X0vyI5RPEaWF3GiJN469g6HspI/+mY+Mp98wrokyxjhuoLPHYUgnCcCx8CmPnc9inO
	 YXz5FzclwA5pXybeydIGo5EtCtuTHJt1RYTYNphK8+3EIs+Q4009Ym/if2fnYEaYZ9
	 DYe47T0wwXrD70xruhhxEk8BKp2t9z9U9SL5itgunBQIBgQaUO4fmCYBVnJqrWCs9t
	 UT6C+VfDSBB2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CC873780F7F;
	Thu, 11 Jan 2024 12:31:17 +0000 (UTC)
Message-ID: <ef5c443e-461f-49d6-b88d-63076cd2f903@collabora.com>
Date: Thu, 11 Jan 2024 13:31:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: Add PM6150L
 thermals
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Bjorn Andersson
 <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240105-fp4-thermals-v1-0-f95875a536b7@fairphone.com>
 <20240105-fp4-thermals-v1-2-f95875a536b7@fairphone.com>
 <18dc5f88-6590-4e2d-948f-fd77f4713f8b@linaro.org>
 <CYA4ZGOQOJXY.2RO98RBCDKK5J@fairphone.com>
 <f78ce9e6-0a25-4e08-b972-db055b7afd71@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <f78ce9e6-0a25-4e08-b972-db055b7afd71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 20:16, Konrad Dybcio ha scritto:
> 
> 
> On 1/9/24 12:24, Luca Weiss wrote:
>> On Tue Jan 9, 2024 at 11:09 AM CET, Konrad Dybcio wrote:
>>>
>>>
>>> On 1/5/24 15:54, Luca Weiss wrote:
>>>> Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
>>>> RFC_CAM_THERM, CAM_FLASH_THERM and QUIET_THERM thermistors connected to
>>>> PM6150L.
>>>>
>>>> Due to hardware constraints we can only register 4 zones with
>>>> pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
>>>
>>> Ugh.. so the ADC can support more inputs than the ADC_TM that was
>>> designed to ship alongside it can?
>>>
>>> And that's why the "generic-adc-thermal"-provided zones need to
>>> be polled?
>>
>> This part of the code from qcom-spmi-adc-tm5.c was trigerring if I
>> define more than 4 channels, and looking at downstream I can also see
>> that only 4 zones are registered properly with adc_tm, the rest is
>> registered with "qcom,adc-tm5-iio" which skips from what I could tell
>> basically all the HW bits and only registering the thermal zone.
>>
>>
>>     ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM,
>>                &channels_available, sizeof(channels_available));
>>     if (ret) {
>>         dev_err(chip->dev, "read failed for BTM channels\n");
>>         return ret;
>>     }
>>
>>     for (i = 0; i < chip->nchannels; i++) {
>>         if (chip->channels[i].channel >= channels_available) {
>>             dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
>>             return -EINVAL;
>>         }
>>     }
>>
>>
>>>
>>>>
>>>> The trip points can really only be considered as placeholders, more
>>>> configuration with cooling etc. can be added later.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>> [...]
>>>
>>> I've read the sentence above, but..
>>>> +        sdm-skin-thermal {
>>>> +            polling-delay-passive = <1000>;
>>>> +            polling-delay = <5000>;
>>>> +            thermal-sensors = <&msm_therm_sensor>;
>>>> +
>>>> +            trips {
>>>> +                active-config0 {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "passive";
>>>
>>> I don't fancy burnt fingers for dinner!
>>
>> With passive trip point it wouldn't even do anything now, but at what
>> temp do you think it should do what? I'd definitely need more time to
>> understand more of how the thermal setup works in downstream Android,
>> and then replicate a sane configuration for mainline with proper
>> temperatures, cooling, etc.
> If "skin therm" means "the temperature of some part of the phone's
> body that can be felt with a human hand", then definitely some
> throttling should happen at 40ish with heavy throttling at 50
> and crit at 55 or so..
> 
> We should probably make this a broader topic and keep a single
> policy for all supported phones.
> 
> + CC AGdR, may be interested in where this leads
> 
> Konrad

A thermal trip at 125°C for *skin temperature* is useless... if a device's skin
temperature (be it a smartphone, a SBC, a Chromebook, a non-specially-identified
laptop, a car head unit, or whatever else you can imagine) reaches that kind of
temperature, this means that something inside likely reached something along the
lines of 150°C for a prolonged period of time.

You will definitely agree with me that if something reached that temperature for
a certain period of time, it is *highly unlikely* (not to say impossible) that
Linux is even still running and that the green smoke that is naturally trapped in
any chip didn't get released :-)

Besides, keep in mind that if the SKIN temperature is 55°C, if your device has
a -> lithium <- battery (li-ion/lifepo/others), your hands are "probably" in a
kind of danger that I wouldn't be comfortable with (and neither you I'm sure).

Strictly related to the trip temperature setting for "SKIN", for me this is a
strong NAK.

I'd go for stricter ranges too, something like...
- critical: ~52/53
- heavy throttling: 49/50
- throttle: ~45
NOTE: this would be valid only if there are other throttling points for CPU/GPU/etc


---- Anyway, something else I have in my mind: ----

Konrad: "standardizing" skin temperature is too big of a bet, and will be wrong,
because industrial-grade devices are permitted to reach higher skin temperatures.
Some industrial grade smartphones (example: rugged stuff) may have sensors in
the underside of the ruggedized shell... so in that case you want to set the skin
temperature limit with delta-T ideally...

Though!

Making this easier for everyone: we can somehow dictate (unofficially, because
of more of the many reasons I already explained) an acceptable temperature range
for "skin" temperature, outside of which, reviews should follow manual testing.

As for the concept of "skin temperature", and for some thermal framework work
(sorry for the word game) that I'm bringing on the table, in this case we can
imagine it as:

Thermal zone type: SKIN
Thermal zone name: shell-upper/shell-rightmost/shell....something

Type SKIN would be defined as
"a zone defining the temperature of the outer shell of a device"...

..and for example differently from type PCB, which fits different temperature
probe points.


Feel free to keep me in the loop, btw.

Cheers,
Angelo

