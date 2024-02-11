Return-Path: <linux-kernel+bounces-60691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D83850891
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083261F21956
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78BA59B4E;
	Sun, 11 Feb 2024 10:02:22 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E54654E;
	Sun, 11 Feb 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707645742; cv=none; b=pNLceN4ciBFiA7QWoFGggYpzt0N2ZGj898SU6mc+wnyL04QxQO6TlJUHa/fEw0LmfkisrDCTS9Ml6Z9s0giIlCL32N2OKbbExrFsckvLnICLXulimDHWE+lbD5pANKWCYlRx9MURw3cvoqUtO+cM1kjOGu3t+And2pol5iOJYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707645742; c=relaxed/simple;
	bh=FLM87GWBIqq+21QUmq7nG9qXFxso3CinqfwCnCj+hvk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MVdows8ZgkwlWTYQgCAx9f4fbNxKb3eunfO3Cr6rXvDTOvVc9IjnSCjc6mLq0oZtE1GqxqPnt+QIV/qDLQbzmr49aWar3BHbdKVfRDdPqyN8n/LT7M+8e3e+DfQn+RsaWXbk34SWa+o7JsuplYPEqrU99YgW9NNZyMlusUCHprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rZ6f5-0000Rh-Ve; Sun, 11 Feb 2024 11:02:12 +0100
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-02-11]
Date: Sun, 11 Feb 2024 10:02:11 +0000
Message-Id: <170764569476.480163.4912590939283332268@leemhuis.info>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707645740;2698d6f1;
X-HE-SMSGID: 1rZ6f5-0000Rh-Ve

Hi Linus, from the regressions point of view it's afaics business as
usual and nothing to worry about. 

A fix[1] for a boot failure for on Apple M1 took the wrong path, but
that was noticed and it hopefully should arrive in your tree during the
next week[2].

[1] https://lore.kernel.org/lkml/20240122153442.7250-1-arnd@kernel.org/
[2] https://lore.kernel.org/lkml/20240209163454.98051-1-srinivas.kandagatla@linaro.org/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 7 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.7.. aka v6.8-rc), culprit identified
======================================================


nvmem: boot failure for linux-6.8-rc1 on Apple M1
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240122153442.7250-1-arnd@kernel.org/
https://lore.kernel.org/lkml/20240122153442.7250-1-arnd@kernel.org/

By Arnd Bergmann; 19 days ago; 12 activities, latest 1 days ago.
Introduced in 0331c611949f (v6.8-rc1)

Fix incoming:
* nvmem: include bit index in cell sysfs file name
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=b588e2d813c85a2ecbaf3d64269dfde4bb735917


[ *NEW* ] usb: typec: boot issues on rk3399-roc-pc due to revert
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/
https://lore.kernel.org/lkml/ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk/

By Mark Brown; 2 days ago; 1 activities, latest 2 days ago.
Introduced in b717dfbf73e8 (v6.8-rc3)

Recent activities from: Mark Brown (1)


[ *NEW* ] `lis3lv02d_i2c_suspend()` causes `unbalanced disables for regulator-dummy` and `Failed to disable Vdd_IO: -EIO`
-------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
https://lore.kernel.org/lkml/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/

By Paul Menzel; 8 days ago; 2 activities, latest 2 days ago.
Introduced in 2f189493ae32 (v6.8-rc1)

Recent activities from: Mark Brown (1), Paul Menzel (1)


md/raid5: issue with raid5 with journal device
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240123005700.9302-1-dan@danm.net/
https://lore.kernel.org/lkml/20240123005700.9302-1-dan@danm.net/

By Dan Moulding; 19 days ago; 38 activities, latest 3 days ago.
Introduced in bed9e27baf52 (v6.8-rc1)

Fix incoming:
* Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""
  https://lore.kernel.org/regressions/a68c06ec-b303-4caf-ac39-882a1acb75b1@leemhuis.info/


sched: DT kselftests on meson-gxl-s905x-libretech-cc fail
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Za8cjQXptttuyb6c@finisterre.sirena.org.uk/
https://lore.kernel.org/lkml/Za8cjQXptttuyb6c@finisterre.sirena.org.uk/

By Mark Brown; 19 days ago; 15 activities, latest 5 days ago.
Introduced in b3edde44e5d4 (v6.8-rc1)

Fix incoming:
* topology: Set capacity_freq_ref in all cases
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=98323e9d70172f1b46d1cadb20d6c54abf62870d


Regression by b17ef04bf3a4 ("drm/amd/display: Pass pwrseq inst for backlight and ABM")
--------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZbUB0YWxEET3Y0xA@eldamar.lan/
https://lore.kernel.org/lkml/ZbUB0YWxEET3Y0xA@eldamar.lan/

By Salvatore Bonaccorso; 14 days ago; 4 activities, latest 12 days ago.
Introduced in b17ef04bf3a4 (v6.8-rc1)

Recent activities from: Salvatore Bonaccorso (1)

Noteworthy links:
* https://bugs.debian.org/1061449
* https://gitlab.freedesktop.org/drm/amd/-/issues/3122


===================================================
current cycle (v6.7.. aka v6.8-rc), unknown culprit
===================================================


[ *NEW* ] fs/9p: "netfs: Zero-sized write" failures during ldconfig test
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
https://lore.kernel.org/v9fs/ZbQUU6QKmIftKsmo@FV7GG9FTHL/

By Eric Van Hensbergen; 15 days ago; 7 activities, latest 10 days ago.
Introduced in v6.7..v6.8-rc1

Fix incoming:
* netfs: Fix missing zero-length check in unbuffered write
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=ca9ca1a5d5a980550db1001ea825f9fdfa550b83


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/170646134151.3426506.9467210052600500703@leemhuis.info

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

