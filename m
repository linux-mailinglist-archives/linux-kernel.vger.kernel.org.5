Return-Path: <linux-kernel+bounces-105826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AFD87E514
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EDFB21364
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D72C19C;
	Mon, 18 Mar 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Y5W9u7Ga"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6B25757;
	Mon, 18 Mar 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751135; cv=none; b=NIq3+0fCqfVVBHnanaSZ9ds6ur1FydHjXcYX0gEbv5INQ3pMCIIs/XtDdXdZ4eeYltimplT+N4R68XD9b98xeNGIualxCGdHAKQ5ItonjHTA3x2bIIXxMh3FvbhpsjMGzf3kaUSmarnpnFSRRCy7yTL4CiZ2HfSgU9FV2v+U2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751135; c=relaxed/simple;
	bh=LyKymQpai4NPJgMQu4KSa1lmNvpYbFeMuDfPh2+HPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzELMgblVdTeXXWikI+lrTXtIJg0UWB4iXvzGYRMz3rgOlrSbuD/ggu6RDjMtkUYV+AdXAyMXWFqTzOhrhnnvBF4spOf24coPNDepjmxhbsKJRpTPY7iO4Z7m6USmV+2RAAE7H2UOIcU6LSQQzNeAmbTrF/x5qNjF2O+8KR0+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Y5W9u7Ga; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/HUnBo7yzk/GQr34a886n6vcdOoie6mtT3fmI7o6CHQ=; t=1710751133;
	x=1711183133; b=Y5W9u7GafPV+vKVJf6vSWu7YK17qKyhgNovDbjQHhMaGiJyLSyV+KWwc1CFk3
	XcebkZxwzkuzG8GuoArEUVBQELcNKRQDZuhxOjC4wKKYZBYPcOQG9SqBf9he8h7+u1zKSGmGK+DmT
	9Y4xMOu3mBfQ1Hmz4i/iZUgCf9MubVjWcRAxOCZtWRLSNOH3MxsqXwedG6AFxKYJ68XoNNuH1TJRY
	em6qLUrlEPoqALmPskt6m2OEnkOTgHq2EtGPZMpP0g2zYg1Cj5Lyv82gE/XgClrZBJEnXNUwLrHxG
	JGtPYa7r+/hCM1VE2n/6qlLb9yBExDCJpuRdE+CJloGmjCiqjw==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rm8W1-00037E-0R; Mon, 18 Mar 2024 09:38:41 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v1 2/4] docs: verify/bisect: check taint flag
Date: Mon, 18 Mar 2024 09:38:37 +0100
Message-ID: <8fcaffa8e85f36d51178d61061355c3c8bc85a0f.1710750972.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1710751133;a9f5f439;
X-HE-SMSGID: 1rm8W1-00037E-0R

Instruct readers to check the taint flag, as the reason why it's set
might directly or indirectly cause the bug or interfere with testing.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index fb82118bb011b9..632372e343d89f 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -113,6 +113,7 @@ will be considered the 'good' release and used to prepare the .config file.
        #   checking if the output of the next two commands matches:
        tail -n 1 ~/kernels-built
        uname -r
+       cat /proc/sys/kernel/tainted
 
   c) Check if the problem occurs with this kernel as well.
 
@@ -572,21 +573,29 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   Remember the identifier momentarily, as it will help you pick the right kernel
   from the boot menu upon restarting.
 
-.. _recheckbroken_bissbs:
-
-* Reboot into the kernel you just built and check if the feature that is
-  expected to be broken really is.
-
-  Start by making sure the kernel you booted is the one you just built. When
-  unsure, check if the output of these commands show the exact same release
-  identifier::
+* Reboot into your newly built kernel. To ensure your actually started the one
+  you just built, you might want to verify if the output of these commands
+  matches::
 
     tail -n 1 ~/kernels-built
     uname -r
 
- Now verify if the feature that causes trouble works with your newly built
- kernel. If things work while investigating a regression, check the reference
- section for further details.
+.. _tainted_bissbs:
+
+* Check if the kernel marked itself as 'tainted'::
+
+    cat /proc/sys/kernel/tainted
+
+  If that command does not return '0', check the reference section, as the cause
+  for this might interfere with your testing.
+
+  [:ref:`details<tainted_bisref>`]
+
+.. _recheckbroken_bissbs:
+
+* Verify if your bug occurs with the newly built kernel. If it does not, check
+  out the instructions in the reference section to ensure nothing went sideways
+  during your tests.
 
   [:ref:`details<recheckbroken_bisref>`]
 
@@ -616,11 +625,14 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
     make -s kernelrelease | tee -a ~/kernels-built
     reboot
 
-  Now verify if you booted the kernel you intended to start, to then check if
-  everything works fine with this kernel::
+  Confirm you booted the kernel you intended to start and check its tainted
+  status::
 
     tail -n 1 ~/kernels-built
     uname -r
+    cat /proc/sys/kernel/tainted
+
+  Now verify if this kernel is showing the problem.
 
   [:ref:`details<recheckstablebroken_bisref>`]
 
@@ -1629,13 +1641,32 @@ need to look in different places.
 
 [:ref:`back to step-by-step guide <storagespace_bissbs>`]
 
+.. _tainted_bisref:
+
+Check if your newly built kernel considers itself 'tainted'
+-----------------------------------------------------------
+
+  *Check if the kernel marked itself as 'tainted'.*
+  [:ref:`... <tainted_bissbs>`]
+
+Linux marks itself as tainted when something happens that potentially leads to
+follow-up errors that look totally unrelated. That is why developers might
+ignore or react scantly to reports from tainted kernels -- unless of course the
+kernel set the flag right when the reported bug occurred.
+
+That's why you want check why a kernel is tainted as explained in
+Documentation/admin-guide/tainted-kernels.rst; doing so is also in your own
+interest, as your testing might be flawed otherwise.
+
+[:ref:`back to step-by-step guide <tainted_bissbs>`]
+
 .. _recheckbroken_bisref:
 
 Check the kernel built from the latest codebase
 -----------------------------------------------
 
-  *Reboot into the kernel you just built and check if the feature that regressed
-  is really broken there.* [:ref:`... <recheckbroken_bissbs>`]
+  *Verify if your bug occurs with the newly built kernel.*
+  [:ref:`... <recheckbroken_bissbs>`]
 
 There are a couple of reasons why the regression you face might not show up with
 your own kernel built from the latest codebase. These are the most frequent:
@@ -1712,6 +1743,9 @@ In case the feature that broke with newer kernels does not work with your first
 self-built kernel, find and resolve the cause before moving on. There are a
 multitude of reasons why this might happen. Some ideas where to look:
 
+* Check the taint status and the output of ``dmesg``, maybe something unrelated
+  went wrong.
+
 * Maybe localmodconfig did something odd and disabled the module required to
   test the feature? Then you might want to recreate a .config file based on the
   one from the last working kernel and skip trimming it down; manually disabling
-- 
2.44.0


