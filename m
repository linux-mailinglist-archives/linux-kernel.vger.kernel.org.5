Return-Path: <linux-kernel+bounces-64196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF642853BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1774E1C26735
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2360DD4;
	Tue, 13 Feb 2024 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="sbnnkpDW"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0060DC0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853932; cv=none; b=EykWIU463Ir4QVTfrUWdHpPShOg/lvrsdlrASJCIMJB/u94u3mMP+2oHlyoSbfTjecGbNv10U1nnDgAE+VHNt982fsbKx3eOw38Rjhdl8mOZukuBJOlMQLjmwjD61B6T3sXMrt+k5EuRcjBAZ4L8IXTe7uPDK+Idv88OYMx8aYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853932; c=relaxed/simple;
	bh=X2QnHRQefkn7feHFSgOFU2grkx1Xss++PwPzwoeNB1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GoIEGlGF4Are09PsakH8iC18eR9KmRNuF7Zg8k6IWeJtylD6tfIuQoDDg60T9sueuMhohkSMF+MCTtfp+3ZGHy80M/CJnNuJJ/h+VYm7DI+9tVvalZ/W6juQ7bT34xg5wAQtyCXVxMj1dSUNl1yo5GvjmeZ4ZuAR++pm8f9n4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=sbnnkpDW; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3D20712002A;
	Tue, 13 Feb 2024 22:51:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3D20712002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707853919;
	bh=fRH4VSjfvrHyW5aEuTbUTtPuR9qt0PHqLCQ18q0dLno=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=sbnnkpDWoy6eaeomF3lDFPKO1xz94j+zfnwMIOO8DnK8QtCIbodJSOvD145/U7UHm
	 xQ3Rxs2vQdDI/j4uXUADJY9gUvEylW8OJAuLV8me49ntfOJ/QGRR0IN1+NmmIhdnNc
	 uT9it3QTSjhHzDiweGkofcfJkCwgxyWWnv6iIYSYM95+nKzyAAwORZlmS56WP/rFKg
	 u0xywApbfRsMwG2ioEO53lnDfUA2/ckhT8MAgIg9SR9HkS/KRqEPBMKRv+xYCciA15
	 MjpUmpTwbhhYawTB/Rx96NnPyZWs4ZQpqmdM3NJLl9LudpVW7w0Rl8c6eiZuzPcJ3e
	 ZOaTtPjD2HcGg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 13 Feb 2024 22:51:59 +0300 (MSK)
Received: from [172.28.160.241] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 22:51:58 +0300
Message-ID: <63e0d41a-92b6-4596-ae54-d6bc2624e63d@salutedevices.com>
Date: Tue, 13 Feb 2024 22:51:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/mutex: Clean up mutex.h
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20231216013656.1382213-1-longman@redhat.com>
 <8be5bc9d-9505-41c6-b2ca-654bfe1d809f@salutedevices.com>
 <22c625f9-1750-4ade-b9c7-27b608c7f653@salutedevices.com>
 <a8313e5d-c4f2-4f4c-a05e-b87b2d694901@redhat.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <a8313e5d-c4f2-4f4c-a05e-b87b2d694901@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183416 [Feb 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/13 18:14:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/13 18:15:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/13 16:15:00 #23586885
X-KSMG-AntiVirus-Status: Clean, skipped


On 2/13/24 06:28, Waiman Long wrote:
> 
> On 2/11/24 18:28, George Stark wrote:
>> Hello
>>
>> Excuse me, this is my 4th letter here since December 2023 and there's 
>> no response unfortunately.
>>
>>
>> Just to recall that we had the discussion in December 2023 about 
>> implementing devm_mutex_init. We came to conclusion that the only 
>> effective way to do it in include/linux/mutex.h but mutex.h requires
>> some cleanups to simplify the devm_mutex_init patch.
>> mutex.h owners proposed such a cleanup patch themselves and there's no 
>> progress since that. How can we move forward on those patches?
>>
>> Cleanup patch:
>> https://lore.kernel.org/lkml/20231216013656.1382213-1-longman@redhat.com/
>>
>> Original problem that requires devm_mutex_init and discussion:
>> https://lore.kernel.org/lkml/ZcZeRmVjEPhVPW9-@smile.fi.intel.com/T/#m0f514f8f96e18db9568f84b2df37aaf648874a4a
> 
> Sorry for my late reply. My cleanup patch was sent at the later half of 
> Dec 2023. It is probably not a good time as maintainers are either busy 
> or taking time off. I have resent the patch again with other cleanup 
> patches. Hopefully those patches can be merged soon.

Hello Waiman.

Good to see you again. I'm sorry if I was too impatient. Thanks for 
updating your patch series.

> 
> Cheers,
> Longman
> 

-- 
Best regards
George

