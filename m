Return-Path: <linux-kernel+bounces-82446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F158684B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3105B22025
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3357135A5F;
	Mon, 26 Feb 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU8PAxe+"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AB135A7A;
	Mon, 26 Feb 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991143; cv=none; b=enCzWm2Ny13/JIWUiTQCe4KUHWPIMjPZR6nlccnnV1l6cBQdJwj7qnWP57Kh7VrsxsI/nXCIR66iw17nKtMANq+vcN7i3cqmc/j45lkzg3HblEOR6Es1Ij2e+uiY7torkMAYqGNSa6R0ZjBDDTDincjCWlbNS4iR+Nh06PPz/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991143; c=relaxed/simple;
	bh=XgqOTJb39qn6qfwvzC4Xjd8T0w2B1vbycueYW2K2slw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nnd2HSCbjcKcNF1dgfEl8D04fWaKiBvjffHSwqbLhGV4cHkwCPSDgCz2lnl8QkrRq/bRwk8E5SoERbd2FmnE/ikCLuyCFL23ifXzShSPy096oZJCPxpU2pBfM5QkS814o70N3te2tDItXRZms5F6WbPKKgYFHxCGXLmaT54wbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU8PAxe+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3651d6dea15so12392605ab.1;
        Mon, 26 Feb 2024 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991139; x=1709595939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENJCVwViqySP78QQC22e16vdfpVFUmVF6XiIGfyzNm8=;
        b=EU8PAxe+VgumJUzw7MzB47y5YXZadvE26yszmZtCxus791HV/z7xdqu8Bd7eWVKuTB
         vOY91l7KY6dwCXU44hKv8KhuOPp+3cXgsRnl7TBppKyPbdZGyy1+b651mielcXledxvR
         qpU+keFQ5U/jmJHHRfU/jnOm3gQ4l7PmlReFWjoiZIpy2FVXOB3swSfa4Co677nOhFmN
         bft+IjS2jlbpco/Ow5Gjr/VJokfuiBPz4//VuB5QMedOUZbzvdn1/CXG31sOwXhEOYK4
         lZfVNrDBoeJshC02a8dfR1zS3+9crK2eM0wUEB0DBe+JWqw4Vk9pJsftwy3AJFf9bVTq
         Xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991139; x=1709595939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENJCVwViqySP78QQC22e16vdfpVFUmVF6XiIGfyzNm8=;
        b=RVy2Upt5kLWRuf5Jpe4YFNr4tK9ZQuhjvS3uGGjWPot30Pz1iplS4ygob5JHqIKwxl
         ErFT9jCGdkqziNCCvh6TNetM/ouHix6ae3kj3HWqwyUXy+Xa23xasNBKy7nXMk/k2mDG
         NAAHTQSMljez9eDNWkw0HjUFePpoJG3xkkUt2q+Uy3lSvNtB9zz0UpQ6Q62ZZ5IhUCGi
         Q6PTsrf/NPKgh07pFcJtXyknMtkbLXwAw2XvqjhMBAdtltn/1cm616NhPjxB7dMZBMeT
         gxJnsnSChyfUt9YbxexhTPc65CSh+halQWkj0n01cPbf/gqwM5uE7zdn+nFnfYdes4gs
         zgZw==
X-Forwarded-Encrypted: i=1; AJvYcCUr+Z83Y7mUWplde0dru9oOMPpV+3HJcg3HU5x9fqIAVdo8KLTgktZS7GhYtF2LdJV731iv74JSy/FhMFtkajMxHdKvwWRqE6n7B8TqWLp3XpO6CqxAXXVGinJmArX7UsdY8KjJRHSFng==
X-Gm-Message-State: AOJu0YxwFV4Z1XP48yQP7yQdQs3YAEwPasKeSpL4G7xLCGbZ89N0veW3
	hZpPR/lCpUZJd0y/Xf0tkZd+ad37zrcgytzd/JlX6DqBX2HYGueB
X-Google-Smtp-Source: AGHT+IE0Qm5yQ6rNCxa0d3sGukCo6hDILzXZzbUGhgTRn/EM30OHE3gVJrckX3sKvHnVgYCb1ktBmA==
X-Received: by 2002:a05:6e02:1a45:b0:365:4e45:5436 with SMTP id u5-20020a056e021a4500b003654e455436mr5629213ilv.15.1708991138844;
        Mon, 26 Feb 2024 15:45:38 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:38 -0800 (PST)
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
Subject: [PATCH V6 1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Mon, 26 Feb 2024 17:45:12 -0600
Message-ID: <20240226234532.80114-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226234532.80114-1-aford173@gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
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


