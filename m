Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1D75599E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGQCdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGQCd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:33:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F0103
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:33:07 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R45j81nxgzBHXhg
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:33:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689561180; x=1692153181; bh=kLMGLgzlpWUylD1aig+WRk76Wr1
        qG/HTlfr/E2irSOo=; b=oRFLzKxOMnEy4EJmQ5LpqjYi8w7g+VN3/i268zKI5QP
        2BUjWv5gGfwP5yp2LBHyfyYNjGjzCr0RDSNH0Br/gpMi6hKy9hCBAjAH991GfQiZ
        ri9F1aBQNb7MFCi/j+LBvoXCUsVsp99iyYczsqD1XBjL4KdRJDO50JR3m9gjFHBA
        xacmspR9d9MyyagtjQJ18fRVLurDugQiF5Tf1RG7PRAMP6vCdh0ou+xjwgUgS9j1
        vm3WV7RIOpuGxO7QFnH0oZsXpqjw+D2lLHDFCurFPh6vzOQ2XzU3yp6RgsGQfLXO
        EmJLX8XZLOyGzOgFBXFa4Kch1c14muRxYVAzzhU16aw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UVHflj9JtaeR for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 10:33:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R45j76jyZzBHXR9;
        Mon, 17 Jul 2023 10:32:59 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 10:32:59 +0800
From:   hanyu001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] scsi: Convert snprintf to scnprintf
In-Reply-To: <tencent_1B9669556AF9CF690462AB7F2A47C7378809@qq.com>
References: <tencent_1B9669556AF9CF690462AB7F2A47C7378809@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0130702c160ac0e88f3fd3e2ef02dfbc@208suo.com>
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

Fix the coccicheck warnings:

./drivers/scsi/scsi_transport_sas.c:525:9-17: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_sas.c:572:8-16: WARNING: use scnprintf or 
sprintf
./drivers/scsi/scsi_transport_sas.c:1180:9-17: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/scsi/scsi_transport_sas.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c 
b/drivers/scsi/scsi_transport_sas.c
index d704c484a251..bbbe6ff28b34 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -522,7 +522,7 @@ show_sas_device_type(struct device *dev,
      struct sas_phy *phy = transport_class_to_phy(dev);

      if (!phy->identify.device_type)
-        return snprintf(buf, 20, "none\n");
+        return scnprintf(buf, 20, "none\n");
      return get_sas_device_type_names(phy->identify.device_type, buf);
  }
  static DEVICE_ATTR(device_type, S_IRUGO, show_sas_device_type, NULL);
@@ -569,7 +569,7 @@ show_sas_phy_enable(struct device *dev, struct 
device_attribute *attr,
  {
      struct sas_phy *phy = transport_class_to_phy(dev);

-    return snprintf(buf, 20, "%d\n", phy->enabled);
+    return scnprintf(buf, 20, "%d\n", phy->enabled);
  }

  static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, show_sas_phy_enable,
@@ -1177,7 +1177,7 @@ show_sas_rphy_device_type(struct device *dev,
      struct sas_rphy *rphy = transport_class_to_rphy(dev);

      if (!rphy->identify.device_type)
-        return snprintf(buf, 20, "none\n");
+        return scnprintf(buf, 20, "none\n");
      return get_sas_device_type_names(
              rphy->identify.device_type, buf);
  }
