Return-Path: <linux-kernel+bounces-117912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357688B294
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7940CB37146
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162943AB2;
	Mon, 25 Mar 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DJRLAW/1"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C9FC01;
	Mon, 25 Mar 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397922; cv=none; b=KgMVKO6zGsv78bK+6IlzWUM5nChyoLQTcGCXLZXjafkOCUhxnMTuz1WtV4zV4do61fIKBy/Ys73ydac4AkNgd6s548kg5coIZzLL9mTXguAplE7nqk3PWF34dNvtYpFxENouwi/JrnNPUMgB5uFz0fpvzl8JX5bP4nLa06/bZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397922; c=relaxed/simple;
	bh=Gmb2BaijEb4m5JgrvZZz3HH7oDI3q6QmBj33VjTQq8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VOkKplpQN0nYcK/2JgYVde8iUhvA+u7zEM3cxK12X/2UGqMOEH0nfo7oaqE7ZZb6XxhV3rKbk5Xt0Kv6Tf1AaIklOaD1WRHNab4TZFKGlfUsqdfZMU/VHfcdeXv+yf6kQb+nbkx49KLvtDBIpEsaJwvxZDs5dsQg90TWru1/cZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DJRLAW/1; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D7DA512000B;
	Mon, 25 Mar 2024 23:18:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D7DA512000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711397913;
	bh=ag/Xt50izz8cSF9yG1EEgnKoOdRbmA9hyWMHr06p+jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=DJRLAW/1rpTIEtDVub8hh36iuJwSL1w2ucxfIcQNn1CSyMZ7jSUZYABrf9s3VJMnV
	 mZ7/3TEl8VmpZKYYTi9I83y8HnO0RAgAvFrWqPhpK9pfHMc18VbKkq7bDcDBv8M1fF
	 UzERFN1AoDHTVv5oEFkP+nr3BUaKOUp8i87DloNtjYrpkZV/euvXiu5J6acq591MMl
	 siDktPxm9Rj4j46yaft3ldmO6YXfCcoldU2v6SRM1hddPgNEHNZjx5UemA5FyjR8rd
	 GZJsvUFufLucFHVeH+aqmPfcRGvPZ48XwwPVqy8nPqq/6PdGkPuZ9IdOV+pnPqewVl
	 ANQQJGglgAE3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 25 Mar 2024 23:18:33 +0300 (MSK)
Received: from [172.28.66.90] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 23:18:33 +0300
Message-ID: <01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
Date: Mon, 25 Mar 2024 23:18:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
Content-Language: en-US
To: Harald Geyer <harald@ccbib.org>, <lars@metafoo.de>, <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
 <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184404 [Mar 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/25 18:32:00 #24438765
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Harald

Thanks for the review.


On 3/25/24 21:48, Harald Geyer wrote:
> Hi George!
> 
> I'm torn on this:
> 
> Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark:
>> Protocol parsing errors could happen due to several reasons like
>> noise
>> environment, heavy load on system etc. If to poll the sensor
>> frequently
>> and/or for a long period kernel log will become polluted with error
>> messages if their log level is err (i.e. on by default).
> 
> Yes, these error are often recoverable. (As are many other HW errors,
> that typically are logged. Eg USB bus resets due to EMI)
> 
> However they are still genuine errors of the HW.
> 
>>   Also some types
>> of those messages already have dbg level so use unified log level for
>> all such cases.
> 
> My take so far has been: Debug level messages are for debugging the
> code (ie adding/testing support of new device variants etc). Users
> aren't expected to know about or enable debug output. OTOH anything
> actually going wrong is an error and should be logged as such.
> 
> The idea is, that these messages help users understand issues with
> their HW (like too long cables, broken cables etc). But it is true,
> that they will slowly accumulate in many real world scenarios without
> anything being truly wrong.

I agree with you that it's very convenient to just take a look to dmesg
and see device connection problems at once. But unlike e.g. usb user has
to actually start reading sensor to perform communication and read
errors will be propagated to the userspace and could be noticed \
handled.

Anyway I believe we should use uniform approach for read errors -
currently in the driver there're already dbg messages:

"lost synchronisation at edge %d\n"
"invalid checksum\n"

I changed log level from err to dbg for the messages:

"Only %d signal edges detected\n"
"Don't know how to decode data: %d %d %d %d\n"

They all are from a single callback and say the same thing -
communication problem.

If we make all those messages as errors it'd be great to have mechanism
to disable them e.g. thru module parameter or somehow without rebuilding
kernel. Those errors can be bypassed by increasing read rate.

> 
> I don't consider the dmesg buffer being rotated after a month or two a
> bug. But I suppose this is a corner case. I'll happily accept whatever
> Jonathan thinks is reasonable.
> 
> Best regards,
> Harald
> 
> 
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> ---
>> I use DHT22 sensor with Raspberry Pi Zero W as a simple home meteo
>> station.
>> Even if to poll the sensor once per tens of seconds after month or
>> two dmesg
>> may become full of useless parsing error messages. Anyway those
>> errors are caught
>> in the user software thru return values.
>>
>>   drivers/iio/humidity/dht11.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/dht11.c
>> b/drivers/iio/humidity/dht11.c
>> index c97e25448772..e2cbc442177b 100644
>> --- a/drivers/iio/humidity/dht11.c
>> +++ b/drivers/iio/humidity/dht11.c
>> @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11, int
>> offset)
>>                  dht11->temperature = temp_int * 1000;
>>                  dht11->humidity = hum_int * 1000;
>>          } else {
>> -               dev_err(dht11->dev,
>> +               dev_dbg(dht11->dev,
>>                          "Don't know how to decode data: %d %d %d
>> %d\n",
>>                          hum_int, hum_dec, temp_int, temp_dec);
>>                  return -EIO;
>> @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
>> *iio_dev,
>>   #endif
>>
>>                  if (ret == 0 && dht11->num_edges <
>> DHT11_EDGES_PER_READ - 1) {
>> -                       dev_err(dht11->dev, "Only %d signal edges
>> detected\n",
>> +                       dev_dbg(dht11->dev, "Only %d signal edges
>> detected\n",
>>                                  dht11->num_edges);
>>                          ret = -ETIMEDOUT;
>>                  }
>> --
>> 2.25.1
>>
> 

-- 
Best regards
George

