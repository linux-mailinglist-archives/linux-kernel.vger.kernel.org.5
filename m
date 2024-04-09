Return-Path: <linux-kernel+bounces-136357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650389D319
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08CC2832F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AB7E774;
	Tue,  9 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dhxGVrzX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321B7C0A6;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=fP2pkBMfL+wbk6Zil0/fIr1Z0w3tbiRoHbfpxazXmxx2589NWxn5dOdsxfRe6qe68zwYE/u+xkUcHK9b8Wp2/dlO1ub72dNTR9MSonjhTGZJDdfx/hByA2qDH1pmLL+f9bg7QL2LK8zp6B/Biw0sV66LChL2SfpZ9bcJsCREavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=Z7oJ0ojzxvgN6IlNaV9Gw82cLAFxnX0SPwkszNBnPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUjL9h3KIOFed0mednWNY3eryJtkWEAAKOY9rajg5ULNSYIdh4jQvYoZY6Yi0MNZ5Perb/e64koeAigwn1q5YEweW7J5SEezFMERevYEV9+qYjhUjMfTakJ91lj/SPJCpcls4mCtgrLR89tEWETn42vyFSsSybAf0NUjSNNB0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dhxGVrzX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=uCCHKQw/1e/VvfCrnRGy2B0smnW1Q61lxcP9UuK98Q8=; t=1712647855;
	x=1713079855; b=dhxGVrzXWpFtkaaAyeN6WjFd3bp/Jbf2XDdvHgkByRX5av70OaRzkfD1R7hq0
	2bPkMdfaM9u3o6/aR5EnFTAbS/j2TKR/DpnTYYVA/noL+3gqbyJ2TWT0T0kziIbqJzcW3rWNhKjM7
	xpCRWklc3ZwMRVM1WUzoHJFsUydBAgL98Wmgr/vVVgUwsnFa2FkswSi0SSP3GwpKZmRwEntgQGSUS
	OEEVhM9jbbDDVYEBXHHfS4o359txMB9T6srYcb1KQ5intSgM5smAYFdIqBLixD99CcgF6OwGZrN88
	4HXdMz7g/bk65ropsgMJBpf07hN4NGhiW0PUNK962TUySTczhQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wR-0006Ld-Ny; Tue, 09 Apr 2024 09:30:51 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 6/6] docs: verify/bisect: stable regressions: first stable, then mainline
Date: Tue,  9 Apr 2024 09:30:49 +0200
Message-ID: <efd3cb9c68db450091021326bf9c334553df0ec2.1712647788.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712647788.git.linux@leemhuis.info>
References: <cover.1712647788.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712647855;18e5c630;
X-HE-SMSGID: 1ru5wR-0006Ld-Ny

Rearrange the instructions so that readers facing a regression within a
stable or longterm series first test its latest release before testing
mainline. This is less scary for some people. It also reduces the chance
that something goes sideways for readers that compile their first
kernel, as mainline can cause slightly more trouble.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 91 +++++++++++--------
 1 file changed, 51 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 6193c797642732..c389d4fd7599df 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -309,31 +309,32 @@ machine; if you want to compile the kernel on another system, check
 .. _rangecheck_bissbs:
 
 * Determine the kernel versions considered 'good' and 'bad' throughout this
-  guide.
+  guide:
 
-  Do you follow this guide to verify if a bug is present in the code developers
-  care for? Then consider the mainline release your 'working' kernel (the newest
-  one you regularly use) is based on to be the 'good' version; if your 'working'
-  kernel for example is 6.0.13, then your 'good' kernel is 6.0.
+  * Do you follow this guide to verify if a bug is present in the code the
+    primary developers care for? Then consider the version of the newest kernel
+    you regularly use currently as 'good' (e.g. 6.0, 6.0.13, or 6.1-rc2).
 
-  In case you face a regression, it depends on the version range where the
-  regression was introduced:
+  * Do you face a regression, e.g. something broke or works worse after
+    switching to a newer kernel version? In that case it depends on the version
+    range during which the problem appeared:
 
-  * Something which used to work in Linux 6.0 broke when switching to Linux
-    6.1-rc1? Then henceforth regard 6.0 as the last known 'good' version
-    and 6.1-rc1 as the first 'bad' one.
+    * Something regressed when updating from a stable/longterm release
+      (say 6.0.13) to a newer mainline series (like 6.1-rc7 or 6.1) or a
+      stable/longterm version based on one (say 6.1.5)? Then consider the
+      mainline release your working kernel is based on to be the 'good'
+      version (e.g. 6.0) and the first version to be broken as the 'bad' one
+      (e.g. 6.1-rc7, 6.1, or 6.1.5). Note, at this point it is merely assumed
+      that 6.0 is fine; this hypothesis will be checked in segment 2.
 
-  * Some function stopped working when updating from 6.0.13 to 6.1.5? Then for
-    the time being consider 6.0 as the last 'good' version and 6.1.5 as
-    the 'bad' one. Note, at this point it is merely assumed that 6.0 is fine;
-    this assumption will be checked in segment 2.
+    * Something regressed when switching from one mainline version (say 6.0) to
+      a later one (like 6.1-rc1) or a stable/longterm release based on it
+      (say 6.1.5)? Then regard the last working version (e.g. 6.0) as 'good' and
+      the first broken (e.g. 6.1-rc1 or 6.1.5) as 'bad'.
 
-  * A feature you used in 6.0.13 does not work at all or worse in 6.1.15? In
-    that case you want to bisect within a stable/longterm series: consider
-    6.0.13 as the last known 'good' version and 6.0.15 as the first 'bad'
-    one. Note, in this case you still want to compile and test a mainline kernel
-    as explained in segment 1: the outcome will determine if you need to report
-    your issue to the regular developers or the stable team.
+    * Something regressed when updating within a stable/longterm series (say
+      from 6.0.13 to 6.0.15)? Then consider those versions as 'good' and 'bad'
+      (e.g. 6.0.13 and 6.0.15), as you need to bisect within that series.
 
   *Note, do not confuse 'good' version with 'working' kernel; the latter term
   throughout this guide will refer to the last kernel that has been working
@@ -392,19 +393,13 @@ machine; if you want to compile the kernel on another system, check
 
 .. _stablesources_bissbs:
 
-* Retrieve the sources for any stable or longterm series you might need.
-
-  Is the version you earlier established as 'bad' a stable or longterm release?
-  Then download the code for the series it belongs to ('linux-6.1.y' in this
-  example)::
+* Is one of the versions you earlier established as 'good' or 'bad' a stable or
+  longterm release (say 6.1.5)? Then download the code for the series it belongs
+  to ('linux-6.1.y' in this example)::
 
     git remote set-branches --add stable linux-6.1.y
     git fetch stable
 
-  If the version earlier established as 'good' is from a different stable or
-  longterm series (say 6.0.13), repeat the previous step, but this time for the
-  branch holding the series the 'good' version belongs to (e.g. linux-6.0.y).
-
 .. _oldconfig_bissbs:
 
 * Start preparing a kernel build configuration (the '.config' file).
@@ -545,10 +540,24 @@ be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
 
 .. _checkoutmaster_bissbs:
 
-* Check out the latest Linux codebase::
+* Check out the latest Linux codebase.
 
-    cd ~/linux/
-    git switch --discard-changes --detach mainline/master
+  * Are your 'good' and 'bad' versions from the same stable or longterm series?
+    Then check the `front page of kernel.org <https://kernel.org/>`_: if it
+    lists a release from that series without an '[EOL]' tag, checkout the series
+    latest version ('linux-6.1.y' in the following example)::
+
+      cd ~/linux/
+      git switch --discard-changes --detach stable/linux-6.1.y
+
+    Your series is unsupported, if is not listed or carrying a 'end of life'
+    tag. In that case you might want to check if a successor series (say
+    linux-6.2.y) or mainline (see next point) fix the bug.
+
+  * In all other cases, run::
+
+      cd ~/linux/
+      git switch --discard-changes --detach mainline/master
 
   [:ref:`details <checkoutmaster_bisref>`]
 
@@ -650,15 +659,15 @@ be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
 
 .. _recheckstablebroken_bissbs:
 
-* Are you facing a problem within a stable/longterm series, but failed to
-  reproduce it with the mainline kernel you just built? One that according to
-  the `front page of kernel.org <https://kernel.org/>`_ is still supported? Then
-  check if the latest codebase for the particular series might already fix the
-  problem. To do so, check out that series latest version (again, this here is
-  assumed to be 6.0)::
+* Did you just built a stable or longterm kernel? And were you able to reproduce
+  the regression with it? Then you should test the latest mainline codebase as
+  well, because the result determines which developers the bug must be submitted
+  to.
+
+  To prepare that test, check out current mainline::
 
     cd ~/linux/
-    git switch --discard-changes --detach linux-6.0.y
+    git switch --discard-changes --detach mainline/master
 
   Now use the checked out code to build and install another kernel using the
   commands the earlier steps already described in more detail::
@@ -680,7 +689,9 @@ be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
     uname -r
     cat /proc/sys/kernel/tainted
 
-  Now verify if this kernel is showing the problem.
+  Now verify if this kernel is showing the problem. If it does, then you need
+  to report the bug to the primary developers; if it does not, report it to the
+  stable team. See Documentation/admin-guide/reporting-issues.rst for details.
 
   [:ref:`details <recheckstablebroken_bisref>`]
 
-- 
2.44.0


