Return-Path: <linux-kernel+bounces-35707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061A839567
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184F028C0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD61292CC;
	Tue, 23 Jan 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XkGu8/FQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxVJkuBH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDF82D62;
	Tue, 23 Jan 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028443; cv=none; b=MKbMQd1Ij9cbpDV2UlPx2CzHCyRaW8CDtyDlZsD7v1z50lbRNwI1I3QpfiMOd2N1qT4S4TaGIf79j0/hCnpkRJ8LZyeanl5vRGJBlyaqVIL7PTNVwws+/lgfTTGeeZVRNgYYqMw0bjx2s/tXEPoSd5MJAE+7H3iLp9Og49USOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028443; c=relaxed/simple;
	bh=hQbL/bTWo5b/f0fUHYOc6fJKjPDV7lRgpxdNJ+4o7iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMxFYNzYhggcTLOKodbhKnXMx8EfmvwZ19CPsvyGyMidUiy15Rcce1cTMZK7HzBQPItfwh340hsmMhIII2fwonbsgAFUFtPsWy7qGxcFenf0JOwWM5/OTgbgLkYQ0hMYbMN8vZTiI7l1fVUGqSzSrDsdWQna0YqFJDsBVwrPDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XkGu8/FQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxVJkuBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pISPf/npImhbjYhJnYCx42aZMFasXDW5I0m3JI4CPiM=;
	b=XkGu8/FQf/4pPZZTdEI2xfbNsNtmlFv2HJ8eXGczGkr8A/d7D9qjFnIsPRJv0GflZ1xImp
	ex7Ys39yxtHsxtD+b1yRfekzR2sXhOhjmkP7ZRc7b4AV04ON7gWDGpgbEdC0qS6l4wkHvA
	nIr6Krs1Zjg8gfAc+BVnQGKBep9ndYnIzVZ6a+OUro6ljY6kzmhF+i565FhRubLqzkm1VR
	K1TmOx4s6J/ND8Na961e82SNttCDtk8uyOFGcctVx5Ielnoh8EJ9MzWePosNw4p5BN7Z3d
	xgcS5r6yeV3mLHr0exYauwdnj9gQ5Xw4q20OavN+Xc/va9os8WtDxaDRsBdIcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pISPf/npImhbjYhJnYCx42aZMFasXDW5I0m3JI4CPiM=;
	b=RxVJkuBH0lZE7LBg9cPxRbknZhFc/wp7Fa+ZPjMBU60tk45DrOcPu9QdVD5nq3tmgIPe2+
	4gnZbSclEBwzOWBg==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 6/8] Documentation: Create a new folder for all timer internals
Date: Tue, 23 Jan 2024 17:47:00 +0100
Message-Id: <20240123164702.55612-7-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure of documentation changed. There is 'core-api' where also
timer related documentation belongs to. But the timer related documentation
(doesn't matter whether it is up to date or outdated) is still located in a
separate folder with no relation to core-api.

Create a new folder which is located below core-api and make it the new
place for all timer related documentation. Instead of revisiting all files
below the already existing timer folder right now, add a warning banner to
the top of all those files. When it is ensured the content is up to date,
they can be moved to the final destination.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/core-api/index.rst        |  1 +
 Documentation/core-api/timers/index.rst | 22 ++++++++++++++++++++++
 Documentation/timers/highres.rst        |  5 +++++
 Documentation/timers/hpet.rst           |  5 +++++
 Documentation/timers/hrtimers.rst       |  5 +++++
 Documentation/timers/index.rst          |  5 +++++
 Documentation/timers/no_hz.rst          |  4 ++++
 Documentation/timers/timekeeping.rst    |  5 +++++
 Documentation/timers/timers-howto.rst   |  5 +++++
 9 files changed, 57 insertions(+)
 create mode 100644 Documentation/core-api/timers/index.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a3a08d81f11..5aac1bdc411e 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -128,6 +128,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
 
    librs
    netlink
+   timers/index
 
 .. only:: subproject and html
 
diff --git a/Documentation/core-api/timers/index.rst b/Documentation/core-api/timers/index.rst
new file mode 100644
index 000000000000..e0a985fe4f89
--- /dev/null
+++ b/Documentation/core-api/timers/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Timers
+======
+
+This is all timer core related documentation. It is split into two
+sections. The first will provide all information for people who simply want
+to use timers. The second contains all information which are required by
+developers who want to dive deeper into the concepts and implementation of
+the timer infrastructure.
+
+The documentation should cover all files, which are located below
+kernel/timers/ and also the timer related includes.
+
+Information for Users
+=====================
+
+
+
+Information about concepts and internals
+========================================
diff --git a/Documentation/timers/highres.rst b/Documentation/timers/highres.rst
index bde5eb7e5c9e..14bf4e680b59 100644
--- a/Documentation/timers/highres.rst
+++ b/Documentation/timers/highres.rst
@@ -2,6 +2,11 @@
 High resolution timers and dynamic ticks design notes
 =====================================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 Further information can be found in the paper of the OLS 2006 talk "hrtimers
 and beyond". The paper is part of the OLS 2006 Proceedings Volume 1, which can
 be found on the OLS website:
diff --git a/Documentation/timers/hpet.rst b/Documentation/timers/hpet.rst
index c9d05d3caaca..1459555048d9 100644
--- a/Documentation/timers/hpet.rst
+++ b/Documentation/timers/hpet.rst
@@ -2,6 +2,11 @@
 High Precision Event Timer Driver for Linux
 ===========================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 The High Precision Event Timer (HPET) hardware follows a specification
 by Intel and Microsoft, revision 1.
 
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index f88ff8bae89c..ce8a7b5c1387 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -2,6 +2,11 @@
 hrtimers - subsystem for high-resolution kernel timers
 ======================================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 This patch introduces a new subsystem for high-resolution kernel timers.
 
 One might ask the question: we already have a timer subsystem
diff --git a/Documentation/timers/index.rst b/Documentation/timers/index.rst
index 983f91f8f023..f99b26430a1d 100644
--- a/Documentation/timers/index.rst
+++ b/Documentation/timers/index.rst
@@ -4,6 +4,11 @@
 Timers
 ======
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 .. toctree::
     :maxdepth: 1
 
diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index f8786be15183..04cb41c53eb7 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -2,6 +2,10 @@
 NO_HZ: Reducing Scheduling-Clock Ticks
 ======================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
 
 This document describes Kconfig options and boot parameters that can
 reduce the number of scheduling-clock interrupts, thereby improving energy
diff --git a/Documentation/timers/timekeeping.rst b/Documentation/timers/timekeeping.rst
index f83e98852e2c..36d02d4fc085 100644
--- a/Documentation/timers/timekeeping.rst
+++ b/Documentation/timers/timekeeping.rst
@@ -2,6 +2,11 @@
 Clock sources, Clock events, sched_clock() and delay timers
 ===========================================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 This document tries to briefly explain some basic kernel timekeeping
 abstractions. It partly pertains to the drivers usually found in
 drivers/clocksource in the kernel tree, but the code may be spread out
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
index 5c169e3d29a8..bdf34453339a 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -2,6 +2,11 @@
 delays - Information on the various kernel delay / sleep mechanisms
 ===================================================================
 
+.. warning:: Documents in this folder might be outdated, as they haven't
+	     been revisited for a longer time. Up to date documentation is
+	     located in the core-api documentation:
+	     :doc:`../core-api/timers/index`
+
 This document seeks to answer the common question: "What is the
 RightWay (TM) to insert a delay?"
 
-- 
2.39.2


