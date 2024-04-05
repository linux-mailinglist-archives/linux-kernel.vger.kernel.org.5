Return-Path: <linux-kernel+bounces-132660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33898997E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DF9B21BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459715FA80;
	Fri,  5 Apr 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="T6amqLXC"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC579145B09;
	Fri,  5 Apr 2024 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306075; cv=none; b=oBxq1bqma3AghioY3O9H3KXs6eSGdpOdjgao8l6HZl1cpRqPQZlM3zQ8o9doFKNVczAsPxtPx7N3qBUjdnIpmdA6uXsmmdwxNBVXlvz5lUAi+9l9vU2RhoAV+37SB00el9hyfMYWUYGo9K6S7K5AJ4cRwnrdnHEsVq0SI2Ka+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306075; c=relaxed/simple;
	bh=Yako+DMTpbUlsWgZYmb5aBvtdempxtUvW+SFSwCrbYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSCfDcak1Y7ZGXWSaZpvXXeS/2Plpto2iMKL/wJcScRETkPT41W/JQfh8XdhlA6ophpggutU7+q2cXzts3A4UTYaarqWORKaoSMi+mD0jfsMfq4T1ADztUiVzNvOqMkazA+vewIGRKpvxBWdF9JA4j7oFKmi9NfAyBwb/bOvdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=T6amqLXC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=DLsk7UNbl2mGLlf8AChN6UTKTKuAoEYD5hs7O3ETLuk=;
	t=1712306073; x=1712738073; b=T6amqLXCw+tbHT8+D+/EV2iwEqf0JJktgLc4i38HU4TOkRM
	m+ZT746D9qjHKwl9U8XGGOfahxqNV4IoAK+3NmGatsanFtOUsKcK78mb6unPRRNvjo79huRQvqOTA
	MTIibIrxxcm+/KmwsKXs7kEUSUB4WTu5lnbafy6yKgniBeSeS7GAzmrZO7Fxo4WxOa5sBb/eoap5l
	ie5XiJFybSxZ5+yHHiUE9OVVuz7qPz/ULurc6P05dtNdzwB8nMHCvHA2oapkrdS8GE7YiKbVmpBvy
	qcGMSyCuTtWrhdU7hwMMrWNIEn9/GEt/KlSoCiduwLSt68kTrnv0Efy1h39rv2jA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rsf1n-0000E9-IL; Fri, 05 Apr 2024 10:34:27 +0200
Message-ID: <2d822b6c-8b55-443d-ad9e-03e97ce7b99b@leemhuis.info>
Date: Fri, 5 Apr 2024 10:34:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
To: Mike Lothian <mike@fireburn.co.uk>, peter.tsao@mediatek.com
Cc: aaron.hou@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, sean.wang@mediatek.com,
 steve.lee@mediatek.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
 <20240401144424.1714-1-mike@fireburn.co.uk>
 <CAHbf0-FqUqoDty81OH9_Et7MTWFikYYhEvP7SBVGyeXO-R94_A@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAHbf0-FqUqoDty81OH9_Et7MTWFikYYhEvP7SBVGyeXO-R94_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712306073;1a58ee15;
X-HE-SMSGID: 1rsf1n-0000E9-IL

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 01.04.24 17:20, Mike Lothian wrote:
> On Mon, 1 Apr 2024 at 15:44, Mike Lothian <mike@fireburn.co.uk> wrote:
>>
>> I think this patch is causing issues with older firmware
>>
>> Bus 003 Device 002: ID 13d3:3563 IMC Networks Wireless_Device
>>
>> [    0.315064] Bluetooth: Core ver 2.22
>> [    0.315064] NET: Registered PF_BLUETOOTH protocol family
>> [    0.315064] Bluetooth: HCI device and connection manager initialized
>> [    0.315064] Bluetooth: HCI socket layer initialized
>> [    0.315064] Bluetooth: L2CAP socket layer initialized
>> [    0.315064] Bluetooth: SCO socket layer initialized
>> [    4.670811] Bluetooth: RFCOMM TTY layer initialized
>> [    4.671029] Bluetooth: RFCOMM socket layer initialized
>> [    4.671790] Bluetooth: RFCOMM ver 1.11
>> [    4.673416] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [    4.673659] Bluetooth: BNEP filters: protocol multicast
>> [    4.673895] Bluetooth: BNEP socket layer initialized
>> [    4.674125] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>> [    4.674360] Bluetooth: HIDP socket layer initialized
>> [    5.016365] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin failed with error -2
>> [    5.017163] Bluetooth: hci0: Failed to load firmware file (-2)
>> [    5.017557] Bluetooth: hci0: Failed to set up firmware (-2)
>> [    5.018129] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>>
>> The correct name should be mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
>>
>> Reverting this patch fixes things
> 
> If it helps, the device ID is 0x7961 and the fw_flavour is 24 or 0x18 in hex

Thanks for the report!

Peter, did you look into this?

Anyway: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot report:
https://lore.kernel.org/all/20240401144424.1714-1-mike@fireburn.co.uk/
#regzbot introduced: 1cb63d80fff6c4
#regzbot title: net: Bluetooth: firmware loading problems with older
firmware
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

