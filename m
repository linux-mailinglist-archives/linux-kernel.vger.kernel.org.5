Return-Path: <linux-kernel+bounces-136358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D92789D31A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C471C215E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C57E77B;
	Tue,  9 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HZquhLkV"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AA7BAFE;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=ZKgsvupKV+F8TWpNZwFbXKxEQBj1+FPfCq2U8fkMnboiDqB02WZkCPJYIFZBpob5T1JQxoQEPkZitOQpFGkaf0ZoRbkapz7ijAweJkNrEhld2TyzeDMIcvswRwGUxbLgBBgW5Sibu4Z66UuZ8sLiabacRFAOCWUZZzs49LxXL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=j4STcrPuuHe6kQK78UyT+7uWG0z053vYmOT+DzSljc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQDqU65Mx1vfC86alXYOjxRP5phiG4NsSOFjPOJGNGXwf7f3LcRK+PbOS59wckdq0yNFeBpp0LVquSKvqB/gkpKzaFoT0LFcnI1ODoqUGOtEqu3aDQjDAk2UTXB57pzLj2pHkofmmNF/ATQdFPVEJ9bqrHP+WWe3vADEZW5an2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HZquhLkV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=LGeHfhhpbX0NVOpB0WHhcEnxl/s/Lvh5IZ1Wpx5G0xY=; t=1712647855;
	x=1713079855; b=HZquhLkVzd1582+mrANxa+lFQZY0BrVsFfvIINnOBWD/HER7bPjXZCcX72yGq
	a76cdVIs+LJnJcgV5VymzRPuC8ZBTnHcL3pSLpSSL0AXTwdBcVs/KaNOzpoY4N/lR38xonLRvdhqk
	nS9ZcuPHcaq5uSjgwoY0fxZnPR7pXTkSiZiuqMipjhqI1O/wG1/5FcdMEM8IwxY8TCGOyCAYLWqa4
	7cIlA1fY2KlUAIwH3gI4q2C9R+OLbBvPh5sngAWkOB+6yJ/ntr5RPAIGeVUIqUfqjZiSndvoNrVh2
	Zj1A26eb9uAYVRs8rQEJia2jSpjJyaItkE1naC7YXyJqHS1q+Q==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wR-0006Ld-6C; Tue, 09 Apr 2024 09:30:51 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 4/6] docs: verify/bisect: explain testing reverts, patches and newer code
Date: Tue,  9 Apr 2024 09:30:47 +0200
Message-ID: <dacf26a4c48e9e8f04ecbc77e0a74c9b2a6a1103.1712647788.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1ru5wR-0006Ld-6C

Rename 'Supplementary tasks' to 'Complementary tasks' while introducing
a section 'Optional tasks: test reverts, patches, or later versions':
the latter is something readers occasionally will have to do after
reporting a bug and thus is best covered here.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 128 ++++++++++++++++--
 1 file changed, 115 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 355c2cea5230d9..1987c827211fce 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -160,7 +160,7 @@ will be considered the 'good' release and used to prepare the .config file.
      this step (e.g. build, install, boot, and test a kernel to then tell Git
      the outcome). Do so again and again until Git shows which commit broke
      things. If you run short of disk space during this process, check the
-     section 'Supplementary tasks: cleanup during and after the process'
+     section 'Complementary tasks: cleanup during and after the process'
      below.
 
   d) Once your finished the bisection, put a few things away::
@@ -182,7 +182,7 @@ will be considered the 'good' release and used to prepare the .config file.
     kernel; just this time skip the first command copying the base .config file
     over, as that already has been taken care off.
 
-* **Supplementary tasks**: cleanup during and after the process.
+* **Complementary tasks**: cleanup during and after the process.
 
   a) To avoid running out of disk space during a bisection, you might need to
      remove some kernels you built earlier. You most likely want to keep those
@@ -205,6 +205,18 @@ will be considered the 'good' release and used to prepare the .config file.
      the kernels you built earlier and later you might want to keep around for
      a week or two.
 
+* **Optional task**: test a debug patch or a proposed fix later::
+
+    git fetch mainline
+    git switch --discard-changes --detach mainline/master
+    git apply /tmp/foobars-proposed-fix-v1.patch
+    cp ~/kernel-config-working .config
+    ./scripts/config --set-str CONFIG_LOCALVERSION '-local-foobars-fix-v1'
+
+  Build, install, and boot a kernel as described in *segment 1, section b* --
+  but this time omit the first command copying the build configuration over,
+  as that has been taken care of already.
+
 .. _introguide_bissbs:
 
 Step-by-step guide on how to verify bugs and bisect regressions
@@ -232,7 +244,9 @@ developers are obliged to act upon.
 
  :ref:`Segment 3: perform a bisection and validate the result <introbisect_bissbs>`.
 
- :ref:`Supplementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
+ :ref:`Complementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
+
+ :ref:`Optional tasks: test reverts, patches, or later versions <introoptional_bissbs>`.
 
 The steps in each segment illustrate the important aspects of the process, while
 a comprehensive reference section holds additional details for almost all of the
@@ -669,7 +683,7 @@ be a waste of time. [:ref:`details <introlatestcheck_bisref>`]
 Do you follow this guide to verify if a problem is present in the code
 currently supported by Linux kernel developers? Then you are done at this
 point. If you later want to remove the kernel you just built, check out
-:ref:`Supplementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
+:ref:`Complementary tasks: cleanup during and after following this guide <introclosure_bissbs>`.
 
 In case you face a regression, move on and execute at least the next segment
 as well.
@@ -888,7 +902,7 @@ each kernel on commodity x86 machines.
 
 .. _introclosure_bissbs:
 
-Supplementary tasks: cleanup during and after the bisection
+Complementary tasks: cleanup during and after the bisection
 -----------------------------------------------------------
 
 During and after following this guide you might want or need to remove some of
@@ -950,6 +964,81 @@ space might run out.
 
   [:ref:`details <finishingtouch_bisref>`]
 
+.. _introoptional_bissbs:
+
+Optional: test reverts, patches, or later versions
+--------------------------------------------------
+
+While or after reporting a bug, you might want or potentially will be asked to
+test reverts, debug patches, proposed fixes, or other versions. In that case
+follow these instructions.
+
+* Update your Git clone and check out the latest code.
+
+  * In case you want to test mainline, fetch its latest changes before checking
+    its code out::
+
+      git fetch mainline
+      git switch --discard-changes --detach mainline/master
+
+  * In case you want to test a stable or longterm kernel, first add the branch
+    holding the series you are interested in (6.2 in the example), unless you
+    already did so earlier::
+
+      git remote set-branches --add stable linux-6.2.y
+
+    Then fetch the latest changes and check out the latest version from the
+    series::
+
+      git fetch stable
+      git switch --discard-changes --detach stable/linux-6.2.y
+
+* Copy your kernel build configuration over::
+
+    cp ~/kernel-config-working .config
+
+* Your next step depends on what you want to do:
+
+  * In case you just want to test the latest codebase, head to the next step,
+    you are already all set.
+
+  * In case you want to test if a revert fixes an issue, revert one or multiple
+    changes by specifying their commit ids::
+
+      git revert --no-edit cafec0cacaca0
+
+    Now give that kernel a special tag to facilitates its identification and
+    prevent accidentally overwriting another kernel::
+
+      ./scripts/config --set-str CONFIG_LOCALVERSION '-local-cafec0cacaca0-reverted'
+
+  * In case you want to test a patch, store the patch in a file like
+    '/tmp/foobars-proposed-fix-v1.patch' and apply it like this::
+
+      git apply /tmp/foobars-proposed-fix-v1.patch
+
+    In case of multiple patches, repeat this step with the others.
+
+    Now give that kernel a special tag to facilitates its identification and
+    prevent accidentally overwriting another kernel::
+
+    ./scripts/config --set-str CONFIG_LOCALVERSION '-local-foobars-fix-v1'
+
+* Build a kernel using the familiar commands, just without copying the kernel
+  build configuration over, as that has been taken care of already::
+
+    make olddefconfig &&
+    make -j $(nproc --all)
+    # * Check if the free space suffices holding another kernel:
+    df -h /boot/ /lib/modules/
+    sudo make modules_install
+    command -v installkernel && sudo make install
+    make -s kernelrelease | tee -a ~/kernels-built
+    reboot
+
+* Now verify you booted the newly built kernel and check it.
+
+[:ref:`details <introoptional_bisref>`]
 
 .. _submit_improvements:
 
@@ -1986,20 +2075,33 @@ build artifacts and the Linux sources, but will leave the Git repository
 (~/linux/.git/) behind -- a simple ``git reset --hard`` thus will bring the
 sources back.
 
-Removing the repository as well would likely be unwise at this point: there is a
-decent chance developers will ask you to build another kernel to perform
-additional tests. This is often required to debug an issue or check proposed
-fixes. Before doing so you want to run the ``git fetch mainline`` command again
-followed by ``git checkout mainline/master`` to bring your clone up to date and
-checkout the latest codebase. Then apply the patch using ``git apply
-<filename>`` or ``git am <filename>`` and build yet another kernel using the
-familiar commands.
+Removing the repository as well would likely be unwise at this point: there
+is a decent chance developers will ask you to build another kernel to
+perform additional tests -- like testing a debug patch or a proposed fix.
+Details on how to perform those can be found in the section :ref:`Optional
+tasks: test reverts, patches, or later versions <introoptional_bissbs>`.
 
 Additional tests are also the reason why you want to keep the
 ~/kernel-config-working file around for a few weeks.
 
 [:ref:`back to step-by-step guide <finishingtouch_bissbs>`]
 
+.. _introoptional_bisref:
+
+Test reverts, patches, or later versions
+----------------------------------------
+
+  *While or after reporting a bug, you might want or potentially will be asked
+  to test reverts, patches, proposed fixes, or other versions.*
+  [:ref:`... <introoptional_bissbs>`]
+
+All the commands used in this section should be pretty straight forward, so
+there is not much to add except one thing: when setting a kernel tag as
+instructed, ensure it is not much longer than the one used in the example, as
+problems will arise if the kernelrelease identifier exceeds 63 characters.
+
+[:ref:`back to step-by-step guide <introoptional_bissbs>`].
+
 
 Additional reading material
 ===========================
-- 
2.44.0


