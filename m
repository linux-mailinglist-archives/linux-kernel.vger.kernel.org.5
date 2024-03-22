Return-Path: <linux-kernel+bounces-111283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7F886A19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6470DB21220
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9743B1AA;
	Fri, 22 Mar 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="FKlWKUeK"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD839867;
	Fri, 22 Mar 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102812; cv=none; b=dokGn7rnKm7TupDpGipCpm/CtUFBcrlGBF2monxlz031g99HMmCIczt6Ocnw+WaMsqBF0UqE04Wb9nDq1WHvYc9aezNZpwUrw+K+luCznGKfPQZ1J5O6osifiLpHVQRohF9TiiNQFRMwJ5tTPruZ7dWfSkcXRJTJPVVbbNgQ0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102812; c=relaxed/simple;
	bh=TfmXLhZXlfD0a9LyMZempjSiPKbS9E8Xr+DsBXNjmU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=usGukaugOFCHZFDtuEd3tZ5/GwZ4mmv56OeC4u7sb2ahzhoo+Es/N3LpuIGfUVjZNvcPIygC2C3hE2yKgBpZesuGjLRAr50vHSBMUCh9UAtMxWrkMVY7WG6iSNbllay5MPJGWDJmGVpggvl3YM49djWhAGBel+ExD2M+hKLSYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=FKlWKUeK; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7026E12000B;
	Fri, 22 Mar 2024 13:20:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7026E12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711102800;
	bh=QDsXGW5/59UnvmoHb3vEogUe5cS21Npp2od4h0J6xN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=FKlWKUeK+Oq0Wa+n74SgqpGy705mGzvkWv6h0k8Gfk8rHuNm71Nhx7NdEmaNRYsIJ
	 xuvhIlx82rTpCj65nZrWMzYAAROXsiBivt6R/xNnS78zjkhmonuxCdGfi/89QqGqvP
	 YKt/fjuonKqBdfTGDKdOrBh1bWLKgoYGr5jq5FsmupxBvrYXqUoztUmFHjLPZ0W9AB
	 p0cHBsKD16pBmq2MYbKeZ+T2UMnkNE13z4HhjSMQH46ZFRbAHjgscmeLUDZaMPAHk2
	 Bzfg7GCi33eJ7sBopA4XVke04B8sOVR9o70ghTAmCLMsQTIPBQj0reQ6jenm3f7WRR
	 h9HeiTFDgAtHQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 22 Mar 2024 13:20:00 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Mar 2024 13:19:59 +0300
Message-ID: <9bfd0ccc-a5d8-446c-a08c-bbc36a4d66eb@salutedevices.com>
Date: Fri, 22 Mar 2024 13:19:59 +0300
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
	<linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
 <20240321181133.GG13211@google.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240321181133.GG13211@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184346 [Mar 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/22 05:30:00 #24352985
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Lee

On 3/21/24 21:11, Lee Jones wrote:
> On Thu, 14 Mar 2024, George Stark wrote:
> 
>> This patch series fixes the problem of devm_led_classdev_register misusing.
>>
>> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
>> is used then led_classdev_unregister() called after driver's remove() callback.
>> led_classdev_unregister() calls driver's brightness_set callback and that callback
>> may use resources which were destroyed already in driver's remove().
>>
>> After discussion with maintainers [2] [3] we decided:
>> 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
>> but fix drivers
>> 2) don't use devm_led_classdev_unregister
>>
>> So the solution is to use devm wrappers for all resources
>> driver's brightness_set() depends on. And introduce dedicated devm wrapper
>> for mutex as it's often used resource.

..

>>    locking/mutex: introduce devm_mutex_init()
>>    leds: aw2013: use devm API to cleanup module's resources
>>    leds: aw200xx: use devm API to cleanup module's resources
>>    leds: lp3952: use devm API to cleanup module's resources
>>    leds: lm3532: use devm API to cleanup module's resources
>>    leds: nic78bx: use devm API to cleanup module's resources
>>    leds: mlxreg: use devm_mutex_init() for mutex initialization
>>    leds: an30259a: use devm_mutex_init() for mutex initialization
>>
>>   drivers/leds/leds-an30259a.c | 14 ++++----------
>>   drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
>>   drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
>>   drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
>>   drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
>>   drivers/leds/leds-mlxreg.c   | 14 +++++---------
>>   drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
>>   include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
>>   kernel/locking/mutex-debug.c | 11 +++++++++++
>>   9 files changed, 122 insertions(+), 74 deletions(-)
> 
> Doesn't apply to v6.8.
> 
> What base was used for this?

I've just pulled git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
and v7 was applied cleanly. linux-next is ok too.

v6.8 is lack of recent patch 6969d0a2ba1adc9ba6a49b9805f24080896c255c
v7's patch #2 depends on it

-- 
Best regards
George

