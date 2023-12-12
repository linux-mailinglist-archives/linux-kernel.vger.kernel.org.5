Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4B80F9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377697AbjLLWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377685AbjLLWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:08:42 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31FCE;
        Tue, 12 Dec 2023 14:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702418918; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=spmfy7VZreba86boZZQ9+PiViYdBPNdGgRDjo4i6fYFrFXAQ/asemv1OtWZSSkf1SL
    l5WMbCXMeSuFfMK+xqwoOObXiJiXNieZe3HRpFplUPKaCCj+9nJE9Jz2NQT6ZjF4UFjN
    Fu7kzgF+xDvhGBuVhghKqp0mN7E8V8pgLnN/BJIgtQtTLc+gFDr1W2FFbt+iXxcYSw1v
    JHE1FaUzpfmz5v2vbX10GM6vX9Y+uNdzlx9DPc1VQ4D24j85XNLBsgBsMk6S1Lwl9jmw
    QcCr26k332DIHCs3AY1T+tK1WclYFnGFJ+owCbJT2NNkhnklneEbPaa6pGCiHrqNo7Ph
    hBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fYHGrUYY95PvDN+9HnCE2Tig2ZNtTkEA/xEkZJV9Dps=;
    b=Ito4rqNY9caGayHi+z0N7eJpOwVMw0pya/f9uDdnj9wpMA/0VFUxM2kR7InZfo6FRH
    3yleZyEYogdSReYwnPIFAOleBL69EMWCOPueBVy33VRisXyyFUJQtxqxpard8tEEInxe
    8ic20Og8+mI5CqMiRfgcwQZBjmxr0D86YDdSrQhcYcfGX6+O+RwmToNtsfpRZt3fmsKZ
    k92YM+2GQjX3FYrsfAY+gFyAcAwIz6mOzKf+1WmUFPJJFT7fiCXMik2VUvqcxgRuac/8
    L8N3pNrJNwN6vARzJDFOQHAE+8qjU+XqxEzBC4YD7oNWZ/pLZH3OYt3y14jSrPB6oqTM
    RAow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fYHGrUYY95PvDN+9HnCE2Tig2ZNtTkEA/xEkZJV9Dps=;
    b=mBcSZ0zqTZXSHpOQ8aXRoM4LHSrlrIvKGzFcgDxMtND6PfMPph4MKZJLbo3gjtyYfY
    BMf1TZc1PnF+nKAOMwy95mgLVUB+ztG1ZDphsuYgaU4T6265LpOSL//vVN8ZWRrJBFvW
    5BPkiY8+Lle5vqrYmLhCwy2GETuDVeMt+CDG1ywmjgJhPMGcYhgkQh2F5ZLVFOXjS7TZ
    HM2puUIeoNGb1kauzL+GkcXS9pg9fxjhD0nUhTsfGjH4hOlzhdPoUbLzDk2r8KVzrKLs
    b7efM6iYaKcYm77pDzecwD2roIkMlMWTakHPxSU4detfu+lKCwVjN3g2hMW8JHfxzmBL
    2vSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fYHGrUYY95PvDN+9HnCE2Tig2ZNtTkEA/xEkZJV9Dps=;
    b=jWX5BdGK/OOXwhSlNK4+BqE0nY55DDrtB/rjSuxQnwJYyq+lBZXeC3sybHKvWpIfvk
    1aLj6JONm5W2SvBJ+lBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1krW49WPrbTU8waUHk0CK6S5K43N4UTp8lPg"
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBCM8bNW0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Dec 2023 23:08:37 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 2/3] scsi: ufs: core: Add UFS RTC support
Date:   Tue, 12 Dec 2023 23:08:24 +0100
Message-Id: <20231212220825.85255-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212220825.85255-1-beanhuo@iokpp.de>
References: <20231212220825.85255-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add Real Time Clock (RTC) support for UFS device. This enhancement is crucial
for the internal maintenance operations of the UFS device. The patch enables
the device to handle both absolute and relative time information. Furthermore,
it includes periodic task to update the RTC in accordance with the UFS Spec,
ensuring the accuracy of RTC information for the device's internal processes.

RTC and qTimestamp serve distinct purposes. The RTC provides a coarse level
of granularity with, at best, approximate single-second resolution. This makes
the RTC well-suited for the device to determine the approximate age of programmed
blocks after being updated by the host. On the other hand, qTimestamp offers
nanosecond granularity and is specifically designed for synchronizing Device
Error Log entries with corresponding host-side logs.

Given that the RTC has been a standard feature since UFS Spec 2.0, and qTimestamp
was introduced in UFS Spec 4.0, the majority of UFS devices currently on the
market rely on RTC. Therefore, it is advisable to continue supporting RTC in
the Linux kernel. This ensures compatibility with the prevailing UFS device
implementations and facilitates seamless integration with existing hardware.
By maintaining support for RTC, we ensure broad compatibility and avoid potential
issues arising from deviations in device specifications across different UFS
versions.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Mike Bi <mikebi@micron.com>
Signed-off-by: Luca Porzio <lporzio@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ufs/core/ufshcd.c | 83 ++++++++++++++++++++++++++++++++++++++-
 include/ufs/ufs.h         | 13 ++++++
 include/ufs/ufshcd.h      |  4 ++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 43140699bc29..cda1e1080446 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -99,6 +99,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Default RTC update every 10 seconds */
+#define UFS_RTC_UPDATE_INTERVAL_MS (10 * MSEC_PER_SEC)
+
 /* UFSHC 4.0 compliant HC support this mode. */
 static bool use_mcq_mode = true;
 
@@ -683,6 +686,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 			hba->dev_info.wb_enabled = false;
 			hba->dev_info.wb_buf_flush_enabled = false;
 		}
+		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+			hba->dev_info.rtc_time_baseline = 0;
 	}
 	if (err != -EOPNOTSUPP)
 		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
@@ -8190,6 +8195,72 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
 	ufshcd_vops_fixup_dev_quirks(hba);
 }
 
+static void ufshcd_update_rtc(struct ufs_hba *hba)
+{
+	struct timespec64 ts64;
+	int err;
+	u32 val;
+
+	ktime_get_real_ts64(&ts64);
+
+	if (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
+		dev_warn_once(hba->dev, "%s: Current time precedes previous setting!\n", __func__);
+		return;
+	}
+
+	/*
+	 * The Absolute RTC mode has a 136-year limit, spanning from 2010 to 2146. If a time beyond
+	 * 2146 is required, it is recommended to choose the relative RTC mode.
+	 */
+	val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
+
+	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR, QUERY_ATTR_IDN_SECONDS_PASSED,
+				0, 0, &val);
+	ufshcd_rpm_put_sync(hba);
+
+	if (err)
+		dev_err(hba->dev, "%s: Failed to update rtc %d\n", __func__, err);
+	else if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+		hba->dev_info.rtc_time_baseline = ts64.tv_sec;
+}
+
+static void ufshcd_rtc_work(struct work_struct *work)
+{
+	struct ufs_hba *hba;
+
+	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_update_work);
+
+	 /* Update RTC only when there are no requests in progress and UFSHCI is operational */
+	if (!ufshcd_is_ufs_dev_busy(hba) && hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL)
+		ufshcd_update_rtc(hba);
+
+	if (ufshcd_is_ufs_dev_active(hba))
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+				      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+}
+
+static void ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
+{
+	u16 periodic_rtc_update = get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+
+	if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
+		dev_info->rtc_type = UFS_RTC_ABSOLUTE;
+
+		/*
+		 * The concept of measuring time in Linux as the number of seconds elapsed since
+		 * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is elapsed from January 1st
+		 * 2010 00:00, here we need to adjust ABS baseline.
+		 */
+		dev_info->rtc_time_baseline = mktime64(2010, 1, 1, 0, 0, 0) -
+							mktime64(1970, 1, 1, 0, 0, 0);
+	} else {
+		dev_info->rtc_type = UFS_RTC_RELATIVE;
+		dev_info->rtc_time_baseline = 0;
+	}
+}
+
 static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
@@ -8242,6 +8313,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufs_init_rtc(hba, desc_buf);
+
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
@@ -8795,6 +8868,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_force_reset_auto_bkops(hba);
 
 	ufshcd_set_timestamp_attr(hba);
+	schedule_delayed_work(&hba->ufs_rtc_update_work,
+			      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -9752,6 +9827,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
 	if (ret)
 		goto set_link_active;
+
+	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	goto out;
 
 set_link_active:
@@ -9846,6 +9923,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		if (ret)
 			goto set_old_link_state;
 		ufshcd_set_timestamp_attr(hba);
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+				      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
@@ -10542,8 +10621,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 						UFS_SLEEP_PWR_MODE,
 						UIC_LINK_HIBERN8_STATE);
 
-	INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work,
-			  ufshcd_rpm_dev_flush_recheck_work);
+	INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work, ufshcd_rpm_dev_flush_recheck_work);
+	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 
 	/* Set the default auto-hiberate idle timer value to 150 ms */
 	if (ufshcd_is_auto_hibern8_supported(hba) && !hba->ahit) {
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index e77ab1786856..7e7169d94596 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/scsi/scsi_bsg_ufs.h>
+#include <linux/time64.h>
 
 /*
  * Using static_assert() is not allowed in UAPI header files. Hence the check
@@ -551,6 +552,14 @@ struct ufs_vreg_info {
 	struct ufs_vreg *vdd_hba;
 };
 
+/* UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time baseline */
+#define UFS_RTC_TIME_BASELINE BIT(9)
+
+enum ufs_rtc_time {
+	UFS_RTC_RELATIVE,
+	UFS_RTC_ABSOLUTE
+};
+
 struct ufs_dev_info {
 	bool	f_power_on_wp_en;
 	/* Keeps information if any of the LU is power on write protected */
@@ -578,6 +587,10 @@ struct ufs_dev_info {
 
 	/* UFS EXT_IID Enable */
 	bool	b_ext_iid_en;
+
+	/* UFS RTC */
+	enum ufs_rtc_time rtc_type;
+	time64_t rtc_time_baseline;
 };
 
 /*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d862c8ddce03..727bdf296b34 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -912,6 +912,8 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @mcq_opr: MCQ operation and runtime registers
+ * @ufs_rtc_update_work: A work for UFS RTC periodic update
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1076,6 +1078,8 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	struct delayed_work ufs_rtc_update_work;
 };
 
 /**
-- 
2.34.1

