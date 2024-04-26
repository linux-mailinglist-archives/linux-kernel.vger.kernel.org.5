Return-Path: <linux-kernel+bounces-159829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E38B34D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51BF28693C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAE1442FE;
	Fri, 26 Apr 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sljorf8a"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054671422C6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125791; cv=none; b=vA4652GAcJgjU/vofarYRd3MAYaq6LKmuymeHnBGrGEomhRteTivSMHDL5YEAxCwjv7PTybrXNmpRSS7nHYG2KfT0InwJg4TrpVeGC5KUj7sJNAIzFCu1NeEenFaOJwBtsTnsEknKi61i3YAJzwOuQ9qil0xpLXg6Nk2s/JXtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125791; c=relaxed/simple;
	bh=kEIXNWge+gu6r69LP1+LoW5ZL/kMo1721Gar8FYgwE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRiOa9ukRXr7K4SPLbn3Af9sPHOM2p+BQjiJf5TOkc5PxsWwBwkQ1l/3RGnLfelDlaoHdZvxRpH1WjDauI4V6JWyrLF1f5iKXMttB1Mjc+wOVOaGhMMzi/qIduDnMATKbIHgHXoLf5PkXrD0h4ko/bOnfnJlC/SWVI5VsoTWvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sljorf8a; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5723edf0ae5so2098866a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714125787; x=1714730587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXVLcsEROWtnozSKM9ibFjZVD9YeGJfdJ8xwiEDpbCA=;
        b=sljorf8abuXbxliOoFIkZbMZ0KUNYxoCzpmwvJ1PvhBKTdXzaf70grQr3owfp4C75D
         dJONjyTB8CHK8uQR/tFfFZY40eWUmUUIqr2daX4IJw91FqKCGxlYnyvNyZU3uDsC4ACP
         9rjrKvY9bswDq6kEhMgm+vdndEzBTt9YetFh1333Nd6CklzPNyLbojTMEqwvZx1PzMTQ
         XYPNBO5NSUdsIUV5Gy0IzR7Z7NQmEN0+7eq3pHIhRDA5GOgdpqE1vYt5EILyrZ7HhP7N
         Aha1WZRXgOq/b6haHvUhJFpquxREvVUDNudsIwS+MOm5YpCf+RNKIzJYkbQJAak8+X0Z
         W8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125787; x=1714730587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXVLcsEROWtnozSKM9ibFjZVD9YeGJfdJ8xwiEDpbCA=;
        b=cPTgAvqWbGvxEI3aEqcSDfQId7J+xv2Fr7TazKaLZp+XClFUw29w9fBcIuSJzWJU6H
         htwWETOWYi9NkEgCSkytNm8bPwn7W8UabhdrauxxF524k88DuYLf/V60K15eD292bkRa
         /7FMMV8uZ1UD6woxlWJb9AU8peUluaMxFItkgCcnbYRnTKiuDJIZiHkybQU2iGFfLFPK
         v8rQEXioBdeh8dacibX0qYHumckjMtZsSn+tgYE3HmWlNECwoTNIZ6C0lm9snLOJdKr4
         5ran6+PQwMRbD+bxgfMYD/VVTp5XOGRjeRsqta03R1CVPR24D4ATl29Ocd2YrJA1hikx
         dGyg==
X-Forwarded-Encrypted: i=1; AJvYcCV9KDaTX6CcXb80nJU4UOHnNwt34il2a0uQIcxwJdh+t2FADtx6liywml9LQpexzgSJc3rx2FVJAixq0WPRD5rIymDheKRwEw8hNKhQ
X-Gm-Message-State: AOJu0YywJ8Jznca7CJeJJUyEsXw4G0MYIIPQaJCQYViUCL+cF3qmJX3d
	zF1v/NaCZOoBWkVKM/QNQNIOCx+2SS4NNPz1v2gH/6SDwXER0wHVCWm38vLqxQQ=
X-Google-Smtp-Source: AGHT+IHWAn2UwzuKzKX4rvGcf0ZfBBLAyRhZHKgOyrPEhmB6C/M04p2DwE2DH2kIrrp+nKiuxjo6WA==
X-Received: by 2002:a17:906:1457:b0:a52:2c0e:2e91 with SMTP id q23-20020a170906145700b00a522c0e2e91mr1517888ejc.17.1714125787362;
        Fri, 26 Apr 2024 03:03:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm10417289ejj.218.2024.04.26.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:03:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 26 Apr 2024 11:03:04 +0100
Subject: [PATCH v2 1/5] dt-bindings: clock: google,gs101-clock: add HSI2
 clock management unit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-hsi0-gs101-v2-1-2157da8b63e3@linaro.org>
References: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
In-Reply-To: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
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
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
[AD: keep CMUs in google,gs101.h sorted alphabetically, and resolve
minor merge conflicts in google,gs101-clock.yaml]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/clock/google,gs101-clock.yaml         | 26 +++++++++
 include/dt-bindings/clock/google,gs101.h           | 62 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 94dcc4f84c85..6323971e1f2f 100644
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
+            - const: ufs_embd
+            - const: mmc_card
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


