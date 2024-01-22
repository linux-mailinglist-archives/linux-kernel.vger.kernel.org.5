Return-Path: <linux-kernel+bounces-32746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F5835F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054341C25B81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397DE3D98E;
	Mon, 22 Jan 2024 10:24:13 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07413D0D8;
	Mon, 22 Jan 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919052; cv=none; b=hEPLmzpGWpCa39ZOykzMwpe43y+ZpFSbBGlsJqdZJpbuAAPwZig3jfaMXU5rIwRFb5x9gbxCT8Ap5Y4D/IrhWkViGlP7qYn47gg/CL3dKVFThBQIE/MeagNsp4bMtvt8kEHlYDa46qrDAYwYoyqxO9c+/cSyEb44m7mG/MhNVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919052; c=relaxed/simple;
	bh=Rr2AQ7zd4vwMdcv471OHCjd5FyGE0fpWiiEpedaYODQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3JQ7OjI7iEJ0bxHUxrc5Mmf0vxXokueJHVrDQ2qIPbhpNZzhrbUmsaglsfIgbulCkifGVo1ox7qwpgS5Yal2mEIejyg0jQH0/unWpBJBq0VIsD7GWWA+3WYKu+DFdJACeuf8BoxF9ToNqMuSkj40xszE3X3Vipb4tJFWm2Muo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRrTM-0008R4-F5; Mon, 22 Jan 2024 11:24:08 +0100
Message-ID: <0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
Date: Mon, 22 Jan 2024 11:24:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] ath11k broken in v6.7
Content-Language: en-US, de-DE
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
 <878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
 <94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
 <87fryp3he0.fsf@kernel.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87fryp3he0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705919050;08e9ea00;
X-HE-SMSGID: 1rRrTM-0008R4-F5

On 22.01.24 09:24, Kalle Valo wrote:
> "Linux regression tracking (Thorsten Leemhuis)"
> <regressions@leemhuis.info> writes:
>> On 22.01.24 08:36, Kalle Valo wrote:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>> Kalle Valo <kvalo@kernel.org> writes:
>>>>> Kalle Valo <kvalo@kernel.org> writes:
>>>>>>
>>>>>> Proposed fix:
>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
>>>>> The fix is now applied:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>>>>> I'll try to use regzbot for the first time, let's see how it goes:
>>>>> #regzbot introduced: 0a3d898ee9a8 ^
>>>> Forgot to include the bug report:
>>>>
>>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218364
>>
>> FWIW, that usage was slightly off and not how it's supposed to be done.
>> But whatever, let's ignore that. I'm reworking things currently
>> slightly, as you are not the first one that slightly got mislead -- and
>> the newer commands will hopefully be mire intuitive.
> 
> Just to educate myself, how should I have done it? (But feel free to
> skip the question if you are busy)

I think that's not worth it, as I hope to introduce the new commands in
the near future (but you know how it is with the last 5 to 10
percent...). But let me show you how it's then supposed to be done in
this situation, that way you can give early feedback:

  #regzbot report: https://bugzilla.kernel.org/show_bug.cgi?id=218364
  #regzbot introduced: 0a3d898ee9a8

That "#regzbot report" will be new and make it more obvious to users
what regzbot should consider to be the report (e.g. what Link:/Closes:
tags later in commits fixing the issue will link to). You used "#regzbot
introduced: 0a3d898ee9a8 ^" and due to the "^" it assumed the start of
this thread would be the report (side note: mixing that aspect into the
"introduced" command was a stupid idea anyway.).

That "#regzbot link:" will vanish as well (at least from the docs, it
will remain to be supported), as people use it wrong in various
different ways: for duplicates, reports (like your did), patch
submissions fixing the issue (then 'regzbot monitor' should have been
used) among others. Which is totally understandable now that I look at
it. That's why it will be replaced by "#regzbot related: <url>" to avoid
any connection with the Link: tag used in commits; for duplicates
"#regzbot dup:" will stay around.

>> Great, thx. Hope it reached mainline soon. Maybe once it's there you or
>> I should tell Greg to pick this up quickly for stable given that it
>> apparently "might affect quite a few people".
> I'll try to remember that but the thing is that I don't really follow
> stable releases.

Let me do it, it's easy for me. And FWIW, I don't even follow the stable
releases for that, I just drop Greg a mail when I notice the patch
reached mainline through the weekly net merge. He'll take care of the rest.

> I wish there would be a person who could follow stable
> releases from wireless perspective and make sure everything is ok there.

Maybe at some point regression tracking can help somewhat with that. But
I still have to fix a few things to make people use it and scale it up.

Side note: some people seem to have gotten the impression that I care a
lot about *all* stable/longterm kernels. Let me use this opportunity to
say that it's not really the case. I fully understand and respect that
those series are a somewhat separate thing some developers don't want to
be involved in (especially the older trees). But the thing is: the
latest stable tree is what we tell users to use -- and something quite a
few important distros ship as their regular kernel these days. That's
why I take special care of regression that found there.

Ciao, Thorsten

