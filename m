Return-Path: <linux-kernel+bounces-107406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E49387FC01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8248E1C21F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5EC7F483;
	Tue, 19 Mar 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efau+ci0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FA7D401
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845086; cv=none; b=Npu/9AaCCf0TQ8jU+6mSLN6pp6NwFoXuKfX93F2XyIt800EYyvarBrbSdUVD2ZDjlVBfwsi6Yndplhux0HkbgMGzTrYIVqfx3G2Qk1ZO3exEyFgZbH/Nqa1vZ2n+7wzUPdED4xpeSzNPs0fXOOxSpP+VH34/5qI5CepbTB5LsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845086; c=relaxed/simple;
	bh=WsGgAE39xLO1WpNxrXfF0aN/WkAyS4SNo1d7Voxy384=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTIT6pEF0qOjoGsJWwuVsp/c3ds5OQeZ0qomRSqbbOCfgv1TssfcF04Hg1UJ7YR4Ri89G3XnvZTJSHPfhgiHOe8pFPH3njBm1/cvnruDh8eH3SkgW7snwZP3M/k+W3uq6AEwk2aaB0fMlvND0BRk0Gx4KFmaDOSuhmHB3yDu0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efau+ci0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41409fd8b6eso27906095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845083; x=1711449883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaUDxu1aSxyRZXnYFOND1HceBfA/6o9Fk2GBTMCjqhg=;
        b=efau+ci0WufP7mMygXekY6fy7NIRO4WNproaFaPgGndVeWOSMij8hPDEA+WhjMAP+F
         sXqCQ5V4E0seGy7JkOO/D/TH9XOaoLgTu32PfGgIoDTN/2Ut1wSbFJOFXCZX1ikPzcVk
         RrQV9AWA2Ih64zTfvNZrIN56GYQll/vrlfd4pKK+Asu2XJ7CiYlIkxwS9277zqNfnw5m
         horJ31L+AJbRfSHFtNAyizEgfG4i5ngO3cyxLvO3eLQ64Cc01whjJ+tK8oeYhzJ3eyBN
         UyEG1G0VqOXKIY9FLB1UUWzZSAUJW9CISUKclKJxK1NRgQdJblGpkR5syjbSrA1U+8Vl
         HX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845083; x=1711449883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaUDxu1aSxyRZXnYFOND1HceBfA/6o9Fk2GBTMCjqhg=;
        b=FZ2NPGt8XMaqbRMIQEJe2e8+xgiZrV9rMrJBok9tkBRBRIjugV6+igOaouYdU7CId0
         SkjrcOw3W7sKC2fzjA6ZT7H6rqaVxtCr+P+YqibabSVoynyD9QSkuuzQDEQjDzBwS1Hk
         RpR8jRIyyTpMveWpNlGJHZ7+mscbWUBDOxmhJ4K9Jw+yon3McP0RpY4v059GU+bfYkpo
         pPRJ3sZQ9QBFOu2ZQBaNfTaZsGtyhbuGcyIw6QXwaDX/o/nW3yCiyFjWYJXzsH1qGXqA
         14gxOuDaweCXNPcCgD7OEt0RuR03LQrpt496xptmxHph0fgtPc8dawQcPKP2j1oHoEuP
         VyAw==
X-Forwarded-Encrypted: i=1; AJvYcCX20HDDOhdbF5Q1GljzOKmdWX055uVdYYQdWf1irLL0VOVzDQbijvq8bd0LzBrLmS44JSnXd+p/LdbH2lG8kwrC0iuoZ8sSi6+c09Hg
X-Gm-Message-State: AOJu0YylNfQOSfGmK1K4aI0AQD3GabkSYhQ3ZDoM3hFAW3FWcpetqdEf
	p5cjMJleNf0M2bHlrdTFbPrHa60QqIKB5olCAUhZapDq5qF+S8bWR822ie31vm0=
X-Google-Smtp-Source: AGHT+IEI8FAubESL+OiWqRmez4YrJyHkp0zhMaROfLEYoQuQYkJSDscEjausMNnTYtuORRoHxflksw==
X-Received: by 2002:a5d:420e:0:b0:33f:6ec1:56dd with SMTP id n14-20020a5d420e000000b0033f6ec156ddmr7618246wrq.45.1710845083167;
        Tue, 19 Mar 2024 03:44:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4d45000000b0033e03a6b1ecsm12029459wru.18.2024.03.19.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 11:44:29 +0100
Subject: [PATCH 3/7] phy: qcom: qmp-pcie: register second optional PHY AUX
 clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-3-926d7a4ccd80@linaro.org>
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3998;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WsGgAE39xLO1WpNxrXfF0aN/WkAyS4SNo1d7Voxy384=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+WyVxmma2DSKw3/90m56VEW2t4wrDj06AsVmW6xr
 jurjn3aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZflslQAKCRB33NvayMhJ0eJ7EA
 Ci49/QyBonFj6tTlibAF/GecKy1f4werx+qj80VTNMHp4lnZqaFjmcd5Mf36y+mo8ejHbBNVJk448Q
 TXtX8ILRoQzCPl4EhvAJIKLQdqoS9jynPhkVnN/BfMvt4Z3KGwIQGjNCcBjJZJdo2LVBs6qlWGsivm
 Lwru5OgO1kRvo0JYWs9INIqH2Pkua4sen+yy4repsxhxS1+pnY3Cbt+ijHz7Meq/BmJKjQ51iPoR1o
 uoB0Mk9xEPgAHTZZKA214XRQL2UsvUsf3V//3wuHX5Qu5GrEZ2XVNxwDw3hD1gyYFXNNac12iGWVYu
 Xi5pT5vu0HkqR9bGSepW2fKD+rAvqUpWqRJ2MDzSjrtX2i0K/7mQP79ZtZiJ1UQhraZyJkiWmwH44m
 8TAaLzuQhsPoAQtcfCmYnkXI4uU+INxioz23jM1kFZ2tsqevV5Top4womKXrL0xt0FfSDFnerrGWNr
 eqUD1iQ7PYDRYg0qh7O6WpkJHEEOiioIFSmTMBPgAF8/N475ppBZJ8n3HZcTiAOpUdtmFeC9WxHJli
 v1lo+blY9rjF7fmF3Bdf3VOLa7kZ6/esa1aZNHKOlls8R38Bdv6m2Xhr87ZvQZ6tbLSeJTmLkNLMid
 x8sC12HuRi8gFf9hB8eUEj6p813xjDgMr0BoYTnxpBxOP8CvB+bGmMtvTM4A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
add the code to register it for PHYs configs that sets a aux_clock_rate.

In order to get the right clock, add qmp_pcie_clk_hw_get() which uses
the newly introduced QMP_PCIE_PIPE_CLK & QMP_PCIE_PHY_AUX_CLK clock
IDs and also supports the legacy bindings by returning the PIPE clock.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 079b3e306489..2d05226ae200 100644
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
@@ -3681,6 +3687,62 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
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
@@ -3689,6 +3751,14 @@ static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np
 	if (ret)
 		return ret;
 
+	if (qmp->cfg->aux_clock_rate) {
+		ret = phy_aux_clk_register(qmp, np);
+		if (ret)
+			return ret;
+
+		return devm_of_clk_add_hw_provider(qmp->dev, qmp_pcie_clk_hw_get, qmp);
+	}
+
 	return devm_of_clk_add_hw_provider(qmp->dev, of_clk_hw_simple_get,
 					   &qmp->pipe_clk_fixed.hw);
 }

-- 
2.34.1


