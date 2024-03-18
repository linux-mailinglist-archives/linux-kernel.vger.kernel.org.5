Return-Path: <linux-kernel+bounces-106217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B287EADA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B23F1C20FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE354E1DC;
	Mon, 18 Mar 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FFpxyMmW"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A84E1A0;
	Mon, 18 Mar 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771828; cv=none; b=S+pxOeC0qpULPs4J1oEt8CppXAf3Ix7O3JVtKMkqwNGsDVLGQH2KF97983wWW7TddkV3cfQgc9gtz52GAivsqw0qdqu4+u7WWXWYizItRgQzOjSPEdZh/68UQ6u1RvVbn9WyzI/1d5znHBgOSBpAH2mppFlGyFNKT8jmK+l1des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771828; c=relaxed/simple;
	bh=c6uoZOmmg1ClfgDRLu/D429KDEPIAYcmzMObVVAixM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fF/MvL7MaC1SGKhbIupe94uk03uB6FhdTcJp7ig2kkbndZ1IHoi4LUe7PUvnyHZ/62UHfJM3Vka+xucM0LYahFt+nt+XmQ0mhbRqQRJprgDTRTgBlwHKy6Wfw+bEs1AMXV85QtcvmRG1wk0145kGPfxUNwvWcJjBtlZvquRXWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FFpxyMmW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=XzC0+Hwr1TDXS2snk7C57VVemGg1yb3OgZJVr0YWweI=;
	t=1710771826; x=1711203826; b=FFpxyMmWvFTbLjGiACPSX12N0SAjl3w8iVSti7h9+2xLX8j
	loLa9AUWGCb4BJG+dID3I+DvDOWWCIzYXQCu95Jpyj/0JEEyhyZdsc1odrgKIa8LSa7y7PlM/BCew
	sIL4igoE7acCqQ6edJ0OzfyIeFEVZHzFdI9F9vJH3XM8qXOON2vabaTEa9+IXrJWgmXMEDBSdeqoa
	LV3qLiQtHBvp1BUqQuAX3zZ7tp5BwhncIsT8L8Ehq0c0XRFvlfRE4qVDJYsUDUALTqM4cVj27s+WO
	69TzEjbKBm7hwQblK0hLHoDhzVGoRc/TmWZC0r4+TublNkU5ESReXpe1pHgRsuqg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmDtv-0001UH-9b; Mon, 18 Mar 2024 15:23:43 +0100
Message-ID: <764f2b10-9791-4861-9bef-7160fdb8f3ae@leemhuis.info>
Date: Mon, 18 Mar 2024 15:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
Content-Language: en-US, de-DE
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>, stable@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
References: <20240306111157.29327-1-petr@tesarici.cz>
 <20240311182516.1e2eebd8@meshulam.tesarici.cz>
 <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
 <20240311192118.31cfc1fb@meshulam.tesarici.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240311192118.31cfc1fb@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710771826;9e9993c1;
X-HE-SMSGID: 1rmDtv-0001UH-9b

On 11.03.24 19:21, Petr Tesařík wrote:
> On Mon, 11 Mar 2024 18:43:59 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>> On Mon, Mar 11, 2024 at 6:25 PM Petr Tesařík <petr@tesarici.cz> wrote:
>>> On Wed,  6 Mar 2024 12:11:57 +0100
>>> Petr Tesarik <petr@tesarici.cz> wrote:
>>>  
>>>> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
>>>> initialized in the same file.
>>>>
>>>> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
>>>>
>>>>       static struct lock_class_key __key;
>>>>
>>>> Since u64_stats_init() is a function (albeit an inline one), all calls
>>>> within the same file end up using the same instance, effectively treating
>>>> them all as a single lock-class.  
>>> What happens with this fix now?
>>>
>>> IIUC it should be reviewed by Eric, but I don't know through which tree
>>> it should be merged. Any plans yet?  
>>
>> I thought I gave a reply, but apparently not .
>>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thank you!

Great. Just wondering, as there afaics was no activity since about one
week: what is the plan forward here?

Is the "through which tree it should be merged" question still
unresolved? I quickly looked and it seems two of the last tree changes
to that file over the past years went through net-next (the other one
through the tip tree). That's why I CCed the other two net maintainers
and the net list now.

Or is the plan to merge this after the merge window? Or only merge it
for 6.10, as it are bogus lockdep warnings that are being fixed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

