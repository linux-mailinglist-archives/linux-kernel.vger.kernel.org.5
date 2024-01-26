Return-Path: <linux-kernel+bounces-39935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D472583D798
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0AB288DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BF250EC;
	Fri, 26 Jan 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNocVOoG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855724A03
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261927; cv=none; b=UzCdYB89yoySsaFZJ5j7QJ/u2b9PWDNsujL4EYImCxa7zNUuIrXCSbeCocusYyO5FCs4EZ8CaMgsMV05APXbhet9ACrs3JO3A9+dLGoA8xZ7Z5GPrU8LjvLWf14GWNkGeVOwqd6PudREJWeq3quZO68LChi+IfIfHYV7ym1gSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261927; c=relaxed/simple;
	bh=eHhrQ9vAHc9Fb3/HL56l8DURgtGk8GaRo6G9M3z3KNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXzy/WUgPUtwdMPq65OmlnZiTaENjhcNIYQU0y795msmc/wkBMTCmch8uRMXVYc4NcgoRmZVsMGnSmgvsE176nWZBC7/3yIPBNcJlqhPua6grkgbx9OCWXD8wAPM1NEXN/qeWGVb5RkyHD+vx1IX3u2p9hCKRpcb1NzSQWWzeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNocVOoG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2a17f3217aso28221166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706261924; x=1706866724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmwYH3BEWdqQXMuMFSLehSYvl/UOnjbyoVi5Cl3yg2Y=;
        b=VNocVOoG55C96lU1rYSfTJchPOCYxlg27lPMCi2lG9okHjcgwlOO/G4EbmTkfExD2m
         5z59cw+nhrKwrR5PS/ikdpHJw93Tts/ai+Ay7MB3rfsIpCqcuVyKHhcM/gBdwZUr/VhE
         +u4/zMFetsADCyu1BOuXFGoYfklP4Vrrh+8KBkRZFYKPzlKq2PIt/8Awyg4zcvUIMhFN
         VbJN+m/ytzmQ+iCXsDyaE+SycfW/WBfv7wj7hbzFNiyq+87exxoP8/EPVKvb2Gw8ew20
         XnnloAwxunAO+tBKSRw1W7Ts+8cpW8Nu2oZo8rMcj1bkJa7U2NxMBK0ytliLGFshHu2T
         XUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261924; x=1706866724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmwYH3BEWdqQXMuMFSLehSYvl/UOnjbyoVi5Cl3yg2Y=;
        b=pFpoSRE6S0UgARYJd/af7f6Q7F8AXFhZcSQQ7tnNQmvGjII/+d05yMs1U9iUumeJ0P
         ad70TM410vGKcRG5G0ni+hJn+OO+2N1PieQvUL29VhR5Aw5vMZAvb4dp8rFEZove5fih
         C4WGaCQfySrdFPGiJZc0O1IRJio3ElARBhnHxX5ynvEJDwJjOchlCs9UECGomdewo75b
         lqd1ILa6KTT6zWICjU0uWyfLxCc0q7n5VTd4KUaCMiWV3eoNJwYCC5urEE074/sDJ2Xl
         +L+NZdQvWx9QoWsef9qVo2DLwFWr8QHor0zLw6bVUNalqw6hMEfgNEfc3LXVLvu9NtwW
         3bFA==
X-Gm-Message-State: AOJu0YzaXd1qXy3rgR/2cz47bcMKpKkj74MrV2aIT8bqXRuJKZaEA9TR
	HklkObPm2NBwkZjnOAMpBLpiIi1FmMvHvxLWoMTpAdZxhx+KX5o4TNz/GSJkeqo=
X-Google-Smtp-Source: AGHT+IF8ShXdLMh6fAtHT0WCqMKtBB/ZXNtn11U7mAbU9NvlghqJFIPsbI6Fu4PtsD4DUOqqe6xe7w==
X-Received: by 2002:a17:906:5a87:b0:a31:7af3:f46f with SMTP id l7-20020a1709065a8700b00a317af3f46fmr915566ejq.77.1706261924303;
        Fri, 26 Jan 2024 01:38:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm426768ejb.199.2024.01.26.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:38:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 10:38:30 +0100
Subject: [PATCH v2 1/7] arm64: dts: qcom: sm8150: describe all PCI MSI
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-1-0bb067f73adb@linaro.org>
References: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
In-Reply-To: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eHhrQ9vAHc9Fb3/HL56l8DURgtGk8GaRo6G9M3z3KNM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls32bPPQNv52o2L++LvpCXRQO5ezFWIYW1zS6+
 uembBveSFqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbN9mwAKCRDBN2bmhouD
 18VwD/9q1Px44JNvmHdouCeqof+pimNNFqL6izuLVXDH3QwRKyPc0GZ4DFSFOm7ZzV8FPpxMf3H
 ht7qKjWIgxyO1CTL3kBb4x1GR1Zs9pch2rYh5xPLq2F/JwQp+ao8HsLqMiYhGmndOzV+ruCrr/j
 +iLEZ3f5IzkKTUpeXekE4jfs5wLk2o+7Iru76zHpu9bCJN5/iKp5Ua9uc6kqOo/bHyxRLJVjmQD
 JbsX8HG4Pn+rXsz8yenr8044S6kZw6KQ3PmMHRFMB1cEFcVpszuHQNops1qnkwP7aiwV9eLdtDY
 QSPFQaIIJtBzXORRG7yYfjh9yDYrtlnIoHJHpAGMZA5hGAioq+LuwyIw4vg9ovDl7MBg5NMyyaD
 8VoJUeZHz2B9kTsic5n9jxPayu2emQum4UBMiTD6VVTZa6th4baii83p4AkJgpLrLn+7GrWqWfS
 5LIb1Opm8jpzFlrI5hp1ZFeJa1cdxpoYygulVV3e/qyNdTnLLw6zMWNMnln8OBsAEp4GYO4d3X/
 6w3TPs2tC9RmcdmJIOe0wdHH5oNOEn4I6brISkk2j6OsOT8djdFTQMcTt+PFjSOeQgLyGVyCKxu
 Z5n5hJT/ImhjUQfqVA1AyRZrIHHI7t8tlWMmrojTTovyhlV1hFHd4P6anJOs3H3tnpWDtRh9NTn
 9IISOiJyjRF9wwQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each group of MSI interrupts is mapped to the separate host interrupt.
Describe each of interrupts in the device tree for PCIe hosts.  Not
tested on hardware.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 761a6757dc26..f7f26fa4a412 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1843,8 +1843,22 @@ pcie0: pcie@1c00000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1934,8 +1948,22 @@ pcie1: pcie@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.34.1


