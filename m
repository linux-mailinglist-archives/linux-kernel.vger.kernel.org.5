Return-Path: <linux-kernel+bounces-160066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4A8B38A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746901F21743
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA529148821;
	Fri, 26 Apr 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1rhvupy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86914830A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138716; cv=none; b=a8XPKz+kyhVLhzEOfjRy4fATaGu/nEmD/l8xPN7VRCqH/Ug28VY8oFhyw12C4miOgLo3sboivVbHSLy4NdXsKgj/4qjBGQN/8hqMak627VszzUZfhgAFXBrSOe/daB0Sibr5Q6BTTVlq+X7ei1y7bpr6GUrWz0aWDP4cLonqvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138716; c=relaxed/simple;
	bh=MnvkoP96ETwyzM7/zS913M9b2W7iLYDRzbOwtkS5MV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpfdHm9WK3UGymgsPInQR8mOa5GcPdiJsSSM5CdKTYLtz0mPsA9zlM11Fbas6E6ikuswEheFtl6j/nvnw4E8cR7OpiqHals8IxByOaX/LDsDK59fS9LRnkbtliZxDn6Bb/RmMMV4F7KW95G9nNEaUDu6MA25cE3dwd1NiFQnMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1rhvupy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b847a81d1so4230785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714138714; x=1714743514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH+qHwJN2mCxyTFNfSJEDrH1StJ86nloa+of3UztIac=;
        b=S1rhvupyupesRYfdEI3MwlW+cDozOdLDCIwcTOg/OggL1KJYUMYSMi1ZDuy3WHhx5P
         2G4hpCwKShLk6uRuIgUACegh66jYBf2nkRVuo3bwGGKuSsry9L60BtCioTRvt7WGVDdK
         KE+uTDvOXE/+5ox2h0Q44kDWmCaJpcTQJqVkYgryafz3AnydA2J9hxxHTOCBp9o6fAIM
         EQpHTZRPbMH59bvKLQNNofXZidSF3H7jTiZ9O5rG0XjK39Imx4j59pU1Gke2pmU4ZgU3
         MMjXtuuJsF65hAaH9PeQGINa+8+TWDen9Xhoht0LDZU8iGiX/3NgwfGBqmiWBjiFcyxy
         sN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138714; x=1714743514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH+qHwJN2mCxyTFNfSJEDrH1StJ86nloa+of3UztIac=;
        b=Shbm3kcNxFOaYMzwUQLpJzcBwgkT1Bi8fJb3qoNd2HzcBosK77Jx1XbXCx9oYkLIPz
         yvEd1dGMoQhoDeWKduaP80JRe7IA+QHwWImvRJjLhz7wNHxAqbYezF4DHxSLwC1PMsWV
         B/SCppnRyNme77/OAjSjhMM8M0aLyPKNUi/vM+P/xsh1fNs84NSH6wLGGVV3b3BQVYY8
         4zBQ/oOI4RwcNMrnPkk+6fBF5IH/25o0TlHLRN2Zsm+TYLb6F/KUQLr4XKabXc7KNXP0
         SN2YRrpqH5ELcsCjtvV6/ERoTEDEGyuFiqZlqcmRWYqL5eD5BfsCKgogdJi5tvzhXdlt
         Lp7g==
X-Forwarded-Encrypted: i=1; AJvYcCVkSoHqGABlu8QPQDtAqoPi7ctOKsEoY7LqdZotBlYIFhgexCjBll8nBJWbzhLdmIB4k221NCqTJ3IdYsjPMtoovEQ75PuuaHfltaMv
X-Gm-Message-State: AOJu0YzWfdlSR4+C/iH/qU0pdqbplgdYONv011lbotpGTaOWJ19r0bIo
	Je76pfgGh+w5HabLfvP1/q85ToRkCYOhEwUx/GORRf93bb7CNx4e28li2ZsNYz8=
X-Google-Smtp-Source: AGHT+IFm+sPiQDs7FxsoddzmGcb5i4tZc2v1N/h+hnpqJdNZnJd4NgTvZqKCbojGXOgRYrkPQiVqiQ==
X-Received: by 2002:a5d:47a3:0:b0:346:41a7:2fc2 with SMTP id 3-20020a5d47a3000000b0034641a72fc2mr2953583wrb.32.1714138713599;
        Fri, 26 Apr 2024 06:38:33 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d6383000000b00341b451a31asm22327689wru.36.2024.04.26.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:38:33 -0700 (PDT)
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
Subject: [PATCH v3 3/4] arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
Date: Fri, 26 Apr 2024 14:38:23 +0100
Message-ID: <20240426133824.2283144-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426133824.2283144-1-peter.griffin@linaro.org>
References: <20240426133824.2283144-1-peter.griffin@linaro.org>
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
index 09044deede63..4679ca33c6a0 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1277,6 +1277,42 @@ pinctrl_hsi2: pinctrl@14440000 {
 			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		ufs_0_phy: phy@17e04000 {
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
 		cmu_apm: clock-controller@17400000 {
 			compatible = "google,gs101-cmu-apm";
 			reg = <0x17400000 0x8000>;
-- 
2.44.0.769.g3c40516874-goog


