Return-Path: <linux-kernel+bounces-27063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45BD82E9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890C01F21FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B010A36;
	Tue, 16 Jan 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRBJXYKB"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818EB10A21;
	Tue, 16 Jan 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-207f801a0a4so1312129fac.1;
        Mon, 15 Jan 2024 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389683; x=1705994483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXfVxRdbpg0Jjrtfyh2r9z1d0R31xJqLPqzwKtIlUvk=;
        b=mRBJXYKBzQMVxgFm4n1QuCw6BKYYhmaNZAUBuEMmo3HG3nNG0sT/FdFXIGX2r/587z
         /Lhjxo51hvUF2QiceIHLS+7ZDcZtuKFc3/DVeNdgbvxQ6BXlC1eZuc/SDAT8PGkkVE8m
         wHzwOQYfP8MS6vNClyPfHTsMXYEiS/pl5kPPlDFV+jBb51bOzSDqntkP2IU3RTGT3fPc
         6ca5/ViG+CgdLJFDGaytMjzrjHsuglIPmUH15P0IAUGONOjW8KcJoSILtcjM7axPFVmJ
         pRW9/55LGKZcxQD2QXrUjJuOCLe5UaY4yyBVwdU916ymSJjCvj2TBQ5TSwOrj3qJERuB
         0XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389683; x=1705994483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXfVxRdbpg0Jjrtfyh2r9z1d0R31xJqLPqzwKtIlUvk=;
        b=K0SiCkN0uy5X38XIlLE0z2muZxu1rbjFBCFHX6M34zH9BHuo1KhvEK3AyeEy2szDM1
         ZIT/ewFGUZZP05x2YRZm0SEEy4xHJkS+bBP0hWbG1Tvf3WCtvyANjAsfjS7rtLpHb8Dg
         tG4djJChhXqMJhyN9GbTC+8r3KlaaOi7soNGcloNePTkRkUQnyb18A+JpUjzuuYQ521l
         7uD3yqJrGQUxKTKoFY6tYlsZwh3NqGrvzIj8SB7XTMxYaEJgeLzOFNdg6Nsb2btGcciS
         9t1CMqVK0OWQdUIXwthjua/rDApLFCakxLfmjli7uMeQpj3M9fjVAhxdsn+EOtRqyHfa
         te3A==
X-Gm-Message-State: AOJu0Yz+yLfKiEKGGl4oRqdSEwWYnfEhbu7yhGkEfYGXU2MdxwABXttB
	N7wZ3Lt7t5VbWCEMPZRzGuI=
X-Google-Smtp-Source: AGHT+IEqnaLXbDXCKsVUX+dGxbBp16mJ7jqRodrtJ/NsEB25oY5Lw0WW7mN4rWbYMPov1atd2HQ2RA==
X-Received: by 2002:a05:6870:a10d:b0:203:e9cc:486e with SMTP id m13-20020a056870a10d00b00203e9cc486emr8835946oae.107.1705389683421;
        Mon, 15 Jan 2024 23:21:23 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ds13-20020a0568306c0d00b006e0c65ba0b4sm253289otb.13.2024.01.15.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:21:23 -0800 (PST)
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
Subject: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system control module
Date: Tue, 16 Jan 2024 15:21:15 +0800
Message-Id: <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
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

Add documentation to describe Sophgo System Control for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
new file mode 100644
index 000000000000..7b50bb56b4cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 SoC system control
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  The Sophgo system control is a registers block (SYS_CTRL), providing multiple
+  low level platform functions like chip configuration, clock control, etc.
+
+properties:
+  compatible:
+    const: sophgo,sg2042-sysctrl
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    # Child node
+    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
+    type: object
+
+required:
+  - compatible
+  - reg
+  - clock-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    system-control@30010000 {
+        compatible = "sophgo,sg2042-sysctrl";
+        reg = <0x30010000 0x1000>;
+
+        clock-controller {
+          compatible = "sophgo,sg2042-sysclk";
+          clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+          #clock-cells = <1>;
+        };
+    };
-- 
2.25.1


