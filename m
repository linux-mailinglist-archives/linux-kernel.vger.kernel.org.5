Return-Path: <linux-kernel+bounces-84087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788D86A218
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E2E284B01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8F153BEA;
	Tue, 27 Feb 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdBFxLk6"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860D14F9FB;
	Tue, 27 Feb 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071503; cv=none; b=ELnQLn+0hoeNU2gHINySJPTiiKk7XZ6c8lxXeY887RRBg03SijA6oACO6kXBCgBgoZmyQW9o9oc51IGFgzDdJOl6pGX7dYfK48TlXo+t1QfiLg0yOs4sRWmBwkX/AZb+Ox0bE10E6xhGBLsENaD18aNOTxhL7UHHXiIbpOVxp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071503; c=relaxed/simple;
	bh=XgqOTJb39qn6qfwvzC4Xjd8T0w2B1vbycueYW2K2slw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBUr3dPWDPLpR8XlD7+4YZBQ3DMbNs4pEonRCXC+cMZeX+tveazaFOpcElrfHVT3Il23dB9VtEtboxqytkgFNYPzjETsjKLktoPiFdmI8bk8qCXrlsXcDi/e1cAikkq48SiGgYKNUdnT4bbiNvXCGWiH9o5mJyLmi0Fj3Y5Aahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdBFxLk6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68fe8e20259so19767636d6.2;
        Tue, 27 Feb 2024 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071500; x=1709676300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENJCVwViqySP78QQC22e16vdfpVFUmVF6XiIGfyzNm8=;
        b=BdBFxLk6E82YXIh93fViarQzNmJss7gV7rbUEewreqQl3tWNf01N3BVGDb7Ml4AA3t
         a5WKsMUZqGWixwDHx73vSFc6aKYwddpe3MxzfgtdboSLb8/aKtfBCQFU0aDBP91HCn4E
         ZiCJDbcZ4qS6BIl4STExprUOwP1cNibYQ7lLSuzBM36jgDl8jtgT/cE4XUROMC3xQTH7
         ski3xf6/OiYk8kNY2au2pVvaM7DO0/RznrH/34yyimvPrd7lIXc5Y+p/mNUtFEgYq8kO
         GtkFeON0sv5xTD9VETaywIkD60O08wfn/BOSv/p6wrUm8lWqUpyMPVO2O9/RoVO9rfg1
         03+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071500; x=1709676300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENJCVwViqySP78QQC22e16vdfpVFUmVF6XiIGfyzNm8=;
        b=Ar05fKZdaiBENd8PZQiE1eKt5+W+v1us0ggE0qfkv692Spk88fFY3IJ+Tx2iABmTxx
         j/q/SvdXgwSut/2Hg94yDGldb2zc6iY8R6DcwRzxM4zKnv50xeIn+CgUQp7ag7v4DX3i
         jSLdxDWJkCNiiMu0uySg3VqZLgB8QBR/s6Id2wiQBXEaAo1DTTvIfTeJ6LMFF4tZggkL
         BLaMfMVNH6IPULzbaRfRhsQavqR2rD2p4ivfOdpav1bifbOpTaBmJqsllzcXtlPskiHN
         Ay1p2Y8CTaL4GWO0Ag9/accpuPC/68Xe+nLMdQYNsQ2jxO8t5B4dJnKfSlyf4xIt27Rn
         1pmg==
X-Forwarded-Encrypted: i=1; AJvYcCW2tH6GU7hc+8rVYeiQbTDXf5RLrd4EdIGhn0haTVZzCZ+g5mNhrf3eepCNM9TMZKDrCqMwkufGktKu6mmQro1S3LuzF1jfCvALsUhW7tANAvs3TkS/HU2a93AmfITRQ1+5sMJnoM+rYQ==
X-Gm-Message-State: AOJu0YyiBmf1K6tOAITdxNTrUsSfd8WZDmBhsXkaUNbk/q//XigfbdIA
	+7CncWXL8QzISgFMiIkPkFXOuYNxTvLBF0bGuxcWobxkaDX0GLOP
X-Google-Smtp-Source: AGHT+IEpZQhtRi5w5yIbBlDmAdFLeORFRaXPwFhoPznALYLBHwR3eVYMv/pDmm9JMFJsmDcE9UXAiA==
X-Received: by 2002:a05:6214:518c:b0:68f:fe7f:abff with SMTP id kl12-20020a056214518c00b0068ffe7fabffmr3307878qvb.19.1709071500273;
        Tue, 27 Feb 2024 14:05:00 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9ee3:b2ab:6ca:180d])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b0068fc55bcf6asm4569556qvl.119.2024.02.27.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:59 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Tue, 27 Feb 2024 16:04:35 -0600
Message-ID: <20240227220444.77566-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>
References: <20240227220444.77566-1-aford173@gmail.com>
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
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V6:  No Change

V5:  No Change

V4:  No Change

V3:  Removed mintems at the request of Krzysztof and add his
     reviewed-by

V2:  I (Adam) tried to help move this along, so I took Lucas' patch
     and attempted to apply fixes based on feedback.  I don't have
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


