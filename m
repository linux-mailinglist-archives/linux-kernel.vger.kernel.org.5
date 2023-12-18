Return-Path: <linux-kernel+bounces-3536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DC816D85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E891C21B05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B04EB42;
	Mon, 18 Dec 2023 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1YV5mAf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFF4F1F3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d39afa1eecso15672925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702901293; x=1703506093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9loaHfrne3H3i5jJvNSoB5V0DmyPKqbag1DqqG2m2L0=;
        b=o1YV5mAf8yN4ej7QlE7lis7T0wVOS0F96LvWw1cS/41gawZ+8kbpFCu2qTJgXpGF6z
         q2cn4bWf3/YRaAuWwNgXD11n1Y9IWbHHNF2PN93SarzS/Z4LTS2c63G4xrIgY1mmpZUT
         TzjWk3FVchUwT2/l0v/YM/jF+IoYDE1VzU5waBUJBX2/0xAC8P2JlCQFF0+PNYpx1oPB
         EFYNUpUvINFffI3s6kxKZuPGBwtXPK17UNTGnZ1bKtTzU8drBrCOMbJs97PjR+vVjwQe
         XRI5LhIajM631J6Z+fXHdJruGdOMuVvezNGAvqvh/DWsfzevbMRh4XOvdFQkF3CM3iYU
         aA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901293; x=1703506093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9loaHfrne3H3i5jJvNSoB5V0DmyPKqbag1DqqG2m2L0=;
        b=lFmbOi2sV5KOkSPTkh29k+BLcgRqxrkg0MpirOzBPyzOZl42A4Nu2GV9CaycbH9BE2
         2+TYZd9EQzA9fjolsKgquoI8FHa7ywv/7UeJ7B4YmxEIAk8msEZ8/HQw8dcV+VNH3PFE
         lEyEyG51aGFUnN+UgiGrZd0+bPDAF2wtqFgmoe3NAnRdPMS6U4Bp5wGX5x1inN8jgH1n
         eCwnEwux6dfYaYcS9XbRk4EKnrFIp30BPGsj/Hzna2JcWtsOXk/wsdRt7v3RcKCXQcp6
         xRqcqRbXoEgqeUmw8j1UoEGfEzDTQnZ8cw6GSdc+Vg+l/j6hgbTk1WIF0dCs8gLDNn0i
         /jUQ==
X-Gm-Message-State: AOJu0Yyy3XZX2MoWhvPTWWthM+Nq+LcCGHCTET6dl3vdPH0kxjEWFbO5
	bxuBbQkZgGFKx9LmyN2GPyj9
X-Google-Smtp-Source: AGHT+IGaxr64tfg1aM5VCDEAL5s2XMkt87LjGgVw1oRinho5wP3KRT0+O3ZPy6QGZ/LPQE6WGGw8Pw==
X-Received: by 2002:a17:902:7846:b0:1d3:47ba:ba45 with SMTP id e6-20020a170902784600b001d347baba45mr8139066pln.136.1702901293170;
        Mon, 18 Dec 2023 04:08:13 -0800 (PST)
Received: from localhost.localdomain ([117.207.27.21])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d368c778dasm1285709plj.235.2023.12.18.04.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:08:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_cang@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/16] arm64: dts: qcom: sm6115: Fix UFS PHY clocks
Date: Mon, 18 Dec 2023 17:37:04 +0530
Message-Id: <20231218120712.16438-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QMP PHY used in SM6115 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 839c60351240..40394c412fdf 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1033,8 +1033,12 @@ ufs_mem_phy: phy@4807000 {
 			#size-cells = <2>;
 			ranges;
 
-			clocks = <&gcc GCC_UFS_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1


