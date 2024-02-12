Return-Path: <linux-kernel+bounces-61331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9B851129
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422361C2213F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CA39AC3;
	Mon, 12 Feb 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECmKadgi"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CB38DE3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734263; cv=none; b=o1011gGsUzSGT/2PeJM/cCZLcS5gXV1sAVUqY08NPp0xgWGCJ68/JPQzD2UqOytIbv0ewCXVhPNQb1eDFVnH5JZHfXhGFjOS8eTtyTSP5JexJ+GcZORermzQBX8tljr6AVOLlo+hVxJCqRhic9gqjaAvmrwT0rewOaIUXCQkQ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734263; c=relaxed/simple;
	bh=xyLfZPXlw/IodCwjvhXZT5/vJzFVRw7x6bUaOPy/kvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB6Vd+fYLCs5eV/lcIbeYUhH6NgX3uidVvJlEPdBsesuHgveYzlo/ZAq+XHWaGLrGl0Qt1aTEbSwMK8FnCayULKOep3sx6Bbu77zGMGJOGy/62abodkCGQHGvmAxtewW/LuT/rsqMqxhEMw2PRGPVbBLrtilgD22DA3M/VPfzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ECmKadgi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-339289fead2so1950560f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707734259; x=1708339059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BvdEXroOBmE71hlHUMyNUGGBnmMbDfsjcjkOq7OOqQ=;
        b=ECmKadgiHg0C2oP5TwTNfu+G96n/KSE6P+vOSDZXXhion9HOUw98AF3Og6NBLpn6YB
         g23YOOy3qvWGlxS6n2rN6sNp3PZfJlfbUUvMwR8RKH9KijpJ2SVZjVPwTfHMINJ0sZTd
         xIAXWcIeCrvc/SsqHhwZDmpyWy60CrORGdO5rAnmjCwDOLWuJi+AKRFIUko2tSBMm2d5
         0OuFOGTFLeerHRpBYp1mIQWL0TsTlRtcxrtwKljjSL1W7k3TB+qdaXRDxzXpCTkslXB2
         JXQ36H/BKyZuJ2OvyAFAa32MvfdHf7HteBXvtGh7ygXsjxnzzbB2Wp6UZ5nz9/kLXXIa
         LRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734259; x=1708339059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BvdEXroOBmE71hlHUMyNUGGBnmMbDfsjcjkOq7OOqQ=;
        b=gJvxBvt7Tc7EjPIRXf3ToBBRHrPkjUFN6DpEEr9S+HfaBqcNTwvfqRVLOjS50Op6fo
         te8mWxqNMKvn0oXG9fY0S7ae4/4lzK13RZjVTYTzoP3Iq2cW3cZl3iMhfS/e+kejv4Kg
         B7zJorGbuQ7s0Jkgg5GjddfdXogxWNe7C1OooggAr5TfhXM+ySWNMP5D9llubcbgd4Vz
         nvEv+ww3rbrsCTgGYcFxHzT3tyiPI4rms5gmuMRhLu7qxSQCDCjSd6bnxWhoXmQraARO
         fDbuhB9ZG8McBchOHNo91Iw3H+ctuYITdZ5VcbTpj0/81f954XL7HYkVISmI+7r2Y8W5
         P0ww==
X-Gm-Message-State: AOJu0Yw7i1C93leojrXysjDqRcsFWrv9uGftBf2In1soR984s7qXnFPf
	kdfDoJ9Ddf0aIjKzjFK3ZUdsFAX73ZT2zXi8MU2CilXfSXi0ygtTGMuTfw0RvEU=
X-Google-Smtp-Source: AGHT+IHfgpBcNTKBPzTl28C7L8l98JcTzLuzauD2qb5+xrPgmA4kkOxd2N5nQ7dQE8XCasCVgrOFsQ==
X-Received: by 2002:a05:6000:4025:b0:33b:28d5:f770 with SMTP id cp37-20020a056000402500b0033b28d5f770mr5113608wrb.62.1707734259567;
        Mon, 12 Feb 2024 02:37:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2ZmLneLBjlDo+rlG+ZbhlhBvLN4FRtZOw3MfS84bGnogqJd7JqkgV3gp07tSOIfluVHCdA7axgCFvXbistoOkbXhGHzuOSjBcakXRj1DAJw9y6GCsic0dHK3RJTKYbKKNte1XywzNhZjgmeb3gT2GmjsPy+C+KgzEJbCPT0fXZ7/KXBdM0UyeMFGmRvdIADx+/hJ8yFGlP1FZsKerGMShAyhAz0RoHUP12lDJ02wiYp9Poaj1PBsb/v6YNI6y3PfMFkKXTrdSINsQ2fzWJR/bZq2ShEnzWBypcSKNo5OOabBYMCzIe38Sk/lINmZgPFPi+MwlP1neGE/Ozb0i7l40Yxx16nUdjH3PMzMk0pqYi+dZXmzCi9sZhWLx7GlrtWePXnFGhBxDC3llTAMb/AvmNyd0aJJro2x1bEnnzC5ZJv7DGloEAlMYP+42Q5LGUUxZJNSKAK4WtXawAkGiwY4bvHpC8CACaSnL1pws0+3d2f/Ot5l4GixtJmL821JnHdyejWHw0/p+GGeK2/AiVXx6feHLu2Eqc9j1UkpAxnwx6bfbfmS8xuJYnmL7YG1lzr4MWMqPm9eiSm4Px5wUMIWWM6Gzqt3WGjnX+3B+Flm6J+0c4l77rkSN+DqUJ9izPDrmmy40YK4nbIYbb1GoJRrGKlTBgXjXOq2kGJw8+noKrYvcrj/nf5Yz5DwtCGQTf8Pyv1Tw02pTKKyUix1m+O/g4tOaM23X6lTsXPC/MGnYMlwda6EloRY0xzkJq/xSEFChJjeJ9NebyKSRu2wWHmlET6BHMPkRvhgnodByl/wf7ZLIOYRp4GEIBL4K1hWnPMyt2mU6GC9OIF2/B5X1HgP8D3YBYdvHoPwpJHM=
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b0033b50e0d493sm6404188wrx.59.2024.02.12.02.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:37:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 12 Feb 2024 11:37:33 +0100
Subject: [PATCH 4/5] arm64: dts: qcom: sm8650: add GPU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-topic-sm8650-gpu-v1-4-708a40b747b5@linaro.org>
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
In-Reply-To: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5837;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xyLfZPXlw/IodCwjvhXZT5/vJzFVRw7x6bUaOPy/kvc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlyfTsVjlUR/LavyXAbdKIkDAS5j/8E5y9K16t90IE
 7hV+hQOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZcn07AAKCRB33NvayMhJ0RAlD/
 9/IP05s3JfcrM/CjbBletyHpeqNlq174CFea6E9cVqSSUpiMdrUl/Z9v6V/lB+b/q52e0KwVuKDQn1
 WPTe7y8xUYGz08k7fbxaCYO+UeMTogkUdu2bY4ECPZTw0Iv/0jfgSFFfdwv07j/8fpZMOe31AQZm8g
 Gr7Uhz/YGrRPFe36xZtBs6Cu2pvdOt9d1tFx5Moeic/J36jhBtE2i5OIcsnsFGr8ZwruIWhRNet1NS
 1ON/ucyT4t2J9LYEK5Dfxb0Cb1UX5p59M+DLN5yWXrht7ZjWiPccd62jFp84n9UBVGQEUAVs6Xrilq
 ZKbAo+AHhEkuK+weFBrOzEFIrpIt/07sG6FpVfLXK/pyi7w7BqLragD4Y8lENANXDbrWpwoMuVglma
 iv2DK+d+xQ/kqMariHMxr2+i2JIbPEF8L9Bwj5SdPkpTysvS4JEYRpWlKCIStHASr7rrzehqeLbrGj
 +gCwWh5xvLrMXZxgcHFX4XbuMPaCM27YOFBe43+n8aLJPS6293w7Y0QaBmg/Ba40eTW5HQqFSOnGp+
 TFH7n8Ua6Cj2f7he57hpF69sEpLa7wBXJ5VSMZuoPyxkTBqjlxIYEJ+V1LAYyfYr9feyQQZ/77l03U
 XYoul5gRKo0f95FgBJrFvnQuZL8YZmSd8cSAhxdXA2P1b4S0kkin7njFnC3w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add GPU nodes for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 169 +++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index c455ca4e6475..f6f9e603fb2f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2582,6 +2582,131 @@ tcsr: clock-controller@1fc0000 {
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
+			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "gfx-mem";
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
@@ -2595,6 +2720,50 @@ gpucc: clock-controller@3d90000 {
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


