Return-Path: <linux-kernel+bounces-136359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1389D315
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D466B22434
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA317EF04;
	Tue,  9 Apr 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZUPupMjS"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316B1DFC5;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=Cfw0c3eHN6tzgQlhgxBdrsXZS/ROXdMnp4Holu+vvivqGkn8Yn7X03ppbR7RxlimBtYRh9glp1mtJ+cvH6UZddKaE0olVRgcqyZFvooS6UfH65QFidwYeYpFnWoyaPL1L5G4Qs51q9ymHP9XL40oGMRPKqofFM29kSC9zE3pYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=1Uigzs4n8T6q5NRH0PxQNUhRU3AhEgvWbprYJabzC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR3KvOmnPaJZQjVRjn/UqC8pIvyH2whCzV+K58iNyT799w7PpvHGt8G9HeH+M7pruSCuEbxTCP1G/XP9w9BXnw3HiEbXPqqTbXXN2bToukhDc7FaUW3a47xeNp/2i6XrpcBUKIi8sGT4YrQkLpK1Xzwxm5MfJDJBITPzZhDkKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZUPupMjS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=AkZuZ+BSWwSPUu4Fb4xPXFyfctmZKJa+cg2LCD0xmwA=; t=1712647855;
	x=1713079855; b=ZUPupMjS+lcqwt/rz53gFXVikghL5UI3SfYJVHHPbnXNNJffBNFA7JsZCo4ut
	cvpIW5tBEJHVW5n7a/lv8m2aBhLywCwWWTeKbaLNfzuT4CUGrcmytr5IlNKAMywRyTUmspcG9YgVa
	M1hFF7ePrrW/ijuKw9rD9+omfoFu+f/s/2aP3eUGbT2pkACWYpgOGFdKA4+2XCFb7WDXG4tpDTfC5
	toanSnSS6J2XAlFppZCYWD26045KuGV3djx7RqFZts9mgpNb0eJyn1oEiarSdO1J+bRs9fGnTWooe
	gDxMTsH1dDdakwWiFTLOPBhkUc/vAigWyJldmejSzlQtku/RZw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wQ-0006Ld-8X; Tue, 09 Apr 2024 09:30:50 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 1/6] docs: verify/bisect: use git switch, tag kernel, and various fixes
Date: Tue,  9 Apr 2024 09:30:44 +0200
Message-ID: <85029aa004447b0eeb5043fb014630f2acafacec.1712647788.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1ru5wQ-0006Ld-8X

Various small improvements and fixes:

* Use the more modern 'git switch' instead of 'git checkout', which
  makes it more obvious what's happening (among others due to the
  --discard-changes parameter that is more clear than --force).

* Provide a hint how a mainline version number and one from a stable
  series look like.

* When trying to validate the bisection result with a revert, add a
  special tag to facilitate the identification.

* Sync version numbers used in various examples for consistency: stick
  to 6.0.13, 6.0.15, and 6.1.5.

* Fix a few typos and oddities.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 117 ++++++++++--------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index d3504826f40154..c999e40c79ab7f 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -38,8 +38,8 @@ aspects, all of which might be essential in your present case.]*
 **In case you want to check if a bug is present in code currently supported by
 developers**, execute just the *preparations* and *segment 1*; while doing so,
 consider the newest Linux kernel you regularly use to be the 'working' kernel.
-In the following example that's assumed to be 6.0.13, which is why the sources
-of 6.0 will be used to prepare the .config file.
+In the following example that's assumed to be 6.0, which is why its sources
+will be used to prepare the .config file.
 
 **In case you face a regression**, follow the steps at least till the end of
 *segment 2*. Then you can submit a preliminary report -- or continue with
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
@@ -240,12 +244,17 @@ to get things rolling again.
 For further details on how to report Linux kernel issues or regressions check
 out Documentation/admin-guide/reporting-issues.rst, which works in conjunction
 with this document. It among others explains why you need to verify bugs with
-the latest 'mainline' kernel, even if you face a problem with a kernel from a
-'stable/longterm' series; for users facing a regression it also explains that
-sending a preliminary report after finishing segment 2 might be wise, as the
-regression and its culprit might be known already. For further details on
-what actually qualifies as a regression check out
-Documentation/admin-guide/reporting-regressions.rst.
+the latest 'mainline' kernel (e.g. versions like 6.0, 6.1-rc1, or 6.1-rc6),
+even if you face a problem with a kernel from a 'stable/longterm' series
+(say 6.0.13).
+
+For users facing a regression that document also explains why sending a
+preliminary report after segment 2 might be wise, as the regression and its
+culprit might be known already. For further details on what actually qualifies
+as a regression check out Documentation/admin-guide/reporting-regressions.rst.
+
+If you run into any problems while following this guide or have ideas how to
+improve it, :ref:`please let the kernel developers know <submit_improvements>`.
 
 .. _introprep_bissbs:
 
@@ -286,7 +295,7 @@ Preparations: set up everything to build your own kernels
   Do you follow this guide to verify if a bug is present in the code developers
   care for? Then consider the mainline release your 'working' kernel (the newest
   one you regularly use) is based on to be the 'good' version; if your 'working'
-  kernel for example is 6.0.11, then your 'good' kernel is 6.0.
+  kernel for example is 6.0.13, then your 'good' kernel is 6.0.
 
   In case you face a regression, it depends on the version range where the
   regression was introduced:
@@ -295,14 +304,14 @@ Preparations: set up everything to build your own kernels
     6.1-rc1? Then henceforth regard 6.0 as the last known 'good' version
     and 6.1-rc1 as the first 'bad' one.
 
-  * Some function stopped working when updating from 6.0.11 to 6.1.4? Then for
-    the time being consider 6.0 as the last 'good' version and 6.1.4 as
+  * Some function stopped working when updating from 6.0.13 to 6.1.5? Then for
+    the time being consider 6.0 as the last 'good' version and 6.1.5 as
     the 'bad' one. Note, at this point it is merely assumed that 6.0 is fine;
     this assumption will be checked in segment 2.
 
-  * A feature you used in 6.0.11 does not work at all or worse in 6.1.13? In
+  * A feature you used in 6.0.13 does not work at all or worse in 6.1.15? In
     that case you want to bisect within a stable/longterm series: consider
-    6.0.11 as the last known 'good' version and 6.0.13 as the first 'bad'
+    6.0.13 as the last known 'good' version and 6.0.15 as the first 'bad'
     one. Note, in this case you still want to compile and test a mainline kernel
     as explained in segment 1: the outcome will determine if you need to report
     your issue to the regular developers or the stable team.
@@ -367,7 +376,7 @@ Preparations: set up everything to build your own kernels
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
 
@@ -505,7 +514,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 * Check out the latest Linux codebase::
 
     cd ~/linux/
-    git checkout --force --detach mainline/master
+    git switch --discard-changes --detach mainline/master
 
   [:ref:`details<checkoutmaster_bisref>`]
 
@@ -617,7 +626,7 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
     cd ~/linux/
     git remote set-branches --add stable linux-6.0.y
     git fetch stable
-    git checkout --force --detach linux-6.0.y
+    git switch --discard-changes --detach linux-6.0.y
 
   Now use the checked out code to build and install another kernel using the
   commands the earlier steps already described in more detail::
@@ -669,7 +678,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
   'good' (once again assumed to be 6.0 here)::
 
     cd ~/linux/
-    git checkout --detach v6.0
+    git switch --discard-changes --detach v6.0
 
   Now use the checked out code to configure, build, and install another kernel
   using the commands the previous subsection explained in more detail::
@@ -703,7 +712,7 @@ Segment 3: perform the bisection and validate the result
 With all the preparations and precaution builds taken care of, you are now ready
 to begin the bisection. This will make you build quite a few kernels -- usually
 about 15 in case you encountered a regression when updating to a newer series
-(say from 6.0.11 to 6.1.3). But do not worry, due to the trimmed build
+(say from 6.0.13 to 6.1.5). But do not worry, due to the trimmed build
 configuration created earlier this works a lot faster than many people assume:
 overall on average it will often just take about 10 to 15 minutes to compile
 each kernel on commodity x86 machines.
@@ -745,7 +754,7 @@ each kernel on commodity x86 machines.
   If compilation fails for some reason, run ``git bisect skip`` and restart
   executing the stack of commands from the beginning.
 
-  In case you skipped the "test latest codebase" step in the guide, check its
+  In case you skipped the 'test latest codebase' step in the guide, check its
   description as for why the 'df [...]' and 'make -s kernelrelease [...]'
   commands are here.
 
@@ -823,16 +832,16 @@ each kernel on commodity x86 machines.
   Begin by checking out the latest codebase depending on the range you bisected:
 
   * Did you face a regression within a stable/longterm series (say between
-    6.0.11 and 6.0.13) that does not happen in mainline? Then check out the
+    6.0.13 and 6.0.15) that does not happen in mainline? Then check out the
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
@@ -846,21 +855,27 @@ each kernel on commodity x86 machines.
 
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
 
   [:ref:`details<revert_bisref>`]
 
@@ -934,10 +949,12 @@ This concludes the step-by-step guide.
 
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
 
@@ -1059,18 +1076,18 @@ Bisection range
 
 Establishing the range of commits to be checked is mostly straightforward,
 except when a regression occurred when switching from a release of one stable
-series to a release of a later series (e.g. from 6.0.11 to 6.1.4). In that case
+series to a release of a later series (e.g. from 6.0.13 to 6.1.5). In that case
 Git will need some hand holding, as there is no straight line of descent.
 
 That's because with the release of 6.0 mainline carried on to 6.1 while the
 stable series 6.0.y branched to the side. It's therefore theoretically possible
-that the issue you face with 6.1.4 only worked in 6.0.11, as it was fixed by a
+that the issue you face with 6.1.5 only worked in 6.0.13, as it was fixed by a
 commit that went into one of the 6.0.y releases, but never hit mainline or the
 6.1.y series. Thankfully that normally should not happen due to the way the
 stable/longterm maintainers maintain the code. It's thus pretty safe to assume
 6.0 as a 'good' kernel. That assumption will be tested anyway, as that kernel
 will be built and tested in the segment '2' of this guide; Git would force you
-to do this as well, if you tried bisecting between 6.0.11 and 6.1.13.
+to do this as well, if you tried bisecting between 6.0.13 and 6.1.15.
 
 [:ref:`back to step-by-step guide <rangecheck_bissbs>`]
 
@@ -1117,7 +1134,7 @@ These commands install a few packages that are often, but not always needed. You
 for example might want to skip installing the development headers for ncurses,
 which you will only need in case you later might want to adjust the kernel build
 configuration using make the targets 'menuconfig' or 'nconfig'; likewise omit
-the headers of Qt6 is you do not plan to adjust the .config using 'xconfig'.
+the headers of Qt6 if you do not plan to adjust the .config using 'xconfig'.
 
 You furthermore might need additional libraries and their development headers
 for tasks not covered in this guide -- for example when building utilities from
@@ -1184,7 +1201,7 @@ First, execute the following command to retrieve the latest mainline codebase::
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
 Now deepen your clone's history to the second predecessor of the mainline
-release of your 'good' version. In case the latter are 6.0 or 6.0.11, 5.19 would
+release of your 'good' version. In case the latter are 6.0 or 6.0.13, 5.19 would
 be the first predecessor and 5.18 the second -- hence deepen the history up to
 that version::
 
@@ -1490,7 +1507,7 @@ highly recommended for these reasons:
 
   Your report might be ignored if you send it to the wrong party -- and even
   when you get a reply there is a decent chance that developers tell you to
-  evaluate   which of the two cases it is before they take a closer look.
+  evaluate which of the two cases it is before they take a closer look.
 
 [:ref:`back to step-by-step guide <introlatestcheck_bissbs>`]
 
@@ -1552,8 +1569,8 @@ by modifying your search terms or using another line from the error messages.
 
 In the end, most issues you run into have likely been encountered and
 reported by others already. That includes issues where the cause is not your
-system, but lies in the code. If you run into one of those, you might thus find a
-solution (e.g. a patch) or workaround for your issue, too.
+system, but lies in the code. If you run into one of those, you might thus find
+a solution (e.g. a patch) or workaround for your issue, too.
 
 Package your kernel up
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -1767,8 +1784,8 @@ multitude of reasons why this might happen. Some ideas where to look:
 
 Note, if you found and fixed problems with the .config file, you want to use it
 to build another kernel from the latest codebase, as your earlier tests with
-mainline and the latest version from an affected stable/longterm series were most
-likely flawed.
+mainline and the latest version from an affected stable/longterm series were
+most likely flawed.
 
 [:ref:`back to step-by-step guide <recheckworking_bissbs>`]
 
@@ -1911,7 +1928,7 @@ Now remove the boot entry for the kernel from your bootloader's configuration;
 the steps to do that vary quite a bit between Linux distributions.
 
 Note, be careful with wildcards like '*' when deleting files or directories
-for kernels manually: you might accidentally remove files of a 6.0.11 kernel
+for kernels manually: you might accidentally remove files of a 6.0.13 kernel
 when all you want is to remove 6.0 or 6.0.1.
 
 [:ref:`back to step-by-step guide <makeroom_bissbs>`]
-- 
2.44.0


