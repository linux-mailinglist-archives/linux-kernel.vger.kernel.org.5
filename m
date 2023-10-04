Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E57B798A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjJDIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:05:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7ABAC;
        Wed,  4 Oct 2023 01:05:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405524e6768so17647445e9.2;
        Wed, 04 Oct 2023 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696406746; x=1697011546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5CfZEEfJRek6a1cxfvCbS2vJHw6e2V38hQo9fWQ7BE=;
        b=O01hd1MKnI7szlrMtBUpQ9XQSVYnAcpcqmPq6fx1J4+b05wVItWjLvB6595EykVGRu
         k+hc2AUvxER9MmWP5VYd7ojDldmyc8Xjma3zoF5tmtb+xZNXpwIJ1TR1c8e/W7bB8VLw
         GtdvgdkgAb3lqlEOkpxqzn6G42+4/CQ9pEwOgdE/aMAjCxgbdgTUlCnE0HNRgjZGTKXs
         pyfvJ+KcYZPlCeD31cJpedZHo42IHz15MVgtegyUA905C8fjGEU0ZaekR4PG6eXIv55Q
         XcTTqF+IppMSIxQPrKeAj/33o37pFRTjBW7eHSewxcMKhR/PTBn8B0SQkDNiHqWsIGDP
         Uy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406746; x=1697011546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5CfZEEfJRek6a1cxfvCbS2vJHw6e2V38hQo9fWQ7BE=;
        b=wx+7quhg3J6LylNmDy7rr5tG7QiXqqkIOaKSVUEO5CPloTF8emIhUUHg+nuDMbRF/+
         KIm8kikJeJ9JNFmHNfWvZ+peNPUQBRCdIZ5589cdOHXAeywaBWHJvURVYAF1cWVBPUXm
         g10u/X/ShUo9IyRwxYZT6Rl86t52iuJSRRoK2kD3eP0iHxcBsKU6rHMGTeViF826tURT
         EJg+3sUIyx2O3xmj+KHAtTOej0c9MZe/nB7AL1n9NYE3kMjOs5w5cRu+pS3BmwYJI5jt
         NC038/RUTdYKh9XG2k0Uvs17Xv8HCDKL46JjPKgFi66J76FMFYt2HxyLlV6GPxL8P+ML
         /0QA==
X-Gm-Message-State: AOJu0YzwJAwwRK9c086Jmniv+VyZomracrERnezaTWPiy9VON3gHsaKy
        OEAZo1UguLrZE3LXZOz3btE=
X-Google-Smtp-Source: AGHT+IHDBENQD6ewVkil1vNt9g2gLmQNN6XpwzvMqLcZV9IgbXe1MV1L1OAq4tt+VMrRKAiDAQJxQA==
X-Received: by 2002:a1c:720a:0:b0:401:b6f6:d90c with SMTP id n10-20020a1c720a000000b00401b6f6d90cmr1597644wmc.35.1696406745804;
        Wed, 04 Oct 2023 01:05:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b004064e3b94afsm875372wmc.4.2023.10.04.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:05:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] firmware: arm_ffa: Fix spelling mistake "notifcation" -> "notification"
Date:   Wed,  4 Oct 2023 09:05:44 +0100
Message-Id: <20231004080544.271040-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 201a750b060d..68d1b308cf5d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1013,7 +1013,7 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 
 	rc = update_notifier_cb(notify_id, type, NULL, NULL, false);
 	if (rc) {
-		pr_err("Could not unregister notifcation callback\n");
+		pr_err("Could not unregister notification callback\n");
 		mutex_unlock(&drv_info->notify_lock);
 		return rc;
 	}
-- 
2.39.2

