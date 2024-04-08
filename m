Return-Path: <linux-kernel+bounces-135401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCA89C0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D71D1C23DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45880039;
	Mon,  8 Apr 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wmFVMon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPZTOh2z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBB76413;
	Mon,  8 Apr 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581845; cv=none; b=ox1wYGcGaVAVVJaXdpUNAi6bLLFsICU+rKI+RF4DuF+nXWzYBb5ukudXvL4XxYp8YZwzB89n9v0dZYP47KOMb31UJkJzaMWM4imWCSp3q/9v7m7IaBm1Qe6xMoCU89YUZ1RKDY/ZegrrsYxd5G1kjkI7J+tSmtMTSUUtIQ942to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581845; c=relaxed/simple;
	bh=xWkM++z4XDe3BUHMgcTksgmm8NkHqonvYZaZmzmy0aY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BZzVSRUX+Uy0fenJL1GQ+AHxnK1FQLfIVFR+VcTcsdY6DiOWGikbtStMqHrscxOcwFMQmWiEXSeRqX9Vc7RRV1C2KvSAaboQ5uHDsHKKCZoLghiFu6gU5ER7/LYgFbPJX3Gtx5evlpAhJXok6pdNdZ9IqyCnadTeZr23dtZvC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wmFVMon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPZTOh2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVZVaBvn9aDfafgYSfE8670i5W/7C/ZTQa3qTYzRXLI=;
	b=4wmFVMonteEU5rzwivDpXyZTd3Nsc0/UlkKXBYhbA8Xr7AcFsck56EtfNUxrFCt+VMwuGn
	rVSZN8ImKt5S5sdA4oux9LRZtphn6lAfW+39E5kf7YIoc5QusqUs9Kje++aSvJYhvurpi1
	EpsgOtYwV9JFAm9DkdYs9u/u70XbYpFZ7Ph3+49sj/gw2GfHHaupCTWi2JRk288ZBAHLI2
	GEkI4DYWDu4P4BleMCiJtbrDko0D/eVU/cDQeCo6mAf0qK/tD7t0M0BcRtlixlOWu8zJwq
	VnJ6k2mOhx9WGAi2RRek4ypW0o9pOy9Eon6TasyWFMTvY3FG+WKvHGv6TD0VWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVZVaBvn9aDfafgYSfE8670i5W/7C/ZTQa3qTYzRXLI=;
	b=ZPZTOh2zhTzP63puAv8hPpYybdWyh+W+jxChOEAMPfBHE2POcFV9c6BOVKRDAgwLZUgjgp
	UHNaY5vL3Ll7PxDA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Add vdso_data:: Max_cycles
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-7-adrian.hunter@intel.com>
References: <20240325064023.2997-7-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184114.10875.5065216639475428320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d2e58ab5cda2a225c406ac10d0a8b960bc5a39b6
Gitweb:        https://git.kernel.org/tip/d2e58ab5cda2a225c406ac10d0a8b960bc5a39b6
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

vdso: Add vdso_data:: Max_cycles

Add vdso_data::max_cycles in preparation to use it to detect potential
multiplication overflow.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-7-adrian.hunter@intel.com

---
 include/vdso/datapage.h | 4 ++++
 kernel/time/vsyscall.c  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index c71ddb6..d04d394 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -61,6 +61,7 @@ struct vdso_timestamp {
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
+ * @max_cycles:		maximum cycles which won't overflow 64bit multiplication
  * @mask:		clocksource mask
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
@@ -92,6 +93,9 @@ struct vdso_data {
 
 	s32			clock_mode;
 	u64			cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	u64			max_cycles;
+#endif
 	u64			mask;
 	u32			mult;
 	u32			shift;
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index f0d5062..9193d61 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -22,10 +22,16 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	u64 nsec, sec;
 
 	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_HRES_COARSE].max_cycles	= tk->tkr_mono.clock->max_cycles;
+#endif
 	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
 	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
 	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
 	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_RAW].max_cycles		= tk->tkr_raw.clock->max_cycles;
+#endif
 	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
 	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
 	vdata[CS_RAW].shift			= tk->tkr_raw.shift;

