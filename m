Return-Path: <linux-kernel+bounces-62232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74536851D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76F51C224D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852045BED;
	Mon, 12 Feb 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YdZDBNMU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2940BF9;
	Mon, 12 Feb 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763991; cv=none; b=ERifkllIUXACOpzxxpF9Lb/+YTUaBfuJjPy78NgawM/jfPUtOQXU3qkwVlibINVtLPjYq+ky/Zk2UBiw3apK49tsuCkySf3R+EY+/tnaA1nXxTowy9E2/fhj4jRtLMYG0Iih8sGGTHs9i0niCdDhJoKy9JzfDwy7qXLqPLkARJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763991; c=relaxed/simple;
	bh=L1Xv0upbYC1NK7GU2DwkbRMikhm9rpTORFzsKNFZn/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWSV0GIu1z5dloVEhQAn49tEmeAGtqk8RWcsWi+m/P8pDBMkm1GZ/tATjZcakV+pMAx+2jTxFCEkWQy+s+iiO9GzDzQ1nFh7mKsHb93rUks3TThi3qj69QhxZRoWLvaGeFt9qH5vAGDIt38o6kTCXcf8wh13G+E5C4w/2IFla1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YdZDBNMU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707763987;
	bh=L1Xv0upbYC1NK7GU2DwkbRMikhm9rpTORFzsKNFZn/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YdZDBNMU/N5F7/Ba7DqZFY+ypriwyV4u2Dvqc3O8ZsLS8NF6lbMNkS05VkwsOqRWC
	 iEaRgvEemdMbAOXuHgN+qDW8t5IlMwxhjWaQyV8xJna8vqQ6wy7YEJufvLvuAU4jUT
	 yRkG9d3NxGo3K6R0YoXq+BbJF8JUQP12z9WR4JFxJQYqukUZ4r4gGTBpnvTow2S76n
	 ZJ6lSlQiVjjf8PUsyMsNXGN49st6DDILGF3Xv3LjGp5elqQ1q6SiGaLXH8svwBQBFC
	 9677Dx/gQffmrAi10ru9OlaUnwT1QwFiFGKWnOy3acgE+n58T48rpcWr9IrdJ/b4qo
	 7aq3jC5tUwaqQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B67FE3782075;
	Mon, 12 Feb 2024 18:53:07 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 12 Feb 2024 20:52:29 +0200
Subject: [PATCH v3 1/2] dt-bindings: phy: Add Rockchip HDMI/eDP Combo PHY
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-phy-hdptx-v3-1-2cde680cd024@collabora.com>
References: <20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com>
In-Reply-To: <20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, kernel@collabora.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-a684c

Add dt-binding schema for the HDMI/eDP Transmitter Combo PHY found on
Rockchip RK3588 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
new file mode 100644
index 000000000000..54e822c715f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3588-hdptx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC HDMI/eDP Transmitter Combo PHY
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-hdptx-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: apb
+
+  "#phy-cells":
+    const: 0
+
+  resets:
+    items:
+      - description: PHY reset line
+      - description: APB reset line
+      - description: INIT reset line
+      - description: CMN reset line
+      - description: LANE reset line
+      - description: ROPLL reset line
+      - description: LCPLL reset line
+
+  reset-names:
+    items:
+      - const: phy
+      - const: apb
+      - const: init
+      - const: cmn
+      - const: lane
+      - const: ropll
+      - const: lcpll
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Some PHY related data is accessed through GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - resets
+  - reset-names
+  - rockchip,grf
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      phy@fed60000 {
+        compatible = "rockchip,rk3588-hdptx-phy";
+        reg = <0x0 0xfed60000 0x0 0x2000>;
+        clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX0>;
+        clock-names = "ref", "apb";
+        #phy-cells = <0>;
+        resets = <&cru SRST_HDPTX0>, <&cru SRST_P_HDPTX0>,
+                 <&cru SRST_HDPTX0_INIT>, <&cru SRST_HDPTX0_CMN>,
+                 <&cru SRST_HDPTX0_LANE>, <&cru SRST_HDPTX0_ROPLL>,
+                 <&cru SRST_HDPTX0_LCPLL>;
+        reset-names = "phy", "apb", "init", "cmn", "lane", "ropll", "lcpll";
+        rockchip,grf = <&hdptxphy_grf>;
+      };
+    };

-- 
2.43.0


