Return-Path: <linux-kernel+bounces-10508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CA81D53B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D667C282EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B012E5B;
	Sat, 23 Dec 2023 17:20:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578D12E47;
	Sat, 23 Dec 2023 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rH5fM-0003kV-QA; Sat, 23 Dec 2023 18:20:00 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-12-23]
Date: Sat, 23 Dec 2023 17:20:00 +0000
Message-Id: <170335196500.1276302.7317913928045121362@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1703352005;0a1ca076;
X-HE-SMSGID: 1rH5fM-0003kV-QA

Hi Linus. Find below the list of regressions by bot currently tracks wrt
to 6.7. A few notes:

* The fix for the "iwlwifi: rfkill locking up kernel" regression (that
also affects 6.6.y and more than just a user or two) is available. I
might be mistaken, but to me it looks a lot like it was meant to be
mainlined this week, but the pull request from the wireless folks[2]
just fall through the tracks in the pre-festive-season stress.

[1] https://lore.kernel.org/all/20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid/
[2] https://lore.kernel.org/all/20231219223233.189152-3-johannes@sipsolutions.net/

* A fix for the regression from Thomas Weißschuh in below list is part
of today's char/misc pull request from Greg; and mingo's x86 pull
request contains three fixes for regressions that I kept an eye on
without regzbot.

* Two of the remaining tracked regressions are brand new and are worked
on. https://bugzilla.kernel.org/show_bug.cgi?id=218198 looks stalled due
to lack of action from the reporter.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.6.. aka v6.7-rc), culprit identified
======================================================


[ *NEW* ] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
----------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20231221231115.12402-1-dan@danm.net/
https://lore.kernel.org/lkml/20231221231115.12402-1-dan@danm.net/

By Dan Moulding; 1 days ago; 6 activities, latest 0 days ago.
Introduced in 629df6701c8a (v6.7-rc1)

Recent activities from: Dan Moulding (3), Alex Henrie (2), Bagas
  Sanjaya (1)

One patch associated with this regression:
* [PATCH net] net: ipv6/addrconf: clamp temporary address's preferred lifetime to public address's
  https://lore.kernel.org/lkml/20231222234237.44823-2-alexhenrie24@gmail.com/
  0 days ago, by Alex Henrie


[ *NEW* ] badblocks: nvdimm tests were failing after switch to impoved code
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/6585d5fda5183_9f731294b9@iweiny-mobl.notmuch/
https://lore.kernel.org/lkml/6585d5fda5183_9f731294b9@iweiny-mobl.notmuch/

By Ira Weiny; 0 days ago; 5 activities, latest 0 days ago.
Introduced in aa511ff8218b (v6.7-rc1)

Recent activities from: Ira Weiny (3), Coly Li (2)

One patch associated with this regression:
* Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved badblock handling
  https://lore.kernel.org/lkml/658628b098aeb_b31b42945b@iweiny-mobl.notmuch/
  0 days ago, by Ira Weiny


iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218206/
https://bugzilla.kernel.org/show_bug.cgi?id=218206
https://lore.kernel.org/lkml/5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com/

By Linus Lotz and Linus Lotz; 24 days ago; 19 activities, latest 0 days ago.
Introduced in 37fb29bd1f90 (v6.7-rc1)

Fix incoming:
* wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=400f6ebbc175286576c7f7fddf3c347d09d12310


Re: [PATCH v2 0/9] Support light color temperature and chromaticity
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/
https://lore.kernel.org/linux-input/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/

By Thomas Weißschuh; 16 days ago; 5 activities, latest 0 days ago.
Introduced in 5f05285df691 (v6.7-rc1)

Fix incoming:
* Revert "iio: hid-sensor-als: Add light color temperature support"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=d4005431673929a1259ad791db87408fcf85d2cc


system after successful resuming the CPU won't enter lower Package Sates below pc2
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218198/
https://bugzilla.kernel.org/show_bug.cgi?id=218198
https://lore.kernel.org/regressions/4cbd1ad9-d343-421a-b9de-30dc8e2d02c1@leemhuis.info/

By Dieter Mummenschanz and Dieter Mummenschanz; 25 days ago; 37 activities, latest 5 days ago.
Introduced in d035e4eb38b3 (v6.7-rc1)

Recent activities from: bugzilla-daemon@kernel.org (8), Dieter
  Mummenschanz (6), The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1), dlemoal (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170281908496.715347.5933124289020637019@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

