Return-Path: <linux-kernel+bounces-163429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ABA8B6AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC70B2158C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C43F9F4;
	Tue, 30 Apr 2024 06:44:57 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D93A29A;
	Tue, 30 Apr 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459497; cv=none; b=tnUje1xf2YTPpdWu7U1OWtM426+kn0FRAgQFi92a/xmYULucea4JsJsXDSlE0YiBxfy79wwAuw0m2DbfX9fIi9S/YZZIu2AZMdMxig9EG4NyLeNxOJv7uUgGmbFkE5y6Sh/SlvUxlcPC86IUb3aXEqcnYre2EyCuYG9STLzd+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459497; c=relaxed/simple;
	bh=5BVnGHdYy8cEptPfnv17u1GRWICYR24sUcPYjqVduO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdKt5PwqxmC/oZbhWFXkiW7qcAcvhlq8tLtdX3nrrtVb2ojI/0YLJrBZJVPM3wzgjOgUhpO5OTkGsItmespMAJVO/4tGandoQlehPA0pyB+LvsH/l0L6I4P1PLVSKR0T2nDdW6MxnecgzqM1mCifjheRYx9WZzJb+CpAnky1Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Tue, 30 Apr 2024
 14:44:52 +0800
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chuan Liu <chuan.liu@amlogic.com>
Subject: [PATCH v8 2/5] dt-bindings: clock: add Amlogic C3 SCMI clock controller support
Date: Tue, 30 Apr 2024 14:44:35 +0800
Message-ID: <20240430064438.2094701-3-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
References: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the SCMI clock controller dt-bindings for Amlogic C3 SoC family

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../dt-bindings/clock/amlogic,c3-scmi-clkc.h  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h

diff --git a/include/dt-bindings/clock/amlogic,c3-scmi-clkc.h b/include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
new file mode 100644
index 000000000000..663c9b349275
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef __AMLOGIC_C3_SCMI_CLKC_H
+#define __AMLOGIC_C3_SCMI_CLKC_H
+
+#define CLKID_DDR_PLL_OSC			0
+#define CLKID_DDR_PHY				1
+#define CLKID_TOP_PLL_OSC			2
+#define CLKID_USB_PLL_OSC			3
+#define CLKID_MIPIISP_VOUT			4
+#define CLKID_MCLK_PLL_OSC			5
+#define CLKID_USB_CTRL				6
+#define CLKID_ETH_PLL_OSC			7
+#define CLKID_OSC				8
+#define CLKID_SYS_CLK				9
+#define CLKID_AXI_CLK				10
+#define CLKID_CPU_CLK				11
+#define CLKID_FIXED_PLL_OSC			12
+#define CLKID_GP1_PLL_OSC			13
+#define CLKID_SYS_PLL_DIV16			14
+#define CLKID_CPU_CLK_DIV16			15
+
+#endif /* __AMLOGIC_C3_SCMI_CLKC_H */
-- 
2.39.2


