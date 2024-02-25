Return-Path: <linux-kernel+bounces-79998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77EA86297D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE281F219C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED9EED5;
	Sun, 25 Feb 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOkIWKVS"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CEE55F;
	Sun, 25 Feb 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844004; cv=none; b=BFyh7KMRcs+z308EWz4kd6RZ17RD3tPvR3osBueyk4iNCrIGSr0objy8BD+gpGHmPes15tDYjHt4Ti3Gee0eR7EGtGQF5wMFXZrxj2/Cvxojry5Z1Lpb3mK81eCNPMkPlOD36dnrn1pa6grScK2Zs/mojiQCoQ9CBxIu3bC03Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844004; c=relaxed/simple;
	bh=T6lQiVWmytZHVQJAW4xa+ziFT/0SMHSrOAt1hAa7bSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtVzbJ3IS7FUbX/qoHDuaav7DlA3uVQRyqz3OAEpGhyt8TGh3sss20m/n80OHFcSR5z0Tfw14rTzlSUW6FMWNx2lp4tp29/2+s5z7kLLL9rD1CMTTQi5MW7izrTGOkKSeTvNizwMRd8V2qd+pIYhcItPhOTzoOH8i9D6hZmMH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOkIWKVS; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e445b4f80bso1125232a34.0;
        Sat, 24 Feb 2024 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844002; x=1709448802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNeTl78vZFNcKOErgWglz32ctBFQT/HCoAapAxi94qA=;
        b=UOkIWKVSRP+dZWcbzkPwepnMBD6j3h2aA4iOb8Qc9niZMLpw8mAP6jN19Vw86LvWcK
         vrmW70aiBb3hHD6d47YdF8N6grWRuRZ1qvl5RI7fzac2KSu9pkP/oJP5yv+8lG2i4OpH
         C6rAGBIz/FF9pkSjwN0tlUNKWBZRnNZLYLMGVTfkBcQkISf0GHIq3Ojd/kIPtLIRfe65
         kLdGW8hsy0QkWtUcV2WLkEmN5n/XLcqhgMzk2AJt0dZeLfgf7RXGtC2wqdezp4CH9OJb
         oV56VcHlV0eyb4x1QL2VA1ncWQKy20n1T+pbEp2y1jMeeaVkYrN4s6w8fAT7qTmi/Z85
         Zc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844002; x=1709448802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNeTl78vZFNcKOErgWglz32ctBFQT/HCoAapAxi94qA=;
        b=M6BPalDAFH+IgxsvSgfocikoabxvDCt78tbn5aerN0+Ob3VPGjGglJ5h6ReI4vOFcR
         iMdTUWOJ+vlvOwo9Aw9i/xUqWhHOs8JBaDQBeg4Q+tHvPX5Sziv9nES50Lzm1YtSEHe5
         vk9+Qly1rzaQzrikS/BgnR8j9IX+8ODvw38tbf7dTWGZvD6yY3YM55UGC5jx7RN4dPmv
         s1jt2h2FcIRES5F+Czt6DshsN7TKzJGce54UJiRHICfjCsuwBHYm4snLtg5KFRX+N/nn
         M+lZ4XEnlJ7rdmSSkJm0BXyh6rwAToK/JBD7v7GwRHKQHN5IUsnQX44hJEI7gq85HS5T
         w6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM46gWy2OtMGQXVCkq2r5WtAJPh44CAflPtc6sNBcOP8F6PScCBHngajV8efks3QDKbhi8b+gH77cR3V+hb0WXisVIefMjx5AlIcDq
X-Gm-Message-State: AOJu0YwvxfyRHouqTtEovJ/o/0Xpo/Iv+DewUiXTuHbqm9JEgTZrlb5i
	4umoORR6nRxna7HULSmV43Ip20q9p4P5zhyPyf+EhbEgU8IHv99YBfdrDV0k4kYiBQ==
X-Google-Smtp-Source: AGHT+IEGL1ftm5c603QU/kNhH6IuZ3wUSAolORshN5jomCVeQRHqfFnuMr3JaSy25AHc4pS16vydhQ==
X-Received: by 2002:a05:6830:1645:b0:6e4:6526:e207 with SMTP id h5-20020a056830164500b006e46526e207mr4585831otr.36.1708844001894;
        Sat, 24 Feb 2024 22:53:21 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:21 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/13] clk: hisilicon: hi3516cv300: Use helper functions
Date: Sun, 25 Feb 2024 14:52:17 +0800
Message-ID: <20240225065234.413687-3-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3516cv300.c | 171 +++---------------------
 1 file changed, 17 insertions(+), 154 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index e602e65fbc38..0e6b95d00c68 100644
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
2.43.0


