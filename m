Return-Path: <linux-kernel+bounces-99680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD7878BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B9BB20A30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDA4430;
	Tue, 12 Mar 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tUE0gtzI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1128E7;
	Tue, 12 Mar 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201688; cv=none; b=OWauxBN0BUsBYA3V06QcUetCbD/Gi84erThZfAVFT7JwzW9PSpbSmZ0pHBHRJXtZvDkNipW6c7xaVsVFkMpGd7VcdweN5kY1MiWObRrvLUfnENorzGjbGnTOHfpXLk9KhAuYkHS6ANURy8rTUh17yUmzMTsHjbTzIhal5cbY+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201688; c=relaxed/simple;
	bh=GeZsYznIGTP3qixonCG7cT/PIBuzAYo3PpP87XhnnUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cpabJ+hGycnoa9DLVOvqgSvRFV6sB3XjfvQnG6XWbVnQEKaNQO0LqAvC9UrIuFhaSQ2zbKnBe83uDaMS3oj4/9S3G64fHSjfxYYDyF085CpZt+zYEMXF9dfTr6vodBNi5af3wX41xpgTxhDVsOhoF/gxcMsNl8q3DHC8nFKFYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tUE0gtzI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3EB32100005;
	Tue, 12 Mar 2024 03:01:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3EB32100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710201682;
	bh=AYogXDFWk0vVK9Bn0RzjwmQ4yDt/pcDp8R+IGvzlJqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=tUE0gtzIz2fZtZBECrQFgTAN85nrFZTDnwi9I815zB1qvb3aDwut2BQI9nUxuttgo
	 AVShDwMjAPX9IZjm8ZSyLsvokwBkCTtFcZPdERpWggfMt9Ac7CaSq0jgeBQMqrLd63
	 YeBfyQLInCaup4CFe4lTPw8fh9CbOWvkgyZ1KP61nZf4rw4W1u/lYRjCIziWZ2swVw
	 5RhQfxDb7CTXmJn2oWD4IYiQweJKfNcjNZsfIeNd/aizXSSo75m1XFtkH3JX9/CWFv
	 ElQv3ngxWxTLgBgrpvHZ/k1qWFkVHAFi+vo7CMNcdFAlsG3JimLOSRtgWSsMSbq5NY
	 r9cLygfouw8hQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Mar 2024 03:01:22 +0300 (MSK)
Received: from [172.28.160.241] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 03:01:21 +0300
Message-ID: <5ef5fb8d-f1be-4c8e-92fe-f40b68478228@salutedevices.com>
Date: Tue, 12 Mar 2024 03:01:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<hdegoede@redhat.com>, <mazziesaccount@gmail.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
	<boqun.feng@gmail.com>, <nikitos.tr@gmail.com>, <kabel@kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
 <20240307024034.1548605-3-gnstark@salutedevices.com>
 <CAHp75VfkTxRtMc_SpXoyoVjiWxm=c6_1VjeiRFUo4C7kH4HmUA@mail.gmail.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <CAHp75VfkTxRtMc_SpXoyoVjiWxm=c6_1VjeiRFUo4C7kH4HmUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Andy

On 3/7/24 13:34, Andy Shevchenko wrote:
> On Thu, Mar 7, 2024 at 4:40 AM George Stark <gnstark@salutedevices.com> wrote:
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
> 
>>   Hello Christophe. Hope you don't mind I put you SoB tag because you helped alot
>>   to make this patch happen.
> 
> You also need to figure out who should be the author of the patch and
> probably add a (missing) Co-developed-by. After all you should also
> follow the correct order of SoBs.
> 

Thanks for the review.
I explained in the other letter as I see it. So I'd leave myself
as author and add appropriate tag with Christophe's name.
BTW what do you mean by correct SoB order?
Is it alphabetical order or order of importance?

-- 
Best regards
George

