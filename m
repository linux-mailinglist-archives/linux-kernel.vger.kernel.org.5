Return-Path: <linux-kernel+bounces-80071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B4A862A70
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EEF1C20A97
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE410940;
	Sun, 25 Feb 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LUAKSLD3"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F7469E;
	Sun, 25 Feb 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708867311; cv=none; b=qmXetfeZ3Y20d+a21xZPqnnAigOtVVTPo4HPtzDLkMUwCf92dgcGS+4Uu7JvLUdzyCacHNOl1I/5tnuIjhbBJR+lp+T5VbiPFJ+aqsdK/ngqMfaaUo9QMOBLY0C6IgtnjRRMxAVDl61++0lx9L5vnrJq5CjzIe9+0wNGDZBKz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708867311; c=relaxed/simple;
	bh=e6Fs5hBNGOJi+qVx0rXmNV0o7cdgPBl+ah7whiZf/cY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UmrGMFjjZKXMPmXhaeKulk4/VwE0sWYxwAr2wtI20wiepG2DSYiYh+48YmU7mqNB2W7oz516JIuMki1pLwSOcGt3D3B0B1jVeOxYlq3qgguAwhQdhpjISWStl317fmjRVAOjIc1rkhY6hJebKBjIDWLWxAAk8grQqZ9xRYZ3Fqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LUAKSLD3; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-Id:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JlbyhRQ8fSq4p+P9jKTo/LO9pR3RlBvFeOkH9OxFcLQ=; t=1708867309; x=1709299309;
	 b=LUAKSLD3gpojRnLiCGsKuyy29yNliRyiBKLnx/yAUbXkW9x81hnj8ddS3ZzsPMMERuAkN4NgFX
	FjXFI6W4++2YaZpWZugXQsnnITI2C6YRbmvruVmK9Do/n0uPpXsoQFFf42EwJKucAGoMHs23dwjLD
	CeLZHNpDPOZSudLy8ijigUTzsme8EmglwiSZPWTXNinHEIjrRRRqq/dxqW+2q6zsNrwr5ysprGQY5
	EWv5VIkFFhyX4diDeHfEyh1QGViYSch6YzhGJL4eIeWOpXQl9y/zDFmBMOq9akflZJ4BmdyjtwkRM
	2oXfZWnHnWQTTukpOHQ0y2oLv55LgQFwKLmYg==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1reERv-00085o-5l; Sun, 25 Feb 2024 14:21:47 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-02-25]
Date: Sun, 25 Feb 2024 13:21:46 +0000
Message-Id: <170886726066.1516351.14377022830495300698@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708867309;03f85d7d;
X-HE-SMSGID: 1reERv-00085o-5l

Hi Linus, things look mostly normal from my point of view and a few
fixes for tracked issues are heading your way today or next week.
Nevertheless let me mention one issue where I fear that they might not
be fixed before the release:

* Decreased network outgoing speed due to irq sharing that started with
f977f4c9301c8a ("xhci: add handler for only one interrupt line"); the
report is already 22 days old and the discussion is slowly progressing
with no fix in sight (tglx was only brought in recently). Will prod
tomorrow, maybe that will help.
https://lore.kernel.org/lkml/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/
https://lore.kernel.org/lkml/4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com/

Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
X13s, but he send out patch series to fix some or all of those[1], so
with a bit of luck those issues will soon be fixed as well.
https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/

[1]
https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20240223152124.20042-1-johan+linaro@kernel.org/

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


MXSFB error: -ENODEV: Cannot connect bridge
-------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/lkml/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
https://lore.kernel.org/regressions/20240214110822.GA81133@francesco-nb/

By Hiago De Franco and Francesco Dolcini; 16 days ago; 7 activities, latest 0 days ago.
Introduced in edbbae7fba49 (v6.8-rc1)

Recent activities from: Shawn Guo (1), Francesco Dolcini (1)

One patch associated with this regression:
* Re: MXSFB error: -ENODEV: Cannot connect bridge
  https://lore.kernel.org/lkml/20240214105223.GA78582@francesco-nb/
  11 days ago, by Francesco Dolcini

Noteworthy links:
* [PATCH v1] ARM: dts: imx7: remove DSI port endpoints
  https://lore.kernel.org/lkml/20240216104255.21052-1-francesco@dolcini.it/
  9 days ago, by Francesco Dolcini; thread monitored.


sched/cpufreq: reduced maximum CPU frequency is ignored.
--------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/002f01da5ba0$49cbf810$dd63e830$@telus.net/
https://lore.kernel.org/lkml/002f01da5ba0%2449cbf810%24dd63e830%24@telus.net/

By Doug Smythies; 15 days ago; 15 activities, latest 0 days ago.
Introduced in 9c0b4bb7f630 (v6.8-rc1)

Fix incoming:
* cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back
  https://lore.kernel.org/regressions/1049ad19-dc5c-49d4-b12e-5b384f40ad7f@leemhuis.info/


usb: typec: boot issues on rk3399-roc-pc due to revert
------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/
https://lore.kernel.org/lkml/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/

By Mark Brown; 16 days ago; 12 activities, latest 2 days ago.
Introduced in b717dfbf73e8 (v6.8-rc3)

Fix incoming:
* usb: typec: tpcm: Fix issues with power being removed during reset
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=69f89168b310878be82d7d97bc0d22068ad858c0


[ *NEW* ] drm/msm/dp: runtime PM cause internal eDP display on the Lenovo ThinkPad X13s to not always show up on boot (2/2 regressions)
---------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/faad839a-4c28-449f-bd87-845b47a1a6a1@leemhuis.info/
https://lore.kernel.org/regressions/faad839a-4c28-449f-bd87-845b47a1a6a1@leemhuis.info/

By Johan Hovold; 2 days ago; 5 activities, latest 2 days ago.
Introduced in 5814b8bf086a (v6.8-rc1)

Recent activities from: Johan Hovold (3), Linux regression tracking
  #adding (Thorsten Leemhuis) (1), Abhinav Kumar (1)

Noteworthy links:
* drm/msm: Second DisplayPort regression in 6.8-rc1
  https://lore.kernel.org/lkml/ZdMwZa98L23mu3u6@hovoldconsulting.com/
  6 days ago, by Johan Hovold; thread monitored.


`lis3lv02d_i2c_suspend()` causes `unbalanced disables for regulator-dummy` and `Failed to disable Vdd_IO: -EIO`
---------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/

By Paul Menzel; 23 days ago; 10 activities, latest 3 days ago.
Introduced in 2f189493ae32 (v6.8-rc1)

Recent activities from: Hans de Goede (6)

Noteworthy links:
* [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume
  https://lore.kernel.org/lkml/20240220190035.53402-1-hdegoede@redhat.com/
  4 days ago, by Hans de Goede; thread monitored.


[ *NEW* ] irq/net/usb: performance decrease now that network device and xhci share IRQs
---------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com/

By Mikhail Gavrilov; 22 days ago; 21 activities, latest 3 days ago.
Introduced in f977f4c9301c (v6.8-rc1)

Recent activities from: Randy Dunlap (2), Mikhail Gavrilov (2), Mathias
  Nyman (1)


drm as well as soc: qcom: internal eDP display on the Lenovo ThinkPad X13s does not always show up on boot
----------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/

By Johan Hovold; 12 days ago; 13 activities, latest 4 days ago.
Introduced in 2bcca96abfbf (v6.8-rc1)

Fix incoming:
* soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
  https://lore.kernel.org/regressions/f49c65d0-8f6b-4261-a831-82dd9d3091e1@leemhuis.info/


sc7180-trogdor-lazor image corruption regression for USB-C DP Alt Mode ([PATCH 0/2] Add param for the highest bank bit)
-----------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/
https://lore.kernel.org/regressions/85581fad-da8f-4550-a1c8-8f2996425dcd@lausen.nl/

By Leonard Lausen; 7 days ago; 4 activities, latest 6 days ago.
Introduced in 8814455a0e54 (v6.8-rc1)

One patch associated with this regression:
* Re: [REGRESSION] sc7180-trogdor-lazor image corruption regression for USB-C DP Alt Mode ([PATCH 0/2] Add param for the highest bank bit)
  https://lore.kernel.org/regressions/cf95947d-8bec-4f95-9e08-2d942723cafc@linaro.org/
  7 days ago, by Dmitry Baryshkov


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170827338885.977320.16936376590840962619@leemhuis.info

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

