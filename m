Return-Path: <linux-kernel+bounces-80007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216A86298F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338591C2095F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3914A81;
	Sun, 25 Feb 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqd4u3eA"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47596156C2;
	Sun, 25 Feb 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844042; cv=none; b=iPtnU2UI+j9Hp/zyPT8snLmJ6GMhi4N4WPmwy3s6la3jOsummOhef3aXwRmO/AZHLs/3QN5Ltyowb4WMdcx42YcRydKHe3vwcuVPWWo1Qae3VHexTMnIrOyjYW2IS1CH2g/KTga1VM790SxxCimunNRR1jD/51RDilW49fJ+osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844042; c=relaxed/simple;
	bh=4hBDfyqNJGhczrAbriDJjBqzMZKnQpCmCElVDsfAepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwXYbynpqShCY+AWL9sMPYXh9/dyEUA8BK1AMsSsCRc8BzXJhWiIOFn8eUguZQiPDccpJYYtDrWGrdOL2VOrMwS3GwnTc0X8ILh74K67iiUzrSn3S25G69bvDlUiEesHWmI4EgnnXxurWBx9Gfh6xlXi7TUZklcoEYsxTxDQOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqd4u3eA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c18dcbc635so1632228b6e.1;
        Sat, 24 Feb 2024 22:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844040; x=1709448840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=Kqd4u3eAtvE3hYq+E87GZu6uO4ZNDxMk0swFC1BIBOKKv6JLpCqpXn8jNDyEswvegq
         +WDCWM2n0YpssTXF8XtjKvkLrIufMAQoNwIsd5mbAHWFjRvlNWkZD2OeChzGejluqQIo
         lYVInui2834Xrpth3pV8vUvN8CF1aSqr79pLEACqi887efYyUVHMgk70yH29onhNvdYx
         v9+SJyNpj02Hs1Ac9PCqZaeF9FWSHWUeaHqAYY15hh+fTbbC+fOFHfLMJbDV448CHrDD
         IChuUpu1swoffZtR3pEq0JvXOVvEbWwsf1NtHGnWBnFzbblU5io5YTLnhsx5/LHeFdTK
         y7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844040; x=1709448840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=ePvwgLLc3YP0pKmh6bLjncaUYVEJU6M3mp7psqf2rIHW2vv69mcd5gXSvDmFDQS+FU
         bszGQXQyy6E5UKqaZJUCZlq47CXYuMmK6+HNlvJ7VnvcTyK/9O3q0rzO8jDlj+Y0H1EP
         LvbnW4VkXE8heu8hr5h4xE8oXhFzjyGBy4mC5PKLhyUC86XyJr6fvTEvWNkjvceyZEZ3
         8/yWSS4Oy36vE7pZQ3hBNZjRYqoMcYEJCsGCMGozy4SBtX8d6oKmtSeEO/ZmanFFZA6v
         Y01loSTZcN2UaX9W2EM40QnrGbFRQkv55MdNcG0eBSJQnT+xk/cVNlWYe2bM17+4hmle
         AQiA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBnTsRXZWcnkZXPhCbshx+U6BG2YpDIXf/P6ReOaiNs3LMFr0nV44cOzMMvzF0fPQ6Hazd3Y205CkPc3W6T+0Ua8osFy2BFUeCyF3
X-Gm-Message-State: AOJu0YxY9kBASLwHQTxFlNeyuMMHZ4d4Y48i5LNxvnpSuIb5IHwK0qEc
	x5lDHQR+z9mb58gs9SOlt2Racs3C6P556nlqRD7MDooSNtQ23XEBx+RycrxzlCwoAg==
X-Google-Smtp-Source: AGHT+IGrwYKomfAsQj4cKz/MKfwetlk53rpeoeSmV3xR4nT7o6aQn7v/dKEW5nGBhivp/Ou1y7JGaw==
X-Received: by 2002:a05:6808:228e:b0:3c1:9f54:7781 with SMTP id bo14-20020a056808228e00b003c19f547781mr132415oib.0.1708844040273;
        Sat, 24 Feb 2024 22:54:00 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:54:00 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date: Sun, 25 Feb 2024 14:52:26 +0800
Message-ID: <20240225065234.413687-12-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225065234.413687-1-mmyangfl@gmail.com>
References: <20240225065234.413687-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hip04.c | 38 ++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index feb34e98af8c..8ba82675ff64 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -10,8 +10,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #include <dt-bindings/clock/hip04-clock.h>
 
@@ -24,16 +24,28 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
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


