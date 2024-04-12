Return-Path: <linux-kernel+bounces-141964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1498A258D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD111C22559
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1E482FA;
	Fri, 12 Apr 2024 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J999A89/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25947F7A;
	Fri, 12 Apr 2024 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898738; cv=none; b=nsUBQp9BPppNhPZEDGX8kddtOs1XhfK5OXYhgGVnKWv+/pjuUtbZuX5Y/5pkzkuFZ6uKpriQgf5qrS8QHsw++Dth0Bd4kbdg9LGqbZsnnzhGquBZ/Ab4fuRIa6r/N27yck4+gCMUtN2C0HTvYWIX5dxcv5Qs7F5YCCkFxLImBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898738; c=relaxed/simple;
	bh=4hBDfyqNJGhczrAbriDJjBqzMZKnQpCmCElVDsfAepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvZUu5QrAedp3GkNVgUmGj+ekPy/SoHOXL/lCWMH484CzXjzRff9CSxIltrDXLBpWZdL+1UImpcXFs4YXYJ4DzC8O0iWc9sVcNTRFOlAUavtK2SYdHP3rqxrznmrX4u+x6ipWQ5v5Ih7gtht0DagEWJXDt/70PvNfxJ2Ir7TnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J999A89/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so531680b3a.0;
        Thu, 11 Apr 2024 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898736; x=1713503536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=J999A89/6C0k8wZMCkTeYCAK9XJ9YivuhcwZDehGJqIgRAZ+bTYgRmxpYfJGGPFFZK
         qN8A4rXa1KIxGPV6LS0weharCK8sdD7/tbcdjMxhEJ1gxP/nMHS4itIqSHef73XSuGzR
         WE6hmHChE8sDWyP7JiOAq02PGwH6X+Z7wiYq8IxYZKIyXB6gN37SH5a4Hi7CsnHf1v7J
         Zyx8yiYGGRJvwYts86da4TrG9KkyNSW2Y67hMxcYWKorchIuRKS55KHq/UHMjxWZHOIy
         gHZOkDJjhzdcsOedHewaFEtNI92TMI3jEdevO19XBbTbkovAklLtLO7NzcTWVrk4ECuy
         CDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898736; x=1713503536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+nnU8lhrJvnMJXK2RHKJh1TRqnP2rEwLBbGg2+14B4=;
        b=Km29QOtaIx3G7YbkhNkbbdbLxeaQkf+6HAawnKsqxMVj2hzjKNDfQLCuvD2JMd9ScP
         ogQi9a8eEZsEzis6KYk2PNc7l2i1cEhD1MS0zRPKT5vfTqd8bCqNu1D2dM1PrH9hFEB4
         i9hNtydpwpBN9h4Ff2TpFC2r+RGJflHgL/GxZ0vbB8YV09ErZLYperu3zx4/v2LTum9D
         NKf7shlVWw3Q2E2L2Uu6l4U8O0Kc6+4bckQJcCHI3d7vDkcDDw+b0++t77kUfCBUPHXl
         hNXJtUU1ufZ6GTFWPFEHl3odpqVN9mcXFIHAjXhr0Apc8GCyohjmkyxRcPgnkSMMYmfL
         MA3w==
X-Forwarded-Encrypted: i=1; AJvYcCU5ucOy38pqs7Ul6O0jVs9dRPlyNMQzMtyfKUamo8Q2mmWfrzyWx6DVDOOkkOKVh8QqYJp2Qu934NjpJUCXvissLboLDSVWzpvrOW89
X-Gm-Message-State: AOJu0YzmhttmNdWXaz3VEUiq5bX1H4is2z5Q5zb/L+9QyY46ZEaWwX1r
	mG+DrPDxQ2AF/6DhMWkgVf8H2FuoBm0OhF3n8m98kLw6wxfi7wLzVEfgCIet
X-Google-Smtp-Source: AGHT+IHkCONMYo0N1+GAWx3hBzOjQJE1wSaEQH37vzw8fjz0Ha0ZXa1nc57mG6r7eiSM6ewQSZlw5g==
X-Received: by 2002:a05:6a21:271d:b0:1a7:a3cb:78f3 with SMTP id rm29-20020a056a21271d00b001a7a3cb78f3mr1670820pzb.12.1712898736123;
        Thu, 11 Apr 2024 22:12:16 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:12:15 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 11/13] clk: hisilicon: hip04: Convert into platform driver module
Date: Fri, 12 Apr 2024 13:10:40 +0800
Message-ID: <20240412051041.90376-13-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412051041.90376-2-mmyangfl@gmail.com>
References: <20240412051041.90376-2-mmyangfl@gmail.com>
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


