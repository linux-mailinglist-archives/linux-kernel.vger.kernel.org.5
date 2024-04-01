Return-Path: <linux-kernel+bounces-126553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7F89396A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74357B21B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B834171C1;
	Mon,  1 Apr 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JbGZ7XfW"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1D10799;
	Mon,  1 Apr 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963793; cv=none; b=tYTulAqVZzb6xk0Dau4ZhwGxBcKFhW1qIuAvGvmGWYiImmTWU3DI8iWqaWLARlsB6nb2apI3wX3JqV0gb6vbkPuDYiFI54huPqQxuPbpZBSkWRjhMc2SryE8af+gSiJzKKmKUmo7fT1+ft85MyuJRBkzcWIl7Sjq4PoGhL7ZUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963793; c=relaxed/simple;
	bh=6FV8MGWn9db4QWiYr/dntyNyQPt3Xq+Y0kp7GZGYN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaIe3gmhbbWePmHhjmInT5UzTAY63LpfPneATl9CSbu6eY7CRLwoHpa3d3+skf4lB0X5P4tFpcDWu2F6/6Qfqux9BOPezfPBGwg34BijHXc+dztmCihSuV0WlEySjp7bRCVWJCC1TD+wuf6sHz7Qe6T23+wqFeFpi2mCd46uEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JbGZ7XfW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=RH+3KEyD9WK7qFUWdzP8dJUxIOCBVMCNW8A60oiD5t8=; t=1711963790;
	x=1712395790; b=JbGZ7XfWEUyiPXeHMbeHDzlkUW4F0+eo9LqrOXz2n+DTFH/S/waXiMbmZ8FXF
	e1BbPxJiMnHM8903QKMbuzDN0BwpAQ02vLVC1ZBPkDnJXLqfjt+5zmJE2BAqsKlkvQrb2CB891KHj
	7jBGC7c2me3sMPnCFa9TElyFqjJ1hBTl/AGeXBL7ocSDiTnMTofyUBkBgZsCof5HhMGMM/gdgmoZt
	rwCor3XSWLcjXY8EOOrTBr+bqgcuAo+JKPiOwKEBdclYa34NpxhUSi379kbc8LjuhMv/zTiOLX1Um
	wYTwAOJX8j8XX6qtODqOpbeCQRi47+nxYmVnWC1KBfwElQKjkQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rrDz6-0001Lq-VJ; Mon, 01 Apr 2024 11:29:45 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 1/3] docs: verify/bisect: git switch; proper headlines; various fixes;
Date: Mon,  1 Apr 2024 11:29:41 +0200
Message-ID: <8d3692c56f2e8a0f7e7b57afa1401e3daa5dd734.1711963460.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711963460.git.linux@leemhuis.info>
References: <cover.1711963460.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711963790;e0cace1b;
X-HE-SMSGID: 1rrDz6-0001Lq-VJ

Various small improvements and fixes:

* Use the more modern 'git switch' instead of 'git checkout', which
  makes it more obvious what's happening (among others due to the
  --discard-changes parameter that is more clear than --force).

* Separate ref links from their target with a space for better
  readability.

* Add a proper heading for the note at the end of the step-by-step
  guide.

* Use proper 3rd and 4th level headlines in the reference section and
  add short intros for the 2nd level headlines that lacked one.

* When trying to validate the bisection result with a revert, add a
  special tag to facilitate the identification.

* Fix a few typos and oddities.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 269 ++++++++++--------
 1 file changed, 158 insertions(+), 111 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index d3504826f40154..2aa9eafa4cfdec 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -29,7 +29,7 @@ The essence of the process (aka 'TL;DR')
 ========================================
 
 *[If you are new to building or bisecting Linux, ignore this section and head
-over to the* ":ref:`step-by-step guide<introguide_bissbs>`" *below. It utilizes
+over to the* ':ref:`step-by-step guide <introguide_bissbs>`' *below. It utilizes
 the same commands as this section while describing them in brief fashion. The
 steps are nevertheless easy to follow and together with accompanying entries
 in a reference section mention many alternatives, pitfalls, and additional
@@ -61,7 +61,7 @@ will be considered the 'good' release and used to prepare the .config file.
     cd ~/linux/
     git remote add -t master stable \
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
-    git checkout --detach v6.0
+    git switch --detach v6.0
     # * Hint: if you used an existing clone, ensure no stale .config is around.
     make olddefconfig
     # * Ensure the former command picked the .config of the 'working' kernel.
@@ -87,7 +87,7 @@ will be considered the 'good' release and used to prepare the .config file.
   a) Checking out latest mainline code::
 
        cd ~/linux/
-       git checkout --force --detach mainline/master
+       git switch --discard-changes --detach mainline/master
 
   b) Build, install, and boot a kernel::
 
@@ -125,7 +125,7 @@ will be considered the 'good' release and used to prepare the .config file.
   a) Start by checking out the sources of the 'good' version::
 
        cd ~/linux/
-       git checkout --force --detach v6.0
+       git switch --discard-changes --detach v6.0
 
   b) Build, install, and boot a kernel as described earlier in *segment 1,
      section b* -- just feel free to skip the 'du' commands, as you have a rough
@@ -157,11 +157,12 @@ will be considered the 'good' release and used to prepare the .config file.
      works with the newly built kernel. If it does, tell Git by executing
      ``git bisect good``; if it does not, run ``git bisect bad`` instead.
 
-     All three commands will make Git checkout another commit; then re-execute
+     All three commands will make Git check out another commit; then re-execute
      this step (e.g. build, install, boot, and test a kernel to then tell Git
      the outcome). Do so again and again until Git shows which commit broke
      things. If you run short of disk space during this process, check the
-     "Supplementary tasks" section below.
+     section 'Supplementary tasks: cleanup during and after the process'
+     below.
 
   d) Once your finished the bisection, put a few things away::
 
@@ -172,12 +173,15 @@ will be considered the 'good' release and used to prepare the .config file.
 
   e) Try to verify the bisection result::
 
-       git checkout --force --detach mainline/master
+       git switch --discard-changes --detach mainline/master
        git revert --no-edit cafec0cacaca0
+       cp ~/kernel-config-working .config
+       ./scripts/config --set-str CONFIG_LOCALVERSION '-local-cafec0cacaca0-reverted'
 
     This is optional, as some commits are impossible to revert. But if the
     second command worked flawlessly, build, install, and boot one more kernel
-    kernel, which should not show the regression.
+    kernel; just this time skip the first command copying the base .config file
+    over, as that already has been taken care off.
 
 * **Supplementary tasks**: cleanup during and after the process.
 
@@ -208,7 +212,7 @@ Step-by-step guide on how to verify bugs and bisect regressions
 ===============================================================
 
 This guide describes how to set up your own Linux kernels for investigating bugs
-or regressions you intent to report. How far you want to follow the instructions
+or regressions you intend to report. How far you want to follow the instructions
 depends on your issue:
 
 Execute all steps till the end of *segment 1* to **verify if your kernel problem
@@ -221,15 +225,15 @@ report; instead of the latter your could also head straight on and follow
 *segment 3* to **perform a bisection** for a full-fledged regression report
 developers are obliged to act upon.
 
- :ref:`Preparations: set up everything to build your own kernels.<introprep_bissbs>`
+ :ref:`Preparations: set up everything to build your own kernels <introprep_bissbs>`.
 
- :ref:`Segment 1: try to reproduce the problem with the latest codebase.<introlatestcheck_bissbs>`
+ :ref:`Segment 1: try to reproduce the problem with the latest codebase <introlatestcheck_bissbs>`.
 
- :ref:`Segment 2: check if the kernels you build work fine.<introworkingcheck_bissbs>`
+ :ref:`Segment 2: check if the kernels you build work fine <introworkingcheck_bissbs>`.
 
- :ref:`Segment 3: perform a bisection and validate the result.<introbisect_bissbs>`
+ :ref:`Segment 3: perform a bisection and validate the result <introbisect_bissbs>`.
 
- :ref:`Supplementary tasks: cleanup during and after following this guide.<introclosure_bissbs>`
+ :ref:`Supplementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
 
 The steps in each segment illustrate the important aspects of the process, while
 a comprehensive reference section holds additional details for almost all of the
@@ -247,17 +251,22 @@ regression and its culprit might be known already. For further details on
 what actually qualifies as a regression check out
 Documentation/admin-guide/reporting-regressions.rst.
 
+If you run into any problems while following this guide or have ideas how to
+improve it, :ref:`please let the kernel developers know <submit_improvements>`.
+
 .. _introprep_bissbs:
 
 Preparations: set up everything to build your own kernels
 ---------------------------------------------------------
 
+The following steps lay the groundwork for all further tasks.
+
 .. _backup_bissbs:
 
 * Create a fresh backup and put system repair and restore tools at hand, just
   to be prepared for the unlikely case of something going sideways.
 
-  [:ref:`details<backup_bisref>`]
+  [:ref:`details <backup_bisref>`]
 
 .. _vanilla_bissbs:
 
@@ -265,7 +274,7 @@ Preparations: set up everything to build your own kernels
   builds them automatically. That includes but is not limited to DKMS, openZFS,
   VirtualBox, and Nvidia's graphics drivers (including the GPLed kernel module).
 
-  [:ref:`details<vanilla_bisref>`]
+  [:ref:`details <vanilla_bisref>`]
 
 .. _secureboot_bissbs:
 
@@ -276,7 +285,7 @@ Preparations: set up everything to build your own kernels
   their restrictions through a process initiated by
   ``mokutil --disable-validation``.
 
-  [:ref:`details<secureboot_bisref>`]
+  [:ref:`details <secureboot_bisref>`]
 
 .. _rangecheck_bissbs:
 
@@ -311,13 +320,13 @@ Preparations: set up everything to build your own kernels
   throughout this guide will refer to the last kernel that has been working
   fine.*
 
-  [:ref:`details<rangecheck_bisref>`]
+  [:ref:`details <rangecheck_bisref>`]
 
 .. _bootworking_bissbs:
 
 * Boot into the 'working' kernel and briefly use the apparently broken feature.
 
-  [:ref:`details<bootworking_bisref>`]
+  [:ref:`details <bootworking_bisref>`]
 
 .. _diskspace_bissbs:
 
@@ -327,7 +336,7 @@ Preparations: set up everything to build your own kernels
   debug symbols: both explain approaches reducing the amount of space, which
   should allow you to master these tasks with about 4 Gigabytes free space.
 
-  [:ref:`details<diskspace_bisref>`]
+  [:ref:`details <diskspace_bisref>`]
 
 .. _buildrequires_bissbs:
 
@@ -337,7 +346,7 @@ Preparations: set up everything to build your own kernels
   reference section shows how to quickly install those on various popular Linux
   distributions.
 
-  [:ref:`details<buildrequires_bisref>`]
+  [:ref:`details <buildrequires_bisref>`]
 
 .. _sources_bissbs:
 
@@ -360,14 +369,14 @@ Preparations: set up everything to build your own kernels
     git remote add -t master stable \
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
-  [:ref:`details<sources_bisref>`]
+  [:ref:`details <sources_bisref>`]
 
 .. _oldconfig_bissbs:
 
 * Start preparing a kernel build configuration (the '.config' file).
 
   Before doing so, ensure you are still running the 'working' kernel an earlier
-  step told you to boot; if you are unsure, check the current kernel release
+  step told you to boot; if you are unsure, check the current kernelrelease
   identifier using ``uname -r``.
 
   Afterwards check out the source code for the version earlier established as
@@ -375,7 +384,7 @@ Preparations: set up everything to build your own kernels
   the version number in this and all later Git commands needs to be prefixed
   with a 'v'::
 
-    git checkout --detach v6.0
+    git switch --discard-changes --detach v6.0
 
   Now create a build configuration file::
 
@@ -398,7 +407,7 @@ Preparations: set up everything to build your own kernels
   'make olddefconfig' again and check if it now picked up the right config file
   as base.
 
-  [:ref:`details<oldconfig_bisref>`]
+  [:ref:`details <oldconfig_bisref>`]
 
 .. _localmodconfig_bissbs:
 
@@ -432,7 +441,7 @@ Preparations: set up everything to build your own kernels
   spending much effort on, as long as it boots and allows to properly test the
   feature that causes trouble.
 
-  [:ref:`details<localmodconfig_bisref>`]
+  [:ref:`details <localmodconfig_bisref>`]
 
 .. _tagging_bissbs:
 
@@ -442,7 +451,7 @@ Preparations: set up everything to build your own kernels
     ./scripts/config --set-str CONFIG_LOCALVERSION '-local'
     ./scripts/config -e CONFIG_LOCALVERSION_AUTO
 
-  [:ref:`details<tagging_bisref>`]
+  [:ref:`details <tagging_bisref>`]
 
 .. _debugsymbols_bissbs:
 
@@ -461,7 +470,7 @@ Preparations: set up everything to build your own kernels
     ./scripts/config -d DEBUG_INFO -d DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
       -d DEBUG_INFO_DWARF4 -d DEBUG_INFO_DWARF5 -e CONFIG_DEBUG_INFO_NONE
 
-  [:ref:`details<debugsymbols_bisref>`]
+  [:ref:`details <debugsymbols_bisref>`]
 
 .. _configmods_bissbs:
 
@@ -471,14 +480,14 @@ Preparations: set up everything to build your own kernels
   * Are you running Debian? Then you want to avoid known problems by performing
     additional adjustments explained in the reference section.
 
-    [:ref:`details<configmods_distros_bisref>`].
+    [:ref:`details <configmods_distros_bisref>`].
 
   * If you want to influence other aspects of the configuration, do so now using
     your preferred tool. Note, to use make targets like 'menuconfig' or
     'nconfig', you will need to install the development files of ncurses; for
     'xconfig' you likewise need the Qt5 or Qt6 headers.
 
-    [:ref:`details<configmods_individual_bisref>`].
+    [:ref:`details <configmods_individual_bisref>`].
 
 .. _saveconfig_bissbs:
 
@@ -488,7 +497,7 @@ Preparations: set up everything to build your own kernels
      make olddefconfig
      cp .config ~/kernel-config-working
 
-  [:ref:`details<saveconfig_bisref>`]
+  [:ref:`details <saveconfig_bisref>`]
 
 .. _introlatestcheck_bissbs:
 
@@ -498,16 +507,16 @@ Segment 1: try to reproduce the problem with the latest codebase
 The following steps verify if the problem occurs with the code currently
 supported by developers. In case you face a regression, it also checks that the
 problem is not caused by some .config change, as reporting the issue then would
-be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
+be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
 
 .. _checkoutmaster_bissbs:
 
 * Check out the latest Linux codebase::
 
     cd ~/linux/
-    git checkout --force --detach mainline/master
+    git switch --discard-changes --detach mainline/master
 
-  [:ref:`details<checkoutmaster_bisref>`]
+  [:ref:`details <checkoutmaster_bisref>`]
 
 .. _build_bissbs:
 
@@ -522,7 +531,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   reference section for alternatives, which obviously will require other
   steps to install as well.
 
-  [:ref:`details<build_bisref>`]
+  [:ref:`details <build_bisref>`]
 
 .. _install_bissbs:
 
@@ -555,7 +564,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   down: if you will build more kernels as described in segment 2 and 3, you will
   have to perform those again after executing ``command -v installkernel [...]``.
 
-  [:ref:`details<install_bisref>`]
+  [:ref:`details <install_bisref>`]
 
 .. _storagespace_bissbs:
 
@@ -568,7 +577,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   Write down or remember those two values for later: they enable you to prevent
   running out of disk space accidentally during a bisection.
 
-  [:ref:`details<storagespace_bisref>`]
+  [:ref:`details <storagespace_bisref>`]
 
 .. _kernelrelease_bissbs:
 
@@ -595,7 +604,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   If that command does not return '0', check the reference section, as the cause
   for this might interfere with your testing.
 
-  [:ref:`details<tainted_bisref>`]
+  [:ref:`details <tainted_bisref>`]
 
 .. _recheckbroken_bissbs:
 
@@ -603,7 +612,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   out the instructions in the reference section to ensure nothing went sideways
   during your tests.
 
-  [:ref:`details<recheckbroken_bisref>`]
+  [:ref:`details <recheckbroken_bisref>`]
 
 .. _recheckstablebroken_bissbs:
 
@@ -617,7 +626,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
     cd ~/linux/
     git remote set-branches --add stable linux-6.0.y
     git fetch stable
-    git checkout --force --detach linux-6.0.y
+    git switch --discard-changes --detach linux-6.0.y
 
   Now use the checked out code to build and install another kernel using the
   commands the earlier steps already described in more detail::
@@ -641,12 +650,12 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 
   Now verify if this kernel is showing the problem.
 
-  [:ref:`details<recheckstablebroken_bisref>`]
+  [:ref:`details <recheckstablebroken_bisref>`]
 
 Do you follow this guide to verify if a problem is present in the code
 currently supported by Linux kernel developers? Then you are done at this
 point. If you later want to remove the kernel you just built, check out
-:ref:`Supplementary tasks: cleanup during and after following this guide<introclosure_bissbs>`.
+:ref:`Supplementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
 
 In case you face a regression, move on and execute at least the next segment
 as well.
@@ -658,7 +667,7 @@ Segment 2: check if the kernels you build work fine
 
 In case of a regression, you now want to ensure the trimmed configuration file
 you created earlier works as expected; a bisection with the .config file
-otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
+otherwise would be a waste of time. [:ref:`details <introworkingcheck_bisref>`]
 
 .. _recheckworking_bissbs:
 
@@ -669,7 +678,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
   'good' (once again assumed to be 6.0 here)::
 
     cd ~/linux/
-    git checkout --detach v6.0
+    git switch --discard-changes --detach v6.0
 
   Now use the checked out code to configure, build, and install another kernel
   using the commands the previous subsection explained in more detail::
@@ -693,7 +702,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
   Now check if this kernel works as expected; if not, consult the reference
   section for further instructions.
 
-  [:ref:`details<recheckworking_bisref>`]
+  [:ref:`details <recheckworking_bisref>`]
 
 .. _introbisect_bissbs:
 
@@ -725,7 +734,7 @@ each kernel on commodity x86 machines.
     git bisect good v6.0
     git bisect bad v6.1.5
 
-  [:ref:`details<bisectstart_bisref>`]
+  [:ref:`details <bisectstart_bisref>`]
 
 .. _bisectbuild_bissbs:
 
@@ -745,7 +754,7 @@ each kernel on commodity x86 machines.
   If compilation fails for some reason, run ``git bisect skip`` and restart
   executing the stack of commands from the beginning.
 
-  In case you skipped the "test latest codebase" step in the guide, check its
+  In case you skipped the 'test latest codebase' step in the guide, check its
   description as for why the 'df [...]' and 'make -s kernelrelease [...]'
   commands are here.
 
@@ -754,7 +763,7 @@ each kernel on commodity x86 machines.
   totally normal to see release identifiers like '6.0-rc1-local-gcafec0cacaca0'
   if you bisect between versions 6.1 and 6.2 for example.
 
-  [:ref:`details<bisectbuild_bisref>`]
+  [:ref:`details <bisectbuild_bisref>`]
 
 .. _bisecttest_bissbs:
 
@@ -794,7 +803,7 @@ each kernel on commodity x86 machines.
   might need to scroll up to see the message mentioning the culprit;
   alternatively, run ``git bisect log > ~/bisection-log``.
 
-  [:ref:`details<bisecttest_bisref>`]
+  [:ref:`details <bisecttest_bisref>`]
 
 .. _bisectlog_bissbs:
 
@@ -806,7 +815,7 @@ each kernel on commodity x86 machines.
     cp .config ~/bisection-config-culprit
     git bisect reset
 
-  [:ref:`details<bisectlog_bisref>`]
+  [:ref:`details <bisectlog_bisref>`]
 
 .. _revert_bissbs:
 
@@ -827,12 +836,12 @@ each kernel on commodity x86 machines.
     latest codebase for the affected series like this::
 
       git fetch stable
-      git checkout --force --detach linux-6.0.y
+      git switch --discard-changes --detach linux-6.0.y
 
   * In all other cases check out latest mainline::
 
       git fetch mainline
-      git checkout --force --detach mainline/master
+      git switch --discard-changes --detach mainline/master
 
     If you bisected a regression within a stable/longterm series that also
     happens in mainline, there is one more thing to do: look up the mainline
@@ -846,23 +855,29 @@ each kernel on commodity x86 machines.
 
     git revert --no-edit cafec0cacaca0
 
-  If that fails, give up trying and move on to the next step. But if it works,
-  build a kernel again using the familiar command sequence::
+  If that fails, give up trying and move on to the next step; if it works,
+  adjust the tag to facilitate the identification and prevent accidentally
+  overwriting another kernel::
 
     cp ~/kernel-config-working .config
+    ./scripts/config --set-str CONFIG_LOCALVERSION '-local-cafec0cacaca0-reverted'
+
+  Build a kernel using the familiar command sequence, just without copying the
+  the base .config over::
+
     make olddefconfig &&
-    make -j $(nproc --all) &&
+    make -j $(nproc --all)
     # * Check if the free space suffices holding another kernel:
     df -h /boot/ /lib/modules/
     sudo make modules_install
     command -v installkernel && sudo make install
-    Make -s kernelrelease | tee -a ~/kernels-built
+    make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
-  Now check one last time if the feature that made you perform a bisection work
-  with that kernel.
+  Now check one last time if the feature that made you perform a bisection works
+  with that kernel: if everything went well, it should not show the regression.
 
-  [:ref:`details<revert_bisref>`]
+  [:ref:`details <revert_bisref>`]
 
 .. _introclosure_bissbs:
 
@@ -903,7 +918,7 @@ space might run out.
   kernel image and related files behind; in that case remove them as described
   in the reference section.
 
-  [:ref:`details<makeroom_bisref>`]
+  [:ref:`details <makeroom_bisref>`]
 
 .. _finishingtouch_bissbs:
 
@@ -926,18 +941,24 @@ space might run out.
     the version considered 'good', and the last three or four you compiled
     during the actual bisection process.
 
-  [:ref:`details<finishingtouch_bisref>`]
+  [:ref:`details <finishingtouch_bisref>`]
+
 
 .. _submit_improvements:
 
-This concludes the step-by-step guide.
+Conclusion
+----------
+
+You have reached the end of the step-by-step guide.
 
 Did you run into trouble following any of the above steps not cleared up by the
 reference section below? Did you spot errors? Or do you have ideas how to
-improve the guide? Then please take a moment and let the maintainer of this
+improve the guide?
+
+If any of that applies, please take a moment and let the maintainer of this
 document know by email (Thorsten Leemhuis <linux@leemhuis.info>), ideally while
 CCing the Linux docs mailing list (linux-doc@vger.kernel.org). Such feedback is
-vital to improve this document further, which is in everybody's interest, as it
+vital to improve this text further, which is in everybody's interest, as it
 will enable more people to master the task described here -- and hopefully also
 improve similar guides inspired by this one.
 
@@ -948,10 +969,20 @@ Reference section for the step-by-step guide
 This section holds additional information for almost all the items in the above
 step-by-step guide.
 
+Preparations for building your own kernels
+------------------------------------------
+
+  *The steps in this section lay the groundwork for all further tests.*
+  [:ref:`... <introprep_bissbs>`]
+
+The steps in all later sections of this guide depend on those described here.
+
+[:ref:`back to step-by-step guide <introprep_bissbs>`].
+
 .. _backup_bisref:
 
 Prepare for emergencies
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
   *Create a fresh backup and put system repair and restore tools at hand.*
   [:ref:`... <backup_bissbs>`]
@@ -966,7 +997,7 @@ for something going sideways, even if that should not happen.
 .. _vanilla_bisref:
 
 Remove anything related to externally maintained kernel modules
----------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Remove all software that depends on externally developed kernel drivers or
   builds them automatically.* [:ref:`...<vanilla_bissbs>`]
@@ -984,7 +1015,7 @@ explains in more detail.
 .. _secureboot_bisref:
 
 Deal with techniques like Secure Boot
--------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *On platforms with 'Secure Boot' or similar techniques, prepare everything to
   ensure the system will permit your self-compiled kernel to boot later.*
@@ -1021,7 +1052,7 @@ Afterwards, permit MokManager to reboot the machine.
 .. _bootworking_bisref:
 
 Boot the last kernel that was working
--------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Boot into the last working kernel and briefly recheck if the feature that
   regressed really works.* [:ref:`...<bootworking_bissbs>`]
@@ -1034,7 +1065,7 @@ the right thing.
 .. _diskspace_bisref:
 
 Space requirements
-------------------
+~~~~~~~~~~~~~~~~~~
 
   *Ensure to have enough free space for building Linux.*
   [:ref:`... <diskspace_bissbs>`]
@@ -1052,7 +1083,7 @@ space by quite a few gigabytes.
 .. _rangecheck_bisref:
 
 Bisection range
----------------
+~~~~~~~~~~~~~~~
 
   *Determine the kernel versions considered 'good' and 'bad' throughout this
   guide.* [:ref:`...<rangecheck_bissbs>`]
@@ -1077,7 +1108,7 @@ to do this as well, if you tried bisecting between 6.0.11 and 6.1.13.
 .. _buildrequires_bisref:
 
 Install build requirements
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Install all software required to build a Linux kernel.*
   [:ref:`...<buildrequires_bissbs>`]
@@ -1117,7 +1148,7 @@ These commands install a few packages that are often, but not always needed. You
 for example might want to skip installing the development headers for ncurses,
 which you will only need in case you later might want to adjust the kernel build
 configuration using make the targets 'menuconfig' or 'nconfig'; likewise omit
-the headers of Qt6 is you do not plan to adjust the .config using 'xconfig'.
+the headers of Qt6 if you do not plan to adjust the .config using 'xconfig'.
 
 You furthermore might need additional libraries and their development headers
 for tasks not covered in this guide -- for example when building utilities from
@@ -1128,7 +1159,7 @@ the kernel's tools/ directory.
 .. _sources_bisref:
 
 Download the sources using Git
-------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Retrieve the Linux mainline sources.*
   [:ref:`...<sources_bissbs>`]
@@ -1148,7 +1179,7 @@ work better for you:
 .. _sources_bundle_bisref:
 
 Downloading Linux mainline sources using a bundle
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""""""""""""""""""""""""""
 
 Use the following commands to retrieve the Linux mainline sources using a
 bundle::
@@ -1219,7 +1250,7 @@ Note, shallow clones have a few peculiar characteristics:
 .. _oldconfig_bisref:
 
 Start defining the build configuration for your kernel
-------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Start preparing a kernel build configuration (the '.config' file).*
   [:ref:`... <oldconfig_bissbs>`]
@@ -1279,7 +1310,7 @@ that file to the build machine and store it as ~/linux/.config; afterwards run
 .. _localmodconfig_bisref:
 
 Trim the build configuration for your kernel
---------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Disable any kernel modules apparently superfluous for your setup.*
   [:ref:`... <localmodconfig_bissbs>`]
@@ -1328,7 +1359,7 @@ step-by-step guide mentions::
 .. _tagging_bisref:
 
 Tag the kernels about to be build
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Ensure all the kernels you will build are clearly identifiable using a
   special tag and a unique version identifier.* [:ref:`... <tagging_bissbs>`]
@@ -1344,7 +1375,7 @@ confusing during the bisection.
 .. _debugsymbols_bisref:
 
 Decide to enable or disable debug symbols
------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Decide how to handle debug symbols.* [:ref:`... <debugsymbols_bissbs>`]
 
@@ -1373,7 +1404,7 @@ explains this process in more detail.
 .. _configmods_bisref:
 
 Adjust build configuration
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check if you may want or need to adjust some other kernel configuration
   options:*
@@ -1384,7 +1415,7 @@ kernel configuration options.
 .. _configmods_distros_bisref:
 
 Distro specific adjustments
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""""
 
   *Are you running* [:ref:`... <configmods_bissbs>`]
 
@@ -1409,7 +1440,7 @@ when following this guide on a few commodity distributions.
 .. _configmods_individual_bisref:
 
 Individual adjustments
-~~~~~~~~~~~~~~~~~~~~~~
+""""""""""""""""""""""
 
   *If you want to influence the other aspects of the configuration, do so
   now.* [:ref:`... <configmods_bissbs>`]
@@ -1426,13 +1457,13 @@ is missing.
 .. _saveconfig_bisref:
 
 Put the .config file aside
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Reprocess the .config after the latest changes and store it in a safe place.*
   [:ref:`... <saveconfig_bissbs>`]
 
 Put the .config you prepared aside, as you want to copy it back to the build
-directory every time  during this guide before you start building another
+directory every time during this guide before you start building another
 kernel. That's because going back and forth between different versions can alter
 .config files in odd ways; those occasionally cause side effects that could
 confuse testing or in some cases render the result of your bisection
@@ -1442,8 +1473,8 @@ meaningless.
 
 .. _introlatestcheck_bisref:
 
-Try to reproduce the regression
------------------------------------------
+Try to reproduce the problem with the latest codebase
+-----------------------------------------------------
 
   *Verify the regression is not caused by some .config change and check if it
   still occurs with the latest codebase.* [:ref:`... <introlatestcheck_bissbs>`]
@@ -1490,28 +1521,28 @@ highly recommended for these reasons:
 
   Your report might be ignored if you send it to the wrong party -- and even
   when you get a reply there is a decent chance that developers tell you to
-  evaluate   which of the two cases it is before they take a closer look.
+  evaluate which of the two cases it is before they take a closer look.
 
 [:ref:`back to step-by-step guide <introlatestcheck_bissbs>`]
 
 .. _checkoutmaster_bisref:
 
 Check out the latest Linux codebase
------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check out the latest Linux codebase.*
-  [:ref:`... <introlatestcheck_bissbs>`]
+  [:ref:`... <checkoutmaster_bissbs>`]
 
 In case you later want to recheck if an ever newer codebase might fix the
 problem, remember to run that ``git fetch --shallow-exclude [...]`` command
 again mentioned earlier to update your local Git repository.
 
-[:ref:`back to step-by-step guide <introlatestcheck_bissbs>`]
+[:ref:`back to step-by-step guide <checkoutmaster_bissbs>`]
 
 .. _build_bisref:
 
 Build your kernel
------------------
+~~~~~~~~~~~~~~~~~
 
   *Build the image and the modules of your first kernel using the config file
   you prepared.* [:ref:`... <build_bissbs>`]
@@ -1521,7 +1552,7 @@ yourself. Another subsection explains how to directly package your kernel up as
 deb, rpm or tar file.
 
 Dealing with build errors
-~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""
 
 When a build error occurs, it might be caused by some aspect of your machine's
 setup that often can be fixed quickly; other times though the problem lies in
@@ -1552,11 +1583,11 @@ by modifying your search terms or using another line from the error messages.
 
 In the end, most issues you run into have likely been encountered and
 reported by others already. That includes issues where the cause is not your
-system, but lies in the code. If you run into one of those, you might thus find a
-solution (e.g. a patch) or workaround for your issue, too.
+system, but lies in the code. If you run into one of those, you might thus find
+a solution (e.g. a patch) or workaround for your issue, too.
 
 Package your kernel up
-~~~~~~~~~~~~~~~~~~~~~~
+""""""""""""""""""""""
 
 The step-by-step guide uses the default make targets (e.g. 'bzImage' and
 'modules' on x86) to build the image and the modules of your kernel, which later
@@ -1587,7 +1618,7 @@ distribution's kernel packages.
 .. _install_bisref:
 
 Put the kernel in place
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
   *Install the kernel you just built.* [:ref:`... <install_bissbs>`]
 
@@ -1630,7 +1661,7 @@ process. Afterwards add your kernel to your bootloader configuration and reboot.
 .. _storagespace_bisref:
 
 Storage requirements per kernel
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check how much storage space the kernel, its modules, and other related files
   like the initramfs consume.* [:ref:`... <storagespace_bissbs>`]
@@ -1651,7 +1682,7 @@ need to look in different places.
 .. _tainted_bisref:
 
 Check if your newly built kernel considers itself 'tainted'
------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check if the kernel marked itself as 'tainted'.*
   [:ref:`... <tainted_bissbs>`]
@@ -1670,7 +1701,7 @@ interest, as your testing might be flawed otherwise.
 .. _recheckbroken_bisref:
 
 Check the kernel built from a recent mainline codebase
-------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Verify if your bug occurs with the newly built kernel.*
   [:ref:`... <recheckbroken_bissbs>`]
@@ -1696,7 +1727,7 @@ the kernel you built from the latest codebase. These are the most frequent:
 .. _recheckstablebroken_bisref:
 
 Check the kernel built from the latest stable/longterm codebase
----------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Are you facing a regression within a stable/longterm release, but failed to
   reproduce it with the kernel you just built using the latest mainline sources?
@@ -1741,7 +1772,7 @@ ensure the kernel version you assumed to be 'good' earlier in the process (e.g.
 .. _recheckworking_bisref:
 
 Build your own version of the 'good' kernel
--------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Build your own variant of the working kernel and check if the feature that
   regressed works as expected with it.* [:ref:`... <recheckworking_bissbs>`]
@@ -1767,15 +1798,25 @@ multitude of reasons why this might happen. Some ideas where to look:
 
 Note, if you found and fixed problems with the .config file, you want to use it
 to build another kernel from the latest codebase, as your earlier tests with
-mainline and the latest version from an affected stable/longterm series were most
-likely flawed.
+mainline and the latest version from an affected stable/longterm series were
+most likely flawed.
 
 [:ref:`back to step-by-step guide <recheckworking_bissbs>`]
 
+Perform a bisection and validate the result
+-------------------------------------------
+
+  *With all the preparations and precaution builds taken care of, you are now
+  ready to begin the bisection.* [:ref:`... <introbisect_bissbs>`]
+
+The steps in this segment perform and validate the bisection.
+
+[:ref:`back to step-by-step guide <introbisect_bissbs>`].
+
 .. _bisectstart_bisref:
 
 Start the bisection
--------------------
+~~~~~~~~~~~~~~~~~~~
 
   *Start the bisection and tell Git about the versions earlier established as
   'good' and 'bad'.* [:ref:`... <bisectstart_bissbs>`]
@@ -1789,7 +1830,7 @@ for you to test.
 .. _bisectbuild_bisref:
 
 Build a kernel from the bisection point
----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Build, install, and boot a kernel from the code Git checked out using the
   same commands you used earlier.* [:ref:`... <bisectbuild_bissbs>`]
@@ -1817,7 +1858,7 @@ There are two things worth of note here:
 .. _bisecttest_bisref:
 
 Bisection checkpoint
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
   *Check if the feature that regressed works in the kernel you just built.*
   [:ref:`... <bisecttest_bissbs>`]
@@ -1831,7 +1872,7 @@ will be for nothing.
 .. _bisectlog_bisref:
 
 Put the bisection log away
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Store Git's bisection log and the current .config file in a safe place.*
   [:ref:`... <bisectlog_bissbs>`]
@@ -1851,7 +1892,7 @@ ask for it after you report the regression.
 .. _revert_bisref:
 
 Try reverting the culprit
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Try reverting the culprit on top of the latest codebase to see if this fixes
   your regression.* [:ref:`... <revert_bissbs>`]
@@ -1869,14 +1910,20 @@ succeeds, test that kernel version instead.
 
 [:ref:`back to step-by-step guide <revert_bissbs>`]
 
+Cleanup steps during and after following this guide
+---------------------------------------------------
 
-Supplementary tasks: cleanup during and after the bisection
------------------------------------------------------------
+  *During and after following this guide you might want or need to remove some
+  of the kernels you installed.* [:ref:`... <introclosure_bissbs>`]
+
+The steps in this section describe clean-up procedures.
+
+[:ref:`back to step-by-step guide <introclosure_bissbs>`].
 
 .. _makeroom_bisref:
 
 Cleaning up during the bisection
---------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *To remove one of the kernels you installed, look up its 'kernelrelease'
   identifier.* [:ref:`... <makeroom_bissbs>`]
@@ -1917,7 +1964,7 @@ when all you want is to remove 6.0 or 6.0.1.
 [:ref:`back to step-by-step guide <makeroom_bissbs>`]
 
 Cleaning up after the bisection
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. _finishingtouch_bisref:
 
-- 
2.44.0


