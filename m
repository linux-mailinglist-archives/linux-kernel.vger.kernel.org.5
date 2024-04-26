Return-Path: <linux-kernel+bounces-159468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854318B2EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0551C22596
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67077F12;
	Fri, 26 Apr 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCpL3p5W"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB19763E7;
	Fri, 26 Apr 2024 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102492; cv=none; b=mzmUKpYmw5f8nrORk4lhLEWl2J52SQyX4q5pOE69dqxRVXPscDVSo0sgMYl0D8INqhDfDYadxEeYn+hpJygOzQIB7E+pc0dfj0Ebn7i/PH9Nvrm+kwX8sS2b+zRCOBwBlNM7rzmv5bZYQopNMjKrFS/WhqdhC+4c8ZY63R1Lb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102492; c=relaxed/simple;
	bh=1qkXhGuDwQbkduummPFAe8udiVcUZ0MifdSnhOYj6io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlO78rtlHlHQFoi/vY5vY7ZUXohxzX3iUyI+pKJlzAMZe15rTsjEU4gBiw8ionH9ECCAAUFG9Ao/2xidzrWJBydxXZwClXwotqhi0kHD8QraDrwQ954LeRIEI8ZyHBk4FWQ88/50Vs+ZiuLtsTT4rI7Rs6Zd1yXwXJZuBAnpzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCpL3p5W; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5af03aa8814so1061416eaf.2;
        Thu, 25 Apr 2024 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714102490; x=1714707290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgmkF5ExFKBr8taCn+NKyhoAczSfK0mT7IU3apetrZA=;
        b=hCpL3p5W9WBkJeP2A5niIFS6csSHe5YmMCqJc699qQa7BzUeZrw63Xvp+Ctg9dAe28
         O7jtqJmMQWV82qwjdOsxuXY9k0I89SqQxdVaN1FAvhwegER5J8i28Z8NSHKpRfHpzvB9
         fKF0hrmxhx08MvCAMAWMi1j2C+BFMCJfHHTvvmaB+ahKQuzu5tL2T5QsfoeJy8489nmD
         R91d2asBNEUpTrhnSZ3YHhctqJD3ET2GxJTVAFBlz7y9JLWUuID8qLeac5kt8bbcn1ug
         gzgClrW20hz+pV1LB3NU/zwoRj7qcgOyOs3TM6K8JWk5V0NFHERUBW4hpM0KvUYftgoU
         P9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714102490; x=1714707290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgmkF5ExFKBr8taCn+NKyhoAczSfK0mT7IU3apetrZA=;
        b=JmrhjzLyP02yFZMgCx7lwbeZsMRv8Ug9gthnwHpQifwivwDxOTzqUiJYf70dMdqlWd
         ybtU5HfJMJxeNFH2Fo3qoRAxhuQ/udmaeFRyfn3E4IpE4A+6llDtl7jQxenfvcS3MmSP
         vjXiuY9F8Ec+l6m5pe6Kkvx3m9oSDCv5bkK2AyEAeqH3k1U/qqV/G3ozjT0BUoLSoc5O
         wsMwvwl1GBwj4nlaABh2bYs/Z8EqfsbddZnZKXIccmmwAUAstg5GZwWapfat9/DodAaq
         1yLOtrGsR/JqpOuxVpSjnrdDTInkSXLr/mqMVC3dkAMTynNoUGRL4+hJeZtkpi7D3GAW
         P/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWxvuGmkr2fRXm2A0dyDMWmjWQlE+t1c3XGjznH2n3D8C9Pq0qx+FxWqF8bIrwNyiZ/fATTmmZTroaFSrZNOvBh0C+uQMwqmbqiIrkeIis4FCguwMMNXD2w9q7l1E5cee0mhKEgibC7tEWo6sjc1hF9WWiJxl2IncE28HydivbAUy6nZg==
X-Gm-Message-State: AOJu0Yzz3VBQ+k+6899B6xWt98D4O9aW3whs6azNnyvYz9cKUssL+dnv
	fcR9YvKwBCNZynyRvga0GFZskF4M80wYX9skBOlb6dTz0tINZEKQ
X-Google-Smtp-Source: AGHT+IHkZJwOYVP92ODunaOaPGEtbDE0Xt0KO2mq5AjBnvBEr81zsuQKiTyqUEeSBhqpLn/TcwAZ0Q==
X-Received: by 2002:a4a:abc5:0:b0:5ac:4372:1d6a with SMTP id o5-20020a4aabc5000000b005ac43721d6amr2045385oon.3.1714102490446;
        Thu, 25 Apr 2024 20:34:50 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a09c4000000b005a4b2172e48sm3669260ooa.41.2024.04.25.20.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:34:50 -0700 (PDT)
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
Subject: [PATCH v15 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Fri, 26 Apr 2024 11:34:43 +0800
Message-Id: <937fcaccc1472406638c9231e6f961899abcca9d.1714101547.git.unicorn_wang@outlook.com>
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

Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 49 ++++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..1491fb8ef6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
@@ -0,0 +1,49 @@
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
+  clock-names:
+    items:
+      - const: rpgate
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
+  - clock-names
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
+      clock-names = "rpgate";
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


