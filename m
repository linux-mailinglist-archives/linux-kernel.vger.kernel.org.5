Return-Path: <linux-kernel+bounces-70162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48829859434
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40ED1F213EE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110051848;
	Sun, 18 Feb 2024 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCrdAtmx"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A608291E;
	Sun, 18 Feb 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224700; cv=none; b=URQqfYrYM3ZfI0K+xLGUKnKynTGAQMlyA/yFlrQ9ZFlTpUUtfRVDIHdYvLU+rJQTJexwX6U33j3jI/2tLCgNUy8n8Kv5Fgn8mikcd4AdWm3+U2o/2wCWskr9ik6AYw2iqnNSZzox1jq9+bRJYYIKDJlxkoSz0AHv0Xan6azNNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224700; c=relaxed/simple;
	bh=Jdv+ueWU8b2f02vq2eNrWT39EonYY6w/pwKzOj0RnVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZWHfBUYtjcXRUUSpZiMAtXfYwHHQ/Xf7+jS5jkqS4joyGXNX9T6W6Z5hy3bwArigaFY2B6XnKSxvBD1fieJeQHGlfVM0wZZsmyqlVm8onNmkwcYCsVDH2YwoW3K6Qa6INvZQ7USzZtF/vO7XBlN6ZzoFNY+PolVdLn1InlDcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCrdAtmx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2e42fb159so1624396a34.2;
        Sat, 17 Feb 2024 18:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708224687; x=1708829487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRbrKRI73ofQNYf9+OIxMKDZ+5eOg/Zf/wi3Ry/Msno=;
        b=XCrdAtmxobZLDHVA+ZohoBnasT+fcfggWDFtwyJnDMLN5bYCy9MbwAvJCw+QauxWAH
         layotIvd28STelazu0Oc7YE1e6YbY8Al4rE3jJ6NuYlEte0tuYfIBkf9r/zGVan87emy
         urzcSx6g7rXY3+RFL6K74UWzI+7AjUlY3P/R3u62PXpTYfUOKjYDLVIdWr30jM8IfGc/
         DQNyTyL1Iq7XPHZ58ksD4+sBmvsIPZq2aqtcRYwyzI85o4/ci3R6OfXYxeoAfAKYxTRV
         bvRvzNEyh/a6FuLd/xdGO54QJf68QErALC38qjsw/Kwz9F6ucslb829aLoZmIFuN5fFL
         C3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708224687; x=1708829487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRbrKRI73ofQNYf9+OIxMKDZ+5eOg/Zf/wi3Ry/Msno=;
        b=qzyX3l5zippa6SkuEDQv/HsoCqUEssVXj+O3krqw4xHb+mUDbw0isyzomsIdPBd6tX
         9JR99a6EGgWiYV4x2LKHTknm7Is+HN9iKsNWmiM+LaAIZLVoNthuYJRAl3OMOsG1qDEn
         L5DCsMccLR8HJ4KWLiZKY9jHDOqXSUb8Gsnw7jR7fhGg3MBLdyyjva5Ychf1ufDNqJ+/
         GED0kPKoKmL2fpohkVtWg4mhQi36rq2/HnRu7KGiEaquLNM5hiv8lTVfIhhi4FwH6Dan
         SvK772LPD/1q7gIB+DfvmuzDp286OtGAyi5vf5e50/7eBGwGp69LS6Oy+6AfK9Lgb+s4
         9WqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4VHq7Vi1DX3GV0ZxuwLH1MfvJ+Bx/wQQ0ah/ZYKOyZuEeBucPMZXwOcLpEPbslWYxddyj4ZGQX37zfo47UiO8jZSa+ajsgjUX2wmUaxeanOHEjQE9MB3Ru8SeqCRNPqReGLTGhnZrflaZkiZ2Efr1e/i0IWfFFFZ9D4z0gg+sZ+KePw==
X-Gm-Message-State: AOJu0Yxk57EsfxvId07ZjHV9fQJi/4UVvXrQPuSx2bEIoEnH2lJYWf3Y
	YcdJb5QwuhdzcNpYsE8ro25XO4nR5XGitInSYhPrqmbzcvS1h7d/
X-Google-Smtp-Source: AGHT+IFKhuGzCsSogooNIFE0br2LhsHM/qVBdm4vLuHib6btXsNQPBKCVLsYSk5eUISEGyLgcCSdxQ==
X-Received: by 2002:a05:6808:3986:b0:3bf:dd31:939b with SMTP id gq6-20020a056808398600b003bfdd31939bmr13523448oib.0.1708224687203;
        Sat, 17 Feb 2024 18:51:27 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id fe6-20020a0568082b0600b003c1348f07b8sm465727oib.16.2024.02.17.18.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 18:51:27 -0800 (PST)
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
Subject: [PATCH v10 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Sun, 18 Feb 2024 10:51:19 +0800
Message-Id: <a48dd91d5f9dbb7d25fd6c80ed130dc458ab6769.1708223519.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708223519.git.unicorn_wang@outlook.com>
References: <cover.1708223519.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..5b90325ccf8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-rpgate
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gate clock for RP subsystem
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000000 {
+      compatible = "sophgo,sg2042-rpgate";
+      reg = <0x10000000 0x10000>;
+      clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-rpgate.h b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
new file mode 100644
index 000000000000..8b4522d5f559
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+
+#define GATE_CLK_RXU0			0
+#define GATE_CLK_RXU1			1
+#define GATE_CLK_RXU2			2
+#define GATE_CLK_RXU3			3
+#define GATE_CLK_RXU4			4
+#define GATE_CLK_RXU5			5
+#define GATE_CLK_RXU6			6
+#define GATE_CLK_RXU7			7
+#define GATE_CLK_RXU8			8
+#define GATE_CLK_RXU9			9
+#define GATE_CLK_RXU10			10
+#define GATE_CLK_RXU11			11
+#define GATE_CLK_RXU12			12
+#define GATE_CLK_RXU13			13
+#define GATE_CLK_RXU14			14
+#define GATE_CLK_RXU15			15
+#define GATE_CLK_RXU16			16
+#define GATE_CLK_RXU17			17
+#define GATE_CLK_RXU18			18
+#define GATE_CLK_RXU19			19
+#define GATE_CLK_RXU20			20
+#define GATE_CLK_RXU21			21
+#define GATE_CLK_RXU22			22
+#define GATE_CLK_RXU23			23
+#define GATE_CLK_RXU24			24
+#define GATE_CLK_RXU25			25
+#define GATE_CLK_RXU26			26
+#define GATE_CLK_RXU27			27
+#define GATE_CLK_RXU28			28
+#define GATE_CLK_RXU29			29
+#define GATE_CLK_RXU30			30
+#define GATE_CLK_RXU31			31
+#define GATE_CLK_MP0			32
+#define GATE_CLK_MP1			33
+#define GATE_CLK_MP2			34
+#define GATE_CLK_MP3			35
+#define GATE_CLK_MP4			36
+#define GATE_CLK_MP5			37
+#define GATE_CLK_MP6			38
+#define GATE_CLK_MP7			39
+#define GATE_CLK_MP8			40
+#define GATE_CLK_MP9			41
+#define GATE_CLK_MP10			42
+#define GATE_CLK_MP11			43
+#define GATE_CLK_MP12			44
+#define GATE_CLK_MP13			45
+#define GATE_CLK_MP14			46
+#define GATE_CLK_MP15			47
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__ */
-- 
2.25.1


