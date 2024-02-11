Return-Path: <linux-kernel+bounces-60663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0385082D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFFC1F21FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A859B69;
	Sun, 11 Feb 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VCaNEBWD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+7EXb7NJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F359143;
	Sun, 11 Feb 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640894; cv=none; b=D8xL8GOfMpKAiTrqia3qa9u0g3eNW5rZkQ9OhseQCHveEC27kmGv4b2qWldr6o7u+/Jtm2LqafdR1L1vaWy0P/ALD1q2q5K9CBTvpK7gXWs7iwjkux7rOwJ1TUeHNeCddM+y2hvQyhJYvfaiDsOfSTlynfkOhnxg13ywquB4zLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640894; c=relaxed/simple;
	bh=WtlDmob9I/0dez6+y0uQwwFTBe2RrcalW/ddVLuBeAY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ovzoEyPwjj/bTfyRK1lJ1uYSxAABOdOQZprIye/LwAt8B7d1KFeMbl3GY9l8JmHMbl8reXDDbYPnuPjgyRorOvd1eDY1e3XCcjrSFSGZS+HPGzFULtBeY24MWV3yFrz7WrcYUUsgcjlQv/Gxronf/W/rQw9AFNh+dDET+sQmP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VCaNEBWD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+7EXb7NJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg9fkFE79qy3rCvd5+KVpIg5ZtbHYmtSAApFU4aQszQ=;
	b=VCaNEBWDkkEg5/USqtYZu8KChtS6myt0ypn65DEZmgifDOFljt1bWFCtDIJ/jUI3CfnvBx
	/6mAa3T8FTyUeLQizA9/OCSJ1+ruTn47wr3JEU4ZYFHWSOrUxjhcKvDqQld1eST20htgPS
	JP4ZJO0TSeUbzyNNdU4HCgtoe7BQlsxo/PRQliPH2mCzX3z8d4lDLHmTLaOfel6cBiBoWK
	VpqOiXopr6u3/w/BpCPJNCxMsBGrkpwr8nZTK2ZVYMWRtO4YHgwtqssKvNhgzCMS6F0yGS
	2b6j5HvEpvqhFZiiTIulFl8QZnIaHqndCqTEN0wfUL+HUxQ5/WqHNNxaYWIBiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg9fkFE79qy3rCvd5+KVpIg5ZtbHYmtSAApFU4aQszQ=;
	b=+7EXb7NJglm1XPCKWAgPe5XOcL95I4YrLIMxLyzJUOZPHsaeaKP/8XedtnRWC+CgcK3zLW
	ShmF9cNfyLpR9+Cw==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] ptp/kvm, arm_arch_timer: Set
 system_counterval_t.cs_id to constant
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-6-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-6-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764088998.398.12620649655948609348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     9be3b2f057d7a6752e8cf25c1d456198b4d3bd6a
Gitweb:        https://git.kernel.org/tip/9be3b2f057d7a6752e8cf25c1d456198b4d3bd6a
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

ptp/kvm, arm_arch_timer: Set system_counterval_t.cs_id to constant

Identify the clocksources used by ptp_kvm by setting the clocksource ID
enum constants. This avoids dereferencing struct clocksource. Once the
system_counterval_t.cs member will be removed, this will also avoid the
need to obtain clocksource pointers from kvm_arch_ptp_get_crosststamp().

The clocksource IDs are associated to timestamps requested from the KVM
hypervisor, so the proper clocksource ID is known at the ptp_kvm request
site.

While at it, also make the ptp_kvm_get_time_fn() 'ret' variable type int as
that's what the function return value is.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-6-peter.hilber@opensynergy.com
---
 drivers/clocksource/arm_arch_timer.c |  5 ++++-
 drivers/ptp/ptp_kvm_arm.c            |  2 +-
 drivers/ptp/ptp_kvm_common.c         | 10 +++++-----
 drivers/ptp/ptp_kvm_x86.c            |  4 +++-
 include/linux/ptp_kvm.h              |  4 +++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e054de9..45a0287 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1807,7 +1807,8 @@ TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
 
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
-				 struct clocksource **cs)
+				 struct clocksource **cs,
+				 enum clocksource_ids *cs_id)
 {
 	struct arm_smccc_res hvc_res;
 	u32 ptp_counter;
@@ -1833,6 +1834,8 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
 		*cycle = (u64)hvc_res.a2 << 32 | hvc_res.a3;
 	if (cs)
 		*cs = &clocksource_counter;
+	if (cs_id)
+		*cs_id = CSID_ARM_ARCH_COUNTER;
 
 	return 0;
 }
diff --git a/drivers/ptp/ptp_kvm_arm.c b/drivers/ptp/ptp_kvm_arm.c
index e68e694..017bb5f 100644
--- a/drivers/ptp/ptp_kvm_arm.c
+++ b/drivers/ptp/ptp_kvm_arm.c
@@ -28,5 +28,5 @@ void kvm_arch_ptp_exit(void)
 
 int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 {
-	return kvm_arch_ptp_get_crosststamp(NULL, ts, NULL);
+	return kvm_arch_ptp_get_crosststamp(NULL, ts, NULL, NULL);
 }
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index b0b36f1..f6683ba 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2017 Red Hat Inc.
  */
-#include <linux/clocksource.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -29,15 +28,16 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 			       struct system_counterval_t *system_counter,
 			       void *ctx)
 {
-	long ret;
-	u64 cycle;
+	enum clocksource_ids cs_id;
 	struct timespec64 tspec;
 	struct clocksource *cs;
+	u64 cycle;
+	int ret;
 
 	spin_lock(&kvm_ptp_lock);
 
 	preempt_disable_notrace();
-	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs);
+	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs, &cs_id);
 	if (ret) {
 		spin_unlock(&kvm_ptp_lock);
 		preempt_enable_notrace();
@@ -48,7 +48,7 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 
 	system_counter->cycles = cycle;
 	system_counter->cs = cs;
-	system_counter->cs_id = cs->id;
+	system_counter->cs_id = cs_id;
 
 	*device_time = timespec64_to_ktime(tspec);
 
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 902844c..2782442 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -93,7 +93,8 @@ int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 }
 
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
-			      struct clocksource **cs)
+			      struct clocksource **cs,
+			      enum clocksource_ids *cs_id)
 {
 	struct pvclock_vcpu_time_info *src;
 	unsigned int version;
@@ -124,6 +125,7 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
 	} while (pvclock_read_retry(src, version));
 
 	*cs = &kvm_clock;
+	*cs_id = CSID_X86_KVM_CLK;
 
 	return 0;
 }
diff --git a/include/linux/ptp_kvm.h b/include/linux/ptp_kvm.h
index 746fd67..95b3d4d 100644
--- a/include/linux/ptp_kvm.h
+++ b/include/linux/ptp_kvm.h
@@ -8,6 +8,7 @@
 #ifndef _PTP_KVM_H_
 #define _PTP_KVM_H_
 
+#include <linux/clocksource_ids.h>
 #include <linux/types.h>
 
 struct timespec64;
@@ -17,6 +18,7 @@ int kvm_arch_ptp_init(void);
 void kvm_arch_ptp_exit(void);
 int kvm_arch_ptp_get_clock(struct timespec64 *ts);
 int kvm_arch_ptp_get_crosststamp(u64 *cycle,
-		struct timespec64 *tspec, struct clocksource **cs);
+		struct timespec64 *tspec, struct clocksource **cs,
+		enum clocksource_ids *cs_id);
 
 #endif /* _PTP_KVM_H_ */

