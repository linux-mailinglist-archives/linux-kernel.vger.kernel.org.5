Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596307686A2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjG3RUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3RUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:20:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CBE10C4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:20:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qQA5J-00029v-8i; Sun, 30 Jul 2023 19:20:01 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-07-30]
Date:   Sun, 30 Jul 2023 17:20:00 +0000
Message-Id: <169073747103.4140879.6035275932676410922@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690737603;c7b38a74;
X-HE-SMSGID: 1qQA5J-00029v-8i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report from by side: everything looks like
business as usual currently. 

One thing you might be interested in: seems the Ryzen keyboard problems
that a9c4a912b7d ("ACPI: resource: Remove "Zen" specific match and
quirks") [v6.5-rc1] was supposed to fix once and for all kinda came
back, as the new approach apparently still doesn't work on all machines:

https://lore.kernel.org/lkml/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/
https://bugzilla.kernel.org/show_bug.cgi?id=217726 (not confirmed yet)

Seems we yet again need quirks:
https://lore.kernel.org/all/79ee5522-3f3e-3480-dfb2-0c7640a97587@amd.com/

:-/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 10 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.4.. aka v6.5-rc), culprit identified
======================================================


PCI: acpiphp: Oops on first attempt to suspend, freeze on second
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/
https://lore.kernel.org/lkml/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/

By Woody Suwalski; 10 days ago; 23 activities, latest 0 days ago.
Introduced in 40613da52b13 (v6.5-rc1)

Fix incoming:
* Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=b607aa1edc9ca2ff16ae29c48e3e4090fae8aeab


[ *NEW* ] IRQ override revert breaks keyboard on Lenovo Yoga 7 14ARB7
---------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/
https://lore.kernel.org/lkml/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/

By August Wikerfors; 3 days ago; 7 activities, latest 1 days ago.
Introduced in a9c4a912b7dc (v6.5-rc1)

Fix incoming:
* ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
  https://lore.kernel.org/all/79ee5522-3f3e-3480-dfb2-0c7640a97587@amd.com/


drm: amdgpu: HW acceleration broke on ThinkPad E595
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/
https://lore.kernel.org/amd-gfx/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/

By Michel Dänzer; 13 days ago; 12 activities, latest 1 days ago.
Introduced in 84b4dd3f84d (v6.5-rc1)

Recent activities from: Michel Dänzer (4), Alex Deucher (2), Zhang,
  Jesse(Jie) (2)

2 patch postings are associated with this regression, the latest is this:
* RE: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support partition switch
  https://lore.kernel.org/amd-gfx/DM4PR12MB5152E173B970C3974F071E76E306A@DM4PR12MB5152.namprd12.prod.outlook.com/
  2 days ago, by Zhang, Jesse(Jie)


net: phylink: mv88e6060 dsa driver broken
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/
https://lore.kernel.org/netdev/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/

By Sergei Antonov; 26 days ago; 17 activities, latest 2 days ago.
Introduced in de5c9bf40c45 (v6.5-rc1)

Fix incoming:
* https://lore.kernel.org/netdev/3ef4662e-7888-9f41-32a3-d4cd07f1572c@leemhuis.info/


kernel pointer dereference regression due to extract_iter_to_sg()
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

By Ondrej Mosnáček; 17 days ago; 8 activities, latest 3 days ago.
Introduced in c1abe6f570af (v6.5-rc1)

Recent activities from: David Howells (3), Sven Schnelle (2), Linux
  regression tracking (Thorsten Leemhuis) (1)

One patch associated with this regression:
* [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
  https://lore.kernel.org/lkml/97730.1690408399@warthog.procyon.org.uk/
  3 days ago, by David Howells


drm/bridge: lt9611: Dragonboard 845c (SDM845) devboard broken when running AOSP
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/

By Amit Pundir; 25 days ago; 20 activities, latest 16 days ago; poked 4 days ago.
Introduced in 8ddce13ae69 (v6.5-rc1)


===================================================
current cycle (v6.4.. aka v6.5-rc), unknown culprit
===================================================


[ *NEW* ] ASUE140D:00 04F3:31B9 doesn't respond to input
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217726/
https://bugzilla.kernel.org/show_bug.cgi?id=217726
https://lore.kernel.org/lkml/bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com/

By Guilhem Lettron and Guilhem Lettron; 1 days ago; 2 activities, latest 0 days ago.
Introduced in v6.4..v6.5-rc1

Recent activities from: Bagas Sanjaya (1), Guilhem Lettron (1)


mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217675/
https://bugzilla.kernel.org/show_bug.cgi?id=217675
https://lore.kernel.org/lkml/51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com/

By rudi and rudi; 14 days ago; 9 activities, latest 3 days ago.
Introduced in v6.5-rc1..831fe284d827 (v6.5-rc1..v6.5-rc2)

Fix incoming:
* wifi: cfg80211: Fix return value in scan logic
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=fd7f08d92fcd7cc3eca0dd6c853f722a4c6176df


mm/vmalloc: NULL or otherwise bad pointer dereferences on ARM64
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/
https://lore.kernel.org/lkml/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/

By Mark Brown; 20 days ago; 10 activities, latest 10 days ago.
Introduced in v6.4..v6.5-rc1

One patch associated with this regression:
* Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
  https://lore.kernel.org/lkml/b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com/
  19 days ago, by Hugh Dickins


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169013434330.3594767.429224047854988999@leemhuis.info

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
