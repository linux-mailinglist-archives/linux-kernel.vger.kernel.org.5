Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93D876C33F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHBDBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjHBDBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:01:07 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE892272B;
        Tue,  1 Aug 2023 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690945220; x=1722481220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8bnxemkUhzO4A3F7jJiLKuutJCDU25f0xvfvEgLXWU=;
  b=V8/OVVCzs3FG54tF1qAJbuWoxZ5txsJzYUo6hFx9anQweH7lgDLkF1R4
   gLEtBlZKQjveYHWNoedT2Lc0NZ968XdXYAAEF4v9rEG5BDz7+tMlHwoVk
   uNqpv3cHJCEsINC18qCZFNuTE6Qhx7HXVV4EGCCv84OGJIYA6InrctEN2
   wJc/JmkSkvqBBf8UJRUdAzZ5oKMAAwPytp96s68psOZIZYal6yluHyxx4
   BQat4aHtUG3iO9932/T5AUzL0P+4mNpfa6V91FWOR+puFxelfINe5Txcp
   i/g7xZJO4ndMei7274dW3PSOF1dCEOlgfHlSFs0IQxhKjsDDqEVTfRBlV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372194283"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372194283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 20:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902819821"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="902819821"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 20:00:14 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock manager
Date:   Wed,  2 Aug 2023 10:58:42 +0800
Message-Id: <20230802025842.1260345-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
References: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add clock ID definitions for Intel Agilex5 SoCFPGA.
The registers in Agilex5 handling the clock is named as clock manager.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../bindings/clock/intel,agilex5-clkmgr.yaml  |  40 +++++++
 .../dt-bindings/clock/intel,agilex5-clkmgr.h  | 100 ++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
 create mode 100644 include/dt-bindings/clock/intel,agilex5-clkmgr.h

diff --git a/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
new file mode 100644
index 000000000000..d120b0da7f3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/intel,agilex5-clkmgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA Agilex5 clock manager
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description:
+  The Intel Agilex5 Clock Manager is an integrated clock controller, which
+  generates and supplies clock to all the modules.
+
+properties:
+  compatible:
+    const: intel,agilex5-clkmgr
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clkmgr: clock-controller@10d10000 {
+      compatible = "intel,agilex5-clkmgr";
+      reg = <0x10d10000 0x1000>;
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/intel,agilex5-clkmgr.h b/include/dt-bindings/clock/intel,agilex5-clkmgr.h
new file mode 100644
index 000000000000..2f3a23b31c5c
--- /dev/null
+++ b/include/dt-bindings/clock/intel,agilex5-clkmgr.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023, Intel Corporation
+ */
+
+#ifndef __DT_BINDINGS_INTEL_AGILEX5_CLKMGR_H
+#define __DT_BINDINGS_INTEL_AGILEX5_CLKMGR_H
+
+/* fixed rate clocks */
+#define AGILEX5_OSC1			0
+#define AGILEX5_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX5_CB_INTOSC_LS_CLK	2
+#define AGILEX5_F2S_FREE_CLK		3
+
+/* PLL clocks */
+#define AGILEX5_MAIN_PLL_CLK		4
+#define AGILEX5_MAIN_PLL_C0_CLK		5
+#define AGILEX5_MAIN_PLL_C1_CLK		6
+#define AGILEX5_MAIN_PLL_C2_CLK		7
+#define AGILEX5_MAIN_PLL_C3_CLK		8
+#define AGILEX5_PERIPH_PLL_CLK		9
+#define AGILEX5_PERIPH_PLL_C0_CLK	10
+#define AGILEX5_PERIPH_PLL_C1_CLK	11
+#define AGILEX5_PERIPH_PLL_C2_CLK	12
+#define AGILEX5_PERIPH_PLL_C3_CLK	13
+#define AGILEX5_CORE0_FREE_CLK		14
+#define AGILEX5_CORE1_FREE_CLK		15
+#define AGILEX5_CORE2_FREE_CLK		16
+#define AGILEX5_CORE3_FREE_CLK		17
+#define AGILEX5_DSU_FREE_CLK		18
+#define AGILEX5_BOOT_CLK		19
+
+/* fixed factor clocks */
+#define AGILEX5_L3_MAIN_FREE_CLK	20
+#define AGILEX5_NOC_FREE_CLK		21
+#define AGILEX5_S2F_USR0_CLK		22
+#define AGILEX5_NOC_CLK			23
+#define AGILEX5_EMAC_A_FREE_CLK		24
+#define AGILEX5_EMAC_B_FREE_CLK		25
+#define AGILEX5_EMAC_PTP_FREE_CLK	26
+#define AGILEX5_GPIO_DB_FREE_CLK	27
+#define AGILEX5_S2F_USER0_FREE_CLK	28
+#define AGILEX5_S2F_USER1_FREE_CLK	29
+#define AGILEX5_PSI_REF_FREE_CLK	30
+#define AGILEX5_USB31_FREE_CLK		31
+
+/* Gate clocks */
+#define AGILEX5_CORE0_CLK		32
+#define AGILEX5_CORE1_CLK		33
+#define AGILEX5_CORE2_CLK		34
+#define AGILEX5_CORE3_CLK		35
+#define AGILEX5_MPU_CLK			36
+#define AGILEX5_MPU_PERIPH_CLK		37
+#define AGILEX5_MPU_CCU_CLK		38
+#define AGILEX5_L4_MAIN_CLK		39
+#define AGILEX5_L4_MP_CLK		40
+#define AGILEX5_L4_SYS_FREE_CLK		41
+#define AGILEX5_L4_SP_CLK		42
+#define AGILEX5_CS_AT_CLK		43
+#define AGILEX5_CS_TRACE_CLK		44
+#define AGILEX5_CS_PDBG_CLK		45
+#define AGILEX5_EMAC1_CLK		47
+#define AGILEX5_EMAC2_CLK		48
+#define AGILEX5_EMAC_PTP_CLK		49
+#define AGILEX5_GPIO_DB_CLK		50
+#define AGILEX5_S2F_USER0_CLK		51
+#define AGILEX5_S2F_USER1_CLK		52
+#define AGILEX5_PSI_REF_CLK		53
+#define AGILEX5_USB31_SUSPEND_CLK	54
+#define AGILEX5_EMAC0_CLK		46
+#define AGILEX5_USB31_BUS_CLK_EARLY	55
+#define AGILEX5_USB2OTG_HCLK		56
+#define AGILEX5_SPIM_0_CLK		57
+#define AGILEX5_SPIM_1_CLK		58
+#define AGILEX5_SPIS_0_CLK		59
+#define AGILEX5_SPIS_1_CLK		60
+#define AGILEX5_DMA_CORE_CLK		61
+#define AGILEX5_DMA_HS_CLK		62
+#define AGILEX5_I3C_0_CORE_CLK		63
+#define AGILEX5_I3C_1_CORE_CLK		64
+#define AGILEX5_I2C_0_PCLK		65
+#define AGILEX5_I2C_1_PCLK		66
+#define AGILEX5_I2C_EMAC0_PCLK		67
+#define AGILEX5_I2C_EMAC1_PCLK		68
+#define AGILEX5_I2C_EMAC2_PCLK		69
+#define AGILEX5_UART_0_PCLK		70
+#define AGILEX5_UART_1_PCLK		71
+#define AGILEX5_SPTIMER_0_PCLK		72
+#define AGILEX5_SPTIMER_1_PCLK		73
+#define AGILEX5_DFI_CLK			74
+#define AGILEX5_NAND_NF_CLK		75
+#define AGILEX5_NAND_BCH_CLK		76
+#define AGILEX5_SDMMC_SDPHY_REG_CLK	77
+#define AGILEX5_SDMCLK			78
+#define AGILEX5_SOFTPHY_REG_PCLK	79
+#define AGILEX5_SOFTPHY_PHY_CLK		80
+#define AGILEX5_SOFTPHY_CTRL_CLK	81
+#define AGILEX5_NUM_CLKS		82
+
+#endif	/* __DT_BINDINGS_INTEL_AGILEX5_CLKMGR_H */
-- 
2.25.1

