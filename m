Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913575E3BC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGWQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGWQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:24:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FD1BC5;
        Sun, 23 Jul 2023 09:23:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bba2318546so1927625ad.1;
        Sun, 23 Jul 2023 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129432; x=1690734232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NCW8TcGCgCLz1s5frmIovLcUfj5F4c7j2JB7dPJVhc=;
        b=XA4lMrWxb9O0bXJv9tXIuGqEblnbUW9GvP5gA76thS7UYYTq7LisBR0flM9xpUb4Bi
         2M9zCWIYRCtx0hDqrCvqycpgP3BX/VW2bRH8QYShbMfHq6F43EMIgDYTzUKkvnkfEJ3v
         RMZSaymBrW8tKQGz0bzNv6JHXac7AOkQ3+yEGCSQmI487LrCKE0aVPeSroLG0Locdf2Q
         2lB3oavIyr8yFoiZwog2rh9wTaO86xhs+fXhZFBQ5qesknQzFhc+7Pynl2DXyKC3Pub+
         TGlVQmmAFM8a0fFxxoL3e9snsMdPq8AK/N6mQ+nbVf4ZYqvtO6X5osXJM6enqvZrtEIn
         jk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129432; x=1690734232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NCW8TcGCgCLz1s5frmIovLcUfj5F4c7j2JB7dPJVhc=;
        b=SVbRRU1tsr3Ymzfecf30QWh5vZaeLGBqOycydKsKFwlPb+3oADb5bJ9KtoKxWBEolf
         gWZ/k/tUp2q57+biFwizKvKIkjGrisqu9E8zWexhp+IZLCKcF2nBXkBcDOpamDxyEL24
         ukyRMpjwdabg8I/Fb0nYdpty9hpfhmCitMVBNzFoXOPXzkiVlXVX/RdT0Wsm+1MroNI/
         4kccJjDKsaC5Qsm9E9yBI+tlGycHQ1zTwFrRRtyZdLbaCyyLfOEWC9xsK7GF4dbMe6iw
         9cup4E5P++3yXR2Jw2hYamIQ/P/37Tt0z2ZZfC8TcZ+kg+PC7P9XDDHssvDgp32gHg+w
         WXuQ==
X-Gm-Message-State: ABy/qLZQeE9qylQ9c6HSswbJi0kRPdz/JLM+cVEV53ETSaJNIGmM+xCH
        jGZttRt/jMD5E8FO8ntbqi6OJ4+YNBs6Mlp/
X-Google-Smtp-Source: APBJJlHGXkzzFUeLdS0uK1YOEB+CkLNn6TrYZq3WJDTx6wPo9ddo3Mhomp618hDPCJJePCQ46ZRE1w==
X-Received: by 2002:a17:903:2288:b0:1b8:a56b:989d with SMTP id b8-20020a170903228800b001b8a56b989dmr10704114plh.6.1690129431691;
        Sun, 23 Jul 2023 09:23:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:23:51 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/13] clk: hisilicon: hi3516cv300: Use helper functions
Date:   Mon, 24 Jul 2023 00:22:27 +0800
Message-Id: <20230723162245.35033-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723162245.35033-1-mmyangfl@gmail.com>
References: <20230723162245.35033-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3516cv300.c | 171 +++---------------------
 1 file changed, 17 insertions(+), 154 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index fe1bd3e3f988..93db2be9229c 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3516CV300 core CRG */
 #define HI3516CV300_INNER_CLK_OFFSET	64
@@ -126,67 +125,14 @@ static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
 	{ HI3516CV300_USB2_PHY_CLK, "clk_usb2_phy", NULL, 0, 0xb8, 7, 0, },
 };
 
-static struct hisi_clock_data *hi3516cv300_clk_register(
-		struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3516cv300_gate_clks,
-			ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
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
-unregister_gate:
-	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
-				ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3516cv300_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
-			ARRAY_SIZE(hi3516cv300_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
-	.register_clks = hi3516cv300_clk_register,
-	.unregister_clks = hi3516cv300_clk_unregister,
+static const struct hisi_clocks hi3516cv300_crg_clks = {
+	.nr = HI3516CV300_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3516cv300_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3516cv300_fixed_rate_clks),
+	.mux_clks = hi3516cv300_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3516cv300_mux_clks),
+	.gate_clks = hi3516cv300_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3516cv300_gate_clks),
 };
 
 /* hi3516CV300 sysctrl CRG */
@@ -200,118 +146,35 @@ static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
 		CLK_SET_RATE_PARENT, 0x0, 23, 1, 0, wdt_mux_table, },
 };
 
-static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
-		struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	return clk_data;
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3516cv300_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
-			crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3516cv300_sysctrl_funcs = {
-	.register_clks = hi3516cv300_sysctrl_clk_register,
-	.unregister_clks = hi3516cv300_sysctrl_clk_unregister,
+static const struct hisi_clocks hi3516cv300_sysctrl_clks = {
+	.nr = HI3516CV300_SYSCTRL_NR_CLKS,
+	.mux_clks = hi3516cv300_sysctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
 };
 
 static const struct of_device_id hi3516cv300_crg_match_table[] = {
 	{
 		.compatible = "hisilicon,hi3516cv300-crg",
-		.data = &hi3516cv300_crg_funcs
+		.data = &hi3516cv300_crg_clks,
 	},
 	{
 		.compatible = "hisilicon,hi3516cv300-sysctrl",
-		.data = &hi3516cv300_sysctrl_funcs
+		.data = &hi3516cv300_sysctrl_clks,
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3516cv300_crg_match_table);
 
-static int hi3516cv300_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static void hi3516cv300_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-}
-
 static struct platform_driver hi3516cv300_crg_driver = {
-	.probe          = hi3516cv300_crg_probe,
-	.remove_new	= hi3516cv300_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3516cv300-crg",
 		.of_match_table = hi3516cv300_crg_match_table,
 	},
 };
 
-static int __init hi3516cv300_crg_init(void)
-{
-	return platform_driver_register(&hi3516cv300_crg_driver);
-}
-core_initcall(hi3516cv300_crg_init);
-
-static void __exit hi3516cv300_crg_exit(void)
-{
-	platform_driver_unregister(&hi3516cv300_crg_driver);
-}
-module_exit(hi3516cv300_crg_exit);
+module_platform_driver(hi3516cv300_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3516CV300 CRG Driver");
-- 
2.40.1

