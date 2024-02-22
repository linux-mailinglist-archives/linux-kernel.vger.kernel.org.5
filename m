Return-Path: <linux-kernel+bounces-77270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052158602F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF901F22B08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8376E5FF;
	Thu, 22 Feb 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHB5GBya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABD1DFD9;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=MPz7x4T5BtBUY66ZyPmNntaNg2MKVR/tLV6hqBfr3lp8W086v8pcpqBHxudvVIJfRU8gFhdKn7oVkXpY7rmrHgaQ4s8jbsQ+HscXYWc5EIQNZikzIcqVRZ5xS4MN1CH2JpVfVy+zvwWOF77SFA9dHqcFU+sO8veuyW8i8gmtdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=Jxi0eH5d/wxrUnu4Tc7jAelZsPK6EWewjca31DP3sFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODD1P0C2CAUaPX8Y6FsnUaecROug8zG0WHRQ11Cc1NlLqktf9kFwhFHTKuS0C44BzIS3w+1QtunZtcPg+Dz4Nnmlip++s1D0MyuqvGdZDsp7pvH5lkG7OBj9Oi3V00/qDvt9HIxGCi6VEKFA0KpjrDipIczY0KP9YNJBJdSAz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHB5GBya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4EE6C433A6;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=Jxi0eH5d/wxrUnu4Tc7jAelZsPK6EWewjca31DP3sFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DHB5GBya/9yZoUDZMQB+Qp/Glf67aTncmzFpAbzBujvn1kU9Sl8vLOpGKbivEFYn+
	 P4YM9rmmt74HbvVuYpC4h2QgNrZFi6vD9mMpW1lYmYuKbCa1GFRaRVtoJAL3h05lmi
	 ZrXJmPfNt4AW1Ku92SWl0Rf94qCbVsIRTEY29knWQSyLqApx7maeTHlMfzCz532FiU
	 cCyAg6+tiv3uAmvZSY7ftx2TxoaztJTaOe45Ds6UDx/OPSFH9iJojPApAPplKAmYjs
	 3RG0u8S05K7q2kaA4dNMQRIIOHjIr/B5lcatBy85biNCzkOf/ZvUd1dWTx+pqUlw/W
	 fBi4mWrVZwBFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DDCC54E49;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 03:40:12 +0800
Subject: [PATCH v4 2/7] dt-bindings: clock: histb-clock: split into two
 header files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-clk-mv200-v4-2-3e37e501d407@outlook.com>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
In-Reply-To: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=6799;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=q6FKPdvaS6C7lfP0l8tnfTtASXs4iYngzwzghiX3fYg=;
 b=xsWP2baBK8ZgXG28WQqNTELicam4HcM3elw4A5PGCA3Gv5VBdzMbiRKehXQorgRns/mfmrBEf
 /+dVh8veghQCwiS4Gjp3+lCLsRlNwZ0LqqDWLm4kfpaiDycFl4/TU1O
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The CRG driver between different SoCs provides different clocks and
resets. We should not provide a generic header file across all HiSTB
SoCs, instead each CRG driver should provide its own.

Split histb-clock.h into two files: hisilicon,hi3798cv200-crg.h and
hisilicon,hi3798cv200-sysctrl.h. This header file is for Hi3798CV200
only actually. For other HiSTB SoCs, some clock definitions are missing.

Create a new histb-clock.h to include these two files for backward
compatibility only. Deprecate this file as well.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  | 62 +++++++++++++++++++
 .../clock/hisilicon,hi3798cv200-sysctrl.h          | 17 ++++++
 include/dt-bindings/clock/histb-clock.h            | 70 +++-------------------
 3 files changed, 88 insertions(+), 61 deletions(-)

diff --git a/include/dt-bindings/clock/hisilicon,hi3798cv200-crg.h b/include/dt-bindings/clock/hisilicon,hi3798cv200-crg.h
new file mode 100644
index 000000000000..7cd8b5d053de
--- /dev/null
+++ b/include/dt-bindings/clock/hisilicon,hi3798cv200-crg.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_HI3798CV200_CRG_H
+#define __DT_BINDINGS_CLOCK_HI3798CV200_CRG_H
+
+/* clocks provided by core CRG */
+#define HISTB_OSC_CLK			0
+#define HISTB_APB_CLK			1
+#define HISTB_AHB_CLK			2
+#define HISTB_UART1_CLK			3
+#define HISTB_UART2_CLK			4
+#define HISTB_UART3_CLK			5
+#define HISTB_I2C0_CLK			6
+#define HISTB_I2C1_CLK			7
+#define HISTB_I2C2_CLK			8
+#define HISTB_I2C3_CLK			9
+#define HISTB_I2C4_CLK			10
+#define HISTB_I2C5_CLK			11
+#define HISTB_SPI0_CLK			12
+#define HISTB_SPI1_CLK			13
+#define HISTB_SPI2_CLK			14
+#define HISTB_SCI_CLK			15
+#define HISTB_FMC_CLK			16
+#define HISTB_MMC_BIU_CLK		17
+#define HISTB_MMC_CIU_CLK		18
+#define HISTB_MMC_DRV_CLK		19
+#define HISTB_MMC_SAMPLE_CLK		20
+#define HISTB_SDIO0_BIU_CLK		21
+#define HISTB_SDIO0_CIU_CLK		22
+#define HISTB_SDIO0_DRV_CLK		23
+#define HISTB_SDIO0_SAMPLE_CLK		24
+#define HISTB_PCIE_AUX_CLK		25
+#define HISTB_PCIE_PIPE_CLK		26
+#define HISTB_PCIE_SYS_CLK		27
+#define HISTB_PCIE_BUS_CLK		28
+#define HISTB_ETH0_MAC_CLK		29
+#define HISTB_ETH0_MACIF_CLK		30
+#define HISTB_ETH1_MAC_CLK		31
+#define HISTB_ETH1_MACIF_CLK		32
+#define HISTB_COMBPHY1_CLK		33
+#define HISTB_USB2_BUS_CLK		34
+#define HISTB_USB2_PHY_CLK		35
+#define HISTB_USB2_UTMI_CLK		36
+#define HISTB_USB2_12M_CLK		37
+#define HISTB_USB2_48M_CLK		38
+#define HISTB_USB2_OTG_UTMI_CLK		39
+#define HISTB_USB2_PHY1_REF_CLK		40
+#define HISTB_USB2_PHY2_REF_CLK		41
+#define HISTB_COMBPHY0_CLK		42
+#define HISTB_USB3_BUS_CLK		43
+#define HISTB_USB3_UTMI_CLK		44
+#define HISTB_USB3_PIPE_CLK		45
+#define HISTB_USB3_SUSPEND_CLK		46
+#define HISTB_USB3_BUS_CLK1		47
+#define HISTB_USB3_UTMI_CLK1		48
+#define HISTB_USB3_PIPE_CLK1		49
+#define HISTB_USB3_SUSPEND_CLK1		50
+
+#endif	/* __DT_BINDINGS_CLOCK_HI3798CV200_CRG_H */
diff --git a/include/dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h b/include/dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h
new file mode 100644
index 000000000000..e908b30bb8ce
--- /dev/null
+++ b/include/dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_HI3798CV200_SYSCTRL_H
+#define __DT_BINDINGS_CLOCK_HI3798CV200_SYSCTRL_H
+
+/* clocks provided by mcu CRG */
+#define HISTB_MCE_CLK			1
+#define HISTB_IR_CLK			2
+#define HISTB_TIMER01_CLK		3
+#define HISTB_LEDC_CLK			4
+#define HISTB_UART0_CLK			5
+#define HISTB_LSADC_CLK			6
+
+#endif	/* __DT_BINDINGS_CLOCK_HI3798CV200_SYSCTRL_H */
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index e64e5770ada6..def617ebe852 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -1,70 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
+ * DEPRECATED
+ *
+ * Each CRG driver should have its own clock number definitions header file.
+ * This file is only reserved for backward compatibility for Hi3798CV200
  */
 
 #ifndef __DTS_HISTB_CLOCK_H
 #define __DTS_HISTB_CLOCK_H
 
-/* clocks provided by core CRG */
-#define HISTB_OSC_CLK			0
-#define HISTB_APB_CLK			1
-#define HISTB_AHB_CLK			2
-#define HISTB_UART1_CLK			3
-#define HISTB_UART2_CLK			4
-#define HISTB_UART3_CLK			5
-#define HISTB_I2C0_CLK			6
-#define HISTB_I2C1_CLK			7
-#define HISTB_I2C2_CLK			8
-#define HISTB_I2C3_CLK			9
-#define HISTB_I2C4_CLK			10
-#define HISTB_I2C5_CLK			11
-#define HISTB_SPI0_CLK			12
-#define HISTB_SPI1_CLK			13
-#define HISTB_SPI2_CLK			14
-#define HISTB_SCI_CLK			15
-#define HISTB_FMC_CLK			16
-#define HISTB_MMC_BIU_CLK		17
-#define HISTB_MMC_CIU_CLK		18
-#define HISTB_MMC_DRV_CLK		19
-#define HISTB_MMC_SAMPLE_CLK		20
-#define HISTB_SDIO0_BIU_CLK		21
-#define HISTB_SDIO0_CIU_CLK		22
-#define HISTB_SDIO0_DRV_CLK		23
-#define HISTB_SDIO0_SAMPLE_CLK		24
-#define HISTB_PCIE_AUX_CLK		25
-#define HISTB_PCIE_PIPE_CLK		26
-#define HISTB_PCIE_SYS_CLK		27
-#define HISTB_PCIE_BUS_CLK		28
-#define HISTB_ETH0_MAC_CLK		29
-#define HISTB_ETH0_MACIF_CLK		30
-#define HISTB_ETH1_MAC_CLK		31
-#define HISTB_ETH1_MACIF_CLK		32
-#define HISTB_COMBPHY1_CLK		33
-#define HISTB_USB2_BUS_CLK		34
-#define HISTB_USB2_PHY_CLK		35
-#define HISTB_USB2_UTMI_CLK		36
-#define HISTB_USB2_12M_CLK		37
-#define HISTB_USB2_48M_CLK		38
-#define HISTB_USB2_OTG_UTMI_CLK		39
-#define HISTB_USB2_PHY1_REF_CLK		40
-#define HISTB_USB2_PHY2_REF_CLK		41
-#define HISTB_COMBPHY0_CLK		42
-#define HISTB_USB3_BUS_CLK		43
-#define HISTB_USB3_UTMI_CLK		44
-#define HISTB_USB3_PIPE_CLK		45
-#define HISTB_USB3_SUSPEND_CLK		46
-#define HISTB_USB3_BUS_CLK1		47
-#define HISTB_USB3_UTMI_CLK1		48
-#define HISTB_USB3_PIPE_CLK1		49
-#define HISTB_USB3_SUSPEND_CLK1		50
+#warning "This header file is deprecated, include hisilicon,hi3798cv200-crg.h \
+and hisilicon,hi3798cv200-sysctrl.h directly instead"
 
-/* clocks provided by mcu CRG */
-#define HISTB_MCE_CLK			1
-#define HISTB_IR_CLK			2
-#define HISTB_TIMER01_CLK		3
-#define HISTB_LEDC_CLK			4
-#define HISTB_UART0_CLK			5
-#define HISTB_LSADC_CLK			6
+#include "hisilicon,hi3798cv200-crg.h"
+#include "hisilicon,hi3798cv200-sysctrl.h"
 
-#endif	/* __DTS_HISTB_CLOCK_H */
+#endif /* __DTS_HISTB_CLOCK_H */

-- 
2.43.0


