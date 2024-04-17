Return-Path: <linux-kernel+bounces-148394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4D8A81EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D5A282A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4713CFA3;
	Wed, 17 Apr 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="fA+EkObP"
Received: from outbound9.mail.transip.nl (outbound9.mail.transip.nl [136.144.136.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C813C8FD;
	Wed, 17 Apr 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352774; cv=none; b=ZSbS2L+WIwTW4A5r7HEZpEH0xEOjpNtZv+XmFkUcBBKDDxxBndkgE2cmMLgEv3qsWaZiST0xIBpbsOpngwe/U0vLOyunWEu7jIJ0CNxTO1psQxaQR89yiSN/lvkL3W/VbWGt6F5RjtIigXT98Ux/B0XdPRIJWonqn+d0rkk5kFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352774; c=relaxed/simple;
	bh=yTNIUVB4TH7/duE82fAx3t+Vra1GNIHORCwHrwOBX4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fs5CLrrp59i+oRMSu3klHpDbnZYsSgaT1iUSWdTdJCfiW0ij1C79FrhITj4A+JUoKtb8UXAH1AbXCHLOqOflNY4gSTOxY/0b0KnOcAo7ukVKWhgjokkQu4zFWyqyWws1POZ4gvnsAhoGsHtF8nLJEwobBMhDljxTdFjubraLEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=fA+EkObP; arc=none smtp.client-ip=136.144.136.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission7.mail.transip.nl (unknown [10.103.8.158])
	by outbound9.mail.transip.nl (Postfix) with ESMTP id 4VKJMf3CJvzTPNc4;
	Wed, 17 Apr 2024 13:19:26 +0200 (CEST)
Received: from [127.0.1.1] (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission7.mail.transip.nl (Postfix) with ESMTPA id 4VKJMd3h2kz1Q6K0;
	Wed, 17 Apr 2024 13:19:25 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Date: Wed, 17 Apr 2024 13:19:23 +0200
Subject: [PATCH] dt-bindings: clock: Add qcom MSM8660 MMCC defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-msm8660-mmcc-v1-1-efc9e455268c@herrie.org>
X-B4-Tracking: v=1; b=H4sIADqwH2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Nz3dziXAszMwPd3NzkZF1Tw2TDFEMgPyU5SQmopaAoNS2zAmxcdGx
 tLQBvBt+iXgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713352765; l=4482;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=HF/J5A6L7bIeZSe/Xg1eXt7FFE66voPUQgLSljZ6GuI=;
 b=553DRHijzy8+1mjYTnwmiP91YFXUbh6exxnV8bomdpW9oxtWwR+iwMfRntnPSLwwWcmZfHK2I
 kLtfh8KCneFA08+DfjFUiXrGgu//1jaajGbL1soCZXIksynoNxvdXfD
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission7.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713352765; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=k5MCBAt95sqb7Q/nGRpmG6zmr6zKDTh/dFbuXAAMDQA=;
 b=fA+EkObPnXvgConbVJSRUiYMkyT58b96UxcXbxBCPRlMfHLCt9U1uEW9lUAI4vRLurE2Zw
 rx6KRRtsrUJKjf5dIGL/saBfY0zdmrVssf8e0ZYqKIgu+Cmh3CIKwt37mWAJovnZJGBsCo
 FQszS87vb9CZVpb5IUUpHG+JnwTic5K4F2H/iQmzLbgi2rkuf1RcUF8qNyDdWI/hQOxsmj
 e6AUtL/FGvi6RU1vJK/fhiTBZ4FCQSnkksgJHEj+JqiC1GAFJyfNnrB+3d5KUVPuH8/lUe
 AYsIipoY8+hJodX3LhNyZhXLM69vLEjDq7MJ7O+XgmJGwMMtDOEt0KmjKKHLAg==
X-Report-Abuse-To: abuse@transip.nl

From: Linus Walleij <linus.walleij@linaro.org>

The compatible binding for the MSM8660 MMCC already exist
but the enumerator defines are missing. Add them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 include/dt-bindings/clock/qcom,mmcc-msm8660.h | 75 +++++++++++++++++++++++++++
 include/dt-bindings/reset/qcom,mmcc-msm8660.h | 53 +++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8660.h b/include/dt-bindings/clock/qcom,mmcc-msm8660.h
new file mode 100644
index 000000000000..2c7a6a3ae328
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8660.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_8660_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_8660_H
+
+#define GMEM_AXI_CLK		0
+#define IJPEG_AXI_CLK		1
+#define IMEM_AXI_CLK		2
+#define JPEGD_AXI_CLK		3
+#define MDP_AXI_CLK		4
+#define VCODEC_AXI_CLK		5
+#define VFE_AXI_CLK		6
+#define ROT_AXI_CLK		7
+#define VPE_AXI_CLK		8
+#define SMI_2X_AXI_CLK		9
+#define AMP_AHB_CLK		10
+#define CSI0_AHB_CLK		11
+#define CSI1_AHB_CLK		12
+#define DSI_M_AHB_CLK		13
+#define DSI_S_AHB_CLK		14
+#define GFX2D0_AHB_CLK		15
+#define GFX2D1_AHB_CLK		16
+#define GFX3D_AHB_CLK		17
+#define HDMI_M_AHB_CLK		18
+#define HDMI_S_AHB_CLK		19
+#define IJPEG_AHB_CLK		20
+#define IMEM_AHB_CLK		21
+#define JPEGD_AHB_CLK		22
+#define MDP_AHB_CLK		23
+#define ROT_AHB_CLK		24
+#define SMMU_AHB_CLK		25
+#define TV_ENC_AHB_CLK		26
+#define VCODEC_AHB_CLK		27
+#define VFE_AHB_CLK		28
+#define VPE_AHB_CLK		29
+#define GFX3D_SRC		30
+#define GFX3D_CLK		31
+#define MDP_SRC			32
+#define MDP_CLK			33
+#define MDP_VSYNC_SRC		34
+#define MDP_VSYNC_CLK		35
+#define MDP_PIXEL_SRC		36
+#define MDP_PIXEL_CLK		37
+#define MDP_LCDC_CLK		38
+#define ROT_SRC			39
+#define ROT_CLK			40
+#define CAM_SRC			41
+#define CAM_CLK			42
+#define CSI_SRC			43
+#define CSI0_CLK		44
+#define CSI1_CLK		45
+#define DSI_BYTE_SRC		46
+#define DSI_BYTE_CLK		47
+#define DSI_ESC_CLK		48
+#define TV_SRC			49
+#define TV_ENC_CLK		50
+#define TV_DAC_CLK		51
+#define MDP_TV_CLK		52
+#define HDMI_TV_CLK		53
+#define HDMI_APP_CLK		54
+#define VCODEC_SRC		55
+#define VCODEC_CLK		56
+#define VPE_SRC			57
+#define VPE_CLK			58
+#define VFE_SRC			59
+#define VFE_CLK			60
+#define CSI0_VFE_CLK		61
+#define CSI1_VFE_CLK		62
+#define PLL2			63
+#define PLL3			64
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,mmcc-msm8660.h b/include/dt-bindings/reset/qcom,mmcc-msm8660.h
new file mode 100644
index 000000000000..c12156b3b8ac
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,mmcc-msm8660.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_MSM_MMCC_8660_H
+#define _DT_BINDINGS_RESET_MSM_MMCC_8660_H
+
+#define IJPEG_AXI_RESET		0
+#define IMEM_AXI_RESET		1
+#define MDP_AXI_RESET		2
+#define VCODEC_AXI_RESET	3
+#define VFE_AXI_RESET		4
+#define ROT_AXI_RESET		5
+#define VPE_AXI_RESET		6
+#define AMP_AHB_RESET		7
+#define CSI0_AHB_RESET		8
+#define CSI1_AHB_RESET		9
+#define DSI_M_AHB_RESET		10
+#define DSI_S_AHB_RESET		11
+#define GFX2D0_AHB_RESET	12
+#define GFX2D1_AHB_RESET	13
+#define GFX3D_AHB_RESET		14
+#define HDMI_M_AHB_RESET	15
+#define HDMI_S_AHB_RESET	16
+#define IJPEG_AHB_RESET		17
+#define IMEM_AHB_RESET		18
+#define JPEGD_AHB_RESET		19
+#define MDP_AHB_RESET		20
+#define ROT_AHB_RESET		21
+#define TV_ENC_AHB_RESET	22
+#define VCODEC_AHB_RESET	23
+#define VFE_AHB_RESET		24
+#define VPE_AHB_RESET		25
+#define MDP_RESET		26
+#define MDP_VSYNC_RESET		27
+#define MDP_PIXEL_RESET		28
+#define ROT_RESET		29
+#define GFX3D_RESET		30
+#define CSI0_RESET		31
+#define CSI1_RESET		32
+#define DSI_BYTE_RESET		33
+#define TV_ENC_RESET		34
+#define MDP_TV_RESET		35
+#define HDMI_TV_RESET		36
+#define HDMI_APP_RESET		37
+#define VCODEC_RESET		38
+#define VPE_RESET		39
+#define VFE_RESET		40
+#define CSI0_VFE_RESET		41
+#define CSI1_VFE_RESET		42
+
+#endif

---
base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
change-id: 20240417-msm8660-mmcc-51c1d1866dcb

Best regards,
-- 
Herman van Hazendonk <github.com@herrie.org>


