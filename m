Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A276AA39
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjHAHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjHAHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:45:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C71211B;
        Tue,  1 Aug 2023 00:44:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso769813766b.1;
        Tue, 01 Aug 2023 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690875881; x=1691480681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duwQiPtNtN/ka+/qSDejTLlGxxydtKaBegoBst6LgQA=;
        b=bflEIgZJpGNTS6Jz8vjxQYTUlCm7p6fq9wi37gFvz6Gi1A1hnh7+v8PhmWz/e2NBHt
         J5vBY1o1UnhJ9Em3FKmkl6F/GOUY+oKXK2ghU7UXx9IeuxZHwAbmhkgcbTajXOEAWioa
         hPhxzLQnLBxTYZgO0jLt9sEd/xETN4tMB3uicL4jqtwOSmPEwbPVUwkEMEqcCsRw0CcW
         O8Iu1uOydcP8C2lk7QC045zuzj7rk5F2AZCsbOoDZDNhnLik1OBdgrOqbQxbqd9x7a9I
         nPLsvQ8EIffw4XaVl8z1SHccErANxiY2i0ZORp2GnU/RQ/VLV2/ykNyo2YP8gYDoWcmE
         XDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875881; x=1691480681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duwQiPtNtN/ka+/qSDejTLlGxxydtKaBegoBst6LgQA=;
        b=Vipze0gqCNmHLtD5DAdxv4/Ibi5fue8rgke/nbh8FBsrlUSiYfnquj1y5AYmlT9t1m
         50LXHB6R1vheyBy722ZkoI2IKuf7wupvhqPoCrKcLT+iheWRQcxoNi6iwOtbPXU4Ap8r
         yu1m7J3jTlsXhMteM74oNUCsqhNFOZmJE2jgc8BLa1zk6LOpfjH5JdS3o93OfUrbB7IT
         GYplLYUuSMyOUfi3CmbnnGRZJNVY60dWBaEB50c79a/g8GIZLnO/0krqxlemQ3b/yu/r
         p82woJjw08mM4eLaggo2OedLJjw99ofcg0LBa6VM9ub6Bvwaupk0MBncTeZs9e7x9k9d
         fj9Q==
X-Gm-Message-State: ABy/qLZmejbklFjXM203Nr2u80Mx5f7KI6vKbcbEej3N0IR1QpSqHkvk
        OGKyw6WsFSLCxboJfEy0w9/t5gEGTPUrQw==
X-Google-Smtp-Source: APBJJlFqt6jAfAmLQZ3qXcE0/0wX91lgUIY+ZCroPI0JqeFIQL3K+Xkro0RoAHQ81Axcfx+wmIIYZA==
X-Received: by 2002:a17:907:77ce:b0:977:befe:d888 with SMTP id kz14-20020a17090777ce00b00977befed888mr1615099ejc.13.1690875880995;
        Tue, 01 Aug 2023 00:44:40 -0700 (PDT)
Received: from localhost.localdomain ([78.97.234.98])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090607cf00b00993159ce075sm7168595ejc.210.2023.08.01.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:44:40 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-gpio@vger.kernel.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, andy@kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: sifive: remove unneeded call to platform_set_drvdata()
Date:   Tue,  1 Aug 2023 10:44:30 +0300
Message-Id: <20230801074430.5179-1-aboutphysycs@gmail.com>
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
 drivers/gpio/gpio-sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index c6a8d2374e31..0010f607a9ef 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -259,7 +259,6 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	girq->child_to_parent_hwirq = sifive_gpio_child_to_parent_hwirq;
 	girq->handler = handle_bad_irq;
 	girq->default_type = IRQ_TYPE_NONE;
-	platform_set_drvdata(pdev, priv);
 
 	return gpiochip_add_data(&chip->gc, chip);
 }
-- 
2.34.1

