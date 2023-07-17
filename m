Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36993755A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGQDnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGQDnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:43:45 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AB134
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:43:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R47Gg13GwzBHXhP
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:43:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689565419; x=1692157420; bh=z3XCtoPPqqOMV3gnIpeNg/Kkivw
        KIMODoeIuwOAKww0=; b=HNag/vJB0+tnSjfFT7xMr9tL2ecrxgRW8CyEn+t83f0
        ghQ9OV3oNe9Iw5HBZSvQiHZv/ij9bcCZfrIG/RObA9Y7F6pzd1pTsizUBGE487el
        Fu1k2+j2F+uV5PflDxIZz33nGfDbmTRIOCg3qxso7cWB5MUT1SeP6khqqy/fpGXq
        OKyIQnafhYYX1qe8pfqvy7ZG9jZyL6TYgj5dyyJN+w/QEboo4K9WVPYn/Iu/4zXJ
        6kknoW5Ax394/H8gYidh/iDHHB176hqNDwZAPndrsACumZeVjWEUWitY2ZnoFEf+
        34jR6mdfkHTSUsoDWojn2yTPYXXkM9OlRsyHwSvf9yw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9dKl_XrkocKs for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:43:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R47Gf5qlwzBHXR9;
        Mon, 17 Jul 2023 11:43:38 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:43:38 +0800
From:   hanyu001@208suo.com
To:     kashyap.desai@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: Convert snprintf to scnprintf
In-Reply-To: <tencent_5A4487B426B52AE79302EAD5319595E3B308@qq.com>
References: <tencent_5A4487B426B52AE79302EAD5319595E3B308@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <dec39ad58f9c6592a2c505a17930a5ec@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/scsi/megaraid/megaraid_sas_base.c:3422:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3412:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3338:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3385:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3402:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3392:WARNING: use scnprintf or 
sprintf
drivers/scsi/megaraid/megaraid_sas_base.c:3476:WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/megaraid/megaraid_sas_base.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c 
b/drivers/scsi/megaraid/megaraid_sas_base.c
index 050eed8e2684..da7931ba4261 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3335,7 +3335,7 @@ fw_crash_buffer_size_show(struct device *cdev,
      struct megasas_instance *instance =
          (struct megasas_instance *) shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
+    return scnprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
          ((instance->fw_crash_buffer_size) * 1024 * 1024)/PAGE_SIZE);
  }

@@ -3382,14 +3382,14 @@ fw_crash_state_show(struct device *cdev,
      struct megasas_instance *instance =
          (struct megasas_instance *) shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
  }

  static ssize_t
  page_size_show(struct device *cdev,
      struct device_attribute *attr, char *buf)
  {
-    return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 
1);
+    return scnprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE 
- 1);
  }

  static ssize_t
@@ -3399,7 +3399,7 @@ ldio_outstanding_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct megasas_instance *instance = (struct megasas_instance 
*)shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d\n", 
atomic_read(&instance->ldio_outstanding));
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
atomic_read(&instance->ldio_outstanding));
  }

  static ssize_t
@@ -3409,7 +3409,7 @@ fw_cmds_outstanding_show(struct device *cdev,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct megasas_instance *instance = (struct megasas_instance 
*)shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d\n", 
atomic_read(&instance->fw_outstanding));
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
atomic_read(&instance->fw_outstanding));
  }

  static ssize_t
@@ -3419,7 +3419,7 @@ enable_sdev_max_qd_show(struct device *cdev,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct megasas_instance *instance = (struct megasas_instance 
*)shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d\n", 
instance->enable_sdev_max_qd);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
instance->enable_sdev_max_qd);
  }

  static ssize_t
@@ -3473,7 +3473,7 @@ raid_map_id_show(struct device *cdev, struct 
device_attribute *attr,
      struct megasas_instance *instance =
              (struct megasas_instance *)shost->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%ld\n",
+    return scnprintf(buf, PAGE_SIZE, "%ld\n",
              (unsigned long)instance->map_id);
  }
