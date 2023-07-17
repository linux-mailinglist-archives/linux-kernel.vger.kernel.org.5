Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF11755B65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGQGSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGQGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:18:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22B11C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:18:34 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4BjN0YWszBHXhQ
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:18:32 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689574711; x=1692166712; bh=oVZePtAPC3fqwCLp67FFuqYQqHm
        SMXChT2dSFjfiNgM=; b=f9PBpLEvFF7pj+m6iqfzgDlO3V/jRhRjBUq1Dq9GwYS
        XJoNGRaUF9qsMFa4xW8yJxmlXKL8/r78EbpCBKefbaO1/goTWHL6Q+mXXlai1ydK
        gYewFrmxyw5LOSh1WmtgGXCvimlyp7Sq23cFMDS4EH8JdgP2R4D/pA4zJFxtkYjg
        nSngh3Y6dSp7CRbXq+tFKs0LxZzeJqNOpTDVSan9maacuyZdR2aovIG6aUV6Ewga
        vI10r+jYK9WuhYTTWWkc7ijOU7WZNAW/gH0AEZCppyn4AC0MQ71YfncORN3zNNat
        mhBExsW0JzEF3E8UMIXHvieDt0dzMlcLN/imLwO6edw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id okXOQfCU0eD8 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 14:18:31 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4BjM5btfzBHXgf;
        Mon, 17 Jul 2023 14:18:31 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 14:18:31 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: Convert snprintf to scnprintf
In-Reply-To: <tencent_F14720A15AAC92683C94E88876A876E7FC05@qq.com>
References: <tencent_F14720A15AAC92683C94E88876A876E7FC05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4a69897245577acfb2f095501b21cd78@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/qla4xxx/ql4_attr.c:200:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:273:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:281:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:303:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:210:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:264:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:312:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:159:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:256:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:247:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:181:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:190:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:223:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:235:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/qla4xxx/ql4_attr.c:173:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/qla4xxx/ql4_attr.c | 30 +++++++++++++++---------------
  1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_attr.c 
b/drivers/scsi/qla4xxx/ql4_attr.c
index abfa6ef60480..6ab578443e12 100644
--- a/drivers/scsi/qla4xxx/ql4_attr.c
+++ b/drivers/scsi/qla4xxx/ql4_attr.c
@@ -156,7 +156,7 @@ qla4xxx_fw_version_show(struct device *dev,
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));

      if (is_qla80XX(ha))
-        return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
+        return scnprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
                  ha->fw_info.fw_major, ha->fw_info.fw_minor,
                  ha->fw_info.fw_patch, ha->fw_info.fw_build);
      else
@@ -170,7 +170,7 @@ qla4xxx_serial_num_show(struct device *dev, struct 
device_attribute *attr,
              char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%s\n", ha->serial_number);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ha->serial_number);
  }

  static ssize_t
@@ -178,7 +178,7 @@ qla4xxx_iscsi_version_show(struct device *dev, 
struct device_attribute *attr,
                 char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%d.%02d\n", 
ha->fw_info.iscsi_major,
+    return scnprintf(buf, PAGE_SIZE, "%d.%02d\n", 
ha->fw_info.iscsi_major,
              ha->fw_info.iscsi_minor);
  }

@@ -187,7 +187,7 @@ qla4xxx_optrom_version_show(struct device *dev, 
struct device_attribute *attr,
                  char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
+    return scnprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
              ha->fw_info.bootload_major, ha->fw_info.bootload_minor,
              ha->fw_info.bootload_patch, ha->fw_info.bootload_build);
  }
@@ -197,7 +197,7 @@ qla4xxx_board_id_show(struct device *dev, struct 
device_attribute *attr,
                char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
+    return scnprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
  }

  static ssize_t
@@ -207,7 +207,7 @@ qla4xxx_fw_state_show(struct device *dev, struct 
device_attribute *attr,
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));

      qla4xxx_get_firmware_state(ha);
-    return snprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
+    return scnprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
              ha->addl_fw_state);
  }

@@ -220,7 +220,7 @@ qla4xxx_phy_port_cnt_show(struct device *dev, struct 
device_attribute *attr,
      if (is_qla40XX(ha))
          return -ENOSYS;

-    return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
+    return scnprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
  }

  static ssize_t
@@ -232,7 +232,7 @@ qla4xxx_phy_port_num_show(struct device *dev, struct 
device_attribute *attr,
      if (is_qla40XX(ha))
          return -ENOSYS;

-    return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
+    return scnprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
  }

  static ssize_t
@@ -244,7 +244,7 @@ qla4xxx_iscsi_func_cnt_show(struct device *dev, 
struct device_attribute *attr,
      if (is_qla40XX(ha))
          return -ENOSYS;

-    return snprintf(buf, PAGE_SIZE, "0x%04X\n", 
ha->iscsi_pci_func_cnt);
+    return scnprintf(buf, PAGE_SIZE, "0x%04X\n", 
ha->iscsi_pci_func_cnt);
  }

  static ssize_t
@@ -253,7 +253,7 @@ qla4xxx_hba_model_show(struct device *dev, struct 
device_attribute *attr,
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));

-    return snprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
  }

  static ssize_t
@@ -261,7 +261,7 @@ qla4xxx_fw_timestamp_show(struct device *dev, struct 
device_attribute *attr,
                char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%s %s\n", 
ha->fw_info.fw_build_date,
+    return scnprintf(buf, PAGE_SIZE, "%s %s\n", 
ha->fw_info.fw_build_date,
              ha->fw_info.fw_build_time);
  }

@@ -270,7 +270,7 @@ qla4xxx_fw_build_user_show(struct device *dev, 
struct device_attribute *attr,
                 char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.fw_build_user);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", 
ha->fw_info.fw_build_user);
  }

  static ssize_t
@@ -278,7 +278,7 @@ qla4xxx_fw_ext_timestamp_show(struct device *dev, 
struct device_attribute *attr,
                    char *buf)
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-    return snprintf(buf, PAGE_SIZE, "%s\n", 
ha->fw_info.extended_timestamp);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", 
ha->fw_info.extended_timestamp);
  }

  static ssize_t
@@ -300,7 +300,7 @@ qla4xxx_fw_load_src_show(struct device *dev, struct 
device_attribute *attr,
          break;
      }

-    return snprintf(buf, PAGE_SIZE, "%s\n", load_src);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", load_src);
  }

  static ssize_t
@@ -309,7 +309,7 @@ qla4xxx_fw_uptime_show(struct device *dev, struct 
device_attribute *attr,
  {
      struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
      qla4xxx_about_firmware(ha);
-    return snprintf(buf, PAGE_SIZE, "%u.%u secs\n", ha->fw_uptime_secs,
+    return scnprintf(buf, PAGE_SIZE, "%u.%u secs\n", 
ha->fw_uptime_secs,
              ha->fw_uptime_msecs);
  }
