Return-Path: <linux-kernel+bounces-70441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F698597C5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13E21C20A53
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F16D1C6;
	Sun, 18 Feb 2024 16:23:47 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAC290F;
	Sun, 18 Feb 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708273426; cv=none; b=c54odezsbE7qzIEF9flf2GoifCbXdi54K4p5czqn0yq3ExMaFthjroR7uvw8gZkGaPO7b676QMpGhXk5spZgAvAqb8jkjksJyGAEL27OX8RUH6UrS7fr5X032d6n4iZ3OAIXeczG0BCYFjeB3ZisE/3hdXOl82x0CFlo5UxpBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708273426; c=relaxed/simple;
	bh=/sSFkLOO86XrSdI5vVzZm2lNzngGV+Xm6AlJYHLgqog=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rOJbMh8RwySQfn7Q136jaEmg5m5q4YwpNFN8BcXWnElueMSS0IJUr8mzNVSBeXgoeio9y1Yruvf+EdKMdkKHBZ3HzQNTjAXgRxZkI1CaNBR5E1EIYPXdDo54/VaqeO4WykE2kgIM6yFyu82B/NVfoSzwQPAiGKdLlSHOPvIvJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rbjx7-0006W2-Vf; Sun, 18 Feb 2024 17:23:42 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-02-18]
Date: Sun, 18 Feb 2024 16:23:41 +0000
Message-Id: <170827338885.977320.16936376590840962619@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708273424;515acaf0;
X-HE-SMSGID: 1rbjx7-0006W2-Vf

Hi Linus, from the regressions point of view it's business as usual and
nothing to worry about afaics.

There is a small fix for a fs/9p regression is sitting in a vfs.netfs
branch for 18 days now; I had expected that it would finally make it to
you this week, but that did not happen; will poke Al and Christian tomorrow:
https://lore.kernel.org/v9fs/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=ca9ca1a5d5a980550db1001ea825f9fdfa550b83

There is also one regression from this cycle that looks somewhat
stalled, but Hans promised to look into it soon:
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.7.. aka v6.8-rc), culprit identified
======================================================


[ *NEW* ] sc7180-trogdor-lazor image corruption regression for USB-C DP Alt Mode ([PATCH 0/2] Add param for the highest bank bit)
---------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/
https://lore.kernel.org/regressions/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/

By Leonard Lausen; 0 days ago; 4 activities, latest 0 days ago.
Introduced in 8814455a0e54 (v6.8-rc1)

Recent activities from: Dmitry Baryshkov (2), Leonard Lausen (2)

One patch associated with this regression:
* Re: [REGRESSION] sc7180-trogdor-lazor image corruption regression for USB-C DP Alt Mode ([PATCH 0/2] Add param for the highest bank bit)
  https://lore.kernel.org/regressions/cf95947d-8bec-4f95-9e08-2d942723cafc@linaro.org/
  0 days ago, by Dmitry Baryshkov


[ *NEW* ] platform/x86/amd/pmf: system freezes after resuming from suspend
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ed2226ff-257b-4cfd-afd6-bf3be9785474@localhost/
https://lore.kernel.org/stable/ed2226ff-257b-4cfd-afd6-bf3be9785474@localhost/

By Trolli Schmittlauch; 2 days ago; 13 activities, latest 0 days ago.
Introduced in 7c45534afa44 (v6.8-rc1)

Recent activities from: Trolli Schmittlauch (6), Mario Limonciello (4),
  Hans de Goede (2), Thorsten Leemhuis (1)

Noteworthy links:
* [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
  https://lore.kernel.org/lkml/20240217005216.113408-1-mario.limonciello@amd.com/
  1 days ago, by Mario Limonciello; thread monitored.


usb: typec: boot issues on rk3399-roc-pc due to revert
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/
https://lore.kernel.org/lkml/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/

By Mark Brown; 9 days ago; 7 activities, latest 1 days ago.
Introduced in b717dfbf73e8 (v6.8-rc3)

Fix incoming:
* usb: typec: tpcm: Fix issues with power being removed during reset
  https://lore.kernel.org/lkml/8e7f9d37-ab18-419f-9641-287412a5cb4a@leemhuis.info/


[ *NEW* ] drm/msm: DisplayPort regressions in 6.8-rc1
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/

By Johan Hovold; 5 days ago; 7 activities, latest 1 days ago.
Introduced in 2bcca96abfbf (v6.8-rc1)

Recent activities from: Johan Hovold (5), Linux regression tracking
  (Thorsten Leemhuis) (1), Abhinav Kumar (1)


[ *NEW* ] sched/cpufreq: reduced maximum CPU frequency is ignored.
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/002f01da5ba0$49cbf810$dd63e830$@telus.net/
https://lore.kernel.org/lkml/002f01da5ba0%2449cbf810%24dd63e830%24@telus.net/

By Doug Smythies; 8 days ago; 10 activities, latest 2 days ago.
Introduced in 9c0b4bb7f630 (v6.8-rc1)

Recent activities from: Vincent Guittot (4), Doug Smythies (3)

One patch associated with this regression:
* RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
  https://lore.kernel.org/lkml/003001da6061%24bbad1e30%2433075a90%24@telus.net/
  2 days ago, by Doug Smythies


[ *NEW* ] MXSFB error: -ENODEV: Cannot connect bridge
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/lkml/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/regressions/20240214110822.GA81133@francesco-nb/

By Hiago De Franco and Francesco Dolcini; 10 days ago; 5 activities, latest 2 days ago.
Introduced in edbbae7fba49 (v6.8-rc1)

Recent activities from: Francesco Dolcini (3), Roland Hieber (1)

One patch associated with this regression:
* Re: MXSFB error: -ENODEV: Cannot connect bridge
  https://lore.kernel.org/lkml/20240214105223.GA78582@francesco-nb/
  4 days ago, by Francesco Dolcini

Noteworthy links:
* [PATCH v1] ARM: dts: imx7: remove DSI port endpoints
  https://lore.kernel.org/lkml/20240216104255.21052-1-francesco@dolcini.it/
  2 days ago, by Francesco Dolcini; thread monitored.


Regression by b17ef04bf3a4 ("drm/amd/display: Pass pwrseq inst for backlight and ABM")
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZbUB0YWxEET3Y0xA@eldamar.lan/
https://lore.kernel.org/lkml/ZbUB0YWxEET3Y0xA@eldamar.lan/

By Salvatore Bonaccorso; 22 days ago; 5 activities, latest 3 days ago.
Introduced in b17ef04bf3a4 (v6.8-rc1)

Fix incoming:
* drm/amd/display: Only allow dig mapping to pwrseq in new asic
  https://lore.kernel.org/lkml/e65c6dc4-9b43-4c97-bb4c-d9c14655835d@leemhuis.info/


`lis3lv02d_i2c_suspend()` causes `unbalanced disables for regulator-dummy` and `Failed to disable Vdd_IO: -EIO`
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/

By Paul Menzel; 16 days ago; 4 activities, latest 4 days ago.
Introduced in 2f189493ae32 (v6.8-rc1)

Recent activities from: Hans de Goede (1), Linux regression tracking
  (Thorsten Leemhuis) (1)


fs/9p: "netfs: Zero-sized write" failures during ldconfig test
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
https://lore.kernel.org/v9fs/ZbQUU6QKmIftKsmo@FV7GG9FTHL/

By Eric Van Hensbergen; 22 days ago; 7 activities, latest 17 days ago.
Introduced in 153a9961b551 (v6.8-rc1)

Fix incoming:
* netfs: Fix missing zero-length check in unbuffered write
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=ca9ca1a5d5a980550db1001ea825f9fdfa550b83


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170764569476.480163.4912590939283332268@leemhuis.info

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

