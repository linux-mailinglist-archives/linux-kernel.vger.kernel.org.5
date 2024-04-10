Return-Path: <linux-kernel+bounces-138243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33489EEA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8101C21FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8115ADB6;
	Wed, 10 Apr 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gYRcQVoh"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1215573D;
	Wed, 10 Apr 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740689; cv=none; b=lPB+WGotMT8o8b8RNuFi5Z3A97zBC+B8uJ3WXV9MFBagG1ukDKRS+oEPLup4HCtob7oC3n6rMMM8nvOxc1t/eo1uh1mf1+uyi0FvB2wt0lNuc7zwpNgLHXLfFjVf+nyuaaXkLbf3S1gwdoWW1XampowE13o6D67AqTNLO8P7tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740689; c=relaxed/simple;
	bh=buENw+YtfetZukl3wvHbHBQ7F3q5JUdS9DaF/JEENWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9XEF+QP/w2f/tDKcUEAql6wve28k1d/sI+CRHzcEsQNn1d9/ez/rWs15mwAgjsps7uQePUG2cQsp6TCwioSXut9oWwSTbzFjlRm32AvwprGZFdyXWUMsHVxJ/unWMQVnr2Inx3F9kX54nKFHSQBX/UQjHFtZR2Cg7eQRNtRvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gYRcQVoh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=MG+8o97HbAfSpyN8cL56yv14qBVXuFd6KIelqD3DFmk=;
	t=1712740687; x=1713172687; b=gYRcQVohw/RNKKHZ/QjVpxIsW6X4wqE2Dvagv3MrcJ+y77T
	5r8/PfIqyAXoP68mhzuNhDS8NhjHechZ+lOf4HngqhhwVwDkwRoLrn2Z96AZH8Ma4/3ZMD3Ak4/Wm
	X3HZRwTC5G3OmtvZxi3+mJvbznX1p7y2sNrjkmGH+S0FgUe+KSo7UIwVeLNxlak/ghzfU6BPfEIdD
	g2oTrYBhdVsX9cd9gsbx+zj+K/1I8KQXl8Sy0cEQsbSUtpJpAijoPVLh+BW6A5ZQFZ+byAF3UhdL5
	DTSW6PeX56+ftLnWfvuUOqoZp1IgnlwQ49eaQWsj4Alpd2D8qo2qO12Hsuxbf+OQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruU5k-0004w0-Oc; Wed, 10 Apr 2024 11:18:04 +0200
Message-ID: <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
Date: Wed, 10 Apr 2024 11:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
To: Bjorn Andersson <andersson@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712740687;59a061c0;
X-HE-SMSGID: 1ruU5k-0004w0-Oc

On 08.04.24 00:52, Bjorn Andersson wrote:
> On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>
>> Tejun, apparently it's cause by a change of yours.
>>
>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>> not CCed them in mails like this.
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
>>
>>> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
>>> with nohz_full=0 cause a page fault and prevents the kernel from
>>> booting.
> [...]
> In addition to this report, I have finally bisected another regression
> to the same commit:
> 
> I start neovim, send SIGSTOP (i.e. ^Z) to it, start another neovim
> instance and upon sending SIGSTOP to that instance all of userspace
> locks up - 100% reproducible.
> 
> The kernel seems to continue to operate, and tapping the power button
> dislodge the lockup and I get a clean shutdown.
> 
> This is seen on multiple Arm64 (Qualcomm) machines with upstream
> defconfig since commit '5797b1c18919 ("workqueue: Implement system-wide
> nr_active enforcement for unbound workqueues")'.

Hmmm, I had hoped Tejun would reply and share an opinion if these
problems are related. But that didn't happen. :-/ So let me at least ask
one question that might help to answer that question: is the machine
using CPU isolation, like the two other reports about problems caused by
this commit do (see the
https://bugzilla.kernel.org/show_bug.cgi?id=218665 and
https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/ for
details) ?

Ciao, Thorsten

