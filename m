Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5E7F07A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjKSQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:41:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0395F9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:41:41 -0800 (PST)
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1r4krc-00034r-Jb; Sun, 19 Nov 2023 17:41:40 +0100
From:   "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2023-11-19]
Date:   Sun, 19 Nov 2023 16:41:39 +0000
Message-Id: <170041205809.2648289.15922511203232588109@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700412102;d956a959;
X-HE-SMSGID: 1r4krc-00034r-Jb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Nothing much to report wrt to regressions in 6.7 cycle. There
is one drm issue that seems to annoy users of the Thinkpad T13s and some
others that use the msm driver. A fix exists since Oct 25. Abhinav Kumar
wanted to queue it "for -fixes rightaway" on Wednesday[1], but it
nevertheless still hasn't even reached -next afaics. Not sure what
happened there, but hope that things will clear up in the next few days.

[1] https://lore.kernel.org/dri-devel/a35623df-6a8e-b398-a0b2-7f11b9ec4e5d@quicinc.com/

While at it let me use this opportunity to bring your attention to one
other regressions from an earlier cycle that IMHO is not handled how you
expect regressions to be handled:

Quite a few machines with Adaptec controllers seems to hang for a few
tens of seconds to a few minutes before things start to work normally
again for a while. That problem is known since late June
(https://bugzilla.kernel.org/show_bug.cgi?id=217599 ) and apparently
caused by 9dc704dcc09eae ("scsi: aacraid: Reply queue mapping to CPUs
based on IRQ affinity") [v6.4-rc7]. Reverting the culprit seems to fix
the problem, but I have no idea if that would be a wise move, at that
commit fixes an I/O hang. Which might be why that commit despite a
warning of mine[1] was picked up by the stable team and added to 6.1.53.
That way it apparently reached Debian recently and caused more people to
run into this and show up in the bugzilla ticket. Hannes Reinecke ~four
weeks ago proposed a fix there, but that didn't work. Apart from it
there was not much (if any?) involvement from the culprit's author (CCed
to the ticket) or the scsi maintainers (which were pointed to that
ticket at least twice mail, among others in [2]).

[2] https://lore.kernel.org/all/4a639fff-445e-455b-9a31-57368d6b7021@leemhuis.info/

Sorry for not bringing this up earlier.

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


[ *NEW* ] drm/amd/display: horizontal flashing bar with a picture of the desktop background on white screen after login
-----------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E%2B8p-4QO6FOWa6zp22_A@mail.gmail.com/

By Mikhail Gavrilov; 5 days ago; 8 activities, latest 3 days ago.
Introduced in ed6e2782e974 (v6.7-rc1)

Recent activities from: Mikhail Gavrilov (5), Christian König (1), Lee,
  Alvin (1), Hamza Mahfooz (1)


[ *NEW* ] drm/msm/dp: boot broken on the Lenovo ThinkPad X13s and some other machines
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZVR8Flrjxy-wgqgJ@hovoldconsulting.com/
https://lore.kernel.org/dri-devel/ZVR8Flrjxy-wgqgJ@hovoldconsulting.com/

By Johan Hovold; 4 days ago; 2 activities, latest 3 days ago.
Introduced in bfcc3d8f94f4 (v6.7-rc1)

Fix incoming:
* drm/msm/dp: attach the DP subconnector property
  https://lore.kernel.org/dri-devel/3aa32b39-ee2f-405e-b4fe-983e351c2e20@leemhuis.info/


===================================================
current cycle (v6.6.. aka v6.7-rc), unknown culprit
===================================================


[ *NEW* ] Radeon regression in 6.6 kernel
-----------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/87edgv4x3i.fsf@vps.thesusis.net/
https://lore.kernel.org/lkml/87edgv4x3i.fsf@vps.thesusis.net/

By Phillip Susi; 7 days ago; 7 activities, latest 0 days ago.
Introduced in 56e449603f0a..b70438004a14 (v6.6-rc2..v6.7-rc1)

Recent activities from: Bagas Sanjaya (3), Phillip Susi (2), Linux
  regression tracking (Thorsten Leemhuis) (1), Dave Airlie (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/169858752781.1095326.10615907253726224231@leemhuis.info

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
