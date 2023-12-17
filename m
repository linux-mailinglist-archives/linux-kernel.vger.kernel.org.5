Return-Path: <linux-kernel+bounces-2600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAE815F43
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876871C20A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533C44386;
	Sun, 17 Dec 2023 13:19:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C84437F;
	Sun, 17 Dec 2023 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rEr2n-0003sq-HM; Sun, 17 Dec 2023 14:18:57 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-12-17]
Date: Sun, 17 Dec 2023 13:18:56 +0000
Message-Id: <170281908496.715347.5933124289020637019@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702819144;743fbb25;
X-HE-SMSGID: 1rEr2n-0003sq-HM

Hi Linus. Find below the list of regressions by bot currently tracks wrt
to 6.7. There is nothing to worry about afaics: I guess fixes for most
of the tracked issues will be heading your way in the next few days.
https://bugzilla.kernel.org/show_bug.cgi?id=218198 might be the exception.

But let me follow up on two things from last week:

> * The Apparmor stuff from Stéphane I CCed you on a few days ago is in
> below list of tracked 6.7 regressions; just mentioning this slightly
> complicated regression (one we might have to live with due to the
> security aspect, but that's your call, I didn't even look closer> in case the CC fall through the crack due to you traveling: 
> https://lore.kernel.org/regressions/CA%2Benf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
Nothing happened there, so I assume you consider the state of things to
be okay and will remove this from my tracking soon.

> * Remember the "Blank screen on boot of Linux 6.5 and later on Lenovo
> ThinkPad L570" regression?[1]. Shortly before releasing 6.6 you wrote
> "But if this is not fixed by -rc1, we'll just revert it." [2]. I might
> have missed something, but it afaics is still not fixed; there was an
> attempt to fix this, but maintainers were not happy and then nothing
> happened anymore -- at least unless I missed something [3].
> 
> [1] https://lore.kernel.org/dri-devel/7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee/
> [2] https://lore.kernel.org/all/CAHk-=wiX0j=8DB0EbCheAAfcx2z99QUZMTeJUxSBGpb0J5pjVg@mail.gmail.com/
> [3] https://lore.kernel.org/all/20231108024613.2898921-1-chenhuacai@loongson.cn/
FWIW, that lead to some activity on Monday, but since then nothing
happened afaics -- which might be mainly due to silence from the
reporter which was asked to test something:
https://lore.kernel.org/all/CAAhV-H52y902nP6nPeghLqs+K8gNzCc3DHTU1C0AQcD0TXHMAQ@mail.gmail.com/
https://lore.kernel.org/all/CAAhV-H5eXM7FNzuRCMthAziG_jg75XwQV3grpw=sdyJ-9GXgvA@mail.gmail.com/

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 5 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.6.. aka v6.7-rc), culprit identified
======================================================


drm/amd/display: horizontal flashing bar with a picture of the desktop background on white screen after login
-------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E%2B8p-4QO6FOWa6zp22_A@mail.gmail.com/

By Mikhail Gavrilov; 33 days ago; 13 activities, latest 1 days ago.
Introduced in ed6e2782e974 (v6.7-rc1)

Recent activities from: Hamza Mahfooz (2), Mario Limonciello (1), Harry
  Wentland (1)

Noteworthy links:
* [PATCH] drm/amd/display: disable FPO and SubVP for older DMUB versions on DCN32x
  https://lore.kernel.org/stable/20231215160116.17012-1-hamza.mahfooz@amd.com/
  1 days ago, by Hamza Mahfooz; thread monitored.


Re: [PATCH v2 0/9] Support light color temperature and chromaticity
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/
https://lore.kernel.org/linux-input/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/

By Thomas Weißschuh; 10 days ago; 4 activities, latest 1 days ago.
Introduced in 5f05285df691 (v6.7-rc1)

Recent activities from: srinivas pandruvada (1), Linux regression
  tracking (Thorsten Leemhuis) (1)


system after successful resuming the CPU won't enter lower Package Sates below pc2
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218198/
https://bugzilla.kernel.org/show_bug.cgi?id=218198
https://lore.kernel.org/regressions/4cbd1ad9-d343-421a-b9de-30dc8e2d02c1@leemhuis.info/

By Dieter Mummenschanz and Dieter Mummenschanz; 19 days ago; 21 activities, latest 1 days ago.
Introduced in d035e4eb38b3 (v6.7-rc1)

Recent activities from: bugzilla-daemon@kernel.org (2),
  Niklas.Cassel (1), The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1)


iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218206/
https://bugzilla.kernel.org/show_bug.cgi?id=218206
https://lore.kernel.org/lkml/5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com/

By Linus Lotz and Linus Lotz; 18 days ago; 14 activities, latest 2 days ago.
Introduced in 37fb29bd1f90 (v6.7-rc1)

Recent activities from: The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1)

One patch associated with this regression:
* bugzilla.kernel.org bug 218206: new comment(#11)
  https://bugzilla.kernel.org/show_bug.cgi?id=218206#c11
  10 days ago, by Johannes Berg


apparmor: move_mount mediation breaks mount tool in containers
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
https://lore.kernel.org/regressions/CA%2Benf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/

By Stéphane Graber; 13 days ago; 14 activities, latest 10 days ago.
Introduced in 157a3537d6bc (v6.7-rc1)

One patch associated with this regression:
* Re: Apparmor move_mount mediation breaks mount tool in containers
  https://lore.kernel.org/regressions/3d17c8c3-6558-4847-b123-4dbe1a1b0763@canonical.com/
  11 days ago, by John Johansen


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170222766284.86103.11020060769330721008@leemhuis.info

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

