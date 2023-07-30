Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D7768730
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjG3S4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjG3S4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:56:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57810F2;
        Sun, 30 Jul 2023 11:56:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuEsC009246;
        Sun, 30 Jul 2023 13:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690743374;
        bh=zmwtTE6Gn6FNjNpT8WsRSK0fWmC4JdsvgzmFXO27aBk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=oJb3+4/ht7j7N4ODjJoudToJOAuM7po7ANGvpVqG7RHlSnBLgubSLOoBp7FbV6rI0
         tZ91sb2F+W1YhmrLyc4NsCRrx9jR95tyqPbpSons0JZTLxctKCVLjSNgPELoEcJhHf
         qaaKa7CvRr9DjwSRbr73Cz5WFcNJcnIMhcjwjJpA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36UIuEsm017897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Jul 2023 13:56:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jul 2023 13:56:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jul 2023 13:56:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36UIuCSx005654;
        Sun, 30 Jul 2023 13:56:13 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Mon, 31 Jul 2023 00:25:55 +0530
Subject: [PATCH 2/5] dt-bindings: crypto: Add binding for TI MCRC64 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230719-mcrc-upstream-v1-2-dc8798a24c47@ti.com>
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690743369; l=2012;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=bspN7GCCxGmD1lRLV3s1YXzpsokel2Qe0EdKzXaB178=;
 b=MI2u6vmuU39rWuNOYq3IyMDCY4UIcUDDKtw9vSLIxims5KFxSZWBzCp3SI+4Ly7+wyC1Z1ddD
 f7hbTnhdnWoCd6OoZ06HYCw2c8aP2FuodvKOROcX5KVwM8Mha0qrnR/
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Texas Instruments MCRC64 driver

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml | 42 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                             |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml b/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
new file mode 100644
index 000000000000..1d1e3f87638c
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/ti,mcrc64.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments MCRC64 bindings
+
+maintainers:
+  - Kamlesh Gurudasani <kamlesh@ti.com>
+
+properties:
+  compatible:
+    const: ti,mcrc64
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    mcrc64: mcrc64@30300000 {
+      compatible = "ti,mcrc64";
+      reg = <0x00 0x30300000 0x00 0x1000>;
+      clocks = <&k3_clks 116 0>;
+      power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+      };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 733bcfa0209a..d8680f6969e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21462,6 +21462,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
 F:	drivers/iio/adc/ti-lmp92064.c
 
+TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
+M:	Kamlesh Gurudasani <kamlesh@ti.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
+
 TI PCM3060 ASoC CODEC DRIVER
 M:	Kirill Marinushkin <kmarinushkin@birdec.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)

-- 
2.34.1

