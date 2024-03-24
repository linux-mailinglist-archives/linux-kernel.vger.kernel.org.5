Return-Path: <linux-kernel+bounces-112724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8A887D6F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A68B1C20A74
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358018639;
	Sun, 24 Mar 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="UeKm70/b"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9E1426F;
	Sun, 24 Mar 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711293375; cv=none; b=BgQEVpnDAI5jB83n8awvnspYXv+19p+74TbRjxdAu0V2S9bOvo+9J/0X7osrPHEcgi9AJ6WohsKSroq0jwvW/Af2YrcRcuusL+81lbr280qpCMPszKKa45nFR2NawyrnXQgELFoS6k2/KMmN91NJLQX71oASTOz31xB/BUPJcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711293375; c=relaxed/simple;
	bh=/vVhyZaEb80l55hrvuHY1aJaeQ00mWkK1psLju4BvtQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EGf4MpFhtOIZ0aNPoEtxhDVBk+3HDPGd1KegCOUC73u++qY/5Fy2YD4ocX1UTsXZlCB4K0Td8ZWEYRR1RRrpxPOV+5G1WS6MtnH6g+4Bt4FndFRzOzSItLRdstK5f2Xd7Wr6XuadZoTAssrFIYpY4HGAT0f5QRtJOWG5VABB+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=UeKm70/b; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zGy+MTIuQKj08FjWhGd/m2pfMqypqBovoRY5p/5r4AM=; t=1711293372; x=1711725372;
	 b=UeKm70/bZJ7F7+A5UcWH1v+rixCBqX7ZNbZVUkrm+E/Uv9R7cHZSF2HYfMU3OKirREt9NFBCzL
	oNjTma9Tp1UMfzFMVlk2B2pq4e0fmN3PvKf75i8+vSSyZF6hcEKj0HQeFAZ/M5m4vGVYATN28+FDj
	OwRECOfUYIQq+8II+G7/h1M4pRDom5VzR2rk9Ywd9cjm/r1B2cJfU/+rwHcgSHNAhCr2cHSxwRpP/
	kKkU7ML/2ZDXjKYameRAFeKE2xKBBEFyCebGBHYxqVDqW3U436psfE45CTnBcubz7DiX5AlLJrqyQ
	8GDvDMi0Dx/RZEXnYsRA5uRKHGb+yQ9IPaygQ==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1roPZy-0005NA-4s; Sun, 24 Mar 2024 16:16:10 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-03-24]
Date: Sun, 24 Mar 2024 15:16:08 +0000
Message-ID: <171129332789.1915280.10544327663661648631@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711293372;deb53a8e;
X-HE-SMSGID: 1roPZy-0005NA-4s

Hi Linus, here is a quick regressions report. I already added a handful
of regression from this cycle to the tracking (see below), but none of
those are really worrying I'd say.

There is one more: a fix for a KASAN splat is already in next since
Friday as 9ddd90c947da4e ("fs/9p: fix uaf in in
v9fs_stat2inode_dotl")[1]. I had hoped Eric would have sent it to you by
now because it apparently is somewhat annoying for the net
maintainers[2] and maybe other kernel developers that use virtme -- but
seems that it's not on the way to you yet. :-/ Sigh. This "regression
fixes are ready at have been in next, but maintainers don't send them to
Linus before the next -rc" is sometimes slightly annoying from my point
of view...

[1] https://lore.kernel.org/all/20240202121531.2550018-1-lizhi.xu@windriver.com/
[2] https://lore.kernel.org/all/20240321182824.6f303e38@kernel.org/

A few words on regressions from the 6.8 cycle that have an easy fix
available and are kinda stalled, in case you are interested:

* A change that came late in the previous cycle made Johan Hovold report
yet another 6.8 regression with the Lenovo ThinkPad X13s, this time
about a Bluetooth problem. He provided a revert to fix it - the BT
people replied, but then nothing happened for 10 days now afaics; will
prod tomorrow:
https://lore.kernel.org/lkml/20240314100103.GC6100@craftyguy.net/

* Two people reported CPU stalls on some Rockchip SOCs that a revert can
fix, but so far I could not convince the developer to set things in motion: 
https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/
https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/

* A fix for bogus lockdep warnings in network driver stmmac also is
making no progress, despite a Reviewed-by: from Eric and some prodding
from my side:
https://lore.kernel.org/lkml/20240306111157.29327-1-petr@tesarici.cz/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 4 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.8.. aka v6.8-post), culprit identified
========================================================


[ *NEW* ] x86/percpu: crashes in qemu with nosmp builds and Intel CPUs
----------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net/
https://lore.kernel.org/lkml/e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net/

By Guenter Roeck; 8 days ago; 34 activities, latest 1 days ago.
Introduced in 71eb4893cfaf

Fix incoming:
* x86/cpu: Ensure that CPU info updates are propagated on UP
  https://lore.kernel.org/regressions/07ba20d1-3c95-42b6-b566-f5c1980ffe16@leemhuis.info/


[ *NEW* ] mm: vmalloc: persistent "spinlock bad magic" message when booting s390 images with spinlock debugging enabled
-----------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net/
https://lore.kernel.org/lkml/bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net/

By Guenter Roeck; 1 days ago; 3 activities, latest 1 days ago.
Introduced in 72210662c5a2

Recent activities from: Guenter Roeck (2), Uladzislau Rezki (1)

One patch associated with this regression:
* Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
  https://lore.kernel.org/lkml/Zf3V6B9f5o0H1LnE@pc636/
  1 days ago, by Uladzislau Rezki


[ *NEW* ] Re: [PATCH] fs: Remove NTFS classic
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/
https://lore.kernel.org/linux-fsdevel/Zf2zPf5TO5oYt3I3@hovoldconsulting.com/

By Johan Hovold; 1 days ago; 1 activities, latest 1 days ago.
Introduced in 7ffa8f3d3023

Recent activities from: Johan Hovold (1)


[ *NEW* ] SUNRPC: RFC 8009 encryption test fails
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZfxJZFwXqqurfet0@aion/
https://lore.kernel.org/linux-nfs/ZfxJZFwXqqurfet0@aion/

By Scott Mayhew; 3 days ago; 2 activities, latest 2 days ago.
Introduced in 561141dd4943

Recent activities from: Chuck Lever III (1), Scott Mayhew (1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170947112079.436664.2969102323110743234@leemhuis.info

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

