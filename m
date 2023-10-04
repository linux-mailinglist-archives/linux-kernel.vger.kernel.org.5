Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF78F7B84A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbjJDQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243272AbjJDQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:11:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C3A7;
        Wed,  4 Oct 2023 09:10:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F197E0004;
        Wed,  4 Oct 2023 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNUAlceB4v3YuX6aNvHrvuj3iMFZRS3mSoGXc1wzpQw=;
        b=Z2GGNY7o8N2rLe6Y49DVkTqqNhtXuJ9ybKtkgTuNRRUli3Wg+X3ywhRoOWTdfBycHAAtNi
        NekvbHMLOd2GJRNIEXgCdmS2u6j0Rsy12RbtvQbHFdguZwkSggXET/nRMpkFjuSlSvYAud
        a9bKM0GJblQyLLzeCeP0AobG9PJNh8UEG5BjlyAQmRIBsqv/VKUSXtGO+hEcp6ySVqw8It
        L6FM/nqMSsQSCVVrb3XK4RMZ3H5QSqXMd+1uu3O2XWm1GgQTU93e/gtdSg/cAQ+Qgh8fQb
        5KbC4dB0rQh2MLNl2Hxe3BDLb9y0zZlH0/ZgGKFn+EmLN6u86EnRQZNHFPE83Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 06/11] dt-bindings: mips: Add bindings for Mobileye SoCs
Date:   Wed,  4 Oct 2023 18:10:33 +0200
Message-Id: <20231004161038.2818327-7-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
supported

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/mips/mobileye.yaml    | 36 +++++++++
 include/dt-bindings/soc/mobileye,eyeq5.h      | 77 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 include/dt-bindings/soc/mobileye,eyeq5.h

diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Documentation/devicetree/bindings/mips/mobileye.yaml
new file mode 100644
index 000000000000..f47767bc2c8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/mobileye.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye SoC series
+
+maintainers:
+  - Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+
+description: |
+    Boards with a Mobileye SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+
+  compatible:
+    oneOf:
+      - description: Boards with Mobileye EyeQ5 SoC
+        items:
+          - enum:
+              - mobileye,eyeq5-epm5
+          - const: mobileye,eyeq5
+
+      - description: Boards with Mobileye EyeQ6 SoC
+        items:
+          - const: mobileye,eyeq6
+
+additionalProperties: true
+
+...
diff --git a/include/dt-bindings/soc/mobileye,eyeq5.h b/include/dt-bindings/soc/mobileye,eyeq5.h
new file mode 100644
index 000000000000..7d8cb97b45bf
--- /dev/null
+++ b/include/dt-bindings/soc/mobileye,eyeq5.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 Mobileye Vision Technologies Ltd.
+ */
+#ifndef _DT_BINDINGS_SOC_MOBILEYE_EYEQ5_H
+#define _DT_BINDINGS_SOC_MOBILEYE_EYEQ5_H
+
+/* EQ5 interrupts */
+#define NUM_INT_I2C_A			1
+#define NUM_INT_I2C_B			2
+#define NUM_INT_I2C_C			3
+#define NUM_INT_I2C_D			4
+#define NUM_INT_I2C_E			5
+
+#define NUM_INT_UART			6 /* same for all UARTs - A, B, C */
+#define NUM_INT_PCIE0_INT0		7
+#define NUM_INT_PCIE0_INT1		8
+
+#define NUM_INT_CAN			9 /* same for all CANs A, B, C */
+
+#define NUM_INT_EMMC			10
+/* empty				11 */
+#define NUM_INT_SPIA_B			12
+#define NUM_INT_SPIC_D			13
+
+#define NUM_INT_GPIO			14
+
+#define NUM_INT_TIMER_0			15
+#define NUM_INT_TIMER_1			16
+#define NUM_INT_TIMER_2			17
+#define NUM_INT_TIMER_3			18
+#define NUM_INT_TIMER_4_ETIMER0_1	19
+#define NUM_INT_OQSPI			20
+#define NUM_INT_DDR_CTRL		21
+#define NUM_INT_NOC			22
+
+#define NUM_INT_GEM0			23
+#define NUM_INT_GEM1			24
+
+#define NUM_INT_VDI_0_VC0		25
+#define NUM_INT_VDI_0_VC1		26
+#define NUM_INT_VDI_0_VC2		27
+#define NUM_INT_VDI_0_VC3		28
+#define NUM_INT_VDI_0_ERR		29
+#define NUM_INT_VDI_1_VC0		30
+#define NUM_INT_VDI_1_VC1		31
+#define NUM_INT_VDI_1_VC2		32
+#define NUM_INT_VDI_1_VC3		33
+#define NUM_INT_VDI_1_ERR		34
+
+#define NUM_INT_MPC0			35
+#define NUM_INT_MPC1			36
+#define NUM_INT_MPC2			37
+#define NUM_INT_MPC3			38
+#define NUM_INT_MPC4			39
+#define NUM_INT_VMP0			40
+#define NUM_INT_VMP1			41
+#define NUM_INT_VMP2			42
+#define NUM_INT_VMP3			43
+#define NUM_INT_PMA0			44
+#define NUM_INT_PMA1			45
+#define NUM_INT_PMAC0			46
+#define NUM_INT_PMAC1			47
+
+#define NUM_INT_PCIE1_INT0		48
+#define NUM_INT_PCIE1_INT1		49
+
+#define NUM_INT_HSM_C3			50
+
+#define NUM_INT_MJPEG			51
+
+#define NUM_INT_FCMU_OLB		52
+#define NUM_INT_FCMU_NMI		53
+#define NUM_INT_WDDOG_TIMER		54
+#define NUM_INT_WDDOG_TIMER_1		55
+
+#endif /* _DT_BINDINGS_SOC_MOBILEYE_EYEQ5_H */
-- 
2.40.1

