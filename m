Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD07B7B99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbjJDJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbjJDJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:16:32 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF2698;
        Wed,  4 Oct 2023 02:16:28 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3945aC2J021867;
        Wed, 4 Oct 2023 11:16:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=tN8WihHZ8UtI7rsXlOoBMNAknU2jMb2LP7lJZaLwYH8=; b=OO
        sEZgJ9bL5gYQUKt35WoI2CeLx0DyXR46fGkH6nM8/uc5Y4xWaU5KC/GHE/mGCtTG
        XUR/sIwBMq0R+dw4nKqQ//Py2ewHi1H/e4Z7r2vrhaRzHS42dOCw1Y29CwJupKyY
        xGJzrgDuqi6TF87eo4u3boz8cLz4EdNLmfTtlq+ZUvvbjXDosRAZHW1j00neT3+5
        C/4jsUHZC8aLpiAKvy5eS0m/3XJj6NaZtudXELFeNXGVwemvuhxUM3ROoREvHtMR
        /GV/BZrfuwGR9o98Q1lYAXX1Ryna+/FUHhxtTo3D1DvYN3VJkcxR6U1JFH03mscu
        6urohqVTzpUfYCs5lUKQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3texmj5utb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 11:16:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 487CE100063;
        Wed,  4 Oct 2023 11:16:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 40F4E22A6DD;
        Wed,  4 Oct 2023 11:16:01 +0200 (CEST)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:16:00 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video encoder
Date:   Wed, 4 Oct 2023 11:15:48 +0200
Message-ID: <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32MP25 VENC video encoder bindings.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 .../bindings/media/st,stm32mp25-venc.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml

diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
new file mode 100644
index 000000000000..c69e0a34f675
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/st,stm32mp25-venc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32MP25 VENC video encoder
+
+maintainers:
+  - Hugues Fruchet <hugues.fruchet@foss.st.com>
+
+description:
+  The STMicroelectronics STM32MP25 SOCs embeds a VENC video hardware encoder
+  peripheral based on Verisilicon VC8000NanoE IP (former Hantro H1).
+
+properties:
+  compatible:
+    const: st,stm32mp25-venc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    venc: venc@580e0000 {
+        compatible = "st,stm32mp25-venc";
+        reg = <0x580e0000 0x800>;
+        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "venc";
+        clocks = <&ck_icn_p_venc>;
+        clock-names = "venc-clk";
+    };
-- 
2.25.1

