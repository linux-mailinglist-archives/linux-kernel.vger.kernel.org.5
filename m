Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80067E6AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKIMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:52:37 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFC2D70
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699534347; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HvxOaHSRlZbk1XmVvFWCzCAS/poMD2oKLLszE7IAbyjw0a5FUUeZlV269UkD5H/8NF
    xxWF4mnLyvGK5+MEvnCFGO7E85ZW8bMVL7XASELEENcw8x0MmQKYePxzvIfuDn/QxHcv
    jv5Q7TWTiBUV9b+jjWVlIb0quMwJ4UGPv1WDarfE4IGHgc4YuvKlaX55IqhKO30Y2sLb
    xYebZRJH7SdTMVG0KDf1fbTRINg4HLrdKTXmUHWXeQcurR4O8aY5nfRT+fmyvntzBYA5
    smAMWtjDyQQ0fCoJ4g63plcmhzKRZvTUBS0bDZq3NqMxftCVoOu52+vSBAZ4JLRPyXM0
    qxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v4SoIWsZxnHJorNVgiNnDjS/thMt0XzDKT8bGo5VjDA=;
    b=mkCld7oj7u3aYWklGDg0QTy+fwgiy9Ys4Z03Xq8zBVPtXfpg4FK+GxgRgqZyICL5/5
    4gtUmlPPSZ4dWpAwOeR7osIUOmFWegpaVsnw07ONlzj0R20+nr0DEMnorIBbz6Sogjt1
    QR8Mm5Oa3KbuKiqmYOgRODAZ6wt826Z+Ah02kPPuGodRXzk+0Hk2G4XV8NPW1PtEXZ3I
    9yfFf2mR8VyVPa60Ut/8+ibt2gGMQQLMJ3YpRxpgTboD7EgqcoMy1v8Zc82Mgpb2nF5b
    vDMg1G0tCB3EHepvg0s2uO7G+PQkFXf5w6srBxqKRU8Cyk0IeAwfr2tdq34WWH/h1lU4
    hvKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v4SoIWsZxnHJorNVgiNnDjS/thMt0XzDKT8bGo5VjDA=;
    b=hI+HM+a7Yhwu+qO5vV1G5Oq5clKjkNb7IuOmaRD7FhM2LUu0zVabY/6tXhD1ARUvC/
    vzATzvfA7O4QiFfd3iAEJ23mMqAc+kYw1brCWEiNRTQPGBlplunZjvmTUVybL4RqvgZa
    jWdNFaMbVLuk5/MBH4kaFZN6MGbnBfaa/jmpBv5DUhEFe2dmOaNGe5Zc1p0Gb5njXA4G
    CmTqi6nBFM/XmqIWz/LZF6b3aMstGfbnZz0nJViAIXgEIS4iBriIJF70PIQ0dKLnoyIH
    mo+B7r2wa/qZnXFi0YqYGVfriGvQaE/dtN0cIXW6jIz5SKDgM2Xa2ZzsK4taClVrvzMk
    GTLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699534347;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=v4SoIWsZxnHJorNVgiNnDjS/thMt0XzDKT8bGo5VjDA=;
    b=oHvFJVZB2InfVpbMs/RvesrWQUjAxaDssXgPHKGtFaZqGWP1aMkZC4UvztwrYunlid
    /IyLjDa9v0OK/MxRTzAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id zd0181zA9CqRvYp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Nov 2023 13:52:27 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
Date:   Thu,  9 Nov 2023 13:52:17 +0100
Message-Id: <20231109125217.185462-3-beanhuo@iokpp.de>
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

This patch introduces a sysfs node named 'rtc_update_ms' within the kernel, enabling users to
adjust the RTC periodic update frequency to suit the specific requirements of the system and
UFS. Also, this patch allows the user to disable periodic update RTC  in the UFS idle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs-sysfs.c | 31 +++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c    |  4 ++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f..d42846316a86 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -255,6 +255,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
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
+	bool resume_period_update;
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
+		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
+						msecs_to_jiffies(hba->dev_info.rtc_update_period));
+	return count;
+}
+
 static ssize_t enable_wb_buf_flush_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -339,6 +368,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RW(rtc_update_ms);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -351,6 +381,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_rtc_update_ms.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f0e3dd3dd280..ae9b60619fd3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8234,9 +8234,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 
 	ufshcd_update_rtc(hba);
 out:
-	if (ufshcd_is_ufs_dev_active(hba))
+	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
 		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
-							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
+						msecs_to_jiffies(hba->dev_info.rtc_update_period));
 	return;
 }
 
-- 
2.34.1

