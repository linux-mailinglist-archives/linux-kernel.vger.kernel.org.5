Return-Path: <linux-kernel+bounces-78377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7DC8612B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DE528599F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16418004F;
	Fri, 23 Feb 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPpHt3uf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B837EEF7;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694909; cv=none; b=hfdDI0T0cKLLQurBTtye1D/3Gr4Y+7O1sNSAc0Eh9hUIeIWcfwSW/PNO7lmw2k5oDH/Lbzr24pjpqQ7bUhDwxEkSsbdn/AwqHay39gMVt0k4aaRuWfmSPggnJ1mbJ1vyQqoqQ75bVcgmodiej+aDdcFIF1Tk0lS64RkGgAYpDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694909; c=relaxed/simple;
	bh=jPvfA4fCiMz71iIgn/ZKZZv+zI2oDR0duOAnRqgl5k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLw7PG/O8pla8894+u0g1ShEJv8QiUVKIDpPR0jysAe2wDdGP6aSlXjtblSLqshpJykMDX6oeQ63Vt4GpaOFWwLyKYLZwCGuqnNzQmtnqbTBKmEr+OugryvTqHdMcpmfmKwdjHCmTX1oSRUEmjQVAm55sVYwUfs4+L5FU433b5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPpHt3uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EBC1C43390;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708694908;
	bh=jPvfA4fCiMz71iIgn/ZKZZv+zI2oDR0duOAnRqgl5k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iPpHt3ufxV+fTr7UQnXkcJ3aHJs6f+/wyLsQnpC9aTIbByvYzc29IB83QY0rQVdK0
	 ojhKKclCNkR5fnv8WpvWMO1H1wkZkvvimtII0uDcvjn1a3aWrojnTs5G93c8tKd9x/
	 vFGjcW5qcaDlhCgSd1pdaqGqIoEJvivmFH3zvJnUzQCYx4HLjL9Nd6ByEB2OHne4Ky
	 5ND5jWv5Or5bMHiCQRgyaZZVHh/HfZ00OZ4hhqjG79T1IsA3nSEhV5QtbzIKO2C4K3
	 /wNJ9ciVFruga43J3QOsw67jqgY7wKaXB+/xY5DeoSYRXCVsebsRUz/7v2DzX2pjrB
	 6nsvIQEMNjrRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D99C54E41;
	Fri, 23 Feb 2024 13:28:28 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 21:28:16 +0800
Subject: [PATCH net-next v5 1/7] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-net-v5-1-43b22d39c013@outlook.com>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
In-Reply-To: <20240223-net-v5-0-43b22d39c013@outlook.com>
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
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708694896; l=2450;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=J7K5LXcWUGxtur5Z9g90nuEgkuP8UoU2HOmGiUfxnWU=;
 b=2elWyDB1l81ckj1MUDjHGcaDAVl57/FpK4J2WPJV+HGVNM+eRIrd0UocZ1tRhzxdz0MTtyQAH
 19C09bN1BtMANsFGeJZiwfqOt3p2aQIEJw6hnS15ftrFBsgq2KiV+Eu
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

convert the old text binding to modern YAML based binding. No semantic
change.

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


