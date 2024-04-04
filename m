Return-Path: <linux-kernel+bounces-131738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82F898B49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F67A1F2274D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236812AACB;
	Thu,  4 Apr 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cxctvy5y"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842874C09;
	Thu,  4 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245012; cv=none; b=IKRYp8AhApjlJszIxYx4N5GvK7kidfusDoq+pFcXTc0dNy8VuODXHAcy2XHDKE0VPTEqW5UkOm+98XJncZ4JAs1BXCH/k9BxlfS0GRkFWe+LOdABw0gmN4xp8uIDMPHTdiCZJkXY9PLeX5pX+XEGqAxbq7ljbsdMKfJ2wvHxiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245012; c=relaxed/simple;
	bh=aIii4mYpgJN8egl1KP1aHIF6OrbI1W29+waTSUEwjmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zjovq75DFBn8cn+/oOcy6YdpiiQx/vZlf7wAdztHXRxw7XoT579bUtGGcvAJSh8Mv6UHrYx4uSU4CsfHP2rOVPGPMvBwFjhlKFsfN8rkm8YoYbr6pG+R5G2fWAMkMYuEQvAkezRqJYIwHWZR0OWfnyqqiAIeYJEM4KzhW4q91oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cxctvy5y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=0Kq6TWEF/jUg1kRW+ewE6G5S/dYP+nVgkjeaw6WseDs=;
	t=1712245010; x=1712677010; b=cxctvy5yfFz5pII0KGlfB5tSCsUukDAlTdFHo4Yiy+oXyzc
	LxGZZ8Uyj1Gyc7w4s/KLIjsjW7oCoJgBI7sF+iUj33+QO8thddmSubLN46rrVbXp0JhcRk/Pk7/+t
	lKI9o4CYvTQ7p2wUHaA1iit7Kt1fM1t8oPUZzfmU+EAmgFdMYCmVS4r4mqDfk32bQxHIue4oaB/Yo
	SwaRqqBuQfMRU+CTsYnTGcXQ+GVftnWPxmxZcjoU45S1xSdjT9LEpz40HI//afS1gxdyApzUWRirO
	4UnBZEwTQob1wpXMZ4N7d++H6H0fp2YERn34tPW8Kngph2LZJCFgPP9Yp38n6niA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rsP8t-0003wc-77; Thu, 04 Apr 2024 17:36:43 +0200
Message-ID: <dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info>
Date: Thu, 4 Apr 2024 17:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Do we need a "DoNotBackPort" tag? (was: Re: Hibernate stuck after
 recent kernel/workqueue.c changes in Stable 6.6.23)
To: Greg KH <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh> <Zg10Keik4KORjXMh@slm.duckdns.org>
 <2024040319-doorbell-ecosystem-7d31@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <2024040319-doorbell-ecosystem-7d31@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712245010;da0ec2cc;
X-HE-SMSGID: 1rsP8t-0003wc-77

On 03.04.24 18:10, Greg KH wrote:
> On Wed, Apr 03, 2024 at 05:22:17AM -1000, Tejun Heo wrote:
>> On Wed, Apr 03, 2024 at 07:11:04AM +0200, Greg KH wrote:
>>>> Side note: I have no idea why the stable team backported those patches
>>>> and no option on whether that was wise, just trying to help finding the best
>>>> solution forward from the current state of things.
>>>
>>> The Fixes: tag triggered it, that's why they were backported.

Yeah, this is what I assumed.

>>>>> which would
>>>>> be far too invasive for -stable, thus no Cc: stable.
>>>>>
>>>>> I didn't know a Fixes
>>>>> tag automatically triggers backport to -stable. I will keep that in mind for
>>>>> future.
>>>>
>>>> /me fears that more and more developers due to situations like this will
>>>> avoid Fixes: tags and wonders what consequences that might have for the
>>>> kernel as a whole
>>>
>>> The problem is that we have subsystems that only use Fixes: and not cc:
>>> stable which is why we need to pick these up as well.  Fixes: is great,
>>> but if everyone were to do this "properly" then we wouldn't need to pick
>>> these other ones up, but instead, it's about 1/3 of our volume :(

I'm also well aware of that and do not want to complain about it, as I
think I grasped why the stable team works like that -- and even think
given the circumstances it is round about the right approach. I also
understand that mistakes will always happen.

Nevertheless this thread and the Bluetooth thing we had earlier this
week[1] makes me fear that this approach could lead to developer
avoiding Fixes: tags. And funny thing, that's something that is already
happening, as I noticed by chance today: "'"A "Fixes" tag has been
deliberately omitted to avoid potential test failures and subsequent
regression issues that could arise from backporting."'"[2].

I wonder if that in the long term might be bad. But well, maybe it won't
matter much. Still made me wonder if we should have a different solution
for this kind of problem. Something like this?

  Cc: <stable@vger.kernel.org> # DoNotBackport

Or something like this?

  Cc: <stable@vger.kernel.org> # DoNotBackport - or only after 16 weeks
in mainline [but I don't care]

Whatever, mainly thinking aloud and do no need a reply to this. :-D

[1]
https://lore.kernel.org/all/84da1f26-0457-451c-b4fd-128cb9bd860d@leemhuis.info/

[2] saw that today here:
https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/

>>> I'll gladly revert the above series if they shouldn't have been
>>> backported to stable, but from reading them, it seemed like they were
>>> fixing an issue that was serious and should have been added to stable,
>>> which is why they were.
>> Oh, yeah, they're fixing an issue. It's just that the issue is relatively
>> confined peformance degradation and the fix is really invasive, so not a
>> great -stable candidate. At the very least, they'd need a log longer cooking
>> time in mainline before being considered for -stable backport.
> Ok, I'll go revert them all now.  I did some test builds here with them
> reverted and they seem sane.  I'll push out some -rcs with just the
> reverts to at least fix the regressions found in the 6.8.y tree now.

Great, thx for taking care of this!

Ciao, Thorsten

