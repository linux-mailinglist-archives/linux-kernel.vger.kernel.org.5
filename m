Return-Path: <linux-kernel+bounces-134658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C789B487
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42301C20C75
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CA381BB;
	Sun,  7 Apr 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN+8waih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02921379;
	Sun,  7 Apr 2024 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712530080; cv=none; b=d2yZ9vwdMXS5FtWE7aj+8CpwR1S3KjudIKSve+4ZnzJ1U4AzG7eZzR6ZibF/Dn6NmvSIZVZ5OIogWs09lUNsv6bPYkuNRrcL0zKGNf3mneJ/J4Bkb1yR9vU3THa5K+pxnkUSAfmgaWWIK8y65QxpveDJezisODvQH4NVJP7RtS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712530080; c=relaxed/simple;
	bh=DeNJLuaGaksiPY8qR+F+kPlU5fDPuLp+JSQfBLqtMS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3VG9YSobzBhVH2nzgDdILlJMfHKPv78V4oR7Gih82aoStV3bRsw0bsaVDvplECXrx3qj89PVEbwDof6OoYVbn9mUrJeXv7+/NlmyEIiV6UjoA39vrrTXQnXsK+57UjX/VQSXFeUviRyFurh2Mv+Jg8hrMJxQ9ysTM6sx/QSprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN+8waih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F11C433F1;
	Sun,  7 Apr 2024 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712530079;
	bh=DeNJLuaGaksiPY8qR+F+kPlU5fDPuLp+JSQfBLqtMS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mN+8waihk+5m/HUeV0HftArL2QhUSfVGH4x3kvJ9jVFo3/dO43cw+JRnFliHrEEtp
	 M0zdz2NjUnr7lsEdKQSK5EClXKp3nLo9uO6yPhUl8LCBgnvMqTYef5yjdBJS+i7vQJ
	 3BV6OJWolHBkb0jbFpKqKhJm+AqNHGwTd9zNod7SK6DiJQktFzYLk5Og/1jXupyOn4
	 0zRpwAy9r75w4/a+hbT4FND4+vcjgudzoF9z7JwF4FYqyuD2oDfUQEt8x9JOOQzdjm
	 t9Ub4eMTye3SWRb9CF2SAWNihpQ8um+VrGWjxFXDzsV2wlINBPKVQHOIyNYSnKo8V7
	 nTF00R3wJFLug==
Date: Sun, 7 Apr 2024 15:52:52 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>

On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developers don't keep an eye on it, I decided to forward it by mail.
> 
> Tejun, apparently it's cause by a change of yours.
> 
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
> 
> > booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
> > with nohz_full=0 cause a page fault and prevents the kernel from
> > booting.
> > 
> > Steps to reproduce:
> > - make defconfig
> > - set CONFIG_NO_HZ_FULL=y
> > - set CONFIG_SUSPEND=n and CONFIG_HIBERNATION=n (to get CONFIG_PM_SLEEP_SMP=n)
> > - make
> > - qemu-system-x86_64 -nographic -cpu qemu64 -smp cores=2 -m 1024 -kernel arch/x86/boot/bzImage -append "earlyprintk=ttyS0 console=ttyS0 root=/dev/dummy rootwait nohz_full=0"
> > 
> > I have attached the output of a failed nohz_full=0 boot as
> > nohz_full_0.txt and - for reference - the output of a nohz_full=1
> > boot as nohz_full_1.txt.
> > 
> > Interestingly enough, using the deprecated isolcpus parameter to
> > enable NO_HZ for cpu0 works. I've attached the output as
> > isolcpus_nohz_0.txt.
> > 
> > Bisecting showed 5797b1c18919cd9c289ded7954383e499f729ce0 as first bad commit.
> 
> See the ticket for more details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> [1] because bugzilla.kernel.org tells users upon registration their
> "email address will never be displayed to logged out users"
> 
> #regzbot introduced: 5797b1c18919cd9c289ded7954383e499f729ce0
> #regzbot from: Friedrich Oslage
> #regzbot duplicate https://bugzilla.kernel.org/show_bug.cgi?id=218665
> #regzbot title: workqueue: nohz_full=0 prevents booting
> #regzbot ignore-activity

In addition to this report, I have finally bisected another regression
to the same commit:

I start neovim, send SIGSTOP (i.e. ^Z) to it, start another neovim
instance and upon sending SIGSTOP to that instance all of userspace
locks up - 100% reproducible.

The kernel seems to continue to operate, and tapping the power button
dislodge the lockup and I get a clean shutdown.

This is seen on multiple Arm64 (Qualcomm) machines with upstream
defconfig since commit '5797b1c18919 ("workqueue: Implement system-wide
nr_active enforcement for unbound workqueues")'.

Regards,
Bjorn

