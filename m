Return-Path: <linux-kernel+bounces-32510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68BB835C82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F190286479
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7F20DF3;
	Mon, 22 Jan 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9yVUA7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03F20DE0;
	Mon, 22 Jan 2024 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911867; cv=none; b=m6aLmHchn7mQGPt70F+5k4Enyonl6Z9tkCQgkbE6eWx8Tiy4kZhLI/m71MAcBSAWvLU1p0n+NR6JBtP2uPTjwlXtKk8SAKKP2MZS5odonj45jDKcZqsLBwMbdIHrnZb4K8BBhhR5Kbw3FNmCuDRRoxdzMYKZQs/F7oialhK9EYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911867; c=relaxed/simple;
	bh=+DIt2XHxR6GWd87F4zF71KKoFdrIBtRWA2j/kw1c0rI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R3LTN5cUd/+JPyTklE7v3XiZOoiFoTK0P5IFbqDOoY2WOVa1WN9k77U2bV4YPk/Z3JLgMI4YtM53uiNic7CjjnSSeCPQT1llfmXkiPkzV+D27zhg0E1bis2RjRiJ5YPWlljglJrqsIQTG7uOA0npJ9iGJBNiu5eZjB6jLgvjCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9yVUA7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3693C433C7;
	Mon, 22 Jan 2024 08:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705911867;
	bh=+DIt2XHxR6GWd87F4zF71KKoFdrIBtRWA2j/kw1c0rI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=U9yVUA7ussq3zLhB7QYCuHHjo7VA6uSyWsUtucbdkKJqLtHrXHCZlLTlb7AkP7x9p
	 KAnO6b7eHzgEZnbaVH84M6vxblFJiBQjCV3Md/2QS6ehAAok6VfACKisSOq9lDiEFO
	 LGPWTuyQ8KMbIYxXIAjwuODbhXn4lnGCm+1nScMmpYtqove6hSuQA4eJDdKLAbwlrJ
	 cLrE1P4eTzV5lr9tMUupqCbfR9NoomokJcdW9L5xBqXvaOHjb+wPYw6t1Jsswb7lXd
	 d7jqBa0Nz547WYXOZCzIp48mgmFtbuCNPKkDVT92lXDKZxrQQeXZ4ReZSKt5rpzN+s
	 zo/NZkZfZBsvg==
From: Kalle Valo <kvalo@kernel.org>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: ath11k@lists.infradead.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
	<878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
	<94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
Date: Mon, 22 Jan 2024 10:24:23 +0200
In-Reply-To: <94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info> (Linux
	regression tracking's message of "Mon, 22 Jan 2024 09:03:27 +0100")
Message-ID: <87fryp3he0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 22.01.24 08:36, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>> Kalle Valo <kvalo@kernel.org> writes:
>>>>
>>>>> Just trying to make everyone aware because I suspect this will affect
>>>>> quite a few people: ath11k is crashing during suspend on v6.7 due to a
>>>>> mac80211 patch, more info:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218364
>
> Many thx for the heads up, much appreciated. Sorry, forgot to add it to
> the tracking myself: during the merge window thing are sometimes a bit
> chaotic for myself as well. And I was head-down in rewriting some parts
> of regzbot (see below).

No worries, this was a good time to learn all this myself.

>>>>> Proposed fix:
>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
>>>>
>>>> The fix is now applied:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>>>>
>>>> I'll try to use regzbot for the first time, let's see how it goes:
>>>>
>>>> #regzbot introduced: 0a3d898ee9a8 ^
>>>
>>> Forgot to include the bug report:
>>>
>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218364
>
> FWIW, that usage was slightly off and not how it's supposed to be done.
> But whatever, let's ignore that. I'm reworking things currently
> slightly, as you are not the first one that slightly got mislead -- and
> the newer commands will hopefully be mire intuitive.

Just to educate myself, how should I have done it? (But feel free to
skip the question if you are busy)

>> #regzbot fix: 556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>
> Great, thx. Hope it reached mainline soon. Maybe once it's there you or
> I should tell Greg to pick this up quickly for stable given that it
> apparently "might affect quite a few people".

I'll try to remember that but the thing is that I don't really follow
stable releases. I wish there would be a person who could follow stable
releases from wireless perspective and make sure everything is ok there.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

