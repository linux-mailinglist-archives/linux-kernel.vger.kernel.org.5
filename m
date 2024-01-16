Return-Path: <linux-kernel+bounces-27062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CAE82E9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE91F23384
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B810A36;
	Tue, 16 Jan 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhn4+URc"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CE10A23;
	Tue, 16 Jan 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598dfed6535so1388125eaf.0;
        Mon, 15 Jan 2024 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389667; x=1705994467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VdJsBun9ralDbam6fQWSWiTkJ0QQ2v0VG1isrzEFbY=;
        b=Uhn4+URczJWIbZzQy9wehhf3AxkRlncUQjCshc5BB0Ti+Sd9LweXSxgc05sI9kKKbr
         QX3s/ghLWtUW1tLmH7la54A5R4z+qOhFZasjoEtqC/d97X0ID3x+SHMa653yuNykvfZe
         xCmevJMr5WcGzNhp1YRfHY3a83LPYE7X/6E1+R5fq2xqy5o3ncHq5c4gXfllkXE9gx1v
         aM5RFfECt0voTAruYjP/1NA2m/K6ziNW35348Xvs8V1A5MB0MGkzCp5PtWfpSoy1OAc7
         X9G6tOyXY6UfOmV+teAofSJVF/uh4bjC1PSgU/gvTrP6O9z/K5+w1Ap0No+EjSE0O95x
         mduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389667; x=1705994467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VdJsBun9ralDbam6fQWSWiTkJ0QQ2v0VG1isrzEFbY=;
        b=cREVMXQTVqmzD69tJp/XZknkFm5e+3T3uMv3ymIAviVxdON3347pXMxL8LTjn70HWC
         UJW/csP8VTcIKjy3yc+tsmAV9qOhl5I1Gv1T0Z08VsLEw2tnpejLWH1pBqiTu8s+Eqe5
         rG/ZdIde5frxNdrl5AcZ5nOVS7+ewDpvnJFBaMluEWsDCbjjfZR8DNCg3VRlpp1qOlad
         AkB2VukxiSezVChAvCMojpz59FiKHo9PTSaWK8J/ufMlLICOYL4/KEMOWNqCWHgxCB5L
         hRlSLOVIhJOrlVR96j+8Jn1Q1X7kngD+/ZUWe35faXHjWZwzS9zKSxlxgDsdpJ5TxapX
         9TbQ==
X-Gm-Message-State: AOJu0YzXws6KUNjZXc7Uig26X7tw3j2kPHzMetTf5Oo07l++Q+El8Bk8
	tEVve4iFczDYJFT/GiICwl8=
X-Google-Smtp-Source: AGHT+IEUtau+rn47qi3HRqmQHzDvJrSn/jj+5ECcfnyg4F9tUWikFZGdFUmHqWXTUP7JdYXo7Rm7fA==
X-Received: by 2002:a4a:6b48:0:b0:598:2d9d:db46 with SMTP id h8-20020a4a6b48000000b005982d9ddb46mr3444117oof.16.1705389666767;
        Mon, 15 Jan 2024 23:21:06 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id b22-20020a4ad896000000b005990885b67esm436338oov.34.2024.01.15.23.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:21:06 -0800 (PST)
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
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v8 1/5] dt-bindings: clock: sophgo: add sysclk for SG2042
Date: Tue, 16 Jan 2024 15:20:59 +0800
Message-Id: <7071845b8d1ff6aa91112c91feb62bc875066d9e.1705388518.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705388518.git.unicorn_wang@outlook.com>
References: <cover.1705388518.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clocks of which configuration registers are in the
range of SYS_CTRL in the memory-map.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

.
---
 .../bindings/clock/sophgo,sg2042-sysclk.yaml  | 44 +++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-sysclk.h  | 63 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-sysclk.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-sysclk.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-sysclk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-sysclk.yaml
new file mode 100644
index 000000000000..93b0631dcd0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-sysclk.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-sysclk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator in System-Control
+
+description:
+  These clocks have configuration registers in the SYS_CTRL range of memory-map.
+  So the node should be a child of system-control node.
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-sysclk
+
+  clocks:
+    items:
+      - description: Oscillator(Clock Generation IC) for Main/Fixed PLL (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 0 (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 1 (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-sysclk.h> for valid indices.
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "sophgo,sg2042-sysclk";
+      clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-sysclk.h b/include/dt-bindings/clock/sophgo,sg2042-sysclk.h
new file mode 100644
index 000000000000..f7a9fbce16f8
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-sysclk.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_SYSCLK_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_SYSCLK_H__
+
+#define MPLL_CLK			0
+#define FPLL_CLK			1
+#define DPLL0_CLK			2
+#define DPLL1_CLK			3
+
+#define GATE_CLK_RXU0			4
+#define GATE_CLK_RXU1			5
+#define GATE_CLK_RXU2			6
+#define GATE_CLK_RXU3			7
+#define GATE_CLK_RXU4			8
+#define GATE_CLK_RXU5			9
+#define GATE_CLK_RXU6			10
+#define GATE_CLK_RXU7			11
+#define GATE_CLK_RXU8			12
+#define GATE_CLK_RXU9			13
+#define GATE_CLK_RXU10			14
+#define GATE_CLK_RXU11			15
+#define GATE_CLK_RXU12			16
+#define GATE_CLK_RXU13			17
+#define GATE_CLK_RXU14			18
+#define GATE_CLK_RXU15			19
+#define GATE_CLK_RXU16			20
+#define GATE_CLK_RXU17			21
+#define GATE_CLK_RXU18			22
+#define GATE_CLK_RXU19			23
+#define GATE_CLK_RXU20			24
+#define GATE_CLK_RXU21			25
+#define GATE_CLK_RXU22			26
+#define GATE_CLK_RXU23			27
+#define GATE_CLK_RXU24			28
+#define GATE_CLK_RXU25			29
+#define GATE_CLK_RXU26			30
+#define GATE_CLK_RXU27			31
+#define GATE_CLK_RXU28			32
+#define GATE_CLK_RXU29			33
+#define GATE_CLK_RXU30			34
+#define GATE_CLK_RXU31			35
+#define GATE_CLK_MP0			36
+#define GATE_CLK_MP1			37
+#define GATE_CLK_MP2			38
+#define GATE_CLK_MP3			39
+#define GATE_CLK_MP4			40
+#define GATE_CLK_MP5			41
+#define GATE_CLK_MP6			42
+#define GATE_CLK_MP7			43
+#define GATE_CLK_MP8			44
+#define GATE_CLK_MP9			45
+#define GATE_CLK_MP10			46
+#define GATE_CLK_MP11			47
+#define GATE_CLK_MP12			48
+#define GATE_CLK_MP13			49
+#define GATE_CLK_MP14			50
+#define GATE_CLK_MP15			51
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_SYSCLK_H__ */
-- 
2.25.1


