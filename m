Return-Path: <linux-kernel+bounces-158302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD98B1E10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A61F21F35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539084DE7;
	Thu, 25 Apr 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="U5Ld14Nr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14184D0D;
	Thu, 25 Apr 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037601; cv=none; b=S+CIHUcEwpsBdA+FSlCGiYkr2iXhtN7ao5si3gizoEE/p9Urx1j1QGY9Zqmgu+7p7Qx6GBM18v0ihTn0vg1SeF2eddzE0D35P4SeymCTd0LuDBQtCp/Q28ozWrXE6brTtLnNkJ9YrymKTmFv91FnXT4HnMXhWY7m5yhgztr3Uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037601; c=relaxed/simple;
	bh=bYBBBONI6emX61ioif4BoxQH1QXZYaWJIll/t+Fju9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVAj7jYcix4KLdYVUSKqvzBFjZ7Xwv463qOVQLoHV68VV7EgbD2LNpbjqYwkQ5Yq+vBAs4sMD+qY5zQODfT903IWKn7HnXNB6MnkFLCz9OyJBvYEWn5qK9xUU4xrR5jNYST6SL/p/rItuocZeiv3Kmgq91/uEYB8nngbHEaYc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=U5Ld14Nr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=mTFvKavRYvl65ZTJWrbvt4xMi66fJbqKJd1ndJa0LB4=;
	t=1714037599; x=1714469599; b=U5Ld14NrRC69jQ02N/CKP8u2KZ9HQ2pox/W8q66iMBpAMLh
	+ADoYtyVOcY2TfabpHoikHkjGlQUIvdCbsrppr2n2sCv7BdgMkvUBLTLLg7ZseZx6R7IlZ3JFibgG
	36+R2TxZ5PSoM+ua1hSlmajMYZ3j3YpphPu3e3TapvlaM2zt1r9jCBP+SoAwJv/GegS25Mx1lqDlO
	/7mnmtntUNiFiiecuHfD3kZTJlk+ipJXMdFqPO+29i/UpX/aN3RU+XW1T2iEnUPh7xqzEOJuR/h5W
	oEC2Cjrwb3mZLejnums7umo0+ZTl2ZeCNS2t4++fq0YthYIX7d8FrUcFui+N99bQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzvTZ-0000vn-6B; Thu, 25 Apr 2024 11:33:09 +0200
Message-ID: <9fb128b1-d625-477f-8a16-aade00b13bc6@leemhuis.info>
Date: Thu, 25 Apr 2024 11:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression fixes sitting in subsystem git trees for a week or
 longer
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240331182440.14477-1-kl@kl.wtf>
 <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
 <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
 <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
 <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
 <87698732-5439-42bd-b2b2-864bb4f3b3ec@leemhuis.info>
 <qcd5klmhyx23rowpbm4egshm6hemhh4stq7r6soblnuul55524@yyktdlowepw7>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <qcd5klmhyx23rowpbm4egshm6hemhh4stq7r6soblnuul55524@yyktdlowepw7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714037599;69439cdb;
X-HE-SMSGID: 1rzvTZ-0000vn-6B

On 25.04.24 10:44, Benjamin Tissoires wrote:
> On Apr 25 2024, Thorsten Leemhuis wrote:
>> On 24.04.24 20:53, Linus Torvalds wrote:
>>> On Wed, 24 Apr 2024 at 09:56, Thorsten Leemhuis
>>> <regressions@leemhuis.info> wrote:
>> [...]
>> And the arch linux wiki even documents a workaround:
>> https://wiki.archlinux.org/title/Lenovo_ThinkPad_Z16_Gen_2#Initialization_failure
>>
>> Those are just the reports and discussions I found. And you know how
>> it is: many people that struggle will never report a problem.
> 
> short FYI, (I've Cc-ed you on the PR), but I just sent the PR for HID,
> which includes this fix.

Great, many thx. Saw it right after sending my mail... :-/

>> Is cherry picking from -next as easy for you? Maintainers sometimes
>> improve small details when merging a fix, so it might be better to
>> take fixes from there instead of pulling them from lore.
> 
> Maybe one suggestion that might help to reduce these kind of situations
> in the future: can you configure your bot to notify the maintainers
> after a couple of days that the patch has been merged that it would be
> nice if they could send the PR to Linus?

Yes, that is an idea in the long run, but I'm not sure if it's wise now
or later. People easily get annoyed by these mails (which I totally
understand!) and then will start hating the bot or regression tracking
in general. That's why I'm really careful here.

There are also the subsystems that regularly flush their fixes shortly
before a new -rc, so they likely never want to see such reminders. And
sending them right after a new -rc is better than nothing, but not ideal
either.

IOW: it's complicated. :-/

> In this case I bet Jiri forgot to send it because he was overloaded and
> so was I.

Understood and no worries. But this became a good opportunity to raise
the general problem, as that is something that bugs me. Sorry. Hope you
don't mind to much that I used that chance.

> So a friendly reminder could make things go faster.

I'll already did this occasionally manually, but that of course does not
scale. Sometimes I wonder if it would be more efficient for nearly all
of us if subsystems just flushed their -fixes branch shortly before each
new -rc, as Linus apparently is not bothered by PRs that contain just a
change or two. But that of course creates work for each of the subsystem
maintainers, unless they creates scripts to handle that work nearly for
free (it seems to me the x86 folks have something like that).

Of course that would mean...

> And maybe, before sending the reminder, if you could also check that the
> target branch hasn't been touched in 2 days that would prevent annoyances
> when we just added a commit and want to let it stay in for-next for 24h
> before sending the full branch.

..that nothing big or slightly dangerous should be merged to -fixes
branches on Fridays.

>> P.S: Wondering if I should team up with the kernel package maintainers
>> of Arch Linux, Fedora, and openSUSE and start a git tree based on the
>> latest stable tree with additional fixes and reverts for regressions
>> not yet fixed upstream...[1] But that feels kinda wrong: it IMHO
>> would be better to resolve those problems quickly in the proper
>> upstream trees.
> 
> I would also say that this is wrong. Unless all regressions go through
> your tree and you then send PR to Linus, [...]

Ohh, sorry, I was not clear here, as that would be totally wrong --
fixes definitely should go through the subsystems trees, as they have
the knowledge and the infra to check them (hmm, maybe a dedicated tree
might make sense for the smaller subsystems, but let's ignore that).

What I meant was just a tree those distros could merge into their
kernels to quickly resolve issues that upstream is slow to fix. But that
obviously has downsides, too. And is yet more work.

> However, do you have some kind of dashboard that you could share with
> the package maintainers? This way they could easily compare the not-yet
> applied fixes with their bugs and decide to backport them themselves.

I have for the kernel overall, but nothing subsystem specific. But that
is pretty high on my todo list, as...

> In other words: let others do the hard work, you are doing a lot already

..I'm very well aware of this. :-/

Ciao, Thorsten

