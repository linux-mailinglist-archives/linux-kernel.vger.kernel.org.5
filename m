Return-Path: <linux-kernel+bounces-118962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4805388C1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8011C380BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3607581C;
	Tue, 26 Mar 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="m8KYAOl7"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A87442B;
	Tue, 26 Mar 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455713; cv=none; b=hVzRVSxHSZrj8DBqmDojTM/OYOeIG61SLfPnO2WFYFQ0uuBMdqDvLlw1P1aZobhpB1PDkH8kE++Bh63BaFIh4OfglDmPnENouWD/0hGdjvCcIg3qoE/R8L4iXyY5YGa9UTIvQ4D5140I7YkYQRxZNEeqCQErApYzIczh23S5rqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455713; c=relaxed/simple;
	bh=qFy509Zv20pYYf9NMDSDTc0uBl7/uVC4F1+1tRJ4fKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzaouPrH/jExLFkrHiCcfv8H58/v5TLkv2qrkigGZvN5lJ+1EgREw6cNsdyVWz0njni+D+Q4bGraWBdA+3RDBB481RqqDGqjuoxhTlNNMR1nB3VQcUVoCi1g8tiTcrNlRasbQFpRs1BQ+SQnRyOg1GIU2Cd0Ui79UWNLm2c6uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=m8KYAOl7; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3NZ/P2d8n2GwW8r6YNLOfK4S660LNZHNaKmSYKCW+RE=; t=1711455711;
	x=1711887711; b=m8KYAOl7beLbX08GVMNHLllA1jrdTlV9cjO/c20l36V0+DJ/u2b+qoV8xe1b/
	xB9+jqBJsqENBsZb/NdtA/s3ClRLiPniAwlE37VyvM50Mo9SHpey9cMA+67mSWwtwDBcKltQ9TG5W
	K3N7XHuxRWgANi03Lj+loJ7nAnjYwzw3K545NR/jrF1bBSt36lgfJp7mYUqGBq6HbHk5bXF41V0Rn
	4Yars49PjDzqn2iJIV7Q/1DMTC6vos1ze99uxuRIUnsuy/gQ0GeJzpxFdYq9sLClbeI4OMmbyoNh8
	5DlSisaG4ql07lqIVbksexL+A8976zVfoKzGTK7bMMjA53cgUg==;
Received: from [77.20.141.166] (helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rp5oH-0000kc-O6; Tue, 26 Mar 2024 13:21:45 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC PATCH v1 2/2] docs: reporting-issue: rework the TLDR
Date: Tue, 26 Mar 2024 13:21:29 +0100
Message-ID: <2f5a78745cbe0a99a4592612d6ffd57a17619fb4.1711455295.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711455295.git.linux@leemhuis.info>
References: <cover.1711455295.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711455711;c092b3a9;
X-HE-SMSGID: 1rp5oH-0000kc-O6

Rework the TLDR (aka the short guide) for various reasons:

* People had to read it entirely and then act upon what they learned,
  which from feedback I got was apparently somewhat hard and confusing
  given everything we expect from bug reporters; this partly was because
  the first paragraph covered a special case (regression in
  stable/longterm kernel) and not the main aspect most people cared
  about when they came to the document.

  Use a step-by-step approach to avoid this.

* Make use of
  Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst

* The 'quickly report a stable regression to the stable team' approach
  hardly worked out: most of the time the regression was not known yet.
  Try a different approach using the regressions list.

* Reports about stable/longterm regressions most of the time were
  greeted with a brief reply along the lines of 'Is mainline affected as
  well?'; this is needed to determine who is responsible, so it might as
  well make the reporter check that before sending the report (which
  verify-bugs-and-bisect-regressions.rst already tells them to do, too).

Not-signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 104 +++++++++++-------
 1 file changed, 62 insertions(+), 42 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index e6083946c146e8..5f3c840ab94524 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -5,48 +5,68 @@ Reporting issues
 ++++++++++++++++
 
 
-The short guide (aka TL;DR)
-===========================
-
-Are you facing a regression with vanilla kernels from the same stable or
-longterm series? One still supported? Then search the `LKML
-<https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
-<https://lore.kernel.org/stable/>`_ archives for matching reports to join. If
-you don't find any, install `the latest release from that series
-<https://kernel.org/>`_. If it still shows the issue, report it to the stable
-mailing list (stable@vger.kernel.org) and CC the regressions list
-(regressions@lists.linux.dev); ideally also CC the maintainer and the mailing
-list for the subsystem in question.
-
-In all other cases try your best guess which kernel part might be causing the
-issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers
-expect to be told about problems, which most of the time will be by email with a
-mailing list in CC. Check the destination's archives for matching reports;
-search the `LKML <https://lore.kernel.org/lkml/>`_ and the web, too. If you
-don't find any to join, install `the latest mainline kernel
-<https://kernel.org/>`_. If the issue is present there, send a report.
-
-The issue was fixed there, but you would like to see it resolved in a still
-supported stable or longterm series as well? Then install its latest release.
-If it shows the problem, search for the change that fixed it in mainline and
-check if backporting is in the works or was discarded; if it's neither, ask
-those who handled the change for it.
-
-**General remarks**: When installing and testing a kernel as outlined above,
-ensure it's vanilla (IOW: not patched and not using add-on modules). Also make
-sure it's built and running in a healthy environment and not already tainted
-before the issue occurs.
-
-If you are facing multiple issues with the Linux kernel at once, report each
-separately. While writing your report, include all information relevant to the
-issue, like the kernel and the distro used. In case of a regression, CC the
-regressions mailing list (regressions@lists.linux.dev) to your report. Also try
-to pin-point the culprit with a bisection; if you succeed, include its
-commit-id and CC everyone in the sign-off-by chain.
-
-Once the report is out, answer any questions that come up and help where you
-can. That includes keeping the ball rolling by occasionally retesting with newer
-releases and sending a status update afterwards.
+Reporting issues
+++++++++++++++++
+
+The short guide on reporting Linux kernel issues (aka "the TL;DR")
+==================================================================
+
+Rule out something external causes your kernel to misbehave: skim the output of
+``journalctl -k``; make sure the kernel is not tainted; consider a glitch in the
+environment (hardware, firmware, initramfs, distribution, file system, ...).
+
+If you deal with multiple issues, process each separately.
+
+Search `lore <https://lore.kernel.org/all/>`_ for earlier reports and fixes.
+Then the wider internet. Consult :ref:`MAINTAINERS <maintainers>` to determine
+how bugs for the affected driver or subsystem must be submitted. This is usually
+by mail and rarely bugzilla.kernel.org; if the driver or subsystem uses an
+externally archived list or one of various bug trackers, search those as well.
+
+In case you deal with a regression still occurring in a less than two (ideally:
+one) weeks old kernel that is vanilla or close to it: send a brief email to
+regressions@lists.linux.dev asking if the regression is known; consider
+continuing this guide right afterwards, but definitely do so if you do not
+receive a positive reply within three days.
+
+Verify the bug and in case of a regression potentially bisect it as described in
+Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst; alternatively
+perform these tasks through different measures as outlined in more detailed
+step-by-step guide below.
+
+Were you unable to reproduce a bug with a mainline kernel you want to see fixed
+in a stable or longterm series? A bug that is not a regression? Then move over
+to 'Resolving non-regressions only occurring in stable or longterm kernels'.
+
+Compile a report with all important details. This always includes the
+distribution and kernel version used. Most of the time you also want to describe
+relevant aspects of your system and make the kernel's log messages available; do
+the same for everything else most likely relevant. In case of a regression, make
+that aspect obvious in the title; also specify the last working and first broken
+early in the body.
+
+Submit your report in the appropriate way, which depends on the outcome of the
+verification:
+
+* Are you facing a regression within a stable or longterm kernel series you were
+  unable to reproduce in a mainline kernel? Then report it by email to the
+  stable team while CCing the regressions list (e.g. To: Greg Kroah-Hartman
+  <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>;
+  CC: stable@vger.kernel.org, regressions@lists.linux.dev) and everyone in the
+  culprit's 'Signed-off-by' chain.
+
+* In all other cases, submit the report as specified in MAINTAINERS. In case of
+  a regression you have to report by mail, CC the regressions list
+  (regressions@lists.linux.dev); when you know the culprit, also CC everyone in
+  its 'Signed-off-by' chain. In case of a regression you have to file in a bug
+  tracker, write a short heads-up email with a link to the report to the list
+  once you have done so -- if the culprit is known, CC everyone that signed the
+  culprit off, too.
+
+Answer any questions in a timely manner and help where you can to resolve the
+issue. Retest with at least every first release candidate (-rc1) of a new
+mainline version and report your findings.
+
 
 The detailed step-by-step guide on reporting Linux kernel issues
 ================================================================
-- 
2.44.0


