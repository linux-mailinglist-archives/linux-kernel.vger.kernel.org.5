Return-Path: <linux-kernel+bounces-120544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A881B88D926
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB51B1C272D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1048339A1;
	Wed, 27 Mar 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhySJ50O"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003F2E647;
	Wed, 27 Mar 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528212; cv=none; b=cOIwz2q1VLxCko7X717lLJXL9KKF1AXMe37i9jvi21uAaE9EO6i9r3lS9CvxRPKGc8rvtQpXT67uakl/B56yh0IlIlFhVdJzFECCoT4MRu/BKReIbnhppM6cB0eJrghiHmHr0Fm7wcA9cGJk8p/HheaTgFKNNxhpPE+9ZgcODgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528212; c=relaxed/simple;
	bh=R0ygEHJUj8I1NP/GUex190+DSvdj/sG5voRmaHdDgSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKqNSl9rCNXXyO3LZ7+ubkMl/DQA1RV1PnhiFdOLJc8qGLoix/g+YmjmTavPIhVnCRbVR7dCvipNn10waQLhqWAABiJ5Nrs2DPsnzrRntK1VkhG8GBp/prR8DAgqtFjnAcrd1yiTNHwucev45EPmJyNwtNv6fOKZLJ6br+GFy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhySJ50O; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22222357d76so2549223fac.2;
        Wed, 27 Mar 2024 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711528210; x=1712133010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=IhySJ50OMIOx+q0EgZ0VGv8H/sOsBtG4+XU7X/jYFV2OpbpHpjcmp7N/w8at0o5PBQ
         z1EiMI+6XHNSnnwq+GeuKRG9knx+qRCNw+eS64i5QuJYb4WL/IyuhFxKl4LbdViKhI6R
         cJZa4IdS4Z1yoQQts3Xwoz+uqnfP2yxyx8EhR61z5uIt5LWbTCb/UOIxp7zH9jfll+5e
         Zb5N5arqwuUkdNLVjj6KMaAoRpmlvN6RDqWJlADqCqOg4CRwD1BKPIF1JmWXec6r6XCL
         xKegNJNTIWY4VfbhbjEi6Vl9fc9s2wrq0huKbqtT0laydtqanuszb/dRQ1XExyprfe35
         IWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528210; x=1712133010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auVFVf5TZOUclH6ERFg1awZazyADre7qdwcfKdlYJq8=;
        b=PzGaCJSrvUq5N4JfJpdrHUnN/USFFYY54deOo7A7gQp3cODxnp9Sio5OPy5JEuYXTK
         Q+iXQnpzkUGJgWQqwl+C5owxStMgmJdl03DUCUjHLOXd6aRu9HJo/RVy5EuvwcyRgpFJ
         zsBklTuDY0qVkawTDB5uu5YEv3BR/TMbXblpHK0E09o+AgTNSpUsLcvPPM8n1lKvX0d5
         WkMxME+YUxLQ0USl2kK4V4uOcYZ9leS9bseeyRsy0JOgMGnEYZ8b/dmQQ3A7EXWOm/NT
         reKyWrujwO4e9rjAn5JP/tVNY5LbIwbNnN64Dy6TipW3e3goe1T5+HVKo8DpwA30wB6O
         Mufg==
X-Forwarded-Encrypted: i=1; AJvYcCUcLG4bEQygwr09N83YvSusDeH3dZBLjYAEGEmg63DkY6mH9iVlx0bjYZXUj2ZJJIxOw98w+F6mABGJULuksbsS3JfgBVyVd/me1RE4GBd/F38YRAH9TDUtnjqfgMqwq//NuA+X8t9lv4PWcT7JIb8cvMWcLoQSwtCPssuB9L4KjwcTqg==
X-Gm-Message-State: AOJu0YxYbS4tDIjnMk8+VV0fpR0+1ObMR3ckHlW8rz38VALac4FVAh4H
	nrt//mP0W8RyqmfWvChB4xMETnvARXo9WjXguj9y2CwHbpjpaQBn
X-Google-Smtp-Source: AGHT+IGJDU1xid2QssySH1k1Hs1N7muilac+ajQkwpr9hmbgzkFBd+g+QqlCC0idks1XRDqEixq8KQ==
X-Received: by 2002:a05:6870:91d6:b0:22a:1038:39e6 with SMTP id c22-20020a05687091d600b0022a103839e6mr2243406oaf.0.1711528210500;
        Wed, 27 Mar 2024 01:30:10 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id xa10-20020a0568707f0a00b00229f553239esm2752241oab.36.2024.03.27.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:30:10 -0700 (PDT)
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
Subject: [PATCH v12 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Wed, 27 Mar 2024 16:30:03 +0800
Message-Id: <78ddd5b127860e110f4c782de90025153cdba083.1711527932.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711527932.git.unicorn_wang@outlook.com>
References: <cover.1711527932.git.unicorn_wang@outlook.com>
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


