Return-Path: <linux-kernel+bounces-37469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB583B082
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A81C212A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E4D12BF3B;
	Wed, 24 Jan 2024 17:51:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9812BF05;
	Wed, 24 Jan 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118696; cv=none; b=BMcpH14/fjpBEgsjPuNdNaEo0wCm2eoAMim9wJoV6VBXvtcgvdiLVANZUXXtMm1OSq+lxR9vh0N1ZmBQE8VJluGtcWGxufWZFmygx/bs6kw8XA+hnCH+jUauw2l2/W7IP5drtQKWogp6MWvf0cnr0JMTg+SGnGaiGrWht/LEKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118696; c=relaxed/simple;
	bh=yKIM21Iww3LTk3QxAjQzqREIegASwkkai/qDvoZNrkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8du6fAuCP7bqpg37wynjpBZBm59LGpM9zkoqZHzqy6kocL+QzVjQ58xmD4yQB+iXwZUTNB8TkHSI3RXFMpuyWFQhhQYp3Ml3xYDczTFQKGXTRVbeDjTYYypDzCLeBxim22K3typ8kZj5Y2TbA172ucQp2QmeEDUx4Ob96K7kzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rShPP-0004yI-KF; Wed, 24 Jan 2024 18:51:31 +0100
Message-ID: <e7eb12a9-67ed-45b1-aaf6-e1df52a247bd@leemhuis.info>
Date: Wed, 24 Jan 2024 18:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [git pull] drm for 6.8
Content-Language: en-US, de-DE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vlastimil Babka <vbabka@suse.cz>, Donald Carr <sirspudd@gmail.com>
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
 <2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz>
 <CAOVeLGRxXfs4wxSmB2ULZS72NvJkWQvZyPRz0rAmQyFtL39ekw@mail.gmail.com>
 <0a782904-bb19-4111-979a-31b52aa44ca9@suse.cz>
 <a51ddb8c-cf11-4394-a2fe-ca855749ff02@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <a51ddb8c-cf11-4394-a2fe-ca855749ff02@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706118694;3934329c;
X-HE-SMSGID: 1rShPP-0004yI-KF

Linus, if you have a minute, I'd really like to know...

On 24.01.24 17:41, Mario Limonciello wrote:
> On 1/24/2024 10:24, Vlastimil Babka wrote:
>> On 1/24/24 16:31, Donald Carr wrote:
>>> On Wed, Jan 24, 2024 at 7:06 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> When testing the rc1 on my openSUSE Tumbleweed desktop, I've started
>>>> experiencing "frozen desktop" (KDE/Wayland) issues. The symptoms are
>>>> that
>>>> everything freezes including mouse cursor. After a while it either
>>>> resolves,
>>>> or e.g. firefox crashes (if it was actively used when it froze) or it's
>>>> frozen for too long and I reboot with alt-sysrq-b. When it's frozen
>>>> I can
>>>> still ssh to the machine, and there's nothing happening in dmesg.
>>>> The machine is based on Amd Ryzen 7 2700 and Radeon RX7600.
>>> [...]
>>> I am experiencing the exact same symptoms;
>>
>> Big thanks to Thorsten who suggested I look at the following:
>>
>> https://lore.kernel.org/all/20240123021155.2775-1-mario.limonciello@amd.com/
>> https://lore.kernel.org/all/CABXGCsM2VLs489CH-vF-1539-s3in37=bwuOWtoeeE+q26zE+Q@mail.gmail.com/
>>
>> Instead of further bisection I've applied Mario's revert from the
>> first link
>> on top of 6.8-rc1 and the issue seems gone for me now.
> 
> Thanks for confirming.  I don't think we should jump right to the revert
> right now.
>
>  I posted it in case that is the direction we need to go
> (simple git revert didn't work due to contextual changes).
> 
> Let's give the folks who work on GPU scheduler some time to understand
> the failure and see if they can fix it.

..how you think about this and other situations like this. Given that
we have

* two affected people in this thread
* one earlier thread about it
* the machine that made Mario write the patch
* and I have someone in #fedora-kernel that likely is affected as well

it seems that this is not some corner case very few people run into.
Hence I tend to say that this should be dealt with rather sooner than
later. Maybe before rc2? Or is this asking too much?

The thing from my point of view is, that each such problem might
discourage testers from testing again or lead to thoughts like "I only
start testing after -rc4". Not to mention that other people will try to
bisect the problem like Vlastimil did, which will cost them quite some
time and effort -- only to find out that we known about the problem
already and did not quickly fix it. That is discouraging for them as
well and thus bad for field testing I'd assume.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

