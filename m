Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486BC771646
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHFRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:15:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25223C2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:15:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qShLF-0004VZ-SQ; Sun, 06 Aug 2023 19:14:57 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-08-06]
Date:   Sun,  6 Aug 2023 17:14:57 +0000
Message-Id: <169134199152.488860.7520017509596978680@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691342111;4f409422;
X-HE-SMSGID: 1qShLF-0004VZ-SQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Not much to report from by side: nearly everything currently
looks like business as usual.

Hans ~two hours ago submitted a revert for a9c4a912b7d to address the
second manifestation of the Ryzen keyboard problems I brought to your
attention last week (which was backported to 6.4.7 and thus meanwhile
reached some mainstream distros). Thing is: for some users a9c4a912b7d
was a fix to avoid the first manifestation of the regression (caused by
9946e39fe8d0). Hence if we apply this we afaics need to extend the quirk
list for the first manifestation of the problem. This thread has the
details:
https://lore.kernel.org/all/20230806151453.10690-1-hdegoede@redhat.com/

FWIW, a zram regression from the 6.4 cycle that let to XFS metadata
corruption on ppc64le turned up (I CCed you on Friday); a fix for
that became ready over the weekend (thanks Christoph!) and Jens
already picked it up:
https://lore.kernel.org/lkml/b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com/
https://lore.kernel.org/lkml/20230805055537.147835-1-hch@lst.de/

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


ASUE140D:00 04F3:31B9 doesn't respond to input
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217726/
https://bugzilla.kernel.org/show_bug.cgi?id=217726
https://lore.kernel.org/lkml/bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com/

By Guilhem Lettron and Guilhem Lettron; 8 days ago; 14 activities, latest 0 days ago.
Introduced in a9c4a912b7dc (v6.5-rc1)

Recent activities from: Guilhem Lettron (3), Hans de Goede (2), Mario
  Limonciello (AMD) (2), henil (2), Linux regression tracking (Thorsten
  Leemhuis) (1), August Wikerfors (1), Marcin Bachry (1)

Noteworthy links:
* [PATCH] ACPI: resource: revert "Remove "Zen" specific match and quirks"
  https://lore.kernel.org/stable/20230806151453.10690-1-hdegoede@redhat.com/
  0 days ago, by Hans de Goede; thread monitored.


PCI: acpiphp: Oops on first attempt to suspend, freeze on second
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/
https://lore.kernel.org/lkml/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com/

By Woody Suwalski; 17 days ago; 31 activities, latest 1 days ago.
Introduced in 40613da52b13 (v6.5-rc1)

Fix incoming:
* Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=b607aa1edc9ca2ff16ae29c48e3e4090fae8aeab


[ *NEW* ] pm: boot problems when hibernate is configured and kernel locked down
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz/
https://lore.kernel.org/lkml/2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz/

By Vlastimil Babka; 3 days ago; 3 activities, latest 2 days ago.
Introduced in cc89c63e2fe3 (v6.5-rc1)

Fix incoming:
* PM: hibernate: fix resume_store() return value when hibernation not available
  https://lore.kernel.org/lkml/84f6ea98-0d72-e17a-4b7c-d025f2d34e95@leemhuis.info/


[ *NEW* ] crypto: broke CAAM RNG instantiation on an i.MX8MM
------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de/
https://lore.kernel.org/lkml/e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de/

By Bastian Krause; 20 days ago; 7 activities, latest 2 days ago.
Introduced in ef492d08030 (v6.5-rc1)

Recent activities from: Gaurav Jain (1), Herbert Xu (1)

One patch associated with this regression:
* Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
  https://lore.kernel.org/lkml/f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de/
  19 days ago, by Bastian Krause


kernel pointer dereference regression due to extract_iter_to_sg()
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

By Ondrej Mosnáček; 24 days ago; 11 activities, latest 2 days ago.
Introduced in c1abe6f570af (v6.5-rc1)

Recent activities from: Herbert Xu (1), Ard Biesheuvel (1), Ondrej
  Mosnáček (1)

One patch associated with this regression:
* [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
  https://lore.kernel.org/lkml/97730.1690408399@warthog.procyon.org.uk/
  10 days ago, by David Howells


drm/bridge: lt9611: Dragonboard 845c (SDM845) devboard broken when running AOSP
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/

By Amit Pundir; 32 days ago; 49 activities, latest 2 days ago.
Introduced in 8ddce13ae69 (v6.5-rc1)

Recent activities from: Marek Vasut (11), Dmitry Baryshkov (7), Neil
  Armstrong (5), neil.armstrong@linaro.org (2), Laurent Pinchart (1),
  Rob Clark (1), Abhinav Kumar (1), Amit Pundir (1)

Noteworthy links:
* [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet"
  https://lore.kernel.org/lkml/20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org/
  4 days ago, by Neil Armstrong; thread monitored.


[ *NEW* ] btrfs: write-bandwidth performance regression with NVMe raid0
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230731152223.4EFB.409509F4@e16-tech.com/
https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/

By Wang Yugui; 6 days ago; 14 activities, latest 4 days ago.
Introduced in da023618076 (v6.5-rc1)

Recent activities from: Christoph Hellwig (7), Wang Yugui (7)

2 patch postings are associated with this regression, the latest is this:
* Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
  https://lore.kernel.org/linux-btrfs/20230801235123.B665.409509F4@e16-tech.com/
  5 days ago, by Wang Yugui


[ *NEW* ] ALSA: hda/realtek: Audible "pop" sound whenever audio card goes in or out of sleep
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217732/
https://bugzilla.kernel.org/show_bug.cgi?id=217732
https://lore.kernel.org/regressions/bc22f6c4-a147-3032-49ef-0784d0171d9a@leemhuis.info/

By serfreeman1337 and serfreeman1337; 7 days ago; 3 activities, latest 7 days ago.
Introduced in 69ea4c9d02b7 (v6.5-rc3)


drm: amdgpu: HW acceleration broke on ThinkPad E595
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/
https://lore.kernel.org/amd-gfx/647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net/

By Michel Dänzer; 20 days ago; 12 activities, latest 8 days ago.
Introduced in 84b4dd3f84d (v6.5-rc1)

2 patch postings are associated with this regression, the latest is this:
* RE: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support partition switch
  https://lore.kernel.org/amd-gfx/DM4PR12MB5152E173B970C3974F071E76E306A@DM4PR12MB5152.namprd12.prod.outlook.com/
  9 days ago, by Zhang, Jesse(Jie)


===================================================
current cycle (v6.4.. aka v6.5-rc), unknown culprit
===================================================


mm/vmalloc: NULL or otherwise bad pointer dereferences on ARM64
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/
https://lore.kernel.org/lkml/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/

By Mark Brown; 27 days ago; 10 activities, latest 17 days ago.
Introduced in v6.4..v6.5-rc1

One patch associated with this regression:
* Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
  https://lore.kernel.org/lkml/b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com/
  26 days ago, by Hugh Dickins


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169073747103.4140879.6035275932676410922@leemhuis.info

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
