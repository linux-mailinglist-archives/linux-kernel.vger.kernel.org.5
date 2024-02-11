Return-Path: <linux-kernel+bounces-61024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B08850C62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813CBB216F0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95C17564;
	Sun, 11 Feb 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kNtNTle/"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601E17557;
	Sun, 11 Feb 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695533; cv=none; b=VOUuhfW7vP1qqnxNlX903OIKpH9bYcBGNxpfWzHXhXCFOAyjfYTi97kyxvnVoJ7rcwT6rj0WM50fOmp9Cju/5aKKubf4wervJFNNbxnx8X22pOG6G+txIaQ8g9j4uTkICzcJb2EDZglQNmzWxfRO8DpRZA15tAOahCh1H64+zLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695533; c=relaxed/simple;
	bh=lkgoJmksyXGMZ3z/tr7z4ObnZYK5CflsLDGo0yBYGV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rbxseMzviCUkslZxNdsZhWm3wO7rFQaH9w7KtxaAcBpEyWui2dTzYtaFHh7QCum2xCA0hV7uOmzjjzHsWlpO9eUKzbp8xTKX/G3tUv1RnCcsCBpOvw560v5gZiSFkVPtqk0IyofBOXKJo0z/s7Co8GO8yA6Xcf8Sp4E9oDTnCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kNtNTle/; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 04368100008;
	Mon, 12 Feb 2024 02:52:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 04368100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707695527;
	bh=IMiP40KbV9wZozYYHWOgNE0Ph2d3x1wnOAFT2nZOhok=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=kNtNTle/RZipPAFjGEP5tKgjDqH7AH1NsdRvCStWpKRXRS8zjTxxQmbh0bUdpxWrH
	 Lnv5mH6RZQh5vLKMuB8qTl3VMsmm+xmo5BGW5WIRV3y//9BFe0exM94ahwBzfuW6Hz
	 R33y0nHOlmi+2QmTbfswXzJwSZ+nnCHgrKx0LLUj1gPr+jMU9dh377Ma8zGmB5JFUV
	 PFn2PZuo4cP1IffurE76oZp6vjV1ROH9vUfunCC5NA1svLdW5aV1+ZquGT/8mMSlo8
	 KhRZMRSt15qSMqzfM0atHzHi3B3BcTXoBJLFKxxG50/yZvL8hY8oKwSW9suacJ14sn
	 zfHwGvwPzL7Aw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 02:52:06 +0300 (MSK)
Received: from [172.28.160.241] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 02:52:06 +0300
Message-ID: <d844862e-1d1c-4c9a-b7fe-e0ac44f4126e@salutedevices.com>
Date: Mon, 12 Feb 2024 02:52:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][SPF error] Re: [PATCH v4 00/10]
 devm_led_classdev_register() usage problem
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <pavel@ucw.cz>, <vadimp@nvidia.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <linux-leds@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Lee Jones
	<lee@kernel.org>, <kernel@salutedevices.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231221151111.GJ10102@google.com> <ZcZcpUHygltD2ETa@smile.fi.intel.com>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <ZcZcpUHygltD2ETa@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183351 [Feb 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_urls_end_caps}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/11 23:16:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/11 23:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/11 20:38:00 #23539253
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Andy.


I haven't lose hope for the devm_mutex thing and keep pinging those guys 
from time to time.

Sure I can single out the fix-only patch I'll do it tomorrow.


On 2/9/24 20:11, Andy Shevchenko wrote:
> On Thu, Dec 21, 2023 at 03:11:11PM +0000, Lee Jones wrote:
>> On Thu, 14 Dec 2023, George Stark wrote:
>>
>>> This patch series fixes the problem of devm_led_classdev_register misusing.
>>>
>>> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
>>> is used then led_classdev_unregister() called after driver's remove() callback.
>>> led_classdev_unregister() calls driver's brightness_set callback and that callback
>>> may use resources which were destroyed already in driver's remove().
>>>
>>> After discussion with maintainers [2] [3] we decided:
>>> 1) don't touch led subsytem core code and don't remove led_set_brightness() from it
>>> but fix drivers
>>> 2) don't use devm_led_classdev_unregister
>>>
>>> So the solution is to use devm wrappers for all resources
>>> driver's brightness_set() depends on. And introduce dedicated devm wrapper
>>> for mutex as it's often used resource.
>>>
>>> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
>>> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
>>> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383
> 
> ...
> 
>> FYI: I'll conduct my review once the locking side is settled.
> 
> To reduce burden can you apply the first one? It's a fix.
> 

-- 
Best regards
George

