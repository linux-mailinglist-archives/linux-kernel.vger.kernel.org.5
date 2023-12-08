Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942DD80A15B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573798AbjLHKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjLHKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:40:20 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7081FF1;
        Fri,  8 Dec 2023 02:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702031990; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CVBdpuKfpQh3RnqOvqIAzSqOssKQhpIxfaHypxjgX+YgQDFHaMOykt2VP7Hdnep/6h
    fKrT1xmQTZKSccG93kMPPCUBsl8f6fhV3ox3dska7Hq1kWTlchQWaldZgh2cmJaqiI1f
    lgqpIyVdM1nRwrXoOlvvnuds+DmgOYg54Z4f1jkJIL/xYAOJmOmDpG6z9P0MYgyFuCMq
    rawq7vUgyFd38ZzLvhuZTLfBKAppj6EmFUApMsabZx5gTuf5qFna1LspxQt/XL0QGDvz
    QxjmzxaaUKjqG7DGzFsi0PY8ve1/hCtmEN/KMjEsTtZ1zDpQvNUCToko8gY0frOsLcnJ
    EPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031990;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=aNJUsEEVhh/k5YDGGcoju8oExRYTWnmRPy1Q8p94Okc=;
    b=MdG5+t1x4vJ+GLXaG7Wg8sY+7KyLk/lFPifg3WpmwgGc/bqc3Svct0eadM20Gjlr1K
    Br/ZEwrU866H8R1lw+ZQj7yoOQmL/IIGUSoGnOmlgh5jA0OijRVKrJtYajIBvaK+UDUa
    AAUzOIFVNGiwQRknn/bUd4MJHW9IsFiinfEOQ3xBCw2H4csh/tayLrbiNrGAbrFTqtbU
    lTs55Ia0QoDFDJtGVcbcXB6y7/mKgQxHUdHteBPyeqbwv0BYentymKSIHpxAa/e4CI1H
    Q15PSEQxIwJ52gU+2FV3K9/j19KGzLGoGoLSxpItL8FcqN9JOyai0rCFll1hsbmGTQsr
    tt5Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031990;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=aNJUsEEVhh/k5YDGGcoju8oExRYTWnmRPy1Q8p94Okc=;
    b=grECucoWOqf/VgyGkqkNNLP4w02MNtnnFaEKzUj9HOp0cVR8mkvETZEVjFB2vfFUFh
    XcVX6Gx6HyyfAEqKwThU16qWgpIvaw20cmPnIbLT/iuaonakEYTbI8AQJx+TtDksayiU
    LW8UenHwa5vzp6tKKCAzmGe9c0CtlkH3c1a0GfJTKrm8RFmwSIxVE7gzcESw4ZkBDfWf
    NvBQuiW3lXE9FlbZPseBFkeTNpcZG7kOZpWtiqoHMzG9e60Nw+O6Q8j+6tzHsE4EfCKX
    vCEgFEHFEqz3svOdoT2VpOOQdsTBXatr3rPStHS5pOPGnXvA/NQIo1FAg+YYT7Jr/lGM
    uqpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702031990;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=aNJUsEEVhh/k5YDGGcoju8oExRYTWnmRPy1Q8p94Okc=;
    b=wKu+rDyLU5H1TP25f9RdQ0PAZEvX7YNViXf+0/J440jvKp8sqKEa/DJLL7H81EObx8
    7AVyaCaNQd5tCcNN9nDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8AdnBb7
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
Subject: [PATCH v4 3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
Date:   Fri,  8 Dec 2023 11:39:40 +0100
Message-Id: <20231208103940.153734-4-beanhuo@iokpp.de>
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

Introduce a sysfs node named 'rtc_update_ms' within the kernel, enabling
user to adjust the RTC periodic update frequency to suit the specific
requirements of the system and UFS. Also, this patch allows the user to
disable/enable periodic update RTC in the UFS idle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  7 +++++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 11 ++++++--
 include/ufs/ufs.h                          |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index b73067bb5ea2..5bf7073b4f75 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1523,3 +1523,10 @@ Description:	Indicates status of Write Booster.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/rtc_update_ms
+What:		/sys/bus/platform/devices/*.ufs/rtc_update_ms
+Date:		November 2023
+Contact:	Bean Huo <beanhuo@micron.com>
+Description:
+		rtc_update_ms indicates how often the host should synchronize or update the
+		UFS RTC. If set to 0, this will disable UFS RTC periodic update.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 05b10ca90b50..7a11575f7e1b 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -302,6 +302,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t rtc_update_ms_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
+}
+
+static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int ms;
+	bool resume_period_update = false;
+
+	if (kstrtouint(buf, 0, &ms))
+		return -EINVAL;
+
+	if (!hba->dev_info.rtc_update_period && ms > 0)
+		resume_period_update =  true;
+	/* Minimum and maximum update frequency should be synchronized with all UFS vendors */
+	hba->dev_info.rtc_update_period = ms;
+
+	if (resume_period_update)
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+						msecs_to_jiffies(hba->dev_info.rtc_update_period));
+	return count;
+}
+
 static ssize_t enable_wb_buf_flush_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -386,6 +415,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RW(rtc_update_ms);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -398,6 +428,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_rtc_update_ms.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dedb0c08363b..953d50cc4256 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8240,9 +8240,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 	if (!is_busy)
 		ufshcd_update_rtc(hba);
 
-	if (ufshcd_is_ufs_dev_active(hba))
+	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
 		schedule_delayed_work(&hba->ufs_rtc_update_work,
-			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+			msecs_to_jiffies(hba->dev_info.rtc_update_period));
 }
 
 static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
@@ -8264,6 +8264,13 @@ static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
 		dev_info->rtc_time_baseline = 0;
 	}
 
+	/*
+	 * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because Spec does not clearly state
+	 * how to calculate the specific update period for each time unit. Here we disable periodic
+	 * update work, and let user configure by sysfs node according to specific circumstance.
+	 */
+	hba->dev_info.rtc_update_period = 0;
+
 	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 }
 
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 8022d267fe8a..288724d3be90 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -592,6 +592,7 @@ struct ufs_dev_info {
 	/* UFS RTC */
 	enum ufs_rtc_time rtc_type;
 	time64_t rtc_time_baseline;
+	u32 rtc_update_period;
 };
 
 /*
-- 
2.34.1

