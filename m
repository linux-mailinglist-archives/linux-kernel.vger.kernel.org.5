Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74E785370
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjHWJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjHWI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:58:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AF9199A;
        Wed, 23 Aug 2023 01:54:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so50166345e9.2;
        Wed, 23 Aug 2023 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780885; x=1693385685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=Z2yj4F8BQq9pyniw85upgEcGXlayZJKLK+004DFTVY2Vz9d0/0limFZk1jnqgu4JCN
         Ga0oWg3ZVgAbJX7csPr/f3pfjZ8rfDoS9NwVaB7lSCcRDi4iFmyXUxxJXdvGkSERL/MN
         kIz4BGrosZvFJcGpzZIaX0KpMEi6NPhq5/n7R6C/dY9knzV/24wWHe9EymDIuYkVe88J
         DkSYRpFA9gAYutf9t9UryrFmx3h4PlsvhBpS6eOxfrpbzZ5GCEEFJgIUBlyOD90jJaSh
         Fx4+I4GIF1mbs1ZkQNaw6UFTa2+KIXzWiwFZLpZFJTxakgEfUAUwiPHZZYdxDgPvWVfJ
         r9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780885; x=1693385685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=CF/I8Bg2eNh0YadJslUtelnC9H3lh8VYoASY7qTMrRzAb8NXvgv2GdhfxmhGmC+pmy
         KT62ZfXb6UDn6hWDfL3w6McedngFimhBKrBloJV9rWVnTU5IjQyPHlyJRWz5DE8ldGhG
         +fr3l/fF3CjfwrsRYItezaTOISKD9oXqByIDL4HOhkVO/URFesKTW316u6Rg/kASUUHt
         Tic156xlpxx9vPCteKZkflho0U8sNxxHSxQ2eM5p7Bq3ryvtkBNrJWma0sVA5Xz1wxbj
         fpK9/l4ffQmABvo690yzI59rV3vdjEJw6p5hzorMRAL95x/+wziCVnALt7vg5z6LSh3S
         FSig==
X-Gm-Message-State: AOJu0YyO+OOfCUSKUr7VZFXczpDJaYs0fTOCNRTZcGaoXq+NRkIvdT7E
        nGjYCtVqnzOEHpG3AhE158uqj2G++ogNWw==
X-Google-Smtp-Source: AGHT+IFckMV0KrXEfSTJ1ulVw/BczcqOeoFhAmPSo5PmBS3fcUbgwtBwB1XAAK/hCvbIilAlZVkZkQ==
X-Received: by 2002:a7b:c459:0:b0:3fe:16d3:7d60 with SMTP id l25-20020a7bc459000000b003fe16d37d60mr9280946wmi.9.1692780884696;
        Wed, 23 Aug 2023 01:54:44 -0700 (PDT)
Received: from gba-Precision-5530.kat.ac.za ([196.24.39.242])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fed78b03b4sm16265420wmc.20.2023.08.23.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:54:44 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] power: supply: Fix tps65217-charger vs vbus irq conflict
Date:   Wed, 23 Aug 2023 10:54:29 +0200
Message-Id: <20230823085430.6610-2-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823085430.6610-1-nemith592@gmail.com>
References: <20230823085430.6610-1-nemith592@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index a4bc9f2a10bc..6f68becdbfd0 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
-						IRQF_ONESHOT, "tps65217-charger",
+						IRQF_SHARED, "tps65217-charger",
 						charger);
 		if (ret) {
 			dev_err(charger->dev,
-- 
2.34.1

