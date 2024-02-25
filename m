Return-Path: <linux-kernel+bounces-79997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCF86297B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C6C1C20BC4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A64DF46;
	Sun, 25 Feb 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDVuoMd+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4DDDC1;
	Sun, 25 Feb 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844000; cv=none; b=WmLBu4bf9IRgk6zaUZTaZHO8/oxsVvE5iPly0NhtuYy2DG+wLR/qfRfl+qdmv+uNMQRHNQrVQbxcdUrjHkPBTA9wFX/ze8dfa4AfLxtm9f/XYKI1SDlz+lPteLuMb9RgOxcpRN5kNvbpiWrCUbQIYJn6d3ZdBCJ2TYyHIDKrPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844000; c=relaxed/simple;
	bh=qV+TUhScXnsFCcXjysHZMsUqOYgW0YWa8A1F/4yvWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alvtolb5RDfaQv+ioTQ9je7dWF0cel4Rzkven9SnVd77VYuJNtbUQJWfn+uR84MGaQnHFiOfnQrb6rwdg/xsYvRfqEKFjJFO/DcqOX0Ip++Q5nO46ZTsIKJ5SlatIJCM7VYmoBDhIhW1y+GcXZOjXnsIb1VeJ2NX2zyBlNNhtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDVuoMd+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e4670921a4so1037808b3a.0;
        Sat, 24 Feb 2024 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708843998; x=1709448798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge3qCO4AreotxW/9ObggwwmDAaxwATx2bDwIFBb6N7I=;
        b=cDVuoMd+UfsnMTsXmPHY2QVNey1b4b1OQBlJu/jml5EHwqJc+js2zvWVGoMWGXWJAf
         TUuoCpByctOe5OJu/zpxOdYEMQlFwp5sc3ZNWDhf0WQPJc1pLlmOp+Fh6pz4z3RoucZQ
         MtDrhPmY32OjqXxyyFXi0oYL0wHOyvFkgwK+n36HmMFEzMrsd6RPhC6VBlc1plOPYPoR
         MKB5Pj8bUJW8y+C0KIw30g0HkMhdiffpO33diIZPI/D91wmgkEjE1aAS8dPVdgA0xBc8
         I2/xbPWhGy99RZKmiO1sDKo3ki0MfyGOZWlFA8nerovTBcER0M6ErctKfxeFGIZOGlww
         rv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708843998; x=1709448798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge3qCO4AreotxW/9ObggwwmDAaxwATx2bDwIFBb6N7I=;
        b=nNxGPyj4/gWV6CTeX37gzPFUWlCi6o11+MSFeV31KM9YIfQ1tGn3lwuR84s+T6kKsw
         7pWvc9cye2MuOo89CpJrTU5vvppoIs9Vgn/D4Q+uutYDzQn42Fmv09t7FQk1xzZR01mj
         eK+OnHTTDO7ILCfqoIG56XNVMTmAUOi4DncrpWL/74LpSBJy4y4/a7eOELd3mqlUkLKB
         8rNd/npjy7/8NuvDsltH38xSklsABo4EXj/VsCN63pqJl4kGGY/lnLZ7+QH5lGYS1vCN
         or9y4qfS3R/CRIMAWeGbfhBIu9azlSgX963PpCd1FX4qmS46dS9TINDGtclYcJ/g2wl1
         3eWg==
X-Forwarded-Encrypted: i=1; AJvYcCUU25bPN4D3bBgfv1JqqGX+gGA7XyR6R5mfRZqy2V37sXPAX/U0MNTPnLG0ve2v31lEZ8Rd58BDpGLFTqim+/F3ZZgXLmQqGJLu2H1E
X-Gm-Message-State: AOJu0YzoVYj6IMlp9EXQLu/wwcrKbT1tW+kjucQbmn+itYjwLiFiDozx
	uDPgvD/2Xd90kOiQgeH6ZO3S/cm2eEfkALaNDY5C2lX8/PpUf615TRxqYfclMA3BCw==
X-Google-Smtp-Source: AGHT+IEW+z97dm13dPtWy9ORBQ0gnmDM4mRbvJLM8Vv8Env+wEWkLSoWrzOEs5bDOvMzSXuh2NttmA==
X-Received: by 2002:a62:5802:0:b0:6e4:c56f:aa65 with SMTP id m2-20020a625802000000b006e4c56faa65mr4064087pfb.19.1708843997666;
        Sat, 24 Feb 2024 22:53:17 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:17 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/13] clk: hisilicon: Add helper functions for platform driver
Date: Sun, 25 Feb 2024 14:52:16 +0800
Message-ID: <20240225065234.413687-2-mmyangfl@gmail.com>
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

Helper functions extract common operations on platform drivers.

During migration to devm APIs, (virtual) fixed clocks were found hard on
devm APIs, since they often depended by crucial peripherals, thus require
early initialization before device probing, and cannot use devm APIs.

One solution to this problem is to add a "fixed-clock" node to device tree,
independent to clock device, and make those peripherals depend on that.
However, there is also some devices that do use fixed clocks provided by
drivers, for example clk-hi3660.c .

To simplify codes, we migrate clocks of other types to devm APIs, while
keep fixed clocks self-managed, alongside with struct hisi_clock_data, and
remove devm-managed hisi_clock_data.

`hisi_clk_alloc` will be removed in the following patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk.c   | 157 ++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h   |  46 +++++++++-
 drivers/clk/hisilicon/crg.h   |   5 ++
 drivers/clk/hisilicon/reset.c |  42 +++++++++
 4 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 09368fd32bef..e50115f8e236 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
+{
+	if (data->clks) {
+		if (data->clks->fixed_rate_clks_num)
+			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
+						       data->clks->fixed_rate_clks_num,
+						       data);
+		if (data->clks->fixed_factor_clks_num)
+			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
+							 data->clks->fixed_factor_clks_num,
+							 data);
+	}
+
+	of_clk_del_provider(np);
+	kfree(data->clk_data.clks);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_free);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
@@ -341,3 +360,141 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
+{
+	if (clks->nr)
+		return clks->nr;
+
+	return clks->fixed_rate_clks_num + clks->fixed_factor_clks_num +
+		clks->mux_clks_num + clks->phase_clks_num +
+		clks->divider_clks_num + clks->gate_clks_num +
+		clks->gate_sep_clks_num + clks->customized_clks_num;
+}
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks)
+{
+	struct hisi_clock_data *data;
+	int ret;
+
+	data = hisi_clk_init(np, hisi_clocks_get_nr(clks));
+	if (!data)
+		return -ENOMEM;
+	data->clks = clks;
+
+	ret = hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
+					   clks->fixed_rate_clks_num, data);
+	if (ret)
+		goto err;
+
+	ret = hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
+					     clks->fixed_factor_clks_num, data);
+	if (ret)
+		goto err;
+
+	np->data = data;
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_early_init);
+
+static int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+			     struct hisi_clock_data *data)
+{
+	int ret;
+
+	if (clks->mux_clks_num) {
+		ret = hisi_clk_register_mux(clks->mux_clks,
+					    clks->mux_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->phase_clks_num) {
+		ret = hisi_clk_register_phase(dev, clks->phase_clks,
+					      clks->phase_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->divider_clks_num) {
+		ret = hisi_clk_register_divider(clks->divider_clks,
+						clks->divider_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_clks_num) {
+		ret = hisi_clk_register_gate(clks->gate_clks,
+					     clks->gate_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_sep_clks_num) {
+		hisi_clk_register_gate_sep(clks->gate_sep_clks,
+					   clks->gate_sep_clks_num, data);
+	}
+
+	if (clks->clk_register_customized && clks->customized_clks_num) {
+		ret = clks->clk_register_customized(dev, clks->customized_clks,
+						    clks->customized_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int hisi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct hisi_clocks *clks;
+	struct hisi_clock_data *data;
+	int ret;
+
+	clks = of_device_get_match_data(dev);
+	if (!clks)
+		return -ENOENT;
+
+	if (!np->data) {
+		ret = hisi_clk_early_init(np, clks);
+		if (ret)
+			return ret;
+	}
+
+	data = np->data;
+	np->data = NULL;
+
+	if (clks->prologue) {
+		ret = clks->prologue(dev, data);
+		if (ret)
+			goto err;
+	}
+
+	ret = hisi_clk_register(dev, clks, data);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_probe);
+
+void hisi_clk_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_clock_data *data = platform_get_drvdata(pdev);
+
+	hisi_clk_free(np, data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_remove);
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b027..87b17e9b79a3 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,12 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_onecell_data		clk_data;
+	void __iomem			*base;
+	const struct hisi_clocks	*clks;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,6 +105,39 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
+struct hisi_clocks {
+	/* if 0, sum all *_num */
+	size_t nr;
+
+	int (*prologue)(struct device *dev, struct hisi_clock_data *data);
+
+	const struct hisi_fixed_rate_clock *fixed_rate_clks;
+	size_t fixed_rate_clks_num;
+
+	const struct hisi_fixed_factor_clock *fixed_factor_clks;
+	size_t fixed_factor_clks_num;
+
+	const struct hisi_mux_clock *mux_clks;
+	size_t mux_clks_num;
+
+	const struct hisi_phase_clock *phase_clks;
+	size_t phase_clks_num;
+
+	const struct hisi_divider_clock *divider_clks;
+	size_t divider_clks_num;
+
+	const struct hisi_gate_clock *gate_clks;
+	size_t gate_clks_num;
+
+	const struct hisi_gate_clock *gate_sep_clks;
+	size_t gate_sep_clks_num;
+
+	const void *customized_clks;
+	size_t customized_clks_num;
+	int (*clk_register_customized)(struct device *dev, const void *clks,
+				       size_t num, struct hisi_clock_data *data);
+};
+
 struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
@@ -113,6 +148,7 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 
 struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
@@ -154,4 +190,10 @@ hisi_clk_unregister(mux)
 hisi_clk_unregister(divider)
 hisi_clk_unregister(gate)
 
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+void hisi_clk_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index 803f6ba6d7a2..bd8e76b1f6d7 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -22,4 +22,9 @@ struct hisi_crg_dev {
 	const struct hisi_crg_funcs *funcs;
 };
 
+/* helper functions for platform driver */
+
+int hisi_crg_probe(struct platform_device *pdev);
+void hisi_crg_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CRG_H */
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17db8b1..c7d4c9ea7183 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+
+#include "clk.h"
+#include "crg.h"
 #include "reset.h"
 
 #define	HISI_RESET_BIT_MASK	0x1f
@@ -116,3 +120,41 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
 	reset_controller_unregister(&rstc->rcdev);
 }
 EXPORT_SYMBOL_GPL(hisi_reset_exit);
+
+int hisi_crg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_crg_dev *crg;
+	int ret;
+
+	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	ret = hisi_clk_probe(pdev);
+	if (ret)
+		return ret;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+
+err:
+	hisi_clk_remove(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_probe);
+
+void hisi_crg_remove(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	hisi_clk_remove(pdev);
+}
+EXPORT_SYMBOL_GPL(hisi_crg_remove);
-- 
2.43.0


