Return-Path: <linux-kernel+bounces-105825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AC87E513
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D958A1F2105D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D72C19D;
	Mon, 18 Mar 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mTqPZHRm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E622086;
	Mon, 18 Mar 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751134; cv=none; b=q/pYIEedDnbcIYwwZ1LjGBi/ylJfdPq+TPycDQIRLQFW9CD0fx35n0c6mIkmjseVJczrW35cfWDkpTdnxHgKa93yqyaLjt5x6El9NSqEa4cKSlXuvQH2O5MwfpyMprz5w7bd9e2gXUNfWheJ3LZKZ9TDGOpdUEuZFFxDFgTqcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751134; c=relaxed/simple;
	bh=Wsp4QU0EbEp59KyAXAfPwstK+7jqUH5pvIFh0uCXQn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7gb3r+Yk5PoMOU91lzJytJ4SHXTu5qvkqGUuKXUmiHW10wXigHPRUCZNaY4Y275ui+nNqd8f9tx1vpbMcl1nL0ZRPaM1sCkmupfThIjs5GRBx437FEhkpZWoC2REbifLmiJ0epaZTnYpzXJYIa7hZdel1uFEJBpvZj190ADXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mTqPZHRm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qNS37WICxSoFpCabsEiBmVjOxf9ErAGU0YHXXLoH3j4=; t=1710751131;
	x=1711183131; b=mTqPZHRmrtpmBUhyxdeHvxoAi9d/Wo2L+S8J8OHosn8wOINPeBiVDuxHeFqjW
	TwmkUO+eCqfkmXDDRBAYA10Nfz3ov+v1PPg5qnPWSP+x3T9MoWlH8NTeetUKx4getyA205GXE8Uj9
	SgXtpYyxaC6pBJ94+YEDax7L2FGHD65gAUKWVcxF8FoFGWXeyBTSCwVSrbHY/Ctk/Fo6sMPqUNWpF
	GLpHt1h1y19m4/+T3h5tqo0W9W4Fws3duxFxIdUcWGcNZ3jrexDS5em5eUPlZ/4mmhLoqUs1arjcS
	T1JcicrFQ59m4TXAuIMBc2Nuw/R5911SJY1hXrGZSrVpVf7eJw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rm8W1-00037E-St; Mon, 18 Mar 2024 09:38:41 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 4/4] docs: verify/bisect: remove a level of indenting
Date: Mon, 18 Mar 2024 09:38:39 +0100
Message-ID: <01f1a407e92b92d9f8614bd34882956694bab123.1710750972.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1rm8W1-00037E-St

Remove a unnecessary level of indenting in some areas of the reference
section. No text changes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 114 +++++++++---------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index ee9df7ecb02ac7..d3504826f40154 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -1138,12 +1138,12 @@ Git clone of Linus' mainline repository. There is nothing more to say about
 that -- but there are two alternatives ways to retrieve the sources that might
 work better for you:
 
- * If you have an unreliable internet connection, consider
-   :ref:`using a 'Git bundle'<sources_bundle_bisref>`.
+* If you have an unreliable internet connection, consider
+  :ref:`using a 'Git bundle'<sources_bundle_bisref>`.
 
- * If downloading the complete repository would take too long or requires too
-   much storage space, consider :ref:`using a 'shallow
-   clone'<sources_shallow_bisref>`.
+* If downloading the complete repository would take too long or requires too
+  much storage space, consider :ref:`using a 'shallow
+  clone'<sources_shallow_bisref>`.
 
 .. _sources_bundle_bisref:
 
@@ -1195,23 +1195,23 @@ branches as explained in the step-by-step guide.
 
 Note, shallow clones have a few peculiar characteristics:
 
- * For bisections the history needs to be deepened a few mainline versions
-   farther than it seems necessary, as explained above already. That's because
-   Git otherwise will be unable to revert or describe most of the commits within
-   a range (say 6.1..6.2), as they are internally based on earlier kernels
-   releases (like 6.0-rc2 or 5.19-rc3).
+* For bisections the history needs to be deepened a few mainline versions
+  farther than it seems necessary, as explained above already. That's because
+  Git otherwise will be unable to revert or describe most of the commits within
+  a range (say 6.1..6.2), as they are internally based on earlier kernels
+  releases (like 6.0-rc2 or 5.19-rc3).
 
- * This document in most places uses ``git fetch`` with ``--shallow-exclude=``
-   to specify the earliest version you care about (or to be precise: its git
-   tag). You alternatively can use the parameter ``--shallow-since=`` to specify
-   an absolute (say ``'2023-07-15'``) or relative (``'12 months'``) date to
-   define the depth of the history you want to download. When using them while
-   bisecting mainline, ensure to deepen the history to at least 7 months before
-   the release of the mainline release your 'good' kernel is based on.
+* This document in most places uses ``git fetch`` with ``--shallow-exclude=``
+  to specify the earliest version you care about (or to be precise: its git
+  tag). You alternatively can use the parameter ``--shallow-since=`` to specify
+  an absolute (say ``'2023-07-15'``) or relative (``'12 months'``) date to
+  define the depth of the history you want to download. When using them while
+  bisecting mainline, ensure to deepen the history to at least 7 months before
+  the release of the mainline release your 'good' kernel is based on.
 
- * Be warned, when deepening your clone you might encounter an error like
-   'fatal: error in object: unshallow cafecaca0c0dacafecaca0c0dacafecaca0c0da'.
-   In that case run ``git repack -d`` and try again.
+* Be warned, when deepening your clone you might encounter an error like
+  'fatal: error in object: unshallow cafecaca0c0dacafecaca0c0dacafecaca0c0da'.
+  In that case run ``git repack -d`` and try again.
 
 [:ref:`back to step-by-step guide <sources_bissbs>`]
 [:ref:`back to section intro <sources_bisref>`]
@@ -1235,23 +1235,23 @@ locate the right build configuration.*
 
 Two things can easily go wrong when creating a .config file as advised:
 
- * The oldconfig target will use a .config file from your build directory, if
-   one is already present there (e.g. '~/linux/.config'). That's totally fine if
-   that's what you intend (see next step), but in all other cases you want to
-   delete it. This for example is important in case you followed this guide
-   further, but due to problems come back here to redo the configuration from
-   scratch.
+* The oldconfig target will use a .config file from your build directory, if
+  one is already present there (e.g. '~/linux/.config'). That's totally fine if
+  that's what you intend (see next step), but in all other cases you want to
+  delete it. This for example is important in case you followed this guide
+  further, but due to problems come back here to redo the configuration from
+  scratch.
 
- * Sometimes olddefconfig is unable to locate the .config file for your running
-   kernel and will use defaults, as briefly outlined in the guide. In that case
-   check if your distribution ships the configuration somewhere and manually put
-   it in the right place (e.g. '~/linux/.config') if it does. On distributions
-   where /proc/config.gz exists this can be achieved using this command::
+* Sometimes olddefconfig is unable to locate the .config file for your running
+  kernel and will use defaults, as briefly outlined in the guide. In that case
+  check if your distribution ships the configuration somewhere and manually put
+  it in the right place (e.g. '~/linux/.config') if it does. On distributions
+  where /proc/config.gz exists this can be achieved using this command::
 
-     zcat /proc/config.gz > .config
+    zcat /proc/config.gz > .config
 
-   Once you put it there, run ``make olddefconfig`` again to adjust it to the
-   needs of the kernel about to be built.
+  Once you put it there, run ``make olddefconfig`` again to adjust it to the
+  needs of the kernel about to be built.
 
 Note, the olddefconfig target will set any undefined build options to their
 default value. If you prefer to set such configuration options manually, use
@@ -1393,16 +1393,16 @@ when following this guide on a few commodity distributions.
 
 **Debian:**
 
- * Remove a stale reference to a certificate file that would cause your build to
-   fail::
+* Remove a stale reference to a certificate file that would cause your build to
+  fail::
 
-    ./scripts/config --set-str SYSTEM_TRUSTED_KEYS ''
+   ./scripts/config --set-str SYSTEM_TRUSTED_KEYS ''
 
-   Alternatively, download the needed certificate and make that configuration
-   option point to it, as `the Debian handbook explains in more detail
-   <https://debian-handbook.info/browse/stable/sect.kernel-compilation.html>`_
-   -- or generate your own, as explained in
-   Documentation/admin-guide/module-signing.rst.
+  Alternatively, download the needed certificate and make that configuration
+  option point to it, as `the Debian handbook explains in more detail
+  <https://debian-handbook.info/browse/stable/sect.kernel-compilation.html>`_
+  -- or generate your own, as explained in
+  Documentation/admin-guide/module-signing.rst.
 
 [:ref:`back to step-by-step guide <configmods_bissbs>`]
 
@@ -1563,11 +1563,11 @@ The step-by-step guide uses the default make targets (e.g. 'bzImage' and
 steps of the guide then install. You instead can also directly build everything
 and directly package it up by using one of the following targets:
 
- * ``make -j $(nproc --all) bindeb-pkg`` to generate a deb package
+* ``make -j $(nproc --all) bindeb-pkg`` to generate a deb package
 
- * ``make -j $(nproc --all) binrpm-pkg`` to generate a rpm package
+* ``make -j $(nproc --all) binrpm-pkg`` to generate a rpm package
 
- * ``make -j $(nproc --all) tarbz2-pkg`` to generate a bz2 compressed tarball
+* ``make -j $(nproc --all) tarbz2-pkg`` to generate a bz2 compressed tarball
 
 This is just a selection of available make targets for this purpose, see
 ``make help`` for others. You can also use these targets after running
@@ -1599,20 +1599,20 @@ If installkernel is found, the kernel's build system will delegate the actual
 installation of your kernel image to this executable, which then performs some
 or all of these tasks:
 
- * On almost all Linux distributions installkernel will store your kernel's
-   image in /boot/, usually as '/boot/vmlinuz-<kernelrelease_id>'; often it will
-   put a 'System.map-<kernelrelease_id>' alongside it.
+* On almost all Linux distributions installkernel will store your kernel's
+  image in /boot/, usually as '/boot/vmlinuz-<kernelrelease_id>'; often it will
+  put a 'System.map-<kernelrelease_id>' alongside it.
 
- * On most distributions installkernel will then generate an 'initramfs'
-   (sometimes also called 'initrd'), which usually are stored as
-   '/boot/initramfs-<kernelrelease_id>.img' or
-   '/boot/initrd-<kernelrelease_id>'. Commodity distributions rely on this file
-   for booting, hence ensure to execute the make target 'modules_install' first,
-   as your distribution's initramfs generator otherwise will be unable to find
-   the modules that go into the image.
+* On most distributions installkernel will then generate an 'initramfs'
+  (sometimes also called 'initrd'), which usually are stored as
+  '/boot/initramfs-<kernelrelease_id>.img' or
+  '/boot/initrd-<kernelrelease_id>'. Commodity distributions rely on this file
+  for booting, hence ensure to execute the make target 'modules_install' first,
+  as your distribution's initramfs generator otherwise will be unable to find
+  the modules that go into the image.
 
- * On some distributions installkernel will then add an entry for your kernel
-   to your bootloader's configuration.
+* On some distributions installkernel will then add an entry for your kernel
+  to your bootloader's configuration.
 
 You have to take care of some or all of the tasks yourself, if your
 distribution lacks a installkernel script or does only handle part of them.
-- 
2.44.0


