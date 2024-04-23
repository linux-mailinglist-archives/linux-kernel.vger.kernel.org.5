Return-Path: <linux-kernel+bounces-155377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B908AE98C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57D01F255D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBFA657DB;
	Tue, 23 Apr 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pe77vCGy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760413BAD9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882672; cv=none; b=bIoVbBx+9e3nAMl9TXjnjvYkZt6BLR7pKGSJTYEzk2a36ao8E9TuCqtgQ6a8rOZuwIgwjgfab4NeIdsJzMYWhRPf8H+XiNYSLG6vpNaZkt0oDW/iHz4armgXEQRaXhjc/Kc+5bgI0u8Y/77Digs9iTjDZRZQPPKVFG2ixmGBkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882672; c=relaxed/simple;
	bh=dkgyIeuA/rSLVwh0yr2LhHaoKvHARceOejcXP6+Bw+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWsNgOxRjH7Qe+VTUn6ENtGAFkUyNv0RGnbW1FtiacCwjJU0pD9rKA52Dunj+0slvteJwLIwNnGLwCxSbaOmLAZe0ZhTR9OcOMPJ+Zk0sYmFjlIPeqGN/uYcv7/FPnFDh38k8l/WiF6cjheFzZKLihpIeYS8wF5WHhBbJZF8ffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pe77vCGy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572040691c9so4488874a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713882668; x=1714487468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOCRkzqatq7AAsS01se7sveW2XHdbFtybSCUQL6wBPA=;
        b=pe77vCGyVdj1pewbtjXWejr7TTELLtzTJ8dgOFgPiGEjkpWQfE1OPbkRNEgjJse7jV
         S4m9m1aFqVfD1wtBeD4PFunbC2Ps0pyb4kSLqFL8oqcWturxr6MF6yeGOCFktfXNaLvk
         495IZrwe3VFF3RVR13y9uc9KJW/xdVvQWymX+K+9cStJpEGB1P7641HhMeLR52q3ZvLi
         W6Lc8J2SjfzGFSKcz9o9ZMjgMKT3i2IShTZw65pYBaFVukH57muiDcvedMFpk5LcA5Dn
         W2afAKOJcoIuuRMQ2zlrYdEfKRzEjGcCmk0mLU8vrhb+mvVme2dwHTicm1SaYNvDGu3G
         NFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882668; x=1714487468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOCRkzqatq7AAsS01se7sveW2XHdbFtybSCUQL6wBPA=;
        b=B59QEt9GRVSGewS/3Edf5qP23FIo7fg+Kp186Y6VTAS9YsI/1sdFeGNVsN+kyjKcpW
         SjIyHXW870F3SqR16fzfv+JZjsPBPRfc+llR83plm88ZGqenTAhvWCwKid9Ed3ojJPsD
         OKGuewjBjutsj4x3wUz3sLXPZtY1hHWlRdnfDwaB/j/qyU3xxi/eWSOgc8rg41ELlnMf
         8vW+3NvSeJw3J3xGc18E0s51X4FogDS6B6X4nGOOM5t6J/ToX+tBjBGIh4NIToA97Zjn
         uX6a7iqr9kz6aLufOXLEyBOjsG5a+dgLmNaYollQD+PMaQvU7aBxwN2XulVMY8FgjO6y
         dFdw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHk/5x58YtHiLOvXIBDz4ihDEHhkkrDFBxG6gVI2SE7zQ3kpzhEEg9Kj3Puk5SqgcMQ2dX/iNnClJJInWwtbxIKp76MedVVZELN8w
X-Gm-Message-State: AOJu0Yz8NpmcuPBm2XFSHhXuIJMh3hQX1v2IVu9qZiCuXwaB20iOjy7j
	G4/5d3hzyYwUyR/PhlBQSnLqRzXekKuTqP9a6bJUvyGPQAbfY+WE1/+/XE8ZsWk=
X-Google-Smtp-Source: AGHT+IENg9Nj05PS+wIkYuBbbKydukDUSO/epgsZ1tRfqOWpx2DEydIj7ZT9LTYXUHPoW9ncGQV2wg==
X-Received: by 2002:a50:a41d:0:b0:571:b82f:630d with SMTP id u29-20020a50a41d000000b00571b82f630dmr3143078edb.0.1713882667926;
        Tue, 23 Apr 2024 07:31:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005704957a968sm6708099edb.13.2024.04.23.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:31:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 23 Apr 2024 15:31:03 +0100
Subject: [PATCH 1/3] dt-bindings: clock: google,gs101-clock: add HSI0 clock
 management unit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-hsi0-gs101-v1-1-2c3ddb50c720@linaro.org>
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

Add dt-schema documentation and clock IDs for the high speed interface
0 HSI0 clock management unit. This is used (amongst others) for USB.

While the usual (sed) script has been used to derive the linux clock
IDs from the data sheet, one manual tweak was applied to fix a typo
which we don't want to carry:
    HSI0_USPDPDBG_USER -> HSI0_USBDPDBG_USER (note USB vs USP).

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note for future reference: To ensure consistent naming throughout this
driver, the IDs have been derived from the data sheet using the
following, with the expectation for all future additions to this file
to use the same:
    sed \
        -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|CLK_FOUT_\1_PLL|' \
        \
        -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_|CLK_MOUT_\1_|' \
        -e 's|^PLL_CON0_PLL_\(.*\)|CLK_MOUT_PLL_\1|' \
        -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|CLK_MOUT_\1|' \
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
        -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_|CLK_DOUT_\1_|' \
        \
        -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_|CLK_GOUT_\1_|' \
        -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
        -e 's|^CLK_GOUT_[^_]\+_[^_]\+_CMU_\([^_]\+\)_PCLK$|CLK_GOUT_\1_PCLK|' \
        -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
        -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|CLK_GOUT_\1_CLK_\1_\2|' \
        \
        -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
---
 .../bindings/clock/google,gs101-clock.yaml         | 29 +++++++++++-
 include/dt-bindings/clock/google,gs101.h           | 54 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 1d2bcea41c85..94dcc4f84c85 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -30,16 +30,17 @@ properties:
       - google,gs101-cmu-top
       - google,gs101-cmu-apm
       - google,gs101-cmu-misc
+      - google,gs101-cmu-hsi0
       - google,gs101-cmu-peric0
       - google,gs101-cmu-peric1
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   "#clock-cells":
     const: 1
@@ -72,6 +73,30 @@ allOf:
           items:
             - const: oscclk
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-cmu-hsi0
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24.576 MHz)
+            - description: HSI0 bus clock (from CMU_TOP)
+            - description: DPGTC (from CMU_TOP)
+            - description: USB DRD controller clock (from CMU_TOP)
+            - description: USB Display Port debug clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: bus
+            - const: dpgtc
+            - const: usb31drd
+            - const: usbdpdbg
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindings/clock/google,gs101.h
index 3dac3577788a..7a2006f0edf1 100644
--- a/include/dt-bindings/clock/google,gs101.h
+++ b/include/dt-bindings/clock/google,gs101.h
@@ -313,6 +313,60 @@
 #define CLK_APM_PLL_DIV4_APM				70
 #define CLK_APM_PLL_DIV16_APM				71
 
+/* CMU_HSI0 */
+#define CLK_FOUT_USB_PLL					1
+#define CLK_MOUT_PLL_USB					2
+#define CLK_MOUT_HSI0_ALT_USER					3
+#define CLK_MOUT_HSI0_BUS_USER					4
+#define CLK_MOUT_HSI0_DPGTC_USER				5
+#define CLK_MOUT_HSI0_TCXO_USER					6
+#define CLK_MOUT_HSI0_USB20_USER				7
+#define CLK_MOUT_HSI0_USB31DRD_USER				8
+#define CLK_MOUT_HSI0_USBDPDBG_USER				9
+#define CLK_MOUT_HSI0_BUS					10
+#define CLK_MOUT_HSI0_USB20_REF					11
+#define CLK_MOUT_HSI0_USB31DRD					12
+#define CLK_DOUT_HSI0_USB31DRD					13
+#define CLK_GOUT_HSI0_PCLK					14
+#define CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_SUSPEND_CLK_26	15
+#define CLK_GOUT_HSI0_CLK_HSI0_ALT				16
+#define CLK_GOUT_HSI0_DP_LINK_I_DP_GTC_CLK			17
+#define CLK_GOUT_HSI0_DP_LINK_I_PCLK				18
+#define CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK				19
+#define CLK_GOUT_HSI0_ETR_MIU_I_ACLK				20
+#define CLK_GOUT_HSI0_ETR_MIU_I_PCLK				21
+#define CLK_GOUT_HSI0_GPC_HSI0_PCLK				22
+#define CLK_GOUT_HSI0_LHM_AXI_G_ETR_HSI0_I_CLK			23
+#define CLK_GOUT_HSI0_LHM_AXI_P_AOCHSI0_I_CLK			24
+#define CLK_GOUT_HSI0_LHM_AXI_P_HSI0_I_CLK			25
+#define CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_I_CLK			26
+#define CLK_GOUT_HSI0_LHS_AXI_D_HSI0AOC_I_CLK			27
+#define CLK_GOUT_HSI0_PPMU_HSI0_AOC_ACLK			28
+#define CLK_GOUT_HSI0_PPMU_HSI0_AOC_PCLK			29
+#define CLK_GOUT_HSI0_PPMU_HSI0_BUS0_ACLK			30
+#define CLK_GOUT_HSI0_PPMU_HSI0_BUS0_PCLK			31
+#define CLK_GOUT_HSI0_CLK_HSI0_BUS_CLK				32
+#define CLK_GOUT_HSI0_SSMT_USB_ACLK				33
+#define CLK_GOUT_HSI0_SSMT_USB_PCLK				34
+#define CLK_GOUT_HSI0_SYSMMU_USB_CLK_S2				35
+#define CLK_GOUT_HSI0_SYSREG_HSI0_PCLK				36
+#define CLK_GOUT_HSI0_UASC_HSI0_CTRL_ACLK			37
+#define CLK_GOUT_HSI0_UASC_HSI0_CTRL_PCLK			38
+#define CLK_GOUT_HSI0_UASC_HSI0_LINK_ACLK			39
+#define CLK_GOUT_HSI0_UASC_HSI0_LINK_PCLK			40
+#define CLK_GOUT_HSI0_USB31DRD_ACLK_PHYCTRL			41
+#define CLK_GOUT_HSI0_USB31DRD_BUS_CLK_EARLY			42
+#define CLK_GOUT_HSI0_USB31DRD_I_USB20_PHY_REFCLK_26		43
+#define CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_REF_CLK_40		44
+#define CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_REF_SOC_PLL		45
+#define CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_SCL_APB_PCLK		46
+#define CLK_GOUT_HSI0_USB31DRD_I_USBPCS_APB_CLK			47
+#define CLK_GOUT_HSI0_USB31DRD_USBDPPHY_I_ACLK			48
+#define CLK_GOUT_HSI0_USB31DRD_USBDPPHY_UDBG_I_APB_PCLK		49
+#define CLK_GOUT_HSI0_XIU_D0_HSI0_ACLK				50
+#define CLK_GOUT_HSI0_XIU_D1_HSI0_ACLK				51
+#define CLK_GOUT_HSI0_XIU_P_HSI0_ACLK				52
+
 /* CMU_MISC */
 #define CLK_MOUT_MISC_BUS_USER				1
 #define CLK_MOUT_MISC_SSS_USER				2

-- 
2.44.0.769.g3c40516874-goog


