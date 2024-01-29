Return-Path: <linux-kernel+bounces-42621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A68403E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86391F21897
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709965F544;
	Mon, 29 Jan 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW5N78mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCE5C5E0;
	Mon, 29 Jan 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528029; cv=none; b=tz4k1GTxRRxF0IkYf/84Rxn3KkhkqDyFdS6oxr4DWCJBlHQX5y7LzQnHkWuzUjtF9liIfzSKtfif85NK99oYxe9U0AFNgMTgBwk7MioA8DOSMfdTFKvCfHnjtc91WNpjPSqgjGH0FkNmLe76haQBoH5JTKKrlh7Dq4grtcFtePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528029; c=relaxed/simple;
	bh=9Im3//+edoEovvD3z3/DbAAPUqCpZJ6xFDEEDLE/cAc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tdXdCg5IFu5TzwysYNolx2LWw+LiZhBr522Z8C+HbK4Dg+g+MU7Vz8LId5u8l3FHsjF8XaCW2rlvi8wscJHCMXmQqCV+DAObeu/Mr0m0W4RdMz8aJctHWlanKgWENilEmH8Y9+VlLlX6tGCPQWx/pU4VNZ7bsbUiqT2xIgCgkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW5N78mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92439C433C7;
	Mon, 29 Jan 2024 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706528028;
	bh=9Im3//+edoEovvD3z3/DbAAPUqCpZJ6xFDEEDLE/cAc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UW5N78mjfQDgW+vaQbyiiO6D8tkCP8cRM7tAqn84SoSFF5x1fAdF8D4B+gIFK4vDO
	 VYl1odPjW8p1bXYpB7W9oZuUgfpjL07elXav6uAhpSje5ZTYrtOINTjFi1d+ELUtUd
	 iWswgaclE6f2MmGV7VVNxhxVN/QT59vkYhENAdJ+VFWx+Sq5QyPYNSh1Lbddg3eV8x
	 96/MKtnee1NQB4Pd/KFwJ+1QSc+k6RnOQxYc0G/3wGL3q1PhW9YLTJ/oMxS1/TrkJW
	 oEyt73bIvsGO6jgNjiywmBVm2sW1+rhCc0YsrDQ7FSWGokeXVSMyRLTopm6blQXUkw
	 MsyaAf+fxBKhw==
From: Kalle Valo <kvalo@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: ath11k@lists.infradead.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
	<878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
	<94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
	<87fryp3he0.fsf@kernel.org>
	<0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
Date: Mon, 29 Jan 2024 13:33:45 +0200
In-Reply-To: <0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info> (Thorsten
	Leemhuis's message of "Mon, 22 Jan 2024 11:24:06 +0100")
Message-ID: <871qa0xtk6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 22.01.24 09:24, Kalle Valo wrote:
>> "Linux regression tracking (Thorsten Leemhuis)"
>> <regressions@leemhuis.info> writes:
>>
>>> FWIW, that usage was slightly off and not how it's supposed to be done.
>>> But whatever, let's ignore that. I'm reworking things currently
>>> slightly, as you are not the first one that slightly got mislead -- and
>>> the newer commands will hopefully be mire intuitive.
>> 
>> Just to educate myself, how should I have done it? (But feel free to
>> skip the question if you are busy)
>
> I think that's not worth it, as I hope to introduce the new commands in
> the near future (but you know how it is with the last 5 to 10
> percent...).

I sure do know :) I assume you will announce in the regressions list
once the new interface is available, I'll then take a look at it in
detail and update my notes.

> But let me show you how it's then supposed to be done in this
> situation, that way you can give early feedback:
>
>   #regzbot report: https://bugzilla.kernel.org/show_bug.cgi?id=218364
>   #regzbot introduced: 0a3d898ee9a8
>
> That "#regzbot report" will be new and make it more obvious to users
> what regzbot should consider to be the report (e.g. what Link:/Closes:
> tags later in commits fixing the issue will link to).

Thanks, this looks very intuitive to me.

> You used "#regzbot introduced: 0a3d898ee9a8 ^" and due to the "^" it
> assumed the start of this thread would be the report

Actually I did that on purpose as I wanted to test how including a mail
to a regression report works :)

> (side note: mixing that aspect into the "introduced" command was a
> stupid idea anyway.).
>
> That "#regzbot link:" will vanish as well (at least from the docs, it
> will remain to be supported), as people use it wrong in various
> different ways: for duplicates, reports (like your did), patch
> submissions fixing the issue (then 'regzbot monitor' should have been
> used) among others. Which is totally understandable now that I look at
> it. That's why it will be replaced by "#regzbot related: <url>" to avoid
> any connection with the Link: tag used in commits; for duplicates
> "#regzbot dup:" will stay around.

So, in the new interface, how should I handle a situation that a
regression is first reported on the mailing list, added to regzbot and
later there's also a bug report opened for the issue?

>> I wish there would be a person who could follow stable
>> releases from wireless perspective and make sure everything is ok there.
>
> Maybe at some point regression tracking can help somewhat with that. But
> I still have to fix a few things to make people use it and scale it up.

I just feel it should be more than that, I'm worried that randomly
taking wireless commits to stable releases is risky. There really should
be someone looking after wireless (read: reviewing patches) in stable
releases. This would be a good role for someone who is interested to
learn how kernel.org development works and helping the community. Do we
have a way to announce these kind volunteer vacancies somewhere? :)

> Side note: some people seem to have gotten the impression that I care a
> lot about *all* stable/longterm kernels. Let me use this opportunity to
> say that it's not really the case. I fully understand and respect that
> those series are a somewhat separate thing some developers don't want to
> be involved in (especially the older trees). But the thing is: the
> latest stable tree is what we tell users to use -- and something quite a
> few important distros ship as their regular kernel these days. That's
> why I take special care of regression that found there.

Yeah, I understand that a lot of users use stable kernel releases. But
the reality is that we in wireless really don't have the bandwidth to
manage stable kernels, it is enough of a challenge to manage Linus'
releases. So help here is very much needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

