Return-Path: <linux-kernel+bounces-41839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD683F86A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2681C22539
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B02C850;
	Sun, 28 Jan 2024 17:03:20 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A928E03;
	Sun, 28 Jan 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461399; cv=none; b=hNQ8pB0mZHSbJS5V1xsdsIpqasF8047ylrmSEYvkY12sW4CtirTpdGHT7rStqrkDlybn0qkHhsvNdNzfRhxIyy0/L0G6p/LUpP4YDY05gC3ulCdftzxzWesG2u1MVoRpVyU3n+MIjXhN8yIp8cenpsrKBPD/H+uxKFwZhzOvKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461399; c=relaxed/simple;
	bh=hoGLeTx931dYTROijJ6Yud2063fpjpNZ3M75yTo2dgo=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bowDaySr6p/228Wsi9FXSA7sANm7d7fS5+s0uFlgra6gJXVZ4xTOgZmgixetDaAS7QM/2nOSEA2BgeT/vqGVfnbbnSePSuH6ax/qIajywSjnM2rHX4JXYz8UBYKYAytYDoIa6Y5ugH73pCsKl9wG+qnDm4fCbDXRbrFGZXfuQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rU8Ys-0002QN-UN; Sun, 28 Jan 2024 18:03:15 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-01-28]
Date: Sun, 28 Jan 2024 17:03:13 +0000
Message-Id: <170646134151.3426506.9467210052600500703@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706461397;4dfb79b2;
X-HE-SMSGID: 1rU8Ys-0002QN-UN

Hi Linus. Nothing much to report from my side. Here are a few things I
nevertheless want to point out wrt. to regression from this or the
previous cycle:

* As already mentioned last week: quite a few people reported problems
that among others "break 32bit processes on x86_64 (at least). In
particular, 32bit kernel or firefox builds in our build system" (quote
from Jiri). The mm fix for that is in -next since Tuesday (currently as
0d0498b139768f ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")), but sadly
not yet on the way to you (at least afaics):
https://lore.kernel.org/all/20240126075612.87780C433F1@smtp.kernel.org/

 For details and problems reports see:

  https://lore.kernel.org/linux-mm/d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org/
  https://lore.kernel.org/linux-mm/CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com/
  https://lore.kernel.org/all/1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com/
  https://lore.kernel.org/all/a914c7f2-cf9f-44a8-99d4-c25a66d39f1c@arm.com/


* There have been multiple reports that the keyboard on the popular
Dell XPS 13 9350 / 9360 / 9370 models on 6.7 has stopped working after
suspend/resume -- and the culprit that causes it recently sadly was
backported to a few stable/longterm series. Hans posted a fix on Friday
and asked sending them your way "ASAP", but that afaics has not happened
yet (no wonder given the timing):

  https://lore.kernel.org/all/20240126160724.13278-1-hdegoede@redhat.com/


* Speaking of popular Linus laptops, in case anyone cares: GPIO is
broken on the Thinkpad T14s Gen1 AMD, a fix for it was posted on
Tuesday, sadly was not yet picked up afaics:

  https://lore.kernel.org/lkml/20240123180818.3994-1-mario.limonciello@amd.com/


* Ohh, and the Apple M1 is plagued by boot failures, a fix for it is in
next as b40fed13870045 ("nvmem: include bit index in cell sysfs file
name") and also found here:

  https://lore.kernel.org/all/20240122153442.7250-1-arnd@kernel.org/


Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 6 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.7.. aka v6.8-rc), culprit identified
======================================================


[ *NEW* ] Regression by b17ef04bf3a4 ("drm/amd/display: Pass pwrseq inst for backlight and ABM")
------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZbUB0YWxEET3Y0xA@eldamar.lan/
https://lore.kernel.org/lkml/ZbUB0YWxEET3Y0xA@eldamar.lan/

By Salvatore Bonaccorso; 1 days ago; 3 activities, latest 0 days ago.
Introduced in b17ef04bf3a4 (v6.8-rc1)

Recent activities from: Debian Bug Tracking System (1), Linux regression
  tracking (Thorsten Leemhuis) (1), Salvatore Bonaccorso (1)

Noteworthy links:
* https://bugs.debian.org/1061449


[ *NEW* ] nvmem: boot failure for linux-6.8-rc1 on Apple M1
-----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240122153442.7250-1-arnd@kernel.org/
https://lore.kernel.org/lkml/20240122153442.7250-1-arnd@kernel.org/

By Arnd Bergmann; 6 days ago; 8 activities, latest 1 days ago.
Introduced in 0331c611949f (v6.8-rc1)

Fix incoming:
* nvmem: include bit index in cell sysfs file name
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=b40fed13870045731e374e6bb48800cde0feb4e2


[ *NEW* ] md/raid5: issue with raid5 with journal device
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240123005700.9302-1-dan@danm.net/
https://lore.kernel.org/lkml/20240123005700.9302-1-dan@danm.net/

By Dan Moulding; 5 days ago; 24 activities, latest 2 days ago.
Introduced in bed9e27baf52 (v6.8-rc1)

Fix incoming:
* Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""
  https://lore.kernel.org/regressions/a68c06ec-b303-4caf-ac39-882a1acb75b1@leemhuis.info/


[ *NEW* ] mm: multiple 30-38% regressions in vm-scalability, will-it-scale-tlb_flush2, and will-it-scale-fallocate1
-------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/202401221624.cb53a8ca-oliver.sang@intel.com/
https://lore.kernel.org/lkml/202401221624.cb53a8ca-oliver.sang@intel.com/

By kernel test robot; 6 days ago; 10 activities, latest 2 days ago.
Introduced in 8d59d2214c23 (v6.8-rc1)

Fix incoming:
* mm: memcg: optimize parent iteration in memcg_rstat_updated()
  https://lore.kernel.org/regressions/ddf5f638-1854-47e0-9527-2549034005dd@leemhuis.info/


[ *NEW* ] ACPI: OSL:/pinctrl: GPIO controller failing to work
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240123180818.3994-1-mario.limonciello@amd.com/
https://lore.kernel.org/lkml/20240123180818.3994-1-mario.limonciello@amd.com/
https://bugzilla.kernel.org/show_bug.cgi?id=218407

By Mario Limonciello and Christian Heusel; 4 days ago; 3 activities, latest 4 days ago.
Introduced in 7a36b901a6eb (v6.8-rc1)

Fix incoming:
* pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
  https://lore.kernel.org/lkml/0fd03c79-5e86-4cf8-99ae-944d73d5515a@leemhuis.info/


[ *NEW* ] sched: DT kselftests on meson-gxl-s905x-libretech-cc fail
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Za8cjQXptttuyb6c@finisterre.sirena.org.uk/
https://lore.kernel.org/lkml/Za8cjQXptttuyb6c@finisterre.sirena.org.uk/

By Mark Brown; 5 days ago; 9 activities, latest 5 days ago.
Introduced in b3edde44e5d4 (v6.8-rc1)

Fix incoming:
* topology: Set capacity_freq_ref in all cases
  https://lore.kernel.org/regressions/753e71de-9e0b-4335-baba-dfe8e2ce7f6d@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170585059505.2778011.9564698506290962184@leemhuis.info

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

