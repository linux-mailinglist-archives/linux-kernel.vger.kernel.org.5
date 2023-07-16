Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B811754F07
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGPOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:32:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C254BBA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 07:32:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qL2nT-0004yV-Tq; Sun, 16 Jul 2023 16:32:28 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-07-16]
Date:   Sun, 16 Jul 2023 14:32:27 +0000
Message-Id: <168951788956.3088691.6549033530966986041@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689517950;317b20c8;
X-HE-SMSGID: 1qL2nT-0004yV-Tq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report from by side; there are a few
regressions I'm aware off, but everything currently is business as usual.

The iwlwifi issue I mentioned last week was fixed (thx again Johannes).
Kees picked up and sent you one compile fix in todays pull. Maybe you
also might still get this one for build failure from the tip folks:
https://lore.kernel.org/all/20230629102051.42E8360467@lion.mk-sys.cz/

Problem was reported here:
https://lore.kernel.org/lkml/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/

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


[ *NEW* ] CONFIG_EFI_PGT_DUMP regression due to allowing failing pte_offset_map[_lock]()
----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/

By Mikhail Gavrilov; 1 days ago; 5 activities, latest 0 days ago.
Introduced in 0d940a9b270b (v6.5-rc1)

Recent activities from: Bagas Sanjaya (2), Mikhail Gavrilov (2), Hugh
  Dickins (1)


locking/atomic: build error on sparc64:allmodconfig
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net/
https://lore.kernel.org/lkml/32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net/

By Guenter Roeck; 18 days ago; 15 activities, latest 0 days ago.
Introduced in d12157efc8e0 (v6.5-rc1)

Fix incoming:
* sparc: mark __arch_xchg() as __always_inline
  https://lore.kernel.org/lkml/cdd40a39-28ba-3c75-b9d0-b62904cb48a3@leemhuis.info/


drm/bridge: lt9611: Dragonboard 845c (SDM845) devboard broken when running AOSP
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
https://lore.kernel.org/dri-devel/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/

By Amit Pundir; 11 days ago; 20 activities, latest 2 days ago.
Introduced in 8ddce13ae69 (v6.5-rc1)

Recent activities from: Abhinav Kumar (2), Marek Vasut (2), Amit
  Pundir (1), Jagan Teki (1)


[ *NEW* ] kernel pointer dereference regression due to extract_iter_to_sg()
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/
https://lore.kernel.org/lkml/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com/

By Ondrej Mosnáček; 3 days ago; 2 activities, latest 2 days ago.
Introduced in c1abe6f570af (v6.5-rc1)

Recent activities from: Bagas Sanjaya (1), Ondrej Mosnáček (1)


net: phylink: mv88e6060 dsa driver broken
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/
https://lore.kernel.org/netdev/CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com/

By Sergei Antonov; 12 days ago; 8 activities, latest 2 days ago.
Introduced in de5c9bf40c45 (v6.5-rc1)

Recent activities from: Vladimir Oltean (3), Sergei Antonov (2), Russell
  King (Oracle) (1), Andrew Lunn (1)


[ *NEW* ] KVM: arm64: boot failures due to missing bti instructions
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230704134136.a5znw4jupt5yp5kg@bogus/
https://lore.kernel.org/lkml/20230704134136.a5znw4jupt5yp5kg@bogus/

By Sudeep Holla; 12 days ago; 18 activities, latest 3 days ago.
Introduced in b53d4a272349 (v6.5-rc1)

Fix incoming:
* KVM: arm64: Add missing BTI instructions
  https://lore.kernel.org/lkml/55bffc21-5f19-765f-9dbc-1b565c880426@leemhuis.info/


blk-mq: NFS workload leaves nfsd threads in D state
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
https://lore.kernel.org/linux-block/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/

By Chuck Lever III; 7 days ago; 11 activities, latest 4 days ago.
Introduced in 615939a2ae73 (v6.5-rc1)

Recent activities from: Chuck Lever III (4), Christoph Hellwig (4),
  Chengming Zhou (2)

2 patch postings are associated with this regression, the latest is this:
* Re: NFS workload leaves nfsd threads in D state
  https://lore.kernel.org/linux-block/20230711120137.GA27050@lst.de/
  5 days ago, by Christoph Hellwig


objtool: build failure
----------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/
https://lore.kernel.org/lkml/20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz/

By Michal Kubecek; 18 days ago; 15 activities, latest 4 days ago.
Introduced in eb0481bbc4ce (v6.5-rc1)

Fix incoming:
* objtool: initialize all of struct elf
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=9f71fbcde2820f2af4658313e808cf1e579190a4


Bluetooth: Dragonboard 845c (SDM845) devboard broken
----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/
https://lore.kernel.org/lkml/CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com/

By Amit Pundir; 9 days ago; 5 activities, latest 6 days ago.
Introduced in 6945795bc81 (v6.5-rc1)

Recent activities from: Amit Pundir (1), Johan Hovold (1)


===================================================
current cycle (v6.4.. aka v6.5-rc), unknown culprit
===================================================


[ *NEW* ] mm/vmalloc: NULL or otherwise bad pointer dereferences on ARM64
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/
https://lore.kernel.org/lkml/42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk/

By Mark Brown; 5 days ago; 8 activities, latest 4 days ago.
Introduced in v6.4..v6.5-rc1

Recent activities from: Mark Brown (5), Hugh Dickins (2), Lorenzo
  Stoakes (1)

One patch associated with this regression:
* Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
  https://lore.kernel.org/lkml/b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com/
  4 days ago, by Hugh Dickins


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/168891835223.2415011.16827771958379610758@leemhuis.info

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
