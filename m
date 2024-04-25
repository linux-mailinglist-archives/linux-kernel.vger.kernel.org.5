Return-Path: <linux-kernel+bounces-158191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E98B1CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B991281DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7384D7602B;
	Thu, 25 Apr 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ISEK/6P7"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08B6EB56;
	Thu, 25 Apr 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033559; cv=none; b=mS+mnw06nc8MQXnBkXhXTeg95CVAE2NApaOa6s4ukJU4IBLoYCTlhs+sl5xq83+zbP311CTGDPK/1QT3TOvTHTUinFk2FGPIP9DdiY8/ODBxiYh/zSDxFd46Cn5iEqs1iwmrXn/rCE00t3hKGULnX9VJE3drE/D1MI0TcFpslxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033559; c=relaxed/simple;
	bh=8OwDnxT/BWxIvNWqIts0KuoJtLvetaqykchXNQY8pXY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IflAEFFE90c/yTuu4eKoBK9SrlVff80B5caR97gIATZE1kJf1y8mVq/msto6pwmvPYEN8JMjq5auCNyGRNgGzQKf7OU6ylhXQ6lOT7r9MdjXH1DmTseIRfmmXKzWmHW0brv+O2D2HcB1MKA/U4/RX7Q0UPwtUKjnvsnBfkExpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ISEK/6P7; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3eKdcAaunz7UeynxgnkJpgqy7iwdenLUDp9NN2OrPJs=; t=1714033557;
	x=1714465557; b=ISEK/6P7BAZTVGk7nb70YyzXJ28/TN8kGkUw8WPi98CzTh8uMwRiIu6Bx3gg0
	YgcEcpqi6CZFYIfz2zxGMWW3qX5Fm0a8U3a8dohsbW3wrBaVHc9Uf1yiPPGr2SrtRjlPjj+0S+qJf
	CrM4Mv9wsu1Gl54HUcYR1X/RF9sndGRLv+UCU5ss9d/Q3Rfq3QU9j4M6/fggwO1oBhY4YPb3h0nrF
	AgNQcpjWisr6SCCwF0KnFTD8M8oSD2EXnKvZack8AGIIWe59a0BF9cIEjzWpnwnS8jaeZCbYVJFm/
	TAjGnLRddN5MkB8rf4xxtNPr+wSwtfNb+X4D8VunsEst7w5qEw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzuQO-0003Hx-Ec; Thu, 25 Apr 2024 10:25:48 +0200
Message-ID: <87698732-5439-42bd-b2b2-864bb4f3b3ec@leemhuis.info>
Date: Thu, 25 Apr 2024 10:25:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: regression fixes sitting in subsystem git trees for a week or
 longer
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240331182440.14477-1-kl@kl.wtf>
 <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
 <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
 <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
 <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
Content-Language: en-US, de-DE
In-Reply-To: <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714033557;d16c12a9;
X-HE-SMSGID: 1rzuQO-0003Hx-Ec

On 24.04.24 20:53, Linus Torvalds wrote:
> On Wed, 24 Apr 2024 at 09:56, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> out of interest: what's your stance on regression fixes sitting in
>> subsystem git trees for a week or longer before being mainlined?
> 
> Annoying, but probably depends on circumstances. The fact that it took
> a while to even be noticed presumably means it's not common or holding
> anything up.

Well, I searched and found quite a few users that reported the problem:

https://bbs.archlinux.org/viewtopic.php?id=293971 (at least 4 people)
https://bbs.archlinux.org/viewtopic.php?id=293978 (2 people)
https://bugzilla.redhat.com/show_bug.cgi?id=2271136 (1)
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061040 (1)
https://forums.opensuse.org/t/no-touchpad-found-el-touchpad-a-veces-es-reconocido-por-el-sistema/174100 (1)
https://oldos.me/@jay/112294956758222518 (1)

There are also these two I mentioned earlier already:
https://social.lol/@major/112294920993272987 (1)
https://lore.kernel.org/all/9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org/ (1)

Side note: there were more discussions about it here:
https://forums.lenovo.com/t5/Fedora/PSA-Z16-Gen-2-touchpad-not-working-on-kernel-6-8/m-p/5299530
https://www.reddit.com/r/thinkpad/comments/1bwxwnr/review_thinkpad_z16_gen_2_with_arch_linux/
https://www.reddit.com/r/linuxhardware/comments/1bwxhwa/review_thinkpad_z16_gen_2_arch_linux/

And the arch linux wiki even documents a workaround:
https://wiki.archlinux.org/title/Lenovo_ThinkPad_Z16_Gen_2#Initialization_failure

Those are just the reports and discussions I found. And you know how
it is: many people that struggle will never report a problem.


IMHO this all casts a bad light on our "no regression" rule, as the
fix is ready, just not mainlined and backported. And as I mentioned:
I see similar situations all the time. That's why I made noise here.


> That said, th4e last HID pull I have is from March 14. If the issue is
> just that there's nothing else happening, I think people should just
> point me to the patch and say "can you apply this single fix?"

Then I'll likely do so in my regression reports more often.

Is cherry picking from -next as easy for you? Maintainers sometimes
improve small details when merging a fix, so it might be better to
take fixes from there instead of pulling them from lore.

Ciao, Thorsten

P.S: Wondering if I should team up with the kernel package maintainers
of Arch Linux, Fedora, and openSUSE and start a git tree based on the
latest stable tree with additional fixes and reverts for regressions
not yet fixed upstream...[1] But that feels kinda wrong: it IMHO
would be better to resolve those problems quickly in the proper
upstream trees.

[1] yes, I'm fully aware that such a tree can only address some of the
issues; but from what I see that already would make quite a difference.

