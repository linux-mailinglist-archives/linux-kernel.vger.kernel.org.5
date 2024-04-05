Return-Path: <linux-kernel+bounces-133549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2189A56C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F870B229D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052DD173347;
	Fri,  5 Apr 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DI+99aiB"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6117334B;
	Fri,  5 Apr 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347586; cv=none; b=dc6ySI6KGydR9jfxiKZtMnYRN86GS6KZ+D2MWWKkgenahMbdUVo6I2Xf9ioYQ+D/CIMxXhROOKYOHIYqlyYJ6GuJoZYlRWrFYy2RDE06NBXeiLSV2MfB3T1/IJaNCjeTigmIPPkqxNYd41vDc5znrHZTIPDK/YSBzlWC6wJTUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347586; c=relaxed/simple;
	bh=uaop8AMwEo7OLxvfnSoNm0x1ldGPdxq97EPjucRL9d8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FygRZab7sfNlWQPKK3Sv0C4S1z5qVN+1+NGj9E9tnm3kwL3A+i/2TUsTAPrMSYS4lDMxlsltOjopl0t5h7+XfAxk38fFW2SIi+p3QpThZr6ei2+IWvnCIRm1nmiqb+ZIFlk5f8cD3xz8AsEAfXe5GRG+aOgjEamh1Dwl1ddGtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DI+99aiB; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5A940100028;
	Fri,  5 Apr 2024 23:06:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5A940100028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712347578;
	bh=thDFa/zYNo6oJG4ciqQQwjBzQGtMqiJCORO6AnLSVXk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
	b=DI+99aiBM6I4MMJYYEgQsfB78uSUSDmKN4l02fnHbgB5WMwXiN7//VkItBMASESSV
	 6ec5lvO2mBQTdfEuuo7qlvi+XDT74892LR5iVbJ+UkZ0/JmU7+JKH5ZYJeir1FNSok
	 8T64LotGVPV6du38nwH46kDUGMP4gTdUFegtb9em0dEs0eDBN6XoQ3jB0GH4M107c8
	 8F4Cjio6Hrtlp6+F3V6B2OikszjvhwO13hR/atMQ9OIidsAAO9nANHwLzc4Hj2gvMk
	 AWbnNlH1ehGxyMlFoL8KGXSdVvhYVZNVAb1oly4TSZCSNd9wgueLenKrUE2f6R5QNR
	 OhRnDQPifcFyA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  5 Apr 2024 23:06:18 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Apr 2024 23:06:17 +0300
Message-ID: <a7a7c60f-3415-4167-8a35-ed956eb7d3ce@salutedevices.com>
Date: Fri, 5 Apr 2024 23:06:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
To: Harald Geyer <harald@ccbib.org>, <lars@metafoo.de>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
 <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
 <01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
 <e3765f2d7de8a9d26e97750a6a0d1e26da74ab9b.camel@ccbib.org>
Content-Language: en-US
In-Reply-To: <e3765f2d7de8a9d26e97750a6a0d1e26da74ab9b.camel@ccbib.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184605 [Apr 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/05 17:55:00 #24670772
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Harald

On 3/26/24 17:03, Harald Geyer wrote:
> Hi George!
> 
> Am Montag, dem 25.03.2024 um 23:18 +0300 schrieb George Stark:
>> On 3/25/24 21:48, Harald Geyer wrote:
>>> Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark:
>>>> Protocol parsing errors could happen due to several reasons like
>>>> noise
>>>> environment, heavy load on system etc. If to poll the sensor
>>>> frequently
>>>> and/or for a long period kernel log will become polluted with
>>>> error
>>>> messages if their log level is err (i.e. on by default).
>>>
>>> Yes, these error are often recoverable. (As are many other HW
>>> errors,
>>> that typically are logged. Eg USB bus resets due to EMI)
>>>
>>> [...]
>>>
>>> The idea is, that these messages help users understand issues with
>>> their HW (like too long cables, broken cables etc). But it is true,
>>> that they will slowly accumulate in many real world scenarios
>>> without
>>> anything being truly wrong.
>> I agree with you that it's very convenient to just take a look to
>> dmesg
>> and see device connection problems at once. But unlike e.g. usb user
>> has
>> to actually start reading sensor to perform communication and read
>> errors will be propagated to the userspace and could be noticed \
>> handled.
> 
> Not really. The log lines contain additional information useful for
> understanding the problem with the setup.
> 
>> Anyway I believe we should use uniform approach for read errors -
>> currently in the driver there're already dbg messages:
>>
>> "lost synchronisation at edge %d\n"
>> "invalid checksum\n"
> 
> These errors are usually caused by EMI and there isn't much to do aside
> from trying again until we find a time window with less interference.
> They are not logged, because in some cases they might be very frequent
> and can be handled by the user space client programatically anyway.
> 
>> I changed log level from err to dbg for the messages:
>>
>> "Only %d signal edges detected\n"
> 
> This mostly indicates a problem with the setup. Long cable, dead
> sensor, high (interrupt) load etc.
> 
> Its true that this can happen during normal operation. - Usually when
> the system takes too long to enter the irq handler.
Usually there's nothing to do about it. And several late-handled
interrupts can lead to any of 4 errors.

> 
> But the primary causes are:
> 1) Your wiring is broken. In this case, the message is immediately
> helpful and points you in the right direction. (Only if you understand
> the protocol though.)
> 2) Your sensor is dead or "crashed", which also warrants an error msg
> IMO.

My sensor works around 3 years 24\7 (with one reboot per month) and 
still precise (for home usage at least) - I compared it with several 
other home temperature sensors.

I've just checked another sensor in my setup (3.3v, cable 15cm) the
error rate is the same. So it's ether EMI or single-core slow cpu.

> 
> The "crashed" case is a bit special. Some chips seem to randomly stop
> working after a couple of hours and the only remedy is to power cycle
> them. This could be done automatically. - I have the sensor power
> supply pin on a GPIO and reset it from userspace in my setup. I tried
> to work on a version of the driver some years ago, that would
> optionally register with a regulator and manage sensor resets from
> within the kernel driver. If this was actually implemented, we could
> reduce the logging to cases, where the reset didn't solve the problem.
> 
> I stopped working on this, because it would have required changes to
> the regulator framework, to be actually useful, and the regulator
> maintainers didn't seem to keen about them. However, if you want to
> pick this up in an effort to reduce unnecessary error conditions and
> messages, I certainly would be happy.
> 
>> "Don't know how to decode data: %d %d %d %d\n"
> 
> This would indicate a sensor, that uses the same protocol but an
> unsupported data format. This is a permanent error and therefor should
> be logged IMO.
> 
> I guess, if you have a bad readout due to EMI but the checksum
> accidentally matches, then you might get this message too. But this
> should be a very rare case.

It's not very rare but sure not permanent. It can happen once per 
several hundreds / a thousand requests.

> 
>> They all are from a single callback and say the same thing -
>> communication problem.
> 
> Not really. See above.
> 
>> If we make all those messages as errors it'd be great to have
>> mechanism
>> to disable them e.g. thru module parameter or somehow without
>> rebuilding
>> kernel.
> 
> No. What you try to change is cosmetic at best. It certainly doesn't
> justify adding any complexity.
> 
> Since Jonathan deferred to my judgment:
> 
> As you can see, I did consider the trade-off between useful diagnostics
> and spamming the log carefully. So naturally I'm inclined to reject
> your proposal unless it solves an actual problem.
> 
> Also people still mail me directly with bogus bug reports about the
> driver when really they have some issue with their setup. I fear, if we
> reduce diagnostics, it will increase that noise.

If you don't ask those people to send dmesg with CONFIG_DEBUG is on you 
lost 2 of 4 possible errors and don't see the whole picture. Other 
dev_dbg messages in this driver are rather helpful.

Anyway thanks for that very interesting information. It's not obvious at 
all if you're unfamiliar with protocol and the driver. Probably it 
should be put in some documentation. Without diving into driver's source 
code those messages are just noise.
Still I consider all those cases are purely debug. When there no 
hardware support for sensor's protocol and the kernel is not realtime 
then errors are probable. But often a temp sensor application is
not required to struggle for every measurement. And it's not desirable
to add logrotate to embedded system just because of temp sensor diagnostics.

> 
> So I reject your proposed changes, if they are for the sake of
> unification. I'm willing to discuss, what the most sensible trade-off
> is, but it would need to actually add to the considerations I already
> did.
> 
> Best regards,
> Harald
> 
> 
>>   Those errors can be bypassed by increasing read rate.
>>
>>>
>>> I don't consider the dmesg buffer being rotated after a month or
>>> two a
>>> bug. But I suppose this is a corner case. I'll happily accept
>>> whatever
>>> Jonathan thinks is reasonable.
>>>
>>> Best regards,
>>> Harald
>>>
>>>
>>>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>>>> ---
>>>> I use DHT22 sensor with Raspberry Pi Zero W as a simple home
>>>> meteo
>>>> station.
>>>> Even if to poll the sensor once per tens of seconds after month
>>>> or
>>>> two dmesg
>>>> may become full of useless parsing error messages. Anyway those
>>>> errors are caught
>>>> in the user software thru return values.
>>>>
>>>>    drivers/iio/humidity/dht11.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/humidity/dht11.c
>>>> b/drivers/iio/humidity/dht11.c
>>>> index c97e25448772..e2cbc442177b 100644
>>>> --- a/drivers/iio/humidity/dht11.c
>>>> +++ b/drivers/iio/humidity/dht11.c
>>>> @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11,
>>>> int
>>>> offset)
>>>>                   dht11->temperature = temp_int * 1000;
>>>>                   dht11->humidity = hum_int * 1000;
>>>>           } else {
>>>> -               dev_err(dht11->dev,
>>>> +               dev_dbg(dht11->dev,
>>>>                           "Don't know how to decode data: %d %d %d
>>>> %d\n",
>>>>                           hum_int, hum_dec, temp_int, temp_dec);
>>>>                   return -EIO;
>>>> @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
>>>> *iio_dev,
>>>>    #endif
>>>>
>>>>                   if (ret == 0 && dht11->num_edges <
>>>> DHT11_EDGES_PER_READ - 1) {
>>>> -                       dev_err(dht11->dev, "Only %d signal edges
>>>> detected\n",
>>>> +                       dev_dbg(dht11->dev, "Only %d signal edges
>>>> detected\n",
>>>>                                   dht11->num_edges);
>>>>                           ret = -ETIMEDOUT;
>>>>                   }
>>>> --
>>>> 2.25.1
>>>>
>>>
>>
> 

-- 
Best regards
George

