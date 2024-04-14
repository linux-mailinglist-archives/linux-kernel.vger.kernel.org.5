Return-Path: <linux-kernel+bounces-144209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA88A432C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E99B2107E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC559B41;
	Sun, 14 Apr 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="f84NdA/Y"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191D5676C;
	Sun, 14 Apr 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104871; cv=none; b=mrTOpSWYO+xwLY8cJsYVA4ILdKrWHynKD6+RZkbHQIIiACw6dIvU7bc4SEJOoySTzKLBVSEvCmPPepURNVh+K3ZiH0rFBuZZASxFcLb3uFnbeppJTP21iu8/wXno9vB7f6+Dok3aEyl6QoK/9yHIATeTtt2cxbwvbYGP8YwKr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104871; c=relaxed/simple;
	bh=z4aLvt7q8tSe/OIe9vHd9wJf/Uuidx0NIGNLsafAqUU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GxhbCC2+fEN2kTSnd7hGK3jOrlGYirBkqK8CJXWwxyGfak1M7EUSrHFXJSiZpizmYLM3U7GMGyDD9P/cJAUd5dshsCCUAQRp7jnxoPVEpvwxgUmaYlEqORnXNd7HBX4gu9Bb+F9zWN/H8YG+jcq7DxOwBKcm3vvp8OXpA6scnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=f84NdA/Y; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4gXMPa8PREdyg93Q7us+EJbOTVwOtJx791ddFFgUgPc=; t=1713104869; x=1713536869;
	 b=f84NdA/YDZDk7wCrFZ1Mp092tF+nmWAU1BxPg0KoVJ+V8BBQqTt3qN5J1FJWfjwG+9lNNJoek6
	P20ZMcc6f0AzRvrdWIf3HPWRVOnWEQ4MEfayV0r4Gh9u2TTGn38aCpIOLgh7M8G4u6k7V9TKLj6jp
	sEnGOJ3dnmobXZw8FaTVO+g8IJwSotKWhqAiG+nkfItze0FNNTkc0y7uU/gCdpSiDaZMyeguK73X5
	zfPW2P/Du8T4n/45/Cbkf04QqKa7dlfg/5liPw5yJ/oLJUByqdqx5kE8FcWmBaO8xPVLN54QnvErV
	jbZn4UNQVd9fjuyHkJ8wqeqbP7FLvI1LhSgbg==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rw0pY-0002rH-IO; Sun, 14 Apr 2024 16:27:40 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-04-14]
Date: Sun, 14 Apr 2024 14:27:39 +0000
Message-ID: <171310482077.3453606.17735678473578439767@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713104869;64f8bb31;
X-HE-SMSGID: 1rw0pY-0002rH-IO

Hi Linus, here is the weekly regressions report. Nothing worth
highlighting afaics. There is a BT regression that is not making
progress I'll prod tomorrow.

The biggest problem maybe worth mentioning are some fs/9p problems Eric
Van Hensbergen is trying to get a hold on for a few days now[1]. Maybe
Eric might send a big revert during next weeks if a fix does not come
into reach.

[1] https://lore.kernel.org/all/?q=f%3AHensbergen, e.g.
https://lore.kernel.org/all/CAFkjPTnn+Oc55hNg3B_aDE7=0bm2AHJRW5wpksA4N-QiutPGpw@mail.gmail.com/
https://lore.kernel.org/all/CAFkjPTnn+Oc55hNg3B_aDE7=0bm2AHJRW5wpksA4N-QiutPGpw@mail.gmail.com/

Ciao, Thorsten
---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 10 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


workqueue: nohz_full=0 prevents booting
---------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218665/
https://bugzilla.kernel.org/show_bug.cgi?id=218665
https://lore.kernel.org/lkml/5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info/

By Friedrich Oslage and Friedrich Oslage; 14 days ago; 25 activities, latest 1 days ago.
Introduced in 5797b1c18919 (v6.9-rc1)

Recent activities from: Oleg Nesterov (6), Frederic Weisbecker (3),
  Nicholas Piggin (1)

6 patch postings are associated with this regression, the latest is this:
* [PATCH] sched/isolation: fix boot crash when maxcpus < first-housekeeping-cpu
  https://lore.kernel.org/lkml/20240413141746.GA10008@redhat.com/
  1 days ago, by Oleg Nesterov

Noteworthy links:
* Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
  https://lore.kernel.org/lkml/20240402105847.GA24832@redhat.com/
  14 days ago, by Oleg Nesterov; thread monitored.


mainline boot regression on AMD Stoney Ridge Chromebooks
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240322175210.124416-1-laura.nao@collabora.com/
https://lore.kernel.org/lkml/20240322175210.124416-1-laura.nao@collabora.com/

By Laura Nao; 22 days ago; 36 activities, latest 2 days ago.
Introduced in c749ce393b (v6.9-rc1)

Fix incoming:
* x86/cpu/amd: Make the NODEID_MSR union actually work
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=898e4996e76053bfa0f578629ec6b35baff4224b


fs: ntfs: obsolete legacy driver and a bunch of  warnings
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/linux-fsdevel/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/all/6215a88a-7d78-4abb-911f-8a3e7033da3e@gmx.com/

By Johan Hovold and Artem S. Tashkinov; 22 days ago; 9 activities, latest 3 days ago.
Introduced in 7ffa8f3d3023 (v6.9-rc1)

Recent activities from: Konstantin Komarov (1)

3 patch postings are associated with this regression, the latest is this:
* Re: [PATCH 2/2] ntfs3: remove warning
  https://lore.kernel.org/linux-fsdevel/b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com/
  3 days ago, by Konstantin Komarov


leds: hangs on boot
-------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 11 days ago; 7 activities, latest 3 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Recent activities from: Johannes Berg (2), Lee Jones (1), Linux
  regression tracking (Thorsten Leemhuis) (1)


net: Bluetooth: firmware loading problems with older firmware
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 12 days ago; 3 activities, latest 9 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)


clk: qcom: gdsc: lockdep splat
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 22 days ago; 14 activities, latest 9 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Fix incoming:
* clk: qcom: gdsc: treat optional supplies as optional
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6677196fb1932e60b88ad0794a7ae532df178654


[ *NEW* ] x86/retpoline: MITIGATION_RETHUNK causes boot problems on x86-32 machines
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
https://lore.kernel.org/lkml/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
https://lore.kernel.org/lkml/20240413024956.488d474e@yea/

By Borislav Petkov and Erhard Furtner; 10 days ago; 4 activities, latest 10 days ago.
Introduced in 4461438a8405 (v6.9-rc1)


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


[ *NEW* ] Guest happens Call Trace when adding vCPU to guest
------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218698/
https://bugzilla.kernel.org/show_bug.cgi?id=218698
https://lore.kernel.org/lkml/b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info/

By Ma Xiangfei and Ma, XiangfeiX; 5 days ago; 8 activities, latest 3 days ago.
Introduced in v6.8-rc7..v6.9-rc2

Recent activities from: Artem S. Tashkinov (3), The Linux kernel's
  regression tracker (Thorsten Leemhuis) (3), Dongli Zhang (1), Ma
  Xiangfei (1)


[ *NEW* ] new 9p kasan splat in 6.9
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on/
https://lore.kernel.org/v9fs/f6upxoxa6d2c6cbh4ka775msggvuduigiu7xgvfx7qsufg2lo6@2ellaad6b2on/

By Kent Overstreet; 14 days ago; 10 activities, latest 3 days ago.
Introduced in v6.8..v6.9-rc2

Recent activities from: Eric Van Hensbergen (2), Kent Overstreet (1)


[ *NEW* ] fs: 9p: various problems (xfstests; open / unlink / fstat|ftruncate etc fail; warning when using apt)
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev/
https://lore.kernel.org/v9fs/E7D462A2-EE93-4A57-9F15-8565EE1567F3@linux.dev/
https://lore.kernel.org/v9fs/ZhNvwwYRN4-EczYi@codewreck.org/

By Itaru Kitayama and Dominique Martinet; 6 days ago; 5 activities, latest 6 days ago.
Introduced in v6.8..v6.9-rc2

Recent activities from: Itaru Kitayama (3), Dominique Martinet (2)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171251198215.2979732.6005919918293923522@leemhuis.info

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

