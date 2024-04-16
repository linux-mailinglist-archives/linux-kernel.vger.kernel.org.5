Return-Path: <linux-kernel+bounces-146316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DB8A6372
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD31F21D19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8A3C08F;
	Tue, 16 Apr 2024 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="poOdPGFL"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F93BBEA;
	Tue, 16 Apr 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247698; cv=none; b=pCoDnE8Fvv1EE/PDpHErxpCTACZyrSEs5l8nCjPBtbbBPJDk55hjgoKbzTWqmObfJNJIoa41k71GYeuMiqIRQ5jSTm6x3h/zftMN7yQZoAGMEES7ZQ+/lTW6mmZlUoMwE+vR5UXYTvCTmpx8ENxOFI1V+r+PfvjSs0/Wbs53rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247698; c=relaxed/simple;
	bh=WICUcYaypsw/DK9gFrMDqKtJd5tnBe1HuVDRQOGmKBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6O2EhC88RwRz/sSNH0pw/s7SkHnwmrC/LzTiAHt+KWQNB6a2ZOppu8iKSEM2clc2ojjUaOi1g2iI33r4gopo0S8evgNlfqsPMvZenoirguI76sfD2fexaavLrx2HVxMPk5u71XW59WmjJw1cFD7HsCUD/nc7N7SIyygAFkZyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=poOdPGFL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=kokKt0017qNqpH691SbrggxmrEJ7Johu9iji03ZhiK0=;
	t=1713247696; x=1713679696; b=poOdPGFLnaJdEbeYzfhtLcZr4qniDVpD3ZEVBsES3ap5hUI
	8KrF/PPFm/D9PXajLDSEhcmlggJ97wdmCtoy9Iesi2MKNTtRiZpkvC211PZaPdbvGrV6H0uq65M0I
	K4mSDfv275CY8fLirxdfaK097IUK8Mv1XWNzTMxHp5bm8OgY7CrN6M6P3Ump2MP9nmwsRrpy/T/IE
	ZXbZc1xdIixqjFm9rQnGKgW3bvNXI46L0/s3IbbgBDfh2S9xGNKLWbiA53qN5eM4W6PB7knd/aTp6
	S2/LCXFVQComi20L2rWG/7wH/v6BXsGBnU3fkIuRzsNnOACBGM6atdfxW+8GZ8rg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rwbzE-00032x-Aa; Tue, 16 Apr 2024 08:08:08 +0200
Message-ID: <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>
Date: Tue, 16 Apr 2024 08:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
To: Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
 <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713247696;9626bdd3;
X-HE-SMSGID: 1rwbzE-00032x-Aa

On 12.04.24 04:57, Bjorn Andersson wrote:
> On Wed, Apr 10, 2024 at 11:18:04AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 08.04.24 00:52, Bjorn Andersson wrote:
>>> On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>
>>>> Tejun, apparently it's cause by a change of yours.
>>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
>>>>
>>>>> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
>>>>> with nohz_full=0 cause a page fault and prevents the kernel from
>>>>> booting.
>>> [...]

Tejun, I got a bit lost here. Can you help me out please?

I'm currently assuming that these two reports have the same cause:
https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/T/#u
https://bugzilla.kernel.org/show_bug.cgi?id=218665

And that both will be fixed by this patch from Oleg Nesterov:
https://lore.kernel.org/lkml/20240411143905.GA19288@redhat.com/

But well, to me it looks like below issue from Bjorn is different, even
if it is caused by the same change -- nevertheless it looks like nobody
has looked into this since it was reported about two weeks ago. Or was
progress made and I just missed it?

>>> In addition to this report, I have finally bisected another regression
>>> to the same commit:
>>>
>>> I start neovim, send SIGSTOP (i.e. ^Z) to it, start another neovim
>>> instance and upon sending SIGSTOP to that instance all of userspace
>>> locks up - 100% reproducible.
>>>
>>> The kernel seems to continue to operate, and tapping the power button
>>> dislodge the lockup and I get a clean shutdown.
>>>
>>> This is seen on multiple Arm64 (Qualcomm) machines with upstream
>>> defconfig since commit '5797b1c18919 ("workqueue: Implement system-wide
>>> nr_active enforcement for unbound workqueues")'.
>>
>> Hmmm, I had hoped Tejun would reply and share an opinion if these
>> problems are related. But that didn't happen. :-/ So let me at least ask
>> one question that might help to answer that question: is the machine
>> using CPU isolation, like the two other reports about problems caused by
>> this commit do (see the
>> https://bugzilla.kernel.org/show_bug.cgi?id=218665 and
>> https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/ for
>> details) ?
> 
> No, this is a clean SMP system running stock arch/arm64/defconfig,
> booted with "clk_ignore_unused pd_ignore_unused audit=0" as the command
> line.
> 
> Regards,
> Bjorn

Ciao, Thorsten

