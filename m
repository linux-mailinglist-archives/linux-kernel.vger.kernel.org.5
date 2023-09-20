Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3B7A76F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjITJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjITJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:12:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5057683;
        Wed, 20 Sep 2023 02:12:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf7a6509deso49511045ad.3;
        Wed, 20 Sep 2023 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695201157; x=1695805957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RDULjoQzHjU0PTxlc2WdDnc+PjIGpAs5L7B9DlE1S8=;
        b=joVd7PI6EwxWeGhUZuaj58hCTKw6OecX+5EkDdFVRDHqAadvu9uafwaDgEa6VD/E91
         5Nf/bBRSGRIYiq7ADaO93Enfx0xCNDzZEnolc2kXIP0zJ4dLa/LTCnJaOLVz9qtTlJ/y
         L+CaerHZqUGxlPWdSd9Hn+yRtpPs+VlhGT/F1VH0NN5iAWwg/wvQxOmsOMciFWxrlLlJ
         30eDEqTf2bqnFEk/SPMg40YPxoTnjkgF6i7yESSPG4N8Lf+J2GCD8m/3Ejb7w3C+TSOj
         SH43Q6ozfjh4YVvDLjMhTdo26/TzhAYdcYLWnYrRGtjGLbEr2JEJ8bVnNIfld6zx8XYh
         y9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201157; x=1695805957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RDULjoQzHjU0PTxlc2WdDnc+PjIGpAs5L7B9DlE1S8=;
        b=MQ5XfMsj7hXjfYpBomKukGr1pLCB5NTRJYJDynpmnSDhsZnpaoYNtw1xMUDu7o+Y6N
         a0UZmaoLVcNaIdpwLShC/sUf3oYw1rzcmDYDlsyZgHM72KaoVVXyFWZd+/4x5Si138jh
         JVnLoJybbBm6aKeXHl1pKUEHY8KV7dZzFZNPfrMrZb6IkaAkEGOhtA0juBHyaOkr2D0q
         qKE24S1i9bjEW7IO1tRnpbCsPICzSVk+DH+KuD331sSuJR5nsXDZ81ENVJeBH65eMBnd
         XctboCQB5IRQGH4QY5HqOm5B6YfjQ0uxByjNWUO5w1jFh883kT1YRDtr88ufJPhTp57T
         XlGQ==
X-Gm-Message-State: AOJu0Yw7qI0pbKg26q4ih/FF5s3IOAitMd157h5xgaT97qrb5ek5qvEe
        414XlJb2IvKXJhBcgXaAHLc=
X-Google-Smtp-Source: AGHT+IH97MOvSyHSZv1yM6IYJs13VxkUpK8BAynmgGvotJS2mQ/lL7rqPZeXmBguHmAGzRIJfDcVTg==
X-Received: by 2002:a17:903:124d:b0:1c5:6691:4978 with SMTP id u13-20020a170903124d00b001c566914978mr2154400plh.37.1695201156730;
        Wed, 20 Sep 2023 02:12:36 -0700 (PDT)
Received: from mason-virtual-machine.localdomain ([43.224.245.242])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902c1d500b001bb8895848bsm5247792plc.71.2023.09.20.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 02:12:36 -0700 (PDT)
From:   Zhang Hui <masonzhang.xiaomi@gmail.com>
X-Google-Original-From: Zhang Hui <zhanghui31@xiaomi.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanley.chu@mediatek.com, peng.zhou@mediatek.com,
        yujiaochen@xiaomi.com, yudongbin@xiaomi.com, zhanghui31@xiaomi.com
Subject: [PATCH] scsi: ufs: core: Do not access null point in ufshpb_remove
Date:   Wed, 20 Sep 2023 17:12:26 +0800
Message-Id: <20230920091226.55663-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanghui <zhanghui31@xiaomi.com>

If hpb is not enabled or not allowed, some points will not be allocated in
init flow, so access them will trigger KE in ufshpb remove flow.

Call trace in rmmod ko:
destroy_workqueue+0x1c/0x234
ufshpb_remove+0x40/0x50
ufshcd_remove+0x3c/0xd0
...

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
 drivers/ufs/core/ufshpb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 255f8b38d0c2..fa345e161cb8 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -2656,6 +2656,9 @@ void ufshpb_init(struct ufs_hba *hba)
 
 void ufshpb_remove(struct ufs_hba *hba)
 {
+	if (!ufshpb_is_allowed(hba) || !hba->dev_info.hpb_enabled)
+		return;
+
 	mempool_destroy(ufshpb_page_pool);
 	mempool_destroy(ufshpb_mctx_pool);
 	kmem_cache_destroy(ufshpb_mctx_cache);
-- 
2.34.1

