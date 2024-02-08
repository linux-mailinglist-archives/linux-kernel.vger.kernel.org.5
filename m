Return-Path: <linux-kernel+bounces-58190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C861084E28A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E79D2906E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2E7BAE9;
	Thu,  8 Feb 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQBGrYby"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D37AE56;
	Thu,  8 Feb 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400346; cv=none; b=E2IENmsUSS39obvV+q1fjfJX+BrVzy1NaXu6pKTKSKtujjwF+ME4OFOorOx7z8sYBC0UuO/uQang41ow5djK0hDCJFYOmgkvUz56OZKmcnKk9H1Rh5F7ZmH9Q9CyEaEiwgxbd70AaRenB2VFBtn7Lz/SU8FtlCQ3dxAdcz4WiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400346; c=relaxed/simple;
	bh=0hkxkRww44gWsbUz2oCLIa2CCfYl1bmQoNetwgaccsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOyVjEUwdEiRiCEQgs7ALtT8GLgP29CwJSXKRHiZWZfKi0kP7BzMJx0psVmj1J5v+skITZjiLdo85tkZt7wMtStqLw4Gj+bGzTVVw1/59wH/HXO5D/2l/1XrmsjYnnRnuO347N+L2YsHgWmnzc32K5oNXjKapUFFAEmPyqbuEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQBGrYby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C971AC433C7;
	Thu,  8 Feb 2024 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400345;
	bh=0hkxkRww44gWsbUz2oCLIa2CCfYl1bmQoNetwgaccsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQBGrYbyW76TPaFzdIU7MkCIuBpxB46/tz74SZPld8IZhB/OOjKu2tbJZh9pAR1dr
	 eRIwbX1+8vQLKCDc7SXI33OpIre7MfDuUKfOOoM498832MYi2bkv0i82COyCFqvHqJ
	 v5wl0x7dKtd4D4PPC3uaDKev2LxZ9qP3wFWrK/zylMJQV429fOX7pSPhz+7xwkCe5F
	 bKr8GjfGr2yw8dmHBO/L7bVlM+XKMaRaH83Q8rcaEOYD+GvDj7Qc5Kktj20KpH07dn
	 lCiWQeGpWTRo9vzrgj0GWzXN7bKboCv7sL7TwdYrgpsn8wSUlYmenaBTGDuZwjTLoS
	 X7BCucO2yP2/Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 08 Feb 2024 15:51:44 +0200
Subject: [PATCH v2 2/3] arm64: dts: ti: Add DT overlay for PCIe + USB2.0
 SERDES personality card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-for-v6-9-am65-overlays-2-0-v2-2-70bae3e91597@kernel.org>
References: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
In-Reply-To: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, srk@ti.com, 
 r-gunasekaran@ti.com, Roger Quadros <rogerq@ti.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3979; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=aJ5YN8fQrTKqyKVzLcv0eLbdORQPnXvyyK98PAqogVU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlxNyN3+NHAaqXY8oYlQ9dvUfzyog0RExKT5cr5
 c6xGkaT5RmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcTcjQAKCRDSWmvTvnYw
 k4CqD/0ZFSpdqECROEZspgwPMsmZ1BTmsGNfNMLqNBp/nA51QfeCMVnGr8AZq/DmPfI3iICIWou
 YDsliTQ1mrgtKeIERSabeIY9VDeJBm0R5esIWAMBciZpxgtpcWhLdLF8ahTjCoJweluZOD5ga+o
 CVPrnzw/vbjhqiwKNNObvmXJAvixTcz4lvO2q+QLSx0YIcbcVvXbQuPl1rDpOfG1MuvppiIJdBu
 UOA3y/Reh1Vfewthj2dKLRJH59kceLdetLhd5QiLLdqhBZJxWXw83hB+ncBN4rLq/qIVopvofqf
 yhO64BoQl0nsEnPz/TTVrg7uzGqtWDBUhz9NoqXDLrLzWUHLEA6hceRVUBpr8vxu2VD5PtI/+2l
 Pi1X33n9TMT7zSUJZMw9DAYUSeiAV/1eX5ot0rL8DRTwKF/qdW75A6SJu9fPwy+8kTeCdH6oEv9
 qILZaP8BNhSawVdtNVC1bL4bZWdVicH4z8M8KE3cU5f669a1Z4dbOyInk7Jno5vrKUzayGGFUgC
 wAhXVjlxk3sZxWp7N8ePJYzbSLzWQ1QhGlfBAEabgO0HCIr4Bh1hJ8vpjjt20L+oY8PL/EgOJzr
 /il5B7Lv5Nj+LG7qTwZ7hfa8mJGkNQ6s8BgwvaWbmY6DvAXnLPRneLZX5BLWcnH8ZEgfwZPjyaV
 uCp43LQ6hKB2AGw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

From: Roger Quadros <rogerq@ti.com>

Enable both SERDES and PCIe DT nodes in order to get PCIe working on
the SERDES PCIe x2 personality card.

The daughter card also has a USB 2.0 dual-role port. As the base board
already supports a 2.0 dual-role port, enable the port on the SERDES
card to be a host only port.

This will prevent user confusion as having 2 ports in device mode often
leads to confusion as to which port is bound to the gadget function driver.

The PCIe x2 card is provided with the AM65x IDK configuration [1]
so apply the overlay to k3-am654-idk.dtb

[1] https://www.ti.com/lit/ug/spruim6a/spruim6a.pdf

Co-developed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Changelog:

v2:
- Drop PCIe endpoint settings as it no longer exists in base tree.

v1: https://lore.kernel.org/all/20240126114530.40913-3-rogerq@kernel.org/
---
 arch/arm64/boot/dts/ti/Makefile                |  3 +-
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso | 59 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bfcc86ff8e24..f534c373c958 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -47,7 +47,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
-k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo
+k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
@@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am654-pcie-usb2.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
new file mode 100644
index 000000000000..dd701e0c1750
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for SERDES personality card: 2lane PCIe + USB2.0 Host on AM654 EVM
+ *
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-am654-serdes.h>
+#include "k3-pinctrl.h"
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>,
+			  <&serdes0 AM654_SERDES_CMU_REFCLK>,
+			  <&serdes0 AM654_SERDES_RO_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>,
+				 <&k3_clks 153 4>,
+				 <&k3_clks 153 4>;
+	status = "okay";
+};
+
+&serdes1 {
+	assigned-clocks = <&serdes1 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&serdes0 AM654_SERDES_RO_REFCLK>;
+	status = "okay";
+};
+
+&pcie0_rc {
+	num-lanes = <2>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+	reset-gpios = <&pca9555 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&main_pmx0 {
+       usb0_pins_default: usb0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
+		>;
+	};
+};
+
+&dwc3_0 {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins_default>;
+	dr_mode = "host";
+};

-- 
2.34.1


