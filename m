Return-Path: <linux-kernel+bounces-116916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC988A51D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEF283A64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386261A0B17;
	Mon, 25 Mar 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bS3TlnnG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CD152192
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365001; cv=none; b=UUqcZKyaPEiyc2KzUqXd2agpk5Lvk2sg84mH51JYZsNLOCdeeq48RF7a3NggjL5y2PEROg1btKtUp97luxmV0/l0Q+5SfUAlFIFm0A0t8O4Gwq85NSBM9mRYgV2jXfzbb+HgRinhXJSrj8sVgLPJ5PN0b3N5OSanwuaiA3KNwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365001; c=relaxed/simple;
	bh=Smlla1YZJOXz+za+ZZXCQUR8f4zJcKmwkP7WPfkHnjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlLuhtXzC+fu+2ViW53hVAKU8Z1gvaOdba0fBpgVYREQRk6dNt4q/QsyGLbRUOCNuyzTpayNQ93RUb71Ht+ImV1OmM3wvizAPrIliWS239Wf67+3Q7F6nXkOWDBIr14iXN4PDhfQ+yOqSM/QMQ2IX9a2F3BPlsYBTH/lMsT6ioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bS3TlnnG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso69846966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364996; x=1711969796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IUPR9d02dtJIVzX3UuZrrXfP4OKmNv4PgS6wUBZYrw=;
        b=bS3TlnnGu19jdOgylFyK0VWB1iyLAdTFHOVnDexvxWyG/Elf6dbvlxQFlmui4eOFBj
         CFa1JtfIyozAj3lSLE2ChSUSd3g4RNq6tQL21afkIkKx3BrUzWQWAnvIZV5ODTVUabWl
         f2ryfc9GPNxTdEodoooAU6fgqZbTp5XOI4RTFySFMW4A2syq8KceWj2eqtuCAD1dwZ4L
         w/Mwg2CnGgGPeVwVLtd+HPr6FCSSU3naJxegvzbQcNjcHm4jCbNuiCUOd0iDww1ix0al
         eM33ug4XNXNNoD3GKvbZ17lDoy3vNzO/wt0Kt44v556UJGyjb/ce1komfvBAiRPvPv4f
         QnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364996; x=1711969796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IUPR9d02dtJIVzX3UuZrrXfP4OKmNv4PgS6wUBZYrw=;
        b=rLBkRo2LfbUMNqxwTmQkjmGfEvWJKwHO36/zO/JIpMVHU32zIRWx0CAaQAfZY6zu6V
         ybqvwow1WXIavjJJLijhEDFqo3eO1ypcjNTYHGe0KivDqC1jSqjwZSqsQ0JPpUQOdjCk
         eQx+ol9xGuaqUr8fjKDhBADKLo+PTfrYnnuK0rtF8xDEjAkjG7qibeR4PPBLaNSaUoGd
         3fZeRXCG7crGo9NW2UncxR5Dqg6oXKMioXshXdQ4nXtMS2ydWMT32z10W7AoqqA6QQiz
         ErylOjDaRxZyWp8xSgOmcKE9zgnDkkSOpp3Z8iAXLBiCMvdTUGbE/0W1ThtlVjWRxpj7
         HiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVLl31TbuZlvz+S2uNYeFOVpxomwe93zb3UMgkUkkeOMcgX3QQweNW7/DL81X1LD/Yh+C8Iwi/cOR/4VZwJ1JLWiVuXoCPnbNrVz+RZ
X-Gm-Message-State: AOJu0YwuRGhAPox1KwY80LvotCAojZdt93yU9p3gQkXaUrhSQlhEgkZ0
	3yfibTMkQNJPWpKhrRioFmy943oyDz/FWWFfDG0+7Eoq1bK1Hkkz8fh2ukSxAwhagoG6M/eMfN/
	7pnK49A==
X-Google-Smtp-Source: AGHT+IEDzapRzBUhD8Wikei+Fe01fhmJ44zHGQuzWGYETfbOY6sW484hiwXhMxRzNCWm+NyWQJl15Q==
X-Received: by 2002:a17:907:9487:b0:a47:53b2:2045 with SMTP id dm7-20020a170907948700b00a4753b22045mr2605709ejc.3.1711364995658;
        Mon, 25 Mar 2024 04:09:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b00a4650ec48d0sm2972367ejb.140.2024.03.25.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:09:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Mar 2024 12:09:48 +0100
Subject: [PATCH v11 2/7] clk: meson: add vclk driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-2-04f55de44604@linaro.org>
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
In-Reply-To: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7703;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Smlla1YZJOXz+za+ZZXCQUR8f4zJcKmwkP7WPfkHnjw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVt8lufmJtSUzrk5JX5BRPCbAsKVAfZDz2r2ClgZ
 Lmdr8L+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFbfAAKCRB33NvayMhJ0SMxD/
 9G3+ufv4b2MeR5wblBw1a0iT81X5deO0bxyyUyryPjkStmsKMPVnagRriJT1iNhAlrLLaVdiAjua3u
 vQGdLoV6m45Vg3aO3rV+IQ3XVjrmi3rw7UT2YukMgKrRMQooFilE4+0IEb5H0uN674HF1/Zdab+GO0
 oJa+LxFiin1SjOc+kkTlUEF7dGOfC0AaZGgFM9Z8ubDojWJxhY/G11AN9iABpnBCu44w5gj/EaS4up
 8Co/bHBq7X/eiH8dkillauBRvkzgOlvDJv3NMiYXOh0JeIAuHgGTiuauKX3VOLnaK+VnRX4439w58t
 9jDJSt8hcVq07OnNCeHtj51Kk3ZWIkMSEFZqeo7v2lW78lTjlqjRiBa0NY6/d+Swctqtka8anWo44+
 Exyfxmd+ay1l+U+M+fyK7I6zzT8blI2iCj/D0rBV7Fz3ygOymkgmjX70q/AzOOgUit09rDOq+z4S9w
 bp4LFDtQZ3nh8zuUlgxXQyHHkBtEwFZ1Uj2d5ZDu79zLUhTWj3bWya3g+OVK8HIPEb/oW/xeGwepw+
 wk0mdwuomBydWZG5qmYd3w8gKpyKr6CFzYhI/Mwd4+lr6c1drFEXzjU75wjkwJSfBWNmxXxc5Yui/x
 f1AAjIC6pGeBos9pbkem6atXcG+B0oFgz3vsYdPXjSXRFMFtS3LRUO010ToA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The VCLK and VCLK_DIV clocks have supplementary bits.

The VCLK gate has a "SOFT RESET" bit to toggle after the whole
VCLK sub-tree rate has been set, this is implemented in
the gate enable callback.

The VCLK_DIV clocks as enable and reset bits used to disable
and reset the divider, associated with CLK_SET_RATE_GATE it ensures
the rate is set while the divider is disabled and in reset mode.

The VCLK_DIV enable bit isn't implemented as a gate since it's part
of the divider logic and vendor does this exact sequence to ensure
the divider is correctly set.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/Kconfig  |   4 ++
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/vclk.c   | 141 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/vclk.h   |  51 ++++++++++++++++
 4 files changed, 197 insertions(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 29ffd14d267b..8a9823789fa3 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -30,6 +30,10 @@ config COMMON_CLK_MESON_VID_PLL_DIV
 	tristate
 	select COMMON_CLK_MESON_REGMAP
 
+config COMMON_CLK_MESON_VCLK
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
 config COMMON_CLK_MESON_CLKC_UTILS
 	tristate
 
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 9ee4b954c896..9ba43fe7a07a 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
 obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
 obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
 
 # Amlogic Clock controllers
 
diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
new file mode 100644
index 000000000000..3ea813a0a995
--- /dev/null
+++ b/drivers/clk/meson/vclk.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <linux/module.h>
+#include "vclk.h"
+
+/* The VCLK gate has a supplementary reset bit to pulse after ungating */
+
+static inline struct meson_vclk_gate_data *
+clk_get_meson_vclk_gate_data(struct clk_regmap *clk)
+{
+	return (struct meson_vclk_gate_data *)clk->data;
+}
+
+static int meson_vclk_gate_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
+
+	meson_parm_write(clk->map, &vclk->enable, 1);
+
+	/* Do a reset pulse */
+	meson_parm_write(clk->map, &vclk->reset, 1);
+	meson_parm_write(clk->map, &vclk->reset, 0);
+
+	return 0;
+}
+
+static void meson_vclk_gate_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
+
+	meson_parm_write(clk->map, &vclk->enable, 0);
+}
+
+static int meson_vclk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
+
+	return meson_parm_read(clk->map, &vclk->enable);
+}
+
+const struct clk_ops meson_vclk_gate_ops = {
+	.enable = meson_vclk_gate_enable,
+	.disable = meson_vclk_gate_disable,
+	.is_enabled = meson_vclk_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(meson_vclk_gate_ops);
+
+/* The VCLK Divider has supplementary reset & enable bits */
+
+static inline struct meson_vclk_div_data *
+clk_get_meson_vclk_div_data(struct clk_regmap *clk)
+{
+	return (struct meson_vclk_div_data *)clk->data;
+}
+
+static unsigned long meson_vclk_div_recalc_rate(struct clk_hw *hw,
+						     unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+
+	return divider_recalc_rate(hw, prate, meson_parm_read(clk->map, &vclk->div),
+				   vclk->table, vclk->flags, vclk->div.width);
+}
+
+static int meson_vclk_div_determine_rate(struct clk_hw *hw,
+					      struct clk_rate_request *req)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+
+	return divider_determine_rate(hw, req, vclk->table, vclk->div.width,
+				      vclk->flags);
+}
+
+static int meson_vclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, vclk->table, vclk->div.width,
+			      vclk->flags);
+	if (ret < 0)
+		return ret;
+
+	meson_parm_write(clk->map, &vclk->div, ret);
+
+	return 0;
+};
+
+static int meson_vclk_div_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+
+	/* Unreset the divider when ungating */
+	meson_parm_write(clk->map, &vclk->reset, 0);
+	meson_parm_write(clk->map, &vclk->enable, 1);
+
+	return 0;
+}
+
+static void meson_vclk_div_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+
+	/* Reset the divider when gating */
+	meson_parm_write(clk->map, &vclk->enable, 0);
+	meson_parm_write(clk->map, &vclk->reset, 1);
+}
+
+static int meson_vclk_div_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
+
+	return meson_parm_read(clk->map, &vclk->enable);
+}
+
+const struct clk_ops meson_vclk_div_ops = {
+	.recalc_rate = meson_vclk_div_recalc_rate,
+	.determine_rate = meson_vclk_div_determine_rate,
+	.set_rate = meson_vclk_div_set_rate,
+	.enable = meson_vclk_div_enable,
+	.disable = meson_vclk_div_disable,
+	.is_enabled = meson_vclk_div_is_enabled,
+};
+EXPORT_SYMBOL_GPL(meson_vclk_div_ops);
+
+MODULE_DESCRIPTION("Amlogic vclk clock driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
new file mode 100644
index 000000000000..20b0b181db09
--- /dev/null
+++ b/drivers/clk/meson/vclk.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#ifndef __VCLK_H
+#define __VCLK_H
+
+#include "clk-regmap.h"
+#include "parm.h"
+
+/**
+ * struct meson_vclk_gate_data - vclk_gate regmap backed specific data
+ *
+ * @enable:	vclk enable field
+ * @reset:	vclk reset field
+ * @flags:	hardware-specific flags
+ *
+ * Flags:
+ * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
+ */
+struct meson_vclk_gate_data {
+	struct parm enable;
+	struct parm reset;
+	u8 flags;
+};
+
+extern const struct clk_ops meson_vclk_gate_ops;
+
+/**
+ * struct meson_vclk_div_data - vclk_div regmap back specific data
+ *
+ * @div:	divider field
+ * @enable:	vclk divider enable field
+ * @reset:	vclk divider reset field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ *
+ * Flags:
+ * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
+ */
+struct meson_vclk_div_data {
+	struct parm div;
+	struct parm enable;
+	struct parm reset;
+	const struct clk_div_table *table;
+	u8 flags;
+};
+
+extern const struct clk_ops meson_vclk_div_ops;
+
+#endif /* __VCLK_H */

-- 
2.34.1


