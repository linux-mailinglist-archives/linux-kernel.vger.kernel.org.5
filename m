Return-Path: <linux-kernel+bounces-139921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF9E8A0929
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FC1C2162E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC013E8B2;
	Thu, 11 Apr 2024 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHm7Jopn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50F13E8BC;
	Thu, 11 Apr 2024 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819196; cv=none; b=qkM8sOaRrMv3N5c08ubgoC8LFC0V5/hqKyxgwW3Laacil+KGa1OpDpLJYFh/M8V551/pcpFJUWWv5IF9ZWUtd+Vd9rf0fCJEJV1VCJmIP0y8a3FU1RXb+8bzR2J1MkkGzg3rOwRsZxn6gxe+cr1je1ADT2U2OCiqMwQQP2YyXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819196; c=relaxed/simple;
	bh=O6604vi/bj5igXZdGKPwpCmuP/mf360WhfeWzANdq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA2D91cU1mPXGANUTqj+8Ubt1JYhtBkBoaAeGXV6L1LqrUFl27ToEiTL+0H4WAg8a3Ww6fwJeFjl1w+A0ZreJ0fbuMoZpZ+1almC9bmrZVpakjSc5SiOiYq2OUoV1aFGXJUb35aomk0qhKw62bpYP59d5kw04LSfIIqV0WQY8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHm7Jopn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ece8991654so6760773b3a.3;
        Thu, 11 Apr 2024 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819194; x=1713423994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=aHm7JopniMcEEAtagxiFj9nsCdsZgB7GZ+T8PFVOwiMmZJ1gemUo6KL0aG5G9kubtJ
         WyByJwRT4kdNs6bRAMQdfLRP/x9ascUQ7Tlf7fbroEjtmmNYR+FcsC0BoFC32ItZKn4Q
         k4aVwKmQ2VRV0GBd4GcJ9f0ndYAhee74yy+IIT5dv463HZDJKWoQINtJIfLpi38gMIzJ
         PIhUiLudYORgCzdpEHJHFeami2p0u65q0H2AEVUTB71HK/2fAqcgaPZcnhnuTyI8SAVh
         eUOtyFTAByCjkEUxzL90bNNYdrdD1DEp4CACWi+svn7PeN3BJvluPaHDvfPMacSqtzUx
         cZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819194; x=1713423994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=v6mamIYlpiFF5At9pBDJNnm/fWroP5o4Em7LVZ3u6g5EZ2j55saAtBTelJJnMkD+UL
         odiFEVhU2507KT9sR2rT2Nx3/T86CAlGGrwNx+lDVNtX5Q6FuS+0L5FV3JAm943HtX3N
         FG//iuVgBvGgEtakHJprnSTZ0Q/Y3BMIY0PDj6mjcylyLDHuobPZmxfRdcnH/SrTNCpF
         0aP0Uhkr7f55KVPLMMWCx88Byyt8M2nuCdXLgCHjnEHxVnU4xMj7CP0swoMxudhJKBS4
         VQwTAege8LoQD0Mk3K5hWedbxwzJWhlBMNtKwxRmm4WA+r7nhnPDNJj5snEp1j113sqm
         3DrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfm7b6cilVEmBUYV+L14lY9onAE1JtXQA0e6Sp52iS8H/UccUIS05Bt979THvy41jKOC38Pfc6qSx6dSZM9agm3XR1VSQckp//bb2I
X-Gm-Message-State: AOJu0YyCiNaQwwbs16538YslgYVqm+LPbPKCyQSUWQZqPxeNRo/XtBEK
	Rs0BLCTkGX0e0bS6Rg1fzS1s6ndHXwtOSG/3sBNxvdAqA95Guwit3H7ajdoO
X-Google-Smtp-Source: AGHT+IHVNje+T4OaGcFQnKq6MwDZHsEgBBIF8VA91BPtyyv+0mMDwR2iwuWty5OxlYZT9cKldYnmfw==
X-Received: by 2002:a05:6a00:9386:b0:6ea:cc67:48d0 with SMTP id ka6-20020a056a00938600b006eacc6748d0mr6002604pfb.5.1712819193770;
        Thu, 11 Apr 2024 00:06:33 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:33 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 05/13] clk: hisilicon: hi3519: Use helper functions
Date: Thu, 11 Apr 2024 15:04:50 +0800
Message-ID: <20240411070503.38093-7-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3519.c | 127 ++++-------------------------
 1 file changed, 15 insertions(+), 112 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index 141b727ff60d..cb541de752da 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "clk.h"
-#include "reset.h"
+#include "crg.h"
 
 #define HI3519_INNER_CLK_OFFSET	64
 #define HI3519_FIXED_24M	65
@@ -73,130 +73,33 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
 };
 
-static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3519_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
-				     ARRAY_SIZE(hi3519_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				clk_data);
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-unregister_gate:
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3519_clk_unregister(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static int hi3519_clk_probe(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = hi3519_clk_register(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static void hi3519_clk_remove(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	hi3519_clk_unregister(pdev);
-}
-
+static const struct hisi_clocks hi3519_crg_clks = {
+	.nr = HI3519_NR_CLKS,
+	.fixed_rate_clks = hi3519_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3519_fixed_rate_clks),
+	.mux_clks = hi3519_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3519_mux_clks),
+	.gate_clks = hi3519_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3519_gate_clks),
+};
 
 static const struct of_device_id hi3519_clk_match_table[] = {
-	{ .compatible = "hisilicon,hi3519-crg" },
+	{ .compatible = "hisilicon,hi3519-crg",
+	  .data = &hi3519_crg_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
 
 static struct platform_driver hi3519_clk_driver = {
-	.probe          = hi3519_clk_probe,
-	.remove_new	= hi3519_clk_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3519-clk",
 		.of_match_table = hi3519_clk_match_table,
 	},
 };
 
-static int __init hi3519_clk_init(void)
-{
-	return platform_driver_register(&hi3519_clk_driver);
-}
-core_initcall(hi3519_clk_init);
-
-static void __exit hi3519_clk_exit(void)
-{
-	platform_driver_unregister(&hi3519_clk_driver);
-}
-module_exit(hi3519_clk_exit);
+module_platform_driver(hi3519_clk_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");
-- 
2.43.0


