Return-Path: <linux-kernel+bounces-166118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465218B9672
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C8283BDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05A46447;
	Thu,  2 May 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zMOd6jbZ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B5168DA;
	Thu,  2 May 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638616; cv=none; b=TJCZaNeUrbijlZUf5SPTct2fmPR6pQhE5GCC9C6xpNJ9pU/pqbPZXKtAHtTUO+5mzyBBthP4qA7x0hDbEeZG1H6ntEQyFowd/uJrPYjoNrY6opEAf0BB/2I3duE+LiVxyJMgfCMKGrvlG3Pupl+6ASyYrWMIs0M52POi7O9pi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638616; c=relaxed/simple;
	bh=vOI/nXtB8szATT9cPSG35cgjUhx0wO9nDdrM+dagnXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWqrC7C+wYQDhagcso5XYHirhHIgZ5wtHkfTexLcQagXyG6IeoNEBaCl1N/j6jCtFNY8VcSlLar5jUFgxANheAlkcIQQfzDa+DUGEW0Eg2kZoqm6DYT3+Kcq7q2+UN9seTP1Tb89Id63A9YBwDBZB3LK9HGzafDDQMrE8m+tNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zMOd6jbZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=9m0sQbYRngeahD4E6m4UZ+bEYxjvjKNj0Unh9KoUYJo=;
	t=1714638614; x=1715070614; b=zMOd6jbZCuPnlwSRUb925IXnmtirdv5FmwabyI1VMqpQzMQ
	X6QPJ8LiTm0vYOIAowHvN7cGrf8UNn7YIqO1PVgxt1PVgf5UzpMNkQWetiwj5UBvcqk+1p9s/At3Y
	+U8DrU/2z4/iA8anMQE7EBk1VZqg20pAlwidpIEiTScDXFyn+Wl7RNIkdcteSv30tsT/60y091nPx
	8Fad77VVv/EPzAT8uH2xCNV6/ZdzcSlhpDJEmG7Dv77JeYYvY4ZbVaTUJ/nBhUcFZZbjll9yXEdP7
	SJaounw1Od5F+ldzMqvA9vrZN/S8F/CfiDz2Hs0yLemyCdO5P5GrlVd59ZWj6uiQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s2RpS-00006M-NL; Thu, 02 May 2024 10:30:10 +0200
Message-ID: <935b4630-5100-4be6-ae96-4d043b0d5ae4@leemhuis.info>
Date: Thu, 2 May 2024 10:30:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
To: Lee Jones <lee@kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
 <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
 <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
 <20240502071908.GB5338@google.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240502071908.GB5338@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714638614;e18d2da4;
X-HE-SMSGID: 1s2RpS-00006M-NL

On 02.05.24 09:19, Lee Jones wrote:
> On Tue, 23 Apr 2024, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> On 23.04.24 11:06, Johannes Berg wrote:
>>> On Tue, 2024-04-23 at 11:00 +0200, Linux regression tracking (Thorsten
>>> Leemhuis) wrote:
>>>> On 16.04.24 08:17, Johannes Berg wrote:
>>>>> On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
>>>>>>
>>>>>> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
>>>>>> iwl_req_fw_callback()
>>>>>>
>>>>>> Is that still best thing to try in your opinion?
>>>>>
>>>>> I guess so, I don't have any better ideas so far anyway ...
>>>>
>>>> [adding the iwlwifi maintainer; thread starts here:
>>>> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
>>>> ]
>>>>
>>>> Johannes, Miri, what's the status wrt to this regression? From here
>>>> things look somewhat stalled -- but maybe there was progress and I just
>>>> missed it.
>>>
>>> What do you want? It got bisected to an LED merge, but you ping _us_?
>>> Way to go ...
>>
>> Sorry, to me it sounded a bit like you had an idea for a fix and were
>> going to give it a try -- similar to how the maintainers for a r8169
>> driver and the igc driver provided fixes for bugs recent LED changes
>> exposed.
>>
>> But sure, you are right, in the end some LED change seems to have cause
>> this, so the duty to fix it lies in that field. Therefore:
>>
>> Lee, what's the status here to get this fixed before the final?
> 
> No idea.  Did you send a fix?

I'm just here to help Linus keeping an eye on regression to ensure they
are handled like he wants them to be handled.

But Ben Greear sent a patch to work around the problem:

https://lore.kernel.org/all/20240430234212.2132958-1-greearb@candelatech.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

