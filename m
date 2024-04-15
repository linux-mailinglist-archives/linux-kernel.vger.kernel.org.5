Return-Path: <linux-kernel+bounces-145070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB38A4F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AF31F20583
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46C6CDCF;
	Mon, 15 Apr 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uaUeMkCI"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB41FA1;
	Mon, 15 Apr 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184264; cv=none; b=ikY2jOCXWEqLyNN3zAS2ZH/y2QLqKMP2n0312QK53V/Lp6scPUrUL/OPjC+DmgXzBxyoHyDLDZfbMaPFlM+RhTsf4JLHPFsCIrEGeh/rt/83WF1CsFKMdUHxaLaYqNGxhEDdbIKGaHXuVqrhN8xW4NXV1+MhYqmX8rJ2YiV/LT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184264; c=relaxed/simple;
	bh=bPep+N9XIwW1XB+4tjXi7DEWWpImBvt7KLF6vBWpfKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/AIYZFxi/WUIMQTE3dWxJHo2OKq7be7Ujwd6vATXF/kiHhXhYtLogz7ULEp8bvGeYgA1KtF2hMk2rTsmagYSTfkMFW1QlllRAEHyCEBGTNHUOFvyRis9Elx4HE1KEINhmaRiam52gUICt8MIfEWyUEcDc5zIXyv81xzgJHi/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uaUeMkCI; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=StS4x0S3//04l7wNyiAlQ2KElGTWLVjD4MZApYb4baA=;
	t=1713184260; x=1713616260; b=uaUeMkCI+6lJ+Bywz0JGb7PBEJwH35F/1ao/Wtb4I25MzA6
	aekZmpzm2FwBSYyseiVRxRURMQi+5UH/gmoeO5vWz4UQRhd5XdFiMlHWnvhKWKhGBW4gqR8zUoNku
	j0Nu2Es1ZCUmG18zgrrgEfNYmRHQAd7HnATrpjAwp/SbPQwhioxm7MqKE4Sm/yp6ULk2nCDJqnVX1
	80w4Q7VdISCFmRf3L/kxcRlZMQhjerPb5YwxN+2zil/G7V16cRGixxGz1at8pT8GaMB7vLgyDTWmx
	VYYvjyGQYiPBVzikv9xef2qApLNbn6NhAiJefjteHQAnmWEPD/uIUwTt3KkpbzOg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rwLU4-0001A5-KM; Mon, 15 Apr 2024 14:30:52 +0200
Message-ID: <5c0ce057-992b-4200-bb74-b84826974860@leemhuis.info>
Date: Mon, 15 Apr 2024 14:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
To: =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 =?UTF-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>,
 "mike@fireburn.co.uk" <mike@fireburn.co.uk>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
 <Aaron.Hou@mediatek.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
 <20240401144424.1714-1-mike@fireburn.co.uk>
 <CAHbf0-FqUqoDty81OH9_Et7MTWFikYYhEvP7SBVGyeXO-R94_A@mail.gmail.com>
 <2d822b6c-8b55-443d-ad9e-03e97ce7b99b@leemhuis.info>
 <11f098c7cc3a063fd20c02f1a66372e3444cb272.camel@mediatek.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <11f098c7cc3a063fd20c02f1a66372e3444cb272.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713184260;30b9f5a3;
X-HE-SMSGID: 1rwLU4-0001A5-KM

On 05.04.24 11:15, Deren Wu (武德仁) wrote:
> 
> Thanks for the note. We are looking for solution for this issue. Peter
> would post the new patch. :)

Anyone still working on this, as that afaics did not happen -- or was
there progress and I just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> On Fri, 2024-04-05 at 10:34 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> [CCing the regression list, as it should be in the loop for
>> regressions:
>>
> https://urldefense.com/v3/__https://docs.kernel.org/admin-guide/reporting-regressions.html__;!!CTRNKA9wMg0ARbw!n9OQDQtfMiQdddzNLvMEOMLnnEHhw12KRY5W5YPscQJTiNQtuIVuJufNc2UYpy-rUlRtMUwZsL5NDERIf1CoGox8J2I$
>>  ]
>>
>> On 01.04.24 17:20, Mike Lothian wrote:
>>> On Mon, 1 Apr 2024 at 15:44, Mike Lothian <mike@fireburn.co.uk>
>>> wrote:
>>>>
>>>> I think this patch is causing issues with older firmware
>>>>
>>>> Bus 003 Device 002: ID 13d3:3563 IMC Networks Wireless_Device
>>>>
>>>> [    0.315064] Bluetooth: Core ver 2.22
>>>> [    0.315064] NET: Registered PF_BLUETOOTH protocol family
>>>> [    0.315064] Bluetooth: HCI device and connection manager
>>>> initialized
>>>> [    0.315064] Bluetooth: HCI socket layer initialized
>>>> [    0.315064] Bluetooth: L2CAP socket layer initialized
>>>> [    0.315064] Bluetooth: SCO socket layer initialized
>>>> [    4.670811] Bluetooth: RFCOMM TTY layer initialized
>>>> [    4.671029] Bluetooth: RFCOMM socket layer initialized
>>>> [    4.671790] Bluetooth: RFCOMM ver 1.11
>>>> [    4.673416] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>>> [    4.673659] Bluetooth: BNEP filters: protocol multicast
>>>> [    4.673895] Bluetooth: BNEP socket layer initialized
>>>> [    4.674125] Bluetooth: HIDP (Human Interface Emulation) ver
>>>> 1.2
>>>> [    4.674360] Bluetooth: HIDP socket layer initialized
>>>> [    5.016365] bluetooth hci0: Direct firmware load for
>>>> mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin failed with error -2
>>>> [    5.017163] Bluetooth: hci0: Failed to load firmware file (-2)
>>>> [    5.017557] Bluetooth: hci0: Failed to set up firmware (-2)
>>>> [    5.018129] Bluetooth: hci0: HCI Enhanced Setup Synchronous
>>>> Connection command is advertised, but not supported.
>>>>
>>>> The correct name should be
>>>> mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
>>>>
>>>> Reverting this patch fixes things
>>>
>>> If it helps, the device ID is 0x7961 and the fw_flavour is 24 or
>>> 0x18 in hex
>>
>> Thanks for the report!
>>
>> Peter, did you look into this?
>>
>> Anyway: To be sure the issue doesn't fall through the cracks
>> unnoticed,
>> I'm adding it to regzbot, the Linux kernel regression tracking bot:
>>
>> #regzbot report:
>>
> https://lore.kernel.org/all/20240401144424.1714-1-mike@fireburn.co.uk/
>> #regzbot introduced: 1cb63d80fff6c4
>> #regzbot title: net: Bluetooth: firmware loading problems with older
>> firmware
>> #regzbot ignore-activity
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>> hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>>
> https://urldefense.com/v3/__https://linux-regtracking.leemhuis.info/about/*tldr__;Iw!!CTRNKA9wMg0ARbw!n9OQDQtfMiQdddzNLvMEOMLnnEHhw12KRY5W5YPscQJTiNQtuIVuJufNc2UYpy-rUlRtMUwZsL5NDERIf1CoQcaol0s$
>>  
>> That page also explains what to do if mails like this annoy you.

