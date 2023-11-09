Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CC7E6ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjKIMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKIMwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:52:38 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AE02D72
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699534347; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MhRqKS75irB3ZvueQzqrPgQAAjyn8PCN3rchBTeJgIEF702inec2uyGd/BqOQ2zgf2
    Es4z+YKVSaoXKpaaYJnjCMKAEgZdHSq6v+KXFWlL1rDCkDkMr94nZQCz5ony6VQ+BVyI
    Ptyx/hJPdjPQFFCWimBgulU63dVDSB6hYBrr1cnY9gycZXsFF8FZZ0yZnPRyxKh9lTh3
    WAFZYMdzRBR+qkigREaZsuGa+FaQheNQaDke9HQ+tuBJ8ra2NXBbQD/dsVNe5tT2zJE7
    6xcvre0WiXhbKphjsZUPbisbFBeUcvEWEHODnlOVx3UBNWmIvYw+c+pi3ZYtojWHsToq
    dIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZypnMkXOv7QYQeRW25PllggTkD8rnbD+qAFFzhGmPZE=;
    b=W/+vZrlqMyBaVNL3qgyV0IuLQMmGEEeIWCPB6ho/Rb3XgfJH6IZFpRWLkT11eid5GE
    2VgTheD8rIag+NHd/z5shZ5h35hnDuUGFwA6iPyjh+4qjMbPK7xYslozSTx3I8nmrdt6
    E58zNCOtHaHAy/fYjSZk2J5xS4pJFw4yXIsjFe/okAt6ubrTTElsxEJ5jOHFsGLF8Tnf
    P0XQ2kgkPASQO/RmibuI87U+fwrZd/sUQrGnJjhMRfNwL2IGS4mBkDNiMuqXPnHs0WPq
    jQVuhh3y1oORoOOZOPtlkhC/N5Rj4EyopJbVfKJrN7Ppwgiza/SXc0p41jVkjlq6NE0m
    aBfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZypnMkXOv7QYQeRW25PllggTkD8rnbD+qAFFzhGmPZE=;
    b=Ir/+pTyTeRcfwp7KOp6PXHDtcdAculOZwe+8L/FnWBl7f/l4AjMS57nil5XKlRMxrS
    KT0DlC+6gQJmRvZGsapOjE6MxdHloHwPw8UU9Y3W8QxTOuqMSpbTnW5JuJGKkyx3Qe5Z
    1zZKp9Q6kcT2MKh86U3nzVy5QSOik9RbUvgrohsnaAbn1zMHQ+lgpVFQD1kBwkCjb7VE
    NzKRpK1E0P9S0jZxNtCbEGLYRxu5k6/bwLyXUjTCWiQsOc+Zfk4ZPY12QYHYlsADeJ7T
    xB645b23vBTq6lc8Wx9vBqMDKJlaOhi1Uf8S86HuxBGBJV7UCwme8QdEWoqUZTbj2jDc
    Lfmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZypnMkXOv7QYQeRW25PllggTkD8rnbD+qAFFzhGmPZE=;
    b=T9LzrN8jKWSRWXvP76GPj9LcpwR2RoanFIHUtDJkXkzpRCRPXHUXGJ1CgOlrkXggkl
    wVvgjYgY+Hl+MLu/wCCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id zd0181zA9CqQvYo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Nov 2023 13:52:26 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
Date:   Thu,  9 Nov 2023 13:52:16 +0100
Message-Id: <20231109125217.185462-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109125217.185462-1-beanhuo@iokpp.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

The objective of this patch is to incorporate Real Time Clock (RTC) support in Universal
Flash Storage (UFS) device. This enhancement is crucial for the internal maintenance
operations of the UFS device. The patch enables the device to handle both absolute and
relative time information. Furthermore, it includes periodic task to update the RTC in
accordance with the UFS specification, ensuring the accuracy of RTC information for the
device's internal processes.

Signed-off-by: Mike Bi <mikebi@micron.com>
Signed-off-by: Luca Porzio <lporzio@micron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd.c | 92 +++++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         | 20 +++++++++
 include/ufs/ufshcd.h      |  2 +
 3 files changed, 114 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68d7da02944f..f0e3dd3dd280 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -99,6 +99,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Default RTC update every 10 seconds */
+#define UFS_RTC_UPDATE_EVERY_MS  10*1000
+
 /* UFSHC 4.0 compliant HC support this mode. */
 static bool use_mcq_mode = true;
 
@@ -677,6 +680,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 			hba->dev_info.wb_enabled = false;
 			hba->dev_info.wb_buf_flush_enabled = false;
 		}
+		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+			hba->dev_info.rtc_time_baseline = 0;
 	}
 	if (err != -EOPNOTSUPP)
 		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
@@ -8185,6 +8190,85 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
 	ufshcd_vops_fixup_dev_quirks(hba);
 }
 
+static int ufshcd_update_rtc(struct ufs_hba *hba)
+{
+	int err = 0;
+	u32 val;
+	struct timespec64 ts64;
+
+	ktime_get_real_ts64(&ts64);
+	val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
+
+	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR, QUERY_ATTR_IDN_SECONDS_PASSED,
+					0, 0, &val);
+	ufshcd_rpm_put_sync(hba);
+
+	if (err)
+	        dev_err(hba->dev, "%s: failed to send rtc %d\n",  __func__, err);
+	else if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+		hba->dev_info.rtc_time_baseline = ts64.tv_sec;
+
+	return err;
+}
+
+static void ufshcd_rtc_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct ufs_hba *hba;
+
+	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_delayed_work);
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	if (hba->clk_gating.active_reqs || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
+		hba->outstanding_reqs || hba->outstanding_tasks || hba->active_uic_cmd ||
+		hba->uic_async_done) {
+		/*
+		 * RTC updates should not interfere with normal IO requests; we should only update
+		 * the RTC when there are no ongoing requestsUFS is not idle
+		 */
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		goto out;
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	ufshcd_update_rtc(hba);
+out:
+	if (ufshcd_is_ufs_dev_active(hba))
+		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
+							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
+	return;
+}
+
+static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u16 periodic_rtc_update = get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
+
+	if (periodic_rtc_update & BIT(9)) {
+		dev_info->rtc_type = UFS_RTC_ABSOLUTE;
+		/*
+		 * The concept of measuring time in Linux as the number of seconds elapsed since
+		 * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is elapsed from January 1st
+		 * 2010 00:00, here we need to adjust ABS baseline.
+		 */
+		dev_info->rtc_time_baseline = mktime64(2010, 1, 1, 0, 0, 0) -
+								mktime64(1970, 1, 1, 0, 0, 0);
+	} else {
+		dev_info->rtc_type = UFS_RTC_RELATIVE;
+		dev_info->rtc_time_baseline = 0;
+	}
+
+	/*
+	 * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because Spec does not clearly
+	 * define how to calculate the specific update period for each time unit. Here we simply
+	 * set the update period to 1 minute by default.
+	 */
+	hba->dev_info.rtc_update_period = UFS_RTC_UPDATE_EVERY_MS;
+
+	INIT_DELAYED_WORK(&hba->ufs_rtc_delayed_work, ufshcd_rtc_work);
+}
+
 static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
@@ -8237,6 +8321,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufs_init_rtc(hba, desc_buf);
+
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
@@ -8790,6 +8876,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_force_reset_auto_bkops(hba);
 
 	ufshcd_set_timestamp_attr(hba);
+	schedule_delayed_work(&hba->ufs_rtc_delayed_work,
+							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -9746,6 +9834,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
 	if (ret)
 		goto set_link_active;
+
+	cancel_delayed_work(&hba->ufs_rtc_delayed_work);
 	goto out;
 
 set_link_active:
@@ -9840,6 +9930,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		if (ret)
 			goto set_old_link_state;
 		ufshcd_set_timestamp_attr(hba);
+		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
+							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index e77ab1786856..18b39c6b3a97 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/scsi/scsi_bsg_ufs.h>
+#include <linux/rtc.h>
 
 /*
  * Using static_assert() is not allowed in UAPI header files. Hence the check
@@ -551,6 +552,20 @@ struct ufs_vreg_info {
 	struct ufs_vreg *vdd_hba;
 };
 
+enum ufs_rtc_time {
+	UFS_RTC_RELATIVE,
+	UFS_RTC_ABSOLUTE
+};
+
+enum ufs_rtc_time_unit {
+	UFS_RTC_TIME_UNIT_UNDEFINE	= 0x0,
+	UFS_RTC_TIME_UNIT_MONTHS	= 0x1,
+	UFS_RTC_TIME_UNIT_WEEKS		= 0x2,
+	UFS_RTC_TIME_UNIT_DAYS		= 0x3,
+	UFS_RTC_TIME_UNIT_HOURS		= 0x4,
+	UFS_RTC_TIME_UNIT_MINUTES	= 0x5
+};
+
 struct ufs_dev_info {
 	bool	f_power_on_wp_en;
 	/* Keeps information if any of the LU is power on write protected */
@@ -578,6 +593,11 @@ struct ufs_dev_info {
 
 	/* UFS EXT_IID Enable */
 	bool	b_ext_iid_en;
+
+	/* UFS RTC */
+	enum ufs_rtc_time rtc_type;
+	time64_t rtc_time_baseline;
+	u32 rtc_update_period;
 };
 
 /*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7f0b2c5599cd..11da11d6870c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1071,6 +1071,8 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	struct delayed_work ufs_rtc_delayed_work;
 };
 
 /**
-- 
2.34.1

