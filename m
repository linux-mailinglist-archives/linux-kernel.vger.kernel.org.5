Return-Path: <linux-kernel+bounces-49294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DA84684C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788F01C2137C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB2717596;
	Fri,  2 Feb 2024 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5sW7cfD"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CA48788;
	Fri,  2 Feb 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856098; cv=none; b=N8vJFCH1WDN8afM39cjh6NDJ9wJEfV52dUbcQWgGBIteRIvndmnGEJpr+uOrSYIHx1d4fhePidtrMPTMmkvXvKZZgRGyOrMV8wMPxWu0JJugyXGnWdG0F+7swz2IsHt3vTizDykD3usv+yZJGhV+IrR42UZVwDpda2qqrZe7MoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856098; c=relaxed/simple;
	bh=FnWjsjwj8800isp2bFvFIFMiFcnzRWHiCH41bnxfCwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlGTxOfVcL1SH1ayq5ToceQ+sa2ClZIN4PRaAvjHnyvBTSJFXAicrQt55wsPXw9dtHe4YD3+wSR2ydXGLUV9UKkOo1DyvqkBxu0X6AT4YQnpqImqjtK0dRMxEbHTV0Sm1oNtqnv65DxczGfLxJkqxLjUPF6HjWsTrL3KPeqWopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5sW7cfD; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2144c37f3d3so989380fac.0;
        Thu, 01 Feb 2024 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856096; x=1707460896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/7Ihe4vPnqb+El0TxxOCHRxUyQil8HxVU+vhaaiIU4=;
        b=M5sW7cfDuayE8gjf3PSbR6cgR9/Gge2XgASzvIjgQ/dt4SVRsj4NQC69bslN7NXzSc
         La3dI+IqSwAg0rCJ8SUnmcUo9a8sOSszdZl4aH77jlBlDvQejQjOWVSTuj3ln8jGglZ8
         2MDvVCJkwJ8aI1VYQ44oXoEpyMzNVVJOphER5zYgD+J+KhP0GhzOZE9FeXrqoyjqIvC8
         nXLOOxHiZm9q9GptSw1O0wCNEl7M6iEkRzy0LTHeLL/s1mE514D1r9wXEP3sVMDcilYN
         tjiZOihnQKOVprwID6Q/zkyrhi1o2EUVUvrpqN2nqbXknHM17L8fIcjM1sEJbAqAlLHS
         L/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856096; x=1707460896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/7Ihe4vPnqb+El0TxxOCHRxUyQil8HxVU+vhaaiIU4=;
        b=KF0lTWdB0XgirbcQ22XjppLvEysKpOww/GSpj/WBD/cgL2g2mVA0GspD92I0XenOKT
         mbGM9AZpZ77Ob4voMCbPFl8sMFsJgZDxjx+JGcqC374t/666iCdzCpWoEJy0isDKRfAJ
         1gMD73Nw+2oFqmGHA1TqDKm4kufgUdAu5zW2Ih4tjhCIJR+S5JtROjK21LmDEkwBd9Lm
         IUfaYIhc6l3TNBPZ/xKoqsjyMBYMeREx0oMzJZvElMCTATt9kvS+McTJX+5Hucj6TZCl
         prDyts9btbZ/DVoXDSZyGxAGxcu3ydJuSyRej/NhISPsau9dcWar0dUUA6+16DxD4uFT
         FOyg==
X-Gm-Message-State: AOJu0YzcKx9JggTSHcUd3alHjrfcDS033Zv6I80WSWkhXOFecarlGrP6
	jhMYXnH8rvBITrIVCO8Lt1jStfQ8NKQcbsY5MaFou06plDw4YnZZ
X-Google-Smtp-Source: AGHT+IHSiFTmHke13wN1SxKcd66FM+K2StullT3LYnHJcbR7rpQ5ZFrlEClwc0zT0kIMT5IkxBOkrQ==
X-Received: by 2002:a05:6870:a119:b0:218:dec1:8330 with SMTP id m25-20020a056870a11900b00218dec18330mr1063507oae.8.1706856096067;
        Thu, 01 Feb 2024 22:41:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9fyP97T4LGPWcPjGEhvjLc+c58XmBo0/gXNEC1NZHfGLci4RzYqgMSvCkP8r6WWKeQ7rFoFtGpwnKpMbt0wCIrhZoIgV1ULFXJqV+EMaX9Xxbids+QPLJ90x0WP7Te/hJovSp9zxHKtUQwuz5Dfm8+98FhhJEJy09Rl8NfghF3w9XRO6mtxdq1Df1JXZ0UWkQtg1+2nCjVv0wIO2DFtGj53Fy9pi3TihN8uPmOGJadRFlUTavMeHu403+hY57YoDLcDbeqrSNXke3rUlt+GzxjjAGnYZ7O0mXmLdp6TG7Q/H7L5iVxUqaDWa0jDEBx18ac77BmzWKfbSDhCvo+rqVxeMOuvgh4mImSKrpVl7D9WcIQMePJDi5G/LYutDX6l/3yGSmrGLcZVxaouXDXVaXNmshRMLPsNZQCaYmw2Xpld5+UFbBThgBBXYqsVsAAtwKa04Nay28Vu9UYdoixkdkOLW3cQYoL+GGjVvhPMWyzSnJg9wx92qqCInTah3uPV5/uKnZ8aycVNNEyjNfuPSIVdvZuP566bNINTOQv07bBKymsvDHBTBQAE7gxqACz0WwDy/2wP3GykpZkXQkKSBMatCXahwyF5NNlgiBceV6ws1EElGHJi9GoF58aR50ERZWFtGyFdghkkBU/RBUSRqmFff7hSYS/0F/vmJ5XmOJxfw=
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id sc23-20020a056871221700b00205d664c127sm335381oab.16.2024.02.01.22.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:41:35 -0800 (PST)
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
Subject: [PATCH v9 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Fri,  2 Feb 2024 14:41:27 +0800
Message-Id: <bf3b8178a013004f259cd9254b13279254505852.1706854074.git.unicorn_wang@outlook.com>
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

Add bindings for the pll clocks for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/clock/sophgo,sg2042-pll.yaml     | 45 +++++++++++++++++++
 include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 ++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
new file mode 100644
index 000000000000..b9af733e8a73
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
@@ -0,0 +1,45 @@
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
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-pll.h> for valid indices.
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
+      compatible = "sophgo,sg2042-pll";
+      reg = <0x10000000 0x10000>;
+      clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
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


