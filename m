Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958F37559CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGQDDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQDDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:03:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBEE41
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:03:30 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R46NG2V0nzBHYMF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:03:26 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689563006; x=1692155007; bh=rj1LT5bHpmuBtzv1OK7rGF7ySrl
        /kE8PVdYCYiJZi9M=; b=DurlklZiQTjvPgxW2hoYfpA6FM+v/b6Om5w5nQh4aQ2
        pii99d7e+zhqyhFpi4s8oGM7NF1YZU2vwmW5RPWNv98nhdSPRSP7k2K5/50C1Ppi
        QqXDHBJCPsYGRmMwVtv9JoO8v3FfUCwuOvQ2PJWyd3EzVSPK7ch6zUy8qyeCP4Oi
        2XWRWoLxSm5dxWV5FKotjwMyo/7pxSJDXt9j8lc1PYEA4KJT3FtCyz4yzt4rWnV+
        aHL38KaSs5HWb5g/hmRNsQL4t/rylwiBS3FosFf629geaG9B+y3m4vQNzAliplDU
        zmbpd93zTdSaCdyvAwsGWZehj+yqc+g4kcXnh2/AKbA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dY6LvTGuiD47 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:03:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R46NG0dnCzBHYMC;
        Mon, 17 Jul 2023 11:03:26 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:03:26 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH]  scsi: Convert snprintf to scnprintf
In-Reply-To: <tencent_3FC1F30F01ADEAF1CAC67170222ADA97DA07@qq.com>
References: <tencent_3FC1F30F01ADEAF1CAC67170222ADA97DA07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7309ee79c3aa243c0b448746c76f1d9e@208suo.com>
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

Fix the coccicheck warnings:

./drivers/scsi/pmcraid.c:3591:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pmcraid.c:3557:8-16: WARNING: use scnprintf or sprintf
./drivers/scsi/pmcraid.c:3496:8-16: WARNING: use scnprintf or sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/pmcraid.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 9415a4819470..a65198a48b16 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3493,7 +3493,7 @@ static ssize_t pmcraid_show_log_level(
      struct Scsi_Host *shost = class_to_shost(dev);
      struct pmcraid_instance *pinstance =
          (struct pmcraid_instance *)shost->hostdata;
-    return snprintf(buf, PAGE_SIZE, "%d\n", 
pinstance->current_log_level);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", 
pinstance->current_log_level);
  }

  /**
@@ -3554,7 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
      char *buf
  )
  {
-    return snprintf(buf, PAGE_SIZE, "version: %s\n",
+    return scnprintf(buf, PAGE_SIZE, "version: %s\n",
              PMCRAID_DRIVER_VERSION);
  }

@@ -3588,7 +3588,7 @@ static ssize_t pmcraid_show_adapter_id(
          pinstance->pdev->devfn;
      u32 aen_group = pmcraid_event_family.id;

-    return snprintf(buf, PAGE_SIZE,
+    return scnprintf(buf, PAGE_SIZE,
              "adapter id: %d\nminor: %d\naen group: %d\n",
              adapter_id, MINOR(pinstance->cdev.dev), aen_group);
  }
