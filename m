Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC45753C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjGNNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjGNNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B735AE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so3253835e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342692; x=1691934692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNQjkE8rt0loSfu/6IF9XOAi/Sv+jFDCxC5ymTmcAL4=;
        b=CAoScYrac6wbsvgf3sCMIHSfG/XzOgLvZwMP16U/7iGRxj0aeq6Qmevw4df6X9scar
         SzZtfeh+IvZxJHqY+y8996NhE8uM/yj4/2X1rLO/2mc7fUJwLd/MJHEYcklGEEtg9dVE
         HfVkUBg1Hu0OBW0vJ+5vJZzpXhPnMobGOs9u5EdqsCTFSK90I0Cbl0wd8C6gdOf5+K7N
         0C5hoKxZir6Xxx3OVQ5clhrtdGIyJcXS8v0fDYj79V7kM4Xoqx9HVXvQKXcaTH07j5wI
         78S4zgXWu4YOvicqE/rw6CJ2GSLWHKXQiq7gyJxy4EC4h0UYo8C40ct9Ap8DgdBPLmxV
         Fy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342692; x=1691934692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNQjkE8rt0loSfu/6IF9XOAi/Sv+jFDCxC5ymTmcAL4=;
        b=IKlcX/MXuJIMCsdAIKaPP5RD+0WTT5of5QyBo/l2d8MTJIkwpdsnQMVKWfMqv5d3HW
         O8biY+8x9WPP/w9aSh4P7eVHB6j5FqAkI6yTHEaTub5z7ZJTj/9+vwbD6AXgogwxsQ3J
         ho9c8YCy2MlpokQw2ZWMLrZhlPJHhztkv902N+dLnBS/uhjO/qslZVnHTWU5JXU43ixL
         Z6ron4rjogsfBll0pSORhF0J9C/zOqNjXPuacerzklKyDcwsFuFblU0vCc20DNYPXcdz
         ApOHcM+B25uyZoMdDwEUhQhgQLzTIO4p1QBUgykpNZjrz5s/UPVfPHlR5Gph5RS+m8N7
         8xDg==
X-Gm-Message-State: ABy/qLZNHP+nTBvzZ1UIEsu9PiEqvFkbXBgGifuD3hgTT4T530HETNyI
        9IwxgojMJWANsAEBaLVCYVB5Qw==
X-Google-Smtp-Source: APBJJlEtcarDtuEPzDUyEAOM2S+8mXuE4bWTS+fzJGLSHttt9cEGE2oEfk1B/l9ervCqaopUQXL+JQ==
X-Received: by 2002:a05:6512:2202:b0:4f6:2a02:fc1a with SMTP id h2-20020a056512220200b004f62a02fc1amr4347481lfu.17.1689342692293;
        Fri, 14 Jul 2023 06:51:32 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:31 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 3/8] hwmon: (pmbus/mp2975) Prepare for MP2973 and MP2971
Date:   Fri, 14 Jul 2023 15:51:11 +0200
Message-ID: <20230714135124.2645339-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for differntiating between the chips.
The following commits will make use of this mechanism.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 130cfde52e42..04778f2dcbdb 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include "pmbus.h"
 
 /* Vendor specific registers. */
@@ -56,8 +57,13 @@
 				 PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | \
 				 PMBUS_HAVE_POUT | PMBUS_PHASE_VIRTUAL)
 
+enum chips {
+	mp2975
+};
+
 struct mp2975_data {
 	struct pmbus_driver_info info;
+	enum chips chip_id;
 	int vout_scale;
 	int vid_step[MP2975_PAGE_NUM];
 	int vref[MP2975_PAGE_NUM];
@@ -68,6 +74,13 @@ struct mp2975_data {
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
+static const struct i2c_device_id mp2975_id[] = {
+	{"mp2975", mp2975},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, mp2975_id);
+
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
 static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
@@ -691,6 +704,11 @@ static int mp2975_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	if (client->dev.of_node)
+		data->chip_id = (enum chips)of_device_get_match_data(&client->dev);
+	else
+		data->chip_id = i2c_match_id(mp2975_id, client)->driver_data;
+
 	memcpy(&data->info, &mp2975_info, sizeof(*info));
 	info = &data->info;
 
@@ -739,15 +757,8 @@ static int mp2975_probe(struct i2c_client *client)
 	return pmbus_do_probe(client, info);
 }
 
-static const struct i2c_device_id mp2975_id[] = {
-	{"mp2975", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, mp2975_id);
-
 static const struct of_device_id __maybe_unused mp2975_of_match[] = {
-	{.compatible = "mps,mp2975"},
+	{.compatible = "mps,mp2975", .data = (void *)mp2975},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mp2975_of_match);
-- 
2.41.0

