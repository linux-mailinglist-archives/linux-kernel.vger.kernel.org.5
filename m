Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AB7C98EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJOMMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:12:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3FA9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:12:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qrzzF-0006hc-Fr; Sun, 15 Oct 2023 14:12:49 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-10-15]
Date:   Sun, 15 Oct 2023 12:12:48 +0000
Message-Id: <169737193299.624972.12831031401706621880@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697371972;24450f30;
X-HE-SMSGID: 1qrzzF-0006hc-Fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. My list of unresolved regressions introduced during this cycle
got a lot shorter, as quite a few fixes for tracked issues found their
way into mainline over the past few days.

But there is one regression where things looked stalled despite the
following fix existing for a while:

https://lore.kernel.org/netdev/20230927055246.121544-1-xuanzhuo@linux.alibaba.com/

That fix was posted two and a half weeks ago (one day after the
regression linked in the patch description was reported) and got one ACK
one week ago; but apart for that nothing has happened afaics. Not sure
what's up there.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 4 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.5.. aka v6.6-rc), culprit identified
======================================================


[ *NEW* ] Re:block: Fix regression in sed-opal for a saved key.
---------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com/
https://lore.kernel.org/lkml/53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com/

By Greg Joyce; 9 days ago; 3 activities, latest 1 days ago.
Introduced in 3bfeb6125664 (v6.6-rc1)

Fix incoming:
* block: Fix regression in sed-opal for a saved key.
  https://lore.kernel.org/lkml/2519b67c-58d3-4f87-9513-5321b1722b60@leemhuis.info/


Regression: devcoredump patch broke Realtek usb bluetooth adapter
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20231003182038.k57nirtt4sonvt7c@box.shutemov.name/
https://lore.kernel.org/lkml/20231003182038.k57nirtt4sonvt7c@box.shutemov.name/

By Kirill A. Shutemov; 11 days ago; 12 activities, latest 1 days ago.
Introduced in 044014ce85a1 (v6.6-rc1)

Fix incoming:
* Bluetooth: btrtl: Ignore error return for hci_devcd_register()
  https://lore.kernel.org/lkml/b96190f1-44f4-4562-9030-6916e97c8b82@leemhuis.info/


powerpc: new page table range API causes PowerMac G5 to fail booting
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230929132750.3cd98452@yea/
https://lore.kernel.org/linuxppc-dev/20230929132750.3cd98452@yea/

By Erhard Furtner; 16 days ago; 12 activities, latest 2 days ago.
Introduced in 9fee28baa601 (v6.6-rc1)

Recent activities from: Erhard Furtner (2), Michael Ellerman (2)

2 patch postings are associated with this regression, the latest is this:
* Re: [Bisected] PowerMac G5 fails booting kernel 6.6-rc3 (BUG: Unable to handle kernel data access at 0xfeffbb62ffec65fe)
  https://lore.kernel.org/linuxppc-dev/87mswwnec1.fsf@linux.ibm.com/
  9 days ago, by Aneesh Kumar K.V


virtio: network-related regression when using SWIOTLB in the guest
------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230926130451.axgodaa6tvwqs3ut@amd.com/
https://lore.kernel.org/lkml/20230926130451.axgodaa6tvwqs3ut@amd.com/

By Michael Roth; 18 days ago; 5 activities, latest 7 days ago.
Introduced in 295525e29a (v6.6-rc1)

Fix incoming:
* virtio_net: fix the missing of the dma cpu sync
  https://lore.kernel.org/lkml/a7a2bf25-cfc1-47a8-baf4-487a8574fb5a@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169678126224.160034.5275230285223450822@leemhuis.info

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
