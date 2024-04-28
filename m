Return-Path: <linux-kernel+bounces-161331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE48B4AC3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D161C20EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254754BC3;
	Sun, 28 Apr 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ddX2gVc1"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9C4087C;
	Sun, 28 Apr 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294275; cv=none; b=CX1BPaFA0IWrWLKZQVK5lr4381vQNgYjTcmIguytS1GaSgMN3636CJlnIchHUmgugmXfwehf+2OWtdpgCLyddaISVBB3K7KP+w4XnHJUbVlgATEvPNQDXhwbRbXmFo1sEL42vKjz9hORJPZu77O+JCteIwfFVrWbCoUT4VgRQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294275; c=relaxed/simple;
	bh=uL7Oj6+p8bZppsO9uaH2Az131Nc/PQuQdpL+Yljoy74=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ukMbODAiEoXCJH3wcJEAz1WwMVu5x0zyf/0hGL9qlyglk+soYVIFyWul5eIjp0nKA4bkscPIglwu9IFUm72R/3Djwn4NkApWNDpa8ojXyodFkmbPiSUJbeP5q/xZ2oVymI7u3zQ1vWndUC0rVotaRzt+vI2OOtcYqdseP01ae6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ddX2gVc1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ORHhUrcPtKMyb4iNT733BnP6sk0bHqIN3QKAtijFNig=; t=1714294273; x=1714726273;
	 b=ddX2gVc1wvwTHa3yik3kejD2Isp0E5zBmysFcd/SGtuORgkfqxZlIuFKmPLdRuHnVcvfpX/+t8
	q3G1yHCQGNbMsIHn8U7FUFVj0T2s7GE2wfS9LbFZl0YuU+/0WKhDcuXw1kU4E5DiFuE1WdHc8SnUv
	r3dFt3XaIP5JbcB8pR1jJZMN+wSwlYbNU9TUHeEFRBgKsLjLmK6r1+WJBbSRBt3kjuMhRipbAdPsS
	VfbxSPGvfIpgotj2rLt0JgCOImHBItI8LePn5UtiIYUMTfwjpP/Q0WJf6HWdzzc0+sclBSW7mpg9q
	BDLSseiZuxfbkhoHsQjUHXSXEFCuPbSYday4w==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s10Fb-0001bB-8q; Sun, 28 Apr 2024 10:51:11 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-04-28]
Date: Sun, 28 Apr 2024 08:51:10 +0000
Message-ID: <171429421714.587108.18297293641257286341@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714294273;7fc66e67;
X-HE-SMSGID: 1s10Fb-0001bB-8q

Hi Linus, here is the weekly report for regressions introduced during
this cycle. 

There is nothing in it that I'm really worried about. Had hoped a
partial revert[1] for a e1000e problem would make it to you. But that
did not work out, after 11 days it's not even reviewed yet afaics.
This is somewhat annoying, as the culprit made it to some stable
trees and annoys quite a few users[2]. :-/

[1] https://lore.kernel.org/all/20240417190320.3159360-1-vitaly.lifshits@intel.com/
[2] https://lore.kernel.org/lkml/ded3e7ae-6a7d-48b2-8acc-c125874ee09f@leemhuis.info/

Ohh, I had also hoped 6677196fb1932e ("clk: qcom: gdsc: treat optional
supplies as optional") [next-20240404 (pending-fixes)] finally would
make it to you; afaics it did not, but should soon according to the
maintainer[3].

[3] https://lore.kernel.org/lkml/653hocuhibu6xvffxblek4zoot3ryk7ilu6tbqznnliyfi3ma4@uhxfwcpsteny/

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 11 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


[ *NEW* ] Re: [PATCH] Revert "vmgenid: emit uevent when VMGENID updates"
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com/
https://lore.kernel.org/lkml/e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com/

By Alexander Graf; 6 days ago; 9 activities, latest 1 days ago.
Introduced in 3aadf100f93d (v6.9-rc5)

Recent activities from: Alexander Graf (4), Jason A. Donenfeld (2),
  Linux regression tracking (Thorsten Leemhuis) (1), Babis Chalios (1),
  Lennart Poettering (1)


[ *NEW* ] net: e1000e: scheduling while atomic
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218740/
https://bugzilla.kernel.org/show_bug.cgi?id=218740
https://lore.kernel.org/lkml/dff8729b-3ab6-4b54-a3b0-60fabf031d62@intel.com/

By *cJ* and Sasha Neftin; 10 days ago; 13 activities, latest 1 days ago.
Introduced in 6dbdd4de0362 (v6.9-rc3)

Fix incoming:
* e1000e: change usleep_range to udelay in PHY mdic access
  https://lore.kernel.org/regressions/03489993-9612-422f-b1d9-0ad5f62c0e98@leemhuis.info/


net: Bluetooth: firmware loading problems with older firmware
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 26 days ago; 8 activities, latest 2 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)

Fix incoming:
* Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=0b5286e3da9fd4cc2f142afe56d1590c1d1cf9bd


x86/topology: system stopped booting
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/

By Lyude Paul; 10 days ago; 12 activities, latest 2 days ago.
Introduced in f0551af02130 (v6.9-rc1)

Fix incoming:
* x86/topology: Deal with more broken ACPI tables
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


leds: hangs on boot
-------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 25 days ago; 16 activities, latest 2 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Fix incoming:
* wifi: iwlwifi: Use request_module_nowait
  https://lore.kernel.org/regressions/9bb17713-e3b7-4c8d-ba70-0221a969b154@leemhuis.info/


workqueue: nohz_full=0 prevents booting
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218665/
https://bugzilla.kernel.org/show_bug.cgi?id=218665
https://lore.kernel.org/lkml/5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info/

By Friedrich Oslage and Friedrich Oslage; 27 days ago; 34 activities, latest 3 days ago.
Introduced in 5797b1c18919 (v6.9-rc1)

Fix incoming:
* https://lore.kernel.org/regressions/9bb17713-e3b7-4c8d-ba70-0221a969b154@leemhuis.info/


btrfs: snapper fails
--------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/generic/https://github.com/openSUSE/snapper/issues/894/
https://github.com/openSUSE/snapper/issues/894

By Linux regression tracking (Thorsten Leemhuis); 6 days ago; 3 activities, latest 4 days ago.
Introduced in 86211eea8ae1 (v6.9-rc1)

Fix incoming:
* btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


clk: qcom: gdsc: lockdep splat
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 36 days ago; 15 activities, latest 5 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Fix incoming:
* clk: qcom: gdsc: treat optional supplies as optional
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6677196fb1932e60b88ad0794a7ae532df178654


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


[ *NEW* ] Ryzen 7840HS CPU single core never boosts to max frequency
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218759/
https://bugzilla.kernel.org/show_bug.cgi?id=218759

By Gaha; 6 days ago; 16 activities, latest 1 days ago.
Introduced in v6.8..v6.9-rc5

Recent activities from: Gaha (8), Perry Yuan(AMD) (4), Mario Limonciello
  (AMD) (3), The Linux kernel's regression tracker (Thorsten
  Leemhuis) (1)


sched: kernel NULL pointer dereference in pick_next_task_fair
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZhuYyrh3mweP_Kd8@nz.home/
https://lore.kernel.org/lkml/ZhuYyrh3mweP_Kd8@nz.home/
https://lore.kernel.org/lkml/CA%2B9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com/

By Sergei Trofimovich and Igor Raits; 13 days ago; 26 activities, latest 4 days ago.
Introduced in v6.8..v6.9-rc3

Fix incoming:
* sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=1560d1f6eb6b398bddd80c16676776c0325fe5fe


net: Beaglebone Ethernet Probe Failure In 6.8+
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zh/tyozk1n0cFv+l@euler/
https://lore.kernel.org/netdev/Zh%2Ftyozk1n0cFv%2Bl@euler/

By Colin Foster; 10 days ago; 6 activities, latest 4 days ago.
Introduced in v6.8..v6.9-rc5

Recent activities from: Andrew Halaney (1), Andrew Lunn (1), Colin
  Foster (1)

One patch associated with this regression:
* Re: Beaglebone Ethernet Probe Failure In 6.8+
  https://lore.kernel.org/netdev/Zicyc0pj3g7%2FMemK@euler/
  5 days ago, by Colin Foster


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171372007343.4173668.6277096045174922087@leemhuis.info

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

