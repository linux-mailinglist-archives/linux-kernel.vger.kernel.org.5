Return-Path: <linux-kernel+bounces-105824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890987E515
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61089281E86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538702C1A8;
	Mon, 18 Mar 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kcQZr9Dl"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577B1F951;
	Mon, 18 Mar 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751134; cv=none; b=ACZo4QWrbEK19vB9wVez3uq9M3iFdsNr2eIMWUhyGx0L4V3NCph/hSExe7XCgmv1C43NfRIYPbEe5V0nY7aKjSLO7UpV+uCyyesSVXQewJiAwt0j4KlnctPDeahcVfYmACu3mxKHMdxJhXl8qdsjD5FpKX6YJf9SI8lkocqvQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751134; c=relaxed/simple;
	bh=WnShpXu62iSzRRDBo5xsNMmJG8+9mR0aHT5Ak7nJwng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM0k/iuB88SKJlrHUKrqDamQbgxzRAoFqWTWmsjOmNMxKzpPcLeNJAV3+gCYZJu98j2mSUKyWtjBJHe1e6mET+cpNCJegRhxYNwcGkj1jSc6WcwVY4Z/7Ou4TCMUb6RfqbiVxVM5xlkrWzODAJ/ePz8px0rnwJ8B7qlYjav72G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kcQZr9Dl; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Z3hD0ye0qaFiXPo1rbWYFlfwqkbkQMOMPhyUKL9+6YI=; t=1710751131;
	x=1711183131; b=kcQZr9DlZSpQts1OB4pZGxlsGPmuwCxmy4RiFVUxF25EVRKC2OxtDEkRABGUS
	BG6oN/FmY1id3cLxLV9paB2kiTBNauvKl95N1E0PQfzjtlA1kzCZyWjk1q75cqAIqA0MqpxFtDjs+
	tNh1g9Z3ihnsyVqdck0UotqQi+Q/UA8kdanndxUTBZXJhGWbGM/2KOIo7rtvZwx1FUm7YvhDIFamZ
	WFj7+xzpIODSCda2m3BHM4wgPViuFFTj+zqdAsGqMpjCezOpayFyU1oGniliCJQqIvUsAVVFoX996
	ratg4GF117lUrfGYhv0y+edwel/4/ioYz3n00fBSCS1mk6JkwA==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rm8W1-00037E-D0; Mon, 18 Mar 2024 09:38:41 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 3/4] docs: verify/bisect: drop 'v' prefix, EOL aspect, and assorted fixes
Date: Mon, 18 Mar 2024 09:38:38 +0100
Message-ID: <f13d203d5975419608996300992eaa2e4fcc2dc1.1710750972.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710750972.git.linux@leemhuis.info>
References: <cover.1710750972.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1710751131;f9e8a67c;
X-HE-SMSGID: 1rm8W1-00037E-D0

A bunch of minor fixes and improvements and two other things:

- Explain the 'v' version prefix when it's first used, but drop it
  everywhere in the text for consistency. Also drop single quotes around
  a few version numbers.

- Point out that testing a stable/longterm kernel only makes sense if
  the series is still supported.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 117 ++++++++++--------
 1 file changed, 62 insertions(+), 55 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 632372e343d89f..ee9df7ecb02ac7 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -39,13 +39,13 @@ aspects, all of which might be essential in your present case.]*
 developers**, execute just the *preparations* and *segment 1*; while doing so,
 consider the newest Linux kernel you regularly use to be the 'working' kernel.
 In the following example that's assumed to be 6.0.13, which is why the sources
-of v6.0 will be used to prepare the .config file.
+of 6.0 will be used to prepare the .config file.
 
 **In case you face a regression**, follow the steps at least till the end of
 *segment 2*. Then you can submit a preliminary report -- or continue with
 *segment 3*, which describes how to perform a bisection needed for a
 full-fledged regression report. In the following example 6.0.13 is assumed to be
-the 'working' kernel and 6.1.5 to be the first 'broken', which is why v6.0
+the 'working' kernel and 6.1.5 to be the first 'broken', which is why 6.0
 will be considered the 'good' release and used to prepare the .config file.
 
 * **Preparations**: set up everything to build your own kernels::
@@ -232,9 +232,10 @@ developers are obliged to act upon.
  :ref:`Supplementary tasks: cleanup during and after following this guide.<introclosure_bissbs>`
 
 The steps in each segment illustrate the important aspects of the process, while
-a comprehensive reference section holds additional details. The latter sometimes
-also outlines alternative approaches, pitfalls, as well as problems that might
-occur at the particular step -- and how to get things rolling again.
+a comprehensive reference section holds additional details for almost all of the
+steps. The reference section sometimes also outlines alternative approaches,
+pitfalls, as well as problems that might occur at the particular step -- and how
+to get things rolling again.
 
 For further details on how to report Linux kernel issues or regressions check
 out Documentation/admin-guide/reporting-issues.rst, which works in conjunction
@@ -285,23 +286,23 @@ Preparations: set up everything to build your own kernels
   Do you follow this guide to verify if a bug is present in the code developers
   care for? Then consider the mainline release your 'working' kernel (the newest
   one you regularly use) is based on to be the 'good' version; if your 'working'
-  kernel for example is '6.0.11', then your 'good' kernel is 'v6.0'.
+  kernel for example is 6.0.11, then your 'good' kernel is 6.0.
 
   In case you face a regression, it depends on the version range where the
   regression was introduced:
 
   * Something which used to work in Linux 6.0 broke when switching to Linux
-    6.1-rc1? Then henceforth regard 'v6.0' as the last known 'good' version
-    and 'v6.1-rc1' as the first 'bad' one.
+    6.1-rc1? Then henceforth regard 6.0 as the last known 'good' version
+    and 6.1-rc1 as the first 'bad' one.
 
   * Some function stopped working when updating from 6.0.11 to 6.1.4? Then for
-    the time being consider 'v6.0' as the last 'good' version and 'v6.1.4' as
+    the time being consider 6.0 as the last 'good' version and 6.1.4 as
     the 'bad' one. Note, at this point it is merely assumed that 6.0 is fine;
     this assumption will be checked in segment 2.
 
   * A feature you used in 6.0.11 does not work at all or worse in 6.1.13? In
     that case you want to bisect within a stable/longterm series: consider
-    'v6.0.11' as the last known 'good' version and 'v6.0.13' as the first 'bad'
+    6.0.11 as the last known 'good' version and 6.0.13 as the first 'bad'
     one. Note, in this case you still want to compile and test a mainline kernel
     as explained in segment 1: the outcome will determine if you need to report
     your issue to the regular developers or the stable team.
@@ -351,7 +352,7 @@ Preparations: set up everything to build your own kernels
   internet connections.*
 
   Execute the following command to retrieve a fresh mainline codebase while
-  preparing things to add stable/longterm branches later::
+  preparing things to add branches for stable/longterm series later::
 
     git clone -o mainline --no-checkout \
       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
@@ -370,14 +371,19 @@ Preparations: set up everything to build your own kernels
   identifier using ``uname -r``.
 
   Afterwards check out the source code for the version earlier established as
-  'good' (in this example this is assumed to be 6.0) and create a .config file::
+  'good'. In the following example command this is assumed to be 6.0; note that
+  the version number in this and all later Git commands needs to be prefixed
+  with a 'v'::
 
     git checkout --detach v6.0
+
+  Now create a build configuration file::
+
     make olddefconfig
 
-  The second command will try to locate the build configuration file for the
-  running kernel and then adjust it for the needs of the kernel sources you
-  checked out. While doing so, it will print a few lines you need to check.
+  The kernel build scripts then will try to locate the build configuration file
+  for the running kernel and then adjust it for the needs of the kernel sources
+  you checked out. While doing so, it will print a few lines you need to check.
 
   Look out for a line starting with '# using defaults found in'. It should be
   followed by a path to a file in '/boot/' that contains the release identifier
@@ -601,11 +607,12 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 
 .. _recheckstablebroken_bissbs:
 
-* Are you facing a problem within a stable/longterm release, but failed to
-  reproduce it with the mainline kernel you just built? Then check if the latest
-  codebase for the particular series might already fix the problem. To do so,
-  add the stable series Git branch for your 'good' kernel (again, this here is
-  assumed to be 6.0) and check out the latest version::
+* Are you facing a problem within a stable/longterm series, but failed to
+  reproduce it with the mainline kernel you just built? One that according to
+  the `front page of kernel.org <https://kernel.org/>`_ is still supported? Then
+  check if the latest codebase for the particular series might already fix the
+  problem. To do so, add the stable series Git branch for your 'good' kernel
+  (again, this here is assumed to be 6.0) and check out the latest version::
 
     cd ~/linux/
     git remote set-branches --add stable linux-6.0.y
@@ -639,7 +646,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 Do you follow this guide to verify if a problem is present in the code
 currently supported by Linux kernel developers? Then you are done at this
 point. If you later want to remove the kernel you just built, check out
-:ref:`Supplementary tasks: cleanup during and after following this guide.<introclosure_bissbs>`.
+:ref:`Supplementary tasks: cleanup during and after following this guide<introclosure_bissbs>`.
 
 In case you face a regression, move on and execute at least the next segment
 as well.
@@ -678,7 +685,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
     reboot
 
   When the system booted, you may want to verify once again that the
-  kernel you started is the one you just built:
+  kernel you started is the one you just built::
 
     tail -n 1 ~/kernels-built
     uname -r
@@ -701,7 +708,7 @@ configuration created earlier this works a lot faster than many people assume:
 overall on average it will often just take about 10 to 15 minutes to compile
 each kernel on commodity x86 machines.
 
-* In case your 'bad' version is a stable/longterm release (say v6.1.5), add its
+* In case your 'bad' version is a stable/longterm release (say 6.1.5), add its
   stable branch, unless you already did so earlier::
 
     cd ~/linux/
@@ -1191,8 +1198,8 @@ Note, shallow clones have a few peculiar characteristics:
  * For bisections the history needs to be deepened a few mainline versions
    farther than it seems necessary, as explained above already. That's because
    Git otherwise will be unable to revert or describe most of the commits within
-   a range (say v6.1..v6.2), as they are internally based on earlier kernels
-   releases (like v6.0-rc2 or 5.19-rc3).
+   a range (say 6.1..6.2), as they are internally based on earlier kernels
+   releases (like 6.0-rc2 or 5.19-rc3).
 
  * This document in most places uses ``git fetch`` with ``--shallow-exclude=``
    to specify the earliest version you care about (or to be precise: its git
@@ -1257,7 +1264,7 @@ restrictions).
 
 Occasionally odd things happen when trying to use a config file prepared for one
 kernel (say 6.1) on an older mainline release -- especially if it is much older
-(say v5.15). That's one of the reasons why the previous step in the guide told
+(say 5.15). That's one of the reasons why the previous step in the guide told
 you to boot the kernel where everything works. If you manually add a .config
 file you thus want to ensure it's from the working kernel and not from a one
 that shows the regression.
@@ -1407,12 +1414,12 @@ Individual adjustments
   *If you want to influence the other aspects of the configuration, do so
   now.* [:ref:`... <configmods_bissbs>`]
 
-You at this point can use a command like ``make menuconfig`` to enable or
-disable certain features using a text-based user interface; to use a graphical
-configuration utility, call the make target ``xconfig`` or ``gconfig`` instead.
-All of them require development libraries from toolkits they are based on
-(ncurses, Qt5, Gtk2); an error message will tell you if something required is
-missing.
+At this point you can use a command like ``make menuconfig`` or ``make nconfig``
+to enable or disable certain features using a text-based user interface; to use
+a graphical configuration utility, run ``make xconfig`` instead. Both of them
+require development libraries from toolkits they are rely on (ncurses
+respectively Qt5 or Qt6); an error message will tell you if something required
+is missing.
 
 [:ref:`back to step-by-step guide <configmods_bissbs>`]
 
@@ -1489,10 +1496,10 @@ highly recommended for these reasons:
 
 .. _checkoutmaster_bisref:
 
-Checkout the latest Linux codebase
-----------------------------------
+Check out the latest Linux codebase
+-----------------------------------
 
-  *Checkout the latest Linux codebase.*
+  *Check out the latest Linux codebase.*
   [:ref:`... <introlatestcheck_bissbs>`]
 
 In case you later want to recheck if an ever newer codebase might fix the
@@ -1520,7 +1527,7 @@ When a build error occurs, it might be caused by some aspect of your machine's
 setup that often can be fixed quickly; other times though the problem lies in
 the code and can only be fixed by a developer. A close examination of the
 failure messages coupled with some research on the internet will often tell you
-which of the two it is. To perform such a investigation, restart the build
+which of the two it is. To perform such investigation, restart the build
 process like this::
 
   make V=1
@@ -1543,10 +1550,10 @@ often one of the hits will provide a solution for your problem, too. If you
 do not find anything that matches your problem, try again from a different angle
 by modifying your search terms or using another line from the error messages.
 
-In the end, most trouble you are to run into has likely been encountered and
+In the end, most issues you run into have likely been encountered and
 reported by others already. That includes issues where the cause is not your
-system, but lies the code. If you run into one of those, you might thus find a
-solution (e.g. a patch) or workaround for your problem, too.
+system, but lies in the code. If you run into one of those, you might thus find a
+solution (e.g. a patch) or workaround for your issue, too.
 
 Package your kernel up
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -1662,18 +1669,18 @@ interest, as your testing might be flawed otherwise.
 
 .. _recheckbroken_bisref:
 
-Check the kernel built from the latest codebase
------------------------------------------------
+Check the kernel built from a recent mainline codebase
+------------------------------------------------------
 
   *Verify if your bug occurs with the newly built kernel.*
   [:ref:`... <recheckbroken_bissbs>`]
 
-There are a couple of reasons why the regression you face might not show up with
-your own kernel built from the latest codebase. These are the most frequent:
+There are a couple of reasons why your bug or regression might not show up with
+the kernel you built from the latest codebase. These are the most frequent:
 
-* The cause for the regression was fixed meanwhile.
+* The bug was fixed meanwhile.
 
-* The regression with the broken kernel was caused by a change in the build
+* What you suspected to be a regression was caused by a change in the build
   configuration the provider of your kernel carried out.
 
 * Your problem might be a race condition that does not show up with your kernel;
@@ -1725,9 +1732,9 @@ it's possible that the thing that regressed might never have worked in vanilla
 builds of the 'good' version in the first place.
 
 There is a third reason for those that noticed a regression between
-stable/longterm kernels of different series (e.g. v6.0.13..v6.1.5): it will
+stable/longterm kernels of different series (e.g. 6.0.13..6.1.5): it will
 ensure the kernel version you assumed to be 'good' earlier in the process (e.g.
-v6.0) actually is working.
+6.0) actually is working.
 
 [:ref:`back to step-by-step guide <introworkingcheck_bissbs>`]
 
@@ -1760,8 +1767,8 @@ multitude of reasons why this might happen. Some ideas where to look:
 
 Note, if you found and fixed problems with the .config file, you want to use it
 to build another kernel from the latest codebase, as your earlier tests with
-mainline and the latest version from an affected stable/longterm series most
-likely has been flawed.
+mainline and the latest version from an affected stable/longterm series were most
+likely flawed.
 
 [:ref:`back to step-by-step guide <recheckworking_bissbs>`]
 
@@ -1774,8 +1781,8 @@ Start the bisection
   'good' and 'bad'.* [:ref:`... <bisectstart_bissbs>`]
 
 This will start the bisection process; the last of the commands will make Git
-checkout a commit round about half-way between the 'good' and the 'bad' changes
-for your to test.
+check out a commit round about half-way between the 'good' and the 'bad' changes
+for you to test.
 
 [:ref:`back to step-by-step guide <bisectstart_bissbs>`]
 
@@ -1800,7 +1807,7 @@ There are two things worth of note here:
 * Those slightly odd looking version identifiers can happen during bisections,
   because the Linux kernel subsystems prepare their changes for a new mainline
   release (say 6.2) before its predecessor (e.g. 6.1) is finished. They thus
-  base them on a somewhat earlier point like v6.1-rc1 or even v6.0 -- and then
+  base them on a somewhat earlier point like 6.1-rc1 or even 6.0 -- and then
   get merged for 6.2 without rebasing nor squashing them once 6.1 is out. This
   leads to those slightly odd looking version identifiers coming up during
   bisections.
@@ -1816,7 +1823,7 @@ Bisection checkpoint
   [:ref:`... <bisecttest_bissbs>`]
 
 Ensure what you tell Git is accurate: getting it wrong just one time will bring
-the rest of the bisection totally of course, hence all testing after that point
+the rest of the bisection totally off course, hence all testing after that point
 will be for nothing.
 
 [:ref:`back to step-by-step guide <bisecttest_bissbs>`]
@@ -1837,7 +1844,7 @@ instead of testing ten or more kernels you might only have to build a few to
 resolve things.
 
 The .config file is put aside, as there is a decent chance that developers might
-ask for it after you reported the regression.
+ask for it after you report the regression.
 
 [:ref:`back to step-by-step guide <bisectlog_bissbs>`]
 
@@ -1887,7 +1894,7 @@ simply remove its modules directory in /lib/modules/.
 
 The other place is /boot/, where typically two up to five files will be placed
 during installation of a kernel. All of them usually contain the release name in
-their file name, but how many files and their exact name depends somewhat on
+their file name, but how many files and their exact names depend somewhat on
 your distribution's installkernel executable and its initramfs generator. On
 some distributions the ``kernel-install remove...`` command mentioned in the
 step-by-step guide will delete all of these files for you while also removing
-- 
2.44.0


