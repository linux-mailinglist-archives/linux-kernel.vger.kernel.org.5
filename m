Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84B7722DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjHGLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjHGLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:39:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E130CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:36:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so43722105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691408157; x=1692012957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Agm9ohdAYV3+TshoHqaF/LVvRZmz4yzXXe9p6yrAkKE=;
        b=Akbk335S4dpmyQasHji3KS4o/sb2OAArXxyq6qwzV5QElqeK6tdaEAIPZ+z5u29rBS
         VxG8q3L5ZoGpS5nuz2qQ66iKxnDsZ9wssAUCGKjd88+VvJgWOCFm9xg+Mz0pj8Ch9tKK
         BLxC7q9eXl3n+Tjo4wi5A3DOdDBr/lx0AdRm6loAyCBlVS3Why2wUK8RB5K35yXspWQ2
         T2cIasnafgfg8oadu6OYAZnhPlsFUjseLIe4AGzSPOLrqXJolQ5RmWmtpvHhHgsQ0bdh
         OsQukXbhjZn6aNdAALt9sXYWtHaI5cHJxrfWZ1+md5hU20/yQp6KJZcMTZkpDECAHcnN
         OO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408157; x=1692012957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agm9ohdAYV3+TshoHqaF/LVvRZmz4yzXXe9p6yrAkKE=;
        b=CB2uTodKQ0bpwTxR4NH/A/VMt0dZP0l8Icquo/Gx0ugE3ChEfEqe9Rg73ny6TyUqZ1
         Yu0kxERAHsr/Ol6skJUurOeotRWrx9jq1p2kftzeyI4c1DqRvhIUdYmQjVCzgXzmwZAI
         QAoqFjw7NPkagAc5YiPq1l1BCHYeBkfIFSbTA0dZVfg3pWMBpnlrpIaf5T4XYxfegMYq
         GMfXSYCClW6dMEFE0mfL8ik0dwuPLMjmt8AlrppN2AApCWcDyykIiXsDLAYRUbTL5mfG
         Dhg47ZVl2nvQRjLXmifi8TLP7Xe1zu1olyC5hNs5mgYH441CescnQwLXK3P5cWnF0JPs
         7Mng==
X-Gm-Message-State: AOJu0YxER2x6xgATc/vUluyx465wCTEpArS0ix9JB62gKOoFCymLen7I
        BHQCQZE7zUkEBhsv7pVYag1ozHJMUrMAnQ==
X-Google-Smtp-Source: AGHT+IGltSF6t4D+QkUDVZOK8qKk4Qx2aCBEZhfw5g1s4x4+JBjuVNskE6cv+o8bYgmauB6cheSSDA==
X-Received: by 2002:a05:600c:2297:b0:3fe:1b67:db7e with SMTP id 23-20020a05600c229700b003fe1b67db7emr7253343wmf.18.1691408156915;
        Mon, 07 Aug 2023 04:35:56 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c234a00b003fc16ee2864sm10458653wmq.48.2023.08.07.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:35:56 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     michal.simek@amd.com, p.zabel@pengutronix.de, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] reset: zynq: remove unneeded call to platfrom_set_drvdata()
Date:   Mon,  7 Aug 2023 14:35:45 +0300
Message-Id: <20230807113545.14743-1-aboutphysycs@gmail.com>
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-zynq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-zynq.c b/drivers/reset/reset-zynq.c
index 706bbbbb4ec7..688b512882ec 100644
--- a/drivers/reset/reset-zynq.c
+++ b/drivers/reset/reset-zynq.c
@@ -94,7 +94,6 @@ static int zynq_reset_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, priv);
 
 	priv->slcr = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						     "syscon");
-- 
2.34.1

