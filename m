Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6B77F335
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349558AbjHQJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349565AbjHQJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:25:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7832D62
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso76140025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692264334; x=1692869134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3jIyUrd5GzfmWvpSZW4U6VKePA4YO/cn1PhySd1hkU=;
        b=diCldWqXec2nuRPwhbv8dnOOSVxtSlg1mqcdOIQtloIOxaXTZTDs7QzWXrxm3ahT/J
         EwbXFkKoREOC9iYAj7p1HumhRuByqiIx++aY0vqwOOLpMUnregLOdlUbm/wb+X9iZgkb
         Ae2czXdYfpHz2lsTUe7SK7LLElOTK/A+LmjzIOyeONYIaNelle11qLLgw2tR8yTkCZAV
         pMFKUnkMo7Q2VwpvlVTM0JR12bIZx1AbHKTNXNPrURP4XpZoxmowiKX1yym/72vksaDh
         V/Uu6dVMTXeWOUc9kUwK7EDoI828pzRb3M4ozw0f2+bI0VkDSe1Wl0ZSmUG9vbpONYz5
         tkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264334; x=1692869134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3jIyUrd5GzfmWvpSZW4U6VKePA4YO/cn1PhySd1hkU=;
        b=gyRDjKGNpvBaAQO4keqruoOAdOZ7KqXWDtyK6bLRKRIMo1B5rnJ48J7j3Ro+f0g6Ni
         X7VCCTPdvtRkiu7b5CXKGoVYxkDCvk9eNB30Qt6EaXZILXjKvF0sqdyKJL+XXZNx263b
         69RdcL4Y5t4sixM7olXk+eL2G8BwJ3KXbzyxsdYL8vxHp90p67DEf2LasKJC5KVgzkUp
         Cj/dyPC954/VkAcoYUJMf0A4U/cos/57+onMhOxexGtwOYdeZu+UGYQYqQhkxCEjkDor
         lh0WjKw/CFDgKl76G98mq84vvKPYxvq8mmaVrhC6NaXGI1ojjaJOHo/Wrd2VaBqGHuzu
         4kxA==
X-Gm-Message-State: AOJu0YwQ8v5qjKjOCyvdU7h0vN86u71AmVMAX/pDAtIHY21AmXZHLJi8
        objLIScmztV0X8fG4Ph2IpKSaA==
X-Google-Smtp-Source: AGHT+IFq50pyoIZbPhhzBj0EePyDPVFwUgBYXowAlhP/0dG8YPEoXUU9dCUuA2LlPbazK2I1HTwJoQ==
X-Received: by 2002:a1c:750a:0:b0:3fd:2d35:b96a with SMTP id o10-20020a1c750a000000b003fd2d35b96amr3489743wmc.39.1692264334303;
        Thu, 17 Aug 2023 02:25:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c2a4a00b003fc00892c13sm2227934wme.35.2023.08.17.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:25:33 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: pmbus: Fix -EIO seen on pli1209
Date:   Thu, 17 Aug 2023 11:25:26 +0200
Message-ID: <20230817092527.808631-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
References: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

After doing performance optimizations the pli1209 driver failed to
probe with a probabilty of 2%. It wasn't able to read the PMBUS_OPERATION
register due to an -EIO error.

An investigation showed that the PLI1209 takes 230 usec to execute the
CLEAR_FAULTS command. During that time it's busy and NACKs all requests
on the SMBUS interface. It also NACKs reads on PMBUS_STATUS_BYTE
making it impossible to poll the BUSY flag.

Add a custom write_data function to just wait for not BUSY unconditionally
after sending a CLEAR_FAULTS command.

TEST: Verified using an I2C bus analyser that no more NACKs are seen after
      sending a CLEAR_FAULTS command.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pli1209bc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
index 7d8bd3167b21..c95433790b11 100644
--- a/drivers/hwmon/pmbus/pli1209bc.c
+++ b/drivers/hwmon/pmbus/pli1209bc.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 9elements GmbH
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pmbus.h>
@@ -53,6 +54,30 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
 	}
 }
 
+static int pli1209bc_write_byte(struct i2c_client *client, int page, u8 reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_CLEAR_FAULTS:
+		ret = pmbus_write_byte(client, page, reg);
+		/*
+		 * PLI1209 takes 230 usec to execute the CLEAR_FAULTS command.
+		 * During that time it's busy and NACKs all requests on the
+		 * SMBUS interface. It also NACKs reads on PMBUS_STATUS_BYTE
+		 * making it impossible to poll the BUSY flag.
+		 *
+		 * Just wait for not BUSY unconditionally.
+		 */
+		usleep_range(250, 300);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
 static const struct regulator_desc pli1209bc_reg_desc = {
 	.name = "vout2",
@@ -102,6 +127,7 @@ static struct pmbus_driver_info pli1209bc_info = {
 	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
 	.read_word_data = pli1209bc_read_word_data,
+	.write_byte = pli1209bc_write_byte,
 #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
 	.num_regulators = 1,
 	.reg_desc = &pli1209bc_reg_desc,
-- 
2.41.0

