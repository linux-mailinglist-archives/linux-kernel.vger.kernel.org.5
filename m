Return-Path: <linux-kernel+bounces-119276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6C88C681
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9441CB2442A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02F13C8E0;
	Tue, 26 Mar 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7r38BeB"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC213C81B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465990; cv=none; b=PDGNvEWM+vr/qAQUqxV9hq17gCwo1bppmzEjCTuGcrozK9RK/cH5N2vjLBywHOYT1tjlgybujeFLntSFPtpos2mbRSLfj+5r8IBP6EnIqhRik178edH8MsX1GfEV3OxVkZ249HQ+MrOWiSM6iKIVjPTu9kTbIm6IF6qNds/A2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465990; c=relaxed/simple;
	bh=FeLxIq9atoz4TPPt/7OWo23kfV4aQ2q8J2PJbLuSt0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IePIspjgk1V43tn9E8ey9Vf0HCd6zLS7/rVL0dEvfCz2BfXhQf32RGcfKmH6NUZ68pB/kEtrPsIaArWIEyHyESEY0KPpQe08C1PbOK6pG8REFZOkrwu88QZyI/1wdzKKr+g2MYI9ak1ny+wUlJPuwALKZjz2aMu0ZbZB43KsRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7r38BeB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41490ab5cdfso2855515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711465986; x=1712070786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlz6Sy54uP+548eyUIyn9J//AASUpkQcLH7vl4aBa9g=;
        b=T7r38BeBBT/mVNNY51rJuK5P+5q57Gaw1rJWD56W7SzMRvW6zen2psnixWbXdb4gXZ
         oLl98OCZjkB7wIoRed5y5NHyJHkUI/ywD/kZ/UhQ34I7tJHrsetKyUubu3BvNDBsd3Vy
         RRZ7mkwKa89kj/Ra8HR+cSQwQQQVTI7C1A90gub9H8Q6oD/9jldzhq61tvQeeRGQd4UX
         9H4bRANgZQxznKRyLOMEOkNmuFCLWiujSjP1O5asJLaV1PRAKP/OaG2WJKO7ATXmlrw4
         aQig8BlYhdFqRDBs3aD93g9P4JysCtRUhcUi40nE7Dr+p0eDsm19D9AjId8ozf2eQ6HI
         KYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465986; x=1712070786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlz6Sy54uP+548eyUIyn9J//AASUpkQcLH7vl4aBa9g=;
        b=sjUdoUeWMl3clusfn2NGQTBRog/WChhKam2T1i5xU8bWqCJV+i+6qLiRq6yk8eRa1x
         98gwzXM1MFpocJhY9IWvJbMWQa58D2aH9kW+7gNaC3mGQbMdCbcJ52GXYI4n/Oipx7Yl
         vr0KFSqbJ/FCoqOMJQRaUK8IiVtPsIwj0reryXPDnXpV9rW6wN820XPFDq7PPgg4Hlbc
         R1joNJJCifaLiTMnV+FNRTCmLKELc8juBK/L7vyhRvmvrzcE7EZ1SsWpjjhncBHNQs+Z
         SaEY00RjoH87wLORU/uCQdwNmE6UqsblcA9mco4l+aLvOguz4Dv312VHWZ7tSn2jqNdC
         ZmGw==
X-Forwarded-Encrypted: i=1; AJvYcCWISOY9Ey5lx6frCybDFr2V5/u+gITaXMJ7eU2ygMw+yTLOEJXBnpT4M3o54zhTyUl6WxtV240z5FBRjpdlBXhNj+DAHhPdZ4MloJEZ
X-Gm-Message-State: AOJu0YxOt0+HajcymoT7XA9xEzkFurY4Y/Ib8J0oG2Tx7HqARZaqWqgT
	KYosUCVasKcrj7aCuTEoLK/uavLW8om34eOc0/sYNrOGyRQk2K+lL4B1ZV33Zj0=
X-Google-Smtp-Source: AGHT+IE2q39yRZ0lVDRKXL88UfaNYlGtE1ohcmxKv1HapUorPMZCa98GMyKI3xk9IVqNsvr3qlmwcg==
X-Received: by 2002:adf:efcb:0:b0:33e:c594:f154 with SMTP id i11-20020adfefcb000000b0033ec594f154mr1283887wrp.62.1711465986199;
        Tue, 26 Mar 2024 08:13:06 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b0033e7a204dc7sm12325692wrq.32.2024.03.26.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:13:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 3/5] arm64: dts: exynos: gs101: move pinctrl-* properties after clocks
Date: Tue, 26 Mar 2024 15:12:59 +0000
Message-ID: <20240326151301.348932-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240326151301.348932-1-tudor.ambarus@linaro.org>
References: <20240326151301.348932-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pinctrl-* properties after clocks so that we keep alphabetic
order and align with the other similar definitions.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index a1aff219208a..cfb3ddc7f885 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -393,11 +393,11 @@ hsi2c_8: i2c@10970000 {
 				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-0 = <&hsi2c8_bus>;
-				pinctrl-names = "default";
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				pinctrl-0 = <&hsi2c8_bus>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 		};
@@ -473,11 +473,11 @@ hsi2c_12: i2c@10d50000 {
 				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-0 = <&hsi2c12_bus>;
-				pinctrl-names = "default";
 				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
 					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				pinctrl-0 = <&hsi2c12_bus>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 		};
-- 
2.44.0.396.g6e790dbe36-goog


