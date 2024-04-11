Return-Path: <linux-kernel+bounces-139927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C804E8A0935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54ED4B286D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4A1420B0;
	Thu, 11 Apr 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCLXkEel"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462F140367;
	Thu, 11 Apr 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819221; cv=none; b=nqr6r68WZ4TuMmYJvdmWJ6zb8QEuPqI86QKze7axtG7IdncYs0BPl4WRRL+nMIFOXWguLkBfvlisdX/cbSWZG0+v9oyu0lGUTEAqHx7qFgWGu9e+Y8m4c813XCQb0XCzHKHSTwgKcpDpU5t4KMz36sjvl/D/PQpliK99BSHOVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819221; c=relaxed/simple;
	bh=4hBDfyqNJGhczrAbriDJjBqzMZKnQpCmCElVDsfAepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thBpmYAiX+7gGyZT62+mywDmSEfslmXgqFatrGyQVvYT86VDWTxlJuWHqLkSL8qoY7IXRJfM/nVehcuh/d4XE1thGx49NsdpFmPS/PSykApkQ+XfahDxN8o2rUI2eLydN26QSEqkVmVBfFIvYFnWX1cXJ723RDuJoY+NHw0Mnr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCLXkEel; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so5374122a12.2;
        Thu, 11 Apr 2024 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819219; x=1713424019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=ZCLXkEelB8wBA+jtl82AUzujpoKEYp6sGkJwlXUyclxPcD8onUKWgTVDwhh7afuY/v
         h5+Z1+8JUR1kfPMpB05aHKrViH63skUFUJBMrnNmpHLa/xA2jqKCC2dim1hmFzMb9AVa
         MUyVcXE7JQV6fBwF6RCYKbe88uSjjx//KpIww2N7qP8KpA1H0ZdTqVdYIFBsyAiqRTxZ
         HzzfG3UC6UXDAzJlL0uvblZ+I9eQuh8eZJ2xHMCzj7QMdD25eUE6wNFPUlQFjhe81gL/
         ASvIksFNti8uYgxMplAEY8p6EjsOds35Qb8woG7PJo2zD4ojlvDgkAfDsBiLpBwf2nuy
         gobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819219; x=1713424019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=qyovFvh7LC6ifCXkESLv37ByXhDOf1ts/9Nx3RTm+1Gt/GcHWx3dUmpNlse0+uCCv9
         ERXvfB4TZbzRfA3CAC8oO8FJpTlSyPBnqHrnBchaCcBiZ7MxCtEsx4iLd+m7CHbN6g2Z
         V7fM2bqyVGwaedpe7NwCYYHTDORm+XIOv36CIly0Lvp4nT+9qWWxMgSgDYKEB+l8tOYg
         zCj8E003uJ05UynjlodMkSR27Pm6vwVVBK8qJ4N3MdltZ34wwxWxsX6sLFnE+dDVtD7e
         sawTzeZzFOVe6tgDog+r8HvLRkHJaDw70MQzwlhIxOa8wRzhsSHG9ybQ6t+RaoGzm+MK
         mHlw==
X-Forwarded-Encrypted: i=1; AJvYcCW499un7VjVs9HYIbSa6hQ1ge2iFhMWTh0NHqZOpecafKvyt0oC9lqkjL8sSvLLNc2CI3d8VYGGxzCwEi2T98HBHpPp31EJiJpG0abI
X-Gm-Message-State: AOJu0YykSM+kY99107H/CzRqbUZJ0MwMEP1PH2B50sUe/K1Xir+5d1te
	nHZnq6dlRCoBDqLRBdE219YsgxZs+WWZWtKUdQrXFO7jVv6unuWde5pPBUnw
X-Google-Smtp-Source: AGHT+IEUmGfqMkt731Rb5CABFKSOrqGnPjeVU6s5AtY5X7Bc3PrYI8gnbW62UfDVypDVtei2d6EspA==
X-Received: by 2002:a05:6a20:104b:b0:1a7:79b2:ff1b with SMTP id gt11-20020a056a20104b00b001a779b2ff1bmr3947113pzc.27.1712819219308;
        Thu, 11 Apr 2024 00:06:59 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:58 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date: Thu, 11 Apr 2024 15:04:56 +0800
Message-ID: <20240411070503.38093-13-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070503.38093-2-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com>
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


