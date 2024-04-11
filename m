Return-Path: <linux-kernel+bounces-140630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9268A1702
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F552835F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573514E2CD;
	Thu, 11 Apr 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SILsPVAt"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDF14D708;
	Thu, 11 Apr 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845252; cv=none; b=V5n8GinPSu1tDvYYr9CRa3Ge0hpIfIwqXKjyytttXgX+luxT8i+XgI3v4w/Ev6TsCgovd47WhC7K3BD6XIjS6gWmBMQ8PK5HfXY2BG7yEhNHjmh767rGAkQM5iM3oFmAuGP8/nEOBgK/hqDHp5WSgYQsViuetMIqW2CMabPssd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845252; c=relaxed/simple;
	bh=gArZRcKJqCCIYXotisDvi1lLpRBGz36Ctb1FuCH/V0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KNwSY1CyNcIsKh+rr46s8krAowf6ovXUDtwUt6Xh1IAU/fxlXXpWK4dcjoC/bRxEC6Y4VrNtcgJnly3jZUGhYic/QnaU+c14E7Oe7AbrPXQXuvnMCXSn+3THiU6aO0SWri735CoJfPYABreXlIsLtYArKRrryYL4xEJaPjui7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SILsPVAt; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6F00E120030;
	Thu, 11 Apr 2024 17:20:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6F00E120030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712845247;
	bh=JzEpKQOQSCAa/sVPzjULYwdH6hnGpIyZLwikvel8MFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SILsPVAtRh4oDqWZ4PBAOsJ4XUelJx8uvYUE3MF3S727ZbdfQ7pcPdWk32QDHAq3B
	 jUcmJtuapXxvqhh7/U7SEyoXgOYsfcvGsrgSxbYINJCtU8IJxb3rmndUBraT9Bhb+i
	 PNMN/mnRNZQiEIe7NX92bxnjwP9LEHomh/ENj7JWSyjzvlwnBlLfP3vrFlhmVuI/UD
	 uHVVjUcXA430gXDzplKDr7vDCkO7qiEa5Kh7IHaETCm3RnGLSkQEMk5jx+xDBVDqPG
	 3dlZotPKesgQ1/35dHV1qR1tqtu9comYUxCy4Z5GVHwJTtjE/mwODIgW82RcIzLMTr
	 yMKQfdiOnU+1Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 17:20:47 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 17:20:46 +0300
Message-ID: <25eabe2f-93ce-46d3-b0e0-f633e1cefbe4@salutedevices.com>
Date: Thu, 11 Apr 2024 17:20:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
To: Lee Jones <lee@kernel.org>
CC: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <vadimp@nvidia.com>,
	<christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
 <20240321181133.GG13211@google.com>
 <9bfd0ccc-a5d8-446c-a08c-bbc36a4d66eb@salutedevices.com>
 <20240322104303.GN13211@google.com>
 <e3dd3ed1-02dc-447c-9fdd-9d8193a25e5f@salutedevices.com>
 <20240411134514.GK1980182@google.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240411134514.GK1980182@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184674 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 09:22:00 #24744908
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Lee

On 4/11/24 16:45, Lee Jones wrote:
> On Fri, 29 Mar 2024, George Stark wrote:
> 
>> Hello Lee
>>
>> On 3/22/24 13:43, Lee Jones wrote:
>>> On Fri, 22 Mar 2024, George Stark wrote:
>>>
>>>> Hello Lee
>>>>
>>>> On 3/21/24 21:11, Lee Jones wrote:
>>>>> On Thu, 14 Mar 2024, George Stark wrote:
>>>>>
>>>>>> This patch series fixes the problem of devm_led_classdev_register misusing.
>>>>>>
>>>>>> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
>>>>>> is used then led_classdev_unregister() called after driver's remove() callback.
>>>>>> led_classdev_unregister() calls driver's brightness_set callback and that callback
>>>>>> may use resources which were destroyed already in driver's remove().
>>>>>>
>>>>>> After discussion with maintainers [2] [3] we decided:
>>>>>> 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
>>>>>> but fix drivers
>>>>>> 2) don't use devm_led_classdev_unregister
>>>>>>
>>>>>> So the solution is to use devm wrappers for all resources
>>>>>> driver's brightness_set() depends on. And introduce dedicated devm wrapper
>>>>>> for mutex as it's often used resource.
>>>>
>>>> ...
>>>>
>>>>>>      locking/mutex: introduce devm_mutex_init()
>>>>>>      leds: aw2013: use devm API to cleanup module's resources
>>>>>>      leds: aw200xx: use devm API to cleanup module's resources
>>>>>>      leds: lp3952: use devm API to cleanup module's resources
>>>>>>      leds: lm3532: use devm API to cleanup module's resources
>>>>>>      leds: nic78bx: use devm API to cleanup module's resources
>>>>>>      leds: mlxreg: use devm_mutex_init() for mutex initialization
>>>>>>      leds: an30259a: use devm_mutex_init() for mutex initialization
>>>>>>
>>>>>>     drivers/leds/leds-an30259a.c | 14 ++++----------
>>>>>>     drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
>>>>>>     drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
>>>>>>     drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
>>>>>>     drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
>>>>>>     drivers/leds/leds-mlxreg.c   | 14 +++++---------
>>>>>>     drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
>>>>>>     include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
>>>>>>     kernel/locking/mutex-debug.c | 11 +++++++++++
>>>>>>     9 files changed, 122 insertions(+), 74 deletions(-)
>>>>>
>>>>> Doesn't apply to v6.8.
>>>>>
>>>>> What base was used for this?
>>>>
>>>> I've just pulled git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>> and v7 was applied cleanly. linux-next is ok too.
>>>>
>>>> v6.8 is lack of recent patch 6969d0a2ba1adc9ba6a49b9805f24080896c255c
>>>> v7's patch #2 depends on it
>>>
>>> No problem.  I'll wait for v6.9-rc1.
>>>
>>
>> Just checked the v7 patch series on released 6.9-rc1 and it's applied
>> cleanly. If anything i can help please let me know.
> 
> It applies, but doesn't seem to build:
> 
> make --silent --keep-going --jobs=8 O=../build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- 'CC=sccache aarch64-linux-gnu-gcc' 'HOSTCC=sccache gcc' allmodconfig
> make --silent --keep-going --jobs=8 O=../build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- 'CC=sccache aarch64-linux-gnu-gcc' 'HOSTCC=sccache gcc'
> ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-an30259a.ko] undefined!
> ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-aw200xx.ko] undefined!
> ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-aw2013.ko] undefined!
> ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-lm3532.ko] undefined!
> ERROR: modpost: "__devm_mutex_init" [drivers/leds/leds-mlxreg.ko] undefined!
> make[3]: *** [/builds/linux/scripts/Makefile.modpost:145: Module.symvers] Error 1
> 
> Did you forget to export it?
> 

Yes, my bad. I tested *DEBUG* configs but without modules enabled.
Adding EXPORT_SYMBOL_GPL(__devm_mutex_init); fixes the problem,
v8 is on the way.

-- 
Best regards
George

