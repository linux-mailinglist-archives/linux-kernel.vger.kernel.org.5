Return-Path: <linux-kernel+bounces-72247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACEF85B121
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9646F1C21D47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99B433CB;
	Tue, 20 Feb 2024 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edAMSc4Y"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94B3EA64;
	Tue, 20 Feb 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398549; cv=none; b=O3WgTdc5czApTsGryWhO9YJfzMd+kw43pTVUPt0yTkgrN341HpkIp1GSPH7k//bmOpevsL1BBAj4g8OjLipyo58I6jEBBNqSB/J/VPhhFuoT5hQiQ/hqgryvfA9QoYIshZCBkiHXXjNQxs3DSdbtPhxos2vSkmmbIJJq+yia5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398549; c=relaxed/simple;
	bh=jF9yyA2sxGXqIZo+yklQ1iTLf7X16ewH9pEH6J9E1xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg53pgwGMS+1bXcPvPrLv170ZSCqZYNC9xYcZKrYMernch4ZF61del7COq0UjUHvJT7bjoyabT5lP9peDqjbZyZwF+vuxANu+RAVQucgmN9n4rrb+k0p5aSlHDWeqOVXYEGk+2I+uz353H8jthpJWPM+EqB+3hP6VrMcKakLX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edAMSc4Y; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21e9589d4ffso1042837fac.1;
        Mon, 19 Feb 2024 19:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398547; x=1709003347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkgZ0brSHMcJ6vLWoNuANGTzYAm5g8JP8scMBBfVgfg=;
        b=edAMSc4YP7DfkMSd3Edevtm8s10nBlfRQn/o+A/qHdUDtR7IzUi9tnSzLrpo7/2cnp
         ZX+R7LAfOQQ8p6apqgeftDc9Aq5rPBVgehsCBMOl61tdWFuwDGSUAO1XFvEVAWK6gUcR
         hofq3iXtRP9y7EUapPIdO9gnmFGqGdRwLEnizvWC4g8syhWtJSZFJ8WBgXsB8IRQ+YBu
         sf0oxY4DEW3Du4udghhCURUWgT2Xdm2yccxKnw6TzRxuAc6fjyecVu6lKyfBNzXeOB6t
         z/f8nEpJ0PKMwD/AfQmUcNAph+JBItheCgK19MoET2Xa81nT3BokPUxKdx3CcYZBN2F+
         bLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398547; x=1709003347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkgZ0brSHMcJ6vLWoNuANGTzYAm5g8JP8scMBBfVgfg=;
        b=D+iyoHIMigtsuR6DJ4uimSKp3O6zVtAriFR/MhvrLZ3HpGspIzexLc/QJS9Pj8OlgJ
         gBgJJpb6vft7/7y8G5xb0j8P4cxj2HAO9SUiBzFH+ip75Pf8RbNWGQlsXVhKLgPoUPol
         h1Fy2fs0h846HidX0ax0TLAkyk1PbLnZ6q4bmHzJOkocXiINsDg82BGDb8WKympxiu8+
         UXvQrOhYu0RyEudCK5CzO+uy3lQ3/TxN/LpAXfiHJeesy2PiGUi8QfZtTxNE7oMJUwET
         H2TfwQkko00+SqOvWillCCvCtDF7iXWsIXD7ndbfYZUx063FVacsn1YH33DYEdYmeNQG
         eg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXgE2ID/efujdYehl89Yvpj4tCYskqtnu+JEEpP3b6e+zRIuxljVOdqQV8e52nKx8GQ+bFyMGLHAEnTSwGOIbDOxa05lwHrKy09hRNAgzqwtUA+nT9v+TL1E8H+lhY8mcIzHMgY+p6ulWPEURyxFoo8/bwJNxlh1eFa2lwyomADjNG1Dg==
X-Gm-Message-State: AOJu0YysTCqI20GlRYJGvssrTbftTHVfapNM710miytyPYUXJGHa57Vw
	O3iKHDkfgyY5O0UP1hjYLBHuOpFCUUK72IVZw4nlSyoChOcCAldi
X-Google-Smtp-Source: AGHT+IF/5/Qao1ubBVUJqn7zPUt32ZBx86tloI6CxK0c4cOMuM6NlgnTRnOp4KPXJ4JSjWe/pvWQOA==
X-Received: by 2002:a05:6870:1656:b0:21e:5fe2:2143 with SMTP id c22-20020a056870165600b0021e5fe22143mr9914011oae.58.1708398547247;
        Mon, 19 Feb 2024 19:09:07 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id pf7-20020a0568717b0700b0021eb31be7b6sm1149713oac.14.2024.02.19.19.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:09:07 -0800 (PST)
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
Subject: [PATCH v11 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Tue, 20 Feb 2024 11:08:59 +0800
Message-Id: <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com>
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
index 000000000000..9d4b55e2b12f
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


