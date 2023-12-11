Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471E80D488
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjLKRvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbjLKRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012493;
        Mon, 11 Dec 2023 09:50:55 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50d176eb382so4042209e87.2;
        Mon, 11 Dec 2023 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317053; x=1702921853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsJX+Qboa5vi8f2nlAdje7XxRx8QzHIYwHcUKKyZ1AE=;
        b=FHW5Q7Ge8RTNlxvNzMIVT9FHiIz+3+KLPU9iaku/akVCwWCXOovSH99NRX2uE2EptN
         BtV42L1xZZZNYjbwNKr4mlc6uVGxj/1837PsA+1DVdl9z0G5DHKCQBjuZJIZILWuGdYk
         gZPfvQ27RXfGCutmBTg4iAHnIqzPH4fHyeoNvH7Q1c+a7LCkMR2vRFjkp7YvSkvvxih5
         2x9KFPVYgUNxkiDNXYPcCSe+tMzRgwyc9cd/9ke6c+2N+hwIfwwwMDYufyUIXzt4KK+O
         bqiZjNlnJIv09rFOweasHRmHfbRb7NaS+EmtmAnboeJAV/AfVu5bSCpV3JG0MXngK+Nx
         4RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317053; x=1702921853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsJX+Qboa5vi8f2nlAdje7XxRx8QzHIYwHcUKKyZ1AE=;
        b=QmzCt5MErbktnaW6E0CaBQeNntLk2jp0BIm67DampV8xZOE97kOB7Y2XYjNjfn/h+S
         axxVsDlq+X9jIqRMCWqMVojyEe4vkgBSD0PE/W5k2AwfzXOlRfPhfMvGHA/AfiVFZMVn
         pOUaO7AhAf1b8LBh4AbyQK++zEkVAcIsXQU7luitRceDoHQyPF0qB8Wzo/fru9lZEeFE
         T0LR72h+gQygNRXkveAmIW+SikBEBdNBRSsQPZobCtKeIzh68y/TZxq9ftuKRk6sHFgl
         q1mZ4RaK/WhSg6hIFg8l7kNshiWZZ5te7HyeTEw4BCgMWzBk57KuqQSpty/cPjG6lsiJ
         Y7nw==
X-Gm-Message-State: AOJu0Yy2enAMxwajp7tpZs4oK5GffwRj/ofNxhwhd9gSzIR1uQIv2bdA
        Fd8lPxkRtN637UgXE571mnWYfXrHvtLM0/qT
X-Google-Smtp-Source: AGHT+IHWmoO4gOl4K1CGXOUSRKjBpgui2q6MybzatvHWDbLEyc5cgeIEIekJLGsvIuPTPGHTR4U/XQ==
X-Received: by 2002:a05:6512:1308:b0:50d:1a14:2f78 with SMTP id x8-20020a056512130800b0050d1a142f78mr3033484lfu.86.1702317052809;
        Mon, 11 Dec 2023 09:50:52 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24572000000b0050bfdfe0133sm1127334lfm.134.2023.12.11.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:52 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 08/19] media: i2c: ov4689: Enable runtime PM before registering sub-device
Date:   Mon, 11 Dec 2023 20:50:11 +0300
Message-ID: <20231211175023.1680247-9-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
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

As the sensor may be accessible right after its async sub-device is
registered, enable runtime PM before doing so.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 2eef64cd0070..ba33b0ced532 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -874,16 +874,16 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_entity;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
 		goto err_clean_subdev;
 	}
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
-
 	return 0;
 
 err_clean_subdev:
-- 
2.43.0

