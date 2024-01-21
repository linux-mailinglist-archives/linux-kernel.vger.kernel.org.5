Return-Path: <linux-kernel+bounces-32133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAD8356F0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984271F21611
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18839AD1;
	Sun, 21 Jan 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVGkoRP7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2138DFC;
	Sun, 21 Jan 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856365; cv=none; b=C3HxjPzTgLt1RkaZmGvj11iFodCPFTKAgceXxvKP51YK9q02wQ4/dcEXOCjENUCdppE/LfxM/WjV12i61iPzth1MYR1/xmr5NAF1bIuW6iK8rXDp5o+n2kvoiFp6oz2EqG+KFqizsQ0JkNWG37ddLeNXrmokmOe0KcrggR1LZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856365; c=relaxed/simple;
	bh=MtVhwuHNbEP/vSCa8fcY/sH7cIwR8Q8n7RkTyvahgCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4aTSbdhXrusWSb8WTu2H4HjflQ+Z/LPj2yqM2jLd04jfBJMOdLs1xVQ69oKbff2xo2DxD475cDDmFHo3c4Cj3uuLaTFcx0tfxuZ4xaw99NS1WPzfnCO0kcJaJDspGG8BTMOAHk0vIxLagYD6oxAfLjV9/I0t4RZ4jXsW97Q61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVGkoRP7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33922d2cb92so2090909f8f.1;
        Sun, 21 Jan 2024 08:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856362; x=1706461162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo0ib7C6TUtcBIejQoK+EtbiZe92K2BuKhrngunq1ko=;
        b=FVGkoRP7V6TdFiBdrX4TjLXDB/PWJy/8JjPMB08gu5rJyqp94KmmkFpANMFy8M2jYC
         L/2ZBg4mULdIpeIqZFMLaxfyCILRfxVRdf5tjZNgJ2pQZTFkwMlzeYFn+IeOdntXy7km
         TiqwKqMD48qbCcndRs40u0yBGiEyASeFx8957MNgYZ3QxHQzkMcTtMkNTP2MAPCigNir
         u6WaSXt7aBQCkdd/3A9hSkXNUvEZCSBY6H1J/WIbN4JoslOJ6Dy904Pj4lV8lvJUPO6R
         NpT5AEF+Cgv2vPaM7SZymhgCsEnHuBrefi7+D0JHnE90InxF24C8BFKns3dLDilM/6uH
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856362; x=1706461162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo0ib7C6TUtcBIejQoK+EtbiZe92K2BuKhrngunq1ko=;
        b=cmlN9Dx6/KgxkCwaltmxY9Vp4/5w9MYG6LPoPyHDKpHL+g9GH/N2QAY5k3r9ow3aWH
         YLzUkOoRd+thvvN1fK+N2SQHAOeCsKiE3oKSzpNbHj4TNHhgWm5dRIO+CQ8VMHSgwg+U
         Geq/6U+ymgI3VU7ImUmsb1PX9JSJAttBZCy1BDiOyHYciIsyF1UXqtxCuicQQ273TYn4
         qigo11gJmorzlK5R9qAsxxfou3y+nA2PHXYOqyGz+dIclaHGVe+TwopeKo6WevRmVKkA
         MIKe8Pzc8X6JTDjXuPnyT8jmARBEDmYPmXdz055uAGbgurCqsHPr/EgQwxqVYEcrPnBA
         H6vw==
X-Gm-Message-State: AOJu0Yyxhe3r6JbShEpr2TmdYlKiVwNluYIWzkhn2kgGYQVqmw6QU2MY
	hrMYi3YpGraxPPaHAj0BE8xXkXrDLpw/mjrC5PA1qOdGa//+QRpG
X-Google-Smtp-Source: AGHT+IGJoG871Sz7xpwv8z4prtpFIJHsc9b6Nx7+yT0ZTicW9bxEvV+UUzC/VttqB5z+MEDlpF1xdQ==
X-Received: by 2002:adf:f6cb:0:b0:337:bec0:f8e1 with SMTP id y11-20020adff6cb000000b00337bec0f8e1mr913546wrp.244.1705856361938;
        Sun, 21 Jan 2024 08:59:21 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:21 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:46 +0100
Subject: [PATCH v4 6/8] arm64: dts: qcom: sc7180: Add UFS nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-6-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=2735;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=MtVhwuHNbEP/vSCa8fcY/sH7cIwR8Q8n7RkTyvahgCQ=;
 b=fhzJZVm/qMMTdyjWkpEBv/O2e/Jk+jSMKDBEkKvJz97udNDUzwL1pgPjfwmqDvHAiiTd0Uvv3
 Ud6DPxOolvnAVVhusODuHwt/5z0l4blP7iTfBGXe7lXPCTZ8EoVqKpy
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Add the UFS, QMP PHY and ICE nodes for the Qualcomm SC7180 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4dcaa15caef2..93c867cac755 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1532,6 +1532,76 @@ mmss_noc: interconnect@1740000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sc7180-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0 0x01d84000 0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			iommus = <&apps_smmu 0xa0 0x0>;
+
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk";
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+			freq-table-hz = <50000000 200000000>,
+					<0 0>,
+					<0 0>,
+					<37500000 150000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			qcom,ice = <&ice>;
+
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sc7180-qmp-ufs-phy",
+				     "qcom,sm7150-qmp-ufs-phy";
+			reg = <0 0x01d87000 0 0x1000>;
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+			power-domains = <&gcc UFS_PHY_GDSC>;
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		ice: crypto@1d90000 {
+			compatible = "qcom,sc7180-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0 0x01d90000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sc7180-ipa";
 

-- 
2.43.0


