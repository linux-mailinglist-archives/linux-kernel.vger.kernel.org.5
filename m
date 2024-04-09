Return-Path: <linux-kernel+bounces-136360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A789D321
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CFF1C21872
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6D7FBA4;
	Tue,  9 Apr 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="V/l8NogV"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834F79955;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=JC7BP9HwyslE8lbiKFdd4MdU3e9W2GCSLF3XmruA0r9wjFnhW6awmbhXBWn2LAm7qveKiM3i4+jFQTBz4n47j9M8zKJQqAqvR4XRdjhLbxfODxAzJ6avZE0brdeH0lqhQbfd223Nx3A9j56ZR9pUNlNcjXQmWsp77aadjxT7+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=CMX6aA9wScU43YKlAsL1ntr9Wuy50Tzw1OIpyrleAiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiGCzo88akwT7Unbxcw6iS4VxZBl281GAtIJ7B3+UCZnIuyfFiaeCUHHXsh0osuEsobnMYNzpS65VoAnrY3CBKYP6y/L4ENZIXeSpzvjpl1T9FyX1sqieTzvwY8tq5W8n6X/WA3Y60J0ldKdIwezSJB+BCbHn2OxdTJ9nlmSB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=V/l8NogV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pPlFRJ8SFuDnkXHqmbQgQnUnXyCLw1rG7kPikkOu6Os=; t=1712647855;
	x=1713079855; b=V/l8NogVpAGIwvDzQnLqRuqtaV/4OS4p/7xfY35YcxlwizVkYsIXvsupHB99y
	UnJhePk5HTmd4un3fo4jwM2biLFQzbCzXoqvVBn2cbYoh4XjumKm1CoTVIvWCVtJXB8mVl4gu1x0M
	DqrWsxF7S1p39nungCGJlH2z9PECr48UfpfsigAiefv780B40xAxnDG7vNc+Drtsvdwe/H6hnDPNc
	6HuEF5rSbZLf8z3v9C4ZzL1px12beJpPY7ToAxpEZMWGqefUvsVgDeGT/SolBQNlB5QEBqYdxUgth
	uuTCUS1bY3W2me0lcRhoyynzUOnEYCCxHexhKwVKtVb/f4fS6A==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wR-0006Ld-Eq; Tue, 09 Apr 2024 09:30:51 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 5/6] docs: verify/bisect: describe how to use a build host
Date: Tue,  9 Apr 2024 09:30:48 +0200
Message-ID: <288160cb4769e46a3280250ca71da0abc4aa002d.1712647788.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1ru5wR-0006Ld-Eq

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
index 1987c827211fce..6193c797642732 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -276,6 +276,10 @@ Preparations: set up everything to build your own kernels
 
 The following steps lay the groundwork for all further tasks.
 
+Note: the instructions assume you are building and testing on the same
+machine; if you want to compile the kernel on another system, check
+:ref:`Build kernels on a different machine <buildhost_bis>` below.
+
 .. _backup_bissbs:
 
 * Create a fresh backup and put system repair and restore tools at hand, just
@@ -2103,11 +2107,77 @@ problems will arise if the kernelrelease identifier exceeds 63 characters.
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


