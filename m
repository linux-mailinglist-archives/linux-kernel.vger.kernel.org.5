Return-Path: <linux-kernel+bounces-60664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984385082E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F291D1F22A14
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB159B74;
	Sun, 11 Feb 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/svAXlK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kp2SRcC9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3E5914F;
	Sun, 11 Feb 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640894; cv=none; b=hh2bbZ+PBfRXjUy8uR55/1H0ObJg2XyWIzOYfBweD5DrmIpd+QWh6BOWGz6Hm765TuHPfkVJk4KdN/0t4Cwpi5JH8DYzddx3gBWFgt89W/v/X/gh1O5v3U4GRuanU7sVqrQMHNzf4YY04wjdpr7t/ES1vefMDACtZXfg5+ELAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640894; c=relaxed/simple;
	bh=eMI1H9E2hbAvc+crFYzOiXeUD06o3YTPirTX3f4yv0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qEWqyRJJAG0ExrS46fN0TkAVlDCzQ9TmwGO5992LCyiZftqmAGSGfep7GFzHrmoAl6o6OZg9o3ZLrkZDeahp7Oo0/7IygHJNGGtuiF9WZlPKTzLABDm+zAjwjVJ6Z6iUKdbFxFImxfEiH/azI6l24FcYLbtsYkkkpMUSq77auS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/svAXlK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kp2SRcC9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVpjmDPxQYdVOTD09wDoa7NCF6DwXAMTzVJVqTgUlT8=;
	b=B/svAXlKRr6gBBUK5DHbCCQ32fE8Iij7pa3lLHeaC51pUgWpsWbKcrZ+KK6t9juGO17egF
	vxNWKPE4JRDHf29uTX6uZwWT6SyiJlNM5axWUn2hBHetSUminOGnfOZJ/8d8b0VNR5jjNM
	WntyzGq8vldyoGro+gxYrFTgH5ffsBIQ2PuxFPozOCo708wkLr/O2F9TWHOlY32ybphRIE
	RbRDuQ7Jzhz4HZThNFFdo4y3//6GnFOlEY5MXT0HiDjSllMs8Vn2nEV8r7vwOokOs60xcH
	fWf6yc/zgCvnMV+YHaF3tT4FthNqTH58f0046OEdEw9KBmEMAqSCNKBrdu/Ejw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVpjmDPxQYdVOTD09wDoa7NCF6DwXAMTzVJVqTgUlT8=;
	b=kp2SRcC9a1/Vh5cJlggmrCKL2PSIP982re/6O5DezK3YTeKvd1INDQO7uobNyNxQNp79qb
	nKnL+o82h9ltLgBg==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] x86/kvm, ptp/kvm: Add clocksource ID, set
 system_counterval_t.cs_id
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-5-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-5-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764089059.398.1435801360306795593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     576bd4962f19bb8f437f8cecbb25e4202438c41e
Gitweb:        https://git.kernel.org/tip/576bd4962f19bb8f437f8cecbb25e4202438c41e
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

x86/kvm, ptp/kvm: Add clocksource ID, set system_counterval_t.cs_id

Add a clocksource ID for the x86 kvmclock.

Also, for ptp_kvm, set the recently added struct system_counterval_t member
cs_id to the clocksource ID (x86 kvmclock or ARM Generic Timer). In the
future, get_device_system_crosststamp() will compare the clocksource ID in
struct system_counterval_t, rather than the clocksource.

For now, to avoid touching too many subsystems at once, extract the
clocksource ID from the clocksource. The clocksource dereference will be
removed once everything is converted over..

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-5-peter.hilber@opensynergy.com
---
 arch/x86/kernel/kvmclock.c      | 1 +
 drivers/ptp/ptp_kvm_common.c    | 2 ++
 include/linux/clocksource_ids.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5bb3955..2f1bbf7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -160,6 +160,7 @@ struct clocksource kvm_clock = {
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.id     = CSID_X86_KVM_CLK,
 	.enable	= kvm_cs_enable,
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index 2418977..b0b36f1 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2017 Red Hat Inc.
  */
+#include <linux/clocksource.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -47,6 +48,7 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 
 	system_counter->cycles = cycle;
 	system_counter->cs = cs;
+	system_counter->cs_id = cs->id;
 
 	*device_time = timespec64_to_ktime(tspec);
 
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index f846794..a4fa343 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -8,6 +8,7 @@ enum clocksource_ids {
 	CSID_ARM_ARCH_COUNTER,
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
+	CSID_X86_KVM_CLK,
 	CSID_MAX,
 };
 

