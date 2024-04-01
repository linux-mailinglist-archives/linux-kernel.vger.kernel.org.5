Return-Path: <linux-kernel+bounces-126550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE7893965
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE028218E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1510A31;
	Mon,  1 Apr 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RD52WKjU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238D10788;
	Mon,  1 Apr 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963791; cv=none; b=Ujn4PEqc1aP/bxtzrZPbojMNl4EyjmkDVEMvp1I0Ry8SSsScILCJlKHucf+AGzR1Xyu0iWpeZOTFoe5dMg0pIEiJNJL2Yhec1IiGi5UvucXRB2j7TjImBdPOb820X60jN8Jdz13x9fWLimXxUsyyRR8BgyNTnvotZydY84h8VFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963791; c=relaxed/simple;
	bh=1xbwl3deUI8EugEpHFtd11RFuw1yy3rmyznd1Szn2Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uadVLD49qJuEP8LM+izAkLpET2yq6Q5othscvx971qiEl0GOiNsIp8mHF4eAvKfNVRuQIrbh2DClFeufMIxdo1IhPp3SgspMvD9IWX6OsYPLX4xc0IOakqF16Atdlya64cYNEP5FLFOgqIITvoUZYSYYHA2KfyJrAYMTBS/49gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RD52WKjU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sBR4AUtbOWGkAitvBQQqQOWJXiRUJp1cu3pYde9QQ8Q=; t=1711963789;
	x=1712395789; b=RD52WKjUiqye7VkoUPvw7NdOInJIbP1bt0qKHjN2htkjQFlYNMeCGP3EiBnvk
	KzyMAP0U8P1GS9MXe2S/XCN2bP8z/KAQKrmjhgQGcruADaWmNVysKNnVEN8ZVHEdNiCNOZqf+MNUl
	f5Pl7cr+13e1K/8NkIdsdo+ghUfCBeL792zBTXVp7RF7R+aEQT1KABF5Tm8ptk+ueIGeewxY4N5mm
	UM16QXltQaQLqnVfP6PBveTm2woblkHxhDr36WvxP+FZBTmA5HEIgwQtFHQfmHLyzTi5cjF0hFS4m
	YnWy8XT0UQ/w61+Xr6VSR+C5Wifo25U2Jyx4HqR9VAm/Dx6ttQ==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rrDz7-0001Lq-Iw; Mon, 01 Apr 2024 11:29:45 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 3/3] docs: verify/bisect: describe how to use a build host
Date: Mon,  1 Apr 2024 11:29:43 +0200
Message-ID: <0d863aeea2f19f1eac460e503bd09ed2519d09a5.1711963460.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711963789;9169144f;
X-HE-SMSGID: 1rrDz7-0001Lq-Iw

Describe how to build kernels on another system (with and without
cross-compiling), as building locally can be quite painfully on some
slow systems. This is done in an add-on section, as it would make the
step-by-step guide to complicated if this special case would be
described there.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 78 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index 24a54fcd6abe1b..f371c48e9ef603 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -275,6 +275,10 @@ Preparations: set up everything to build your own kernels
 
 The following steps lay the groundwork for all further tasks.
 
+Note: the instructions assume you are building and testing on the same
+machine; if you want to compile the kernel on another system, check
+:ref:`Build kernels on a different machine <buildhost_bis>` below.
+
 .. _backup_bissbs:
 
 * Create a fresh backup and put system repair and restore tools at hand, just
@@ -2096,11 +2100,77 @@ problems will arise if the kernelrelease identifier exceeds 63 characters.
 [:ref:`back to step-by-step guide <introoptional_bissbs>`].
 
 
-Additional reading material
-===========================
+Additional information
+======================
+
+.. _buildhost_bis:
+
+Build kernels on a different machine
+------------------------------------
+
+To compile kernels on another system, slightly alter the step-by-step guide's
+instructions:
+
+* Start following the guide on the machine where you want to install and test
+  the kernels later.
+
+* After executing ':ref:`Boot into the working kernel and briefly use the
+  apparently broken feature <bootworking_bissbs>`', save the list of loaded
+  modules to a file using ``lsmod > ~/test-machine-lsmod``. Then locate the
+  build configuration for the running kernel (see ':ref:`Start defining the
+  build configuration for your kernel <oldconfig_bisref>`' for hints on where
+  to find it) and store it as '~/test-machine-config-working'. Transfer both
+  files to the home directory of your build host.
+
+* Continue the guide on the build host (e.g. with ':ref:`Ensure to have enough
+  free space for building [...] <diskspace_bissbs>`').
+
+* When you reach ':ref:`Start preparing a kernel build configuration[...]
+  <oldconfig_bissbs>`': before running ``make olddefconfig`` for the first time,
+  execute the following command to base your configuration on the one from the
+  test machine's 'working' kernel::
+
+    cp ~/test-machine-config-working ~/linux/.config
+
+* During the next step to ':ref:`disable any apparently superfluous kernel
+  modules <localmodconfig_bissbs>`' use the following command instead::
+
+    yes '' | make localmodconfig LSMOD=~/lsmod_foo-machine localmodconfig
+
+* Continue the guide, but ignore the instructions outlining how to compile,
+  install, and reboot into a kernel every time they come up. Instead build
+  like this::
 
-Further sources
----------------
+    cp ~/kernel-config-working .config
+    make olddefconfig &&
+    make -j $(nproc --all) targz-pkg
+
+  This will generate a gzipped tar file whose name is printed in the last
+  line shown; for example, a kernel with the kernelrelease identifier
+  '6.0.0-rc1-local-g928a87efa423' built for x86 machines usually will
+  be stored as '~/linux/linux-6.0.0-rc1-local-g928a87efa423-x86.tar.gz'.
+
+  Copy that file to your test machine's home directory.
+
+* Switch to the test machine to check if you have enough space to hold another
+  kernel. Then extract the file you transferred::
+
+    sudo tar -xvzf ~/linux-6.0.0-rc1-local-g928a87efa423-x86.tar.gz -C /
+
+  Afterwards :ref:`generate the initramfs and add the kernel to your boot
+  loader's configuration <install_bisref>`; on some distributions the following
+  command will take care of both these tasks::
+
+    sudo /sbin/installkernel 6.0.0-rc1-local-g928a87efa423 /boot/vmlinuz-6.0.0-rc1-local-g928a87efa423
+
+  Now reboot and ensure you started the intended kernel.
+
+This approach even works when building for another architecture: just install
+cross-compilers and add the appropriate parameters to every invocation of make
+(e.g. ``make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- [...]``).
+
+Additional reading material
+---------------------------
 
 * The `man page for 'git bisect' <https://git-scm.com/docs/git-bisect>`_ and
   `fighting regressions with 'git bisect' <https://git-scm.com/docs/git-bisect-lk2009.html>`_
-- 
2.44.0


