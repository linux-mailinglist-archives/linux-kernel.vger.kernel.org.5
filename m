Return-Path: <linux-kernel+bounces-18728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22848261E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738351F21FEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA6101DF;
	Sat,  6 Jan 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7SU09So"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032F101C9;
	Sat,  6 Jan 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36071910050so4006655ab.1;
        Sat, 06 Jan 2024 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579553; x=1705184353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYXO0TXmrPEwqq+/MbuU+qZou0rkBxurEPhJUKxALbc=;
        b=g7SU09Soo/FaLOtSMKq7SLFcaSN/Ws/hkzr4e/gksHQD9MQAgtdqyu2eJY/a7zgbHY
         sM0Lj/vypNBrEAw2LHpd2UmhcQT3EAGPIMKLG22TmLHQlpRkNwC7JbigDS0LXL25VOmr
         vkRQzIQT0YWkbY20ZBMRdJmerHyXPIw0ha0pxnDqYLsKh+0NERbJmMSSBRal3J6H1ECg
         zXWt51/dsnFEPLePFmMHViEoPHotKAmxJOBFk1auowSXfaW9485hRBjkd7SY3iWMM74Y
         KG9XQHZp+neEscSfK16HWawAli1wz+kmA0XJH09j8R0bZbpR7wxp54YRftJz6GheMfCV
         fVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579553; x=1705184353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYXO0TXmrPEwqq+/MbuU+qZou0rkBxurEPhJUKxALbc=;
        b=p/YzMUSu0a0QVWzR/pzIz4vLb2s2M59CmlRkMxJATJ2wPQh2uvOzDTibgeNEukXMg7
         gmi/VFMxmt4XrKB74gOvytcL0i0iQVFBUj2gy1Fx7ksxT7EIWQqCkz8JFbI6bCVV7alE
         vKRyG0dwrK5GoEY9YMv/AeLp5wmWhmsn+G2Fa70RHVvyFifHucNbmCyvWWl/RqJ2MbTO
         NnYWxTOUjVjGX2ca+BowFKDQdePUi4+wUxGXZ7UjsnclK+s488H/vmMHDrflLr/daP6K
         QE6svBvJKreZWCvRwp4sBRfs72pfS25Bq0a2HuuXl0mvAhML+Oku/c4nYrmh+SDp33tF
         qjJg==
X-Gm-Message-State: AOJu0YwqY3RcS2EGVbcMBOPRfNBydbTcfO+E4eH7SmpmvBqs9h+a7Oax
	fKw/uj4FFo1obdzQOOXbX40=
X-Google-Smtp-Source: AGHT+IGIt5Rt7HY/t7nCMCZDgRKKmmyUrOXO7GhHrgaSGRvAS7zb2V9Gd2Gt5+TSM/tEeODoTGFjeA==
X-Received: by 2002:a92:cd8c:0:b0:35f:e0a7:8892 with SMTP id r12-20020a92cd8c000000b0035fe0a78892mr2198542ilb.8.1704579552892;
        Sat, 06 Jan 2024 14:19:12 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:af2f:17f0:33a3:d6fe])
        by smtp.gmail.com with ESMTPSA id i13-20020a92c94d000000b003607ff64574sm679751ilq.64.2024.01.06.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:19:12 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Sat,  6 Jan 2024 16:19:04 -0600
Message-ID: <20240106221907.325127-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
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

---
V2:  Rebase on Linux-Next
     Fix bot error due to the word 'binding' being in the description
     Add phy-cells to the required list

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
new file mode 100644
index 000000000000..d1b941b48151
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
@@ -0,0 +1,63 @@
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
+    minItems: 2
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


