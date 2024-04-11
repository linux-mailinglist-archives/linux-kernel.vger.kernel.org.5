Return-Path: <linux-kernel+bounces-140166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32D8A0C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C3B24567
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D9144D20;
	Thu, 11 Apr 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7uSxd1yP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D213FD76;
	Thu, 11 Apr 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827575; cv=none; b=apQZG9nMsU4T+MffZfrKxsw8BRiIcZnhlD4fVszsoLgqa0oL2NqnMiHkqM6HuratiNEN7CNQvISWqEmvw/hCUdL9j1RH2Zz9QHRqEJ8gqYvP5No8TTRPE/A9WYH7JdEE9e1xRNxOkoNxFX+2VfbzTxg9wixvN3EsGy2UM644gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827575; c=relaxed/simple;
	bh=yKL/GD2g+PqqgINfyNMStamCKLF/QziBlhTPzWm6TAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8Odff4XxmusH2A1b4Y6lAdKtQBxde1g4iXkpPIwVV/q95SLEIVZKS2lKdkLHYpaq2swQF7YwTOLzPVSv30YpxCm8uLbauYK4g9oSLdtgegUg61AYqhg882xxe1bvPCbHpTmbBmXxuQp0YX1jMR6vcW2j2lxhGRvwfWpdoz4v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7uSxd1yP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B7qcKO017772;
	Thu, 11 Apr 2024 11:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=r6X6BGtuJHlAwq5hKk1XL9iK7bAsTfplYeEEaPUDmGs=; b=7u
	Sxd1yPdI4XGINNxlPGMjR9PKr0kacLfcKFbaXTrCSBM19iQxPtxicJKuD5AQpHsq
	qQYkHiJun3eBnfltFc2idQ6fkbwgdJ7E9pf72qkHLmL/4bMRg97If9iVjdzkVhrW
	e3iai0w3AXiQxU7u1tJegTT1jrc9kRAsRzRS8oFdCj/b9MHV2tx52RvTNquDn6qL
	F78qUtIUEPvgnHOQgmEWpnkNTaneLC16JW6g63NGz01QEE90JdiSe4OhMKfCz9zZ
	vW8PGrYQOFmO9elQpTYco9cIbUeLxcLrLRx5kpJ7tqWoAdBsGOlJXKGv7jAKwdhj
	d5qiTFqGA3Q5sB0E9fMA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh5c54s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:25:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 293A540049;
	Thu, 11 Apr 2024 11:25:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C1D2212FB4;
	Thu, 11 Apr 2024 11:25:00 +0200 (CEST)
Received: from localhost (10.48.86.110) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 11:25:00 +0200
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/4] clk: stm32mp13: use platform device APIs
Date: Thu, 11 Apr 2024 11:24:50 +0200
Message-ID: <20240411092453.243633-2-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411092453.243633-1-gabriel.fernandez@foss.st.com>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_03,2024-04-09_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Convert devm_platform_ioremap_resource() and remove unnecessary
dependency check with SCMI clock driver.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c | 11 +++--
 drivers/clk/stm32/clk-stm32mp13.c  | 72 +++---------------------------
 2 files changed, 10 insertions(+), 73 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 58705fcad334..1721a3ed7386 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -25,7 +25,6 @@ static int stm32_rcc_clock_init(struct device *dev,
 {
 	const struct stm32_rcc_match_data *data = match->data;
 	struct clk_hw_onecell_data *clk_data = data->hw_clks;
-	struct device_node *np = dev_of_node(dev);
 	struct clk_hw **hws;
 	int n, max_binding;
 
@@ -64,7 +63,7 @@ static int stm32_rcc_clock_init(struct device *dev,
 			hws[cfg_clock->id] = hw;
 	}
 
-	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
 }
 
 int stm32_rcc_init(struct device *dev, const struct of_device_id *match_data,
@@ -638,7 +637,7 @@ struct clk_hw *clk_stm32_mux_register(struct device *dev,
 	mux->lock = lock;
 	mux->clock_data = data->clock_data;
 
-	err = clk_hw_register(dev, hw);
+	err = devm_clk_hw_register(dev, hw);
 	if (err)
 		return ERR_PTR(err);
 
@@ -659,7 +658,7 @@ struct clk_hw *clk_stm32_gate_register(struct device *dev,
 	gate->lock = lock;
 	gate->clock_data = data->clock_data;
 
-	err = clk_hw_register(dev, hw);
+	err = devm_clk_hw_register(dev, hw);
 	if (err)
 		return ERR_PTR(err);
 
@@ -680,7 +679,7 @@ struct clk_hw *clk_stm32_div_register(struct device *dev,
 	div->lock = lock;
 	div->clock_data = data->clock_data;
 
-	err = clk_hw_register(dev, hw);
+	err = devm_clk_hw_register(dev, hw);
 	if (err)
 		return ERR_PTR(err);
 
@@ -701,7 +700,7 @@ struct clk_hw *clk_stm32_composite_register(struct device *dev,
 	composite->lock = lock;
 	composite->clock_data = data->clock_data;
 
-	err = clk_hw_register(dev, hw);
+	err = devm_clk_hw_register(dev, hw);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index d4ecb3c34a1b..bf81d7491708 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -1536,77 +1536,16 @@ static const struct of_device_id stm32mp13_match_data[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32mp13_match_data);
 
-static int stm32mp1_rcc_init(struct device *dev)
-{
-	void __iomem *rcc_base;
-	int ret = -ENOMEM;
-
-	rcc_base = of_iomap(dev_of_node(dev), 0);
-	if (!rcc_base) {
-		dev_err(dev, "%pOFn: unable to map resource", dev_of_node(dev));
-		goto out;
-	}
-
-	ret = stm32_rcc_init(dev, stm32mp13_match_data, rcc_base);
-out:
-	if (ret) {
-		if (rcc_base)
-			iounmap(rcc_base);
-
-		of_node_put(dev_of_node(dev));
-	}
-
-	return ret;
-}
-
-static int get_clock_deps(struct device *dev)
-{
-	static const char * const clock_deps_name[] = {
-		"hsi", "hse", "csi", "lsi", "lse",
-	};
-	size_t deps_size = sizeof(struct clk *) * ARRAY_SIZE(clock_deps_name);
-	struct clk **clk_deps;
-	int i;
-
-	clk_deps = devm_kzalloc(dev, deps_size, GFP_KERNEL);
-	if (!clk_deps)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(clock_deps_name); i++) {
-		struct clk *clk = of_clk_get_by_name(dev_of_node(dev),
-						     clock_deps_name[i]);
-
-		if (IS_ERR(clk)) {
-			if (PTR_ERR(clk) != -EINVAL && PTR_ERR(clk) != -ENOENT)
-				return PTR_ERR(clk);
-		} else {
-			/* Device gets a reference count on the clock */
-			clk_deps[i] = devm_clk_get(dev, __clk_get_name(clk));
-			clk_put(clk);
-		}
-	}
-
-	return 0;
-}
-
 static int stm32mp1_rcc_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	int ret = get_clock_deps(dev);
+	void __iomem *base;
 
-	if (!ret)
-		ret = stm32mp1_rcc_init(dev);
-
-	return ret;
-}
-
-static void stm32mp1_rcc_clocks_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *child, *np = dev_of_node(dev);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
 
-	for_each_available_child_of_node(np, child)
-		of_clk_del_provider(child);
+	return stm32_rcc_init(dev, stm32mp13_match_data, base);
 }
 
 static struct platform_driver stm32mp13_rcc_clocks_driver = {
@@ -1615,7 +1554,6 @@ static struct platform_driver stm32mp13_rcc_clocks_driver = {
 		.of_match_table = stm32mp13_match_data,
 	},
 	.probe = stm32mp1_rcc_clocks_probe,
-	.remove_new = stm32mp1_rcc_clocks_remove,
 };
 
 static int __init stm32mp13_clocks_init(void)
-- 
2.25.1


