Return-Path: <linux-kernel+bounces-93617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707F873266
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FF292181
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573475DF04;
	Wed,  6 Mar 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="R5LF02AZ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE8D53F;
	Wed,  6 Mar 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716881; cv=none; b=lZ5yCoiIhdloHyst/JDbbUgATbuPneoBQcu+0Q2IysRIZU8elFCW9ecUlE6RGrk3+oUalR+wz3ivN7YTm8VLnrQw6ESyPTe7IycvcRbGooql5zR4umcKt6edg6mHI0dGnuIeoSGRaonFDsuUlLo7N9L8GEQToe8FbfIW4dcdW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716881; c=relaxed/simple;
	bh=pGa9mdlvKwjfobh9Qn2cKqrNObJsTaPZcQwmDmiXL6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs3N0qLvUFfhHwp5+Ct4l/eVgH9lC5+xJJTDAm0e4/MuLzLfPDRhTlRECO8ah+K4ZJnBgqtwY3rufAtZQlvWIrh+rZX6j6q4HF7CBR9e/FSp9zhkd68uHPnVjekjyxAi5iEuibLQ0ZAz3L07xtX035MeIhIt6oBxSX8auiv+y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=R5LF02AZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3biypYV+gbhxHHtP/tQVz92UYZTIUPbXvDcOsML1WdY=; t=1709716878; x=1710148878;
	 b=R5LF02AZNZaX0ykUZLu+fBu2+N9w5rUl8HtOCWGj1xsESDFN8KZaZBur4AOYu1ONs5QNcVJsnF
	7MJGWnUwsEzAFmvX1NRooH2ZyyAM8kGz1lhu8Gb4vUMsWhY+L4xbafSpOqW7maRV39H6HiULRp8nf
	ikLUBsV4eybNicN2vq+s8IUb84ehA6LEz428XvNkJ/NVg7QnzaqD3F345P0JW1Mq8u4eebMb5qjKF
	kx3icP1gLV9XQRGui9bOyDokK9jV/+6k0/zznRZvA4D4kUUxodWh47IoIIkEZW9NSXTJbtwqLtziC
	36J6BS1ctNq+/CJ8mMOohjN2HfMn/6RgpAWEw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rhnSb-00084Q-2E; Wed, 06 Mar 2024 10:21:13 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support for Arch
Date: Wed,  6 Mar 2024 10:21:12 +0100
Message-ID: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1709716878;071bd769;
X-HE-SMSGID: 1rhnSb-00084Q-2E

Assorted changes for the recently added document.

Improvements:

* Add instructions for installing required software on Arch Linux.

Fixes:

* Move a 'git remote add -t master stable [...]' from a totally wrong
  to the right place.

* Fix two anchors.

* Add two required packages to the openSUSE install instructions.

Fine tuning:

* Improve the reference section about downloading Linux mainline sources
  to make it more obvious that those are alternatives.

* Include the full instructions for git bundles to ensure the remote
  gets the right name; that way the text also works stand alone.

* Install ncurses and qt headers for use of menuconfig and xconfig by
  default, but tell users that they are free to omit them.

* Mention ahead of time which version number are meant as example in
  commands used during the step-by-step guide.

* Mention that 'kernel-install remove' might do a incomplete job.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Lo! A quick note reg "mention ahead of time which version numbers are
meant as example in commands used during the step-by-step guide". I did
that, as I've seen someone following the guide without replacing the
version numbers, so pointing this out with a few words seemed wise. But
I'm not sure if the way I did it was the best; if someone has a better
idea how to do that, please let me know. Ciao, Thorsten
---
 .../verify-bugs-and-bisect-regressions.rst    | 135 +++++++++++-------
 1 file changed, 84 insertions(+), 51 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 54bde8bac95c67..58211840ac6ffb 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -192,8 +192,8 @@ will be considered the 'good' release and used to prepare the .config file.
 
        sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
        sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
-       # * Note, if kernel-install is missing, you will have to
-       #   manually remove the kernel image and related files.
+       # * Note, on some distributions kernel-install is missing
+       #   or does only part of the job.
 
   b) If you performed a bisection and successfully validated the result, feel
      free to remove all kernels built during the actual bisection (Segment 3 c);
@@ -348,11 +348,14 @@ Preparations: set up everything to build your own kernels
   one downloads less than 500 MByte, the other works better with unreliable
   internet connections.*
 
-  Execute the following command to retrieve a fresh mainline codebase::
+  Execute the following command to retrieve a fresh mainline codebase while
+  preparing things to add stable/longterm branches later::
 
     git clone -o mainline --no-checkout \
       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
     cd ~/linux/
+    git remote add -t master stable \
+      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
   [:ref:`details<sources_bisref>`]
 
@@ -365,7 +368,7 @@ Preparations: set up everything to build your own kernels
   identifier using ``uname -r``.
 
   Afterwards check out the source code for the version earlier established as
-  'good' and create a .config file::
+  'good' (in this example this is assumed to be 6.0) and create a .config file::
 
     git checkout --detach v6.0
     make olddefconfig
@@ -462,8 +465,10 @@ Preparations: set up everything to build your own kernels
 
     [:ref:`details<configmods_distros_bisref>`].
 
-  * If you want to influence other aspects of the configuration, do so now
-    by using make targets like 'menuconfig' or 'xconfig'.
+  * If you want to influence other aspects of the configuration, do so now using
+    your preferred tool. Note, to use make targets like 'menuconfig' or
+    'nconfig', you will need to install the development files of ncurses; for
+    'xconfig' you likewise need the Qt5 or Qt6 headers.
 
     [:ref:`details<configmods_individual_bisref>`].
 
@@ -601,8 +606,8 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
 * Are you facing a problem within a stable/longterm release, but failed to
   reproduce it with the mainline kernel you just built? Then check if the latest
   codebase for the particular series might already fix the problem. To do so,
-  add the stable series Git branch for your 'good' kernel and check out the
-  latest version::
+  add the stable series Git branch for your 'good' kernel (again, this here is
+  assumed to be 6.0) and check out the latest version::
 
     cd ~/linux/
     git remote set-branches --add stable linux-6.0.y
@@ -652,7 +657,7 @@ otherwise would be a waste of time. [:ref:`details<introworkingcheck_bisref>`]
   regressed works as expected with it.
 
   Start by checking out the sources for the version earlier established as
-  'good'::
+  'good' (once again assumed to be 6.0 here)::
 
     cd ~/linux/
     git checkout --detach v6.0
@@ -697,15 +702,13 @@ each kernel on commodity x86 machines.
   stable branch, unless you already did so earlier::
 
     cd ~/linux/
-    git remote add -t master stable \
-      https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable.git
     git remote set-branches --add stable linux-6.1.y
     git fetch stable
 
 .. _bisectstart_bissbs:
 
 * Start the bisection and tell Git about the versions earlier established as
-  'good' and 'bad'::
+  'good' (6.0 in the following example command) and 'bad' (6.1.5)::
 
     cd ~/linux/
     git bisect start
@@ -884,8 +887,9 @@ space might run out.
 
   On quite a few distributions this will delete all other kernel files installed
   while also removing the kernel's entry from the boot menu. But on some
-  distributions this command does not exist or will fail; in that case consult
-  the reference section, as your Linux distribution needs special care.
+  distributions kernel-install does not exist or leaves boot-loader entries or
+  kernel image and related files behind; in that case remove them as described
+  in the reference section.
 
   [:ref:`details<makeroom_bisref>`]
 
@@ -1015,8 +1019,6 @@ the right thing.
 
 [:ref:`back to step-by-step guide <bootworking_bissbs>`]
 
-.. _buildrequires_bisref:
-
 .. _diskspace_bisref:
 
 Space requirements
@@ -1060,7 +1062,7 @@ to do this as well, if you tried bisecting between 6.0.11 and 6.1.13.
 
 [:ref:`back to step-by-step guide <rangecheck_bissbs>`]
 
-.. _sources_bisref:
+.. _buildrequires_bisref:
 
 Install build requirements
 --------------------------
@@ -1076,72 +1078,103 @@ about to build.
 Here are a few examples what you typically need on some mainstream
 distributions:
 
+* Arch Linux and derivatives::
+
+    sudo pacman --needed -S bc binutils bison flex gcc git kmod libelf openssl \
+      pahole perl zlib ncurses qt6-base
+
 * Debian, Ubuntu, and derivatives::
 
-    sudo apt install bc binutils bison dwarves flex gcc git make openssl \
-      pahole perl-base libssl-dev libelf-dev
+    sudo apt install bc binutils bison dwarves flex gcc git kmod libelf-dev \
+      libssl-dev make openssl pahole perl-base pkg-config zlib1g-dev \
+      libncurses-dev qt6-base-dev g++
 
 * Fedora and derivatives::
 
-    sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h} \
-      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}
+    sudo dnf install binutils \
+      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole,rpmbuild} \
+      /usr/include/{libelf.h,openssl/pkcs7.h,zlib.h,ncurses.h,qt6/QtGui/QAction}
 
 * openSUSE and derivatives::
 
-    sudo zypper install bc binutils bison dwarves flex gcc git make perl-base \
-      openssl openssl-devel libelf-dev
-
-In case you wonder why these lists include openssl and its development headers:
-they are needed for the Secure Boot support, which many distributions enable in
-their kernel configuration for x86 machines.
+    sudo zypper install bc binutils bison dwarves flex gcc git \
+      kernel-install-tools libelf-devel make modutils openssl openssl-devel \
+      perl-base zlib-devel rpm-build ncurses-devel qt6-base-devel
 
-Sometimes you will need tools for compression formats like bzip2, gzip, lz4,
-lzma, lzo, xz, or zstd as well.
-
-In case you want to adjust the build configuration with make targets like
-'menuconfig' or 'xconfig' later, ensure to also install development headers for
-ncurses and Qt5.
+These commands install a few packages that are often, but not always needed. You
+for example might want to skip installing the development headers for ncurses,
+which you will only need in case you later might want to adjust the kernel build
+configuration using make the targets 'menuconfig' or 'nconfig'; likewise omit
+the headers of Qt6 is you do not plan to adjust the .config using 'xconfig'.
 
 You furthermore might need additional libraries and their development headers
-for tasks not covered in this guide. For example, zlib will be needed when
-building kernel tools from the tools/ directory;.
+for tasks not covered in this guide -- for example when building utilities from
+the kernel's tools/ directory.
 
 [:ref:`back to step-by-step guide <buildrequires_bissbs>`]
 
-Download the sources using git
+.. _sources_bisref:
+
+Download the sources using Git
 ------------------------------
 
   *Retrieve the Linux mainline sources.*
   [:ref:`...<sources_bissbs>`]
 
-The step-by-step guide outlines how to retrieve the Linux sources using a full
-Git clone of Linus' mainline repository. If you have an unreliable internet
-connection, you instead might want to use a 'Git bundle' to retrieve the
-sources; if downloading the complete repository would take too long or requires
-too much storage space, use a shallow clone instead.
+The step-by-step guide outlines how to download the Linux sources using a full
+Git clone of Linus' mainline repository. There is nothing more to say about
+that -- but there are two alternatives ways to retrieve the sources that might
+work better for you:
 
-Downloading Linux mainline using a bundle
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * If you have an unreliable internet connection, consider
+   :ref:`using a 'Git bundle'<sources_bundle_bisref>`.
 
-Switch to you home directory and follow the instructions `kernel.org provides
-for this case <https://www.kernel.org/cloning-linux-from-a-bundle.html>`_.
+ * If downloading the complete repository would take too long or requires too
+   much storage space, consider :ref:`using a 'shallow
+   clone'<sources_shallow_bisref>`.
 
-Afterwards add the stable Git repository as remote and all required
-stable/branches as explained in the step-by-step guide.
+.. _sources_bundle_bisref:
 
-Downloading Linux mainline using a shallow clone
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Downloading Linux mainline sources using a bundle
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Use the following commands to retrieve the Linux mainline sources using a
+bundle::
+
+    wget -c \
+      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/clone.bundle
+    git clone --no-checkout clone.bundle ~/linux/
+    cd ~/linux/
+    git remote remove origin
+    git remote add mainline \
+      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+    git fetch mainline
+    git remote add -t master stable \
+      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+
+In case the 'wget' command fails, just re-execute it, it will pick up where
+it left off.
+
+[:ref:`back to step-by-step guide <sources_bissbs>`]
+[:ref:`back to section intro <sources_bisref>`]
+
+.. _sources_shallow_bisref:
+
+Downloading Linux mainline sources using a shallow clone
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 First, execute the following command to retrieve the latest mainline codebase::
 
     git clone -o mainline --no-checkout --depth 1 -b master \
       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
     cd ~/linux/
+    git remote add -t master stable \
+      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
 
 Now deepen your clone's history to the second predecessor of the mainline
 release of your 'good' version. In case the latter are 6.0 or 6.0.11, 5.19 would
 be the first predecessor and 5.18 the second -- hence deepen the history up to
-the latter::
+that version::
 
     git fetch --shallow-exclude=v5.18 mainline
 
@@ -1150,7 +1183,7 @@ branches as explained in the step-by-step guide.
 
 Note, shallow clones have a few peculiar characteristics:
 
- * For bisections the history needs to be deepend a few mainline versions
+ * For bisections the history needs to be deepened a few mainline versions
    farther than it seems necessary, as explained above already. That's because
    Git otherwise will be unable to revert or describe most of the commits within
    a range (say v6.1..v6.2), as they are internally based on earlier kernels

base-commit: a800c6f5b0573847722c5ec70e0ce5cde6ca13dd
-- 
2.44.0


