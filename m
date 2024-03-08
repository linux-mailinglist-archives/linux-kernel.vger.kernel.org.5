Return-Path: <linux-kernel+bounces-96671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D87875FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561D6283410
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFEF535D2;
	Fri,  8 Mar 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUki9uYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840D2E85A;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887185; cv=none; b=c3dUMFJ659a9pMW74cDmqriUKbD8A/h9ZPAiwkfWDe9GegZJ/83bpIZXMbV3Z+JC6wek6qWdjHA0SNJXqTQwnhuzXUSgbyH2DJEMFBw0c9XxDa1j3sPSVAzkHdo9+mQxth7MbZ9SvZsO5CwZYYIKLwmCp5qP4DkTrqJb83XUgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887185; c=relaxed/simple;
	bh=3nX8fP3l7Bt65toEN0CdGwFHFH0sX3inF2oQP8On+7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxDX7dVbMlY/XRRz+8s0gG0fNBCNtdzxmCd69pJZiF9pwhl0jthJXEQiNptxZtnXJ4QC+ZmtwRUMU9qAViMRTF2Pez7t3QXmqFGaNASjiCijBKcj9hEscEsdZq0Nc4uVsDNgVQvxwWNWDuzn1g1jlwlTFigCRLNOdpM/g+Dp4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUki9uYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AD90C43399;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887185;
	bh=3nX8fP3l7Bt65toEN0CdGwFHFH0sX3inF2oQP8On+7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HUki9uYopQRh44lDvzPwbCwWaV7W5Bhjts6NoR06E1piWc9xSmUWPx9otEsf3PFrB
	 6JorfR+9A0tYw3TJvKGPfj4e5La5HOCoEWVyGzTtwBRc7+w5c19oi/6+OvR53jPIzR
	 DcujkmjB/gszLGH8j18Ioof3Le2PPW1fB48YtycEtjDpFxCicqxFtl/rSaLNkIsB7z
	 EvBmqaPYOCKuSQOgdmKQccDhsbJfWcPTUYEYf7VG8K+stONrj8niCBq2spqJ06sAmT
	 qCmLhlZysaTv0gCFFzuWf533+WjmtmZTYU/PNcoNSOzCvdTWY81807ETmHThLk2cFp
	 SwnQ/fdLi2OVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F17EC54E5C;
	Fri,  8 Mar 2024 08:39:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 08 Mar 2024 16:39:43 +0800
Subject: [PATCH net-next v10 1/8] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-net-v10-1-3684df40897e@outlook.com>
References: <20240308-net-v10-0-3684df40897e@outlook.com>
In-Reply-To: <20240308-net-v10-0-3684df40897e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709887184; l=2517;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=stv+a/mRLJaLswc2WeXjirfjJSRDl5txIs38K87wIhs=;
 b=9j+FuIPIRUS4exeZWvRUUqli182hH9albcedJVvHCPLBrHPuQEELwVoMCxNg27Nh5UsQ1ZSNi
 86J4wuWoK7mAkor+Q9fdQ8yP0dI4RCDC/+lAWl4y4SMOmSgzPllaEUt
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


