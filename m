Return-Path: <linux-kernel+bounces-154747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30118AE07C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265F5B2103B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECDB58236;
	Tue, 23 Apr 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pi8Lz4FM"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B925647F;
	Tue, 23 Apr 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862854; cv=none; b=BbCgyHKZdadeOCTP1x9Ysiegc9nPFDPxsE0g95MZuwwl7/t9Tz1VtXkI9xHv4aHM4BmKaB55Zc38wuqI2pos1ZYaj5zAmbprbee+pXtxESSlL73XfNUa/uNKpSmsTPWhe2KWAyTQUXa4uxleta9phx/G5lKLEg+kBODbcWXjPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862854; c=relaxed/simple;
	bh=DVL/W006mq7B8XRru41g4X8LQ/QFyfpjIosJSHzQt7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlPqQFmvOge6I09bCjyAoLNY7im3lfYO8Ic+5qUnF/KkYh14bXMCVrUtqII3RVzWM4CE/M3/aAxFX27Ydg66brfxzT9mNeC0+ke73HbHa6xPdE3s0GtbOJCT8XA5pt//t26Z3VPOTixTT8lQj6BwSa4rBpduJymTqzBl9pAneN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pi8Lz4FM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=rZoO7ltG3psc+RMtbCywngv1xFSki99rx9Qg2yUYeDY=;
	t=1713862849; x=1714294849; b=pi8Lz4FMeS88/pL4t/BZI+mzwR1XURZ3pWX3VQziH/aUDMH
	IJQOY96L4PJKa3PZgsi657gii2u7Gg4sPkxUTXIJ2ZCapLRwb3pejurux4JvugNiFZFjuJPxbt4L4
	9SCVYvs67jHxwISBk4VUah6KCcjz968u8+VNB8MX5msrHg4YSDN7SDcCrlPcVsktiumwA0huLMowO
	Wgl1O0zzBj/GkkEPJHABiIamBOqXYxiwlxNHMXz0EAZyYavYoqiglhdX9HI0JvRhmAwLmy5cKbMdw
	RrEdTij+/x23UvpvNLEdpJYL+4IqdZF3VDPSdxjAJbmSBf/bIruuCdvIn0l6Notg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzC15-0000B6-B2; Tue, 23 Apr 2024 11:00:43 +0200
Message-ID: <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
Date: Tue, 23 Apr 2024 11:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
 Ben Greear <greearb@candelatech.com>, Lee Jones <lee@kernel.org>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713862849;391881e7;
X-HE-SMSGID: 1rzC15-0000B6-B2

On 16.04.24 08:17, Johannes Berg wrote:
> On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
>>
>> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
>> iwl_req_fw_callback()
>>
>> Is that still best thing to try in your opinion?
> 
> I guess so, I don't have any better ideas so far anyway ...

[adding the iwlwifi maintainer; thread starts here:
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

]

Johannes, Miri, what's the status wrt to this regression? From here
things look somewhat stalled -- but maybe there was progress and I just
missed it.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

