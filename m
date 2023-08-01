Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A976A9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHAH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjHAH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:28:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC7170A;
        Tue,  1 Aug 2023 00:28:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522b77956d2so3769944a12.3;
        Tue, 01 Aug 2023 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690874931; x=1691479731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WfKxn5oEge6vhPnDEY2egIOARkuMSrcIgRzGtV9I48=;
        b=QFGYr4jQrL3lzilRxrCW3QGb9PU/BPM9f4tLeaJ6JU/p3i2QRvbGtYo/VBLHKt80Jm
         0Eo+M23eUHoQrb0rTyUk/t1yKDk5jpL9Ku4pUYLJPveXJg0FmVckd8CyruqA4MPn4MgC
         RKIb0tcL1cMauIND+ZquG4QOT2AY4t34WHqBvZ5Me+0sHFbb78r8//R13bgy8uj/Z7yL
         N8H5Bs9rF85Li/bxNms2ntt/v1TD36+jcuoGfDiR198Jm2tZdaMRbl4xL0Wt1c1qVVah
         pIC+eYZrJDUtgBQQNQuAfg0WXuPh47sJCmvEQrS18s4pfrrM8ubc90t8bKvvwxPBgWFK
         nZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690874931; x=1691479731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WfKxn5oEge6vhPnDEY2egIOARkuMSrcIgRzGtV9I48=;
        b=fX7lR+6/fPi9Srp+EekTnbfbOqUKW1xeHmMPpk1MKgbcxpaa/A+YJOZcf7exiiCcX3
         /LbimFVle9mBNPdVyoaKTyD5gTfbwmDtpaSIUx7lvv69xXvu1eon/wS5inU3zUFEXKuI
         AUVy+QnNZZP7Zfgy3v+WBk8YP7YwdvRjDc6CyM8YOhXwDBpLpBtISPuKnF+tefWQlATi
         WsONU69edObXNieBHoK4ZflJCbL0lRBbhJhHXrc9dmtbsiRrRUxDLJzkSGaor2MrK9dQ
         tqHImTfa06tikqEn6PzdKd/iuCewtZ7RrjwiEgmgGnHUT2l7M6soK5YUCBVQeIcFzKLB
         UKrw==
X-Gm-Message-State: ABy/qLYgiBttpXxBeyr/nGpaMzuS5Lm53dgM1yKZAuk3xvU0BKdBl8hA
        A5bTJUIEK5vNMc/teVFP690LmPCXUYt4ew==
X-Google-Smtp-Source: APBJJlH8rRo5q+iOBKzEfMa9JknO9z8suKe7TdjZwOWEtp6jfs3yPbtOnYzVooZTdZ20cPk0g3Abfg==
X-Received: by 2002:a05:6402:2054:b0:522:af5c:ad20 with SMTP id bc20-20020a056402205400b00522af5cad20mr1945093edb.1.1690874930803;
        Tue, 01 Aug 2023 00:28:50 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7d49a000000b0051dfa2e30b2sm6459244edr.9.2023.08.01.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:28:50 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: sch: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 10:28:00 +0300
Message-Id: <20230801072800.4130-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-sch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 8a83f7bf4382..e48392074e4b 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -380,8 +380,6 @@ static int sch_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, sch);
-
 	girq = &sch->chip.irq;
 	gpio_irq_chip_set_chip(girq, &sch_irqchip);
 	girq->num_parents = 0;
-- 
2.34.1

