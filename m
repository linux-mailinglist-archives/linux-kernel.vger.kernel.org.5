Return-Path: <linux-kernel+bounces-104963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10487D6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1A8B20CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DF5A4CA;
	Fri, 15 Mar 2024 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F21+zhgN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25485823D;
	Fri, 15 Mar 2024 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541738; cv=none; b=Gn8HvVL2ZvMCKljX8cD0/PzimTsdKi36w5claYzDnKmrFbi273QZqgVUf/lvyW3aB6w19fPgOaKB7PsFnCuRUj3v/zAGBN9ykUai0qGQUFMtiSf25MnUhMSaYZj8hUwd75b+Z0agaX9lC4YuCa0ZY5djvW1pVQudE3N4r7+aV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541738; c=relaxed/simple;
	bh=IqZyr9amdKBauEhJdHCTkXE0YnirulZCw9rxMBb0SnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHph4fm819SBcXSeU27sLoFLHzSSy5tluQHsIhM3cKjk1oXHDtKi+e/T45q2/XxkumgMXQ7XYxPy2B5zgAm5Q8lLGXgDx0opeZZOb3xs+rjcwNJETsxMWT6TBB04AlMBpP+yIA7vY2HW6zoHx9iWN6ndqmvuJy3FiPxYRYUC3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F21+zhgN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so18504671fa.0;
        Fri, 15 Mar 2024 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710541733; x=1711146533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=302kqphgnvloT7tRflp5vmAeTFbHsjR2zeOi1oIAOPs=;
        b=F21+zhgNlX5H7ccq0+w9Ls+ITrIglt7glaIZ4nSnNfpbAdjPDf4s52whkCp4Fa+/m+
         Stu7EjszmCj/ZYQWG2dBgV1Eq1A56zn2qRrDle4D4kMvfezhz1iR61LC8PEL9BckLjqP
         MTMcJThUXnjp1nhAtV3l8n/euaHQcm+ILK0SJFtf3D9ortXRKLiQ7vU/Cx5TcSTk5lni
         pquinVCXYpx+RZYI6+hKwqcuP3LtPQ9MP8eJKeh4fg2/1cxwXk6YDt3SjmsO/JU5rHjL
         EJIYG0cfU04kai17dUNNNVj7ikhu7xtnfScTJclublUlb7sl8vw8a6boFwj9UMHZQqGp
         g2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541733; x=1711146533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=302kqphgnvloT7tRflp5vmAeTFbHsjR2zeOi1oIAOPs=;
        b=jZ0sQr1lvDn/lOAQYXB8LsycLg2PuBEIUK/g+ZEZ+XppMXgrR+YA+3vX1+Pp495PhJ
         7JtzKKNBvoLQqHL3AkvM1vO6Sni6AUImWmaDIuJAjkSJ3iinkrzvUX///XUF7l1pOWM8
         CyD3bgchps30T8WOj90CeQLKhfq5MH+s16oRaCh/t0C4NtKkeDsygEE2bAas4fjQEKKE
         2gbum4CAaxR0QRFJ9Swg5BBO3tI3GahLZV6EJ6vqdoL5peN0pahBijihb9F4GsHz2t1m
         Dl179vP0yqpvGJvwsyJibIIM+PtsCUR6GzDsYY6DYDGgV9otthAmfBV2DTnm1ysvAXj+
         Tc/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwTD+5sJLI7dBoUzbrUFi3qJ7fDHUkFi0pYvUAH9dtaHTDdmFAEiyty/bQjZi1RD2f4yvSs0n0rdNLduPadDzgaIyRzGhjvm9jZCHFiFz+CYtrKoOJhBru58YFfqAW4DPh4S1TCenSrGcLzlofdIAWPEaielq2Iyu08ALIaYjyG2LSYRq9lDprnFJingrSdaqXjvijw5pWLbWOtA==
X-Gm-Message-State: AOJu0YwQ1UTiist6GidX4yhIqCSJlkOfxm7wdSBToCSuJAahdu5H3UPP
	P0H+mJMsYdbI/NboiBSjrhAUFGxrFoaNlCZJIlaA6AAPj6Gr0Wnv
X-Google-Smtp-Source: AGHT+IHcjRin3ixKrRDCEXWR1NTp6DqzyykF1/dJQj9Pfcg3SJc4VnuWq0HeLh8Kw0lcnJE/ychySA==
X-Received: by 2002:a2e:b81a:0:b0:2d2:cb43:bc86 with SMTP id u26-20020a2eb81a000000b002d2cb43bc86mr3340739ljo.45.1710541732845;
        Fri, 15 Mar 2024 15:28:52 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.googlemail.com with ESMTPSA id el9-20020a056402360900b005684173e413sm2039833edb.72.2024.03.15.15.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:28:52 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-clk@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: net: add schema for NXP S32 dwmac glue driver
Date: Fri, 15 Mar 2024 23:27:49 +0100
Message-Id: <20240315222754.22366-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240315222754.22366-1-wafgo01@gmail.com>
References: <20240315222754.22366-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT binding schema documentation for the NXP S32 dwmac glue driver. This documentation is based on the patchset originally provided by Chester Lin [1]. This commit is a re-send of [2] and [3].

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228
[2] https://lore.kernel.org/lkml/20221031101052.14956-1-clin@suse.com/T/#me96c28bd0536de276dee941469ea084d51b42244
[3] https://lore.kernel.org/lkml/20221031101052.14956-1-clin@suse.com/T/#m887a1b34e612f8dc0d5b718e4d6834c083f1e245

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../bindings/net/nxp,s32-dwmac.yaml           | 130 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 2 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
new file mode 100644
index 000000000000..0fbca6ce7d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NXP S32 DWMAC Ethernet controller
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nxp,s32-dwmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: "snps,dwmac.yaml#"
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - nxp,s32-dwmac
+
+  reg:
+    items:
+      - description: Main GMAC registers
+      - description: S32 MAC control registers
+
+  dma-coherent:
+    description:
+      Declares GMAC device as DMA coherent
+
+  clocks:
+    items:
+      - description: Main GMAC clock
+      - description: Peripheral registers clock
+      - description: Transmit SGMII clock
+      - description: Transmit RGMII clock
+      - description: Transmit RMII clock
+      - description: Transmit MII clock
+      - description: Receive SGMII clock
+      - description: Receive RGMII clock
+      - description: Receive RMII clock
+      - description: Receive MII clock
+      - description:
+          PTP reference clock. This clock is used for programming the
+          Timestamp Addend Register. If not passed then the system
+          clock will be used.
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: pclk
+      - const: tx_sgmii
+      - const: tx_rgmii
+      - const: tx_rmii
+      - const: tx_mii
+      - const: rx_sgmii
+      - const: rx_rgmii
+      - const: rx_rmii
+      - const: rx_mii
+      - const: ptp_ref
+
+  tx-fifo-depth:
+    const: 20480
+
+  rx-fifo-depth:
+    const: 20480
+
+required:
+  - compatible
+  - reg
+  - tx-fifo-depth
+  - rx-fifo-depth
+  - clocks
+  - clock-names
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/nxp,s32-scmi-clock.h>
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      gmac0: ethernet@4033c000 {
+        compatible = "nxp,s32-dwmac";
+        reg = <0x4033c000 0x2000>, /* gmac IP */
+              <0x4007C004 0x4>;    /* S32 CTRL_STS reg */
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        tx-fifo-depth = <20480>;
+        rx-fifo-depth = <20480>;
+        dma-coherent;
+        clocks = <&clks S32_SCMI_CLK_GMAC0_AXI>,
+                 <&clks S32_SCMI_CLK_GMAC0_AXI>,
+                 <&clks S32_SCMI_CLK_GMAC0_TX_SGMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_TX_RGMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_TX_RMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_TX_MII>,
+                 <&clks S32_SCMI_CLK_GMAC0_RX_SGMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_RX_RGMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_RX_RMII>,
+                 <&clks S32_SCMI_CLK_GMAC0_RX_MII>,
+                 <&clks S32_SCMI_CLK_GMAC0_TS>;
+        clock-names = "stmmaceth", "pclk",
+                      "tx_sgmii", "tx_rgmii", "tx_rmii", "tx_mii",
+                      "rx_sgmii", "rx_rgmii", "rx_rmii", "rx_mii",
+                      "ptp_ref";
+
+        gmac0_mdio: mdio {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          compatible = "snps,dwmac-mdio";
+
+          ethernet-phy@1 {
+            reg = <0x01>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..e5bf61347b66 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -66,6 +66,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nxp,s32-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
@@ -117,7 +118,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 8
+    maxItems: 11
     additionalItems: true
     items:
       - description: GMAC main clock
@@ -129,7 +130,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 11
     additionalItems: true
     contains:
       enum:
-- 
2.25.1


