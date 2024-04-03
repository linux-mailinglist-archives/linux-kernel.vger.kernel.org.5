Return-Path: <linux-kernel+bounces-129041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDC8963A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D41C2301A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0245BE1;
	Wed,  3 Apr 2024 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ADTRbQNU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557517997;
	Wed,  3 Apr 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119765; cv=none; b=EotcjlblgSz3cKNDB9CTQ6WG07wL6vLc/rR4A1p+1anygAe0Y4kwDCle8B4dL7p1dWgMEib2mwniriE/gB/7epUQtEUf1WAYIAd5ZrfJHb+e9SpWBOATWZ0MhRrM6R+/Q0kBqPtRR/2GIEF7isYeeIRiQR67U+I4Qr3lSPcc488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119765; c=relaxed/simple;
	bh=QmDWs704HYYc5Y6/bd68g/B3XytY1/o4TXKGVFkVfSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gIyWRD8oakRE2jOp7uwIeC0vScX00o6rRLemsatCO0bByxXcHfaev03fkYE6lV6llfnDkbWO/5PAyrnvMN5jBob0qzn4bHJnV8AlI71wcOj3DDS3PISMz7lIvbo9qjtgOGD8BzMcAtKvIdHt6yNYvNID4Xo5A7CWMhqiDISvv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ADTRbQNU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9f2oNPXNMAeWBLw7dRuSLYmhlGmf0wKBLFiNHGbRWNk=; t=1712119763;
	x=1712551763; b=ADTRbQNUxOVtXv8Us8yvjrCLS6RFxp5o2kkx/HxfJqxavSDt0Ue+G7CLLPZLY
	8X2MhU3brQoZu4i5LdX/3r6HIaiDu7+BUDqAQQ+X451OjAwULFw5+yEJ/XBBKLjjPhKTAftzW2AsK
	uD89VXJnfk+3vz8mkJ7C/zVkdwTRIfDJyHThhxvcbai7l1M4BDA8tIDNqC75grHcbpH/F76HSrWpV
	wbJiXtb3nhrUEz22Vvz/cVeInjE2VwVm7cqnHVrl4HCeCpqW0O0yDCZQzlo1Kv68aes4J8paexho1
	JTFbwrVps/zhF52ZT9lgWNAIOOrVGrTfKYJgpg5vgrPcX9QqXQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrsYq-0001Bk-WD; Wed, 03 Apr 2024 06:49:21 +0200
Message-ID: <990192aa-f554-4aba-b935-f522c62188ab@leemhuis.info>
Date: Wed, 3 Apr 2024 06:49:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
To: Martin Steigerwald <martin@lichtvoll.de>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2325246.ElGaqSPkdT@lichtvoll.de>
 <12401263.O9o76ZdvQC@lichtvoll.de>
 <be5a7213-78b3-4917-b95b-ec31cd2350e4@leemhuis.info>
 <22240355.EfDdHjke4D@lichtvoll.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <22240355.EfDdHjke4D@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712119763;ca4dd1c0;
X-HE-SMSGID: 1rrsYq-0001Bk-WD

On 02.04.24 21:42, Martin Steigerwald wrote:
> Linux regression tracking (Thorsten Leemhuis) - 19.03.24, 09:40:06 CEST:
>> On 16.03.24 17:12, Martin Steigerwald wrote:
>>> Martin Steigerwald - 16.03.24, 17:02:44 CET:
>>>> ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
>>>> Hibernation works correctly with self-compiled 6.7.9.
>>>
>>> Apparently 6.8.1 does not even reboot correctly anymore. runit on
>>> Devuan. It says it is doing the system reboot but then nothing
>>> happens.
>>>
>>> As for hibernation the kernel cancels the attempt and returns back to
>>> user space desktop session.
>>>
>>>> Trying to use "no_console_suspend" to debug next. Will not do bisect
>>>> between major kernel releases on a production machine.
>>
>> FWIW, without a bisection I guess no developer will take a closer look
>> (but I might be wrong and you lucky here!), as any change in those
>> hundreds of drivers used on that machine can possibly lead to problems
>> like yours. So without a bisection we are likely stuck here, unless
>> someone else runs into the same problem and bisects or fixes it. Sorry,
>> but that's just how it is.
> 
> I have been asked this repeatedly with previous bug reports. My issue
> with bisecting between major kernel versions is this:
>  
> When I look around here I see no second ThinkPad T14 AMD Gen 1 here I 
> could use for testing. Also doing a kernel bisect using a GRML live iso… 
> not really.
> 
> The one I reported this from is a production machine with a 4 TB NVMe
> SSD which contains a lot of data. I am not willing to risk data loss or
> (silent) file system corruption by bisecting between major kernel
> releases. Bisecting between major kernel releases in my understanding
> would require to test various releases between in this example 6.7 and
> 6.8 and even between 6.7 and 6.8-rc1. At least in my understand anything 
> between 6.7 and 6.8-rc1 is not guaranteed to be even be somewhat stable.

It's hard to qualify and always a matter of personal viewpoint/opinion,
but I'd say: kernel from the merge window are pretty stable and
reliable. But sure, accidents that eat data happen and they happen
slightly more often during merge windows because the rate of change is
higher. But in the end they do not happen often, which is why Fedora
rawhide for example ships merge window kernels all the time.

> I 
> am not usually installing an rc1 kernel on a production machine, but 
> rather wait for at least rc2/3 nowadays. Its a balanced risk calculation. 
> And rc2/3 or later appears to be a risk I am willing to take. But 
> something between stable and rc1? Nope.

Well, that's up to you -- but the reality is also that developers are
not obliged to look into regressions report closely, unless someone
bisected it.

> It is not even that rare. 6.7 some rc failed with hibernation as well. 

Maybe too few people (or too few of those that run the latest kernels)
use hibernate these days (I haven't for more than 15 years), which is
why it's not tested much.

> With exactly the same machine. I refused to do a bisect as well in that 
> case. At some later time the issue was fixed without me doing anything 
> more.

Maybe you were lucky, maybe someone else bisected and reported the problem.

> Now my question is this: Without me willing to bisect in that case, is
> a bug report even useful? Otherwise I may just switch this last machine
> to distribution kernels. It would save a lot of time for me. This private 
> and freelancer production machine is the last left-over machine with self-
> compiled kernels.
> 
> So far I still thought I would somehow be contributing to Linux kernel
> quality with detailed bug reports that take time to write, but apparently 
> I am not. Can you clarify?

Not really, as it always depends on the situation. There are bugs (like
https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/
) where a report without a bisection is enough. But there are others
where it's unlikely that anyone will take a closer look; a lot of those
reg. suspend/hibernate fall into this category, as problems in that area
can be cause by any subsystem and its drivers -- which is why the power
management people can't look into most of those, as then they quickly
wouldn't get anything else done while spending time on bugs most of the
time other people caused.

Ciao, Thorsten

