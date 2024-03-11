Return-Path: <linux-kernel+bounces-99661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F261878B89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB3C1F21689
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8559B48;
	Mon, 11 Mar 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RNY/olFU"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AF58AC0;
	Mon, 11 Mar 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199900; cv=none; b=qALe2IrMZQVFJdbG/o/ApemVP6ayRZtaca0w6GH/qBdmClf6+TCjdO5By7Lp1kOTZikd9bS0cIoIz35kQ4M++iSyPvlj0oWdHh6710uV2Jt/oOhv9wfye4scLJdLw0o+yykksCGcASajOMK/bwYTBV8Oc7wk7R6zoGaj5ZdQh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199900; c=relaxed/simple;
	bh=xda1DjtsO26KoNNqQ4yv4DiHmO/Gu1jjoseWnxR+l9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Msr/IoYvmZnpXcKXg0mNIEqTP0Yb56nHjNVWS6Nu7t5sp9CVKk3y/qRavtfGMAcaOW7pfw90ArwxJxTP3tKhP3YYq/JfFxXsqMAEob1uRixAFOXwfZuRg+uhBHGS6CzTo9WHG7lbgPUFp+bfnOkFB1OmeoEuEbP21wcq7TN9mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RNY/olFU; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4A10E100003;
	Tue, 12 Mar 2024 02:31:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4A10E100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710199886;
	bh=uEwQ4ROw4TAZrCT3ztOPL4T42aaQ+bdG8DJJXy5LAdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=RNY/olFUNBbT4wszWQF/A8YfGOl6KZ+3bSGVQVBZqtsPu0486mMjDBH3aASJt7r4S
	 bip+Xtb0RD1vCVmAjV4wGHmbNLZKf3lt3LtCl1eXeMlaLCWhS2VYYgNlvOIQPPkMMw
	 ike65JIYEIs7YqqE75dnD1EFvXtb3RT1VqPj1YA9snUpkZCNLI0r9P2eDqRTNx/rOI
	 WgrFW5W86UxK+GkS3xYHARobRq7l+0Mj+u6sLA+aoIbWmjIoWXNLjqGV9BU4OWT/IP
	 dBQ8z/yOQ7t62cComO4bmO28G6lcKYZbbIwc1w6cRJ75KhjUU3jGjSBU9d/Jd7OVs+
	 P1p3qOUCOvQVg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Mar 2024 02:31:26 +0300 (MSK)
Received: from [172.28.160.241] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:31:25 +0300
Message-ID: <fb7e3e79-d0ce-4142-b372-a0ee0a8a3036@salutedevices.com>
Date: Tue, 12 Mar 2024 02:31:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "pavel@ucw.cz"
	<pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>, "vadimp@nvidia.com"
	<vadimp@nvidia.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "hdegoede@redhat.com"
	<hdegoede@redhat.com>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"nikitos.tr@gmail.com" <nikitos.tr@gmail.com>, "kabel@kernel.org"
	<kabel@kernel.org>
CC: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
 <20240307024034.1548605-3-gnstark@salutedevices.com>
 <598887eb-b1b9-4bc1-adf3-4fd758ac2d9f@csgroup.eu>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <598887eb-b1b9-4bc1-adf3-4fd758ac2d9f@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 16:52:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 16:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Christophe

On 3/7/24 16:50, Christophe Leroy wrote:
> 
> 
> Le 07/03/2024 à 03:40, George Stark a écrit :
>> [Vous ne recevez pas souvent de courriers de gnstark@salutedevices.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Using of devm API leads to a certain order of releasing resources.
>> So all dependent resources which are not devm-wrapped should be deleted
>> with respect to devm-release order. Mutex is one of such objects that
>> often is bound to other resources and has no own devm wrapping.
>> Since mutex_destroy() actually does nothing in non-debug builds
>> frequently calling mutex_destroy() is just ignored which is safe for now
>> but wrong formally and can lead to a problem if mutex_destroy() will be
>> extended so introduce devm_mutex_init()
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>    Hello Christophe. Hope you don't mind I put you SoB tag because you helped alot
>>    to make this patch happen.
> 
> Up to you, I sent a RFC patch based on yours with my ideas included
> because an exemple is easier than a lot of words for understanding, and
> my scripts automatically sets the Signed-off-by: but feel free to change
> it to Suggested-by:

Although we had close ideas for the final patch in v4
you encouraged me to do it in the right (=effective) way and go back
from devm-helpers.h to mutex.h in the first place, reinforced the 
concept with appropriate examples from existing code, reviewed a lot. 
Thanks. Probably Suggested-by: is more suited here

-- 
Best regards
George

