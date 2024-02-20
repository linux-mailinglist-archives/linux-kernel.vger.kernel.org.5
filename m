Return-Path: <linux-kernel+bounces-72246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C585B11E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317C31C2256B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B6433CB;
	Tue, 20 Feb 2024 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkJEJe9f"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43623D7;
	Tue, 20 Feb 2024 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398529; cv=none; b=EPP8o2ShTU31GeY3L9WEvmGJ/PzcP1F7CYrV8i01w2wsNdk4qv2jn8r/Go8uS4ywOaM49ffHmWkmd1Emdcv4O936KOiKKFuLJAxz0QefgMhmPfYdJdeyJTrA+SndVNQuz+o4P0K1R/DJVIL2T0fTCNKQ2fqhrLmDaym2C1bI7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398529; c=relaxed/simple;
	bh=1z2DjnnEUQ8VRVOOj7bX9GFcbA+wqEyxADFf3p99mzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alOyfEjU++D1C0KCHgOLHCIuAzFpx4tiNad2L+YXxDteuCW3vrY05kJBYtzPdTzRnX4o5zwICXBiN5Ww9d8ngYZ6RCgrBMW5LwQqrry64ddPUwSRhR3jTOVbJZiJ9Bvt5xTwoNm4vjZ2QlA5tlCQPTVzyrdyFtICadSteQvJcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkJEJe9f; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e45ef83c54so114147a34.2;
        Mon, 19 Feb 2024 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708398526; x=1709003326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=mkJEJe9fL5O/Yc3zMUSP4IINK3hASRqhutLWANw887Zpzs9+gVXCAxil/pLk+ShbGY
         mLfviV6/wvnDr5LkD0qJGEIuwD3GK+DGh5Kok01EsNnX8hdLP8CKxdUu2e2YK0tr2rfL
         Y87/9QQLIDjONMD+/Lx7VfC11H1LinAlYfryOOnYdqroqQVKtJJrp9jZLCrEYxKRlcSD
         iqOXvGZ3GU7MKEs8rIZDAHe94r0Uh80A6jPPj/2pvrt7q/VPx9if3xlWwwXcyXpWhvSa
         VtP2GbcRSonw3o+Iu2sIO80df5T4VKdYdeNwJPjv0yViNDvv8WCgAP5+jL8LJVey3cRp
         qiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398526; x=1709003326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvyDKytI3LByIiwfwmYUFkoNWJX9ByqcE9gyEaLOuuM=;
        b=Pg9HUcBZm48svtfUksE1k6ewWZluScVlfcD71ph2TMa9Lv137QUYt2mqv6u8gQ2k/v
         iZaoJcIwS705l5IP9U6XPZTmVtzaOrHUBYvztPKDVImW6eVE4jd/5qvS+qdYA92d6lFl
         wffWzZbnkSrng4FCaM75oBbKxXhSD2Dk1n9OvKoZDYwKuZ5QvUBwx0DZaOgtcto6zxyp
         OHUFjU7udkUUYznQJGrNucwioYaT/ANOT/c4WmELqy0RDOdOy8w5KHI3pEzT08vKzAki
         t7Y5KYflYcMhyPukPG1TU5qujGVnpaWXj+a5F7mlliplQudg2p7yIqN2w3+VkPZgeGw4
         ogrg==
X-Forwarded-Encrypted: i=1; AJvYcCWyA7EPJUB4Oiv+Q+KufE6bo9GF/q52gwj8qwNPwlSXKZrVljn+9OPnL3ntungpqK6To2kLpcCOFFevHUpSzGP+OO80UPnQr4g9i8bDW8lBOKC4voV7FYDUR735ELPDl8aNx7etMjqwBJ+RTBJyy/cYUEogzGO6XsD+kcM0r64+E9g78Q==
X-Gm-Message-State: AOJu0Yz8toPWtiZ5ECB4supVCmQ1JU1XKDVjJwH03HhF+OfnkSS6UroD
	VMZIAITq9O7bkez3NhPKC+rr6sk9pciTUzamV1KFLR3I4n1kG60OZuS4x2E2hRU=
X-Google-Smtp-Source: AGHT+IHZPHDxduRznjnFT9HJ9VF/En0gTBhG8lGkybmmExK+w12IUjEuvgusnbsbKQfOQT1nK12MVQ==
X-Received: by 2002:a9d:66c9:0:b0:6e2:f24d:697c with SMTP id t9-20020a9d66c9000000b006e2f24d697cmr16288749otm.11.1708398526492;
        Mon, 19 Feb 2024 19:08:46 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id dq20-20020a0568300ed400b006e2e8cb4da6sm1160483otb.16.2024.02.19.19.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:08:46 -0800 (PST)
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
Subject: [PATCH v11 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Tue, 20 Feb 2024 11:08:39 +0800
Message-Id: <92448a1ca9ad8f713dbdbf3453f1a5db0ca47d9b.1708397315.git.unicorn_wang@outlook.com>
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


