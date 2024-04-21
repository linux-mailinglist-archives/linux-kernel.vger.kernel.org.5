Return-Path: <linux-kernel+bounces-152537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE478AC03D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C2CB20B28
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA342942D;
	Sun, 21 Apr 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="3kOffwsB"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72614F4EB;
	Sun, 21 Apr 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720116; cv=none; b=eag84mY1jJi+4BKSNzVvBlt/lhxGLumoTueGsyKBCtBfZnAq/9FOKQVlu2aEYqutOfm/coEEujxKBVVhSNx1Ma/F0DmKTGkdXlePzqtjaKYJzRYqsYKtg6gwLxb+U7QqEKjJyzCTUgMDzwE5tNEGTdOrOJ4RRG6/kGil/Xd22ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720116; c=relaxed/simple;
	bh=jnDPYyUGF8KWZI/acH3h5szYqEd3zd2oWm68bhlT2go=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cW7RSWHjy1gUT+ghEudRP/Rm3v+kXnfd1Ye5T2FoEdmCVe1k9CaPZGGNI6f4vb9ZzVX+ksGBmskL8oLdO6xfmwzxylanWBJXyEUGNVGDOokh09cmplwjDRxd6qkbf0PUsamlpFLxx+Bj22rNRcGTUEyz+0dsrCb1eTX6KVBwxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=3kOffwsB; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=W19+hMh8iCpe7e1YN/BSiDXrEdxITke4MrSyNpzXPhg=; t=1713720114; x=1714152114;
	 b=3kOffwsBLW6ShF31378W4UkXAFf/ZrxX4/qXSd+Nt+fPFdR87jQ+uTjigyTj1l1mORR/0MmxqU
	wlR9Noy97njQNdxt4VrrHh/Bk6BSNWir/aFqE7ovulXCjXJqrA1Nvg5c5QYCUSjXNQ38m03eeLvFU
	8s9FzP2EjQ7iFdCNEaosWDJuuZ3mMwseHRZPGOc38kayz/HNgv2gusIOG9yMKNFq+kAaLnA9o4Tbq
	3jM4bOvDPiM4dSC8Y0wx/UNOxEFpPwfmw29tkVeGplHSSyeTlucN5PCGWepsCr/+dr58Tts6fN9bx
	JjPQkb6998VR9JCJMXZiMaF/idUtqGfg2KRFQ==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ryasx-0002Q4-UI; Sun, 21 Apr 2024 19:21:52 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-04-21]
Date: Sun, 21 Apr 2024 17:21:45 +0000
Message-ID: <171372007343.4173668.6277096045174922087@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713720114;6d23299f;
X-HE-SMSGID: 1ryasx-0002Q4-UI

Hi Linus, here is the weekly regressions report. Fixes for almost all of
the tracked regressions are already in next[1] or under review, so there
is nothing to worry about afaics.

Ciao, Thorsten

[1] on of the for more that two weeks now; will prod the maintainer
tomorrow to ensure it will make it for -rc6: 6677196fb1932e ("clk: qcom:
gdsc: treat optional supplies as optional") [next-20240404]

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 13 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


net: Bluetooth: firmware loading problems with older firmware
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 20 days ago; 7 activities, latest 0 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)

Fix incoming:
* Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=263296438807ac3b4f829711f056e796dff5f708


[ *NEW* ] CA6390 bluetooth doesn't work after warm boot or disable/reenable
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218726/
https://bugzilla.kernel.org/show_bug.cgi?id=218726

By Wren Turkal; 6 days ago; 95 activities, latest 0 days ago.
Introduced in 56d074d26c58 (v6.9-rc1)

Fix incoming:
* Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
  https://lore.kernel.org/regressions/92377e46-5eca-4c0b-b0b6-58394916abc3@leemhuis.info/


[ *NEW* ] net: wifi: iwlwifi: Thinkpad 480 no Wifi
--------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com/
https://lore.kernel.org/linux-wireless/8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com/

By Stefan Seyfried; 1 days ago; 4 activities, latest 1 days ago.
Introduced in a8b5d4809b50 (v6.9-rc2)

Fix incoming:
* wifi: iwlwifi: mvm: fix link ID management
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


[ *NEW* ] btrfs: snapper fails
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/generic/https://github.com/openSUSE/snapper/issues/894/
https://github.com/openSUSE/snapper/issues/894

By Linux regression tracking (Thorsten Leemhuis); 0 days ago; 1 activities, latest 1 days ago.
Introduced in 86211eea8ae1 (v6.9-rc1)

Fix incoming:
* btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


[ *NEW* ] x86/topology: system stopped booting
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/

By Lyude Paul; 3 days ago; 7 activities, latest 1 days ago.
Introduced in f0551af02130 (v6.9-rc1)

Fix incoming:
* x86/topology: Deal with more broken ACPI tables
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


[ *NEW* ] ACPI: PM: s2idle: sleep broken on 13th Gen Lenovo laptops
-------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218750/
https://bugzilla.kernel.org/show_bug.cgi?id=218750

By Mark Pearson; 1 days ago; 1 activities, latest 1 days ago.
Introduced in 073237281a50 (v6.9-rc1)

Recent activities from: Mark Pearson (1)


workqueue: nohz_full=0 prevents booting
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218665/
https://bugzilla.kernel.org/show_bug.cgi?id=218665
https://lore.kernel.org/lkml/5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info/

By Friedrich Oslage and Friedrich Oslage; 21 days ago; 29 activities, latest 3 days ago.
Introduced in 5797b1c18919 (v6.9-rc1)

Recent activities from: Frederic Weisbecker (2), Phil Auld (2)

6 patch postings are associated with this regression, the latest is this:
* [PATCH] sched/isolation: fix boot crash when maxcpus < first-housekeeping-cpu
  https://lore.kernel.org/lkml/20240413141746.GA10008@redhat.com/
  8 days ago, by Oleg Nesterov

Noteworthy links:
* Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
  https://lore.kernel.org/lkml/20240402105847.GA24832@redhat.com/
  21 days ago, by Oleg Nesterov; thread monitored.


fs: ntfs: obsolete legacy driver and a bunch of  warnings
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/linux-fsdevel/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/

By Johan Hovold and Artem S. Tashkinov; 30 days ago; 24 activities, latest 3 days ago.
Introduced in 7ffa8f3d3023 (v6.9-rc1)

Fix incoming:
* ntfs3: serve as alias for the legacy ntfs driver
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=74871791ffa9562d43567c5ff2ae93def3f39f65


leds: hangs on boot
-------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 19 days ago; 10 activities, latest 5 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Recent activities from: Lee Jones (1), Johannes Berg (1), Ben Greear (1)


[ *NEW* ] CA6390 bluetooth doesn't work after warm boot or disable/reenable
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org/
https://lore.kernel.org/linux-bluetooth/a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org/
https://bugzilla.kernel.org/show_bug.cgi?id=218726

By Wren Turkal and Wren Turkal; 16 days ago; 25 activities, latest 6 days ago.
Introduced in 56d074d26c58 (v6.9-rc1)

Fix incoming:
* Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable
  https://lore.kernel.org/regressions/92377e46-5eca-4c0b-b0b6-58394916abc3@leemhuis.info/


clk: qcom: gdsc: lockdep splat
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 30 days ago; 14 activities, latest 16 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Fix incoming:
* clk: qcom: gdsc: treat optional supplies as optional
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6677196fb1932e60b88ad0794a7ae532df178654


x86/retpoline: MITIGATION_RETHUNK causes boot problems on x86-32 machines
-------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
https://lore.kernel.org/lkml/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
https://lore.kernel.org/lkml/20240413024956.488d474e@yea/

By Borislav Petkov and Erhard Furtner; 17 days ago; 4 activities, latest 17 days ago.
Introduced in 4461438a8405 (v6.9-rc1)

Fix incoming:
* https://lore.kernel.org/regressions/cd12cf1d-f956-4c66-8622-0009d30210b7@leemhuis.info/


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


[ *NEW* ] sched: kernel NULL pointer dereference in pick_next_task_fair
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZhuYyrh3mweP_Kd8@nz.home/
https://lore.kernel.org/lkml/ZhuYyrh3mweP_Kd8@nz.home/
https://lore.kernel.org/lkml/CA%2B9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com/

By Sergei Trofimovich and Igor Raits; 7 days ago; 11 activities, latest 1 days ago.
Introduced in v6.8..v6.9-rc3

Recent activities from: Peter Zijlstra (4), Chen Yu (3), Xuewen Yan (2),
  Tim Chen (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf() if no eligible entity is found
  https://lore.kernel.org/lkml/20240419084520.GE12673@noisy.programming.kicks-ass.net/
  2 days ago, by Peter Zijlstra

Noteworthy links:
* Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf() if no eligible entity is found [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/ZiEaKOQwiNEglYtS@chenyu5-mobl2/
  3 days ago, by Chen Yu; thread monitored.


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171310482077.3453606.17735678473578439767@leemhuis.info

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

