Return-Path: <linux-kernel+bounces-124190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F258913AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9DE1F22B36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE03FB2A;
	Fri, 29 Mar 2024 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awM3v684"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871B3BBFD;
	Fri, 29 Mar 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693245; cv=none; b=MQhuBvC/B6M2zDVr8TW6MPiVSjcx/80iOTFKhPjHPiLQnMH0tTSWB6AHDdSc3Kf2/W1zRI09ZvFUqYCnERh/tQHu6rutTVspWAjwwOtoXxfvsyKAMnWv26swZQMoQ+sxmZHg8sC3ohw3w1tix/OowPY6my3DBHn/CXsioXeM6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693245; c=relaxed/simple;
	bh=1z2DjnnEUQ8VRVOOj7bX9GFcbA+wqEyxADFf3p99mzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDqcv0JyRWMAg2gMRx+GXVdNzZ9HPg5uVTxexI4lPW137T0QxNYQuqHfpEFN5HSSJoPu+2qUGo5IE1S26bs7dppKzWX12zjPlwVKr80lSuvdbU2GsAIKZfOMPfuzczfgtou7j6Yy3Qde0BG3+mhY6S5G96Kb1LHbvHss0Fs1Hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awM3v684; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so970077a34.2;
        Thu, 28 Mar 2024 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711693243; x=1712298043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=awM3v6843pF2QbyZNYEya13y+UK2ZK0g+Z6AAwB7j/39dD8IvLODXm6lBzTT2cKyQp
         9zmvfg+2I84tdXwc9nlpegQ0TNLRiUE7Iq1mWlij8w6ljE3FofrG842R56A/F9UNP39C
         OKZlh9R6ddJGCZIp10cnxryxdUZGK5EMCYTnr8psvyov3Dq9uBox2zslYEzdgIW0ZFCm
         m/mfvS5fG6XkSDrfGEUiMEbtJbh8dkGJ3JVHf+tqG/xGcxSjfHDP73GiyUftR/168Ltb
         VUyjhdSWiEYyB5fZiyPkd4La8IoEdH45Oxa/2SaxK8W0RCTT9v09N21uXRrYII7hz3Rr
         nydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693243; x=1712298043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=hqn2vG6vZMeKxJjH7SLgj0DkeEAEaIjxP+/TgcwIQm1mc6GUG+UDrceOBwwRwFPu43
         JSrxEX/3GYhZVPW+albPjUd4dkR3MX2uXXAG14IPFepSRvPYenEkMkNXUOeBURu+fW0W
         Rdic2FnT845iVr8s71CZrdoNoTdWW5s4hwUsI3sNN2dyLd1KJ1KMQd1lILViwr3ahBz9
         K5tUnL+O7ECI4ue8IB3gkQhWYdsWGk/uCog1M1zMzJ7kNnZya1PrtKZwcQKLKOw9hOz3
         F3oceZ9vh1AyyHkca6vV0KGMUxGn3OHEnMVBs99695iQzcU6bGajS8pvfrUatNR92Vc9
         W6YA==
X-Forwarded-Encrypted: i=1; AJvYcCVYD5qGp1Lg2fu2E7CaZJOrc6DcYAid0wxXP9ZPIgKm0/Hu3GnPGiDqoHAdagHdEdwYBG8DG/dpYZ41iK4zFoAqDlGh/YIBR7TUOVp+zljWWM8VTJgc+IWsGTcLl0sv99BgUjLWmXwLkyKHHUk+VeVVkzwkfI14UEDn7wHAqkZ9JoT0Yg==
X-Gm-Message-State: AOJu0YzshkTWZLvYzAPFBe8DbbCYSF1xUbf/1RziSj0xlVLgC2pwTCnH
	y1Pn3ftpfGhu948Q3V/5Rqzk4zgAYGnCa0+n6+TQJSo+F6JmVBBI
X-Google-Smtp-Source: AGHT+IE1O+Nt490ZqxJttSBxwo/ASQDA0kTVqGNr//Q2tt5IAtxYLP8wY2qulVH41yTGI3nnoq2+3A==
X-Received: by 2002:a05:6830:12ca:b0:6e6:c3f3:a9a9 with SMTP id a10-20020a05683012ca00b006e6c3f3a9a9mr1441289otq.11.1711693243275;
        Thu, 28 Mar 2024 23:20:43 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id a12-20020a056830008c00b006e739aea9dfsm173130oto.29.2024.03.28.23.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:20:42 -0700 (PDT)
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
Subject: [PATCH v13 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Fri, 29 Mar 2024 14:20:35 +0800
Message-Id: <ea7c845ef81a933a4f927f76b69dc6f7a71942c0.1711692169.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711692169.git.unicorn_wang@outlook.com>
References: <cover.1711692169.git.unicorn_wang@outlook.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
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


