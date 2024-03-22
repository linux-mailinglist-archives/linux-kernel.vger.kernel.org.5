Return-Path: <linux-kernel+bounces-111234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD6886984
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C171F22D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC43A8D2;
	Fri, 22 Mar 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqqLbPcG"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413482230F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100571; cv=none; b=Hk7NPEc9i5eDpr2YtwANz2k1vY5dWhjebHH1nm+aM4+5X6ts//lk+oDAdCWB9sbmrKZv0kINDT//+XUAFkwGNCt4RtqS79ag7iOTUKo5zkGwcMGKU3XiN6Rkc427GR+FzKlRfRzB9Z0F4i68TwK9S7QjVP9gw04I2RTmKUV+Sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100571; c=relaxed/simple;
	bh=Wgkq8K/BH0PUUxsRjybtIkIGqB6VHmyut469RqAI4aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ang4xkjtxdI6s90IMEeE7qQBNuhfQ+GcMQJl1B1WkrsMYvBG8FW1e4kz4KNw4GXLyWJnlZonUkkllNTHVSOI4r423N2HkkSJKE/9ziVxeM0bLqXk1u9VmfoDq1X+ICEMb9FtwKuqDVwf2/DgQl50W74ceyfw5UtAPe1ioYFOjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqqLbPcG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41477b68cb5so8235795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711100567; x=1711705367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyHvDf8fEWqU6UqYlpi/je6SVBUw/5SsGYaEGDoEY18=;
        b=LqqLbPcGsXuwCSfxVdp8RsiLwmRtvBZVk6oKRn7/S5Q7HxNlqULT7bbUYn72Y/xuy1
         qod5ScllH1DFoGJCxlH7wWVj3J0WnSIeMdepVgY1T9pU69nevXu+ZFn6rpHsud+Kp6K4
         igX1mK2JaE8ehPdTh7eKTcYlBoDnW5v+nvp+GlZWG3BDz3O5KrMR6TVYmY5S8CquWsv7
         gCWkw3CW2fk6tyniL4oXtTrMHvSgepaNgO3HnWpZUqERm0sqQ4ByTqrxJ1IoUDxfd5HZ
         9QeYj6fFr38wMkXsARToevapGXkhKVGMNLfe9B0ylGtE/IzcVThilcuXVuG67YNp+vLY
         jdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100567; x=1711705367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyHvDf8fEWqU6UqYlpi/je6SVBUw/5SsGYaEGDoEY18=;
        b=kCz4kEJCsn10LwuWsC3UmcQuPlzgXYucg72v0NmiPg8UKUoCoIFFKfM+wjZ2SPAjeS
         du9AY8GX1P9HFtawiSG717UcF4SELn5kgRNdVa1yGKjTMskj8/o1tuwZzgbRDWHv6T1H
         rCR7+zobUHCMkorIpOY0SaxKM2ns5S+wFCaO15d3CJGNKHosTdnXjwD2lNEZ4VUREKZJ
         bFOcj0gQU8XjJdzFRA+cOOzHdAzzT4PlWCQdIhyejQl2h7OolQfy93VJ5jdMErGpBX8l
         c1iqUnanYIEO++bA2jxD4bJTB0uKOyDLoBWiRes/FSQXRB6wkqOCUrskq06QEUg1Jhx/
         AfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX75hUed6qyMpQaUFdoDRa6/LRPRM69bgoIliYSQlwtOJoIID4DnxPu46HmGYoQZZF78VvfmC/yH5PR56yAocibHSprKQJA+LwZEpbs
X-Gm-Message-State: AOJu0YwPsVmfa3vLxEaHjberrgOBwFCYgPhY/NWEuBwBc+hw6E7GANzs
	qduSdUtIDk2BUeETNB/7qJZhRLNePMwLbW1Jp9gEzoVr05pORim6r8ex3z+qV6g=
X-Google-Smtp-Source: AGHT+IE+qonFa8Gh1P6fbjWtJ2kmomG6PZSSMyCC6SQSUHiE2zmjqrzX7S0w5bOjXIlWMLUHhp1KpQ==
X-Received: by 2002:a05:600c:45d1:b0:414:6ee:a37e with SMTP id s17-20020a05600c45d100b0041406eea37emr1055579wmo.19.1711100567479;
        Fri, 22 Mar 2024 02:42:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0041461a922c2sm2547845wmq.5.2024.03.22.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:42:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Mar 2024 10:42:40 +0100
Subject: [PATCH v2 3/7] phy: qcom: qmp-pcie: register second optional PHY
 AUX clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-3-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4263;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Wgkq8K/BH0PUUxsRjybtIkIGqB6VHmyut469RqAI4aE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl/VKRqdA0LPsdrWsSlpEFNnfXmMrvUh3L2mv4/bhD
 mvHF99+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZf1SkQAKCRB33NvayMhJ0crDEA
 C2qDAP55nHvobDnpvRmV5Lgk7OsPnP2UwYVNSovQxL6HRrXOGTpYwM+xkoc5fy/kZu7Tta9mp+Cqmk
 iO9TpQMekRLAjCY79NIDiyme+vKWAWAgq7IuVItSrMxZw3TftsdPy/A0Hx32opJJ+6/1dUN9W8zy34
 RC3Py6mAtbpQHz3BCJM5L9HMi0eBqbfYy8KGWtCw2tF/G7DMQSCmQWViuqt/l8ZihnLjgnZFABuNUn
 aRdEdDx7rpAPNXh/QwQny7DNtNHaxESD5vdu9Vsd5QC4QJn8MGW5wIy0ExHvZrc26dJJFeKOqeI+4/
 chXLpLJ7SLc+4TSMs0pGdjMeSPnWBissjez+nM/Whrp6tKOc6sUGYf+Z7ybZ575M4s0aS6E8Yc7A/S
 HtPsS8yBRDKS+dL5D1L/9h+WHe4l5HwVGeJTZ9tcDysh1dIOOzXOMVhcR8msccf9jiDqmrZK9rQ0rM
 sYioKCcD9qrjaTGrmAyDXpWvRZkNcIpXmNPFAvZKNNko6qiUiKE1nXpv9UUIRAIvXr3PVkpkqOiqd9
 Aq5X9dgc1hqNyv2OSPlaKHJbhtGuSX1nCRzJCr4NXxjG6RUTzNovXBpGDgnYnbX+HEuhliIaF4cp4/
 uVjOZNsae12awZFqVe9jwob1WWTFYLZxNjrQd8xXMPHeH8V9Iof4XqOriO1g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
add the code to register it for PHYs configs that sets a aux_clock_rate.

In order to get the right clock, add qmp_pcie_clk_hw_get() which uses
the newly introduced QMP_PCIE_PIPE_CLK & QMP_PCIE_PHY_AUX_CLK clock
IDs and also supports the legacy bindings by returning the PIPE clock
when #clock-cells=0.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 78 ++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e8da2e9146dc..6c9a95e62429 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -22,6 +22,8 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/phy/phy-qcom-qmp.h>
+
 #include "phy-qcom-qmp-common.h"
 
 #include "phy-qcom-qmp.h"
@@ -2389,6 +2391,9 @@ struct qmp_phy_cfg {
 
 	/* QMP PHY pipe clock interface rate */
 	unsigned long pipe_clock_rate;
+
+	/* QMP PHY AUX clock interface rate */
+	unsigned long aux_clock_rate;
 };
 
 struct qmp_pcie {
@@ -2420,6 +2425,7 @@ struct qmp_pcie {
 	int mode;
 
 	struct clk_fixed_rate pipe_clk_fixed;
+	struct clk_fixed_rate aux_clk_fixed;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -3686,6 +3692,62 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 	return devm_clk_hw_register(qmp->dev, &fixed->hw);
 }
 
+/*
+ * Register a fixed rate PHY aux clock.
+ *
+ * The <s>_phy_aux_clksrc generated by PHY goes to the GCC that gate
+ * controls it. The <s>_phy_aux_clk coming out of the GCC is requested
+ * by the PHY driver for its operations.
+ * We register the <s>_phy_aux_clksrc here. The gcc driver takes care
+ * of assigning this <s>_phy_aux_clksrc as parent to <s>_phy_aux_clk.
+ * Below picture shows this relationship.
+ *
+ *         +---------------+
+ *         |   PHY block   |<<---------------------------------------------+
+ *         |               |                                               |
+ *         |   +-------+   |                      +-----+                  |
+ *   I/P---^-->|  PLL  |---^--->phy_aux_clksrc--->| GCC |--->phy_aux_clk---+
+ *    clk  |   +-------+   |                      +-----+
+ *         +---------------+
+ */
+static int phy_aux_clk_register(struct qmp_pcie *qmp, struct device_node *np)
+{
+	struct clk_fixed_rate *fixed = &qmp->aux_clk_fixed;
+	struct clk_init_data init = { };
+	int ret;
+
+	ret = of_property_read_string_index(np, "clock-output-names", 1, &init.name);
+	if (ret) {
+		dev_err(qmp->dev, "%pOFn: No clock-output-names index 1\n", np);
+		return ret;
+	}
+
+	init.ops = &clk_fixed_rate_ops;
+
+	fixed->fixed_rate = qmp->cfg->aux_clock_rate;
+	fixed->hw.init = &init;
+
+	return devm_clk_hw_register(qmp->dev, &fixed->hw);
+}
+
+static struct clk_hw *qmp_pcie_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct qmp_pcie *qmp = data;
+
+	/* Support legacy bindings */
+	if (!clkspec->args_count)
+		return &qmp->pipe_clk_fixed.hw;
+
+	switch (clkspec->args[0]) {
+	case QMP_PCIE_PIPE_CLK:
+		return &qmp->pipe_clk_fixed.hw;
+	case QMP_PCIE_PHY_AUX_CLK:
+		return &qmp->aux_clk_fixed.hw;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np)
 {
 	int ret;
@@ -3694,9 +3756,19 @@ static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &qmp->pipe_clk_fixed.hw);
-	if (ret)
-		return ret;
+	if (qmp->cfg->aux_clock_rate) {
+		ret = phy_aux_clk_register(qmp, np);
+		if (ret)
+			return ret;
+
+		ret = of_clk_add_hw_provider(np, qmp_pcie_clk_hw_get, qmp);
+		if (ret)
+			return ret;
+	} else {
+		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &qmp->pipe_clk_fixed.hw);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Roll a devm action because the clock provider is the child node, but

-- 
2.34.1


