Return-Path: <linux-kernel+bounces-21781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF9829430
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC54B1F2709F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A46F39859;
	Wed, 10 Jan 2024 07:22:52 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F738DCA;
	Wed, 10 Jan 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rNSvA-0002wC-7p; Wed, 10 Jan 2024 08:22:40 +0100
Message-ID: <7613e402-894a-4d38-8cef-7263630c1c57@leemhuis.info>
Date: Wed, 10 Jan 2024 08:22:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Subject: A quick "Regression tracking: state of the union early 2024" from my
 side
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1704871369;3c76bbb3;
X-HE-SMSGID: 1rNSvA-0002wC-7p

[I initially published below text on
https://linux-regtracking.leemhuis.info/post/status-jan2024/ ; reposting
it here for completeness and in case anyone wants to comment on it]

## The long story short

I'm not really happy with my performance wrt to my regression tracking
efforts during the last year. To counter that, I've already shifted my
focus somewhat ~in October. With the new year I will shift it some more.
Top-priority will be "make regzbot more useful for kernel subsystem
maintainers" from now on. My tracking efforts of course will continue,
but everything except regressions in the current and the previous
mainline cycle might not see much attention from my side. This
refocusing also means that I won't work much on resolving some
ambiguities around "how regressions are supposed to be handled" which
lead to tension quite a few times. But all that should be for the best
in the long term.

## The details

### Looking back at 2023

My regression tracking efforts with regzbot still have a circus factor
of "one": if I'd run off and join a circus tomorrow, it's likely that
nobody would continue my work. That needs to change to make regression
tracking successful in the long term. I'm very well aware of that,
nevertheless when I look back at last year I think some of my efforts on
regression tracking worked against my goal to establish regression
tracking properly within the Linux kernel development process.

That's why I'm not really happy with my performance last year. That does
not mean that I'm totally unhappy with it, as my work made a difference.
But in the end I might have set the wrong priorities sometimes. Most
importantly in these cases:

* I got into too many debates with developers when I thought a
particular regression was not handled appropriately. Sometimes I was
right, occasionally I was wrong (or even stupid, as I'm just human :-/ )
– and most of the time it was in the big gray area in between, where
your point of view and your understanding of how Linus wants regressions
to be handled decides which of the two it is.

* I should have intervened way earlier in public when volunteers tried
to help with regression tracking, but did so in ways that annoyed
developers (which was totally understandable).

* I should have spent more time improving regzbot. But I did not due to
lack of time and some tasks that are energy drainers. Some of them:

 - Skimming lists and bugzilla for regression reports to track takes a
whole lot of time.

 - I spend a lot of time following up on tracked regression reports,
because they from my understanding of what Linus wants were not handled
well.

 - I had to spend a lot of time following up on regression reports I or
somebody else added to the tracking, as developers often forget Link: or
Closes: tags pointing to the report.

* When I found time to work on regzbot I'm not sure if I worked on the
right features. That's because I spend most of that time on code to
support tracking regressions submitted on gitlab instances or github, as
without it regzbot is unable to track regressions reported for the DRM
and SOF subsystems or things ClangBuiltLinux finds. This work will also
improve the rough bugzilla support, which is crucial if bugzilla gets
used in the way Konstantin envisions it. These changes furthermore
renovate a few really ugly parts in the regzbot code (written in its
early days when I was getting into programming), which is wise to do
before implementing some other important features.

  All in all it was a lot of work, especially dealing with the APIs for
the three bug trackers. Maybe 90 percent of that work is done now; it's
committed, but not used in production, as it still needs a lot more
testing and finetuning.

There are a few other things I'm unhappy with, but those were the major
ones.

### Plans for 2024

In general: regzbot becomes the priority; I'll try to stay on top of
tracked regressions and look out for reports that need to be tracked,
but for some time will work less strictly to reduce the timeI  spend on
this.

These are the regzbot features I plan to work on:

* Finish the current work (gitlab/github support with related core
improvements; see above), which will take *at least* the rest of January
I fear.

* Afterwards focus for a while on making regzbot a more useful and
easier to use tool for kernel developers and subsystems maintainers.This
partly relies on some of the internal renovations already in the works
(see above) and will consist of many small changes in various areas.
Some of them:

 - Make it dead easy to add regressions to the tracking reported only
indirectly by way of a patch submission that fixes the problem.

 - Implement a dedicated "#regzbot forwarding" command, as people often
fail to use the current syntax correctly (they forget the caret in
"#regzbot ^introduced", put it in the wrong place, or do not reply to
what's considered the report).

- Related to the "do not reply to what's considered the report" in the
previous point: implement a command like "#regzbot adjustreport
https://example.com/foo" to adjust the location of the report.

 - Support bulk adding reports and updating the status of tracked
regressions out-of-thread. This will reduce the amount of mail
developers receive and make updating tracking bits easier for me as well.

 - Make it easier to handle duplicates.

 - Webpages and reports UI: create pages where subsystem maintainers can
see unresolved regression in their area.

* Ideally find a subsystem where the maintainers want to use regzbot and
work closely with me to make regzbot more useful for them.

* Allow tagging, for example to tag regressions reports coming from a
certain CI, so that the CI projects can rely on regzbot's magic to keep
an eye on regressions they reported.

* Handle fixes not yet mainlined better in the webui and the reports;
e.g. separate "Fix incoming" into something like "fix up for review",
"fix pending (this cycle)", "fix pending (next cycle)".

* There are a few other things planned for later, but I might work on
them earlier if it turns out they make subsystem maintainers happier:

  - Separate actionable vs non-actionable reports in the UI (actionable:
a sane report with a bisection result).

 - Mark some regressions as "priority".

 - Export data in a simple format to enable developers to allow
scripting things like "is anything in here known to cause a regression
not yet fixed".

 - Make regzbot send mails or add comments. But only when regzbot works
well; and ensure those mails won't bother people.

Regression tracking:

* Spend less time looking out for regression reports and following up
the regressions that regzbot tracks.

  To do so, I plan to focus on regressions introduced during the current
or the previous mainline release. I'll try to keep an eye on regressions
in mainline releases from the past 12 months as well as those in
stable/longterm trees, but will try to not spend too much time on that.
I'll ignore everything older and regressions not bisected, unless it's
one where I get "ohh, this is not good at all" vibes; in such cases I
likely will continue to help reporters improve their report, but in
other cases I won't do that anymore.

Side projects:

* Submit a text on bisecting a Linux kernel regression for inclusion
into the kernel's documentation. I started writing that text on
Christmas eve while having a slight headache; got into a flow afterwards
and finished the bulk of it early January. Just needs more polishing, so
it would be a shame to let it linger on my hard disk.

* Try to add some text to the kernel's documentation endorsed by Linus
and briefly describing how he wants regressions to be handled. Basically
a shorter version of the "Expectations and best practices for fixing
regressions" section already in
https://docs.kernel.org/process/handling-regressions.html. What I've
written there is based on actions and past e-mails from Linus combined
with putting things in context (in general and with stable in mind). But
people don't take it for full, as it was only ACKed by Greg, but not
from Linus – which leads to discussions that are annoying for everyone
involved (and created a lot of tension between developers and myself).

* Prepare discussions about handling and tracking regressions for both
the kernel summit and the maintainers summit this fall.

### Closing words

There are a ton of other things I could and maybe should write here,
that's why I suspect I've forgotten an important thing or two. If that
turns out to be true I might update this post within the first days of
its publication.

