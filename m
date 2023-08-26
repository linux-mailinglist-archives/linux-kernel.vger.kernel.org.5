Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF178992F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHZVIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjHZVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:07:45 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE1E1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcae8c4072so1396470a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693084062; x=1693688862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZyTeNGFnmQqE613GDKmKhvLAFe/AnQBwlsX/erp5GQ=;
        b=F5JiEwbYoIU+ln+iqlWcPcVtM4ikg727AXK4/DMPwmas6P6QWtWxADpAy1ZPjfJI7Q
         et2euTDprhrkB4XtgwjttJe74m7aHk92hkHaT4lEoPxNc/ei0ZUsmbbMAmKksVvVvT8p
         bBfnYErPWjgnnN62KqESbzleqno7oRF3sz0g467YjnH1VQkHbv5bOeOV3PwKoP7fFTb9
         /38CiYq0iPIJZxjOk/SUXOneVp5yekJacuHFL9Gi/9/pSXO2WtfnYQHNJme5//uzvQZJ
         Lbzyos/qfQuE3Hctjac02Q40mXUaNi7G42oMPtHg5fefSAUKFcO+EcJIUgfjdqlQigj1
         BPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084062; x=1693688862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZyTeNGFnmQqE613GDKmKhvLAFe/AnQBwlsX/erp5GQ=;
        b=jr9OpDx/viFbEJVbyE6LwrAGE48xH9i/TXIFdAGuGDjkR7aX7RzhoRd3YXECOGkHJC
         30YYB622elvX9I23TEXq6Pnxo2CXOTHvp8YH8QZ8tRvS4Cq+777BxcsPwKWFi7rTEZST
         FwNQEZL5NuQABKJWg63um8MnO/jKcJUZB0v8Fvvbn5Gf5Prb6ElBeJrWdF5OTC7QtQIb
         mPmd+7HQYnHj1LVFDxSyYdN0+XDgKhJ8sdEMBBaEs6KzI12Xm+uQJ/gNZiAdLcrOppm4
         8XXLRFTkauKWaBSgukiTZQdaDhS+ZakB+B5LIH+oKCZt5ZOdmPV1XAFdVdzVJR7abvlu
         SF9g==
X-Gm-Message-State: AOJu0YzOMqBc/4dolTfHVRj2rtoK3KTKbizZumiIhk2qQmlH685BCVFk
        MkdzORX+KzV2R7nWk6znf4sgMhVaNDU=
X-Google-Smtp-Source: AGHT+IGr00EAhq6uWk1se+am4DAXkfUvAJpPrf0iDTs9CP82H184D9ynRddJTamvciCtHrFTWH8IHw==
X-Received: by 2002:a05:6871:586:b0:1be:e925:3dce with SMTP id u6-20020a056871058600b001bee9253dcemr7357215oan.7.1693084062707;
        Sat, 26 Aug 2023 14:07:42 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id w3-20020a0c8e43000000b0064f50e2c551sm1488377qvb.1.2023.08.26.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:07:42 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH 4/4] staging: vme_user: fix check unnecessary space after a cast in vme_fake.c
Date:   Sat, 26 Aug 2023 18:05:18 -0300
Message-ID: <603976b29ad4d9a0e4cbd8452ff674ec70a227a8.1693082101.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693082101.git.alexondunkan@gmail.com>
References: <cover.1693082101.git.alexondunkan@gmail.com>
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

Fixed all CHECK: No space is necessary after a cast
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 4258ed6033e7..4ccb16dd0d0b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -95,7 +95,7 @@ static void fake_VIRQ_tasklet(unsigned long data)
 	struct vme_bridge *fake_bridge;
 	struct fake_driver *bridge;
 
-	fake_bridge = (struct vme_bridge *) data;
+	fake_bridge = (struct vme_bridge *)data;
 	bridge = fake_bridge->driver_priv;
 
 	vme_irq_handler(fake_bridge, bridge->int_level, bridge->int_statid);
@@ -1092,7 +1092,7 @@ static int __init fake_init(void)
 	mutex_init(&fake_device->vme_int);
 	mutex_init(&fake_bridge->irq_mtx);
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
-		     (unsigned long) fake_bridge);
+		     (unsigned long)fake_bridge);
 
 	strcpy(fake_bridge->name, driver_name);
 
-- 
2.41.0

