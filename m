Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2147BCF3B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJHQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjJHQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:09:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D2BAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:09:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qpWLB-0002Ub-VJ; Sun, 08 Oct 2023 18:09:14 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-10-08]
Date:   Sun,  8 Oct 2023 16:09:13 +0000
Message-Id: <169678126224.160034.5275230285223450822@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696781355;81a10301;
X-HE-SMSGID: 1qpWLB-0002Ub-VJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. There is not much to report wrt to regressions introduced
during the current cycle: there are a few, put people are working on
fixing them.

Except maybe one; but I'll likely drop that from the list of tracked
issues anyway, unless you object:
https://lore.kernel.org/all/eab8e74b-61e0-4ef4-bfb3-751047d879bc@green-communications.fr/

As far as I understand things the cause is 3ec5ac12ac8a4e ("wifi: mt76:
mt7915: remove VHT160 capability on MT7915") [v6.6-rc1] which removed a
erroneously added feature flag (introduced in c2f73eacee3bf1 ("wifi:
mt76: mt7915: add back 160MHz channel width support for MT7915")
[v6.3-rc4]) which broke a user's hostap configuration. But I guess there
is nothing much we can do here, as the hardware doesn't support that
feature. See above link for details.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 10 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.5.. aka v6.6-rc), culprit identified
======================================================


virtio: network-related regression when using SWIOTLB in the guest
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230926130451.axgodaa6tvwqs3ut@amd.com/
https://lore.kernel.org/lkml/20230926130451.axgodaa6tvwqs3ut@amd.com/

By Michael Roth; 12 days ago; 5 activities, latest 0 days ago.
Introduced in 295525e29a (v6.6-rc1)

Fix incoming:
* virtio_net: fix the missing of the dma cpu sync
  https://lore.kernel.org/lkml/a7a2bf25-cfc1-47a8-baf4-487a8574fb5a@leemhuis.info/


[ *NEW* ] Regression: devcoredump patch broke Realtek usb bluetooth adapter
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20231003182038.k57nirtt4sonvt7c@box.shutemov.name/
https://lore.kernel.org/lkml/20231003182038.k57nirtt4sonvt7c@box.shutemov.name/

By Kirill A. Shutemov; 4 days ago; 11 activities, latest 1 days ago.
Introduced in 044014ce85a1 (v6.6-rc1)

Recent activities from: Max Chou (4), Kirill A. Shutemov (3), patchwork-
  bot+bluetooth@kernel.org (1), bluez.test.bot@gmail.com (1),
  max.chou@realtek.com (1), Bagas Sanjaya (1)

One patch associated with this regression:
* RE: Regression: devcoredump patch broke Realtek usb bluetooth adapter
  https://lore.kernel.org/lkml/7507ad6c8a964b179bf2b3318104a124@realtek.com/
  4 days ago, by Max Chou

Noteworthy links:
* [PATCH] Bluetooth: btrtl: Ignore error return for hci_devcd_register()
  https://lore.kernel.org/lkml/20231006024707.413349-1-max.chou@realtek.com/
  2 days ago, by max.chou@realtek.com; thread monitored.


powerpc: new page table range API causes PowerMac G5 to fail booting
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230929132750.3cd98452@yea/
https://lore.kernel.org/linuxppc-dev/20230929132750.3cd98452@yea/

By Erhard Furtner; 9 days ago; 8 activities, latest 2 days ago.
Introduced in 9fee28baa601 (v6.6-rc1)

Recent activities from: Erhard Furtner (2), Aneesh Kumar K.V (2), Bagas
  Sanjaya (2), Matthew Wilcox (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [Bisected] PowerMac G5 fails booting kernel 6.6-rc3 (BUG: Unable to handle kernel data access at 0xfeffbb62ffec65fe)
  https://lore.kernel.org/linuxppc-dev/87mswwnec1.fsf@linux.ibm.com/
  2 days ago, by Aneesh Kumar K.V


resume_console performance regression due to per-console suspended state
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/217955/
https://bugzilla.kernel.org/show_bug.cgi?id=217955
https://lore.kernel.org/lkml/99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com/

By Todd Brandt and Todd Brandt; 10 days ago; 21 activities, latest 2 days ago.
Introduced in 9e70a5e109a4 (v6.6-rc1)

Fix incoming:
* printk: flush consoles before checking progress
  https://lore.kernel.org/lkml/da91c950-51c0-4c71-855e-ae11898a97f5@gmail.com/


x86,static_call: crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZRhKq6e5nF/4ZIV1@fedora/
https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/

By Hyeonggon Yoo; 7 days ago; 11 activities, latest 2 days ago.
Introduced in aee9d30b9744 (v6.6-rc3)

Fix incoming:
* KEYS: trusted: Remove redundant static calls usage
  https://lore.kernel.org/lkml/019424f6-b39b-41d9-bb4a-40bfc8953d98@leemhuis.info/


Input: psmouse - Resume broken on T14s Gen1 (AMD) due to a new delay when deactivating for SMBus mode
-----------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
https://lore.kernel.org/lkml/ca0109fa-c64b-43c1-a651-75b294d750a1@leemhuis.info/
https://lore.kernel.org/lkml/0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info/

By Thorsten Leemhuis and Thorsten Leemhuis; 11 days ago; 9 activities, latest 3 days ago.
Introduced in 92e24e0e57f7 (v6.6-rc1)

Recent activities from: Jeffery Miller (3), Thorsten Leemhuis (2)

One patch associated with this regression:
* Re: [regression] Resume broken on T14s Gen1 (AMD) due to "Input: psmouse - add delay when deactivating for SMBus mode"
  https://lore.kernel.org/lkml/CAAzPG9MD%2BUQb_RdiMkPkpQGYe-arD1nMKWngMj4P5s3_zJvphQ@mail.gmail.com/
  5 days ago, by Jeffery Miller

Noteworthy links:
* [PATCH v2] Input: psmouse - fix fast_reconnect function for PS/2 mode
  https://lore.kernel.org/lkml/20231005002249.554877-1-jefferymiller@google.com/
  3 days ago, by Jeffery Miller; thread monitored.


[ *NEW* ] dqput() fix causes kvm-xfstests nojournal test time longer
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64/
https://lore.kernel.org/linux-ext4/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64/

By Eric Whitney; 4 days ago; 4 activities, latest 3 days ago.
Introduced in dabc8b207566 (v6.6-rc1)

Recent activities from: Eric Whitney (2), Jan Kara (1), Bagas
  Sanjaya (1)


wifi: mt76: mt7915: removal of VHT160 capability broke hostap
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/12289744.O9o76ZdvQC@natalenko.name/
https://lore.kernel.org/lkml/12289744.O9o76ZdvQC@natalenko.name/

By Oleksandr Natalenko; 17 days ago; 3 activities, latest 8 days ago.
Introduced in 3ec5ac12ac8a (v6.6-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169616777754.3766264.2663767892794249034@leemhuis.info

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
