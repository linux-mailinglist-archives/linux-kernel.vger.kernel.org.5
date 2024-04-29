Return-Path: <linux-kernel+bounces-162320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D168B595A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CB1C2407A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13782D75;
	Mon, 29 Apr 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrl3p4N0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490870CCC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395755; cv=none; b=h/08/WIV19gGPcU3V1kZE43sBaHcQkKxRHhMEw96k7jCyNe0b4Jn5ysO5zKUCwejtTtTVhZU82JWWIVQxmrIdk02w0p/2Y+UDSdQ5qCuL361+BppOSitpf1KlrViQf7H6MFkV5eezLzpmYF77HwQDdLHQa7KSa+PD9ZDd1QEoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395755; c=relaxed/simple;
	bh=souQkvB4qPbke1dYKM4tTRIWixsgu5wPMcr9P+Y23Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR3rpR4fQnZWhOIFVXogMni1vcMiAfWyz1yUpDDsBNeFKlLJPBlzp74DoC2QTR+Z6NUVwmOUaK+ccl9MzlG7JkXnm0rxvUFmH+nZ1QwkILXzR9lfqlyKUd433RS6KnOfbsMDwTOAaBSRPNYw9Atu08D4HgQsWUmEc4o9nV1Pvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrl3p4N0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5878caeb9eso548845166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714395750; x=1715000550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW7VXSKIBcKSx5fQyl4uhYsLSd/yhpxk7VKGos0HkKs=;
        b=rrl3p4N0QR05onLUD3g/zDbZs0DFl6iyp+JKRqmGE/Xevlyd6GUFWIv9LAB1Mdu3w7
         9eFTqCytk/zu8Xqh3kmOZmPL7RAF2c8c/JQyIXbH73o0mMSsFokoLM7nigbrLxwuKQr+
         jH22A7QLt+n2x1xvXuCPLf0DsttyuOBNeqKuuNW+xqJO9f0j2wkS7jQ29I1ga8BAqlBw
         oDl8cAz6OYGCStlLlimkvRgJzRdVJAmYc/8aplLrYYrnq80hH2YKBpOh+bvUodVTZ7qy
         db1sHgmNjvRDk4BKpG0CurhfLqdx/qXnHkehrBLUI/NX5R1pFy1/ayhvoEgGk0qsmj0x
         1lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395750; x=1715000550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW7VXSKIBcKSx5fQyl4uhYsLSd/yhpxk7VKGos0HkKs=;
        b=r+j9RiVrEuxGNZtYKGLasMalPYQYBW16T4yB8Iu5wasU6TXKVmfiwG2owbkwNrN+eK
         Xutyzy5q8bRyxh7ELO8Ehn8fp4qDY9aSsgfAXtEiDNke2LIuK03UALWH9linwM4LviwB
         3Ra09puvL1j4Ac/yoKw7UIh8AIozNhbpP7Bbd0Me+szgH14Z7uMnog3H1+RHA97ah9XN
         7brl807OUFbC89gaVLPdo7KK8oydTZw2xEo6TrZxihPJQnVsywbrm/wOwmJgrTW8sFjJ
         L7aP6g4c3duUQEpVTVxZpW86mhkwfuyyEHp+wx0eMH4VMAP15gzTKLjiYEA8BaYE1Yaz
         UCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGfkWXY2ssBWm+peI7OyHzER15epFD/B4eagAYoxauzSPylVP/Gl0oGemw427419DyQvnim1+9EnmRI2isdiCAlzSioETG8ePSAhyk
X-Gm-Message-State: AOJu0Yx6ofbnGPtGuP1/O2WR6FdwCx28rxEIXot5qSozWFNWQHyp1KAY
	BKy3MCrqyeaRiou0FtjV6LLN18C9Vwoi8p3FfuSNCYMgcd6MRBQf0M+FPaFAI0g=
X-Google-Smtp-Source: AGHT+IF4XsRqgn1x9uRlZH7xFzGp9WlOEXktwC76GIbRwaxrhA8LJhKKgfu4Lm7oHkkdDtE5+VKgUg==
X-Received: by 2002:a17:906:3752:b0:a55:6f6c:3bae with SMTP id e18-20020a170906375200b00a556f6c3baemr6398930ejc.0.1714395750469;
        Mon, 29 Apr 2024 06:02:30 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm9976074ejc.79.2024.04.29.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:02:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 14:02:17 +0100
Subject: [PATCH v3 1/3] dt-bindings: clock: google,gs101-clock: add HSI2
 clock management unit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-hsi0-gs101-v3-1-f233be0a2455@linaro.org>
References: <20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org>
In-Reply-To: <20240429-hsi0-gs101-v3-0-f233be0a2455@linaro.org>
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

From: Peter Griffin <peter.griffin@linaro.org>

Add dt schema documentation and clock IDs for the High Speed Interface
2 (HSI2) clock management unit. This CMU feeds high speed interfaces
such as PCIe and UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
[AD: * keep CMUs in google,gs101.h sorted alphabetically
     * resolve minor merge conflicts in google,gs101-clock.yaml
     * s/ufs_embd/ufs    s/mmc_card/mmc
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
* s/ufs_embd/ufs
* s/mmc_card/mmc
---
 .../bindings/clock/google,gs101-clock.yaml         | 26 +++++++++
 include/dt-bindings/clock/google,gs101.h           | 62 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 94dcc4f84c85..caf442ead24b 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -31,6 +31,7 @@ properties:
       - google,gs101-cmu-apm
       - google,gs101-cmu-misc
       - google,gs101-cmu-hsi0
+      - google,gs101-cmu-hsi2
       - google,gs101-cmu-peric0
       - google,gs101-cmu-peric1
 
@@ -97,6 +98,31 @@ allOf:
             - const: usb31drd
             - const: usbdpdbg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - google,gs101-cmu-hsi2
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24.576 MHz)
+            - description: High Speed Interface bus clock (from CMU_TOP)
+            - description: High Speed Interface pcie clock (from CMU_TOP)
+            - description: High Speed Interface ufs clock (from CMU_TOP)
+            - description: High Speed Interface mmc clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: bus
+            - const: pcie
+            - const: ufs
+            - const: mmc
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindings/clock/google,gs101.h
index 7a2006f0edf1..442f9e9037dc 100644
--- a/include/dt-bindings/clock/google,gs101.h
+++ b/include/dt-bindings/clock/google,gs101.h
@@ -367,6 +367,68 @@
 #define CLK_GOUT_HSI0_XIU_D1_HSI0_ACLK				51
 #define CLK_GOUT_HSI0_XIU_P_HSI0_ACLK				52
 
+/* CMU_HSI2 */
+#define CLK_MOUT_HSI2_BUS_USER						1
+#define CLK_MOUT_HSI2_MMC_CARD_USER					2
+#define CLK_MOUT_HSI2_PCIE_USER						3
+#define CLK_MOUT_HSI2_UFS_EMBD_USER					4
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_PHY_REFCLK_IN		5
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_PHY_REFCLK_IN		6
+#define CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_ACLK				7
+#define CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_PCLK				8
+#define CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_ACLK				9
+#define CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_PCLK				10
+#define CLK_GOUT_HSI2_D_TZPC_HSI2_PCLK					11
+#define CLK_GOUT_HSI2_GPC_HSI2_PCLK					12
+#define CLK_GOUT_HSI2_GPIO_HSI2_PCLK					13
+#define CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK				14
+#define CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK				15
+#define CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK				16
+#define CLK_GOUT_HSI2_MMC_CARD_I_ACLK					17
+#define CLK_GOUT_HSI2_MMC_CARD_SDCLKIN					18
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_DBI_ACLK_UG			19
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_MSTR_ACLK_UG			20
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_SLV_ACLK_UG			21
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_I_DRIVER_APB_CLK		22
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_DBI_ACLK_UG			23
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_MSTR_ACLK_UG			24
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_SLV_ACLK_UG			25
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_I_DRIVER_APB_CLK		26
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PHY_UDBG_I_APB_PCLK		27
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PIPE_PAL_PCIE_I_APB_PCLK	28
+#define CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PCIEPHY210X2_QCH_I_APB_PCLK	29
+#define CLK_GOUT_HSI2_PCIE_IA_GEN4A_1_I_CLK				30
+#define CLK_GOUT_HSI2_PCIE_IA_GEN4B_1_I_CLK				31
+#define CLK_GOUT_HSI2_PPMU_HSI2_ACLK					32
+#define CLK_GOUT_HSI2_PPMU_HSI2_PCLK					33
+#define CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_ACLK				34
+#define CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_PCLK				35
+#define CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_ACLK				36
+#define CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_PCLK				37
+#define CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_ACLK				38
+#define CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_PCLK				39
+#define CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK				40
+#define CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK				41
+#define CLK_GOUT_HSI2_CLK_HSI2_BUS_CLK					42
+#define CLK_GOUT_HSI2_CLK_HSI2_OSCCLK_CLK				43
+#define CLK_GOUT_HSI2_SSMT_HSI2_ACLK					44
+#define CLK_GOUT_HSI2_SSMT_HSI2_PCLK					45
+#define CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2				46
+#define CLK_GOUT_HSI2_SYSREG_HSI2_PCLK					47
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_ACLK			48
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_PCLK			49
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_ACLK			50
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_PCLK			51
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_ACLK			52
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_PCLK			53
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_ACLK			54
+#define CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_PCLK			55
+#define CLK_GOUT_HSI2_UFS_EMBD_I_ACLK					56
+#define CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO				57
+#define CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK				58
+#define CLK_GOUT_HSI2_XIU_D_HSI2_ACLK					59
+#define CLK_GOUT_HSI2_XIU_P_HSI2_ACLK					60
+
 /* CMU_MISC */
 #define CLK_MOUT_MISC_BUS_USER				1
 #define CLK_MOUT_MISC_SSS_USER				2

-- 
2.44.0.769.g3c40516874-goog


