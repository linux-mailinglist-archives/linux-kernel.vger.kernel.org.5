Return-Path: <linux-kernel+bounces-32485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F177C835C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A930E283D84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE341AAC9;
	Mon, 22 Jan 2024 08:03:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBD18640;
	Mon, 22 Jan 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910617; cv=none; b=myeZw4ZpRRO2uPq0i99cHKZasiWth1F14d6RC6Hcxn5zQPaH0Bd8SOZCL7B2aCI6jDWYvPs7KP3FI/w/+CdJMo4Dt9gMk5+sqP0KviAmEXbhIZW9U1zx7BQ6LwQoluieMEtNiS+Cr9/5YxGFTxpscTrvEz/iXBpFq70kKVtpOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910617; c=relaxed/simple;
	bh=3ojb/BkssJXnY53bJxstuYoB/xCo93EEKG5tDFtlPRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWTgBr8rtEuRkDbLZaIFbzqGNd37sC5/NqPWahJMsczBvJEppGk8YJTFE0YRg0iJtY+iNQ1oF4ywoeVzl2+KrtmY/kLkWLMxUuc4cWRLBSX6xDqgxCSEuxvIRZadZwmGE5v7kW2pieOKJPmo2xjLEGXAs3iMwx4vcBXMf+mzgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRpHD-00034m-MQ; Mon, 22 Jan 2024 09:03:27 +0100
Message-ID: <94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
Date: Mon, 22 Jan 2024 09:03:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] ath11k broken in v6.7
Content-Language: en-US, de-DE
To: Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
 <878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87jzo13jmf.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705910615;7459a376;
X-HE-SMSGID: 1rRpHD-00034m-MQ

On 22.01.24 08:36, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
>> Kalle Valo <kvalo@kernel.org> writes:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>
>>>> Just trying to make everyone aware because I suspect this will affect
>>>> quite a few people: ath11k is crashing during suspend on v6.7 due to a
>>>> mac80211 patch, more info:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218364

Many thx for the heads up, much appreciated. Sorry, forgot to add it to
the tracking myself: during the merge window thing are sometimes a bit
chaotic for myself as well. And I was head-down in rewriting some parts
of regzbot (see below).

>>>> Proposed fix:
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
>>>
>>> The fix is now applied:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>>>
>>> I'll try to use regzbot for the first time, let's see how it goes:
>>>
>>> #regzbot introduced: 0a3d898ee9a8 ^
>>
>> Forgot to include the bug report:
>>
>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218364

FWIW, that usage was slightly off and not how it's supposed to be done.
But whatever, let's ignore that. I'm reworking things currently
slightly, as you are not the first one that slightly got mislead -- and
the newer commands will hopefully be mire intuitive.

> #regzbot fix: 556857aa1d0855aba02b1c63bc52b91ec63fc2cc

Great, thx. Hope it reached mainline soon. Maybe once it's there you or
I should tell Greg to pick this up quickly for stable given that it
apparently "might affect quite a few people".

Thx again!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

