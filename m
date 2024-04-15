Return-Path: <linux-kernel+bounces-144661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99998A48E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5715D1F239DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8C225D4;
	Mon, 15 Apr 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRX5jvM3"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D02C684;
	Mon, 15 Apr 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165772; cv=none; b=J/tZhl8w+5p7cZS7mLVTDI/BTxPQfaA2YLC7MNQKI/wl1NmBVlZymobZ572RHWTUMMjhaDdgIa0/W84/1ufqFaRxV20sGNEnGRn1SIlxHJMX8b74lalWmquWo8fXYnYjmzaU/VUBeV6LaVEJ90oEP1hs88vD0j0A1U+UjKRLhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165772; c=relaxed/simple;
	bh=R0ygEHJUj8I1NP/GUex190+DSvdj/sG5voRmaHdDgSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aq1nXLeUlJwicp3BniRWMLGAnD7Uqlb/eMyVaYFSt1yOqQOhLX+j4rMSTUrGIoBa98bceKhXvHGeYnTXtJGU79FZhJeoTmcWq0joE+M8HzZHk4VO+5cWMzB9l2goXCgdHG3strIC8XKB2qfYjiR/FgNrsvd4TpskC41PNJTL4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRX5jvM3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22fa18566adso1705736fac.0;
        Mon, 15 Apr 2024 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165770; x=1713770570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=GRX5jvM3fDmn/HHCEsHZTfdk+n/tGCEACMsDNQ6Ztp9qBF5cGaAOKFtPsRLkaXXmI4
         VtUxi50bsDGmDLCjazG9GAgeSrNILoWhXqSmWWf+wc2E5FiIjEvqzx757DHGT8sNfU14
         st/81gz/SmQYELbSR0t0g4xELVStC9heAF2ttBBrM9O1v/2hqMdaTpTNB8dQmxruRyvy
         frWPDtz0OLY53JbllrKKszEK+Aev2vIFEdeQy+k9vqCYtv/X8V1b8h5hd6ZkPEPUNKo3
         FyH6TiGY2LkRhb7gFb8rLnD8f569lohXN1LlyZ54ZQp1oaNIKhJ/4Arc5ounpRHU4yxG
         HxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165770; x=1713770570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=Fhl3Q0P276d0dNRIJLbqztEvSrP122RLtAO5nMG1v0c2AW6WVFIZQ9+zr55CD5Sm89
         9VLJb1fhS3iA925Q/LzcqEqa9XTGJvAKyvEKAerQ/LeLrzHyGd4g6eQjKJRsHavMyJ2Q
         KlGx687jPw93I38XxnA1N8nAlLMf2NywIlVmI6+xHNulI8UbC5Rf0CgByHe/yTOUhMtr
         dDzdk34wPGN6SNRq5zI3Y+e52HvhtIkj9xbBkNZrIf9Rq20ybpt8BcUo+INU7D7AM4ik
         1aX9IvCVPYpyF+NauXB8tf3Q4Rg0hNXWKZCcsYJNnifQeN50bJpkeQBBbD6TFern+E7y
         JKgg==
X-Forwarded-Encrypted: i=1; AJvYcCXvY5OQ/ICPu3r1R9OYWZv50j7gRytFHNEIJL9akQ47haQ0Lr4DabUpsTwJ7S+0fDiO1zcqhPG4zGc5g913rsCY5bPCSw9mZf5eTjvjr7xcgptAFqau4UHyiazbgeh3TcgDGwNCyTZ8yKn+T88EFyxa3mVe7ZwoTPQy3DMEJHIAcR4Inw==
X-Gm-Message-State: AOJu0YzLswmWT1XaOhCtx0rZ4OhbJtKTOG4eSzNZ6DU90WMBm7u7gs0P
	r9dR3cGuGi0zoNSnBJrC0RD+8lFHkmDtzY9jPS1rnGtvajn2Kz5X
X-Google-Smtp-Source: AGHT+IEz/GjlH0fOEbVPYAut90pt8Z6EHpVsd6iBbQFqtTiWQCVdYrknq65JKWP4SvMRquSdV92kIQ==
X-Received: by 2002:a05:6871:5820:b0:22e:cd9f:4e55 with SMTP id oj32-20020a056871582000b0022ecd9f4e55mr10941942oac.50.1713165770177;
        Mon, 15 Apr 2024 00:22:50 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id vq4-20020a056871a08400b0022e9bd70567sm2159516oab.31.2024.04.15.00.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:22:48 -0700 (PDT)
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
Subject: [PATCH v14 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Mon, 15 Apr 2024 15:22:38 +0800
Message-Id: <9a6531d35b45ebd1f01e7ec205a1fdd68e771427.1713164546.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713164546.git.unicorn_wang@outlook.com>
References: <cover.1713164546.git.unicorn_wang@outlook.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..9a58038b3182
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
+    clock-controller@20000000 {
+      compatible = "sophgo,sg2042-rpgate";
+      reg = <0x20000000 0x10000>;
+      clocks = <&clkgen 85>;
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


