Return-Path: <linux-kernel+bounces-51191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C884084878F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCFF1C21A63
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBE5FB9F;
	Sat,  3 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCnI7cbI"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E25FB8D;
	Sat,  3 Feb 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979218; cv=none; b=D5M84TNdKAS+FncY7SoODGL8HfO18VjSK65uiNePnEghTWkYe8bIba7dE7tONYeUk1hlX3oKpuIu9CWXhExbVOVBFPnnIBwPt5qzrPu5W/YcA4BFyrG+qnYUMdR0vA5LzwEoh1XHJe9AqvQDlHEsK96/OtFfeHNvcjLBY5rRLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979218; c=relaxed/simple;
	bh=XdBMU2U3PmPxor+o5wCzyesRTy1unhmN54rr7OPAIjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfMa9BI+VRHC37LxG96rs/xgKjfNgXFGEN3wjIHBT2rcQ5ztj2LCV/FKZFvGJeOk6NC0cIYcrB+f4THQijOzulhNcOlfBV1u5JukpVnlqSwwv8M8XvLPWF1kthPXprL3vWMFgzVIYmOrZ07nmMy39cja3pcOMEITPvXrFCbL8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCnI7cbI; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7baa8097064so184916539f.3;
        Sat, 03 Feb 2024 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979216; x=1707584016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkvYfuuKpH2RXM+gZl2DrO4caEYcPakC9a9yPqGZtlw=;
        b=kCnI7cbI39+GZkpuEcE4CYO5Afkj93rl2S8JsKZK8x4ny0pRq2/b8tLSP++ROX+bbC
         j0cw7ZvTANBH1lANrIA0G4KDXUr0Q6hwKSc2JB7RYQGXW4qZEPU+nOBhv4PAZyPwD9PO
         VTl3/zwcxAH9f3aO/2GxaftYIAbONR1dgeeDa14OwHkxIUeGlJaQexwj42clVh1TDrEp
         S5JQhxEwihIwsWCVW3WEcvPUiGi6WpFZyBqVwgVoeagQwdsDocTaka7KKlzsBWWnLKnM
         L4vgjkBNlicH7frL5w8OHZUBEgLpOQLZGIELHZnj86YnljFC/zIC85RF6ZNjLXvqBuuQ
         PHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979216; x=1707584016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkvYfuuKpH2RXM+gZl2DrO4caEYcPakC9a9yPqGZtlw=;
        b=fN4jClsj+r0W/Gq0+assfVBTtBb//KhlAiM+cbJfNueHpQQYxZ5mB1GnMFLbzhraYU
         zNasHx0sg+YmkeB/MWp2z7D46AQEkcQGLEshubR3xQhRxNEjZhz7ixpcgU/7FTtg9Lhf
         q54kEEWPNoae5+KMXyVqL3SDweG15Novkt1yVgp+UBL6e8EvgZSYcnesEPIQtWM/qJqs
         5NzthtJr4fBzS+U3lQQW+3Oxwi79XmfKeTioTpEZ3KqOvWF15KjdPrLwE9SXfmWfyQA2
         ouBv+z/7XkLfIAbxbomAUjhsTWptXgSBl4jWDyBFGvH3KfdG0MYoOtvEtKZLzlGNE2HE
         3rkg==
X-Gm-Message-State: AOJu0YwECMbXBEwDUE6xjTp7o3a9F6cQm1rdAtF6LkNIWlQW29fyvCo3
	Z/QonLamVDo4HUR79tv2QeVxHAFdFhpqqD4DHeIJLQlHeUmTUEXW
X-Google-Smtp-Source: AGHT+IEnlehfxC3EzWtYjfCC3lg1i9dFNOJn0VmenuEK/v0vuI8ECXoRZdHOVhb90XAj8e9K5eLOTA==
X-Received: by 2002:a05:6602:122e:b0:7c2:c868:d864 with SMTP id z14-20020a056602122e00b007c2c868d864mr3311227iot.10.1706979215630;
        Sat, 03 Feb 2024 08:53:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjSq9uyvcTPIb1quTtFSupfo+AL7NwJHi6Gu9nFWWPsmK3n0IEtNuMcvPWgzs9ROEuzmDK7+Wupt2U4qGGShNuzx2ikrWYvZJ/eLQgqMNjsPAmbBFMoOlIfiUgvt9rDcSf90uM05CbsK7HmPlbjA4HdOvDHgzozVjMJ4nYwd3PIt7kwXGtQX+NC0ehIFWD/Iqc3ihmxr3qjqO0ux70S7eSaXSAudI43x6cWqJTIpY9O7Z0EJAQBAerJvvb63N4nuYp0CDntCNnt9jv5xL8UiE2YnKrLFgPQWmetCSi3NNhyIXe3NjiYKKKQjVdr/L6ApH0/1upjtGlWPICCQGcbX+MsVUVWD+10W428nzxIH+5dSaEUNKgA2UXG5O+3x8BPM42Lk1nw6769jHifqDAbmh8oYgREXJt43SEtWs0Q2Kw+8fa29c5MY4eUANjOM2LEd29krLgsvnzynjeAcWOgT2StD4fdgMHOHikKBm0upJuFRx6E24nV2rMqvEYYXlvVptT1CRz0FQaq3BXGZ2/+tYak8y962zSr0Z97YrKXI65juREBPHm/SogAU7MW2Vmz8Bug/jcPZt1ycppSiD3Y3CyVrF9zGlf3Ym+b7QEVGQVh43eY119Xx42CFZZjbRmMfdnRHG7LBZF0uGpH3ekeVHTbnVURFewtaY8GnQvpu/5v7C7deIBXMNhFN4aYbmBMWPdE7xaGuzpxOx85u4690rcnBzSOP37lsU/rU26nkQFukAKLzdkSNZCuiNoN55jijF5Q0zBbV6q5CMc2GY8g3jy0gMHsI2IHqeG+o/JM3vWdqh2gpJDd7rE7ckT5vg27ALY/Y2rER5Tbsanb4jlygSWOkMuURwUEdv0oecCQ2UxmAtpFh68Dr5hso0K9/yy7hag2o9VcCLmnHXBC2VVS4vSWHddjoSYUei0RdcQJO7eNCotvGJXUrv9rha08zAHKY94An
 d4r+OPZZMUhxaoi6lIu2Mv8TVSA6zWR4R7R+d4rA+c/RakQwPr38lbHRVnrC3W7wuFaXfGqiZswJWCs9+HeFccxOyl7VxYNRbbmce3Dyn+5gm+OpGoD+yu7xaaUBGZSoE2L3R/KWDDKIRnq98KiwcqGM1DcpLSTdJq1lC7Ni01p+sRk70WhetbCqzNgP6N/NWFDqhP2I0RhVgFQAw47O++snhkvHAL9d1il3HDdBnzucrXNqTLTuqp8gBJKqbZXj7hqlNYjBjc
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:53:32 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 01/12] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Sat,  3 Feb 2024 10:52:41 -0600
Message-ID: <20240203165307.7806-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

Add a DT binding for the HDMI PHY found on the i.MX8MP SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V3:  Removed mintems at the request of Krzysztof and add his
     reviewed-by

V2:  I tried to help move this along, so I took Lucas' patch and
     attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.

     Added phy-cells to the required list and fixed an error due
     to the word 'binding' being in the title.
---
 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
new file mode 100644
index 000000000000..c43e86a8c2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8mp-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8MP HDMI PHY
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8mp-hdmi-phy
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: apb
+      - const: ref
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+
+    phy@32fdff00 {
+        compatible = "fsl,imx8mp-hdmi-phy";
+        reg = <0x32fdff00 0x100>;
+        clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+                 <&clk IMX8MP_CLK_HDMI_24M>;
+        clock-names = "apb", "ref";
+        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+        #clock-cells = <0>;
+        #phy-cells = <0>;
+    };
-- 
2.43.0


