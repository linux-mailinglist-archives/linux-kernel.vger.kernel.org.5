Return-Path: <linux-kernel+bounces-89743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550C86F4F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A0D1F215DF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5EC154;
	Sun,  3 Mar 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RqGth0QL"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B079470;
	Sun,  3 Mar 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471162; cv=none; b=pIbd8yr4ONFnX39si3oVEX5IBio8YBDUUTKRj4nZx90UCVUlONyHbvGrb5JslpJdinBECDemA0mZ1yXG3q2IWezG0ovHa8xD4QhvYgCVATrG0m0Q+CrEX78GIt6QYd7S6ADwzm4ej0JDmQZ8xkHBX3jf5sjAhRw1uWLjTJUeBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471162; c=relaxed/simple;
	bh=GwzdYwwd9vKZRoG8vCcbFUhvwndoPO51vpUj+MhqH+Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pmYB2LbamE9vJCYtP+B8u6Z5Rv9uiEmbhw1kRTDXBgDY7owEKibIBLj3ReP54vj2Th4RbAx1HrmZqaDSWVV3X+vYXij6NR5qiIvaH76Fs9gFveg9NQ2n5FQx6xIh/sUD6MWia3EnbsmibMiqGI8DwVA7UtJ9Xv0zyKGbZMZ18xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RqGth0QL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=g/N+evvegUr5SmxCbvwZGklpSQjm33lIyoj6PNfHopc=; t=1709471160; x=1709903160;
	 b=RqGth0QL6uFf2uAtKIWhmrZev3hjKPZlsLXJOAMUJrDZONe0NpzCJ4mh/FWoPPvg+SjYVfA2Qk
	PK4qoxLVCA4du+DWH9KX//zo+i+5W0N6UR//ZNvEnRqCWUDRwpcR6vrxv99pV23YWwb+ZpFqtxDiY
	S4z35HULJyQkDC/LWf8vjfBwKLAr+c4J+JVmguB9pR7r2pz8Vr6u9Txy1XifKktzUAUNWdTuxd7I9
	o/aIEy55Hl1OFM6m5/iRJ/N3GZ97g1snOD2GXYPacZlsn0wvxCEk5b6XPh7KblHVpdeWQNdocNbG5
	b1l2TUWc/L4M8HohfYc2vdP+jvpYB6S4fJRFQ==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rglXS-0001eC-4K; Sun, 03 Mar 2024 14:05:58 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-03-03]
Date: Sun,  3 Mar 2024 13:05:55 +0000
Message-ID: <170947112079.436664.2969102323110743234@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709471160;a9bbae3e;
X-HE-SMSGID: 1rglXS-0001eC-4K

Hi Linus, things are mostly normal. Sadly normal as so often means that
fixes for some regressions are out there, just not yet in mainline.

 * A fix for "MXSFB error: -ENODEV: Cannot connect bridge"(*) appeared
in next-20240226 as d2f8795d9e50aa ("ARM: dts: imx7: remove DSI port
endpoints").
https://lore.kernel.org/lkml/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/

 * A fix for "sc7180 lazor: Image corruption regression for DP"(*)
appeared in next-20240227 as 0d7dfc79fb9b4b ("drm/msm/a6xx: specify UBWC
config for sc7180".
https://lore.kernel.org/regressions/85581fad-da8f-4550
a1c8-8f2996425dcd@lausen.nl/

 * A fix for warnings during suspend from a misc driver from Hans is
waiting for a review since 12 days.
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
https://lore.kernel.org/lkml/20240220190035.53402-1-hdegoede@redhat.com/

A few other things of note:

 * A lockdep splat in the stmmac code is not really making progress,
will prod tomorrow:
https://lore.kernel.org/lkml/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/

 * Johan Hovold meanwhile continues a quest to fix various regressions
that affect the Lenovo ThinkPad X13s; some of the fixes have already
reached you, some are still under discussion.

 * The list still includes the "decreased network outgoing performance
due to IRQ sharing that happened after a xhci change" I brought up a few
days ago; I'll remove that from the tracking, as you didn't reply.
Likewise for the 6.7 regression "user can't set the minimum power limit
of their Radeon graphic cards as low as before". For details, see:
https://lore.kernel.org/all/f2eaf931-8488-48e3-b008-1cedeba24f12@leemhuis.info/

 * There are a kexec and a nouveau regression from this cycle that are
brand new.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 8 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.7.. aka v6.8-rc), culprit identified
======================================================


[ *NEW* ] x86/mm/ident_map: kexec now leads to reboot
-----------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
https://lore.kernel.org/stable/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

By Pavin Joseph; 1 days ago; 9 activities, latest 0 days ago.
Introduced in d794734c9bbf (v6.8-rc5)

Recent activities from: Pavin Joseph (5), Linux regression tracking
  (Thorsten Leemhuis) (2), Thorsten Leemhuis (1), Steve Wahl (1)


`lis3lv02d_i2c_suspend()` causes `unbalanced disables for regulator-dummy` and `Failed to disable Vdd_IO: -EIO`
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/

By Paul Menzel; 30 days ago; 13 activities, latest 2 days ago.
Introduced in 2f189493ae32 (v6.8-rc1)

Recent activities from: Linux regression tracking (Thorsten
  Leemhuis) (2), Paul Menzel (1)

Noteworthy links:
* [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume
  https://lore.kernel.org/lkml/20240220190035.53402-1-hdegoede@redhat.com/
  11 days ago, by Hans de Goede; thread monitored.


[ *NEW* ] drm/nouveau: rendering freezes with multi-GPU setup
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240229175822.30613-1-sidpranjale127@protonmail.com/
https://lore.kernel.org/dri-devel/20240229175822.30613-1-sidpranjale127@protonmail.com/

By Sid Pranjale; 2 days ago; 1 activities, latest 2 days ago.
Introduced in 042b5f83841f (v6.8-rc4)

Recent activities from: Sid Pranjale (1)

One patch associated with this regression:
* [PATCH] drm/nouveau: keep DMA buffers required for suspend/resume
  https://lore.kernel.org/dri-devel/20240229175822.30613-1-sidpranjale127@protonmail.com/
  2 days ago, by Sid Pranjale


irq/net/usb: performance decrease now that network device and xhci share IRQs
-----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/

By Mikhail Gavrilov; 29 days ago; 29 activities, latest 3 days ago.
Introduced in f977f4c9301c (v6.8-rc1)

Recent activities from: mikhail.v.gavrilov (2), Thomas Gleixner (2),
  Mathias Nyman (2), Mikhail Gavrilov (1), Linux regression tracking
  (Thorsten Leemhuis) (1)


[ *NEW* ] Inconsistent lock state in stmmac code
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/
https://lore.kernel.org/lkml/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/

By Guenter Roeck; 20 days ago; 8 activities, latest 4 days ago.
Introduced in 38cc3c6dcc09 (v6.8-rc4)

Recent activities from: Petr Tesařík (1), Linux regression tracking
  (Thorsten Leemhuis) (1), Alexis Lothoré (1)


[ *NEW* ] drm/msm: DisplayPort hard-reset on hotplug regression in 6.8-rc1
--------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/

By Johan Hovold; 4 days ago; 1 activities, latest 4 days ago.
Introduced in 5814b8bf086a (v6.8-rc1)

Recent activities from: Johan Hovold (1)


[ *NEW* ] sc7180 lazor: Image corruption regression for DP with v6.8-rc4
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/drm/msm/49/
https://gitlab.freedesktop.org/drm/msm/-/issues/49
https://lore.kernel.org/regressions/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/

By Leonard Lausen and Leonard Lausen; 20 days ago; 9 activities, latest 5 days ago.
Introduced in 8814455a0e54 (v6.8-rc1)

Fix incoming:
* drm/msm/a6xx: specify UBWC config for sc7180
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=0d7dfc79fb9b4b81f642f84796111f2bae8427e2


MXSFB error: -ENODEV: Cannot connect bridge
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/lkml/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/regressions/20240214110822.GA81133@francesco-nb/

By Hiago De Franco and Francesco Dolcini; 23 days ago; 8 activities, latest 6 days ago.
Introduced in edbbae7fba49 (v6.8-rc1)

Fix incoming:
* ARM: dts: imx7: remove DSI port endpoints
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=d2f8795d9e50aa33c1e2bc0fcbb98ba4a7795749


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170886726066.1516351.14377022830495300698@leemhuis.info

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

