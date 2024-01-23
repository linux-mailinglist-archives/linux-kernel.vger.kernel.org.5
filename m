Return-Path: <linux-kernel+bounces-35708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1035839569
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7240B1F30721
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785E21292D5;
	Tue, 23 Jan 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erTxn/UG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/45NMdQW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002B82D73;
	Tue, 23 Jan 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028443; cv=none; b=UNNB/CMVSMDN1gfCBFMZul782d/JEQVQ8SwWVngRl4j+JNfGIp4FtN5C76nbxmkob77U85Pv48qL8gxdcgwmRVad6yghSPO0EsGKX6riEJXBR1LhLuHWS2QlSrHzW7QuPER4JRpQ5X/Sj0yFjOVxEpgkUn8fa9gka5I59AC3RX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028443; c=relaxed/simple;
	bh=R2XU6nCysWoBfcCiBV9o40hPodsH/YkZepizm38mysc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHKRo4iLU/opB7qqiDA342ONqsboX4rIHxsbMOI+gJ71B3AkoJ5ZuWL8iETnqU51OfacnXcVBXQ/DPFLu9gE/zRTVLtclPGinOlTN4m5uY1zyVXcX4GIB9byr5USDr93obGrpJDmP69OxiymD+ZlhgYlAPZye0+mdd5kjT2nSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erTxn/UG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/45NMdQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v56TOhPHDVLk12cYFc3wY5Njq/3+mXzyMEHeyZ6UrJY=;
	b=erTxn/UGENeyYM4crwXW7kYiH6Bnlp/9P41fcyVabv2aEcL3J+c3vUVgAK3KQySDiXHDLm
	9yBcvlqaj94J6LWhEsPVyqCGukoE9kTjte5Z6vx3KOnAPz4yEbWBaGxUB221Si89lWQFNC
	KyrRnav7aMoidAwMUMqBHfiRyLSayKEZ6SrpfZPpz9/5eOMNT2M6upLJuyLEHMp1dippy+
	TLox5h9x+1+yNilCNdQVeObe5bIE3Wx32PLVrMXL6ELBcUhbyyjcHe3t3oKALkcRWQ1oTD
	Lm1LVOGRSYseC9muz6nL20g187W23gsiExcNhOrrcq7XfiDeyf1Y2ECkEFxNkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v56TOhPHDVLk12cYFc3wY5Njq/3+mXzyMEHeyZ6UrJY=;
	b=/45NMdQWFfEH1hTiyMswsXkyzw5jlZA1lD+Mg2yh8Q4sdE8AwXuNxkPuwj/kR5O2TDm1OI
	hnNt+DFzLGsoS2CA==
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
Subject: [PATCH 7/8] Documentation: Move "core core" api into a separate file
Date: Tue, 23 Jan 2024 17:47:01 +0100
Message-Id: <20240123164702.55612-8-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some "core core" API as timer API is documented in driver-api. This is
definitely the wrong place. As the subject description in
core-api/index.rst mentions, is also core-api/kernel-api.rst a collection
of leftovers. Therefore create a new core-api file and start to integrate
timer api. As this contains a lot of functions, it is separated into a
timer specific API file.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/core-api/core-api.rst     | 14 ++++++
 Documentation/core-api/index.rst        |  4 +-
 Documentation/core-api/kernel-api.rst   | 12 +++--
 Documentation/core-api/timers/api.rst   | 63 +++++++++++++++++++++++++
 Documentation/core-api/timers/index.rst |  4 ++
 Documentation/driver-api/basics.rst     | 24 ----------
 6 files changed, 93 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/core-api/core-api.rst
 create mode 100644 Documentation/core-api/timers/api.rst

diff --git a/Documentation/core-api/core-api.rst b/Documentation/core-api/core-api.rst
new file mode 100644
index 000000000000..4fe00d084dc7
--- /dev/null
+++ b/Documentation/core-api/core-api.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+The Linux Kernel Core API
+=========================
+
+.. note:: Some Core API is still documented in :doc:`../driver-api/basic` and
+          needs to be moved here. As this document will be huge when it contains
+          the whole API, split the API for a special part into a separate file.
+
+Timers
+======
+
+For timer related API, please refere to :doc:`timers/api`.
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 5aac1bdc411e..ed239269253a 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -11,12 +11,14 @@ Core utilities
 This section has general and "core core" documentation.  The first is a
 massive grab-bag of kerneldoc info left over from the docbook days; it
 should really be broken up someday when somebody finds the energy to do
-it.
+it. :doc:`core-api` is a first step to clean things up. It should only
+contain "core core" API documentation.
 
 .. toctree::
    :maxdepth: 1
 
    kernel-api
+   core-api
    workqueue
    watch_queue
    printk-basics
diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388..13b808084881 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -1,7 +1,13 @@
-====================
-The Linux Kernel API
-====================
+===========================
+The Linux Kernel (Misc) API
+===========================
+
+.. warning::
+   This API description is not the "core core" API description. It can be
+   found in :doc:`core-api`.
 
+   This document contains a collection of kernel related APIs and needs to
+   be split and sorted when there is time.
 
 List Management Functions
 =========================
diff --git a/Documentation/core-api/timers/api.rst b/Documentation/core-api/timers/api.rst
new file mode 100644
index 000000000000..4a84714d3933
--- /dev/null
+++ b/Documentation/core-api/timers/api.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Timers API
+==========
+
+Working with jiffies
+====================
+
+.. kernel-doc:: include/linux/jiffies.h
+   :identifiers: get_jiffies_64 jiffies_to_nsecs msecs_to_jiffies usecs_to_jiffies
+
+.. kernel-doc:: kernel/time/time.c
+   :no-identifiers: mktime64 set_normalized_timespec64 ns_to_timespec64 get_timespec64 put_timespec64 get_old_timespec32 put_old_timespec32 get_itimerspec64 put_itimerspec64 get_old_itimerspec32 put_old_itimerspec32
+
+.. kernel-doc:: kernel/time/timer.c
+   :identifiers: __round_jiffies __round_jiffies_relative round_jiffies round_jiffies_relative __round_jiffies_up __round_jiffies_up_relative round_jiffies_up round_jiffies_up_relative
+
+Jiffie based time comparison helpers
+====================================
+
+.. kernel-doc:: include/linux/jiffies.h
+   :doc: General information about time_* inlines
+
+.. kernel-doc:: include/linux/jiffies.h
+   :no-identifiers: time_comparision_disclaimer get_jiffies_64 jiffies_to_nsecs msecs_to_jiffies usecs_to_jiffies
+
+
+Timespec related functions
+==========================
+
+.. kernel-doc:: kernel/time/time.c
+   :identifiers: mktime64 set_normalized_timespec64 ns_to_timespec64 get_timespec64 put_timespec64 get_old_timespec32 put_old_timespec32 get_itimerspec64 put_itimerspec64 get_old_itimerspec32 put_old_itimerspec32
+
+
+Handle timer list timers
+========================
+
+.. kernel-doc:: kernel/time/timer.c
+   :identifiers: init_timer_key mod_timer_pending mod_timer timer_reduce add_timer add_timer_local add_timer_global add_timer_on timer_delete timer_shutdown try_to_del_timer_sync
+
+
+Timeout and sleeping
+====================
+
+.. kernel-doc:: kernel/time/timer.c
+   :identifiers: schedule_timeout msleep msleep_interruptible usleep_range_state
+
+ktime_t operations
+==================
+
+.. kernel-doc:: include/linux/ktime.h
+   :internal:
+
+
+High-Resolution Timers
+======================
+
+.. kernel-doc:: include/linux/hrtimer.h
+   :internal:
+
+.. kernel-doc:: kernel/time/hrtimer.c
+   :export:
diff --git a/Documentation/core-api/timers/index.rst b/Documentation/core-api/timers/index.rst
index e0a985fe4f89..2f99fc9d4f44 100644
--- a/Documentation/core-api/timers/index.rst
+++ b/Documentation/core-api/timers/index.rst
@@ -16,6 +16,10 @@ kernel/timers/ and also the timer related includes.
 Information for Users
 =====================
 
+.. toctree::
+   :maxdepth: 1
+
+   api
 
 
 Information about concepts and internals
diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index d78b7c328ff7..0e352682bbc7 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -33,30 +33,6 @@ Delaying and scheduling routines
 .. kernel-doc:: include/linux/completion.h
    :internal:
 
-Time and timer routines
------------------------
-
-.. kernel-doc:: include/linux/jiffies.h
-   :internal:
-
-.. kernel-doc:: kernel/time/time.c
-   :export:
-
-.. kernel-doc:: kernel/time/timer.c
-   :export:
-
-High-resolution timers
-----------------------
-
-.. kernel-doc:: include/linux/ktime.h
-   :internal:
-
-.. kernel-doc:: include/linux/hrtimer.h
-   :internal:
-
-.. kernel-doc:: kernel/time/hrtimer.c
-   :export:
-
 Wait queues and Wake events
 ---------------------------
 
-- 
2.39.2


