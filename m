Return-Path: <linux-kernel+bounces-59144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7484F1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38458B25758
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E523664CA;
	Fri,  9 Feb 2024 09:09:59 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF922092;
	Fri,  9 Feb 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469798; cv=none; b=kqJt1hC42sGj/QGSvK9Vo678aP6JqrPO3kJ13H5ed4qAAx5SBt7vruq9uAohw/B/DQv/EYxNj9KL96rCoDohwiwil8Ez1c7yjpYpEDus/rdvjlbIj39N1S5S2OIJYL3Q6UBZGd8/MZ3sroxoKYKXkmrkQw810r7UTtGlrG8P0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469798; c=relaxed/simple;
	bh=eZ3ZS6aFeDJIgLODjm0i+7CNAI7CgMeLhDSvct5oorM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcTT81V4mHE2r5OOZ3i8YGuHK1poAVbq6A7lMdykR0uFy/yLPKFcSANk/m7OWmba4TfLxAUSDZoUnnYpe35jw33DaasZivjSZx5CSOmhlqTK5t96BxqcdBQ5rrdUxPGlmSDxXgdJ5vKcgjQDu6VOYLzsgS/m8yRISTPklCXc3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rYMtN-0007qn-4W; Fri, 09 Feb 2024 10:09:53 +0100
Message-ID: <e9a72160-2d39-4090-8822-ca68477f429f@leemhuis.info>
Date: Fri, 9 Feb 2024 10:09:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Content-Language: en-US, de-DE
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 Sven Peter <sven@svenpeter.dev>, Michael Walle <michael@walle.cc>,
 linux-kernel@vger.kernel.org
References: <20240122153442.7250-1-arnd@kernel.org>
 <170594251756.17335.7078970144473561827.b4-ty@linaro.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <170594251756.17335.7078970144473561827.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707469797;a976a931;
X-HE-SMSGID: 1rYMtN-0007qn-4W

On 22.01.24 17:55, Srinivas Kandagatla wrote:
> On Mon, 22 Jan 2024 16:34:10 +0100, Arnd Bergmann wrote:
>> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc1 on
>> Apple M1, which (in downstream dts files) has multiple nvmem cells that use the
>> same byte address. This causes the device probe to fail with
>>
>> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
>> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                 6.8.0-rc1-arnd-5+ #133
>> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
>> [    0.605362] Call trace:
>> [...]
> 
> Applied, thanks!
> 
> [1/1] nvmem: include bit index in cell sysfs file name
>       commit: b40fed13870045731e374e6bb48800cde0feb4e2

The problem description from Arnd to an outsider like me sounded like
this is something that should be fixed rather sooner than later in
mainline. Am I wrong with that? If not: will this be heading to Linus
soon? Just wondering, as the fix seems to be a in "for-next" branch[1]
of the nvmem repo and not in a "fixes" branch.

Or am I missing something here?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

