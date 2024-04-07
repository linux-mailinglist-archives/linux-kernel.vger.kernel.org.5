Return-Path: <linux-kernel+bounces-134597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D161289B35D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8700B28251C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C433BBE0;
	Sun,  7 Apr 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rR9VYt/G"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44E3A1B5;
	Sun,  7 Apr 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512049; cv=none; b=CIbiAXryuKm2yIZAFY8LuVayvmaQFgEKtLIdMD2yLD0fC0YqMLo3BO9ANzY20Y00Ee04SeO5P6HOPb5NRO5ykoG4HLm63TebGRG5MT1L7L2likMrOp42wQbwMJTdbzMYco+hFbNP0Mq7fbg28czuHv6lzCHx2wWnubol8r9Ilh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512049; c=relaxed/simple;
	bh=3Md9tJVX6dqO0+rjVuEn6Fwi1QnMIsBlC/t3nZwgSFs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TaTeB8tz82l9MG8JQCJpc1SwpC8sE3AfsAqhXLI+ozlduxsls2jH0gtOHG7HVONSnImqCLReseDQCFdZZN4Is9pZRPld1HgXZH3ti27dMFqnTSNLCmjwmC80onpjgcvNCIajOkUJeOJ+/6zpjJZpZN3clBxghiN2kl0qof0SSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rR9VYt/G; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KzB9+NC/iNbqC4GHXz3EN1UlpiBjSRxEyFKgXhwdjJE=; t=1712512046; x=1712944046;
	 b=rR9VYt/G7sGpCcjeNo/q80LxjukEZzygy/DQEXAWelkb3F5TvDlK1yIzICcZHj7HmI7rrzqU92
	60hYTlRHW255l6le8omZsrBx+G4tN0PFrtLt64wL5ybfdEspCywHFjiceqIbhylI7WZCck7xKiS9S
	YIa8vtYu1Y1WI5QRNrwrFU38QyYKL3sxJ9Ajwb+whrTm0zyBjlPaWBy7IZUW22JR40T1MCELi4mq4
	GSKlUO73VRBaZ6CGTtmSi2ixHeWjkEkrGswFqZ7o40Mae6Y4+6vZp/Z7RqHXzaullIs2+u2LQQ5TF
	yKs87DKO5TB499cOHOI2ipYMKOCUi9MXo9tyw==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rtWbz-0001uW-Vz; Sun, 07 Apr 2024 19:47:24 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-04-07]
Date: Sun,  7 Apr 2024 17:47:23 +0000
Message-ID: <171251198215.2979732.6005919918293923522@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712512046;1646a24a;
X-HE-SMSGID: 1rtWbz-0001uW-Vz

Hi Linus, here is the weekly regressions report. Nothing worth highlighting, so you might as well ignore this. :-D

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


[ *NEW* ] workqueue: nohz_full=0 prevents booting
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218665/
https://bugzilla.kernel.org/show_bug.cgi?id=218665
https://lore.kernel.org/lkml/5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info/

By Friedrich Oslage and Friedrich Oslage; 7 days ago; 15 activities, latest 0 days ago.
Introduced in 5797b1c18919 (v6.9-rc1)

Recent activities from: Oleg Nesterov (5), Frederic Weisbecker (2),
  Tejun Heo (2), The Linux kernel's regression tracker (Thorsten
  Leemhuis) (2)

3 patch postings are associated with this regression, the latest is this:
* Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work)
  https://lore.kernel.org/lkml/20240407135248.GB10796@redhat.com/
  0 days ago, by Oleg Nesterov

Noteworthy links:
* Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
  https://lore.kernel.org/lkml/20240402105847.GA24832@redhat.com/
  7 days ago, by Oleg Nesterov; thread monitored.


Framework Laptop 13 AMD suspend/wakeup regression with 6.9rc1
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218641/
https://bugzilla.kernel.org/show_bug.cgi?id=218641
https://lore.kernel.org/lkml/5b778e74-1278-42b1-84e1-a2c04a8211f0@leemhuis.info/

By David Markey and David Markey; 12 days ago; 20 activities, latest 0 days ago.
Introduced in 7ee988770326 (v6.9-rc1)

Recent activities from: anna-maria (5), Mario Limonciello (AMD) (5),
  Thomas Gleixner (2), Anna-Maria Behnsen (1), D.F. (1)

4 patch postings are associated with this regression, the latest is this:
* [PATCH] PM: s2idle: Make sure CPUs will wakeup directly on resume [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/20240405083410.4896-1-anna-maria@linutronix.de/
  2 days ago, by Anna-Maria Behnsen; thread monitored.


mainline boot regression on AMD Stoney Ridge Chromebooks
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240322175210.124416-1-laura.nao@collabora.com/
https://lore.kernel.org/lkml/20240322175210.124416-1-laura.nao@collabora.com/

By Laura Nao; 15 days ago; 16 activities, latest 2 days ago.
Introduced in c749ce393b (v6.9-rc1)

Recent activities from: Thomas Gleixner (9), Laura Nao (4)

One patch associated with this regression:
* Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
  https://lore.kernel.org/lkml/87plv59f45.ffs@tglx/
  2 days ago, by Thomas Gleixner


[ *NEW* ] net: Bluetooth: firmware loading problems with older firmware
-----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 6 days ago; 3 activities, latest 2 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)

Recent activities from: Mike Lothian (2), Deren Wu (武德仁) (1)


clk: qcom: gdsc: lockdep splat
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 16 days ago; 14 activities, latest 2 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Fix incoming:
* clk: qcom: gdsc: treat optional supplies as optional
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6677196fb1932e60b88ad0794a7ae532df178654


[ *NEW* ] leds: hangs on boot
-----------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 5 days ago; 3 activities, latest 3 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Recent activities from: Ben Greear (3)


fs: ntfs: obsolete legacy driver and a bunch of  warnings
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/linux-fsdevel/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/

By Johan Hovold and Artem S. Tashkinov; 16 days ago; 8 activities, latest 13 days ago; poked 3 days ago.
Introduced in 7ffa8f3d3023 (v6.9-rc1)

2 patch postings are associated with this regression, the latest is this:
* [PATCH 2/2] ntfs3: remove warning
  https://lore.kernel.org/linux-fsdevel/20240325-faucht-kiesel-82c6c35504b3@brauner/
  13 days ago, by Christian Brauner


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171190174577.2331570.14684431508078699808@leemhuis.info

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

