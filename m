Return-Path: <linux-kernel+bounces-146617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919458A683D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446B42817A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA4127B5D;
	Tue, 16 Apr 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L3rfRZa+"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638F127E15;
	Tue, 16 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263043; cv=none; b=q4yx1Zoes9H5kwTaK7q4P+4HVviUkYdQZC/8h5JhToj6iWvDuq3C8c4QjLWGRtwvDKdfjZhiDxFbein/D7fDbbSIlFVaZwEoAfn5ekh69VpzPAQ5mXNrmiKhHk7S1qKCm3+mE6Moe+FOwHs90ZL0rmdzPR+S6xXoDk3/CfEEBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263043; c=relaxed/simple;
	bh=gxG9czpJSL7gSbhmQrt5XQ+5u3ojcmcGsSG+RdUKnnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFg8M4L9AczYMoxWMR3BQlPS6gL9W/lhzC7E2YcIMD9y3JdOgtQsuCM5FVb9xcgZtwDse59V2X4LmLALz2pn9Bks+kfsAXjqYHLvn9jOYGXOHFUO2JNdip1+HdhrdO4c/clIHqCqqkQ7MGiWohrGPzxafB02ufpjgCUE4D0VQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L3rfRZa+; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263041; x=1744799041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxG9czpJSL7gSbhmQrt5XQ+5u3ojcmcGsSG+RdUKnnA=;
  b=L3rfRZa+Q54rCZUZs8AA8pE1Z9V6WzYADqhwvWBJvT0XDZQphkNbAu/1
   YVH9+10kbgC2e6C32BmfxsyLoxqUDSX4eUwZ/DRbPG1Hc17qVOnZRKDCM
   Bec8PVhNoGJxhP2O8t7lXvLoLo82l74AJu7qXgVtXrt3tLY90ekLK70Z5
   ZqddjW4JTAkmxzOFORPV2B8TQwqNN9peGjV56ffQJvF0jJPFqyhs2o9l1
   xacXEO8osHCfYYNuJEk7wMKAb6SOa1Evu/Wz85vtsZR8pEhNO/gAFNyai
   J/sKTH90T5/m1pVSQYTstOQN0TS6D1EK2U0l3VgCrfTuVm8QWDUegHVlH
   A==;
X-CSE-ConnectionGUID: v8QcaLGoT46KtVSkqDMUFA==
X-CSE-MsgGUID: 2md/m5qrReu13G/59KPnYg==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="13887177"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:24:00 +0800
IronPort-SDR: nPJqVM20OagVQqOLy9HP1A8vOBFc5kaWFXwTDrMgzzneuk2SYWo1yUqd8RkPCOgLakCX+5mqBY
 hOMGdVg5vdtA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:26:39 -0700
IronPort-SDR: 8/MAnK7w5emHD/Ledi7iPnkOWa7k7nfmwI+rj2Cd8zIPgyiQ76sAq7iI5+dgM1Tt20Pau1P0iP
 aUY+wnvu8f58Cil7tkRc/e6r5qok7uwL35RwoSwW8wIFB1EH8EfiuxLOLXlUqeAcu8MmhiYnrB
 ELd2latKSiyE/xV+PAIs6xeVSmSC0OyyPt2zPQYJWCp6lusdnRaRyOxOXyz7MU2HnTOTVHGaXR
 0ydNuUsITCzymBbb4cx0CMpmx3J9/4TF9onZZ9OEnlDZuV8udHhyFfzfM0KzDKfX/rKYAA8xG3
 NKg=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2024 03:23:58 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/4] scsi: ufs: core: Make use of guard(spinlock_irqsave)
Date: Tue, 16 Apr 2024 13:23:45 +0300
Message-ID: <20240416102348.614-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416102348.614-1-avri.altman@wdc.com>
References: <20240416102348.614-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded handling with cleanup.h guard(spinlock_irqsave) and
scoped_guard(spinlock_irqsave, ...).

There are some explicit spin_lock_irqsave/spin_unlock_irqrestore snaking
instances I left behind because I couldn't make heads or tails of it.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 587 ++++++++++++++++----------------------
 1 file changed, 253 insertions(+), 334 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 823bc28c0cb0..6e35b597dfb5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
 #include <linux/iopoll.h>
+#include <linux/cleanup.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -130,6 +131,8 @@ MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from U
 		       16, 4, buf, __len, false);                        \
 } while (0)
 
+#define SERIALIZE_HOST_IRQSAVE(hba) guard(spinlock_irqsave)(hba->host->host_lock)
+
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix)
 {
@@ -1279,7 +1282,6 @@ static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
 static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 					u64 wait_timeout_us)
 {
-	unsigned long flags;
 	int ret = 0;
 	u32 tm_doorbell;
 	u32 tr_pending;
@@ -1287,28 +1289,27 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 	ktime_t start;
 
 	ufshcd_hold(hba);
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	/*
 	 * Wait for all the outstanding tasks/transfer requests.
 	 * Verify by checking the doorbell registers are clear.
 	 */
 	start = ktime_get();
 	do {
-		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
-			ret = -EBUSY;
-			goto out;
-		}
+		scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+			if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
+				ret = -EBUSY;
+				goto out;
+			}
 
-		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
-		tr_pending = ufshcd_pending_cmds(hba);
-		if (!tm_doorbell && !tr_pending) {
-			timeout = false;
-			break;
-		} else if (do_last_check) {
-			break;
+			tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
+			tr_pending = ufshcd_pending_cmds(hba);
+			if (!tm_doorbell && !tr_pending) {
+				timeout = false;
+				break;
+			} else if (do_last_check) {
+				break;
+			}
 		}
-
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
 		io_schedule_timeout(msecs_to_jiffies(20));
 		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
 		    wait_timeout_us) {
@@ -1320,7 +1321,6 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 			 */
 			do_last_check = true;
 		}
-		spin_lock_irqsave(hba->host->host_lock, flags);
 	} while (tm_doorbell || tr_pending);
 
 	if (timeout) {
@@ -1330,7 +1330,6 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 		ret = -EBUSY;
 	}
 out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_release(hba);
 	return ret;
 }
@@ -1477,17 +1476,13 @@ static void ufshcd_clk_scaling_suspend_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 					   clk_scaling.suspend_work);
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (hba->clk_scaling.active_reqs || hba->clk_scaling.is_suspended) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		return;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (hba->clk_scaling.active_reqs || hba->clk_scaling.is_suspended)
+			return;
+		hba->clk_scaling.is_suspended = true;
+		hba->clk_scaling.window_start_t = 0;
 	}
-	hba->clk_scaling.is_suspended = true;
-	hba->clk_scaling.window_start_t = 0;
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-
 	devfreq_suspend_device(hba->devfreq);
 }
 
@@ -1495,15 +1490,11 @@ static void ufshcd_clk_scaling_resume_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 					   clk_scaling.resume_work);
-	unsigned long irq_flags;
 
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (!hba->clk_scaling.is_suspended) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
+	if (!hba->clk_scaling.is_suspended)
 		return;
-	}
 	hba->clk_scaling.is_suspended = false;
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
 	devfreq_resume_device(hba->devfreq);
 }
@@ -1517,7 +1508,6 @@ static int ufshcd_devfreq_target(struct device *dev,
 	bool scale_up = false, sched_clk_scaling_suspend_work = false;
 	struct list_head *clk_list = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
-	unsigned long irq_flags;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
@@ -1538,43 +1528,37 @@ static int ufshcd_devfreq_target(struct device *dev,
 		*freq =	(unsigned long) clk_round_rate(clki->clk, *freq);
 	}
 
-	spin_lock_irqsave(hba->host->host_lock, irq_flags);
-	if (ufshcd_eh_in_progress(hba)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		return 0;
-	}
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ufshcd_eh_in_progress(hba))
+			return 0;
 
-	/* Skip scaling clock when clock scaling is suspended */
-	if (hba->clk_scaling.is_suspended) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		dev_warn(hba->dev, "clock scaling is suspended, skip");
-		return 0;
-	}
+		/* Skip scaling clock when clock scaling is suspended */
+		if (hba->clk_scaling.is_suspended) {
+			dev_warn(hba->dev, "clock scaling is suspended, skip");
+			return 0;
+		}
 
-	if (!hba->clk_scaling.active_reqs)
-		sched_clk_scaling_suspend_work = true;
+		if (!hba->clk_scaling.active_reqs)
+			sched_clk_scaling_suspend_work = true;
 
-	if (list_empty(clk_list)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		goto out;
-	}
+		if (list_empty(clk_list))
+			goto out;
 
-	/* Decide based on the target or rounded-off frequency and update */
-	if (hba->use_pm_opp)
-		scale_up = *freq > hba->clk_scaling.target_freq;
-	else
-		scale_up = *freq == clki->max_freq;
+		/* Decide based on the target or rounded-off frequency and update */
+		if (hba->use_pm_opp)
+			scale_up = *freq > hba->clk_scaling.target_freq;
+		else
+			scale_up = *freq == clki->max_freq;
 
-	if (!hba->use_pm_opp && !scale_up)
-		*freq = clki->min_freq;
+		if (!hba->use_pm_opp && !scale_up)
+			*freq = clki->min_freq;
 
-	/* Update the frequency */
-	if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
-		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
-		ret = 0;
-		goto out; /* no state change required */
+		/* Update the frequency */
+		if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
+			ret = 0;
+			goto out; /* no state change required */
+		}
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
 	start = ktime_get();
 	ret = ufshcd_devfreq_scale(hba, *freq, scale_up);
@@ -1598,7 +1582,6 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
-	unsigned long flags;
 	ktime_t curr_t;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
@@ -1606,7 +1589,8 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 
 	memset(stat, 0, sizeof(*stat));
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
+
 	curr_t = ktime_get();
 	if (!scaling->window_start_t)
 		goto start_window;
@@ -1642,7 +1626,7 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 		scaling->busy_start_t = 0;
 		scaling->is_busy_started = false;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	return 0;
 }
 
@@ -1706,19 +1690,18 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 
 static void ufshcd_suspend_clkscaling(struct ufs_hba *hba)
 {
-	unsigned long flags;
 	bool suspend = false;
 
 	cancel_work_sync(&hba->clk_scaling.suspend_work);
 	cancel_work_sync(&hba->clk_scaling.resume_work);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (!hba->clk_scaling.is_suspended) {
-		suspend = true;
-		hba->clk_scaling.is_suspended = true;
-		hba->clk_scaling.window_start_t = 0;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (!hba->clk_scaling.is_suspended) {
+			suspend = true;
+			hba->clk_scaling.is_suspended = true;
+			hba->clk_scaling.window_start_t = 0;
+		}
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	if (suspend)
 		devfreq_suspend_device(hba->devfreq);
@@ -1726,15 +1709,14 @@ static void ufshcd_suspend_clkscaling(struct ufs_hba *hba)
 
 static void ufshcd_resume_clkscaling(struct ufs_hba *hba)
 {
-	unsigned long flags;
 	bool resume = false;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->clk_scaling.is_suspended) {
-		resume = true;
-		hba->clk_scaling.is_suspended = false;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (hba->clk_scaling.is_suspended) {
+			resume = true;
+			hba->clk_scaling.is_suspended = false;
+		}
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	if (resume)
 		devfreq_resume_device(hba->devfreq);
@@ -1843,19 +1825,16 @@ static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
 static void ufshcd_ungate_work(struct work_struct *work)
 {
 	int ret;
-	unsigned long flags;
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 			clk_gating.ungate_work);
 
 	cancel_delayed_work_sync(&hba->clk_gating.gate_work);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->clk_gating.state == CLKS_ON) {
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-		return;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (hba->clk_gating.state == CLKS_ON)
+			return;
 	}
 
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	ufshcd_hba_vreg_set_hpm(hba);
 	ufshcd_setup_clocks(hba, true);
 
@@ -1957,28 +1936,26 @@ static void ufshcd_gate_work(struct work_struct *work)
 {
 	struct ufs_hba *hba = container_of(work, struct ufs_hba,
 			clk_gating.gate_work.work);
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	/*
-	 * In case you are here to cancel this work the gating state
-	 * would be marked as REQ_CLKS_ON. In this case save time by
-	 * skipping the gating work and exit after changing the clock
-	 * state to CLKS_ON.
-	 */
-	if (hba->clk_gating.is_suspended ||
-		(hba->clk_gating.state != REQ_CLKS_OFF)) {
-		hba->clk_gating.state = CLKS_ON;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		/*
+		 * In case you are here to cancel this work the gating state
+		 * would be marked as REQ_CLKS_ON. In this case save time by
+		 * skipping the gating work and exit after changing the clock
+		 * state to CLKS_ON.
+		 */
+		if (hba->clk_gating.is_suspended ||
+				(hba->clk_gating.state != REQ_CLKS_OFF)) {
+			hba->clk_gating.state = CLKS_ON;
+			trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-		goto rel_lock;
-	}
-
-	if (ufshcd_is_ufs_dev_busy(hba) || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
-		goto rel_lock;
+			goto out;
+		}
 
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+		if (ufshcd_is_ufs_dev_busy(hba) || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
+			goto out;
+	}
 
 	/* put the link into hibern8 mode before turning off clocks */
 	if (ufshcd_can_hibern8_during_gating(hba)) {
@@ -2009,14 +1986,14 @@ static void ufshcd_gate_work(struct work_struct *work)
 	 * prevent from doing cancel work multiple times when there are
 	 * new requests arriving before the current cancel work is done.
 	 */
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->clk_gating.state == REQ_CLKS_OFF) {
-		hba->clk_gating.state = CLKS_OFF;
-		trace_ufshcd_clk_gating(dev_name(hba->dev),
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (hba->clk_gating.state == REQ_CLKS_OFF) {
+			hba->clk_gating.state = CLKS_OFF;
+			trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
+		}
 	}
-rel_lock:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 out:
 	return;
 }
@@ -2045,11 +2022,8 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 void ufshcd_release(struct ufs_hba *hba)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	__ufshcd_release(hba);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ufshcd_release);
 
@@ -2064,11 +2038,9 @@ static ssize_t ufshcd_clkgate_delay_show(struct device *dev,
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
-	unsigned long flags;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	hba->clk_gating.delay_ms = value;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 EXPORT_SYMBOL_GPL(ufshcd_clkgate_delay_set);
 
@@ -2096,7 +2068,6 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
-	unsigned long flags;
 	u32 value;
 
 	if (kstrtou32(buf, 0, &value))
@@ -2104,18 +2075,18 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 
 	value = !!value;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (value == hba->clk_gating.is_enabled)
-		goto out;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (value == hba->clk_gating.is_enabled)
+			goto out;
 
-	if (value)
-		__ufshcd_release(hba);
-	else
-		hba->clk_gating.active_reqs++;
+		if (value)
+			__ufshcd_release(hba);
+		else
+			hba->clk_gating.active_reqs++;
 
-	hba->clk_gating.is_enabled = value;
+		hba->clk_gating.is_enabled = value;
+	}
 out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	return count;
 }
 
@@ -2189,19 +2160,16 @@ static void ufshcd_clk_scaling_start_busy(struct ufs_hba *hba)
 {
 	bool queue_resume_work = false;
 	ktime_t curr_t = ktime_get();
-	unsigned long flags;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	if (!hba->clk_scaling.active_reqs++)
 		queue_resume_work = true;
 
-	if (!hba->clk_scaling.is_enabled || hba->pm_op_in_progress) {
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	if (!hba->clk_scaling.is_enabled || hba->pm_op_in_progress)
 		return;
-	}
 
 	if (queue_resume_work)
 		queue_work(hba->clk_scaling.workq,
@@ -2217,18 +2185,16 @@ static void ufshcd_clk_scaling_start_busy(struct ufs_hba *hba)
 		hba->clk_scaling.busy_start_t = curr_t;
 		hba->clk_scaling.is_busy_started = true;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
 static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
 {
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
-	unsigned long flags;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	hba->clk_scaling.active_reqs--;
 	if (!scaling->active_reqs && scaling->is_busy_started) {
 		scaling->tot_busy_t += ktime_to_us(ktime_sub(ktime_get(),
@@ -2236,7 +2202,6 @@ static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
 		scaling->busy_start_t = 0;
 		scaling->is_busy_started = false;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
 static inline int ufshcd_monitor_opcode2dir(u8 opcode)
@@ -2263,20 +2228,17 @@ static void ufshcd_start_monitor(struct ufs_hba *hba,
 				 const struct ufshcd_lrb *lrbp)
 {
 	int dir = ufshcd_monitor_opcode2dir(*lrbp->cmd->cmnd);
-	unsigned long flags;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	if (dir >= 0 && hba->monitor.nr_queued[dir]++ == 0)
 		hba->monitor.busy_start_ts[dir] = ktime_get();
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
 static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *lrbp)
 {
 	int dir = ufshcd_monitor_opcode2dir(*lrbp->cmd->cmnd);
-	unsigned long flags;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	if (dir >= 0 && hba->monitor.nr_queued[dir] > 0) {
 		const struct request *req = scsi_cmd_to_rq(lrbp->cmd);
 		struct ufs_hba_monitor *m = &hba->monitor;
@@ -2300,7 +2262,6 @@ static void ufshcd_update_monitor(struct ufs_hba *hba, const struct ufshcd_lrb *
 		/* Push forward the busy start of monitor */
 		m->busy_start_ts[dir] = now;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 
 /**
@@ -2314,7 +2275,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 			 struct ufs_hw_queue *hwq)
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
-	unsigned long flags;
 
 	lrbp->issue_time_stamp = ktime_get();
 	lrbp->issue_time_stamp_local_clock = local_clock();
@@ -2337,14 +2297,14 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
 		ufshcd_inc_sq_tail(hwq);
 		spin_unlock(&hwq->sq_lock);
 	} else {
-		spin_lock_irqsave(&hba->outstanding_lock, flags);
-		if (hba->vops && hba->vops->setup_xfer_req)
-			hba->vops->setup_xfer_req(hba, lrbp->task_tag,
-						  !!lrbp->cmd);
-		__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
-		ufshcd_writel(hba, 1 << lrbp->task_tag,
-			      REG_UTP_TRANSFER_REQ_DOOR_BELL);
-		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+		scoped_guard(spinlock_irqsave, &hba->outstanding_lock) {
+			if (hba->vops && hba->vops->setup_xfer_req)
+				hba->vops->setup_xfer_req(hba, lrbp->task_tag,
+						!!lrbp->cmd);
+			__set_bit(lrbp->task_tag, &hba->outstanding_reqs);
+			ufshcd_writel(hba, 1 << lrbp->task_tag,
+					REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		}
 	}
 }
 
@@ -2515,7 +2475,6 @@ static int
 ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	int ret;
-	unsigned long flags;
 
 	lockdep_assert_held(&hba->uic_cmd_mutex);
 
@@ -2535,9 +2494,8 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 		}
 	}
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->active_uic_cmd = NULL;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock)
+		hba->active_uic_cmd = NULL;
 
 	return ret;
 }
@@ -3051,11 +3009,8 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 out:
 	if (ufs_trigger_eh(hba)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(hba->host->host_lock, flags);
-		ufshcd_schedule_eh_work(hba);
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		scoped_guard(spinlock_irqsave, hba->host->host_lock)
+			ufshcd_schedule_eh_work(hba);
 	}
 
 	return err;
@@ -3109,7 +3064,6 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
 static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
 	u32 mask;
-	unsigned long flags;
 	int err;
 
 	if (is_mcq_enabled(hba)) {
@@ -3129,9 +3083,8 @@ static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 	mask = 1U << task_tag;
 
 	/* clear outstanding transaction before retry */
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_utrl_clear(hba, mask);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock)
+		ufshcd_utrl_clear(hba, mask);
 
 	/*
 	 * wait for h/w to clear corresponding bit in door-bell.
@@ -3198,7 +3151,6 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		struct ufshcd_lrb *lrbp, int max_timeout)
 {
 	unsigned long time_left = msecs_to_jiffies(max_timeout);
-	unsigned long flags;
 	bool pending;
 	int err;
 
@@ -3237,16 +3189,15 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 			 * clear the task tag bit from the outstanding_reqs
 			 * variable.
 			 */
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending = test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
-			if (pending) {
-				hba->dev_cmd.complete = NULL;
-				__clear_bit(lrbp->task_tag,
-					    &hba->outstanding_reqs);
+			scoped_guard(spinlock_irqsave, &hba->outstanding_lock) {
+				pending = test_bit(lrbp->task_tag,
+						&hba->outstanding_reqs);
+				if (pending) {
+					hba->dev_cmd.complete = NULL;
+					__clear_bit(lrbp->task_tag,
+							&hba->outstanding_reqs);
+				}
 			}
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
 			if (!pending) {
 				/*
 				 * The completion handler ran while we tried to
@@ -3259,13 +3210,12 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 			dev_err(hba->dev, "%s: failed to clear tag %d\n",
 				__func__, lrbp->task_tag);
 
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending = test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
-			if (pending)
-				hba->dev_cmd.complete = NULL;
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
+			scoped_guard(spinlock_irqsave, &hba->outstanding_lock) {
+				pending = test_bit(lrbp->task_tag,
+						&hba->outstanding_reqs);
+				if (pending)
+					hba->dev_cmd.complete = NULL;
+			}
 			if (!pending) {
 				/*
 				 * The completion handler ran while we tried to
@@ -4285,7 +4235,6 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_get_attr);
 static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 {
 	DECLARE_COMPLETION_ONSTACK(uic_async_done);
-	unsigned long flags;
 	u8 status;
 	int ret;
 	bool reenable_intr = false;
@@ -4293,22 +4242,23 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (ufshcd_is_link_broken(hba)) {
-		ret = -ENOLINK;
-		goto out_unlock;
-	}
-	hba->uic_async_done = &uic_async_done;
-	if (ufshcd_readl(hba, REG_INTERRUPT_ENABLE) & UIC_COMMAND_COMPL) {
-		ufshcd_disable_intr(hba, UIC_COMMAND_COMPL);
-		/*
-		 * Make sure UIC command completion interrupt is disabled before
-		 * issuing UIC command.
-		 */
-		wmb();
-		reenable_intr = true;
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ufshcd_is_link_broken(hba)) {
+			ret = -ENOLINK;
+			goto out;
+		}
+		hba->uic_async_done = &uic_async_done;
+		if (ufshcd_readl(hba, REG_INTERRUPT_ENABLE) & UIC_COMMAND_COMPL) {
+			ufshcd_disable_intr(hba, UIC_COMMAND_COMPL);
+			/*
+			 * Make sure UIC command completion interrupt is disabled before
+			 * issuing UIC command.
+			 */
+			wmb();
+			reenable_intr = true;
+		}
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	if (ret) {
 		dev_err(hba->dev,
@@ -4348,17 +4298,17 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		ufshcd_print_evt_hist(hba);
 	}
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->active_uic_cmd = NULL;
-	hba->uic_async_done = NULL;
-	if (reenable_intr)
-		ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
-	if (ret) {
-		ufshcd_set_link_broken(hba);
-		ufshcd_schedule_eh_work(hba);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		hba->active_uic_cmd = NULL;
+		hba->uic_async_done = NULL;
+		if (reenable_intr)
+			ufshcd_enable_intr(hba, UIC_COMMAND_COMPL);
+		if (ret) {
+			ufshcd_set_link_broken(hba);
+			ufshcd_schedule_eh_work(hba);
+		}
 	}
-out_unlock:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	mutex_unlock(&hba->uic_cmd_mutex);
 
 	return ret;
@@ -4402,23 +4352,22 @@ EXPORT_SYMBOL_GPL(ufshcd_uic_change_pwr_mode);
 int ufshcd_link_recovery(struct ufs_hba *hba)
 {
 	int ret;
-	unsigned long flags;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->ufshcd_state = UFSHCD_STATE_RESET;
-	ufshcd_set_eh_in_progress(hba);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		hba->ufshcd_state = UFSHCD_STATE_RESET;
+		ufshcd_set_eh_in_progress(hba);
+	}
 
 	/* Reset the attached device */
 	ufshcd_device_reset(hba);
 
 	ret = ufshcd_host_reset_and_restore(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (ret)
-		hba->ufshcd_state = UFSHCD_STATE_ERROR;
-	ufshcd_clear_eh_in_progress(hba);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ret)
+			hba->ufshcd_state = UFSHCD_STATE_ERROR;
+		ufshcd_clear_eh_in_progress(hba);
+	}
 
 	if (ret)
 		dev_err(hba->dev, "%s: link recovery failed, err %d",
@@ -4815,16 +4764,14 @@ EXPORT_SYMBOL_GPL(ufshcd_make_hba_operational);
  */
 void ufshcd_hba_stop(struct ufs_hba *hba)
 {
-	unsigned long flags;
 	int err;
 
 	/*
 	 * Obtain the host lock to prevent that the controller is disabled
 	 * while the UFS interrupt handler is active on another CPU.
 	 */
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock)
+		ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
 
 	err = ufshcd_wait_for_register(hba, REG_CONTROLLER_ENABLE,
 					CONTROLLER_ENABLE, CONTROLLER_DISABLE,
@@ -5295,26 +5242,23 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
-	unsigned long flags;
 
 	hba = shost_priv(sdev->host);
 
 	/* Drop the reference as it won't be needed anymore */
 	if (ufshcd_scsi_to_upiu_lun(sdev->lun) == UFS_UPIU_UFS_DEVICE_WLUN) {
-		spin_lock_irqsave(hba->host->host_lock, flags);
-		hba->ufs_device_wlun = NULL;
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		scoped_guard(spinlock_irqsave, hba->host->host_lock)
+			hba->ufs_device_wlun = NULL;
 	} else if (hba->ufs_device_wlun) {
 		struct device *supplier = NULL;
 
 		/* Ensure UFS Device WLUN exists and does not disappear */
-		spin_lock_irqsave(hba->host->host_lock, flags);
-		if (hba->ufs_device_wlun) {
-			supplier = &hba->ufs_device_wlun->sdev_gendev;
-			get_device(supplier);
+		scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+			if (hba->ufs_device_wlun) {
+				supplier = &hba->ufs_device_wlun->sdev_gendev;
+				get_device(supplier);
+			}
 		}
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-
 		if (supplier) {
 			/*
 			 * If a LUN fails to probe (e.g. absent BOOT WLUN), the
@@ -5618,7 +5562,7 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
 static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 {
 	struct ufs_hba *hba = shost_priv(shost);
-	unsigned long completed_reqs, flags;
+	unsigned long completed_reqs;
 	u32 tr_doorbell;
 	struct ufs_hw_queue *hwq;
 
@@ -5628,19 +5572,18 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
 	}
 
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
-	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
-		/* Do not complete polled requests from interrupt context. */
-		ufshcd_clear_polled(hba, &completed_reqs);
-	}
-	hba->outstanding_reqs &= ~completed_reqs;
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
+	scoped_guard(spinlock_irqsave, &hba->outstanding_lock) {
+		tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
+		WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
+				"completed: %#lx; outstanding: %#lx\n", completed_reqs,
+				hba->outstanding_reqs);
+		if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
+			/* Do not complete polled requests from interrupt context. */
+			ufshcd_clear_polled(hba, &completed_reqs);
+		}
+		hba->outstanding_reqs &= ~completed_reqs;
+	}
 	if (completed_reqs)
 		__ufshcd_transfer_req_compl(hba, completed_reqs);
 
@@ -5664,7 +5607,6 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 	struct ufs_hw_queue *hwq;
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
-	unsigned long flags;
 	int tag;
 
 	for (tag = 0; tag < hba->nutrs; tag++) {
@@ -5682,13 +5624,13 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 			 * For those cmds of which the cqes are not present
 			 * in the cq, complete them explicitly.
 			 */
-			spin_lock_irqsave(&hwq->cq_lock, flags);
-			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				set_host_byte(cmd, DID_REQUEUE);
-				ufshcd_release_scsi_cmd(hba, lrbp);
-				scsi_done(cmd);
+			scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
+				if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+					set_host_byte(cmd, DID_REQUEUE);
+					ufshcd_release_scsi_cmd(hba, lrbp);
+					scsi_done(cmd);
+				}
 			}
-			spin_unlock_irqrestore(&hwq->cq_lock, flags);
 		} else {
 			ufshcd_mcq_poll_cqe_lock(hba, hwq);
 		}
@@ -6512,7 +6454,6 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	struct ufs_hba *hba = shost_priv(shost);
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct ufs_hw_queue *hwq;
-	unsigned long flags;
 
 	*ret = ufshcd_try_to_abort_task(hba, tag);
 	dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
@@ -6522,10 +6463,10 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	/* Release cmd in MCQ mode if abort succeeds */
 	if (is_mcq_enabled(hba) && (*ret == 0)) {
 		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
-		spin_lock_irqsave(&hwq->cq_lock, flags);
-		if (ufshcd_cmd_inflight(lrbp->cmd))
-			ufshcd_release_scsi_cmd(hba, lrbp);
-		spin_unlock_irqrestore(&hwq->cq_lock, flags);
+		scoped_guard(spinlock_irqsave, &hwq->cq_lock) {
+			if (ufshcd_cmd_inflight(lrbp->cmd))
+				ufshcd_release_scsi_cmd(hba, lrbp);
+		}
 	}
 
 	return *ret == 0;
@@ -6918,11 +6859,11 @@ static irqreturn_t ufshcd_check_errors(struct ufs_hba *hba, u32 intr_status)
  */
 static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 {
-	unsigned long flags, pending, issued;
+	unsigned long pending, issued;
 	irqreturn_t ret = IRQ_NONE;
 	int tag;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
+	SERIALIZE_HOST_IRQSAVE(hba);
 	pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
 	issued = hba->outstanding_tasks & ~pending;
 	for_each_set_bit(tag, &issued, hba->nutmrs) {
@@ -6932,7 +6873,6 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 		complete(c);
 		ret = IRQ_HANDLED;
 	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	return ret;
 }
@@ -7056,14 +6996,12 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 {
 	int err = 0;
 	u32 mask = 1 << tag;
-	unsigned long flags;
 
 	if (!test_bit(tag, &hba->outstanding_tasks))
 		goto out;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_utmrl_clear(hba, tag);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock)
+		ufshcd_utmrl_clear(hba, tag);
 
 	/* poll for max. 1 sec to clear door bell register by h/w */
 	err = ufshcd_wait_for_register(hba,
@@ -7084,7 +7022,6 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 	struct Scsi_Host *host = hba->host;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	struct request *req;
-	unsigned long flags;
 	int task_tag, err;
 
 	/*
@@ -7097,24 +7034,21 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 	req->end_io_data = &wait;
 	ufshcd_hold(hba);
 
-	spin_lock_irqsave(host->host_lock, flags);
-
-	task_tag = req->tag;
-	hba->tmf_rqs[req->tag] = req;
-	treq->upiu_req.req_header.task_tag = task_tag;
-
-	memcpy(hba->utmrdl_base_addr + task_tag, treq, sizeof(*treq));
-	ufshcd_vops_setup_task_mgmt(hba, task_tag, tm_function);
-
-	/* send command to the controller */
-	__set_bit(task_tag, &hba->outstanding_tasks);
+	scoped_guard(spinlock_irqsave, host->host_lock) {
+		task_tag = req->tag;
+		hba->tmf_rqs[req->tag] = req;
+		treq->upiu_req.req_header.task_tag = task_tag;
 
-	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
-	/* Make sure that doorbell is committed immediately */
-	wmb();
+		memcpy(hba->utmrdl_base_addr + task_tag, treq, sizeof(*treq));
+		ufshcd_vops_setup_task_mgmt(hba, task_tag, tm_function);
 
-	spin_unlock_irqrestore(host->host_lock, flags);
+		/* send command to the controller */
+		__set_bit(task_tag, &hba->outstanding_tasks);
 
+		ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
+		/* Make sure that doorbell is committed immediately */
+		wmb();
+	}
 	ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_SEND);
 
 	/* wait until the task management command is completed */
@@ -7135,11 +7069,10 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_COMP);
 	}
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->tmf_rqs[req->tag] = NULL;
-	__clear_bit(task_tag, &hba->outstanding_tasks);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
+	scoped_guard(spinlock_irqsave, host->host_lock) {
+		hba->tmf_rqs[req->tag] = NULL;
+		__clear_bit(task_tag, &hba->outstanding_tasks);
+	}
 	ufshcd_release(hba);
 	blk_mq_free_request(req);
 
@@ -7621,7 +7554,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufs_hba *hba = shost_priv(host);
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
-	unsigned long flags;
 	int err = FAILED;
 	bool outstanding;
 	u32 reg;
@@ -7680,11 +7612,10 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 */
 	if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
 		ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
-
-		spin_lock_irqsave(host->host_lock, flags);
-		hba->force_reset = true;
-		ufshcd_schedule_eh_work(hba);
-		spin_unlock_irqrestore(host->host_lock, flags);
+		scoped_guard(spinlock_irqsave, host->host_lock) {
+			hba->force_reset = true;
+			ufshcd_schedule_eh_work(hba);
+		}
 		goto release;
 	}
 
@@ -7713,9 +7644,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+	scoped_guard(spinlock_irqsave, &hba->outstanding_lock)
+		outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
 
 	if (outstanding)
 		ufshcd_release_scsi_cmd(hba, lrbp);
@@ -7836,7 +7766,6 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba)
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
 {
 	int err = SUCCESS;
-	unsigned long flags;
 	struct ufs_hba *hba;
 
 	hba = shost_priv(cmd->device->host);
@@ -7854,18 +7783,18 @@ static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd)
 		return err;
 	}
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	hba->force_reset = true;
-	ufshcd_schedule_eh_work(hba);
-	dev_err(hba->dev, "%s: reset in progress - 1\n", __func__);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		hba->force_reset = true;
+		ufshcd_schedule_eh_work(hba);
+		dev_err(hba->dev, "%s: reset in progress - 1\n", __func__);
+	}
 
 	flush_work(&hba->eh_work);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (hba->ufshcd_state == UFSHCD_STATE_ERROR)
-		err = FAILED;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (hba->ufshcd_state == UFSHCD_STATE_ERROR)
+			err = FAILED;
+	}
 
 	return err;
 }
@@ -8927,7 +8856,6 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 {
 	ktime_t start = ktime_get();
-	unsigned long flags;
 	int ret;
 
 	ret = ufshcd_device_init(hba, init_dev_params);
@@ -8972,13 +8900,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_configure_auto_hibern8(hba);
 
 out:
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (ret)
-		hba->ufshcd_state = UFSHCD_STATE_ERROR;
-	else if (hba->ufshcd_state == UFSHCD_STATE_RESET)
-		hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		if (ret)
+			hba->ufshcd_state = UFSHCD_STATE_ERROR;
+		else if (hba->ufshcd_state == UFSHCD_STATE_RESET)
+			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
+	}
 	trace_ufshcd_init(dev_name(hba->dev), ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
@@ -9247,7 +9174,6 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 	int ret = 0;
 	struct ufs_clk_info *clki;
 	struct list_head *head = &hba->clk_list_head;
-	unsigned long flags;
 	ktime_t start = ktime_get();
 	bool clk_state_changed = false;
 
@@ -9298,11 +9224,10 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 				clk_disable_unprepare(clki->clk);
 		}
 	} else if (!ret && on) {
-		spin_lock_irqsave(hba->host->host_lock, flags);
-		hba->clk_gating.state = CLKS_ON;
+		scoped_guard(spinlock_irqsave, hba->host->host_lock)
+			hba->clk_gating.state = CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
 
 	if (clk_state_changed)
@@ -9523,17 +9448,15 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 {
 	struct scsi_sense_hdr sshdr;
 	struct scsi_device *sdp;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	sdp = hba->ufs_device_wlun;
-	if (sdp && scsi_device_online(sdp))
-		ret = scsi_device_get(sdp);
-	else
-		ret = -ENODEV;
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-
+	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
+		sdp = hba->ufs_device_wlun;
+		if (sdp && scsi_device_online(sdp))
+			ret = scsi_device_get(sdp);
+		else
+			ret = -ENODEV;
+	}
 	if (ret)
 		return ret;
 
@@ -10708,19 +10631,15 @@ static bool ufshcd_rpm_ok_for_spm(struct ufs_hba *hba)
 	struct device *dev = &hba->ufs_device_wlun->sdev_gendev;
 	enum ufs_dev_pwr_mode dev_pwr_mode;
 	enum uic_link_state link_state;
-	unsigned long flags;
-	bool res;
 
-	spin_lock_irqsave(&dev->power.lock, flags);
+	guard(spinlock_irqsave)(&dev->power.lock);
+
 	dev_pwr_mode = ufs_get_pm_lvl_to_dev_pwr_mode(hba->spm_lvl);
 	link_state = ufs_get_pm_lvl_to_link_pwr_state(hba->spm_lvl);
-	res = pm_runtime_suspended(dev) &&
-	      hba->curr_dev_pwr_mode == dev_pwr_mode &&
-	      hba->uic_link_state == link_state &&
-	      !hba->dev_info.b_rpm_dev_flush_capable;
-	spin_unlock_irqrestore(&dev->power.lock, flags);
-
-	return res;
+	return pm_runtime_suspended(dev) &&
+	       hba->curr_dev_pwr_mode == dev_pwr_mode &&
+	       hba->uic_link_state == link_state &&
+	       !hba->dev_info.b_rpm_dev_flush_capable;
 }
 
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm)
-- 
2.42.0


