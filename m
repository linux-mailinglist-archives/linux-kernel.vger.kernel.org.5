Return-Path: <linux-kernel+bounces-126136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510788932A4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7415E1C21481
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D9145B03;
	Sun, 31 Mar 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DT810paS"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E07145321;
	Sun, 31 Mar 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901828; cv=none; b=ihsW5wosxmHd7yMyJdB1Ve/HNajK3Ow93kNxjBQU0SSvw+Aa+oRMOaux+ejn3CKgGUvce1cc+ts8FuSqNVl9W4WCNlymqzZmfFf3aoKJ2Q9xjRJj1+6N7WUC8aS8icoW6HBxD1dL6AZlrvqGLDjzUDgWQjC+E1Vy/qIsKamvYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901828; c=relaxed/simple;
	bh=7d4AGrg7LNaPz64XbJaN8PBYSWQNmkMRmzhW4Nfwirk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EXYRrEj1NqFccXI1s/GDTK+xhWEAa5k+BRGaVwDnludKlg0gl3m+Yrvcub0XBJwNgh/rGnA/ziNKIjczBBR9m/EBdhrSU9cLFYrU2kbvP9OmhxITIMkT0vhpRSOm6z0uFSo8PXZYla7TzdzoF6wJoEZcDIJGjsJKRMyL/JcfxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DT810paS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Rn1of4hq80Ie9C/f+S6crOqo5ck/AhqHFAKMNJp10XE=; t=1711901821; x=1712333821;
	 b=DT810paSc8SP+6+pViLwazv55v80JRKDFaQe+AJNoyyrD70Y8VZw0Gpn+PJM2L1OVN0haiycpa
	ycZw8kaxEapE/F0kN8WU91TfnHDD+NkkVZuUHg0Mnankg8Sg+523CYQlppdFak0Y7a+yi4RJ7tlMK
	bS8PTUQxuA67qRrtYDKOfRSKVii9PaSntXctzSwNvpX3B0yvXDRc5fvPBjuMKvzwBESNdeRL+qUGL
	/JNwjPoAiuFUlAcKpIpwXr9fRttH068ptKEXrTGKS+WWj8AKn+kK6tlaULPcrEz+ofjslDiBGdMmA
	XAYu+FZtql8DgEjvhuZ/nnpmq3KKEd0JtTPBw==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rqxrZ-0002bV-If; Sun, 31 Mar 2024 18:16:53 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-03-31]
Date: Sun, 31 Mar 2024 16:16:52 +0000
Message-ID: <171190174577.2331570.14684431508078699808@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711901821;ff9cb93f;
X-HE-SMSGID: 1rqxrZ-0002bV-If

Hi Linus, here is the weekly regressions report. Everything normal at
this point and nothing worth highlighting. Except maybe one thing:

* A fix for bogus lockdep warning in network driver stmmac that started
to happen in 6.8 is not making no progress, despite a Reviewed-by: from
Eric and some prodding from my side more than 10 days ago:
https://lore.kernel.org/lkml/20240306111157.29327-1-petr@tesarici.cz/
But well, it's "just" a lockdep warning, so it's not really urgent.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 7 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


[ *NEW* ] PWM vibrator does not probe with v6.9-rc1
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz/
https://lore.kernel.org/lkml/D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz/

By Karel Balej; 2 days ago; 5 activities, latest 2 days ago.
Introduced in 40ade0c2e794 (v6.9-rc1)

Recent activities from: Uwe Kleine-König (2), Karel Balej (2), Linux
  regression tracking (Thorsten Leemhuis) (1)

One patch associated with this regression:
* [PATCH] pwm: Fix setting period with #pwm-cells = <1> and of_pwm_single_xlate()
  https://lore.kernel.org/lkml/20240329103544.545290-2-u.kleine-koenig@pengutronix.de/
  2 days ago, by Uwe Kleine-König


mm: vmalloc: persistent "spinlock bad magic" message when booting s390 images with spinlock debugging enabled
-------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net/
https://lore.kernel.org/lkml/bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net/

By Guenter Roeck; 8 days ago; 4 activities, latest 2 days ago.
Introduced in 72210662c5a2 (v6.9-rc1)

Fix incoming:
* mm: vmalloc: bail out early in find_vmap_area() if vmap is not init
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=eefa71fa900336d7c9173a8ec3ce75af68f484ec


mainline boot regression on AMD Stoney Ridge Chromebooks
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240322175210.124416-1-laura.nao@collabora.com/
https://lore.kernel.org/lkml/20240322175210.124416-1-laura.nao@collabora.com/

By Laura Nao; 8 days ago; 3 activities, latest 3 days ago.
Introduced in c749ce393b (v6.9-rc1)

Recent activities from: Laura Nao (2)


[ *NEW* ] Framework Laptop 13 AMD suspend/wakeup regression with 6.9rc1
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218641/
https://bugzilla.kernel.org/show_bug.cgi?id=218641
https://lore.kernel.org/lkml/5b778e74-1278-42b1-84e1-a2c04a8211f0@leemhuis.info/

By David Markey and David Markey; 5 days ago; 6 activities, latest 4 days ago.
Introduced in 7ee988770326 (v6.9-rc1)

Recent activities from: David Markey (3), Mario Limonciello (AMD) (2),
  anna-maria (1)

One patch associated with this regression:
* bugzilla.kernel.org, issue 218641: new comment (#4) with patch
  https://bugzilla.kernel.org/show_bug.cgi?id=218641#c4
  5 days ago, by Mario Limonciello (AMD)


[ *NEW* ] Re: [PATCH v4 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX handler
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 8 days ago; 12 activities, latest 5 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Recent activities from: Johan Hovold (6), Mark Brown (2), Konrad
  Dybcio (1), Dmitry Baryshkov (1), Bjorn Andersson (1)

3 patch postings are associated with this regression, the latest is this:
* [PATCH 4/5] clk: qcom: gpucc-sc8280xp: fix GX external supply lookup [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/20240326140108.21307-5-johan%2Blinaro@kernel.org/
  5 days ago, by Johan Hovold; thread monitored.

Noteworthy links:
* [PATCH] clk: qcom: gdsc: treat optional supplies as optional [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/20240325081957.10946-1-johan%2Blinaro@kernel.org/
  6 days ago, by Johan Hovold; thread monitored.
* [PATCH] clk: qcom: gdsc: treat optional supplies as optional [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/20240325085835.26158-1-johan%2Blinaro@kernel.org/
  6 days ago, by Johan Hovold; thread monitored.


Re: [PATCH] fs: Remove NTFS classic
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/linux-fsdevel/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/

By Johan Hovold; 8 days ago; 8 activities, latest 6 days ago.
Introduced in 7ffa8f3d3023 (v6.9-rc1)

Recent activities from: Christian Brauner (5), Johan Hovold (2)

2 patch postings are associated with this regression, the latest is this:
* [PATCH 2/2] ntfs3: remove warning
  https://lore.kernel.org/linux-fsdevel/20240325-faucht-kiesel-82c6c35504b3@brauner/
  6 days ago, by Christian Brauner


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


[ *NEW* ] bluetooth: oops during init in btintel_read_debug_features
--------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/
https://lore.kernel.org/lkml/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/

By Thorsten Leemhuis; 5 days ago; 2 activities, latest 3 days ago.
Introduced in v6.8..v6.9-rc1

Fix incoming:
* Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=1c3366abdbe884be62e5a7502b4db758aa3974c6


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171129332789.1915280.10544327663661648631@leemhuis.info

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

