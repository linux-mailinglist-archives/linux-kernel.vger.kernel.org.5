Return-Path: <linux-kernel+bounces-106349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB087ECDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFEC1F21897
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97152F86;
	Mon, 18 Mar 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SLvwGWdq"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E399374CB;
	Mon, 18 Mar 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777530; cv=none; b=JPVCFHLryA+fr4O/BDHhXiYAPOQQgrtqjY7+Oh15y5BiXMSjnDMLdIUiwrGPGH+w9BSV4muSIyBWZBQkcCCA4n9LBkjiBkCdPHYyULfNQBpPhWXDx1w169A7yh6sMM+F6XFd20+ouJFDO0tzB+r6KbjcPZvJzLZI5ayNVonh/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777530; c=relaxed/simple;
	bh=02hLa+502nthqIpJ3Rj+S+Vi3TlZ9i7evQxRTLzmvl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPHKHjFKJ0FgvfUVC5DIs3lXszdFiJFnGaEQSFJ+zpP90F0bLb7C7qE5i8TDDIs/fs2YGkL6ydEHwZwGFk6GPMHH/XRTzsdk20W12RiD9j9rMOqcXToXdQIi4q+9brE4DYIhQnyQV5zCfY+QF+fMt03ixewm4oqQ3UUI24NzBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SLvwGWdq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=4dpC3v9e7yNk/nqbEoKg8rGA46wzi6nH/HPa6PvvuGI=;
	t=1710777528; x=1711209528; b=SLvwGWdqhFHvB/9eQojjGJ9lIEPWvnzD1b8HtpH+zTS8BDZ
	sUSKPCXl3+6Bm/IqyA8NFQxyHjDqof5lMZyMOOTYppjtApLE3I6b8TOqew6ptPnXZsULOEN/Id+Em
	ZumpAM++iFg+uJg2hrgWH1Qxh75ipjXZVJrSpSljz9k9UEnRgtMreeDihYLyoXenv0nSj0YK+Skde
	yD3lWCH1NdvuZBMl9e5bOXU7DbEXNGixWLCHMnyTBGxb88ZYrx3sdQpjm9ezgIMVRKY5JnzmUfXL9
	m9yqEFQB4mBRJ9RJP7aL1G3nlbCNPPlCjfXvE/I5tD6fiAIrBEl3h4P7pMGynTwA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmFNt-0004i8-8b; Mon, 18 Mar 2024 16:58:45 +0100
Message-ID: <dfabddd0-7284-480f-8c6c-135fb169a11c@leemhuis.info>
Date: Mon, 18 Mar 2024 16:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with csum_partial with misaligned buffers on sh4
 platform
Content-Language: en-US, de-DE
To: Guenter Roeck <linux@roeck-us.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
 <351dfebd-c09f-470e-8b03-cc904753b136@roeck-us.net>
 <2b54a5d8-b317-4df7-ab2e-d63a352dd77d@leemhuis.info>
 <93ad802f-c152-4461-9f9f-c338f58a000d@roeck-us.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <93ad802f-c152-4461-9f9f-c338f58a000d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710777528;418c2201;
X-HE-SMSGID: 1rmFNt-0004i8-8b

On 18.03.24 16:32, Guenter Roeck wrote:
> On 3/18/24 08:04, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 11.03.24 18:04, Guenter Roeck wrote:
>>> On Sat, Feb 10, 2024 at 07:12:39AM -0800, Guenter Roeck wrote:
>>>>
>>>> when running checksum unit tests on sh4 qemu emulations, I get the
>>>> following
>>>> errors.
>>>
>>> Adding to regression tracker.
>>>
>>> #regzbot ^introduced cadc4e1a2b4d2
>>
>> Hmmm, thx for that, but well, I'm a bit taken back and forth here. That
>> commit afaics is from v3.0-rc1 and Linus iirc at least once said
>> something along the lines of "a regression only reported after a long
>> time at some point becomes just a bug". I'd say that applies there,
>> which is why I'm wondering if tracking this really is worth it.
> 
> Not my call to make. I'll keep in mind to not add "bugs" to the regression
> tracker in the future.

From my side there is no need for you to keep that in mind, as "somewhat
added this regression to the tracking" might be something that will
occasionally make a developer finally fix the problem -- which is why I
waited a few days with today's reply. :-D

> Feel free to drop.

Let me do that:

#regzbot inconclusive: really old regression

> For my understanding, what is "a long time" ?

That is a good question and I guess the answer like so often in kernel
land depends on the regression in question. :-/ Also note that that
"iirc" really was meant like it, as I might misremember. I just checked
and found two related quotes, but the situations are somewhat different:

https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
"""
And yes, I do consider "regression in an earlier release" to be a
regression that needs fixing.

There's obviously a time limit: if that "regression in an earlier
release" was a year or more ago, and just took forever for people to
notice, and it had semantic changes that now mean that fixing the
regression could cause a _new_ regression, then that can cause me to
go "Oh, now the new semantics are what we have to live with".
"""

And also:
https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/
"""
And obviously, if users take years to even notice that something
broke, or if we have sane ways to work around the breakage that
doesn't make for too much trouble for users (ie "ok, there are a
handful of users, and they can use a kernel command line to work
around it" kind of things) we've also been a bit less strict.
"""

Ciao, Thorsten

