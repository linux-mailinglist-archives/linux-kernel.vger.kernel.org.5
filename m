Return-Path: <linux-kernel+bounces-159467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644438B2EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFCDB22B59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39876F1B;
	Fri, 26 Apr 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFyeabL2"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FE763E7;
	Fri, 26 Apr 2024 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102399; cv=none; b=BeSwPb9fJFnvazAnxeIdOopfUP0MHeHXrEmDeIXyVwgcHNYcKJXHEIekBKt5zyGvpXt9nw1vicoIOGovLKdgWATDZJpgsG4jD6OtmRQpgN+tGckFiZkakBYc5CR3JBaYc6jV7ASvmA15TqySMItRzrv/KhE51tEnC6IG7AjiG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102399; c=relaxed/simple;
	bh=epuSjPaOnZBTy0eZREg1ERtEbtPRRgAf/3MDZ+G7/RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdmeCyKIWAAKxHVMxq6WlYpHjemj4vlVV7mkCYAcV8p5WePPZwRkvVChoU73AIWX8PDI7h1fbCpEmsnJ7dr6wCXNdJgDoto81o+1uzSrMdiMNtZl2AQ3PrnAWZo5CPYFKa67TTFpYpC4lKI/A4+pgkETWPtPlJ4YEBYyYSZymTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFyeabL2; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac8c73cf88so1075834eaf.2;
        Thu, 25 Apr 2024 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102397; x=1714707197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN8Ys2aOQntChQ4GtaoxJ/3s2pQju6kNm6fRZuDzLwA=;
        b=AFyeabL2FI1VMoiTUeY4Cj81c8vjzceTyXQRzxk8B7nooVcbe6r9AwD23uj+IZT6jk
         VrN24NxjZgLf/gK/CwdU6JShVVw+HdjLWp97NKmA2mn1h74PRgvvQlAMf1NOLiOLDmId
         WWJWaUdJaWaTA82wlIN+AEeIG0h9fwNwTym1L5SoqUlIu5fy0ehlVzsGMmZrD4ALdwde
         p0ZwUZkFth9jDdNZB8lhACrr6Ep1rKtHdi3xdlPlIARX5D23JRbvp16KoQ5GVQOe4NHM
         WukejR8wo5dmB4elwYHit5rZ5Iq8fTQBFg+bltxXfnK7qoO7ssgdBQ6/r+Fgcb6oDH2n
         X1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102397; x=1714707197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN8Ys2aOQntChQ4GtaoxJ/3s2pQju6kNm6fRZuDzLwA=;
        b=vhXoHdQAZRkmNvEpsx5ZhmaTHRe123JJPy3P0c7be+0ChMNopaZyzq2c6FIyFG/Gy4
         3jP/9V/1Oo0ssnw43MgG/ULsCLoSrh7ebxZAt4409sObnsL92GEPIiPZsQs88fcjI7Ct
         3v6VICr/OZaEenfvLbsJtuII5Qpp0yL1rTLZ4oYvIr+X9v3m0MzP+0tWbXZYF/astKWB
         UFqIQoESnwucYcikVI01W9UyWBF84gEnLHMkEtBHc88kxw6Ve8e8X83V7Ifz5RtZgDyM
         jGEA6+6Stjm9PHoGujl3yJAPg96dWtbEiaQwClDW5gBlbRNbnKE2z4YVGP1hiD8o1SDO
         wsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOCfkOKqnuPCB+uKSNhDO1G/lhxOLhBoABUe9dlmZ4d/IRVqXtNMS4PYGGdsTx20ZqtoHhEIKm4PddU4KOJ1UG0imePbWUKeSMcVrQufeB8NVIaHAfWQ2srcvuH/5wL29z+jcPkY1HtNhdyagBqh6KnX0JypKjKGBsDl7tb+c7SaCAqQ==
X-Gm-Message-State: AOJu0YzgOgmRPmeTQlXFrcHNvwrLA0Nd7+FiQzghcbSIQxmYEa7/jObx
	QtB8fN4kpj13H68Hv2HMHeYsUnm2krCf3wTL1EGYefTrBNbf9KKM
X-Google-Smtp-Source: AGHT+IGBhit2AMdMRrXI/PnnkD3xX1lE60E5/6w+cjz/3uPdBCQBPalq6Nvk2aFERnyXDO1SztWVog==
X-Received: by 2002:a05:6870:ec88:b0:233:2541:d7b6 with SMTP id eo8-20020a056870ec8800b002332541d7b6mr1547598oab.45.1714102397458;
        Thu, 25 Apr 2024 20:33:17 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id sl3-20020a056871808300b002399c0f9d5bsm2584161oab.26.2024.04.25.20.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:33:17 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v15 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Fri, 26 Apr 2024 11:33:10 +0800
Message-Id: <6916e570d25a18be28ff47a0c038e8272de89542.1714101547.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714101547.git.unicorn_wang@outlook.com>
References: <cover.1714101547.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the pll clocks for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-pll.yaml     | 53 +++++++++++++++++++
 include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 +++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
new file mode 100644
index 000000000000..1a417a627dd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PLL Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pll
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Oscillator(Clock Generation IC) for Main/Fixed PLL (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 0 (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 1 (25 MHz)
+
+  clock-names:
+    items:
+      - const: cgi_main
+      - const: cgi_dpll0
+      - const: cgi_dpll1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-pll.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000000 {
+      compatible = "sophgo,sg2042-pll";
+      reg = <0x10000000 0x10000>;
+      clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+      clock-names = "cgi_main", "cgi_dpll0", "cgi_dpll1";
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-pll.h b/include/dt-bindings/clock/sophgo,sg2042-pll.h
new file mode 100644
index 000000000000..2d519b3bf51c
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-pll.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+
+#define MPLL_CLK			0
+#define FPLL_CLK			1
+#define DPLL0_CLK			2
+#define DPLL1_CLK			3
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_PLL_H__ */
-- 
2.25.1


