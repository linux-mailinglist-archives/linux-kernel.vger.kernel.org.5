Return-Path: <linux-kernel+bounces-123253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816389052A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D831F25DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D813175F;
	Thu, 28 Mar 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="UWAu7LtF"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031577FBB3;
	Thu, 28 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643278; cv=none; b=Hr84+2cPzh3OIhIrAP5I+kkrqDya91GEGgBsOG+8prZwWm2MhyZ4QK8kUAKh32Dz43aM8ZmK9QBwdaYZMG0ZaPHyMxf7caaNBRIKUshggtI6RpWsSuerNw+1SbPQZ+3HDjy1TYc0CMiOe2zJrO77M5tfEHax6Qiqa7IQKHlckjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643278; c=relaxed/simple;
	bh=7o2HTIdfBemKnLTTYjnlUWvklJzWJZ7+71R6WBP2DGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=CvYWy2KwUZrP6CI7OpLATXYhWZRyGZo9bT36HE1h2HwclNpdBQH1nBbXrJ7ck1zTmLCm9sTmrDddWYVo9VVPDoaAD/aEFOmbItuKV13z68PI2tdV9igfDMKtxyIorF17n/12ihCTGqXtgKmHJgV4m8jrzjaa89jMDb2zIzwwjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=UWAu7LtF; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 3644E100002;
	Thu, 28 Mar 2024 19:27:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711643254; bh=zrXqsnzu7zidWpxPpeZG8J5gRm86ZdPNuJoo2OBBJVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=UWAu7LtFtRG2SA0V8kv3LchzUBSQA02iejbklZ5v1UoE2JOoKaJstBVXj5NFDLXTr
	 AZ6bh/vmyOgRENbfRji4+Z7lhWnzg+wCmvFtCUlj41U7pKAvfYln6m6swE+JVspp7P
	 PXCQ6SAaCtVLHoOjKagH6lBQwEHr/xVxGpU5alNqoiSVfY98ACv/pzQpC7tfNcpTSc
	 vMFYxS7KUU2bfw5MeVORjAxowmD/R8IH/CiVJuuTeVPNF+uK4x3wBdcYqHEUOUsAjw
	 4HJ+UxltQymQZdKu0DkWr0vzZBhZ6ZIxD800tbtIgafqxHXvusG89C3p8V3R4CZtEO
	 BzGY0lqFfXsrw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 28 Mar 2024 19:26:44 +0300 (MSK)
Received: from [172.17.214.6] (172.17.214.6) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Mar
 2024 19:26:23 +0300
Message-ID: <3fac7a3d-cd8a-4367-8ad7-206b850d2e41@t-argos.ru>
Date: Thu, 28 Mar 2024 19:23:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: davinci: Fix potential buffer overflow
Content-Language: ru
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240328091021.18027-1-amishin@t-argos.ru>
 <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>
CC: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F. Davis" <afd@ti.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<"<lvc-project"@linuxtesting.org>
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184474 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 14:55:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/28 12:50:00 #24493847
X-KSMG-AntiVirus-Status: Clean, skipped



28.03.2024 18:27, Alexander Lobakin пишет:
> From: Aleksandr Mishin <amishin@t-argos.ru>
> Date: Thu, 28 Mar 2024 12:10:21 +0300
> 
>> In davinci_gpio_probe() accessing an element of array 'chips->regs' of size 5 and
>> array 'offset_array' of size 5 can lead to a buffer overflow, since the index
>> 'bank' can have an out of range value 63.
>> Fix this bug by limiting top index value.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: c809e37a3b5a ("gpio: davinci: Allocate the correct amount of memory for controller")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>   drivers/gpio/gpio-davinci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>> index bb499e362912..b65df1f2b83f 100644
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -257,6 +257,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>>   	spin_lock_init(&chips->lock);
>>   
>>   	nbank = DIV_ROUND_UP(ngpio, 32);
>> +    if (nbank > MAX_REGS_BANKS || nbank > 5) {
>> +        nbank = MAX_REGS_BANKS < 5 ? MAX_REGS_BANKS : 5;
>> +	}
> 
> Static analysis warnings make no sense until you provide a reliable way
> to trigger the problem on real systems.
> 
>>   	for (bank = 0; bank < nbank; bank++)
>>   		chips->regs[bank] = gpio_base + offset_array[bank];
>>   
> 
> Thanks,
> Olek
> 

I can only see the code at this time. And I see the following:
1. In some configurations CONFIG_ARCH_NR_GPIO value is 2048. So nbank 
value can be 64.
2. Previously, a patch was proposed that removes restrictions on the 
number of GPIOs 
(https://lore.kernel.org/all/cb540a9d73cad36d288664f8b275c6308a4a3168.1662116601.git.christophe.leroy@csgroup.eu/).

-- 
Kind regards
Aleksandr

