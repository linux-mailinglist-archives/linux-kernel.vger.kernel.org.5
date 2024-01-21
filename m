Return-Path: <linux-kernel+bounces-31998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B552835518
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C64281639
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F4364BB;
	Sun, 21 Jan 2024 10:04:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3DD2FA;
	Sun, 21 Jan 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705831476; cv=none; b=RKmMCWuTcFVXbKebThPPWs6vkjeDxrxjGCHLoCQ6mrNjkFYvE8fshUnyiQr6rEChgADJVU1fsVgpoihMZMUMvZf7DjOvhWUNWo7h9tXn9XSlGKI/dRn8zmvnNCqTksAdBvqvqs/2ymch8QLzr+X3teeerIN+ZudgKvJrRfAZ0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705831476; c=relaxed/simple;
	bh=qxngiyQFq9H5C3J4+lP+xO5xyCkCDua9O6RXGkP9Zsg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dmTZuYtIFVPMUPk8qZ3Xx89oHBwE0raH4js8HYeivn0LGYKd7CLA1j7hQChbIQn80yrhkGuDBaiwQnZaKya/XZGBeLzJUo5T82hFjsAR8kMQZ2n6w3zzw3xco6RKrysVVdgS2zBXq65gehA01m6sBADyoTfiB+nMcihiDuVUmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRUgq-00069v-Rp; Sun, 21 Jan 2024 11:04:32 +0100
Message-ID: <a901f6d2-2c82-409a-a83c-b338470d9ac5@leemhuis.info>
Date: Sun, 21 Jan 2024 11:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230704121847.GA26576@workstation.local>
 <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
 <ac5091d9-0484-4c63-822d-fe61009b9970@leemhuis.info>
In-Reply-To: <ac5091d9-0484-4c63-822d-fe61009b9970@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705831475;d1200097;
X-HE-SMSGID: 1rRUgq-00069v-Rp

On 27.09.23 15:15, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 26.09.23 11:11, Jiri Slaby wrote:
>>
>> On 04. 07. 23, 14:18, Takashi Sakamoto wrote:
>>> Please pull firewire updates for v6.5-rc1.
>>>
>>> The following changes since commit
>>> 44c026a73be8038f03dbdeef028b642880cf1511:
>>>
>>>    Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)
>>
>> Likely some of the below commits causes an instant reboot during boot as
>> was reported in:
>>   https://bugzilla.suse.com/show_bug.cgi?id=1215436
>>
>> 6.4.* was fine, 6.5.4 or 6.6-rc1 fails.
>>
>> module_blacklist=firewire_ohci fixes the issue on 6.5.4.
>>
>> Any ideas what can cause this? I fail to see an issue in the commits...
>> [...]
> 
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced v6.4..v6.5.3
> https://bugzilla.suse.com/show_bug.cgi?id=1215436
> #regzbot title firewire: instant reboot during boot
> #regzbot ignore-activity

#regzbot fix: ac9184fbb8478dab4a0724b279f94956b69be827
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

