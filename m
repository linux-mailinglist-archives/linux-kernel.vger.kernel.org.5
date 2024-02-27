Return-Path: <linux-kernel+bounces-83151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD35868F85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FAB2146F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F813A24A;
	Tue, 27 Feb 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="nVettvaK"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4A12F581;
	Tue, 27 Feb 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035001; cv=none; b=eYZCZ7Ux9alidRjq+3vhHUqTibyMm1XKllmPfescNTbi77cSyab90XWIUgTQtcyiImTQK5eDKeeJ6uduS6FgaAmv/9M/9EG2oFWDOip8A5vaYyAzTokbEglc6yWJRRUnF/8WtPOSJOgK26UVQekZbOrFIIzcGe5rmjYd+XOkA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035001; c=relaxed/simple;
	bh=XpIn0xke6ZmIbUAfWG9Z6nLpSy/56Ej6LZa1r/3tgQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmUnglCD0gCHE0UgZq8Icwrg6Hpcgxai8HCGNPs5M2QqjE3+rNVorbytcvo5VmJW3BGO+tMhBZk0m47jX/AVweaqm/U1dHAmwgHc7D45jooWW7cQZHobAmQIxt6Lk6J+y07h/bRSTAq5kxvYnF7gHwVWP8q0pTi+aZpqJGMFl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=nVettvaK; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=PnirhBwWb9f3Ouw6PnkL+0O6UnmQ5w6CyFE3GoLuG3Y=; t=1709034998;
	x=1709466998; b=nVettvaK+gGlSWpDRC0FiJCOTRISer+zT4azpUttxQFdXYBpRJ6Y18K9YWODx
	6C2oYOByJNH4u9B6XgOY1sGY90GRYJ2A+kRI/MFqCFN92P2gwJNBkb3qn302bXykZKWcCkXUs1Rum
	Uu681mgDgupBkI0+8f52Y7WgUC1qpWk7spQ71fwZoQOShK4i4rJsx3UF2YCIskwK4ZUAopuNN/dJk
	JN5tU8ba94Q+Tocx0InF9f8D3U6T7xRK2LPhW2gAwjKgAtaCfZxWMweJOwF0vPQuUG0eelvCMeIbA
	l63vLGdoHdMdgiMlX2IOSQTiqoHUqFu2HsP9/BdSZsefv+KVpw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rew4U-0001xE-OL; Tue, 27 Feb 2024 12:56:30 +0100
Message-ID: <f2eaf931-8488-48e3-b008-1cedeba24f12@leemhuis.info>
Date: Tue, 27 Feb 2024 12:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2024-02-25]
Content-Language: en-US, de-DE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <5ffb73e0-4b00-4bbb-857a-30a48945758d@leemhuis.info>
 <CAHk-=wiHmYxCP36ngovZimX9sixWxMrGA_WZdYyE8JPqBQ6ysw@mail.gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <CAHk-=wiHmYxCP36ngovZimX9sixWxMrGA_WZdYyE8JPqBQ6ysw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1709034998;7c15b21a;
X-HE-SMSGID: 1rew4U-0001xE-OL

On 26.02.24 18:33, Linus Torvalds wrote:
> On Sun, 25 Feb 2024 at 06:21, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Sorry, forgot something: there is a patch to fix a ntfs3 build problem
>> that was posted 10+ days ago[1] that didn't get any reaction from the
>> ntfs3 maintainer at all. Given the history of occasional slow responses
>> for that subsystem I thought I'd let you know in case you want to pick
>> the fix up directly; but if you do, consider using v2 of the patch[2].
> 
> Ack. Picked up directly.

Thx!

BTW, let me quickly mention two somewhat tricky regressions where I'm
unsure if they are handled how you want them to be handled.

* Multiple users were changing the minimum power limit of their Radeon
graphic cards to reduce the power consumption. Since 1958946858a62b
("drm/amd/pm: Support for getting power1_cap_min value") [v6.7-rc1] they
are unable to go as low as before, as amdgpu now respects a lower-bound
power limit ignored earlier. For details see:
https://lore.kernel.org/regressions/ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org/
https://gitlab.freedesktop.org/drm/amd/-/issues/3183
https://gitlab.freedesktop.org/drm/amd/-/issues/3137
https://gitlab.freedesktop.org/drm/amd/-/issues/2992#note_2247003

  There was the idea to introduce a module parameter (see the lore
discussion linked above) to allow users what they were able to do
before. The amdgpu developers don't want to go down that path.


* Mikhail Gavrilov reported decreased network outgoing performance
caused by f977f4c9301c8a ("xhci: add handler for only one interrupt
line") [v6.8-rc1]: down from ~97-110MB/sec to 66-70MB/sec. Turns out
this is caused by the network device and xhci (USB) drivers now sharing
interrupts:
https://lore.kernel.org/lkml/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/

  Mathias Nyman said that "Mikhail got unlucky" and Tglx called it a
"unfortunate coincidence"; both do not see a need for fix.


In both cases I up to a point can totally understand the point of view
of the developers that handle the situation; at the same time I was
unsure if those situation are handled as you want them to be handled.
That's why I brought them up here. If I don't hear anything from you
I'll assume everything is fine the way it is and will stop tracking both
regressions.

Ciao, Thorsten

