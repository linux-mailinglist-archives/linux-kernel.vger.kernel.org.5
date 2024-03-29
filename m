Return-Path: <linux-kernel+bounces-125422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F988925BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF78DB2156D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5F13DDD8;
	Fri, 29 Mar 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="LhGnnDhw"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D258562E;
	Fri, 29 Mar 2024 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745972; cv=none; b=FKrXdngOtsb/yT1bh7hQZZ/Ggy1vSXZKp7StZpLMwztV1u5CEZqTubzI0LUNMahKbkUJokdks906fRuRKIcepmc8grXKtBJhiE3Ko/V2cECbAXQZHv+sV08jun3X8Wl5lo7Vmp4YvTTJgsgkDoTfWxd748NMScpZeTXwRoh37Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745972; c=relaxed/simple;
	bh=qWuf2QAmzhX6TQ1TQr0SalUhDTbpa+yqkeG1xT6aSrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOas78JgJyBNbAvEaiMHGfddKugtBjrsbDk9h6H4auVKzxBO0A94vZzeS6qxe5ReH/FI0tUCHBTE/ECGqPA3e1Fsk86InptnfpfUP56Y3crTNdMc4Ezlad51qTVt72ejck7xClreo3VNw7+Ltu8G/qS89aBTjb3wL4NbXEpu8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=LhGnnDhw; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8184710001F;
	Fri, 29 Mar 2024 23:59:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8184710001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711745957;
	bh=wKonTLmT/lAstuWfOUMJ7juI/CNJuYDUMc9VxZUfnJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LhGnnDhwKyiOWKZfJuSyJGDqfT0S0zmBLtK032Midb6MAKSk00u5rRDDxFwk76Aru
	 Rsaf2hcABtTY5rFPdfEUqZGcAhIpPVA8MAT+G0CwAz8a/8djKLUi+lKxSeYZVmXF0L
	 3ugy+p+a197AooSJMT1M7+yQ2ikfhHAbfod+ib5PxplfVkK/zcmA9AYj2AiJDtTBdm
	 NAmEZieDLtAplalVrroYmu05r3ArlatJ1fxBjYCYbKCT8MqGZQJhPLxAsUwUvbGOi2
	 Q3+W4TbuRP91G+f6Ug2ZLjS/tQmaIgPnJSQBMZOdqEYvK5NH4/XOw52gzNBZQpMA2J
	 IDzpGYw1o9dNg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 23:59:17 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 23:59:16 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 5/6] dt-bindings: clock: meson: add A1 CPU clock controller bindings
Date: Fri, 29 Mar 2024 23:58:45 +0300
Message-ID: <20240329205904.25002-6-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329205904.25002-1-ddrokosov@salutedevices.com>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184500 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;devicetree.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 19:32:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/29 19:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/29 16:52:00 #24511844
X-KSMG-AntiVirus-Status: Clean, skipped

Add the documentation and dt bindings for Amlogic A1 CPU clock
controller.

This controller consists of the general 'cpu_clk' and two main parents:
'cpu fixed clock' and 'syspll'. The 'cpu fixed clock' is an internal
fixed clock, while the 'syspll' serves as an external input from the A1
PLL clock controller.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 .../bindings/clock/amlogic,a1-cpu-clkc.yaml   | 64 +++++++++++++++++++
 .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   | 19 ++++++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
new file mode 100644
index 000000000000..d52d2e084ae7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a1-cpu-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A1 CPU Clock Control Unit
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Dmitry Rokosov <ddrokosov@salutedevices.com>
+
+properties:
+  compatible:
+    const: amlogic,a1-cpu-clkc
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input fixed pll div2
+      - description: input fixed pll div3
+      - description: input sys pll
+      - description: input oscillator (usually at 24MHz)
+
+  clock-names:
+    items:
+      - const: fclk_div2
+      - const: fclk_div3
+      - const: sys_pll
+      - const: xtal
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@fd000000 {
+            compatible = "amlogic,a1-cpu-clkc";
+            reg = <0 0xfd000000 0 0x88>;
+            #clock-cells = <1>;
+            clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+                     <&clkc_pll CLKID_FCLK_DIV3>,
+                     <&clkc_pll CLKID_SYS_PLL>,
+                     <&xtal>;
+            clock-names = "fclk_div2", "fclk_div3", "sys_pll", "xtal";
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h b/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
new file mode 100644
index 000000000000..1d321c6eddb7
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
+ */
+
+#ifndef __A1_CPU_CLKC_H
+#define __A1_CPU_CLKC_H
+
+#define CLKID_CPU_FSOURCE_SEL0	0
+#define CLKID_CPU_FSOURCE_DIV0	1
+#define CLKID_CPU_FSEL0		2
+#define CLKID_CPU_FSOURCE_SEL1	3
+#define CLKID_CPU_FSOURCE_DIV1	4
+#define CLKID_CPU_FSEL1		5
+#define CLKID_CPU_FCLK		6
+#define CLKID_CPU_CLK		7
+
+#endif /* __A1_CPU_CLKC_H */
-- 
2.43.0


