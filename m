Return-Path: <linux-kernel+bounces-24630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E382BF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38129287D49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F856A002;
	Fri, 12 Jan 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VFLkmTpb"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5D67E8D;
	Fri, 12 Jan 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 879AD12002F;
	Fri, 12 Jan 2024 14:43:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 879AD12002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1705059799;
	bh=/eFJ5zdlWZNOA1X7gSb3A6Ck0vtdZ8leabcrBG+9O8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=VFLkmTpbsuaDh9fUiaAHc/e91SwHDXGr9Hl/DuIdmwY5PtJpMImE0QbkBFONyvatX
	 qPQ/BLzDIybSKiWn+rOL2TGdSEwubOPUc2o1AkM1QYftQxGVIuI0J7eKRyJ9sSO9LC
	 U9HkNWEuEU5MEfJJj3AOjjSQEQ04VGAYs9q6En9iD00pGfCBYn4FLXJkq4rBE0M/J+
	 ZM9RCt2lw/kKRGOpmoz/3qcga8qiOWD/ajctSAY8ken5j6hdsbqbKq501RAuh01FP0
	 ZiUPbnfWRPlLuUJXSEEsK2PClikXCrGjgn7mvv6oCiWUQSyL+5lJ15JqOSkw84SRPe
	 /UFCsSnpvBiCw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 12 Jan 2024 14:43:17 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 14:43:17 +0300
Message-ID: <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
Date: Fri, 12 Jan 2024 14:43:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Content-Language: en-US
To: Lee Jones <lee@kernel.org>
CC: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel@salutedevices.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20231221161011.GO10102@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182598 [Jan 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/12 10:31:00 #23117109
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Lee,

On 21.12.2023 19:10, Lee Jones wrote:
> On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> 
>> This led-controller supports 3 pattern controllers for auto breathing or
>> group dimming control. Each pattern controller can work in auto
>> breathing or manual control mode. All breathing parameters including
>> rising/falling slope, on/off time, repeat times, min/max brightness
>> and so on are configurable.
>>
>> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
>> ---
>>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
>>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
>>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
>>  3 files changed, 1031 insertions(+)
>>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> 
> This interface is bananas.  Exposing an entire register interface to
> sysfs does not sit will with me at all.  When we add support to a sysfs
> class, we usually require it to be generic and work across all devices.
> Adding device specific interfaces is generally decried and to be
> avoided.  Don't forget, once we commit something to sysfs, it becomes
> ABI and we have to support it forever.
> 
> A far better approach would be to add support for this in userspace
> instead  You can use the standard I2C character device API to achieve
> the same result.  That way we don't have the same level of commitment
> and is generally a much more flexible/future-proof.
> 

I used sysfs similarly to other LED drivers (for example, leds-lm3533).
Additionally, the controller has interrupts about the completion of the pattern,
which is best to handle in the kernel. In the case of implementation in user
mode, there may be synchronization problems, as the controller has several
memory pages that can be switched by writing the page number to register 0xF0.

-- 
Best Regards,
Martin Kurbanov

