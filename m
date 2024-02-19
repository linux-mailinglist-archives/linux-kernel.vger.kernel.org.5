Return-Path: <linux-kernel+bounces-71645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B585A849
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149C8B243BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232B3D3A3;
	Mon, 19 Feb 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du7nmEJu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294BD3B79D;
	Mon, 19 Feb 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358996; cv=none; b=Na6MmTjHIO28IvstGC6cFxbDUogfcOP8QHTqvOlaICEXULDFG5l1HPjEEJZoN/q6fezXmJIX39a6jio+Jhdq2q+oxJExfQti5Ddtef7NCMMlE+e9FQnLV1XAKXGUzHdc+yYoEfwm+FdXQgpaJoOvdGapkdQumoazhj5MRnmVAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358996; c=relaxed/simple;
	bh=W9dB3rUMqoNAamOHOS2WOxt7HyATzwndZgN7uhrewD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJw9Cu7hw2EiRZsgH6Rt7v30V3A/FUoldlua9zR827y0g1oJU96d057T3DOVDPUnvTU7c91KGFMRhLO/TA2Xa3H1bvPEGKbe+MIq/22E6gNCm2/Ar7jECHES7ycpUo9GnS0fll7/I5U3nVKsrnfrNC+i3XMUgXy4vI+JslLiTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du7nmEJu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4126ac0c32eso3301445e9.1;
        Mon, 19 Feb 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358993; x=1708963793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh9vUfoHPZFnPPcTVso6vUO3bMJmWkfyYVswHNjvUxU=;
        b=Du7nmEJuUPfY+iSQAsc/JcdIzf7uBi16Y/Tl5VYVARFnn/R7LyqV5QdpqxtT7hZoDt
         WfS/VoGDzEJMVswns3L68hT2GxdbpRytN+EycOiYr6L4sglwr2XO8iamYfFAOGBzEQb1
         2HnzHz9cO7mKTZXTW/zruOoy35thyyRUx2c3XTNoYyTcRQQ46rZTzywGtpMzmJtvaroj
         mfOoywzF4JCw64aYw6Jp5YReWDmVqcvWebjkC6+MJHgTPZKTCMARqBK+GvUCSD3jAGf5
         CrAw2XbUkewCf5MsSluyAgcGkXIEJjehOaQ2o6V1XqZTas/bTb4U6MPvwmKcN40DcmfD
         q0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358993; x=1708963793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh9vUfoHPZFnPPcTVso6vUO3bMJmWkfyYVswHNjvUxU=;
        b=rO9N4+AMvHvlXnQGt9wicbxVlR7sh5kDkXbRE+OWvkPA5wv8oJglNkO/CubNmwkAXf
         dRlaWbuFtnTma8jGSF6/wBJN5+Z1tpxe/7FuV7QzNV4Z4a/V4KfTOOj2JIP/a6rBxncG
         QCb81aJbqifu+S06wNWCzl8WsznUZxuugAISVBlDJnVIkpfA7Py2cUw483tySn9ateHo
         HLdob3XM3j6xDlvg5PiAIdpT+VUPLAdPatrT6h3Y1ScgYLGHj9y82QwzmvGegrevk2h6
         SMQ2FspeUz25g7ICrIcKCCovEFSXAXKpj6YcNrfKjL8QFByR7oIKgMzl8+HPju+iLWeX
         1JNA==
X-Forwarded-Encrypted: i=1; AJvYcCVKYznC4rULt5G1Xky2gQbZwDctwjxHVvYY23DqoiA7+ofmeRiaW449AjfvFL9fi7lFWm9kue2sqzHroMkjYc57X4eDrMqoenyZ4TVCSZngvianKWkyiK19PaVbajo4IDU9X3qYqYISkdJfYctMruuGINAxXzckcg2Hqp6Sb6R0BJpzUNZpXpRiZZsP
X-Gm-Message-State: AOJu0YzpPK7bz02w11TLPD0+LHpvE1Kw2LIt7t5eUkwf0IzUWZfbITRH
	c5Jc+0D6XvaZIdggFmTbAR5bw+qatD62kQBmigiOety3D/+7GV/XGSaTTi/Q
X-Google-Smtp-Source: AGHT+IGwHO1+9bzW+aeUsfuP4YK/bsb8fDl3AXVY3KJdwWdOV6wi0ZHETgfjh87YtN31Ug3+vIUc7g==
X-Received: by 2002:a05:600c:1396:b0:411:d889:f3cd with SMTP id u22-20020a05600c139600b00411d889f3cdmr8958674wmf.34.1708358993362;
        Mon, 19 Feb 2024 08:09:53 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11592670wmi.34.2024.02.19.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:09:52 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P} System Controller
Date: Mon, 19 Feb 2024 16:09:10 +0000
Message-Id: <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT binding documentation for System Controller (SYS) found on
RZ/V2H{P} ("R9A09G057") SoC's.

SYS block contains the SYS_LSI_DEVID register which can be used to
retrieve SoC version information.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
Note, the reset index in example node will be update once the CPG
support is upstreamed.
---
 .../soc/renesas/renesas,r9a09g057-sys.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
new file mode 100644
index 000000000000..ba30d7734ee8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H{P} System Controller (SYS)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description:
+  The RZ/V2H{P} SYS (System Controller) controls the overall
+  configuration of the LSI and supports the following functions,
+  - Trust zone control
+  - Extend access by specific masters to address beyond 4GB space
+  - GBETH configuration
+  - Control of settings and states of SRAM/PCIe/CM33/CA55/CR8/xSPI/ADC/TSU
+  - LSI version
+  - WDT stop control
+  - General registers
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-sys
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Clock from external oscillator
+
+  resets:
+    items:
+      - description: SYS_0_PRESETN reset signal
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    extal_clk: extal-clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <24000000>;
+    };
+
+    sys: system-controller@10430000 {
+        compatible = "renesas,r9a09g057-sys";
+        reg = <0x10430000 0x10000>;
+        clocks = <&extal_clk>;
+        resets = <&cpg 1>;
+    };
-- 
2.34.1


