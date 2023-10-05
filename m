Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30197B9FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjJEO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjJEO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:27:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557893D4;
        Thu,  5 Oct 2023 01:52:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-694ed847889so592865b3a.2;
        Thu, 05 Oct 2023 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495938; x=1697100738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl5VP0Ue06tT2oZw2pmITNbqF1XXDB7xjU0jlwfhUG8=;
        b=Z7Y0jjl/BPXvAY2fmEa9YeYoa9tnw+P9lTgf733kjNIyWRwXZiuDz4D1L5gvyyW0at
         phZC9AZGudyrxYtSVbZwzYnI/r3xcOZWwb1oT8x3TpweotFDowuR9viWB5RfmICvJtum
         aLS9OPmtGlHsmmUl07fmLMFXjQ1/N5itzRGReCNsJd9QdaOyrKa5qoYA+YVa5eS3OgUf
         dBxm6BzvJEX/jsiTHzr6BfRaIXyo0zkStZo/Fsfy8IQtOX9mChikfEPTuZ3gl1PrXn7+
         y/rMYLyuEvIBpkMm6wgSPOphKYUEEKtwAMoV5NalMlvhoxqWE45xCnq1BPnpkSCHX2uv
         f/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495938; x=1697100738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl5VP0Ue06tT2oZw2pmITNbqF1XXDB7xjU0jlwfhUG8=;
        b=DkAfFEeFTAdxJvCoVI2WxBHJnap7Q+mVGjC32mjvmhPlfGGnBklXQASGfHwh8/qJzq
         k/wTslGs1BoKB1Ad1jYMDtblHoHOYLVqM3uk2ntEk+vDl9F1Tx1S/gcz07+s6jM8fvNp
         2wUBHofE+hwQ6HQOQF0v5Vx9HgsNfUw1+jCynu68VqfHquqMY9TFk2Wflye6SbM4OutB
         YTvIwfggl9XWKYCxDsYCabQnqp3dsvge9Mqm/rJCZ+6zISr3zPPXkckTNNgWraLIyehN
         opXS6D9tBjyIw4ZYRWZJFoGPd0/YkgS6K10y7Yv9T+MAyAKm78jgKXQERCO3IbSZONNU
         V+7A==
X-Gm-Message-State: AOJu0Yy2GlAzRMvaJ9vt+zmeBHFghpUGBpsvI0IBzZh7XxfioAxLkUIh
        BUOCyPAhN4EKD2IiKp7+Ox/btdeY3bH+Xw==
X-Google-Smtp-Source: AGHT+IFWb3e8Qkv9Al2zbLz4MisKt24rRWCU4okXfthP2HIKN0R3OMVQAY1CGJPlRYGVGR1qNxRjzg==
X-Received: by 2002:a05:6a00:a08:b0:691:2d4:23a2 with SMTP id p8-20020a056a000a0800b0069102d423a2mr5430428pfh.31.1696495937915;
        Thu, 05 Oct 2023 01:52:17 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id p20-20020aa78614000000b006933f657db3sm872773pfn.21.2023.10.05.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:17 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 3/5] watchdog: eiois200_wdt: Implement basic watchdog functionalities
Date:   Thu,  5 Oct 2023 16:51:21 +0800
Message-Id: <61d7009003a08d47a3e5efc2906eb2e76d02cdb3.1696495372.git.advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696495372.git.advantech.susiteam@gmail.com>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

In this patch, the driver has been extended to include basic watchdog
functionality, allowing users to configure the watchdog timeout duration,
start and stop the watchdog timer, and ping it to prevent system resets.
The driver also reports the remaining time until a watchdog reset is
triggered.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/watchdog/eiois200_wdt.c | 64 ++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/eiois200_wdt.c b/drivers/watchdog/eiois200_wdt.c
index ce4435ac62f2..569e619448e5 100644
--- a/drivers/watchdog/eiois200_wdt.c
+++ b/drivers/watchdog/eiois200_wdt.c
@@ -106,6 +106,29 @@ static int get_time(u8 ctrl, u32 *val)
 	return ret;
 }
 
+static int set_time(u8 ctl, u32 time)
+{
+	/* sec to sec */
+	time *= 1000;
+
+	return PMC_WRITE(ctl, &time);
+}
+
+static int wdt_set_config(void)
+{
+	int ret;
+	u32 reset_time = 0;
+
+	reset_time = wddev.timeout;
+
+	ret = set_time(REG_RESET_EVENT_TIME, reset_time);
+	if (ret)
+		return ret;
+
+	dev_info(wdt.dev, "Config wdt reset time %d\n", reset_time);
+
+	return ret;
+}
 
 static int wdt_get_config(void)
 {
@@ -123,24 +146,57 @@ static int wdt_get_config(void)
 	return 0;
 }
 
+static int set_ctrl(u8 data)
+{
+	return PMC_WRITE(REG_CONTROL, &data);
+}
+
 static int wdt_start(struct watchdog_device *dev)
 {
-	return 0;
+	int ret;
+
+	ret = wdt_set_config();
+	if (ret)
+		return ret;
+
+	ret = set_ctrl(CTRL_START);
+	if (ret == 0) {
+		wdt.last_time = jiffies;
+		dev_dbg(wdt.dev, "Watchdog started\n");
+	}
+
+	return ret;
 }
 
 static int wdt_stop(struct watchdog_device *dev)
 {
-	return 0;
+	dev_dbg(wdt.dev, "Watchdog stopped\n");
+	wdt.last_time = 0;
+
+	return set_ctrl(CTRL_STOP);
 }
 
 static int wdt_ping(struct watchdog_device *dev)
 {
-	return 0;
+	int ret;
+
+	dev_dbg(wdt.dev, "Watchdog pings\n");
+
+	ret = set_ctrl(CTRL_TRIGGER);
+	if (ret == 0)
+		wdt.last_time = jiffies;
+
+	return ret;
 }
 
 static unsigned int wdt_get_timeleft(struct watchdog_device *dev)
 {
-	return 0;
+	unsigned int timeleft = 0;
+
+	if (wdt.last_time != 0)
+		timeleft = wddev.timeout - ((jiffies - wdt.last_time) / HZ);
+
+	return timeleft;
 }
 
 static int wdt_support(void)
-- 
2.34.1

