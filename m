Return-Path: <linux-kernel+bounces-154786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29818AE100
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C851C21B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749158ABC;
	Tue, 23 Apr 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ED0I1g6x"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAF20B33;
	Tue, 23 Apr 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864592; cv=none; b=i0XzmGwDUN4dYaaqlAuL32ahGvSnPTfEkQ6spXgfIjPPCGzSxAl01oAzHxKC/OOBKT7mg9Q9f8hnMOm7R7z1Hp1SNTjtkxOqCP/6ybiHzvxBxlyV6LIwqJUQtEx8XfavoEm3xJtUvx8TIorFsc2e3iwn7YAO+F3ou4LPA1R2lF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864592; c=relaxed/simple;
	bh=DKrNix9sXqeDeTqS0MKl9OJhP1yFEStDlJovycaWhCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umVJyK8abD4RmBceiZVGNmF79K+add7kbQbuVuSGuM8lG0d3urcMDxdrDaDL6BVr+7OfphAIvUXiKH+crj30cDwQsJW17FS3bPerukJJCMx/dpkMb4h046qP7ViCz/vsvAtSkDWW29eM6WN3NSHN+ThM69MllE66Jv5XJZ/5C6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ED0I1g6x; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=0mkJ60YZ9h04LMO+Q8FAelHEGO/T+BnTHaX56USQTIU=;
	t=1713864591; x=1714296591; b=ED0I1g6x+z56eIVe6T8eMrh+07e5Mn2ZT41zWgyuVXNneFP
	jq10zHxvUeIJwFG0G3O5cWmbR2/ZU7yC18eghv7HhFYx6/cBmLVn/IM5Hmm6jzjIeha7MF3AzOP4S
	5ugN6XoWKG5f7YsI7iC7uBWJnprwz9rW2aQSWvIu1LWqSDk8mJDYrUdWycNw63fC/ct75s8568S+f
	uZaUuDCKWh7gCQ3AQgP2k+55GfQcHeVQWrrIM4rrZQWQ8G+oA3QQfS4F1SysKWinCCi4Xs5xxKLTt
	dZNEdy9+AQMmASq8UI1fG6nJVCn8s/tQRqrcS6gLWC2jIguxhC6IVSa6JmV+lHEA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzCTE-00077K-IW; Tue, 23 Apr 2024 11:29:48 +0200
Message-ID: <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
Date: Tue, 23 Apr 2024 11:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
To: Lee Jones <lee@kernel.org>, Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713864591;864d740c;
X-HE-SMSGID: 1rzCTE-00077K-IW

On 23.04.24 11:06, Johannes Berg wrote:
> On Tue, 2024-04-23 at 11:00 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> On 16.04.24 08:17, Johannes Berg wrote:
>>> On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
>>>>
>>>> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
>>>> iwl_req_fw_callback()
>>>>
>>>> Is that still best thing to try in your opinion?
>>>
>>> I guess so, I don't have any better ideas so far anyway ...
>>
>> [adding the iwlwifi maintainer; thread starts here:
>> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
>>
>> ]
>>
>> Johannes, Miri, what's the status wrt to this regression? From here
>> things look somewhat stalled -- but maybe there was progress and I just
>> missed it.
> 
> What do you want? It got bisected to an LED merge, but you ping _us_?
> Way to go ...

Sorry, to me it sounded a bit like you had an idea for a fix and were
going to give it a try -- similar to how the maintainers for a r8169
driver and the igc driver provided fixes for bugs recent LED changes
exposed.

But sure, you are right, in the end some LED change seems to have cause
this, so the duty to fix it lies in that field. Therefore:

Lee, what's the status here to get this fixed before the final?

Ciao, Thorsten



