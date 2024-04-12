Return-Path: <linux-kernel+bounces-141957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9397C8A2581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA492813E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288E39FD5;
	Fri, 12 Apr 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMY7Ff5f"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE62BCF4;
	Fri, 12 Apr 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898713; cv=none; b=uPyHafim1J4oGJMCL+2IusMlOOOmhyVBcw2r+KL1HBRZRJmSuuSgqHEYUVM9oyGs9992ttMbQdLU0TYXcJ0SEcwUXLtfQzbWd/1WgufNhzEbBQhMUgPN8lRTWf7OtVAXp2Lb5FNO1vJ3KKGybO8ry5bHcnRduv2N+qcR/iuwhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898713; c=relaxed/simple;
	bh=O6604vi/bj5igXZdGKPwpCmuP/mf360WhfeWzANdq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti7Y+xc+BX6Tbpx8luN+HPv6HvLrsBPXsIRTwIqQEo3uCtvDEpjsHLuF/oZPNlxH8DXblgsmsQ3a89sr08tSJEEif7JNEL80xMlVtN4k9ovmuweiA495qAE0sdYbvAwLwdm3w7wsLTxO8Pt0gejXyoUU3P8C0R2QrQH1GBFaqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMY7Ff5f; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed5109d924so535480b3a.0;
        Thu, 11 Apr 2024 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898711; x=1713503511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=RMY7Ff5fRdvbLBS+IemeRvJDkdEOtGtkNS/KgpfJl6OvGDaG5D5CEn6RO98RaSGqjL
         LwxFn+ASsezH8wyahApahM4i36OKosVANctQ4KMVUZjkzt0BxDvfAWZseIJig65Z+woh
         oh7feZ8gkjzBhBU193JTeDAkmgwgc69oM9VhlYu4qrF1OgwByhXRlWpjTJ/8X/Rs0KYb
         C81uT2Y5my6Iq4mz0si5prwkdPq5Fg7euL4fBfjs8Rjn+QdG9cWbjQ5lCbbCR60g/BYU
         rJtpvgnqpMxTTMoyKh7rhmQgFCf2dLPsfPj6rZX7FW7twzpBrwcpTa0MxfddGr22tsJ1
         q2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898711; x=1713503511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBKLoEacHSWOE25HfyrDdRRp12aAe56L7a96hJM6/NY=;
        b=tDTN3dgvMLNsll1eBjb/1CWtWnIp280P78FJMc+lCXAPzDfZJPmjUAt3ldms+Ff2Fo
         sjlBK+B7ALz1hRc49PYh+s81S/+zDk74Z8gCvedPpjIOuEcBJ8OhFKsO0L8fgyC0Tvrc
         J7LclE9V+zjgc0YtDQLz2UHTmSm+szAFBuC519EF1gNgBAq3rLQOMlkXEyPq0ZJjTI50
         YPqNNQWjCWHcP7dPKE88iNzVUibhKkfbmD6JhM/NmIkpfBqyh3nNj0adDejgjaa8M/Hw
         6Uvo5rfo2QF36zrH1VCdx6d4OD8Snzp286Z3Sf7PQazDhisr0yR/V74mKzXBEJ9lVz+k
         HYTA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUk5uFDebINWH7dgJFM6Y7HVZw5zeswFgxp+VyxWP7NfvxCmplVs/LHA/x1A3u+qeFi3LN906BVMjSTlYvPvCcyRaXDW46gq6TDf5
X-Gm-Message-State: AOJu0Yyi8TPHqAI7hwbLzZeZhX/m2wW2zuKKgBeE0ppZinvgGNp50dcO
	YnHR6AkKmjIABAliYeMDv0tCRvOmqJs+1xrxyxeTXAPFrLlcRZMcs/XwOzBT
X-Google-Smtp-Source: AGHT+IHyBPGnZMc5WJuMbCUxix9T7pF6Kbs6ArzEq88H0oipQ7Qn+Kwmca023sw6UVexKBltNPu+CQ==
X-Received: by 2002:a05:6a20:918e:b0:1a9:11f8:4889 with SMTP id v14-20020a056a20918e00b001a911f84889mr2234584pzd.10.1712898711105;
        Thu, 11 Apr 2024 22:11:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:11:50 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 05/13] clk: hisilicon: hi3519: Use helper functions
Date: Fri, 12 Apr 2024 13:10:34 +0800
Message-ID: <20240412051041.90376-7-mmyangfl@gmail.com>
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


