Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6B80BC4D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjLJRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjLJRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:02:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C2F4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:02:57 -0800 (PST)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1rCNCh-0007h2-0D; Sun, 10 Dec 2023 18:02:55 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-12-10]
Date:   Sun, 10 Dec 2023 17:02:54 +0000
Message-Id: <170222766284.86103.11020060769330721008@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702227777;3576d11e;
X-HE-SMSGID: 1rCNCh-0007h2-0D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Find below the list of regressions by bot currently tracks.
But first let let me mention a few things manually:

* Remember the "Blank screen on boot of Linux 6.5 and later on Lenovo
ThinkPad L570" regression?[1]. Shortly before releasing 6.6 you wrote
"But if this is not fixed by -rc1, we'll just revert it." [2]. I might
have missed something, but it afaics is still not fixed; there was an
attempt to fix this, but maintainers were not happy and then nothing
happened anymore -- at least unless I missed something [3].

[1] https://lore.kernel.org/dri-devel/7c50e051-eba2-09fc-da9f-023d592de457@ristioja.ee/
[2] https://lore.kernel.org/all/CAHk-=wiX0j=8DB0EbCheAAfcx2z99QUZMTeJUxSBGpb0J5pjVg@mail.gmail.com/
[3] https://lore.kernel.org/all/20231108024613.2898921-1-chenhuacai@loongson.cn/

* The Apparmor stuff from Stéphane I CCed you on a few days ago is in
below list of tracked 6.7 regressions; just mentioning this slightly
complicated regression (one we might have to live with due to the
security aspect, but that's your call, I didn't even look closer) in case the CC fall through the crack due to you traveling:
https://lore.kernel.org/regressions/CA%2Benf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/

* Most of the other 6.7 issues I track are being dealt with afaics,
except for one: it seems a amggpu change broke something for users that
haven't updated their firmware. A amd dev acked the problem mid Nov, but
since then it seems nothing has happened to address this; I'll prod the
devs again tomorrow:
https://lore.kernel.org/lkml/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E%2B8p-4QO6FOWa6zp22_A@mail.gmail.com/

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


[ *NEW* ] Re: [PATCH v2 0/9] Support light color temperature and chromaticity
-----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/
https://lore.kernel.org/linux-input/4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de/
https://bugzilla.kernel.org/show_bug.cgi?id!8223

By Thomas Weißschuh; 3 days ago; 2 activities, latest 0 days ago.
Introduced in 5f05285df691 (v6.7-rc1)

Recent activities from: Jonathan Cameron (1), Thomas Weißschuh (1)


[ *NEW* ] iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218206/
https://bugzilla.kernel.org/show_bug.cgi?id=218206
https://lore.kernel.org/lkml/5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com/

By Linus Lotz and Linus Lotz; 11 days ago; 13 activities, latest 2 days ago.
Introduced in 37fb29bd1f90 (v6.7-rc1)

Recent activities from: Mike Pagano (6), Johannes Berg (2), The Linux
  kernel's regression tracker (Thorsten Leemhuis) (2), Darrell Enns (1),
  Bagas Sanjaya (1), Linus Lotz (1)

One patch associated with this regression:
* bugzilla.kernel.org bug 218206: new comment(#11)
  https://bugzilla.kernel.org/show_bug.cgi?id=218206#c11
  3 days ago, by Johannes Berg


[ *NEW* ] system after successful resuming the CPU won't enter lower Package Sates below pc2
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218198/
https://bugzilla.kernel.org/show_bug.cgi?id=218198
https://lore.kernel.org/regressions/4cbd1ad9-d343-421a-b9de-30dc8e2d02c1@leemhuis.info/

By Dieter Mummenschanz and Dieter Mummenschanz; 12 days ago; 17 activities, latest 3 days ago.
Introduced in d035e4eb38b3 (v6.7-rc1)

Recent activities from: Dieter Mummenschanz (10), Phillip Susi (4),
  Niklas.Cassel (2), dlemoal (1)


[ *NEW* ] Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZXHHrCDKKQbGIxli@hovoldconsulting.com/
https://lore.kernel.org/lkml/ZXHHrCDKKQbGIxli@hovoldconsulting.com/

By Johan Hovold; 3 days ago; 1 activities, latest 3 days ago.
Introduced in 9f4f3dfad8cf (v6.7-rc1)

Fix incoming:
* https://lore.kernel.org/lkml/daa0c12e-49be-4047-933f-26823117b3db@leemhuis.info/


[ *NEW* ] apparmor: move_mount mediation breaks mount tool in containers
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CA+enf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/
https://lore.kernel.org/regressions/CA%2Benf=u0UmgjKrd98EYkxFu7FYV8dR1SBYJn_1b0Naq=3twbbQ@mail.gmail.com/

By Stéphane Graber; 6 days ago; 14 activities, latest 3 days ago.
Introduced in 157a3537d6bc (v6.7-rc1)

Recent activities from: John Johansen (6), Stéphane Graber (3),
  Christian Brauner (2), Linux regression tracking (Thorsten
  Leemhuis) (2), Sasha Levin (1)

One patch associated with this regression:
* Re: Apparmor move_mount mediation breaks mount tool in containers
  https://lore.kernel.org/regressions/3d17c8c3-6558-4847-b123-4dbe1a1b0763@canonical.com/
  4 days ago, by John Johansen


drm/amd/display: horizontal flashing bar with a picture of the desktop background on white screen after login
-------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E%2B8p-4QO6FOWa6zp22_A@mail.gmail.com/

By Mikhail Gavrilov; 26 days ago; 9 activities, latest 12 days ago; poked 5 days ago.
Introduced in ed6e2782e974 (v6.7-rc1)

Recent activities from: Alex Deucher (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170041205809.2648289.15922511203232588109@leemhuis.info

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
