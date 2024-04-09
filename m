Return-Path: <linux-kernel+bounces-136361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975D89D323
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B36283245
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997887BAFE;
	Tue,  9 Apr 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rZYEycqh"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4A7C0AB;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=tkSH63eadaHc352RmbQaiMq30j0mSKAwPVChj8UeVWZ5LiENkCpFvPA/vVA6N5VMO8l8sZ37DKDqR1SN2G4M3uEMoudWL/cgQH72Z8KU7z9JPfoIEojJpAVsPv7OfwK8uAyfouXQXF5nCUySVM37XnwOpeehcqrBgV+D8gRZlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=eEtxTLHmaVQHaJavtnI8Gwhmf/rIFPkobr3F83J+mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU7VIXSJ/inKEukAd8DWAErawY2i/NkknftCj7oy+TkwRIEwVuAbZOYPhODstLxzMfP2vGu+Aq88Pu7pE3BDdr8fSYLssiztq74RWiuJoYsc25yKsYoiewE8SzK+C3QV7apBE8HczlTeRm5kdVamwCvynTei83+E5t0bJwi72Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rZYEycqh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ys+pFDTjHVyyCLZAJtZ5EOUWX+e08v/L7i+jg3ZPpmw=; t=1712647855;
	x=1713079855; b=rZYEycqhkydPnrgY48jzYygRqjkUbw3YmIp69kGjaKECXu4MAyV21W5ODUbQK
	vKyFS1H4zelBmgHhAmlnktKY5HXTLcmB03HYovcdaHSJC7zLdTsFdeVQ0ZQiXbB31Fe7kC+nnV6Y4
	x11fOi4Nc9FNYQMWdcet8ewx/qHDdT+KuKwUpLuqdvyuNRgb6o7dkT6ZUSMT1R/A44S0TAPups3pe
	o5DScbu3CH0eyMjov02oygmCwJxOqEs3jo6dZuFZRwwFu1jOD8GKbSU5Q2AhihH0zVmU/Z9w6J02z
	TR6TxfYP2Lu/Q+4hxE+g2QFGVGhq8sTGcoxX3SwH8wyABa2P7Q==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wQ-0006Ld-SR; Tue, 09 Apr 2024 09:30:50 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 3/6] docs: verify/bisect: proper headlines and more spacing
Date: Tue,  9 Apr 2024 09:30:46 +0200
Message-ID: <f59f0f235a2192ed93899a7338153e4cb71075f0.1712647788.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1ru5wQ-0006Ld-SR

Various small improvements and fixes:

* Separate ref links from their target with a space for better
  readability.

* Add a proper heading for the note at the end of the step-by-step
  guide.

* Use proper 3rd and 4th level headlines in the reference section and
  add short intros for the 2nd level headlines that lacked one.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 194 ++++++++++--------
 1 file changed, 113 insertions(+), 81 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 06278501a4bdcc..355c2cea5230d9 100644
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
@@ -224,15 +224,15 @@ report; instead of the latter your could also head straight on and follow
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
@@ -260,12 +260,14 @@ improve it, :ref:`please let the kernel developers know <submit_improvements>`.
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
 
@@ -273,7 +275,7 @@ Preparations: set up everything to build your own kernels
   builds them automatically. That includes but is not limited to DKMS, openZFS,
   VirtualBox, and Nvidia's graphics drivers (including the GPLed kernel module).
 
-  [:ref:`details<vanilla_bisref>`]
+  [:ref:`details <vanilla_bisref>`]
 
 .. _secureboot_bissbs:
 
@@ -284,7 +286,7 @@ Preparations: set up everything to build your own kernels
   their restrictions through a process initiated by
   ``mokutil --disable-validation``.
 
-  [:ref:`details<secureboot_bisref>`]
+  [:ref:`details <secureboot_bisref>`]
 
 .. _rangecheck_bissbs:
 
@@ -319,13 +321,13 @@ Preparations: set up everything to build your own kernels
   throughout this guide will refer to the last kernel that has been working
   fine.*
 
-  [:ref:`details<rangecheck_bisref>`]
+  [:ref:`details <rangecheck_bisref>`]
 
 .. _bootworking_bissbs:
 
 * Boot into the 'working' kernel and briefly use the apparently broken feature.
 
-  [:ref:`details<bootworking_bisref>`]
+  [:ref:`details <bootworking_bisref>`]
 
 .. _diskspace_bissbs:
 
@@ -335,7 +337,7 @@ Preparations: set up everything to build your own kernels
   debug symbols: both explain approaches reducing the amount of space, which
   should allow you to master these tasks with about 4 Gigabytes free space.
 
-  [:ref:`details<diskspace_bisref>`]
+  [:ref:`details <diskspace_bisref>`]
 
 .. _buildrequires_bissbs:
 
@@ -345,7 +347,7 @@ Preparations: set up everything to build your own kernels
   reference section shows how to quickly install those on various popular Linux
   distributions.
 
-  [:ref:`details<buildrequires_bisref>`]
+  [:ref:`details <buildrequires_bisref>`]
 
 .. _sources_bissbs:
 
@@ -368,7 +370,7 @@ Preparations: set up everything to build your own kernels
     git remote add -t master stable \
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
-  [:ref:`details<sources_bisref>`]
+  [:ref:`details <sources_bisref>`]
 
 .. _stablesources_bissbs:
 
@@ -421,7 +423,7 @@ Preparations: set up everything to build your own kernels
   'make olddefconfig' again and check if it now picked up the right config file
   as base.
 
-  [:ref:`details<oldconfig_bisref>`]
+  [:ref:`details <oldconfig_bisref>`]
 
 .. _localmodconfig_bissbs:
 
@@ -455,7 +457,7 @@ Preparations: set up everything to build your own kernels
   spending much effort on, as long as it boots and allows to properly test the
   feature that causes trouble.
 
-  [:ref:`details<localmodconfig_bisref>`]
+  [:ref:`details <localmodconfig_bisref>`]
 
 .. _tagging_bissbs:
 
@@ -465,7 +467,7 @@ Preparations: set up everything to build your own kernels
     ./scripts/config --set-str CONFIG_LOCALVERSION '-local'
     ./scripts/config -e CONFIG_LOCALVERSION_AUTO
 
-  [:ref:`details<tagging_bisref>`]
+  [:ref:`details <tagging_bisref>`]
 
 .. _debugsymbols_bissbs:
 
@@ -484,7 +486,7 @@ Preparations: set up everything to build your own kernels
     ./scripts/config -d DEBUG_INFO -d DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
       -d DEBUG_INFO_DWARF4 -d DEBUG_INFO_DWARF5 -e CONFIG_DEBUG_INFO_NONE
 
-  [:ref:`details<debugsymbols_bisref>`]
+  [:ref:`details <debugsymbols_bisref>`]
 
 .. _configmods_bissbs:
 
@@ -494,14 +496,14 @@ Preparations: set up everything to build your own kernels
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
 
@@ -511,7 +513,7 @@ Preparations: set up everything to build your own kernels
      make olddefconfig
      cp .config ~/kernel-config-working
 
-  [:ref:`details<saveconfig_bisref>`]
+  [:ref:`details <saveconfig_bisref>`]
 
 .. _introlatestcheck_bissbs:
 
@@ -521,7 +523,7 @@ Segment 1: try to reproduce the problem with the latest codebase
 The following steps verify if the problem occurs with the code currently
 supported by developers. In case you face a regression, it also checks that the
 problem is not caused by some .config change, as reporting the issue then would
-be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
+be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
 
 .. _checkoutmaster_bissbs:
 
@@ -530,7 +532,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
     cd ~/linux/
     git switch --discard-changes --detach mainline/master
 
-  [:ref:`details<checkoutmaster_bisref>`]
+  [:ref:`details <checkoutmaster_bisref>`]
 
 .. _build_bissbs:
 
@@ -545,7 +547,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   reference section for alternatives, which obviously will require other
   steps to install as well.
 
-  [:ref:`details<build_bisref>`]
+  [:ref:`details <build_bisref>`]
 
 .. _install_bissbs:
 
@@ -578,7 +580,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   down: if you will build more kernels as described in segment 2 and 3, you will
   have to perform those again after executing ``command -v installkernel [...]``.
 
-  [:ref:`details<install_bisref>`]
+  [:ref:`details <install_bisref>`]
 
 .. _storagespace_bissbs:
 
@@ -591,7 +593,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   Write down or remember those two values for later: they enable you to prevent
   running out of disk space accidentally during a bisection.
 
-  [:ref:`details<storagespace_bisref>`]
+  [:ref:`details <storagespace_bisref>`]
 
 .. _kernelrelease_bissbs:
 
@@ -618,7 +620,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   If that command does not return '0', check the reference section, as the cause
   for this might interfere with your testing.
 
-  [:ref:`details<tainted_bisref>`]
+  [:ref:`details <tainted_bisref>`]
 
 .. _recheckbroken_bissbs:
 
@@ -626,7 +628,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   out the instructions in the reference section to ensure nothing went sideways
   during your tests.
 
-  [:ref:`details<recheckbroken_bisref>`]
+  [:ref:`details <recheckbroken_bisref>`]
 
 .. _recheckstablebroken_bissbs:
 
@@ -662,12 +664,12 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 
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
@@ -679,7 +681,7 @@ Segment 2: check if the kernels you build work fine
 
 In case of a regression, you now want to ensure the trimmed configuration file
 you created earlier works as expected; a bisection with the .config file
-otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
+otherwise would be a waste of time. [:ref:`details <introworkingcheck_bisref>`]
 
 .. _recheckworking_bissbs:
 
@@ -714,7 +716,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
   Now check if this kernel works as expected; if not, consult the reference
   section for further instructions.
 
-  [:ref:`details<recheckworking_bisref>`]
+  [:ref:`details <recheckworking_bisref>`]
 
 .. _introbisect_bissbs:
 
@@ -739,7 +741,7 @@ each kernel on commodity x86 machines.
     git bisect good v6.0
     git bisect bad v6.1.5
 
-  [:ref:`details<bisectstart_bisref>`]
+  [:ref:`details <bisectstart_bisref>`]
 
 .. _bisectbuild_bissbs:
 
@@ -768,7 +770,7 @@ each kernel on commodity x86 machines.
   totally normal to see release identifiers like '6.0-rc1-local-gcafec0cacaca0'
   if you bisect between versions 6.1 and 6.2 for example.
 
-  [:ref:`details<bisectbuild_bisref>`]
+  [:ref:`details <bisectbuild_bisref>`]
 
 .. _bisecttest_bissbs:
 
@@ -808,7 +810,7 @@ each kernel on commodity x86 machines.
   might need to scroll up to see the message mentioning the culprit;
   alternatively, run ``git bisect log > ~/bisection-log``.
 
-  [:ref:`details<bisecttest_bisref>`]
+  [:ref:`details <bisecttest_bisref>`]
 
 .. _bisectlog_bissbs:
 
@@ -820,7 +822,7 @@ each kernel on commodity x86 machines.
     cp .config ~/bisection-config-culprit
     git bisect reset
 
-  [:ref:`details<bisectlog_bisref>`]
+  [:ref:`details <bisectlog_bisref>`]
 
 .. _revert_bissbs:
 
@@ -882,7 +884,7 @@ each kernel on commodity x86 machines.
   Now check one last time if the feature that made you perform a bisection works
   with that kernel: if everything went well, it should not show the regression.
 
-  [:ref:`details<revert_bisref>`]
+  [:ref:`details <revert_bisref>`]
 
 .. _introclosure_bissbs:
 
@@ -923,7 +925,7 @@ space might run out.
   kernel image and related files behind; in that case remove them as described
   in the reference section.
 
-  [:ref:`details<makeroom_bisref>`]
+  [:ref:`details <makeroom_bisref>`]
 
 .. _finishingtouch_bissbs:
 
@@ -946,11 +948,15 @@ space might run out.
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
@@ -970,10 +976,20 @@ Reference section for the step-by-step guide
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
@@ -988,7 +1004,7 @@ for something going sideways, even if that should not happen.
 .. _vanilla_bisref:
 
 Remove anything related to externally maintained kernel modules
----------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Remove all software that depends on externally developed kernel drivers or
   builds them automatically.* [:ref:`...<vanilla_bissbs>`]
@@ -1006,7 +1022,7 @@ explains in more detail.
 .. _secureboot_bisref:
 
 Deal with techniques like Secure Boot
--------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *On platforms with 'Secure Boot' or similar techniques, prepare everything to
   ensure the system will permit your self-compiled kernel to boot later.*
@@ -1043,7 +1059,7 @@ Afterwards, permit MokManager to reboot the machine.
 .. _bootworking_bisref:
 
 Boot the last kernel that was working
--------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Boot into the last working kernel and briefly recheck if the feature that
   regressed really works.* [:ref:`...<bootworking_bissbs>`]
@@ -1056,7 +1072,7 @@ the right thing.
 .. _diskspace_bisref:
 
 Space requirements
-------------------
+~~~~~~~~~~~~~~~~~~
 
   *Ensure to have enough free space for building Linux.*
   [:ref:`... <diskspace_bissbs>`]
@@ -1074,7 +1090,7 @@ space by quite a few gigabytes.
 .. _rangecheck_bisref:
 
 Bisection range
----------------
+~~~~~~~~~~~~~~~
 
   *Determine the kernel versions considered 'good' and 'bad' throughout this
   guide.* [:ref:`...<rangecheck_bissbs>`]
@@ -1099,7 +1115,7 @@ to do this as well, if you tried bisecting between 6.0.13 and 6.1.15.
 .. _buildrequires_bisref:
 
 Install build requirements
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Install all software required to build a Linux kernel.*
   [:ref:`...<buildrequires_bissbs>`]
@@ -1150,7 +1166,7 @@ the kernel's tools/ directory.
 .. _sources_bisref:
 
 Download the sources using Git
-------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Retrieve the Linux mainline sources.*
   [:ref:`...<sources_bissbs>`]
@@ -1170,7 +1186,7 @@ work better for you:
 .. _sources_bundle_bisref:
 
 Downloading Linux mainline sources using a bundle
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""""""""""""""""""""""""""
 
 Use the following commands to retrieve the Linux mainline sources using a
 bundle::
@@ -1241,7 +1257,7 @@ Note, shallow clones have a few peculiar characteristics:
 .. _oldconfig_bisref:
 
 Start defining the build configuration for your kernel
-------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Start preparing a kernel build configuration (the '.config' file).*
   [:ref:`... <oldconfig_bissbs>`]
@@ -1301,7 +1317,7 @@ that file to the build machine and store it as ~/linux/.config; afterwards run
 .. _localmodconfig_bisref:
 
 Trim the build configuration for your kernel
---------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Disable any kernel modules apparently superfluous for your setup.*
   [:ref:`... <localmodconfig_bissbs>`]
@@ -1350,7 +1366,7 @@ step-by-step guide mentions::
 .. _tagging_bisref:
 
 Tag the kernels about to be build
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Ensure all the kernels you will build are clearly identifiable using a
   special tag and a unique version identifier.* [:ref:`... <tagging_bissbs>`]
@@ -1366,7 +1382,7 @@ confusing during the bisection.
 .. _debugsymbols_bisref:
 
 Decide to enable or disable debug symbols
------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Decide how to handle debug symbols.* [:ref:`... <debugsymbols_bissbs>`]
 
@@ -1395,7 +1411,7 @@ explains this process in more detail.
 .. _configmods_bisref:
 
 Adjust build configuration
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check if you may want or need to adjust some other kernel configuration
   options:*
@@ -1406,7 +1422,7 @@ kernel configuration options.
 .. _configmods_distros_bisref:
 
 Distro specific adjustments
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""""
 
   *Are you running* [:ref:`... <configmods_bissbs>`]
 
@@ -1431,7 +1447,7 @@ when following this guide on a few commodity distributions.
 .. _configmods_individual_bisref:
 
 Individual adjustments
-~~~~~~~~~~~~~~~~~~~~~~
+""""""""""""""""""""""
 
   *If you want to influence the other aspects of the configuration, do so
   now.* [:ref:`... <configmods_bissbs>`]
@@ -1448,13 +1464,13 @@ is missing.
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
@@ -1464,8 +1480,8 @@ meaningless.
 
 .. _introlatestcheck_bisref:
 
-Try to reproduce the regression
------------------------------------------
+Try to reproduce the problem with the latest codebase
+-----------------------------------------------------
 
   *Verify the regression is not caused by some .config change and check if it
   still occurs with the latest codebase.* [:ref:`... <introlatestcheck_bissbs>`]
@@ -1519,21 +1535,21 @@ highly recommended for these reasons:
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
@@ -1543,7 +1559,7 @@ yourself. Another subsection explains how to directly package your kernel up as
 deb, rpm or tar file.
 
 Dealing with build errors
-~~~~~~~~~~~~~~~~~~~~~~~~~
+"""""""""""""""""""""""""
 
 When a build error occurs, it might be caused by some aspect of your machine's
 setup that often can be fixed quickly; other times though the problem lies in
@@ -1578,7 +1594,7 @@ system, but lies in the code. If you run into one of those, you might thus find
 a solution (e.g. a patch) or workaround for your issue, too.
 
 Package your kernel up
-~~~~~~~~~~~~~~~~~~~~~~
+""""""""""""""""""""""
 
 The step-by-step guide uses the default make targets (e.g. 'bzImage' and
 'modules' on x86) to build the image and the modules of your kernel, which later
@@ -1609,7 +1625,7 @@ distribution's kernel packages.
 .. _install_bisref:
 
 Put the kernel in place
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
   *Install the kernel you just built.* [:ref:`... <install_bissbs>`]
 
@@ -1652,7 +1668,7 @@ process. Afterwards add your kernel to your bootloader configuration and reboot.
 .. _storagespace_bisref:
 
 Storage requirements per kernel
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check how much storage space the kernel, its modules, and other related files
   like the initramfs consume.* [:ref:`... <storagespace_bissbs>`]
@@ -1673,7 +1689,7 @@ need to look in different places.
 .. _tainted_bisref:
 
 Check if your newly built kernel considers itself 'tainted'
------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Check if the kernel marked itself as 'tainted'.*
   [:ref:`... <tainted_bissbs>`]
@@ -1692,7 +1708,7 @@ interest, as your testing might be flawed otherwise.
 .. _recheckbroken_bisref:
 
 Check the kernel built from a recent mainline codebase
-------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Verify if your bug occurs with the newly built kernel.*
   [:ref:`... <recheckbroken_bissbs>`]
@@ -1718,7 +1734,7 @@ the kernel you built from the latest codebase. These are the most frequent:
 .. _recheckstablebroken_bisref:
 
 Check the kernel built from the latest stable/longterm codebase
----------------------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Are you facing a regression within a stable/longterm release, but failed to
   reproduce it with the kernel you just built using the latest mainline sources?
@@ -1763,7 +1779,7 @@ ensure the kernel version you assumed to be 'good' earlier in the process (e.g.
 .. _recheckworking_bisref:
 
 Build your own version of the 'good' kernel
--------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Build your own variant of the working kernel and check if the feature that
   regressed works as expected with it.* [:ref:`... <recheckworking_bissbs>`]
@@ -1794,10 +1810,20 @@ most likely flawed.
 
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
@@ -1811,7 +1837,7 @@ for you to test.
 .. _bisectbuild_bisref:
 
 Build a kernel from the bisection point
----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Build, install, and boot a kernel from the code Git checked out using the
   same commands you used earlier.* [:ref:`... <bisectbuild_bissbs>`]
@@ -1839,7 +1865,7 @@ There are two things worth of note here:
 .. _bisecttest_bisref:
 
 Bisection checkpoint
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
   *Check if the feature that regressed works in the kernel you just built.*
   [:ref:`... <bisecttest_bissbs>`]
@@ -1853,7 +1879,7 @@ will be for nothing.
 .. _bisectlog_bisref:
 
 Put the bisection log away
---------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Store Git's bisection log and the current .config file in a safe place.*
   [:ref:`... <bisectlog_bissbs>`]
@@ -1873,7 +1899,7 @@ ask for it after you report the regression.
 .. _revert_bisref:
 
 Try reverting the culprit
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
   *Try reverting the culprit on top of the latest codebase to see if this fixes
   your regression.* [:ref:`... <revert_bissbs>`]
@@ -1891,14 +1917,20 @@ succeeds, test that kernel version instead.
 
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
@@ -1939,7 +1971,7 @@ when all you want is to remove 6.0 or 6.0.1.
 [:ref:`back to step-by-step guide <makeroom_bissbs>`]
 
 Cleaning up after the bisection
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. _finishingtouch_bisref:
 
-- 
2.44.0


