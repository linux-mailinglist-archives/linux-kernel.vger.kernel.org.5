Return-Path: <linux-kernel+bounces-146597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713E8A67BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB17B23427
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C2129E6A;
	Tue, 16 Apr 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq7CDa54"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BC127B46;
	Tue, 16 Apr 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261936; cv=none; b=k6BVcqyllToZfqxksYSptZcn6GByH6ATTD3ZMf8DoerE+rDBES/RF2dqfXGyorfrL8uHA6qiU79w1CYDleEnjIQAFuAeQLxL8oa3TSbf0mkjwEWFwKLs/yTRLmhj9+R4Dx4H2F7MrxXNuE/EmTsieEG9f7dbw9UwUWB08RfCp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261936; c=relaxed/simple;
	bh=drTLqBrzR1vZVe972hKGnriyq0RbeLlJz5LkSBB68ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt2Qj5E+LXU3T5AD4UaIsqTa0aZMmbHt2Z2YzXrcqs0IIhXkdffy3RMRmpXR/vr7jmWf75VbmMGbl/d8EsU5ogVWWnw7komrZdaf1L652ctba90t5mi/vZYMgw+uLMJFVJqjZnNk0ysj7uEYblYTlpHKUUBqZx8+3QJHiiDQvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq7CDa54; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2178b2cf2so38706705ad.0;
        Tue, 16 Apr 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261934; x=1713866734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2RRoL7b2pJYvqlX5LsosHr095wT1NGxXFDFBCAg27Q=;
        b=bq7CDa54dLmUkoFyI+QDPY/6Jopq9gco+JY2EPNP+P1V8BP4QbXq1oJwRQpY/yOuPY
         nR3yAAgQHirfHy2y3ftxr2gdyWi294L2KS9MG7rPairYqGeEF9NftKFbThLJGON4xKGi
         f/HUku+lPnEzb8ubvw7+lpu39hPAbWPlJTotLjDwONxxvrEjvAYUtB4t+SI4ZDMBZrdp
         KUcAn/fdIW+Zy9aC8PwJljeQ69gIhYzsSZQsj9WsLnr6E/m4k5FZ1R7sxpq0U+wfF6+9
         jI5ac625SJghb2Ar08gfHeKFXR/LsrrWk1Oxei8tEj5nuq7c1TMhOsn9KOqbenyIij53
         foYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261934; x=1713866734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2RRoL7b2pJYvqlX5LsosHr095wT1NGxXFDFBCAg27Q=;
        b=BorwFtLR9PXKEBiSa0FR4EO/6vcFWLVMMyylbz/dLx7MG4rSLDskHkL6i8Mluq26lI
         +0jokOF2mEPMho8VzIqmkBJBbL8lHqceOeO2nLMTu6g4GelViVMxdOb3qdKNrImhbjq3
         GvICovTNV+R9sUKeRt57EKhSqz6uDp2Wl3qW1MpTXlEJdja57jf30JusWJ8Y1Vm04WHA
         4df6NoV3lXy7PwWvAVw8sTUsunv3Xn76n+d/yEtwee9BzVT3LlkvPcfvWcmLObru/MAB
         pcX6ZiqPdAHRM3uN+h/rcRboEMDsUJ0H3O3YGIa/HRlzy4fxK7IsmKOaxjkRC1uV+iHB
         i+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZoSajNCJSio+jxtj5MwLkSFlh8kCnGluzPeD6kUfXA0ZJfdjxZvHekCnozsavdBjGH2eW19u9tpdSrzaG/tQMu3mZaW31+IZQ2qpd
X-Gm-Message-State: AOJu0YxDmUX7Qqisx7bTlG1Hhk/4L0LmGpBWjqLqALz4sOz7d6YSpS8g
	Fwj1rBafJU/7SmSSlWyxPAYzP8bQPIdYr2FcnjDPZCpyzjJeLnXjPwCwNgSZ
X-Google-Smtp-Source: AGHT+IG+MSXusuP/HzS2u5RRWvsqFZnjb4pSfzxl/7n369X3iQ15ujeWA4dzaGESNG4bH2O+mph9bQ==
X-Received: by 2002:a17:903:234b:b0:1e7:d3e3:9b92 with SMTP id c11-20020a170903234b00b001e7d3e39b92mr1436637plh.40.1713261934167;
        Tue, 16 Apr 2024 03:05:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:05:33 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date: Tue, 16 Apr 2024 18:03:45 +0800
Message-ID: <20240416100347.395295-12-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416100347.395295-1-mmyangfl@gmail.com>
References: <20240416100347.395295-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hip04.c | 39 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index feb34e98af8c..03c89ac6a2d5 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -10,8 +10,9 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -24,16 +25,28 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 	{ HIP04_CLK_168M, "clk168m",  NULL, 0, 168750000, },
 };
 
-static void __init hip04_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
+static const struct hisi_clocks hip04_clks = {
+	.fixed_rate_clks = hip04_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hip04_fixed_rate_clks),
+};
+
+static const struct of_device_id hip04_clk_match_table[] = {
+	{ .compatible = "hisilicon,hip04-clock",
+	  .data = &hip04_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hip04_clk_match_table);
+
+static struct platform_driver hip04_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver		= {
+		.name	= "hip04-clock",
+		.of_match_table = hip04_clk_match_table,
+	},
+};
 
-	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
-	if (!clk_data)
-		return;
+module_platform_driver(hip04_clk_driver);
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
-				     ARRAY_SIZE(hip04_fixed_rate_clks),
-				     clk_data);
-}
-CLK_OF_DECLARE(hip04_clk, "hisilicon,hip04-clock", hip04_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon HiP04 Clock Driver");
-- 
2.43.0


