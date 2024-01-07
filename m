Return-Path: <linux-kernel+bounces-18861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E8826419
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B6E1C20FD4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E039134AE;
	Sun,  7 Jan 2024 12:52:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8B134A4;
	Sun,  7 Jan 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rMSdy-0003t6-9M; Sun, 07 Jan 2024 13:52:46 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-01-07]
Date: Sun,  7 Jan 2024 12:52:45 +0000
Message-Id: <170463193667.1966610.7165124970993807605@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704631973;193a4d4b;
X-HE-SMSGID: 1rMSdy-0003t6-9M

Hi Linus. I noticed a handful of regression reports coming in over the
festive days, but fixes for most of those found their way into mainline
in the past few days. So from here it looks like the -rc8 was definitely
a wise move.

In the end I'm down to three regressions now (as usual: there are likely
more, but I can't have my eyes everywhere).

One regression[1] seems to have stalled due to lack of activity from the
reporter. It's similar with another that came in ~10 days ago[2]. The
third[3] came in before Christmas with a simple patch to fix it, but
sadly that afaics was not reviewed.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218198
[2] https://lore.kernel.org/lkml/ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com/
[3] https://lore.kernel.org/lkml/20231218164532.411125-2-mailingradian@gmail.com/

Ciao, Thorsten
---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 3 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.6.. aka v6.7-rc), culprit identified
======================================================


[ *NEW* ] memblock: platforms supporting SGX fail to kexec
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com/
https://lore.kernel.org/lkml/ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com/

By Ashok Raj; 9 days ago; 3 activities, latest 7 days ago.
Introduced in e96c6b8f212a (v6.7-rc1)

Recent activities from: Mike Rapoport (1), Borislav Petkov (1), Ashok
  Raj (1)


[ *NEW* ] usb: gadget: u_ether: network gadgets don't work
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20231218164532.411125-2-mailingradian@gmail.com/
https://lore.kernel.org/lkml/20231218164532.411125-2-mailingradian@gmail.com/

By Richard Acayan; 19 days ago; 4 activities, latest 9 days ago.
Introduced in f49449fbc21e (v6.7-rc1)

Fix incoming:
* usb: gadget: u_ether: Re-attach netif device to mirror detachment
  https://lore.kernel.org/lkml/9e7cb70d-1eff-4240-841f-e08a91ca995c@leemhuis.info/


system after successful resuming the CPU won't enter lower Package Sates below pc2
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218198/
https://bugzilla.kernel.org/show_bug.cgi?id=218198
https://lore.kernel.org/regressions/4cbd1ad9-d343-421a-b9de-30dc8e2d02c1@leemhuis.info/

By Dieter Mummenschanz and Dieter Mummenschanz; 40 days ago; 37 activities, latest 20 days ago.
Introduced in d035e4eb38b3 (v6.7-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170335196500.1276302.7317913928045121362@leemhuis.info

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

