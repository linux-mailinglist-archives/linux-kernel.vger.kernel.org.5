Return-Path: <linux-kernel+bounces-158209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B68B1D01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94161F2389E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773C7FBB0;
	Thu, 25 Apr 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT9364VM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C27764E;
	Thu, 25 Apr 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034697; cv=none; b=erzepz+FtBwi3mZQWoaSsiuqaq6HGLV5AJ2xhPaGZ0Cd/EoC8ymmahaMcGN/b+JC7w0ROxaKa5o8DM7FSTIVNcvz8+8+finoZruquwo2Wy8rcuq7oV/hLLCbk/+rK26JtmWY+DxQxyNlxWH25ADOnTHNGcawhW/HLABvFUeT0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034697; c=relaxed/simple;
	bh=bYe5R8EHZCktdj4e/a8hGUSDaDaAOflN35ZbtmFQOug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGlJJHa5nPmildqyVfGoJFYQo6YxmHND2Bu4qfTyZq0c5SKApRw6rPRd7ZH+SeMPd7lEr96IdAOMWFFKvHrEjatF+7aIHA5kC/TrDk18y06CmgbCTeWviXfxs51Cteed749SKCr2gsFPWVKWV4lWINQ+dVvvfK67FG95ds1f/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT9364VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEC0C113CC;
	Thu, 25 Apr 2024 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714034697;
	bh=bYe5R8EHZCktdj4e/a8hGUSDaDaAOflN35ZbtmFQOug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RT9364VMwPqaI687iYiSycOppH2GlmKYhIuETBhADlzf2DE4hannuC/Qr7kjZJ9Ez
	 KfR+1aDxDrbcRrIEiKWq1Lty6sMtEnwv831kUatNt3rnzuZ1XgfJn0mdqWTLmVBrZZ
	 rcAsAKKg5kV9SRIrY0pqRn6vLY2Sh5+0NSA0lMjY1xXsxS/u9oONPZCZDGcWpWKLSD
	 2TUuPEzaudNGpTq5ZYKeoS8yIP4V9gL1jPh22HRu51sfGslT7y/PvBAyn5H1AlB9tn
	 91oqDt/dM0GK9VhYbxK5Prj94nXLuewk2WD59PckNxBThXAGLc+3tDEwK0OYO7S9il
	 k+UWWBanQwh+g==
Date: Thu, 25 Apr 2024 10:44:52 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kenny Levinsen <kl@kl.wtf>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: regression fixes sitting in subsystem git trees for a week or
 longer
Message-ID: <qcd5klmhyx23rowpbm4egshm6hemhh4stq7r6soblnuul55524@yyktdlowepw7>
References: <20240331182440.14477-1-kl@kl.wtf>
 <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
 <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com>
 <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
 <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
 <87698732-5439-42bd-b2b2-864bb4f3b3ec@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87698732-5439-42bd-b2b2-864bb4f3b3ec@leemhuis.info>

On Apr 25 2024, Thorsten Leemhuis wrote:
> On 24.04.24 20:53, Linus Torvalds wrote:
> > On Wed, 24 Apr 2024 at 09:56, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> out of interest: what's your stance on regression fixes sitting in
> >> subsystem git trees for a week or longer before being mainlined?
> > 
> > Annoying, but probably depends on circumstances. The fact that it took
> > a while to even be noticed presumably means it's not common or holding
> > anything up.
> 
> Well, I searched and found quite a few users that reported the problem:
> 
> https://bbs.archlinux.org/viewtopic.php?id=293971 (at least 4 people)
> https://bbs.archlinux.org/viewtopic.php?id=293978 (2 people)
> https://bugzilla.redhat.com/show_bug.cgi?id=2271136 (1)
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061040 (1)
> https://forums.opensuse.org/t/no-touchpad-found-el-touchpad-a-veces-es-reconocido-por-el-sistema/174100 (1)
> https://oldos.me/@jay/112294956758222518 (1)
> 
> There are also these two I mentioned earlier already:
> https://social.lol/@major/112294920993272987 (1)
> https://lore.kernel.org/all/9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org/ (1)
> 
> Side note: there were more discussions about it here:
> https://forums.lenovo.com/t5/Fedora/PSA-Z16-Gen-2-touchpad-not-working-on-kernel-6-8/m-p/5299530
> https://www.reddit.com/r/thinkpad/comments/1bwxwnr/review_thinkpad_z16_gen_2_with_arch_linux/
> https://www.reddit.com/r/linuxhardware/comments/1bwxhwa/review_thinkpad_z16_gen_2_arch_linux/
> 
> And the arch linux wiki even documents a workaround:
> https://wiki.archlinux.org/title/Lenovo_ThinkPad_Z16_Gen_2#Initialization_failure
> 
> Those are just the reports and discussions I found. And you know how
> it is: many people that struggle will never report a problem.
> 

short FYI, (I've Cc-ed you on the PR), but I just sent the PR for HID,
which includes this fix.

> 
> IMHO this all casts a bad light on our "no regression" rule, as the
> fix is ready, just not mainlined and backported. And as I mentioned:
> I see similar situations all the time. That's why I made noise here.
> 
> 
> > That said, th4e last HID pull I have is from March 14. If the issue is
> > just that there's nothing else happening, I think people should just
> > point me to the patch and say "can you apply this single fix?"
> 
> Then I'll likely do so in my regression reports more often.
> 
> Is cherry picking from -next as easy for you? Maintainers sometimes
> improve small details when merging a fix, so it might be better to
> take fixes from there instead of pulling them from lore.

Maybe one suggestion that might help to reduce these kind of situations
in the future: can you configure your bot to notify the maintainers
after a couple of days that the patch has been merged that it would be
nice if they could send the PR to Linus?

In this case I bet Jiri forgot to send it because he was overloaded and
so was I. So a friendly reminder could make things go faster.

And maybe, before sending the reminder, if you could also check that the
target branch hasn't been touched in 2 days that would prevent annoyances
when we just added a commit and want to let it stay in for-next for 24h
before sending the full branch.

> 
> Ciao, Thorsten
> 
> P.S: Wondering if I should team up with the kernel package maintainers
> of Arch Linux, Fedora, and openSUSE and start a git tree based on the
> latest stable tree with additional fixes and reverts for regressions
> not yet fixed upstream...[1] But that feels kinda wrong: it IMHO
> would be better to resolve those problems quickly in the proper
> upstream trees.

I would also say that this is wrong. Unless all regressions go through
your tree and you then send PR to Linus, you might quickly get
overloaded because sometimes the fix can not be cherry-picked if there
is one other change just before.

However, do you have some kind of dashboard that you could share with
the package maintainers? This way they could easily compare the not-yet
applied fixes with their bugs and decide to backport them themselves.

In other words: let others do the hard work, you are doing a lot already
:)

Anyway, I really think a friendly reminder would help makes things go
faster. Something like "Hey, it seems that you applied a regression fix
that I am currently tracking and that you haven't sent the PR to Linus
yet. Could you please send it ASAP as we already have several users
reporting the issue?".

Cheers,
Benjamin

> 
> [1] yes, I'm fully aware that such a tree can only address some of the
> issues; but from what I see that already would make quite a difference.

