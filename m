Return-Path: <linux-kernel+bounces-127538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB760894D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E17C1C21AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7D3DB9A;
	Tue,  2 Apr 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rpOaj/Pi"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D03D547;
	Tue,  2 Apr 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045840; cv=none; b=a1lnxnIvsuFDqNc6teSWcLiBy1Xiy6sDyYqKgWZBmZ4FaduUTpA0bRL7l/mc787PR3RzRZFZ0YQ1KtgqFUr82mkqhN4oA0Hz35uVUSUyjImTM8xQzziGqfpjaaR+6RHwP5Ollbl3IwETJH4kcMF+kPnCFT/DItNLoDBemqvMTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045840; c=relaxed/simple;
	bh=xOg72kG8RE3Io6aICsy4zEqghWHs0WzVc9G+4UggKRI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=UkdpmB91quxTAvCf/sWhuojS2aD5W1OqEZcjs8qBtba+dmWnRhqTO4dgPZdG83rTkB/AFuqfwpCY7ktIgGvrdQ+6TCO74nAJcx4vMN/COwnqbQcWrqpVd6z5qovuyMKBAjcKoJ9bkkzMmO8USotSgsJCs1/I7qjRmeNlKL4F8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rpOaj/Pi; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=PIXKukvrVFtF2jLwToNr2JQD8OFYXFrclPIb2BcK3NM=; t=1712045838;
	x=1712477838; b=rpOaj/PiK1BRSrwh2cB4E1DaOBbGy4pxdjw4ZBDkY34WG2Fr75Ty1eVH6kQjL
	76AVAz8yv9L18WJBkVZ07fb2fEpyqcqn48qNMkf0RbO2iMiBSU1aT9UM2vJJt2qPXOquoWkiRSgLM
	BKW/Gufv+tTpPqyEdkCh/wEpGscTfa97VULpul7BM64C8IbIpKw2UukULzw78dShQcPlot7Q3Nnge
	es0zpjlCn4C8754Rl97bEputkFskT5AwzRUTA8euFd7hxixZNH3bHFdXCJLm0WI6fKBUFyCocl0Kz
	r5EGJqAbaUUODeXr/bJJpCQi0W75GH4OecjC87Yf2rPXEW757A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrZKW-0002LN-TB; Tue, 02 Apr 2024 10:17:16 +0200
Message-ID: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
Date: Tue, 2 Apr 2024 10:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Tejun Heo <tj@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Bug 218665 - nohz_full=0 prevents kernel from booting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712045838;ac3989d0;
X-HE-SMSGID: 1rrZKW-0002LN-TB

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Tejun, apparently it's cause by a change of yours.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :

> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
> with nohz_full=0 cause a page fault and prevents the kernel from
> booting.
> 
> Steps to reproduce:
> - make defconfig
> - set CONFIG_NO_HZ_FULL=y
> - set CONFIG_SUSPEND=n and CONFIG_HIBERNATION=n (to get CONFIG_PM_SLEEP_SMP=n)
> - make
> - qemu-system-x86_64 -nographic -cpu qemu64 -smp cores=2 -m 1024 -kernel arch/x86/boot/bzImage -append "earlyprintk=ttyS0 console=ttyS0 root=/dev/dummy rootwait nohz_full=0"
> 
> I have attached the output of a failed nohz_full=0 boot as
> nohz_full_0.txt and - for reference - the output of a nohz_full=1
> boot as nohz_full_1.txt.
> 
> Interestingly enough, using the deprecated isolcpus parameter to
> enable NO_HZ for cpu0 works. I've attached the output as
> isolcpus_nohz_0.txt.
> 
> Bisecting showed 5797b1c18919cd9c289ded7954383e499f729ce0 as first bad commit.

See the ticket for more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

#regzbot introduced: 5797b1c18919cd9c289ded7954383e499f729ce0
#regzbot from: Friedrich Oslage
#regzbot duplicate https://bugzilla.kernel.org/show_bug.cgi?id=218665
#regzbot title: workqueue: nohz_full=0 prevents booting
#regzbot ignore-activity

