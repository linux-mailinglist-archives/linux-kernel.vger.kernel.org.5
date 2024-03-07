Return-Path: <linux-kernel+bounces-95426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C0874D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25F31F231E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083912A17C;
	Thu,  7 Mar 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moEKhiLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242A1292C0;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811289; cv=none; b=b4TW764U++xTdiYDLcnFNNfwkgprYLN0sJhxm8u7U7w1MC4hUvEYrUAFfzo81dU1YCWyAr1JkcSLlQA7ye4vPpj55KjlLl4xlIyFzO8gM+Ci9xMo3tmQAzohNV9WbnG0Gc2pTBt45no6sAYV2QhUszJ2OKLkXCoycSgmGc7adSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811289; c=relaxed/simple;
	bh=3nX8fP3l7Bt65toEN0CdGwFHFH0sX3inF2oQP8On+7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWZxdC+NjzwhK8fkRhzYH80RfLodMYwqwLUhFKPyqo4AQWdCiFQtlHXvKq7aEzPFyV5K2i+AE+IeUl9P0XZ91uIMKJ2DhlC0H+tMAh3pK7bw2NfEYdHe2lnZA+ntQy/HvdqJbjoq2he+kaiwY8XpkG7X3ezsMYgQzzGFN0b+v2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moEKhiLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F000C43390;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811289;
	bh=3nX8fP3l7Bt65toEN0CdGwFHFH0sX3inF2oQP8On+7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=moEKhiLalkkG+Dnn0B4tI51YGpGaIG8RpdwvzF4sr4Ebxf97hp2Khyo/0R77z1iyj
	 5e8jg012cCCeW2UXt/NG+zIKtXVy/qKgBOMPRRKE7YgCU6NdOOztPI53G5UDt43Wvf
	 0XKF/BDMJFlAtu++weKScc8f4/evdfmeo5bw2f6KwGHiMJO/e1nEgTQzd+ncXSTtVZ
	 05hJ8MBQokoCNpUpfVGYt/vbqwCVRQpKrb8g279Jrnfj/P5MjFiZ3kipAsQlJ2RZbv
	 aXc6pxSHlo6I12A3XmX1mXuz0nVu/XhH166wNAWu34j+f/X+PLwHZEewz+Y+H42nCv
	 Ma1EFmcj5iT8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37783C54E58;
	Thu,  7 Mar 2024 11:34:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 19:34:47 +0800
Subject: [PATCH net-next v9 1/9] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-net-v9-1-6e0cf3e6584d@outlook.com>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
In-Reply-To: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
To: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709811287; l=2517;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=stv+a/mRLJaLswc2WeXjirfjJSRDl5txIs38K87wIhs=;
 b=mlkaqT33wizaPh1Wu7/9X/xSrChk2Hhc0IPoYG5q2GlzqUbGqa1Z5futKoTMzNe71r0kWqtJ1
 p2cLPk9WAQfCOGTBB1Vv4TLA4kZs1TB3VqVssF7GP/YsJWEE+W6z6ou
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

convert the old text binding to modern YAML based binding. No semantic
change.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../bindings/net/hisilicon,hisi-femac-mdio.yaml    | 44 ++++++++++++++++++++++
 .../bindings/net/hisilicon-femac-mdio.txt          | 22 -----------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
new file mode 100644
index 000000000000..36def9d5eecd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac-mdio.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon FEMAC MDIO bus
+
+maintainers:
+  - Yang Xiwen <forbidden405@formail.com>
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: hisilicon,hisi-femac-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@10091100 {
+        compatible = "hisilicon,hisi-femac-mdio";
+        reg = <0x10091100 0x20>;
+        clocks = <&clk_mdio>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy@1 {
+            reg = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
deleted file mode 100644
index 23a39a309d17..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Hisilicon Fast Ethernet MDIO Controller interface
-
-Required properties:
-- compatible: should be "hisilicon,hisi-femac-mdio".
-- reg: address and length of the register set for the device.
-- clocks: A phandle to the reference clock for this device.
-
-- PHY subnode: inherits from phy binding [1]
-[1] Documentation/devicetree/bindings/net/phy.txt
-
-Example:
-mdio: mdio@10091100 {
-	compatible = "hisilicon,hisi-femac-mdio";
-	reg = <0x10091100 0x10>;
-	clocks = <&crg HI3516CV300_MDIO_CLK>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	phy0: phy@1 {
-		reg = <1>;
-	};
-};

-- 
2.43.0


