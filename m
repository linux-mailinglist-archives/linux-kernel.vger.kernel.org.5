Return-Path: <linux-kernel+bounces-125074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAE891F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD6B289BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF24145B03;
	Fri, 29 Mar 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MaV42J9f"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A8145B09;
	Fri, 29 Mar 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719796; cv=none; b=CSd2+zUMVeeuEeoSCSrMEu2BEhMKy0VW+aAHWL9BsoJRczK5ZLfwm0/d1kGK16MAh+qOZXmpwmnOfPVhKImvLl6V0DWxy3dQGrYoyspBWmtqYfZGteVybvhqLqrnI9L72bUS/Zf/5eIdHPVfp7nA60XulTYocRLvVB9GHET39M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719796; c=relaxed/simple;
	bh=h81a1m2NkW5/zAPghZR/y5SKAK6WtQ8z99+H0hj6MTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=W9/oSXnUnoi2qcGy9jYXiFWFc1qXJ1pChJz1xW3ZOzLkKhgItP3qDC9lVAmO2mQzNTry2YWK+dwbLKwSYkdQect5eOCO1n5ZgxTUm7u2iKfgu0MhFkk6z26CmEVJ2H9vQ+0mEBXGvCYKrmprJj5JayfaJbSCc/vSGCXbytGuzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MaV42J9f; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8244E100002;
	Fri, 29 Mar 2024 16:43:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8244E100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711719787;
	bh=AWZ20JCgG2ZRP4j+v3n45Ghi9I6tUW7Yb4IWURfOEcY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
	b=MaV42J9f80560NYlsDhOUQKhB6gCc2f2t0yjK14ALI8WUHf78ZrMD+95b52BOClyX
	 svojJ461RjpSEG2xzy+fDJD5N2dgNQXyl/lSZh6u6TUzupU9zZoA2Lh7tOgy5zOYm+
	 4eb7/Eafmm4zCLMy3/JWky4o6Xpb25RZPEaqeMQ+2hhpvFAzi+0QICLUa08QkdSV/0
	 53NA4T2mvvPdEqOGUz+ZSGA0WXwE6HD8GfPysFM3pZE/jnADs//RbRLO4W3p/A9ULE
	 LDnvwHgy0suQG37reS5BRo2K01B1fznKbF0v52Ptx8bFUqXI4JjLoaXO4Hrk4QG6Ka
	 UYcLygKUJeC+g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 16:43:07 +0300 (MSK)
Received: from [172.28.131.133] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 16:43:07 +0300
Message-ID: <e3dd3ed1-02dc-447c-9fdd-9d8193a25e5f@salutedevices.com>
Date: Fri, 29 Mar 2024 16:43:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: George Stark <gnstark@salutedevices.com>
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
Content-Language: en-US
In-Reply-To: <20240322104303.GN13211@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184492 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 06:35:00 #24505095
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Lee

On 3/22/24 13:43, Lee Jones wrote:
> On Fri, 22 Mar 2024, George Stark wrote:
> 
>> Hello Lee
>>
>> On 3/21/24 21:11, Lee Jones wrote:
>>> On Thu, 14 Mar 2024, George Stark wrote:
>>>
>>>> This patch series fixes the problem of devm_led_classdev_register misusing.
>>>>
>>>> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
>>>> is used then led_classdev_unregister() called after driver's remove() callback.
>>>> led_classdev_unregister() calls driver's brightness_set callback and that callback
>>>> may use resources which were destroyed already in driver's remove().
>>>>
>>>> After discussion with maintainers [2] [3] we decided:
>>>> 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
>>>> but fix drivers
>>>> 2) don't use devm_led_classdev_unregister
>>>>
>>>> So the solution is to use devm wrappers for all resources
>>>> driver's brightness_set() depends on. And introduce dedicated devm wrapper
>>>> for mutex as it's often used resource.
>>
>> ...
>>
>>>>     locking/mutex: introduce devm_mutex_init()
>>>>     leds: aw2013: use devm API to cleanup module's resources
>>>>     leds: aw200xx: use devm API to cleanup module's resources
>>>>     leds: lp3952: use devm API to cleanup module's resources
>>>>     leds: lm3532: use devm API to cleanup module's resources
>>>>     leds: nic78bx: use devm API to cleanup module's resources
>>>>     leds: mlxreg: use devm_mutex_init() for mutex initialization
>>>>     leds: an30259a: use devm_mutex_init() for mutex initialization
>>>>
>>>>    drivers/leds/leds-an30259a.c | 14 ++++----------
>>>>    drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
>>>>    drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
>>>>    drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
>>>>    drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
>>>>    drivers/leds/leds-mlxreg.c   | 14 +++++---------
>>>>    drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
>>>>    include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
>>>>    kernel/locking/mutex-debug.c | 11 +++++++++++
>>>>    9 files changed, 122 insertions(+), 74 deletions(-)
>>>
>>> Doesn't apply to v6.8.
>>>
>>> What base was used for this?
>>
>> I've just pulled git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> and v7 was applied cleanly. linux-next is ok too.
>>
>> v6.8 is lack of recent patch 6969d0a2ba1adc9ba6a49b9805f24080896c255c
>> v7's patch #2 depends on it
> 
> No problem.  I'll wait for v6.9-rc1.
> 

Just checked the v7 patch series on released 6.9-rc1 and it's applied
cleanly. If anything i can help please let me know.

-- 
Best regards
George

