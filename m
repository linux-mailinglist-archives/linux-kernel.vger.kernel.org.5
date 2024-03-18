Return-Path: <linux-kernel+bounces-105823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258687E512
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828831F2158D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2428E22;
	Mon, 18 Mar 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pD4wPo0D"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B7208DA;
	Mon, 18 Mar 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751134; cv=none; b=YQ1C7raw173v99w9mm/i+RXZPJ0Cz3jNrOv2RHpBYIUU1/nvDqf6ujh2YDC1wTY9BlsAXRz0vh1cj0goMqNZsilRo/rKJvV7ayPDKAGBdHeAedBPPMOmp53HLnlniSQJfIQmaiuNXPWWb39a1LpelnMHov+ec8Qp8lH3mU7lZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751134; c=relaxed/simple;
	bh=jPOEPcPtHmMeRW17S07f82zR9TS5EX8M8vC1ukw1exg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb8ITvmen4My6gly1ExxoOA29HLvDvW1851Ywgh2xsQST0h1thKUrQFuA1dLbjhbiHbvBJG6CFW7r1xq04TgP7Spo8oTuReXZUtgpMO/pErY3ham+8MdfEbRhbkZRdgCOQdyfvfSNZihW9z163JvMx4FFlFEY0dvysDrUe/VrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pD4wPo0D; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sj1P2/uYIgaCM4YUvEX1RItBfNAnbFCohl8vswtNoXc=; t=1710751131;
	x=1711183131; b=pD4wPo0D/WL4fAxytkmGriHzNUlyJyel6zS1AYbVMuAuEptvEslmhSH8l9c0A
	gqfVEyaz5C8BDFdgB/AMFgaq+rV+TO0hE4oFgSvs9m56WVEz98QVBEPqfZBkx8v6AFcDYOoYJCFl2
	CutROpg23Y+SBXE99ib0S40z9ZJlEbyZDg4tXwTZIqt/C/7DXzkjt1iF73ZCQIgwaW/WWouMmWiMt
	93y1VbYXJiBZk3+HEvpPrxPBAl/fxAqmToSyqr1sQPVFL/e7/0oKr8+x4Va9TNPfPr5Rfot9hV1SE
	qLteuuW3giPXm58/AV6zbWjfcc7QQhtkMbaNXpdBk24Pu5dplQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rm8W0-00037E-Ic; Mon, 18 Mar 2024 09:38:40 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 1/4] docs: verify/bisect: improve install instructions
Date: Mon, 18 Mar 2024 09:38:36 +0100
Message-ID: <e392bd5eb12654bed635f32b24304a712b0c67d1.1710750972.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1rm8W0-00037E-Ic

These changes among others ensure modules will be installed when
/sbin/installkernel is missing. Furthermore describe better what tasks
the script ideally performs so that users can more easily check if those
have been taken care of. In addition to that point to the distro's
documentation for further details on installing kernels manually.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 122 ++++++++----------
 1 file changed, 57 insertions(+), 65 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 58211840ac6ffb..fb82118bb011b9 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -99,7 +99,8 @@ will be considered the 'good' release and used to prepare the .config file.
        # * Note: on Arch Linux, its derivatives and a few other distributions
        #   the following commands will do nothing at all or only part of the
        #   job. See the step-by-step guide for further details.
-       command -v installkernel && sudo make modules_install install
+       sudo make modules_install
+       command -v installkernel && sudo make install
        # * Check how much space your self-built kernel actually needs, which
        #   enables you to make better estimates later:
        du -ch /boot/*$(make -s kernelrelease)* | tail -n 1
@@ -520,44 +521,32 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 
 * Install your newly built kernel.
 
-  Before doing so, consider checking if there is still enough room for it::
+  Before doing so, consider checking if there is still enough space for it::
 
     df -h /boot/ /lib/modules/
 
-  150 MByte in /boot/ and 200 in /lib/modules/ usually suffice. Those are rough
-  estimates assuming the worst case. How much your kernels actually require will
-  be determined later.
+  For now assume 150 MByte in /boot/ and 200 in /lib/modules/ will suffice; how
+  much your kernels actually require will be determined later during this guide.
 
-  Now install the kernel, which will be saved in parallel to the kernels from
-  your Linux distribution::
+  Now install the kernel's modules and its image, which will be stored in
+  parallel to the your Linux distribution's kernels::
 
-    command -v installkernel && sudo make modules_install install
+    sudo make modules_install
+    command -v installkernel && sudo make install
 
-  On many commodity Linux distributions this will take care of everything
-  required to boot your kernel. You might want to ensure that's the case by
-  checking if your boot loader's configuration was updated; furthermore ensure
-  an initramfs (also known as initrd) exists, which on many distributions can be
-  achieved by running ``ls -l /boot/init*$(make -s kernelrelease)*``. Those
-  steps are recommended, as there are quite a few Linux distribution where above
-  command is insufficient:
+  The second command ideally will take care of three steps required at this
+  point: copying the kernel's image to /boot/, generating an initramfs, and
+  adding an entry for both to the boot loader's configuration.
 
-  * On Arch Linux, its derivatives, many immutable Linux distributions, and a
-    few others the above command does nothing at, as they lack 'installkernel'
-    executable.
+  Sadly some distributions (among them Arch Linux, its derivatives, and many
+  immutable Linux distributions) will perform none or only some of those tasks.
+  You therefore want to check if all of them were taken care of and manually
+  perform those that were not. The reference section provides further details on
+  that; your distribution's documentation might help, too.
 
-  * Some distributions install the kernel, but don't add an entry for your
-    kernel in your boot loader's configuration -- the kernel thus won't show up
-    in the boot menu.
-
-  * Some distributions add a boot loader menu entry, but don't create an
-    initramfs on installation -- in that case your kernel most likely will be
-    unable to mount the root partition during bootup.
-
-  If any of that applies to you, see the reference section for further guidance.
-  Once you figured out what to do, consider writing down the necessary
-  installation steps: if you will build more kernels as described in
-  segment 2 and 3, you will have to execute these commands every time that
-  ``command -v installkernel [...]`` comes up again.
+  Once you figured out the steps needed at this point, consider writing them
+  down: if you will build more kernels as described in segment 2 and 3, you will
+  have to perform those again after executing ``command -v installkernel [...]``.
 
   [:ref:`details<install_bisref>`]
 
@@ -622,7 +611,8 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
     make -j $(nproc --all)
     # * Check if the free space suffices holding another kernel:
     df -h /boot/ /lib/modules/
-    command -v installkernel && sudo make modules_install install
+    sudo make modules_install
+    command -v installkernel && sudo make install
     make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
@@ -670,7 +660,8 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
     make -j $(nproc --all)
     # * Check if the free space suffices holding another kernel:
     df -h /boot/ /lib/modules/
-    command -v installkernel && sudo make modules_install install
+    sudo make modules_install
+    command -v installkernel && sudo make install
     make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
@@ -727,7 +718,8 @@ each kernel on commodity x86 machines.
     make -j $(nproc --all)
     # * Check if the free space suffices holding another kernel:
     df -h /boot/ /lib/modules/
-    command -v installkernel && sudo make modules_install install
+    sudo make modules_install
+    command -v installkernel && sudo make install
     make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
@@ -843,7 +835,8 @@ each kernel on commodity x86 machines.
     make -j $(nproc --all) &&
     # * Check if the free space suffices holding another kernel:
     df -h /boot/ /lib/modules/
-    command -v installkernel && sudo make modules_install install
+    sudo make modules_install
+    command -v installkernel && sudo make install
     Make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
@@ -1580,39 +1573,38 @@ Put the kernel in place
   *Install the kernel you just built.* [:ref:`... <install_bissbs>`]
 
 What you need to do after executing the command in the step-by-step guide
-depends on the existence and the implementation of an ``installkernel``
-executable. Many commodity Linux distributions ship such a kernel installer in
-'/sbin/' that does everything needed, hence there is nothing left for you
-except rebooting. But some distributions contain an installkernel that does
-only part of the job -- and a few lack it completely and leave all the work to
-you.
-
-If ``installkernel`` is found, the kernel's build system will delegate the
-actual installation of your kernel's image and related files to this executable.
-On almost all Linux distributions it will store the image as '/boot/vmlinuz-
-<kernelrelease identifier>' and put a 'System.map-<kernelrelease
-identifier>' alongside it. Your kernel will thus be installed in parallel to any
-existing ones, unless you already have one with exactly the same release name.
-
-Installkernel on many distributions will afterwards generate an 'initramfs'
-(often also called 'initrd'), which commodity distributions rely on for booting;
-hence be sure to keep the order of the two make targets used in the step-by-step
-guide, as things will go sideways if you install your kernel's image before its
-modules. Often installkernel will then add your kernel to the bootloader
-configuration, too. You have to take care of one or both of these tasks
-yourself, if your distributions installkernel doesn't handle them.
-
-A few distributions like Arch Linux and its derivatives totally lack an
-installkernel executable. On those just install the modules using the kernel's
-build system and then install the image and the System.map file manually::
-
-   sudo make modules_install
+depends on the existence and the implementation of ``/sbin/installkernel``
+executable on your distribution.
+
+If installkernel is found, the kernel's build system will delegate the actual
+installation of your kernel image to this executable, which then performs some
+or all of these tasks:
+
+ * On almost all Linux distributions installkernel will store your kernel's
+   image in /boot/, usually as '/boot/vmlinuz-<kernelrelease_id>'; often it will
+   put a 'System.map-<kernelrelease_id>' alongside it.
+
+ * On most distributions installkernel will then generate an 'initramfs'
+   (sometimes also called 'initrd'), which usually are stored as
+   '/boot/initramfs-<kernelrelease_id>.img' or
+   '/boot/initrd-<kernelrelease_id>'. Commodity distributions rely on this file
+   for booting, hence ensure to execute the make target 'modules_install' first,
+   as your distribution's initramfs generator otherwise will be unable to find
+   the modules that go into the image.
+
+ * On some distributions installkernel will then add an entry for your kernel
+   to your bootloader's configuration.
+
+You have to take care of some or all of the tasks yourself, if your
+distribution lacks a installkernel script or does only handle part of them.
+Consult the distribution's documentation for details. If in doubt, install the
+kernel manually::
+
    sudo install -m 0600 $(make -s image_name) /boot/vmlinuz-$(make -s kernelrelease)
    sudo install -m 0600 System.map /boot/System.map-$(make -s kernelrelease)
 
-If your distribution boots with the help of an initramfs, now generate one for
-your kernel using the tools your distribution provides for this process.
-Afterwards add your kernel to your bootloader configuration and reboot.
+Now generate your initramfs using the tools your distribution provides for this
+process. Afterwards add your kernel to your bootloader configuration and reboot.
 
 [:ref:`back to step-by-step guide <install_bissbs>`]
 
-- 
2.44.0


