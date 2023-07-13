Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85CE751D91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjGMJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjGMJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:42:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30E359B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:41:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1qNj6cfYzBJx3w
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:40:53 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689241253; x=1691833254; bh=W1OSJeuitguUtY+tH1dNwmL1b5W
        ZEKIxcKU+sdfcjLQ=; b=sWDpdinzoh13UDyz3CpJHEfqr/Og6AuRdbtiqAJn4os
        LjvNNQl5keQAAW0/vue5nouI+5Fjkg80UVfzZGJnBdpdwD9ror2Symkn/76zs/Ku
        JALg7OZAhT12RpOwo3rZFFH97GjcFgaPe9UZB59053u2nunGV2Xs1firvgpRn++6
        BpmZEzNhf1ge6Kb2AG62aB6AZP0OgOxNa/8UnITUuS22QV5++WrQWuTfAy5pm1J5
        Vg8oJe4/4eWwI6L0epXwyLhlwrDYQuo69CY0W50dYsTNUdLC49eLkiP6DQLPDhBD
        B2LJt2ihXmwyTAbkzMZZMbrU/6wJA5jdS9AEA69sSJg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M2b6Th8xyt3a for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 17:40:53 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1qNj29s4zBHXgh;
        Thu, 13 Jul 2023 17:40:53 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 17:40:53 +0800
From:   hanyu001@208suo.com
To:     erazor_de@users.sourceforge.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] hid:  Replace snprintf() with sysfs_emit()
In-Reply-To: <tencent_F6951CE34644A8B408B524E70F0283D50F08@qq.com>
References: <tencent_F6951CE34644A8B408B524E70F0283D50F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <bad7fd90191a531ebf10816f48d3012f@208suo.com>
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

coccinelle report:
./drivers/scsi/mvsas/mv_init.c:699:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/mvsas/mv_init.c:747:8-16:
WARNING: use scnprintf or sprintf

./drivers/hid/hid-roccat-kovaplus.c:330:8-16: WARNING: use scnprintf or 
sprintf
./drivers/hid/hid-roccat-kovaplus.c:277:8-16: WARNING: use scnprintf or 
sprintf
./drivers/hid/hid-roccat-kovaplus.c:339:8-16: WARNING: use scnprintf or 
sprintf
./drivers/hid/hid-roccat-kovaplus.c:349:8-16: WARNING: use scnprintf or 
sprintf
./drivers/hid/hid-roccat-kovaplus.c:370:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat-kovaplus.c 
b/drivers/hid/hid-roccat-kovaplus.c
index 1a1d96e11683..282e26f55074 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -274,7 +274,7 @@ static ssize_t 
kovaplus_sysfs_show_actual_profile(struct device *dev,
  {
      struct kovaplus_device *kovaplus =
              hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-    return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
  }

  static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct 
device *dev,
  {
      struct kovaplus_device *kovaplus =
              hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-    return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
  }
  static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, 
NULL);

@@ -336,7 +336,7 @@ static ssize_t 
kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
  {
      struct kovaplus_device *kovaplus =
              hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-    return snprintf(buf, PAGE_SIZE, "%d\n", 
kovaplus->actual_x_sensitivity);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
kovaplus->actual_x_sensitivity);
  }
  static DEVICE_ATTR(actual_sensitivity_x, 0440,
             kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -346,7 +346,7 @@ static ssize_t 
kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
  {
      struct kovaplus_device *kovaplus =
              hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-    return snprintf(buf, PAGE_SIZE, "%d\n", 
kovaplus->actual_y_sensitivity);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
kovaplus->actual_y_sensitivity);
  }
  static DEVICE_ATTR(actual_sensitivity_y, 0440,
             kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -367,7 +367,7 @@ static ssize_t 
kovaplus_sysfs_show_firmware_version(struct device *dev,
              &info, KOVAPLUS_SIZE_INFO);
      mutex_unlock(&kovaplus->kovaplus_lock);

-    return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
  }
  static DEVICE_ATTR(firmware_version, 0440,
             kovaplus_sysfs_show_firmware_version, NULL);
