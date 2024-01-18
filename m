Return-Path: <linux-kernel+bounces-30157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE26831AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4EB24D51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4625579;
	Thu, 18 Jan 2024 13:36:25 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115451E531;
	Thu, 18 Jan 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584985; cv=none; b=ep9T7bD1FMPQcT7qvAFCuuo17n8NZZlWwgbg75D81PoxZN1XNauvU66xAlVi70gcM5F4oq/3hZKXWAySvcqqGlwWsuBOK92rrhHNRaeMYxyaxToSBhwbvgbsuehLqCAe2rXeO1iq4HigAadjtPzRCVdsaWquiyfX8oR446TuC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584985; c=relaxed/simple;
	bh=6HbT2TMGthwgtVSIaK7teCrAT9dq/hLGM7wI/HBy21U=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-HM-Spam-Status:
	 X-HM-Tid:X-HM-MType:X-HM-Sender-Digest; b=TQImjODjPahMDJTXzZmsIgtLVE7QvX/uKhitYA8oBYoum1JW8API9Ub0SQJAjPFIzM1IFlJduuLOTLvAHbQk3rgps378jMk/Z0mOyMj9XpRrJopfVd2peq6sWt59kUt2WgyC1b9NMfVuEJF/bVhnRF5PUMOH5YQZz7iCzKO+1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.0])
	by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 2B904AC0104;
	Thu, 18 Jan 2024 21:30:29 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
Date: Thu, 18 Jan 2024 21:30:22 +0800
Message-Id: <20240118133022.553339-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118133022.553339-1-amadeus@jmu.edu.cn>
References: <20240118133022.553339-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSB5IVhhOHRgZTBlCSkhNSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVUtZV1kWGg8SFR0UWUFZT0tIVUpIQ0xISlVKS0tVS1kG
X-HM-Tid: 0a8d1cc416abb039kuuu2b904ac0104
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6Ohw6MzwjOhcjMhYhNQoR
	F0sKFExVSlVKTEtOTkNPTUlCQk5NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVUtZV1kIAVlBSU1MSjcG

Enable mmc device found on ipq6018 devices.
This node supports both eMMC and SD cards.

Tested with:
  eMMC (HS200)
  SD Card (SDR50/SDR104)

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 322eced0b876..420c192bccd9 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -441,6 +441,25 @@ dwc_1: usb@7000000 {
 			};
 		};
 
+		sdhc: mmc@7804000 {
+			compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x7804000 0x0 0x1000>,
+			      <0x0 0x7805000 0x0 0x1000>;
+			reg-names = "hc", "cqhci";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC1_BCR>;
+			max-frequency = <192000000>;
+			status = "disabled";
+		};
+
 		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0 0x07884000 0x0 0x2b000>;
-- 
2.25.1


