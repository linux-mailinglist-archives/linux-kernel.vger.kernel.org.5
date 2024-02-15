Return-Path: <linux-kernel+bounces-66517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BA855E02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DFDB28424
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B81BC36;
	Thu, 15 Feb 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6h4hsPC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9731182DF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988840; cv=none; b=XncwCxPcDivnmhzHG3NziIlwVm3u81b4tcDYiDRASgqik4C/CXaKRs/QOXaxU7b76SQABlzyLXeT8mqWf+H9LqAuqWS+3oxCDKoNc+vCN+uvZr1jA6cJKBWbwVWoIBJmANeR1gbpse7u9a34mY7TtS1T8ldkf3vpWKE7FnIuy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988840; c=relaxed/simple;
	bh=YnfJMxPEw+Crbp0x61Gr7hpcpYLyCY6opDQJsdz5YLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqzjlN32FAI+iQI/D0OA/tF4HN7NZJLv7Bx+85B+bN91X8fdGzO8gzHRg+zvDI4sT16duPTc9zyAtmmm84mMRi1JxjQsUXMqgDl9z9figKKf/QLAYrI4v4NurCvoa/uv7lz+Bimkm9eyZDItTSC7j20d1n13S3Cdpt5h/WRuIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6h4hsPC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4121a8635a2so2310025e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988837; x=1708593637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoTug8oI3rc0EGfqabXi49TIa0elLz1yO0hJ7mVAsJQ=;
        b=W6h4hsPC+DkUixiozRIH8dQFAJb5uUI9XGrcpsH5V1Hvo4HZoBjDtFdJLGtT+N/1i2
         ALm96oM5grXu2jYJvEG9OQ8/QNwTNDbQyQepn2fTp5CEcOxHCzyGVooC6t7cCUQVEmlb
         I2EB3cd6D1GIdVl29uDDEW8/n2JrcqbgflZsaiQCXr+5J2V6vHnbTa6hwPQb6BpdAu/T
         yHg3rkVBEIQzvjk/qJWEHWePDpJQyhvxpL9jAxa31mIJV7+whs99oXjZzE9GBvPxiK8P
         kDY/SF6wZ/jZG67zU3uYo7iP6/Cd1TXVjpDLeNVpacltWidpv+g/KF1i+US8WGbrVG63
         xnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988837; x=1708593637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoTug8oI3rc0EGfqabXi49TIa0elLz1yO0hJ7mVAsJQ=;
        b=rlNmFVr+3AXNw6S7YahGLuDlm0hvaU4f4EoLNjeZHwMObrBwliQHnrmtJITM+XEuqz
         Z/iJ4eoDVHm1cNYu6IBVdBzV1vA2zY+PGW+HVoTcailNs+m8BO7LepFyqICjqizUL6zf
         ORUkJdpIHE7/L2q43HaYN3W9kLNUvRxOkKT1/oGvAU+RJGSWk2wVJG/oMaSqwxClhqqp
         y0EvQoQvKxbW7GOhtJHpVo/qfvBPmekRgXl9fgJe4C44aKojBwFcfsU5T2e7jsJpYGK7
         ckNsIGWd1vzouD4/RwE0R6lfDCBIiNDMvErZbRD+U8qnOPJoW3zPcCE0mZN1Pv6Qq3DN
         P/tw==
X-Forwarded-Encrypted: i=1; AJvYcCWWDPt593owcfCwHV/XMp/svJbprywnuLFtgbGBdChaHwaRBhrWaT2ONXJSXhbhBwZNopjqEb0PRUS/luM+Fm8e4oxi2wUNlUpW5oyW
X-Gm-Message-State: AOJu0YxASYDYpQNxaxvaqiVIV2e8nv7R8Jz1jAaFLgHTw0rAyy755Goq
	V1C6iONpV8h5SMPU+Nn0UoMMvpvB1GVIOLu/lvTIgR92HFMSlWPsN9+HkS/6gFg=
X-Google-Smtp-Source: AGHT+IGrvfbJ1uUDMa21ZnoJEdi5tRVea1OtDbDqHW32HWnjFevw0x1eHUUlkCjL4h415agx3thpXA==
X-Received: by 2002:a5d:5751:0:b0:33b:3cb0:3081 with SMTP id q17-20020a5d5751000000b0033b3cb03081mr995363wrw.6.1707988837100;
        Thu, 15 Feb 2024 01:20:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b0033b66c2d61esm1156435wrb.48.2024.02.15.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:20:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 15 Feb 2024 10:20:27 +0100
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8650: add GPU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-sm8650-gpu-v2-5-6be0b4bf2e09@linaro.org>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YnfJMxPEw+Crbp0x61Gr7hpcpYLyCY6opDQJsdz5YLA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlzddcRfimUONnmrWNCX250+syb3LF/WRnexivnTqi
 rWBuVceJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc3XXAAKCRB33NvayMhJ0Z6nD/
 9fbuMf2jo4kFuN4Na5g4SaGhBo9f5t7RS2YyuolvNgbmiOCWUxBT2WnpRWGLXxfed+y2oP7H4byB0T
 9xy7Yb+566tShTaC9KwLQfkZcVS+86cXGQwocurs7RX9mJPuvnp8B6C0kEGcG7WcFC0CzPijpHwzo0
 uvosOjOze6t+bxceWJXwCp01m7aZWVdbSVXFORderPanxV8VYSUI3FJByB2Meb5XjvoBJDQM/E43hE
 ZcQYcCimF1FVVgn0B+/vrQ6QGB6UJ1McO3Gp1UjM0iz+Wd5v1GjIng3k/lmiRVUULg8aMqbhRIGk6L
 uT6021tW0ixDYZGfOxr4UnoveSCRlTbmVk/sc2vFj1NBJHygWxSX6VggeEoUmIeOge95mwAxd4zzXq
 0n9GX+7HArdNA4ud4AtphXsicXhLoGncRtd9hw/47IZmrT54tI0cqycl9KRjGl5SuUMdoNLp4zt10y
 UAoDcWClAcfzGd0ajfZYXXdIQb3I1wam5Ao5A4YBgQD6WYL4Jvn5TPQ/V3kWp/jvwyRN4gevsstM8v
 vkKoq3wyVxvmyBXxulhkHS/Os7qd0/6R04JE8Uj8dQb8nA+lC/sIaqLVg1Yn8Y4jCg5i7ay32cDSMA
 WFhAmjzAuYwbvGXjQEoIILRaZGUC9M7BhCsGo6jCR8m0QCN253r8w8sEjfnw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add GPU nodes for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 166 +++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 62e6ae93a9a8..27dcef27b6ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2589,6 +2589,128 @@ tcsr: clock-controller@1fc0000 {
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
+				opp-680000000 {
+					opp-hz = /bits/ 64 <680000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-629000000 {
+					opp-hz = /bits/ 64 <629000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+				};
+
+				opp-578000000 {
+					opp-hz = /bits/ 64 <578000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+				};
+
+				opp-422000000 {
+					opp-hz = /bits/ 64 <422000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+				};
+
+				opp-310000000 {
+					opp-hz = /bits/ 64 <310000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+				};
+
+				opp-231000000 {
+					opp-hz = /bits/ 64 <231000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
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
+				opp-625000000 {
+					opp-hz = /bits/ 64 <625000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-260000000 {
+					opp-hz = /bits/ 64 <260000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sm8650-gpucc";
 			reg = <0 0x03d90000 0 0xa000>;
@@ -2602,6 +2724,50 @@ gpucc: clock-controller@3d90000 {
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


