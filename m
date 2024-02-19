Return-Path: <linux-kernel+bounces-71417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE385A4EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20921C209C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900CE3C062;
	Mon, 19 Feb 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jC6KFrS4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43036AE5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349783; cv=none; b=GzCqTdRsuzayRu2gTC9nY/oLoZ4yJaAqILTJOG24ExNG5S96/1xPlqrRvILlwCYkelJDGpatV3AanUkPKSKnA7zAe2yYe8Zxcd1z6cOtmsX0YFjG8mSALJmJlUGh1QbbFN4fUcGX0aOQVjMZAarZ5ezudhQ2c8lr4Kf+sgTgifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349783; c=relaxed/simple;
	bh=HC/xBfPb+Ge3S4O35AHKQR0tXgYuKOO6Vtq5u/Zvis8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDkIVXVn81lGPPKAmAAg/VeRiNpeYelNmzWSo5XrPX1UGdlCRAAx72mY1A81EgncOV3sCc7RdCQP/7flGPGmjoGtYRw5DHuxN/ZhLxtLmwVEj2ndPs+vofKgOQ6XzGfYoex+iOpUo4OhMUpjChzZUf6qtrLalUikUBoaT+xo87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jC6KFrS4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso3716722a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349780; x=1708954580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfbMb3jj0qItrK4emPJgHKMlXlJN3RIWDWQruK+cJ2c=;
        b=jC6KFrS42iUy6rxRlREt2hpAHjTVeks+AD6lB2ox/QRFyxlBNqj/hA96m06C/WbTGz
         MdPF/4y1SCPsbcRY+PVPKTolG2Z3D360UX1zBvH1E05cLeSXEFgoHlQi4ilSoqbd/fHG
         XG2tOBGmyzRHeeinPhq9SJZAY8xgZsMliIkGhbClVho14ayKHlXkpA3wZ8HBNabJiUkY
         jVPl5UOSMveEou4C7FX2FCLJnqmOehz5zz8aHWkbLArTil8Pnbw8plcYqgkEQO5BJJFi
         OQ+TMuK4cVV+jODRwSYj2dXiQ4axtfiUvAr5k7PUiDNq8CKVCGJWT48HMs4fgswT1QWe
         4eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349780; x=1708954580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfbMb3jj0qItrK4emPJgHKMlXlJN3RIWDWQruK+cJ2c=;
        b=pfyqNDovIOe7whxeL7T3Ct4bLw8PP8A/kIVBUPiYFcawH9SEg5+zCTWnjkPNAm2HHb
         LZiW8IcQ2dzv+S2BNUTHzU65m6RaGC38EwyX3+hato7WfwXsDTwuGzl3vTQeZUuqCwgK
         BFD4qZRh4bHwhksDEzSL+MqsYF7AE9051Mfo2gEk7idlN4U77C8kOZsIIsaMguppmk2O
         sLis543QtrURsW5tFJyVwBKkoJega2SWA2GfuebpmZWl2/czzCs4gJXOoxoCIJZ4UWAJ
         j50zGdNNxzNcSsEN0uxVK3QwJOnO7LvIZQ+g27ZUWxBGCdxj9sJjdmtnoNMudSlXybZn
         FC9A==
X-Forwarded-Encrypted: i=1; AJvYcCWj8fgMDsEuCcbGZUOLJJ1mbzkI1m/nCtKmzzjoWZMcdB4CRLEqzLDikZVDxO/j6zu1FBP+c9IyogVvVEQbnabxTDw8/akJZYoPo+YW
X-Gm-Message-State: AOJu0YwJ99CDLHdkhWJDsqNw02l7QmwxWliZLs/XHRfKdVonU41Q8pME
	K4dBD6FgczEwtygGdXUm5KFLidNzhIg19ymoaA6in7gP1Jbf7+eqIVZWQsMHiIA=
X-Google-Smtp-Source: AGHT+IGVF2NlMcSebY5m3UgwICGV6Y1d5NL0fAQF4zO4ZxHlMwU6m/KrAlCRO8vwbMnsO7021ZaMIw==
X-Received: by 2002:a05:6402:358:b0:564:8d2f:505b with SMTP id r24-20020a056402035800b005648d2f505bmr1119514edw.39.1708349780176;
        Mon, 19 Feb 2024 05:36:20 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:19 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:52 +0100
Subject: [PATCH 7/8] arm64: dts: qcom: qcm2290: Add GPU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-7-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=5419;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HC/xBfPb+Ge3S4O35AHKQR0tXgYuKOO6Vtq5u/Zvis8=;
 b=6WqrsuxfLwQscwtWGCN3jaXQS4gD+jRD2N76tzuid6qwF60qAtrmeKNmZwBsDDJYOwXJF/j8X
 yi7onOH5wJcCDk8DEhMMqf3+8V2WfyVbN7QF698aYfGcH1cr1M7d0IK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Describe the GPU hardware on the QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 154 ++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 89beac833d43..ec5aef5d9c69 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,dispcc-qcm2290.h>
 #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+#include <dt-bindings/clock/qcom,qcm2290-gpucc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
@@ -737,6 +738,11 @@ qusb2_hstx_trim: hstx-trim@25b {
 				reg = <0x25b 0x1>;
 				bits = <1 4>;
 			};
+
+			gpu_speed_bin: gpu-speed-bin@2006 {
+				reg = <0x2006 0x2>;
+				bits = <5 8>;
+			};
 		};
 
 		pmu@1b8e300 {
@@ -1383,6 +1389,154 @@ usb_dwc3: usb@4e00000 {
 			};
 		};
 
+		gpu: gpu@5900000 {
+			compatible = "qcom,adreno-07000200", "qcom,adreno";
+			reg = <0x0 0x05900000 0x0 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_BIMC_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "mem_iface",
+				      "alt_mem_iface",
+				      "gmu",
+				      "xo";
+
+			interconnects = <&bimc MASTER_GFX3D RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0 1>,
+				 <&adreno_smmu 2 0>;
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmpd QCM2290_VDDCX>;
+			qcom,gmu = <&gmu_wrapper>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			zap-shader {
+				memory-region = <&pil_gpu_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* TODO: Scale RPM_SMD_BIMC_GPU_CLK w/ turbo freqs */
+				opp-1123200000 {
+					opp-hz = /bits/ 64 <1123200000>;
+					required-opps = <&rpmpd_opp_turbo_plus>;
+					opp-peak-kBps = <6881000>;
+					opp-supported-hw = <0x3>;
+					turbo-mode;
+				};
+
+				opp-1017600000 {
+					opp-hz = /bits/ 64 <1017600000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					opp-peak-kBps = <6881000>;
+					opp-supported-hw = <0x3>;
+					turbo-mode;
+				};
+
+				opp-921600000 {
+					opp-hz = /bits/ 64 <921600000>;
+					required-opps = <&rpmpd_opp_nom_plus>;
+					opp-peak-kBps = <6881000>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-844800000 {
+					opp-hz = /bits/ 64 <844800000>;
+					required-opps = <&rpmpd_opp_nom>;
+					opp-peak-kBps = <6881000>;
+					opp-supported-hw = <0x7>;
+				};
+
+				opp-672000000 {
+					opp-hz = /bits/ 64 <672000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <3879000>;
+					opp-supported-hw = <0xf>;
+				};
+
+				opp-537600000 {
+					opp-hz = /bits/ 64 <537600000>;
+					required-opps = <&rpmpd_opp_svs>;
+					opp-peak-kBps = <2929000>;
+					opp-supported-hw = <0xf>;
+				};
+
+				opp-355200000 {
+					opp-hz = /bits/ 64 <355200000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <1720000>;
+					opp-supported-hw = <0xf>;
+				};
+			};
+		};
+
+		gmu_wrapper: gmu@596a000 {
+			compatible = "qcom,adreno-gmu-wrapper";
+			reg = <0x0 0x0596a000 0x0 0x30000>;
+			reg-names = "gmu";
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+		};
+
+		gpucc: clock-controller@5990000 {
+			compatible = "qcom,qcm2290-gpucc";
+			reg = <0x0 0x05990000 0x0 0x9000>;
+			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmpd QCM2290_VDDCX>;
+			required-opps = <&rpmpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,qcm2290-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "mem",
+				      "hlos",
+				      "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+
+			#global-interrupts = <1>;
+			#iommu-cells = <2>;
+		};
+
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,qcm2290-mdss";
 			reg = <0x0 0x05e00000 0x0 0x1000>;

-- 
2.43.2


