Return-Path: <linux-kernel+bounces-131102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3489831E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719481F242EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1136BFCA;
	Thu,  4 Apr 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Lxpeo/wk"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F76BFBC;
	Thu,  4 Apr 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219059; cv=none; b=Irihw8Hg7tWONnaYT84vSUcDBvKM3UuR3Jy8bxjosDjF0IBOliBxWFuh3jHL3DBNAJZPSvlw/ka56wZnIEbOli3he4siUEKdqHYZH4cAtvPfPA4NjtzlNB7mA8Gpz5UuEfsjJoMOl6Yu/btf2h8mhjKAjMzaUUv+Y4vxse3DCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219059; c=relaxed/simple;
	bh=Xiky37y0FVCAukEVsbmR8hxRhEPp5/sXaebaNNQ8odM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sof7vhMRSrpSw/N+C6sefp0rarGFB8h8gQfkxMsdKMbadUUuFG2u7xOAhW63O5pQnAH6VNJN99YfYvZUBs8Cs/FOVBoOqCGk6x+nwxg6rZ+aJZwJC2UskdvbAEdYs0dKM//i+SI4sXOpobRL3fO6VvOHjY5SCobiMm6QV28Lj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Lxpeo/wk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Xiky37y0FVCAukEVsbmR8hxRhEPp5/sXaebaNNQ8odM=;
	t=1712219057; x=1712651057; b=Lxpeo/wk1olN+l+0i/L5HcPRR0u8cnx68fbWHpVUMnm6J3G
	eHlK2mLRSxB5LRfJQf0nFh4ZVj4RzTnKKUIbnB8I4poPHmJzzBF6rqj9udi6UgwU2SnzUt91a68/f
	61v7EGFTsE/VP37VFdNRNsqQ4ZDYF/010FEy/IgqWpPn3yV3J8ocOnkHDhs58vOGKBkygMNAou9Pr
	QXHif/Sh/O1CFk5mvumEVIi64otaOu5Um4j1ryVb6O8deafBIvdOY0QHLIOX6C4BbGnQp/F37/Z2d
	0DPtzcqkzuYTqAB332GJZVaPVF5mtCg/KqV0ExW+p3FSc4TFo/Bi4grTbDMMGHHA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rsION-0008TL-Es; Thu, 04 Apr 2024 10:24:15 +0200
Message-ID: <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info>
Date: Thu, 4 Apr 2024 10:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
To: tglx@linutronix.de
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Laura Nao <laura.nao@collabora.com>,
 the arch/x86 maintainers <x86@kernel.org>
References: <20240328094433.20737-1-laura.nao@collabora.com>
 <20240328115015.36646-1-laura.nao@collabora.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240328115015.36646-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712219057;397b356c;
X-HE-SMSGID: 1rsION-0008TL-Es

[/me added x86 team]

On 28.03.24 12:50, Laura Nao wrote:
>>
>> I ran a manual bisection to track down the root cause for this
>> regression and landed on the c749ce
>> commit from this series:
>> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/

FWIW, that commit is c749ce393b8fe9 ("x86/cpu: Use common topology code
for AMD") from tglx that was part of the "x86/cpu: Rework topology
evaluation" series.

>> Do you have any insight on this issue or any suggestion on how to
>> effectively debug this?
>>
>> Thank you!

Hmmm, it looks like this did not make any progress. Thomas, did this
fall through the cracks due to Easter, or is this this on your todo list?

Or was there some progress and I just missed it?

Laura Nao, I assume the problem is still happening?

FWIW, this was the initial problem description:

>>> KernelCI has identified a mainline boot regression [1] on the following
>>> AMD Stoney Ridge Chromebooks (grunt family), between v6.8 (e8f897) and
>>> v6.8-1185-g855684c7d938 (855684):
>>> - Acer Chromebook Spin 311 R721T (codename kasumi360)
>>> - HP Chromebook 14 (codename careena)
>>> - HP Chromebook 11A G6 EE (codename barla)
>>>
>>> The kernel doesn't boot at all and nothing is reported on the serial
>>> console after "Starting kernel ...". The issue is still present on the
>>> latest mainline revision.
>>> The defconfig used by KernelCI for the boot tests can be found in [2].
>>>
>>> Sending this report in order to track the regression while a fix is
>>> identified.
>>>
>>> Thanks,
>>>
>>> Laura
>>>
>>> [1] https://linux.kernelci.org/test/case/id/65fca98e3883a392524c4380/
>>> [2]
>>> https://storage.kernelci.org/mainline/master/v6.8-11837-g2ac2b1665d3fb/x86_64/x86_64_defconfig%2Bx86-board/gcc-10/config/kernel.config


Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

