Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F77997D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbjIIMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIIMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:02:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518DCCA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:02:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so8697b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694260961; x=1694865761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NNvJwlKaaEpene3hYwihaclJlQcxiYMKhd0xVHXQVBw=;
        b=UpDMsSrvC/Z7+8pZJydvT+MTrWl5kAdDW3+irkItuLJ769Z9LzTzVKWRprqiW/rOA0
         LhyKzCyyIiKv6EnHG7iiS2vtpP3kSMpDFWstDfvvOA4yX9c2IjOkhjHk1YDefReuUCqe
         H4lUg2Yy6wKcSYMLXP8m4TGEfZ4p9FshAXI8RxuzuVCqfd6n2yg/MOxq37Fab3ssDDRl
         towicCKgiUD2RSmB2qzgXLIEgJy+VOGR4MA5k6uzwX1mPwwWHDUi2khAYF993OXyIeGm
         4j88DpDWu0XrRfqrVFaThUgPUhkcMnnHgdV0xr9hfcoU5cI90bKKPm55ehnFAo+ekvP0
         DC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694260961; x=1694865761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNvJwlKaaEpene3hYwihaclJlQcxiYMKhd0xVHXQVBw=;
        b=hGw6BxJ7h6H7xchFgQb5LJocdW3DzkAvMiqPiu0R2wE4aJs3b9j9SAj9ZRxO3mWPRf
         H/zqkT3I2owiLG6Qb82wy+U4NcMvGkn1SsWKiBy4naNn0aKX6qjahrth5YnyCmx+nEfr
         XJ9frqtoi944/gaUkvtIGUeIDYgNW9+TtukheyyocbH/i1YgFdvg1mBjxQmCeWmqLYxz
         CAinttKuABP1HmZaomAxtzaZ13huSDBxCA3rc0PH4zZKUrHBgYG6EUN5HdvDiUWHe12p
         38iFV1OP+o4LYaX00U0ASHtkQhKilPhO7svFxcsjbwEvHBw2lX/3z71yrWM4BRClzZDi
         YVxA==
X-Gm-Message-State: AOJu0Yw/z2gcfXH+/l5ZghrJfRyFqfXh5aQ1NtdkD2uVVZl9YbQQ5T3C
        oFdThGlKaL8fVz8P93ulXvM=
X-Google-Smtp-Source: AGHT+IGV7wsSQZ8gM7uM2NiGxc6j/PbI14YYzMboVpAXGs4115SPsQ1Lllx9LIRYLsg46MDkbWVtnA==
X-Received: by 2002:a05:6a00:851:b0:68e:2da7:6b0d with SMTP id q17-20020a056a00085100b0068e2da76b0dmr4870688pfk.1.1694260961156;
        Sat, 09 Sep 2023 05:02:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a63b801000000b0056368adf5e2sm2576176pge.87.2023.09.09.05.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:02:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <festevam@denx.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm8960: Fix error handling in probe
Date:   Sat,  9 Sep 2023 05:02:37 -0700
Message-Id: <20230909120237.2646275-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 422f10adc3eb ("ASoC: wm8960: Add support for the power supplies")
added regulator support to the wm8960 driver, but neglected to update
error handling in the probe function. This results in warning backtraces
if the probe function fails.

WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2396 _regulator_put.part.0+0x1b4/0x1d8
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-11075-g92901222f83d #1
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x68/0x90
 dump_stack_lvl from __warn+0x70/0x1a4
 __warn from warn_slowpath_fmt+0xac/0x220
 warn_slowpath_fmt from _regulator_put.part.0+0x1b4/0x1d8
 _regulator_put.part.0 from regulator_bulk_free+0x44/0x64
 regulator_bulk_free from release_nodes+0x50/0x7c
 release_nodes from devres_release_group+0xbc/0x138
 devres_release_group from i2c_device_probe+0x180/0x268
 i2c_device_probe from really_probe+0xc4/0x2e0
 really_probe from __driver_probe_device+0x84/0x1a0
 __driver_probe_device from driver_probe_device+0x2c/0xc4
 driver_probe_device from __driver_attach+0x94/0x144
 __driver_attach from bus_for_each_dev+0x70/0xc4
 bus_for_each_dev from bus_add_driver+0xc4/0x1cc
 bus_add_driver from driver_register+0x7c/0x114
 driver_register from i2c_register_driver+0x3c/0xac
 i2c_register_driver from do_one_initcall+0x68/0x3b0
 do_one_initcall from kernel_init_freeable+0x18c/0x240
 kernel_init_freeable from kernel_init+0x14/0x144
 kernel_init from ret_from_fork+0x14/0x24

Add the missing calls to regulator_bulk_disable().

Cc: Fabio Estevam <festevam@denx.de>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Fixes: 422f10adc3eb ("ASoC: wm8960: Add support for the power supplies")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/codecs/wm8960.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0a50180750e8..7689fe3cc86d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1468,8 +1468,10 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 	}
 
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
-	if (IS_ERR(wm8960->regmap))
-		return PTR_ERR(wm8960->regmap);
+	if (IS_ERR(wm8960->regmap)) {
+		ret = PTR_ERR(wm8960->regmap);
+		goto bulk_disable;
+	}
 
 	if (pdata)
 		memcpy(&wm8960->pdata, pdata, sizeof(struct wm8960_data));
@@ -1479,13 +1481,14 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 	ret = i2c_master_recv(i2c, &val, sizeof(val));
 	if (ret >= 0) {
 		dev_err(&i2c->dev, "Not wm8960, wm8960 reg can not read by i2c\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto bulk_disable;
 	}
 
 	ret = wm8960_reset(wm8960->regmap);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to issue reset\n");
-		return ret;
+		goto bulk_disable;
 	}
 
 	if (wm8960->pdata.shared_lrclk) {
@@ -1494,7 +1497,7 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 		if (ret != 0) {
 			dev_err(&i2c->dev, "Failed to enable LRCM: %d\n",
 				ret);
-			return ret;
+			goto bulk_disable;
 		}
 	}
 
@@ -1528,7 +1531,13 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8960, &wm8960_dai, 1);
+	if (ret)
+		goto bulk_disable;
 
+	return 0;
+
+bulk_disable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8960->supplies), wm8960->supplies);
 	return ret;
 }
 
-- 
2.39.2

