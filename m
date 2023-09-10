Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC4799EF5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjIJQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIJQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:25:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B8119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 09:25:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qfNFM-0008Up-8D; Sun, 10 Sep 2023 18:25:16 +0200
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-09-10]
Date:   Sun, 10 Sep 2023 16:25:15 +0000
Message-Id: <169436306694.2246708.7828658786502488268@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694363118;35ef566d;
X-HE-SMSGID: 1qfNFM-0008Up-8D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Here is a quick regression report for mainline ahead of
6.6-rc1. Not much to report. I noticed quite a few reports due to
regressions during the merge window, but except two all of them got
fixed already. And the fix for one of them is worked out already as
well, just not yet heading your way afaics.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 3 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.5.. aka v6.5-post), culprit identified
========================================================


[ *NEW* ] lockdep: backtrace on loongarch
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net/
https://lore.kernel.org/lkml/b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net/

By Guenter Roeck; 6 days ago; 7 activities, latest 1 days ago.
Introduced in 0a6b58c5cd0d

Recent activities from: Guenter Roeck (4), Helge Deller (3)

3 patch postings are associated with this regression, the latest is this:
* Re: [PATCH] lockdep: Fix static memory detection even more
  https://lore.kernel.org/lkml/ZPl%2BY2vRYUnWtTQc@ls3530/
  3 days ago, by Helge Deller


[ *NEW* ] Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test fails
---------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZPTvIb6hwIjY7T2M@mit.edu/
https://lore.kernel.org/linux-ext4/ZPTvIb6hwIjY7T2M@mit.edu/

By Theodore Ts'o; 6 days ago; 11 activities, latest 3 days ago.
Introduced in 8147c4c4546f

Fix incoming:
* jbd2: Remove page size assumptions
  https://lore.kernel.org/linux-ext4/eb707c22-b64a-4b08-9cf9-fcbeb1ddf16c@leemhuis.info/


3D============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169193884982.322301.2963227405402975023@leemhuis.info

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
