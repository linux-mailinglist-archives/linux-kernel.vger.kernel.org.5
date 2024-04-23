Return-Path: <linux-kernel+bounces-155378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD808AE991
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936C91C23A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634058593A;
	Tue, 23 Apr 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiWjPhKN"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F813BAF7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882673; cv=none; b=PaSypIvTyI75ol+tkTIjZA2QTuXYY9gq8XmOZ6emYZeDk2IhALK0LyGlzjSRf/rr/QzsR3T/OP0wkSmK4MIf7otRs0PzO1KEJGQT7PGI7dScSXE5WEC3tKN31dS73/mbxA+sILkBwYlRI4fKR8OhJgyhlCAZFisOzmS2l7s/M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882673; c=relaxed/simple;
	bh=qry6OINB3Y5XDOqbX5Yz2SczN48SFrjT733z3scXr28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hw3W650SZrOH1rAcj7ufaPhONJJve2iCIPhHkAVTXNmxPGduiq9VUPJ9DfdCiIth+JB8YqHQgW2Cj+eweUtu8T60k2x2bHTltGyVhtYXBDlwmZ+mACLjEYsWj6grx/b+q2iR5lc9VuvAGTUPAgbQzrlmPBR8EcWOeCisWjdNOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KiWjPhKN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so6720237a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713882669; x=1714487469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCK7/eaHPs8ty64f0GbdUkElsClEa9GTcSSsrqNCGZg=;
        b=KiWjPhKNABMhf974CnDqoIJZTvEqZmcnD977d0anvvSV72HPTzYmI+WAGNr0YAt2j6
         T81xDA195osX9bJ/TPTbkKnSvFrtBVqtdgE+IsTKL68ErrGQwoU6W1jqqPZQbHeJtvf5
         VYqCht0fCY4AG5Wa863joBlkqeJxCkiFzxlDb6er9bAtUOzSXGH+/RpX57zOfRo1l4Zf
         1hZ9nvkdHyo7pM0LLQF7+NrNL/mcKe6gWJ5v8TBA6+I0T9i5N7WA4t59gqnjkrWWRPsq
         N4GIrszLn/xB7vDSpQ9m3PLmplVekbkQuDqd/f85isGWHNrIYn5TWnJ8C2P8Gr5jdeng
         FN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882669; x=1714487469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCK7/eaHPs8ty64f0GbdUkElsClEa9GTcSSsrqNCGZg=;
        b=tBA3CR+MeS7g3Yv4fN8Z5dJNQdoZnlu7SYsJmI6exDvgwekZcUTGazlN0LZdFCE1Oy
         DjlT6aLOd0SMwF5x8AKNen64fxZJcGabnW1YnpxcUzJ0L7lRMUjz9XJgd3y2Qn0GrEXF
         Dxnzljxsgg9zEnfRjoxeD3r53UsjxeHzCVW3XqZv520daOC+cZPc05VwNEJjOST+MyGL
         jNcK/1v8tAfnJQ0+oHmvWnak0BFGcCfgSRbNCDFeaArxdWrTp92Ryhcpw0f5jDgFoKFF
         03J/TTEAFer0QE5oMU5QtdSnZ8rYc+KXGn1W6b4qcgmFiHjNecXlw2BXq7ySmHG+ApgV
         8Zrw==
X-Forwarded-Encrypted: i=1; AJvYcCWcB0JkGsXi7Z2o7V2P5UqZHqFqLHGz4O799cgRKpRdtwuTvPrBXCDk5EbvU9wYeCoE0oTw0oIEFMUfakk8DUmjckI274TcaghnhQBS
X-Gm-Message-State: AOJu0YzSEd0+fhUAogQWBOKJ4s+ZrJF20+ZLesNdarkkMI/BdXI3FLYk
	btjbM2ndDRUdyxTWD9APd31Zgjzj+9nLUrPwBqUJ5JOY2T0RUGhbibxnZ2vWvm0CjcNyUDysM6p
	LYaR0Gg==
X-Google-Smtp-Source: AGHT+IEbWXn1f2adqw4bm8E/gsau8tSZXTX/Y5n1+OxyLK6YmoEP3zqE4BRnY4l/51WnVMGC/uQExw==
X-Received: by 2002:a50:f607:0:b0:570:5bc4:3337 with SMTP id c7-20020a50f607000000b005705bc43337mr6783702edn.40.1713882668822;
        Tue, 23 Apr 2024 07:31:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005704957a968sm6708099edb.13.2024.04.23.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:31:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 15:31:05 +0100
Subject: [PATCH 3/3] clk: samsung: clk-gs101: add cmu_hsi0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-hsi0-gs101-v1-3-2c3ddb50c720@linaro.org>
References: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
In-Reply-To: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

CMU_HSI0 is the clock management unit for one of the high speed
interfaces, which is used (amongst others) for USB

Some notes about the clocks marked as CLK_IGNORE_UNUSED:
* CLK_GOUT_HSI0_PCLK
  CLK_GOUT_HSI0_LHM_AXI_P_HSI0_I_CLK
  CLK_GOUT_HSI0_XIU_P_HSI0_ACLK need to be kept running as
  otherwise the system becomes unresponsive and it doesn't complete
  booting.

* CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_I_CLK
  CLK_GOUT_HSI0_SSMT_USB_ACLK
  CLK_GOUT_HSI0_SSMT_USB_PCLK
  CLK_GOUT_HSI0_SYSMMU_USB_CLK_S2
  CLK_GOUT_HSI0_XIU_D0_HSI0_ACLK
  CLK_GOUT_HSI0_XIU_D1_HSI0_ACLK are needed for USB to come up
  properly (SSMT is for (secure) memory tagging).

While at the moment we only support booting with the clk_ignore_unused
kernel command line paramenter, it's still worthwhile to explicitly
mark those clocks.

While the usual (sed) script has been used to derive the linux clock
names from the data sheet, one manual tweak was applied to fix a typo
coming from the data sheet which we don't want to carry:
    hsi0_uspdpdbg_user -> hsi0_usbdpdbg_user (note usb vs usp).

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note for future reference: To ensure consistent naming throughout this
driver, the clock names have been derived from the data sheet using the
following, with the expectation for all future additions to this file
to use the same:
    sed \
        -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|fout_\L\1_pll|' \
        \
        -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_\(.*\)|mout_\L\1_\2|' \
        -e 's|^PLL_CON0_PLL_\(.*\)|mout_pll_\L\1|' \
        -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|mout_\L\1|' \
        -e '/^PLL_CON[1-4]_[^_]\+_/d' \
        -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
        -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
        \
        -e 's|_IPCLKPORT||' \
        -e 's|_RSTNSYNC||' \
        -e 's|_G4X2_DWC_PCIE_CTL||' \
        -e 's|_G4X1_DWC_PCIE_CTL||' \
        -e 's|_PCIE_SUB_CTRL||' \
        -e 's|_INST_0||g' \
        -e 's|_LN05LPE||' \
        -e 's|_TM_WRAPPER||' \
        -e 's|_SF||' \
        \
        -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_\(.*\)|dout_\L\1_\2|' \
        \
        -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^gout_[^_]\+_[^_]\+_cmu_\([^_]\+\)_pclk$|gout_\1_\1_pclk|' \
        -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|gout_\L\1_clk_\L\1_\2|' \
        \
        -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
---
 drivers/clk/samsung/clk-gs101.c | 468 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 468 insertions(+)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index bd3c1b02715b..f5f12770b88c 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -15,10 +15,12 @@
 
 #include "clk.h"
 #include "clk-exynos-arm64.h"
+#include "clk-pll.h"
 
 /* NOTE: Must be equal to the last clock ID increased by one */
 #define CLKS_NR_TOP	(CLK_GOUT_CMU_TPU_UART + 1)
 #define CLKS_NR_APM	(CLK_APM_PLL_DIV16_APM + 1)
+#define HSI0_NR_CLK	(CLK_GOUT_HSI0_XIU_P_HSI0_ACLK + 1)
 #define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
 #define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
@@ -1919,6 +1921,469 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
 };
 
+/* ---- CMU_HSI0 ------------------------------------------------------------ */
+/* Register Offset definitions for CMU_HSI0 (0x11000000) */
+#define PLL_LOCKTIME_PLL_USB								0x0004
+#define PLL_CON0_PLL_USB								0x0140
+#define PLL_CON1_PLL_USB								0x0144
+#define PLL_CON2_PLL_USB								0x0148
+#define PLL_CON3_PLL_USB								0x014c
+#define PLL_CON4_PLL_USB								0x0150
+#define PLL_CON0_MUX_CLKCMU_HSI0_ALT_USER						0x0600
+#define PLL_CON1_MUX_CLKCMU_HSI0_ALT_USER						0x0604
+#define PLL_CON0_MUX_CLKCMU_HSI0_BUS_USER						0x0610
+#define PLL_CON1_MUX_CLKCMU_HSI0_BUS_USER						0x0614
+#define PLL_CON0_MUX_CLKCMU_HSI0_DPGTC_USER						0x0620
+#define PLL_CON1_MUX_CLKCMU_HSI0_DPGTC_USER						0x0624
+#define PLL_CON0_MUX_CLKCMU_HSI0_TCXO_USER						0x0630
+#define PLL_CON1_MUX_CLKCMU_HSI0_TCXO_USER						0x0634
+#define PLL_CON0_MUX_CLKCMU_HSI0_USB20_USER						0x0640
+#define PLL_CON1_MUX_CLKCMU_HSI0_USB20_USER						0x0644
+#define PLL_CON0_MUX_CLKCMU_HSI0_USB31DRD_USER						0x0650
+#define PLL_CON1_MUX_CLKCMU_HSI0_USB31DRD_USER						0x0654
+#define PLL_CON0_MUX_CLKCMU_HSI0_USPDPDBG_USER						0x0660
+#define PLL_CON1_MUX_CLKCMU_HSI0_USPDPDBG_USER						0x0664
+#define HSI0_CMU_HSI0_CONTROLLER_OPTION							0x0800
+#define CLKOUT_CON_BLK_HSI0_CMU_HSI0_CLKOUT0						0x0810
+#define CLK_CON_MUX_MUX_CLK_HSI0_BUS							0x1000
+#define CLK_CON_MUX_MUX_CLK_HSI0_USB20_REF						0x1004
+#define CLK_CON_MUX_MUX_CLK_HSI0_USB31DRD						0x1008
+#define CLK_CON_DIV_DIV_CLK_HSI0_USB31DRD						0x1800
+#define CLK_CON_GAT_CLK_BLK_HSI0_UID_HSI0_CMU_HSI0_IPCLKPORT_PCLK			0x2000
+#define CLK_CON_GAT_CLK_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_SUSPEND_CLK_26	0x2004
+#define CLK_CON_GAT_CLK_HSI0_ALT							0x2008
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_DP_GTC_CLK			0x200c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_PCLK				0x2010
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_D_TZPC_HSI0_IPCLKPORT_PCLK			0x2014
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_ACLK				0x2018
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_PCLK				0x201c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_GPC_HSI0_IPCLKPORT_PCLK				0x2020
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_G_ETR_HSI0_IPCLKPORT_I_CLK		0x2024
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_AOCHSI0_IPCLKPORT_I_CLK			0x2028
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_HSI0_IPCLKPORT_I_CLK			0x202c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_ACEL_D_HSI0_IPCLKPORT_I_CLK			0x2030
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_AXI_D_HSI0AOC_IPCLKPORT_I_CLK			0x2034
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_ACLK			0x2038
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_PCLK			0x203c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_ACLK			0x2040
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_PCLK			0x2044
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_RSTNSYNC_CLK_HSI0_BUS_IPCLKPORT_CLK		0x2048
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_ACLK				0x204c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_PCLK				0x2050
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSMMU_USB_IPCLKPORT_CLK_S2			0x2054
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSREG_HSI0_IPCLKPORT_PCLK			0x2058
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_ACLK			0x205c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_PCLK			0x2060
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_ACLK			0x2064
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_PCLK			0x2068
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_ACLK_PHYCTRL			0x206c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_BUS_CLK_EARLY			0x2070
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB20_PHY_REFCLK_26		0x2074
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_REF_CLK_40		0x2078
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_REF_SOC_PLL		0x207c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_SCL_APB_PCLK	0x2080
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBPCS_APB_CLK		0x2084
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_I_ACLK		0x2088
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_UDBG_I_APB_PCLK	0x208c
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D0_HSI0_IPCLKPORT_ACLK			0x2090
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D1_HSI0_IPCLKPORT_ACLK			0x2094
+#define CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_P_HSI0_IPCLKPORT_ACLK				0x2098
+#define DMYQCH_CON_USB31DRD_QCH								0x3000
+#define DMYQCH_CON_USB31DRD_QCH_REF							0x3004
+#define PCH_CON_LHM_AXI_G_ETR_HSI0_PCH							0x3008
+#define PCH_CON_LHM_AXI_P_AOCHSI0_PCH							0x300c
+#define PCH_CON_LHM_AXI_P_HSI0_PCH							0x3010
+#define PCH_CON_LHS_ACEL_D_HSI0_PCH							0x3014
+#define PCH_CON_LHS_AXI_D_HSI0AOC_PCH							0x3018
+#define QCH_CON_DP_LINK_QCH_GTC_CLK							0x301c
+#define QCH_CON_DP_LINK_QCH_PCLK							0x3020
+#define QCH_CON_D_TZPC_HSI0_QCH								0x3024
+#define QCH_CON_ETR_MIU_QCH_ACLK							0x3028
+#define QCH_CON_ETR_MIU_QCH_PCLK							0x302c
+#define QCH_CON_GPC_HSI0_QCH								0x3030
+#define QCH_CON_HSI0_CMU_HSI0_QCH							0x3034
+#define QCH_CON_LHM_AXI_G_ETR_HSI0_QCH							0x3038
+#define QCH_CON_LHM_AXI_P_AOCHSI0_QCH							0x303c
+#define QCH_CON_LHM_AXI_P_HSI0_QCH							0x3040
+#define QCH_CON_LHS_ACEL_D_HSI0_QCH							0x3044
+#define QCH_CON_LHS_AXI_D_HSI0AOC_QCH							0x3048
+#define QCH_CON_PPMU_HSI0_AOC_QCH							0x304c
+#define QCH_CON_PPMU_HSI0_BUS0_QCH							0x3050
+#define QCH_CON_SSMT_USB_QCH								0x3054
+#define QCH_CON_SYSMMU_USB_QCH								0x3058
+#define QCH_CON_SYSREG_HSI0_QCH								0x305c
+#define QCH_CON_UASC_HSI0_CTRL_QCH							0x3060
+#define QCH_CON_UASC_HSI0_LINK_QCH							0x3064
+#define QCH_CON_USB31DRD_QCH_APB							0x3068
+#define QCH_CON_USB31DRD_QCH_DBG							0x306c
+#define QCH_CON_USB31DRD_QCH_PCS							0x3070
+#define QCH_CON_USB31DRD_QCH_SLV_CTRL							0x3074
+#define QCH_CON_USB31DRD_QCH_SLV_LINK							0x3078
+#define QUEUE_CTRL_REG_BLK_HSI0_CMU_HSI0						0x3c00
+
+static const unsigned long hsi0_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_USB,
+	PLL_CON0_PLL_USB,
+	PLL_CON1_PLL_USB,
+	PLL_CON2_PLL_USB,
+	PLL_CON3_PLL_USB,
+	PLL_CON4_PLL_USB,
+	PLL_CON0_MUX_CLKCMU_HSI0_ALT_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_ALT_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_BUS_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_DPGTC_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_DPGTC_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_TCXO_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_TCXO_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_USB20_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_USB20_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_USB31DRD_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_USB31DRD_USER,
+	PLL_CON0_MUX_CLKCMU_HSI0_USPDPDBG_USER,
+	PLL_CON1_MUX_CLKCMU_HSI0_USPDPDBG_USER,
+	HSI0_CMU_HSI0_CONTROLLER_OPTION,
+	CLKOUT_CON_BLK_HSI0_CMU_HSI0_CLKOUT0,
+	CLK_CON_MUX_MUX_CLK_HSI0_BUS,
+	CLK_CON_MUX_MUX_CLK_HSI0_USB20_REF,
+	CLK_CON_MUX_MUX_CLK_HSI0_USB31DRD,
+	CLK_CON_DIV_DIV_CLK_HSI0_USB31DRD,
+	CLK_CON_GAT_CLK_BLK_HSI0_UID_HSI0_CMU_HSI0_IPCLKPORT_PCLK,
+	CLK_CON_GAT_CLK_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_SUSPEND_CLK_26,
+	CLK_CON_GAT_CLK_HSI0_ALT,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_DP_GTC_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_D_TZPC_HSI0_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_GPC_HSI0_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_G_ETR_HSI0_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_AOCHSI0_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_HSI0_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_ACEL_D_HSI0_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_AXI_D_HSI0AOC_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_RSTNSYNC_CLK_HSI0_BUS_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSMMU_USB_IPCLKPORT_CLK_S2,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSREG_HSI0_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_ACLK_PHYCTRL,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_BUS_CLK_EARLY,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB20_PHY_REFCLK_26,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_REF_CLK_40,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_REF_SOC_PLL,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_SCL_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBPCS_APB_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_UDBG_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D0_HSI0_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D1_HSI0_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_P_HSI0_IPCLKPORT_ACLK,
+	DMYQCH_CON_USB31DRD_QCH,
+	DMYQCH_CON_USB31DRD_QCH_REF,
+	PCH_CON_LHM_AXI_G_ETR_HSI0_PCH,
+	PCH_CON_LHM_AXI_P_AOCHSI0_PCH,
+	PCH_CON_LHM_AXI_P_HSI0_PCH,
+	PCH_CON_LHS_ACEL_D_HSI0_PCH,
+	PCH_CON_LHS_AXI_D_HSI0AOC_PCH,
+	QCH_CON_DP_LINK_QCH_GTC_CLK,
+	QCH_CON_DP_LINK_QCH_PCLK,
+	QCH_CON_D_TZPC_HSI0_QCH,
+	QCH_CON_ETR_MIU_QCH_ACLK,
+	QCH_CON_ETR_MIU_QCH_PCLK,
+	QCH_CON_GPC_HSI0_QCH,
+	QCH_CON_HSI0_CMU_HSI0_QCH,
+	QCH_CON_LHM_AXI_G_ETR_HSI0_QCH,
+	QCH_CON_LHM_AXI_P_AOCHSI0_QCH,
+	QCH_CON_LHM_AXI_P_HSI0_QCH,
+	QCH_CON_LHS_ACEL_D_HSI0_QCH,
+	QCH_CON_LHS_AXI_D_HSI0AOC_QCH,
+	QCH_CON_PPMU_HSI0_AOC_QCH,
+	QCH_CON_PPMU_HSI0_BUS0_QCH,
+	QCH_CON_SSMT_USB_QCH,
+	QCH_CON_SYSMMU_USB_QCH,
+	QCH_CON_SYSREG_HSI0_QCH,
+	QCH_CON_UASC_HSI0_CTRL_QCH,
+	QCH_CON_UASC_HSI0_LINK_QCH,
+	QCH_CON_USB31DRD_QCH_APB,
+	QCH_CON_USB31DRD_QCH_DBG,
+	QCH_CON_USB31DRD_QCH_PCS,
+	QCH_CON_USB31DRD_QCH_SLV_CTRL,
+	QCH_CON_USB31DRD_QCH_SLV_LINK,
+	QUEUE_CTRL_REG_BLK_HSI0_CMU_HSI0,
+};
+
+/* List of parent clocks for Muxes in CMU_HSI0 */
+PNAME(mout_pll_usb_p)			= { "oscclk", "fout_usb_pll" };
+PNAME(mout_hsi0_alt_user_p)		= { "oscclk",
+					    "gout_hsi0_clk_hsi0_alt" };
+PNAME(mout_hsi0_bus_user_p)		= { "oscclk", "dout_cmu_hsi0_bus" };
+PNAME(mout_hsi0_dpgtc_user_p)		= { "oscclk", "dout_cmu_hsi0_dpgtc" };
+PNAME(mout_hsi0_tcxo_user_p)		= { "oscclk", "tcxo_hsi1_hsi0" };
+PNAME(mout_hsi0_usb20_user_p)		= { "oscclk", "usb20phy_phy_clock" };
+PNAME(mout_hsi0_usb31drd_user_p)	= { "oscclk",
+					    "dout_cmu_hsi0_usb31drd" };
+PNAME(mout_hsi0_usbdpdbg_user_p)	= { "oscclk",
+					    "dout_cmu_hsi0_usbdpdbg" };
+PNAME(mout_hsi0_bus_p)			= { "mout_hsi0_bus_user",
+					    "mout_hsi0_alt_user" };
+PNAME(mout_hsi0_usb20_ref_p)		= { "fout_usb_pll",
+					    "mout_hsi0_tcxo_user" };
+PNAME(mout_hsi0_usb31drd_p)		= { "fout_usb_pll",
+					    "mout_hsi0_usb31drd_user",
+					    "dout_hsi0_usb31drd",
+					    "fout_usb_pll" };
+
+static const struct samsung_pll_rate_table cmu_hsi0_usb_pll_rates[] __initconst = {
+	PLL_35XX_RATE(24576000, 19200000, 150, 6, 5),
+	{ /* sentinel */ }
+};
+
+static const struct samsung_pll_clock cmu_hsi0_pll_clks[] __initconst = {
+	PLL(pll_0518x, CLK_FOUT_USB_PLL, "fout_usb_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_USB, PLL_CON3_PLL_USB,
+	    cmu_hsi0_usb_pll_rates),
+};
+
+static const struct samsung_mux_clock hsi0_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_PLL_USB,
+	    "mout_pll_usb", mout_pll_usb_p,
+	    PLL_CON0_PLL_USB, 4, 1),
+	MUX(CLK_MOUT_HSI0_ALT_USER,
+	    "mout_hsi0_alt_user", mout_hsi0_alt_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_ALT_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_BUS_USER,
+	    "mout_hsi0_bus_user", mout_hsi0_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_DPGTC_USER,
+	    "mout_hsi0_dpgtc_user", mout_hsi0_dpgtc_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_DPGTC_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_TCXO_USER,
+	    "mout_hsi0_tcxo_user", mout_hsi0_tcxo_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_TCXO_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_USB20_USER,
+	    "mout_hsi0_usb20_user", mout_hsi0_usb20_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_USB20_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_USB31DRD_USER,
+	    "mout_hsi0_usb31drd_user", mout_hsi0_usb31drd_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_USB31DRD_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_USBDPDBG_USER,
+	    "mout_hsi0_usbdpdbg_user", mout_hsi0_usbdpdbg_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI0_USPDPDBG_USER, 4, 1),
+	MUX(CLK_MOUT_HSI0_BUS,
+	    "mout_hsi0_bus", mout_hsi0_bus_p,
+	    CLK_CON_MUX_MUX_CLK_HSI0_BUS, 0, 1),
+	MUX(CLK_MOUT_HSI0_USB20_REF,
+	    "mout_hsi0_usb20_ref", mout_hsi0_usb20_ref_p,
+	    CLK_CON_MUX_MUX_CLK_HSI0_USB20_REF, 0, 1),
+	MUX(CLK_MOUT_HSI0_USB31DRD,
+	    "mout_hsi0_usb31drd", mout_hsi0_usb31drd_p,
+	    CLK_CON_MUX_MUX_CLK_HSI0_USB31DRD, 0, 2),
+};
+
+static const struct samsung_div_clock hsi0_div_clks[] __initconst = {
+	DIV(CLK_DOUT_HSI0_USB31DRD,
+	    "dout_hsi0_usb31drd", "mout_hsi0_usb20_user",
+	    CLK_CON_DIV_DIV_CLK_HSI0_USB31DRD, 0, 3),
+};
+
+static const struct samsung_gate_clock hsi0_gate_clks[] __initconst = {
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_PCLK,
+	     "gout_hsi0_hsi0_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_CLK_BLK_HSI0_UID_HSI0_CMU_HSI0_IPCLKPORT_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_SUSPEND_CLK_26,
+	     "gout_hsi0_usb31drd_i_usb31drd_suspend_clk_26",
+	     "mout_hsi0_usb20_ref",
+	     CLK_CON_GAT_CLK_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_SUSPEND_CLK_26,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_CLK_HSI0_ALT,
+	     "gout_hsi0_clk_hsi0_alt", "ioclk_clk_hsi0_alt",
+	     CLK_CON_GAT_CLK_HSI0_ALT, 21, 0, 0),
+	GATE(CLK_GOUT_HSI0_DP_LINK_I_DP_GTC_CLK,
+	     "gout_hsi0_dp_link_i_dp_gtc_clk", "mout_hsi0_dpgtc_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_DP_GTC_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_DP_LINK_I_PCLK,
+	     "gout_hsi0_dp_link_i_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_DP_LINK_IPCLKPORT_I_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK,
+	     "gout_hsi0_d_tzpc_hsi0_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_D_TZPC_HSI0_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_ETR_MIU_I_ACLK,
+	     "gout_hsi0_etr_miu_i_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI0_ETR_MIU_I_PCLK,
+	     "gout_hsi0_etr_miu_i_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_ETR_MIU_IPCLKPORT_I_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI0_GPC_HSI0_PCLK,
+	     "gout_hsi0_gpc_hsi0_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_GPC_HSI0_IPCLKPORT_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI0_LHM_AXI_G_ETR_HSI0_I_CLK,
+	     "gout_hsi0_lhm_axi_g_etr_hsi0_i_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_G_ETR_HSI0_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_LHM_AXI_P_AOCHSI0_I_CLK,
+	     "gout_hsi0_lhm_axi_p_aochsi0_i_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_AOCHSI0_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_LHM_AXI_P_HSI0_I_CLK,
+	     "gout_hsi0_lhm_axi_p_hsi0_i_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHM_AXI_P_HSI0_IPCLKPORT_I_CLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_I_CLK,
+	     "gout_hsi0_lhs_acel_d_hsi0_i_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_ACEL_D_HSI0_IPCLKPORT_I_CLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI0_LHS_AXI_D_HSI0AOC_I_CLK,
+	     "gout_hsi0_lhs_axi_d_hsi0aoc_i_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_AXI_D_HSI0AOC_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_PPMU_HSI0_AOC_ACLK,
+	     "gout_hsi0_ppmu_hsi0_aoc_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_PPMU_HSI0_AOC_PCLK,
+	     "gout_hsi0_ppmu_hsi0_aoc_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_AOC_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_PPMU_HSI0_BUS0_ACLK,
+	     "gout_hsi0_ppmu_hsi0_bus0_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_PPMU_HSI0_BUS0_PCLK,
+	     "gout_hsi0_ppmu_hsi0_bus0_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_PPMU_HSI0_BUS0_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_CLK_HSI0_BUS_CLK,
+	     "gout_hsi0_clk_hsi0_bus_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_RSTNSYNC_CLK_HSI0_BUS_IPCLKPORT_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_SSMT_USB_ACLK,
+	     "gout_hsi0_ssmt_usb_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_SSMT_USB_PCLK,
+	     "gout_hsi0_ssmt_usb_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_SSMT_USB_IPCLKPORT_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_SYSMMU_USB_CLK_S2,
+	     "gout_hsi0_sysmmu_usb_clk_s2", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSMMU_USB_IPCLKPORT_CLK_S2,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI0_SYSREG_HSI0_PCLK,
+	     "gout_hsi0_sysreg_hsi0_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_SYSREG_HSI0_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_UASC_HSI0_CTRL_ACLK,
+	     "gout_hsi0_uasc_hsi0_ctrl_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_UASC_HSI0_CTRL_PCLK,
+	     "gout_hsi0_uasc_hsi0_ctrl_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_CTRL_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_UASC_HSI0_LINK_ACLK,
+	     "gout_hsi0_uasc_hsi0_link_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_UASC_HSI0_LINK_PCLK,
+	     "gout_hsi0_uasc_hsi0_link_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_UASC_HSI0_LINK_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_ACLK_PHYCTRL,
+	     "gout_hsi0_usb31drd_aclk_phyctrl", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_ACLK_PHYCTRL,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_BUS_CLK_EARLY,
+	     "gout_hsi0_usb31drd_bus_clk_early", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_BUS_CLK_EARLY,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USB20_PHY_REFCLK_26,
+	     "gout_hsi0_usb31drd_i_usb20_phy_refclk_26", "mout_hsi0_usb20_ref",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB20_PHY_REFCLK_26,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_REF_CLK_40,
+	     "gout_hsi0_usb31drd_i_usb31drd_ref_clk_40", "mout_hsi0_usb31drd",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USB31DRD_REF_CLK_40,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_REF_SOC_PLL,
+	     "gout_hsi0_usb31drd_i_usbdpphy_ref_soc_pll",
+	     "mout_hsi0_usbdpdbg_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_REF_SOC_PLL,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_SCL_APB_PCLK,
+	     "gout_hsi0_usb31drd_i_usbdpphy_scl_apb_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBDPPHY_SCL_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_I_USBPCS_APB_CLK,
+	     "gout_hsi0_usb31drd_i_usbpcs_apb_clk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_I_USBPCS_APB_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_USBDPPHY_I_ACLK,
+	     "gout_hsi0_usb31drd_usbdpphy_i_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_I_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI0_USB31DRD_USBDPPHY_UDBG_I_APB_PCLK,
+	     "gout_hsi0_usb31drd_usbdpphy_udbg_i_apb_pclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_USB31DRD_IPCLKPORT_USBDPPHY_UDBG_I_APB_PCLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_XIU_D0_HSI0_ACLK,
+	     "gout_hsi0_xiu_d0_hsi0_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D0_HSI0_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_XIU_D1_HSI0_ACLK,
+	     "gout_hsi0_xiu_d1_hsi0_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D1_HSI0_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI0_XIU_P_HSI0_ACLK,
+	     "gout_hsi0_xiu_p_hsi0_aclk", "mout_hsi0_bus",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_P_HSI0_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_fixed_rate_clock hsi0_fixed_clks[] __initconst = {
+	FRATE(0, "tcxo_hsi1_hsi0", NULL, 0, 26000000),
+	FRATE(0, "usb20phy_phy_clock", NULL, 0, 120000000),
+	/* until we implement APMGSA */
+	FRATE(0, "ioclk_clk_hsi0_alt", NULL, 0, 213000000),
+};
+
+static const struct samsung_cmu_info hsi0_cmu_info __initconst = {
+	.pll_clks		= cmu_hsi0_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(cmu_hsi0_pll_clks),
+	.mux_clks		= hsi0_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(hsi0_mux_clks),
+	.div_clks		= hsi0_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(hsi0_div_clks),
+	.gate_clks		= hsi0_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(hsi0_gate_clks),
+	.fixed_clks		= hsi0_fixed_clks,
+	.nr_fixed_clks		= ARRAY_SIZE(hsi0_fixed_clks),
+	.nr_clk_ids		= HSI0_NR_CLK,
+	.clk_regs		= hsi0_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(hsi0_clk_regs),
+	.clk_name		= "bus",
+};
+
 /* ---- CMU_MISC ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_MISC (0x10010000) */
@@ -3441,6 +3906,9 @@ static const struct of_device_id gs101_cmu_of_match[] = {
 	{
 		.compatible = "google,gs101-cmu-apm",
 		.data = &apm_cmu_info,
+	}, {
+		.compatible = "google,gs101-cmu-hsi0",
+		.data = &hsi0_cmu_info,
 	}, {
 		.compatible = "google,gs101-cmu-peric0",
 		.data = &peric0_cmu_info,

-- 
2.44.0.769.g3c40516874-goog


