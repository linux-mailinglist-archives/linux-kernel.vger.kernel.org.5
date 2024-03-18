Return-Path: <linux-kernel+bounces-105963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF587E6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002E91F213B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833336103;
	Mon, 18 Mar 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKy+d+j5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADA2E642
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756593; cv=none; b=CQJll8KQ2pdDi8F8xpDdC/Oe0wdZjzuS1aBiP5XaiYaD8JWf3L/YJVKptD3OOUIXsVgKNkOXRNitG+qaZns+eATcWDk0j0kBcyqY3L5hfOkD9j54lobThCJM9SO8EsafwTiu+lLjDLqfBZgB3gZEqxQgAsbjKGEJrei+t/JNaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756593; c=relaxed/simple;
	bh=NHUBJ3C6TZTrEVk6MIERemImihySUvN3VXYQqv+Am2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBl5lIjdvgzH2Zn7X2uFdv386CE02xf/CxA/Ew+kjEf2Rg20CljXn9W/gtOha/u7R6K4Gyt252Q93bPH/P5lBl0fEPNJJp5nEiLn6mZHdFqfl+8Bxa6ob4r8w79MxfpE3W7XDWw0VnSVj4i45KEj4qeOWqYVNd3Bu+S8Ji6QvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKy+d+j5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4141156f245so3979775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710756590; x=1711361390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMqC9Qpno0KSr5BatsAEOI7fBV8AlIgGQxaQajD859c=;
        b=YKy+d+j55qflXnM0S8l5GdBXHhOS94wS+VR91E2Jq3UV6zwMU2AK/WhJeoSMrKA7Wz
         XcwW3HcS79QcF3WyIWIB3apOTxyxtkjONpk3HhiHPqjNzzL46XCQtoHgCYcUdTWoZVPp
         fStuJ4Luif+ygZom51r6hYA/fkSH4vx3amBaysH0x1gUUQRkGLk+atocaheytaKUHpqS
         EsS943O+gS0BHTQjPcvtVRAOI2SWecP1OsBS8qodqk+Zci50ln080VePCNug8EG+glO3
         lR8rpT7Q/j0h19jLNoFnCvOI4HLjEbfOseA4dLdXqqLSJazdTFO+89J95BoFXlO25mK5
         MuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756590; x=1711361390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMqC9Qpno0KSr5BatsAEOI7fBV8AlIgGQxaQajD859c=;
        b=DD30RrdqbNnSg0oEtTM3s7GXijm6l6/XRcnoiXP2neg0EvyuIvO9XGJDQUrjHDpiMc
         W5dpQCVu+aoPv1u5w9ArY+eVJKzXuCkeeHluCVkUOy7tNzfvc6q7JbTT27f6VAQd15gF
         54duc6GLchq7cqhf3JICizN6Ooq/hTzkLhljAz2sOB5A7x5VfcWjjsAUyNraQW1bcndg
         zkuvn60BOJosqtBu9zaMzQ/VS/D5abdx8aeWxu1PG2DGnu7tNJO8z64jiWA+je2+AOUf
         SQpu5CYDX7qlbllVNiYWErDf+SXzijHMq2YVImEcZ/C7RnrPrS/9j/GpfvmkKi3zmbLN
         VHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUy4MtAo+Wpr9m2IY/qD+zWMy1BrT+n3g407kum5dMlvUff5p3xCZddFI46t6vtfbpiHC/51Qx+7Pde3v7X2ilveC+wKlavoC8ya8Cg
X-Gm-Message-State: AOJu0YwTqrCZIp1YUKLNMPzPATv+sO6Yo3mcdLSiTdQXRI0C1iLQMi97
	eEBLyr+VpqUWXfnOArkFG+CGHQYqlPUZjem95TUjTqz02J1N2Ly6eLQWQIF6Lu4=
X-Google-Smtp-Source: AGHT+IFPilx0RIzigUSas2wp+HZomIIDYFY/HSTVARt1ijpdHFRLg8nhL/HqfJTPXB+HZiEOggXsdA==
X-Received: by 2002:a05:600c:4f8a:b0:414:239:40cc with SMTP id n10-20020a05600c4f8a00b00414023940ccmr6668887wmq.12.1710756590085;
        Mon, 18 Mar 2024 03:09:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b0033e3c4e600asm9533734wrq.7.2024.03.18.03.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:09:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Mar 2024 11:09:45 +0100
Subject: [PATCH v4 1/2] arm64: dts: qcom: sm8650: add GPU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-topic-sm8650-gpu-v4-1-206eb0d31694@linaro.org>
References: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org>
In-Reply-To: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NHUBJ3C6TZTrEVk6MIERemImihySUvN3VXYQqv+Am2w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+BLrVd7jnoT/LAxO7dXAC92pmy6jUQ4xo1jQii6N
 TUQbQfqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfgS6wAKCRB33NvayMhJ0WTdD/
 4/IU9zp8j6JL+q1JvMZSESSsKSv/tNtZzH58ZnbxeQWqrI8/0/TGbeNk0ceuAPC+WLnhXZS3DKiU3x
 uuKNSV5ywgqnMfo3+PCj0E53w1HaoW3drRekEPyedUk14O/SM/9x6wgi4jtxMXpgfJfow1W2reKEp+
 10CkfEgLycxHasVAIDTVMvtt/KlE5H2WkpOmq9B/9gAqWi1A/D67hOq+23zq10Wi9HjzQubQsfsYyF
 l/V8fcsl0YjF/vRuFNO4pC2ggBliLdY0mdb3AqKVHl4gdISifmdxuzVfqPvBKc05GL61STP6i5O3QE
 GbpI3onuuJBO5uZUpv7mkoBpb+a8QtEGYXZfKYSwMHyGkPmrBLMYejy2Rb/1xw0jMIWu9/ZWKx30S6
 pWAA0ZYaNmqtDwqNVagCw8pCvoiGql/3qaaMFiaro8r7u8UsbipSgP0AFbGk7mSp8GBsHpWUyrpuv1
 7JBHNIe1ez3JQgPeIZ+xoMA94HtnJNMP/cfeR8oupdvzautinqzoI4LIKDiD9t1SLDE9mQ21JPADSN
 lUyCNu1B+UPe8RlIZJkQmejFRF78mdQnNL+Ab0m3jMdVnMH5C0NQYI/f7hD14CEuQTttZgoawc0BDe
 GRVx0+Q79towmPsvxI4Rx+m9+uc44YMPOEyGQgj6m8iEuOyxsQJxBQhUtOaQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add GPU nodes for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 181 +++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..99aa15c7c074 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2591,6 +2591,143 @@ tcsr: clock-controller@1fc0000 {
 			#reset-cells = <1>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-43051401", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x0>,
+				 <&adreno_smmu 1 0x0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+
+			status = "disabled";
+
+			zap-shader {
+				memory-region = <&gpu_micro_code_mem>;
+			};
+
+			/* Speedbin needs more work on A740+, keep only lower freqs */
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-231000000 {
+					opp-hz = /bits/ 64 <231000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+				};
+
+				opp-310000000 {
+					opp-hz = /bits/ 64 <310000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+				};
+
+				opp-422000000 {
+					opp-hz = /bits/ 64 <422000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+				};
+
+				opp-578000000 {
+					opp-hz = /bits/ 64 <578000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-629000000 {
+					opp-hz = /bits/ 64 <629000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+				};
+
+				opp-680000000 {
+					opp-hz = /bits/ 64 <680000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-720000000 {
+					opp-hz = /bits/ 64 <720000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+				};
+
+				opp-770000000 {
+					opp-hz = /bits/ 64 <770000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				opp-834000000 {
+					opp-hz = /bits/ 64 <834000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-750.1", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x35000>,
+			      <0x0 0x03d50000 0x0 0x10000>,
+			      <0x0 0x0b280000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_DEMET_CLK>;
+			clock-names = "ahb",
+				      "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "hub",
+				      "demet";
+
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			iommus = <&adreno_smmu 5 0x0>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-260000000 {
+					opp-hz = /bits/ 64 <260000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-625000000 {
+					opp-hz = /bits/ 64 <625000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sm8650-gpucc";
 			reg = <0 0x03d90000 0 0xa000>;
@@ -2604,6 +2741,50 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,sm8650-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+			power-domains = <&gpucc GPU_CX_GDSC>;
+			dma-coherent;
+		};
+
 		ipa: ipa@3f40000 {
 			compatible = "qcom,sm8650-ipa", "qcom,sm8550-ipa";
 

-- 
2.34.1


