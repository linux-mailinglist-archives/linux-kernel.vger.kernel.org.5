Return-Path: <linux-kernel+bounces-111344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF9886AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4487EB216C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AE3E47A;
	Fri, 22 Mar 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aOXwkk6i"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826E3E479;
	Fri, 22 Mar 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105324; cv=none; b=kpzVTWY5CtjonOSEcdMP4bUKvtBhQbmwca9tGTpdiefWwE+kRLr4mgPiVHNCJhYNay0GDja/cPNgRHRWspMhPutpijYOSUAjzA5QVyd8Ke8IYwB2TdMgtUpjvAa9iake4pTfGyBx5G2WOvbw87zMYaiBijD2njHkiG3FO6cg+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105324; c=relaxed/simple;
	bh=DNDM9B9ksrZKSGXDoW6GLQK1di53GABk/SxYnxD0ID4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpA18iRxHyCowhfJFp9k/cMkpykfspSY5X6xmWv7VGF8gf8M5tUjFErMHD2kVli6cpL1kCStVvfzW0ZHy/i9UuLHWhbeVqk2ragnTUcvfNHtM8EiKR4mYmgV+RpMjLNazIQD0HuRlHZyymrotEXSJSGbzaQ9Yd4+iBih1/M0ANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aOXwkk6i; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=jOb6LgQkAYOowfd3TpK62M7x65cNcm8EVJDYWoVUq0o=;
	t=1711105322; x=1711537322; b=aOXwkk6irLvjl9Fm6k3ejyqMRYxk4ErvGPKuozLNMVfX162
	GV2CLH0E8hcS2zjaF2YR1JliiWgqqytJc1I50BfZVker6I7HOinRKEOXHK8POvzLOWwUmQAtU4wXP
	QBSfOuAywOFScuu48W8ggL+vGhqXFGNvOXII2iZK0lC2tb0kAJo9FXwPEi7lAqe6GyddrSoYU0eVQ
	GSQs1TrncqrcRnrXR0esMA03nf1YsJnbfSTeI7mDkvnC7JOFL7QfyCA5QqXQoChDJDW4j+YcpEMth
	9eZ22V3X+504NnXaaV8uMCZ9KHfKYulWFZH0IeFB7Rg20CPQArXRAXWuw+2Dv0cA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rncen-0000K5-P3; Fri, 22 Mar 2024 12:01:53 +0100
Message-ID: <5e278d43-93dd-47ac-8502-28db2fcd32f9@leemhuis.info>
Date: Fri, 22 Mar 2024 12:01:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jkosina@suse.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711105322;b07c2670;
X-HE-SMSGID: 1rncen-0000K5-P3

[BCCed Greg and the stable list, as this is apparently a mainline
regression and has nothing to do with the stable series

Also CCing Jiri, Benjamin as well as various lists]

On 19.03.24 05:52, Philip Müller wrote:
> On 18/03/2024 17:58, Philip Müller wrote:
>> I'm currently developing on the OrangePi Neo-01, which ships with two
>> similar touchpads using the Synaptics driver. On 6.7.10 those two
>> devices get detected normally. On 6.8.1 it seems to error out.

Thx or the report.

>> I either get none, or at best only one of those two devices.
>>
>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
> 
> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling

FWIW, that's a change from Hans. He is normally quite responsive, but as
he has not replied yet I guess he is AFK for a few days.

Ciao, Thorsten

> When I use the commit before I can rmmod and modprobe in a batch script
> using a loop without erroring out to -110. Attached the testing script
> and dmesg log snippets
> 
> #!/bin/bash
> for ((n=0;n<5;n++))
> do
> sudo rmmod i2c_hid_acpi
> sleep 1
> sudo modprobe i2c_hid_acpi --force-vermagic
> sleep 2
> done
> 
> I will try to use the code of 6.8.1 and revert that commit.

P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot report /
#regzbot introduced aa69d6974185e9f7a552ba982540a38e34f69690
#regzbot title HID: i2c-hid: probe of i2c-XXX0001:00 failed with error -110
#regzbot ignore-activity

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

