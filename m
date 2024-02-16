Return-Path: <linux-kernel+bounces-68486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA569857B07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD161C24087
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FF60DEA;
	Fri, 16 Feb 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oH5WTlgx"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025865A115
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081445; cv=none; b=WRLXYWG8qAdbu0vM2kZZmLs6QfTczuUnL+/2VB5bV5sFTxF2tusviZDzlML4SrL5zL+Js8JQCC5YcpgVDlIGMEIr9tL0VRbgPV92dmZd8bv+P21Ei4tT+3clUre3fX2P80zZZiW7ovtmGi9MPR8iuKUHtRWWDfEsY/N2mHlWW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081445; c=relaxed/simple;
	bh=YnfJMxPEw+Crbp0x61Gr7hpcpYLyCY6opDQJsdz5YLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoU+cJ/GFWG5tyPKfE5fDFYRBD6g3XbUSRf0FCkaCAMCHIMGjS5oij2Bt/lty+YRN9yU758BKy9OHgyIPcgXGZz4BEWftjcoEBIydlXsNhMu5dIGykrt484mbmGQEc7YpvKCMCTHvo88iXXYNfg/QjJb1cOjDx8KCsFg2x5sWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oH5WTlgx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5128812662eso845286e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708081441; x=1708686241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoTug8oI3rc0EGfqabXi49TIa0elLz1yO0hJ7mVAsJQ=;
        b=oH5WTlgx5e72O57qJqV/awMRLJSqFBGQRKxLsY8KSZF4CsiX65Psr5hc9x9SPMsjYv
         zNA4yBBP3O/Xk93ejWuSBcRR4tXe3HqxJ2qouY+7r0Co92EmpW1QVRU/bIUtDjQ24iRB
         fVDnRPVWik5yATKt3GmZPk4OliO9BBVn1WKAA8Pv2aJexdgv7fWn9L+4uFb1iXl2p2gq
         rE9x5YgkC5MRWVAGce3+EDLuBf2f0LF+ODgLTQR9C3qsrNPmFk6BsaPA7o1+KDBWKbjQ
         46LEyjiOOEXPLT1nK2gAjci7Kgjfi6R91cRzZQADVVXZi24cWOFr0Dc3lRokKPee+Px0
         AnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081441; x=1708686241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoTug8oI3rc0EGfqabXi49TIa0elLz1yO0hJ7mVAsJQ=;
        b=qfu1V8n1AW4dEO6AnzEITpb7SKqI9XQ/ErRVHwbIK2KxZW4Q0X40RIapB3zIUBPGzJ
         JoCak3jvZM8qrveVRFwrX8QfgqgYPz472uBlhEDTU2NSyPezq/pHMgD8O2QNOAzmxU6+
         2a8GJUvgswDwtKU5arI3YXyDJQ8nsjxolLVbWYZNTgMDflhPbGCo2mBSlm0pVBKMIvbH
         g1HzoRKEt/ESN0NwlvlW0U7WIiNMPy27keufMfeRvAChmYHqNZTvwQw+44/p6oFY/GJr
         RVAEF1BqXUaRMCQFrVQJl3rcOAi/Wp8YNIoGdnBUrptBcT2oTNbyqG53lWoxl9Yqp4Dx
         9xcw==
X-Forwarded-Encrypted: i=1; AJvYcCVw0DG4PbyHSKxFiCAnw9NO2WdoGF3LdmQXNT3w4JBdnYEO9extFtTww0kJjnxduZShmsfjPCMtauVpvmjrNUJ+igMuItbifPOLnsnk
X-Gm-Message-State: AOJu0YzrSAbDOyRp237eDItNA5Suq+luRwTBcnliOypFniU/5RHmZ0kr
	cf8FP81NuMVdySK2Gww7zIarIyTVq6nF1TKMPrLbR/PctBhYEGke4W0AZcy7ADc=
X-Google-Smtp-Source: AGHT+IGgy6ifdMfZjZdNLwnOMo0WQysyGJ5gI0bzwsoEE/gUN5DhE5K8JJiVngICStweqFy9QnhFmQ==
X-Received: by 2002:a19:7707:0:b0:511:3283:e3af with SMTP id s7-20020a197707000000b005113283e3afmr3198713lfc.27.1708081440926;
        Fri, 16 Feb 2024 03:04:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm1993174wmq.37.2024.02.16.03.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:04:00 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 16 Feb 2024 12:03:53 +0100
Subject: [PATCH v3 6/7] arm64: dts: qcom: sm8650: add GPU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
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
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5727;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YnfJMxPEw+Crbp0x61Gr7hpcpYLyCY6opDQJsdz5YLA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlz0EXwDY7Yg7aqci7SJjR9nKSoD54wIwV2Vb+CdAy
 SVfXnDKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc9BFwAKCRB33NvayMhJ0fq1D/
 0eVUzJBgVh7s/6KY8RP210qpWDN8Vcdh5LSPux3vDXKfQzkirc0B1hlpVU6oWrO9BCE6IFuvisnKAH
 r7t1p9kHhbErqX9yBsMFoRm+YCOs2lEQtiN7ur+M8r5rbkvy6vycF0UTn1lsu1F6VsK0ADiwqbuaRf
 9EmUNyMt1WkvYjQXV0zjBy6GEMj+IW94G6/Y48MHOBzOhcAQq7KnO5I4shutgepEzmFljLC4ZS5BJ8
 YO0Me3cggxTS1ltUSANtNpKLHzj4pYcP4gl29/lMj1HPE5MBCkzO9FsZNNexuFQ+dnxsw+Sfm5t7YB
 4mLfP/iWaZAHUdo96idrEd4kP/I7oLMA8tB5c2lIJrpvfqQH5vkVBRbbSCRm6W2RehqYriSlemWc1F
 tYLh8KvL7zWcGxv6VKSH6XT4bPbOfveXv2y/8dKICBEUfGWX+7rNE80o6xraWpAe8B7ToejmrbYPZD
 qDY5OwNZq8FR+20G8AlHhlWI0WNcIAMtQ17vB8IiLKf4WVi9NynXpoLFV2FjhX/Zp5dcbYB9iuMSt/
 jrqLVuTVY/4G7CzBsRs+bF0rKOF1rn60XXS8pZxWy/dQLW6HO10FMeZfKjgCqzTKRvCS9wTSJ5xNPW
 sBQKAZpB83oGAHXe6xC2l/GViUFra/G2P6u4o7wYIRHIRyxUEFbTgJuvI50A==
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


