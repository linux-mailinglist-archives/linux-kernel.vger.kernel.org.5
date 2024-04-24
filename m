Return-Path: <linux-kernel+bounces-156513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF08B0397
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEB228586E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354C158200;
	Wed, 24 Apr 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="knpp7o+r"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71319158204;
	Wed, 24 Apr 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945463; cv=none; b=rR0dIenwWzkxIMbZ2jrhI9+lMfVECvsSTc4puz+j2SmH37WfemgSc41dUv+CuJ/VDluTUnxnV6qLOUfnysAhptvqkJiJs0l23pHGK4+mbBR9370mxbjBzBpoS6hs+BhP4S5lj3IT1I/hYaaCb28AmS5KhlcFJynjRM2y8AUBY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945463; c=relaxed/simple;
	bh=4rtVE0X0W+VYOde9xnxiY6Ua/MCnujHrvFC8pnUPkTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fSlVO0f3lXGuJyHUgmzGWkWjPZJniUOGeU55lwSUaZuWa5GWtGxWsKFWKflarJHsf1y9lmk6nNJRJPDPCbL5k7GqBcuAHQlmzPIu7Thms3NoOHYOKnRtL9+zAc7zzjC/rkZO8VEe4MNn+j7EisXHj/6/Q3Q4d4TI93dchlF5GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=knpp7o+r; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 73A87100014;
	Wed, 24 Apr 2024 10:57:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 73A87100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713945455;
	bh=MMX6QiCqy4Wkoh4oQ7dRjKfmKsrE2YLbEXXPVkHkon4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=knpp7o+rlSmXPXWuf4/yNNp4X85+CfGDCqeqeTc/IUKAVW90Kc80z8RRcRYbcRpWu
	 GbB3ujXyBOWT3ORfzPNjenLJe4gJ6FXgHZnTo/BN64T0LUlHOD6mAad9nuRtIZWK8J
	 XNIXSOAHiUu+3/jhnR4K74raRpTobcrxVFHTjyRNAgjbkDHwoiFh75X6RTRCv1Cl5N
	 +VaAJU6wgM91mECx5nc9PcqY4Edlh8Pd4Z0NqIHbKifxDsCQfy3p5ehI1X2HgbrDo1
	 GbiGwlGweiNmkH46e2JYvLqixEjoD66BANg10YJa1cbPJRCXRMxlzaqvsKGkRAfqCJ
	 1JjZPFbyUHivA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 10:57:35 +0300 (MSK)
Received: from [172.28.226.27] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Apr 2024 10:57:34 +0300
Message-ID: <6d34b236-4067-42bf-a6f7-d2f3b3270e3b@salutedevices.com>
Date: Wed, 24 Apr 2024 10:57:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pwm: meson: drop unneeded check in get_state callback
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<thierry.reding@gmail.com>, <hkallweit1@gmail.com>,
	<linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20240423161356.2522636-1-gnstark@salutedevices.com>
 <20240423161356.2522636-2-gnstark@salutedevices.com>
 <wkn6ybnnlco7vrqbpclfxaajt5cvywpr633au7qcr6vpjihabq@kb7q6y4khh2k>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <wkn6ybnnlco7vrqbpclfxaajt5cvywpr633au7qcr6vpjihabq@kb7q6y4khh2k>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184892 [Apr 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/24 05:07:00 #24952670
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Uwe

Thanks for the review

On 4/24/24 10:19, Uwe Kleine-König wrote:
> Hello George,
> 
> On Tue, Apr 23, 2024 at 07:13:55PM +0300, George Stark wrote:
>> Drop checking state argument for null pointer in meson_pwm_get_state()
>> due to it is called only from pwm core with always valid arguments.
>>
>> Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> I'd apply this one with the following changes if you agree:
> 
>   - capitalize "drop" in the Subject line
>   - s/get_state/.get_state()/
>   - make "null" all caps (i.e. "NULL")
>   - swap the order of Signed-off-by lines to have yours last.
> 
> Alternatively send it in a v2 together with addressing the comment in
> the second patch.

I agree with the proposed changes and
I'll clean it up after myself in v2

> Best regards
> Uwe
> 

-- 
Best regards
George

