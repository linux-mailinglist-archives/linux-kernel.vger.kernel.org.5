Return-Path: <linux-kernel+bounces-164120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C108B7947
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737C4B21090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230861C230C;
	Tue, 30 Apr 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0CsGvEl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A111BED9E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486497; cv=none; b=mhwDgFBarMQtzdoWaGTh4AVGxwlSVSwr+z+PjthRujdGMgIPlsqwFeOFS3U9oViDkxhZdL3NJ9TiLpCGqT7cVQCIZN9uC4Zcqmp7j8MpOmq/IoV+v4BAqpl7Mr3KORH8CHH69qzq5zmJ7kWN01ULSrQuTtcMUVskr8cslzogGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486497; c=relaxed/simple;
	bh=tjxp0rW8glHF9FMq7P0iV/DBpTkaBY/yqo8eUhO3aZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBRsZehSG/0/rezaVMqiBYeQnMONtE77llfsxvBLOhjP1BD+QSTEebkS/nBd3HvU9B/z3Ike1FVH+12uSDu7olESdRNq1MPASVhpnL01f27h+6bxDBBJlxYJFhQL4VNSAu6hNe47gNWpwK+6CjjFivPK/baUaUi9tT6rUDJUJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0CsGvEl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b794510cdso36515915e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714486494; x=1715091294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdlQOjQKruQurk6qF7RGyhlxjKzmBO+N5iV8uUwrLDc=;
        b=E0CsGvEl2BXJA1nriaMeTLfgUvOr1yc5CJjeQrj36so/FhE2cG1rwHtYjd7WtdWSmn
         S4hOIge9Dj6gOHAzGdjGr/m6TjVETXqk2J5kJSxwKMR3JXSz0I/VI9YuaViwcwMU00XB
         hs00NZDTAHH833yQmcY5hCBKrgL9pPZsK17K1S7S9dcuPY17oe2AGZD77dJLBEowXHE2
         dVbVtPPy597IXhwuvv9DMLKpaTjNpCtLYyAoSTQXE5wdDIgLui21GS75MpVpy3I1fXMn
         JOyBJzYDA3jBzl64lDXXq0YVBp98cg98Bs6rR6riv8TlozAm/4w0QWipo1S19mTuVKXC
         I4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486494; x=1715091294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdlQOjQKruQurk6qF7RGyhlxjKzmBO+N5iV8uUwrLDc=;
        b=ieexLRfIXWrZM7WXUPEmMqkVirTsBZzpogSIvPhL6qjJPdtGjsY8r90bPAA3jKJwBh
         L/j8GJOxIW277LBC/JdyTc48X2JuHU5DRuDlL5jbgw3PV/6MA90jcdNHD+2zSeTiUrP4
         NdBTRqqrRYC/28QK7JB+fuvh3RDXEn7r/RK4fmR9M07XKfOgToDpIPxQWXOETVo4qzuc
         eFEquRoBV63hO6OYAc3TbgeL0bSP5jvopAHxXN9Hg4r06jkOPI6fqxRL/comvQgJxHX0
         n36cOZWmc3qhOkciOZI3XFY1kklu0EoHd4j+YLEGs39bFfbg4Nqu/LOB99zltUmIGnic
         7Q3w==
X-Forwarded-Encrypted: i=1; AJvYcCXlh1Fi46NK76NetRzu99R25zUXidjcPyLNOJ/FTw/6pVJl3+Ob06XiThJK1lHyvNnnp4e8Lz372CyDhxtk/m/2GZHcjTUl4tmgMvR1
X-Gm-Message-State: AOJu0YzvcDKioRf8Nlq4GZc3A/Y8w+pErOln/2t8lvEx5e5n1sRs2g8c
	DXMJtHK/8X4jQHjIKLVTBKOY4QMB6/A0wAI5dhXIgFe9C/SdYRI7sWHr5EgA3gA=
X-Google-Smtp-Source: AGHT+IEEpqR6LOLNxdPkqMtyOYbTgdIvTDuuBru9JEjSe3nJuXIJsw3V8KyaGY6kpiknSGkfBm1TCw==
X-Received: by 2002:a05:600c:4687:b0:41b:82ba:7997 with SMTP id p7-20020a05600c468700b0041b82ba7997mr2226875wmo.3.1714486493857;
        Tue, 30 Apr 2024 07:14:53 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:f162:7aca:a805:2c2f])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0041bf3a716b9sm11593517wmo.34.2024.04.30.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:14:53 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 2/3] arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
Date: Tue, 30 Apr 2024 15:14:44 +0100
Message-ID: <20240430141445.2688499-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240430141445.2688499-1-peter.griffin@linaro.org>
References: <20240430141445.2688499-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the ufs controller node and phy node for gs101.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 9f7635a7928e..16e1c474e8dd 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1332,6 +1332,42 @@ pinctrl_hsi2: pinctrl@14440000 {
 			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		ufs_0: ufs@14700000 {
+			compatible = "google,gs101-ufs";
+			reg = <0x14700000 0x200>,
+			      <0x14701100 0x200>,
+			      <0x14780000 0xa000>,
+			      <0x14600000 0x100>;
+			reg-names = "hci", "vs_hci", "unipro", "ufsp";
+			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
+			clock-names = "core_clk", "sclk_unipro_main", "fmp",
+				      "aclk", "pclk", "sysreg";
+			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
+			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+			pinctrl-names = "default";
+			phys = <&ufs_0_phy>;
+			phy-names = "ufs-phy";
+			samsung,sysreg = <&sysreg_hsi2 0x710>;
+			status = "disabled";
+		};
+
+		ufs_0_phy: phy@14704000 {
+			compatible = "google,gs101-ufs-phy";
+			reg = <0x14704000 0x3000>;
+			reg-names = "phy-pma";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <0>;
+			clocks = <&ext_24_5m>;
+			clock-names = "ref_clk";
+			status = "disabled";
+		};
+
 		cmu_apm: clock-controller@17400000 {
 			compatible = "google,gs101-cmu-apm";
 			reg = <0x17400000 0x8000>;
-- 
2.45.0.rc0.197.gbae5840b3b-goog


