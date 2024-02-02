Return-Path: <linux-kernel+bounces-49296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A8846853
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C9E28996E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FD17C79;
	Fri,  2 Feb 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evXgYvg9"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A917C74;
	Fri,  2 Feb 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856131; cv=none; b=DlRfEjB7LQUhQn4dvToDdTcL6+wCdMBz9aDy6s3ZBZjqdUEv/V/Xz8JVj35zPnc2f2auowr8Xe9ELCkILpoY6t1SFFgkQB3nJprAbTYBb1r2NWwltDLiz2aI9upeEGjaP5PPjZif2mJIlYKLfC0AMSpTBlYS/X9HTz8oulIBDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856131; c=relaxed/simple;
	bh=zT5I4V5TRXhu2sofdzdOnbRvwMs3CJLr1D64+FxFgjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmT1NuBthN+EdG3gY+j+ecuN0tilgGqHVv6gqi/ad8CgIdXeTaWvh7zCY1jf4iHUtThpteUvkJ6XaahyTz3LQflkvR9s2xEZ0shc+WMvPdnxjyInbx2sVYsDgsyukLBPKIxJvSR9wY+92E6j/7Lwt6LdvT5fmDGRMqV6FbpOZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evXgYvg9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2144c37f3d3so989626fac.0;
        Thu, 01 Feb 2024 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856129; x=1707460929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JELyAKQ1T6IEJZGUW3XWSPZsx7DTHSSDfTD0aj2gLgE=;
        b=evXgYvg9DDTyiIjam6le3KDKIsJBJGijDokIPBqVkP0/PxMgRpastFAg/PzrHMcq24
         mo6yBUqL6hlohnnRYSQf0Xyqux/OCgLlK/AcPU8ecwddi7rarL8nS3RjZQaWFs2HYIAa
         xWWs4vXLlp1xJiHXGkJ/sfDY2clUiMCdH8BZV/Svw3tadeALEvvQJybPG6rCxVC9Ne3r
         hZZPW+5eshZEdA5kZI8jYwby1VxgxgDGiRotlBbT/4ID4sroneKfIs1arVcIZ/Wqt1IF
         zLpvw8W6ukaiAPFoK/hYud5cfwRdZuoDGAh1WBi5W0ISVWaqj+4gxzh69GxZsyua0OyC
         /Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856129; x=1707460929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JELyAKQ1T6IEJZGUW3XWSPZsx7DTHSSDfTD0aj2gLgE=;
        b=A2J2cxOFsHhv17emClnRGXOvOSC4hiwXJmU9KJ/6xREhoF/gc1uzMCHO29vZSOWe9u
         XP69pqSrBC/za8eYPDshbJaEu8unRHOxxJwjbMbizMMGZ6bSWPGhyypK2FosUnHRi7Qm
         kycBYfbCaoQDv1Osm9HF/dGpxvRZpWvB4PBb8znJDITg57wApwXOjzm+TSgeFTEyZQnY
         XaYMA2XjVfgSQti3jKhv3d+GFMhOdG3xohcKu3t47p12IjiB7Nvc47EAOo370OgT5SvG
         PaxlyG4Xjg/IC9W29Z5p+vAybFvTS88kdic2nh6MJ6pk3tuvTI8Tp2bTJceq2QJskots
         nSzQ==
X-Gm-Message-State: AOJu0YxNg9aXMkmOrJfpfXmKRD+Nodr30ppAoCPo+LfFTlbII1QCDZrP
	1zocx57wbYJNRrqaaPjRbxLysQQ+zOTIDJ7Llohw0bYmMirnWlIWvAREkRLX
X-Google-Smtp-Source: AGHT+IE/5mOvGH5pTAcH2qVjRrKDAL20GcPlCBgvs4FtVvidSzrX9acAdfuzBp4cg3qXoTG9JoIoog==
X-Received: by 2002:a05:6870:2387:b0:214:909b:7cb1 with SMTP id e7-20020a056870238700b00214909b7cb1mr1208102oap.16.1706856128966;
        Thu, 01 Feb 2024 22:42:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPkRKLB4qnE+z0c2/4Ek7EJrgZX8srQHblddhG3jldRz3i6qa1Docy6KTzLLDZenEp7mo7egouVDxJXpYGWLIg/3PwxNrJ1mvaLBUVAvzoqcf6CpsH3rWDdlm7RU+i+Qc6RvZHDc514oT7xRe9f4UiBHYumhzfXwOPVNnevjXFJqJKBCZTL/52vEvTG5SzL365P7nR/imO3YNObtvBwq7EGTGPN6n/9CC0C2ppLtiQg9K4WynBwNGDpOpsTRE0RLnp5kZbU/oLJyOlsxi5SDRuh4XeA3EoW6h8/5nQNwAhKiERqgam1B1lMeigZTD2ekUQ0ozpk2hlYC2DlDG9FhBpsK5T/XNbSCHkNZ9N+wU0a+IY3LUUgmf+MyG/pXVquf9orN4Vpm54Q3U2+5WVRtDIWq3ObYWAI8HKESS2VBVnMprgT58ukJOi6//qzTTRAv0F5vTn6+Qu6swBvJ+vld2kfEVM8GpzKU9AGxuggO8a7OFmOeoIB6AehdGlZe2mUHymFmYOzULyDMdktpcGXnEm/jxJ2efS+uowsMQ48yEt2rCbzyzWvQH/eg4Jmbzau48TL4DEfY1rKYuK4LBz+iuZqp4cEm9hJPtrD3c96ORWkdEs1AOAFldqxpc446cpOgi9fsvOqFNM6V84y00cR8yrEte+ewVa0/rRDKTg/5huMA0=
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id lf7-20020a0568700c4700b00218f6d86bc0sm338684oab.22.2024.02.01.22.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:42:08 -0800 (PST)
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
Subject: [PATCH v9 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Fri,  2 Feb 2024 14:42:02 +0800
Message-Id: <fcdd83addcd9af159a0bebf2a14543168bd59a07.1706854074.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706854074.git.unicorn_wang@outlook.com>
References: <cover.1706854074.git.unicorn_wang@outlook.com>
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
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 37 ++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..69ce3a64f66c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
@@ -0,0 +1,37 @@
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
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000000 {
+      compatible = "sophgo,sg2042-rpgate";
+      reg = <0x10000000 0x10000>;
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


