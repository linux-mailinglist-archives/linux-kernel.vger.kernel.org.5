Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9680A1F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjLHLOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjLHKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:40:20 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F2199F;
        Fri,  8 Dec 2023 02:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702031989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a87TYAquH8C5MOgBAVVEeOB4SBR4IvU3wb22evvOtG82U/Db0b6al+XWr6XrG6+W/l
    6GMwcNJA/D7SlOvTBUr29ZUwAV4RU8vbIahM/FPReFFYeC4x/38JuoHTtM6Kw9+J9EWs
    6O2G0EIR0f7uX0L/+Al27QppBccUfVtf9DzDeVbnP+eBMjE9tvPI/2RgLgqi2gt4MVWK
    6W3v/TDJ7FuYMLM805Wn4TPubpi5tZuEWH1Xpv5GZjw4EV44+HmQxDdZJi7H1/+a74fm
    /qEJ/nUQSGSYh4+UNsJQknH2woHL8SkkfTOEqbZPgkSM9+sx+2e6QEFaKIr8NXacuncD
    5R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f4Ujy1ijztwDcW/0RIdcSn0ti3Y6B/IocFLBxQZTpHw=;
    b=m4BkZbag82BJqV3LBsUj+IAmF6IlZt3cjnpMuss75YCJUG4LuX+bz6Mi/dpDHvLEak
    AE1F0cF2S4vnH4LDgVdMeok4gj95QV+xRLCl6cTpHjn1/CO9EVzHtW8qfiCyyDV0ndEj
    P/USz+2ggsBu2qzS2BcF9fWVmAu4QBh+FmcyjP3h+Grdg3yx419bueyN2CMqI6PDBlJk
    UCm1omi4gMKaLJQB5Ctw7voJlyJPlyDEANmELJJKHyT3eOAmzfztOH2DUkWUw2aF4bwi
    Dcs35h2awWOWzsxI9xZp0bBnvX+RWXIy/OrJgL3LMNz4SKbfxWgVWPvXlztrnNsPeACy
    +3lA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f4Ujy1ijztwDcW/0RIdcSn0ti3Y6B/IocFLBxQZTpHw=;
    b=saipu40CVxNAxDk1hnk7cFNwMqlq747/bh8DDrFu1Vi7Hc5XAqm3jY2po1gI1m5NLC
    kwZcT2Iih8TitNERon23g+FW8p+bJXaZ9ae4ojYn1YLIzguGy+3dUa3mw2XhGy4qUhBW
    kQ7zcyHS4eOrRFdU+dZAa57+9k8c++LR1C8As/Pi9s9zlYosyf6w+zUP36e1f0gN/1PC
    h/MUDCIiOvp8aKwbue444DhewnCGuIhuj/J6xRGfUs7b9HjPGSQC7V3fZ2hiOSGzI1pp
    oK/bXbE5l2OX+Ujw7Ma0s3US28U8wv2KsmZe4n0gET1VPZoUtGcZDGhFJK4p9DLgRZ2c
    Bh5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f4Ujy1ijztwDcW/0RIdcSn0ti3Y6B/IocFLBxQZTpHw=;
    b=TSn/AK1MOPZQi2+uofxJZn7Wcty6YXjKs+cxyj54HdKc4sjn3SHeC6fWT+Uwk6F+X4
    vtuJQAOFl4zBH/u3HoCg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8AdnBb5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Dec 2023 11:39:49 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Date:   Fri,  8 Dec 2023 11:39:39 +0100
Message-Id: <20231208103940.153734-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208103940.153734-1-beanhuo@iokpp.de>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
---
 drivers/ufs/core/ufshcd.c | 84 +++++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         | 14 +++++++
 include/ufs/ufshcd.h      |  4 ++
 3 files changed, 102 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 32cfcba66d60..dedb0c08363b 100644
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
 
@@ -684,6 +687,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 			hba->dev_info.wb_enabled = false;
 			hba->dev_info.wb_buf_flush_enabled = false;
 		}
+		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+			hba->dev_info.rtc_time_baseline = 0;
 	}
 	if (err != -EOPNOTSUPP)
 		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
@@ -8191,6 +8196,77 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
 	ufshcd_vops_fixup_dev_quirks(hba);
 }
 
+static void ufshcd_update_rtc(struct ufs_hba *hba)
+{
+	int err;
+	u32 val;
+	struct timespec64 ts64;
+
+	ktime_get_real_ts64(&ts64);
+
+	if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
+		dev_warn(hba->dev, "%s: Current time precedes previous setting!\n", __func__);
+		return;
+	}
+	/*
+	 * Absolute RTC mode has 136-year limit as of 2010. Modify UFS Spec or choosing relative
+	 * RTC mode for longer (beyond year 2146) time spans.
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
+	bool is_busy;
+
+	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_update_work);
+
+	is_busy = ufshcd_is_ufs_dev_busy(hba);
+	/*
+	 * RTC updates should not interfere with normal IO requests; we should only update the RTC
+	 * when there are no ongoing requests.
+	 */
+	if (!is_busy)
+		ufshcd_update_rtc(hba);
+
+	if (ufshcd_is_ufs_dev_active(hba))
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+}
+
+static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u16 periodic_rtc_update = get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
+
+	if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
+		dev_info->rtc_type = UFS_RTC_ABSOLUTE;
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
+
+	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
+}
+
 static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
@@ -8243,6 +8319,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufs_init_rtc(hba, desc_buf);
+
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
@@ -8796,6 +8874,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_force_reset_auto_bkops(hba);
 
 	ufshcd_set_timestamp_attr(hba);
+	schedule_delayed_work(&hba->ufs_rtc_update_work,
+				msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -9753,6 +9833,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
 	if (ret)
 		goto set_link_active;
+
+	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	goto out;
 
 set_link_active:
@@ -9847,6 +9929,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		if (ret)
 			goto set_old_link_state;
 		ufshcd_set_timestamp_attr(hba);
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+					msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index e77ab1786856..8022d267fe8a 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/scsi/scsi_bsg_ufs.h>
+#include <linux/time64.h>
 
 /*
  * Using static_assert() is not allowed in UAPI header files. Hence the check
@@ -551,6 +552,15 @@ struct ufs_vreg_info {
 	struct ufs_vreg *vdd_hba;
 };
 
+/*
+ * UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time baseline.
+ */
+#define UFS_RTC_TIME_BASELINE BIT(9)
+enum ufs_rtc_time {
+	UFS_RTC_RELATIVE,
+	UFS_RTC_ABSOLUTE
+};
+
 struct ufs_dev_info {
 	bool	f_power_on_wp_en;
 	/* Keeps information if any of the LU is power on write protected */
@@ -578,6 +588,10 @@ struct ufs_dev_info {
 
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

