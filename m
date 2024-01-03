Return-Path: <linux-kernel+bounces-15961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5E823658
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967E71F25D44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223A1EB53;
	Wed,  3 Jan 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0n2mIwV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0641DDEA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e67f70f34so9523892e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704312957; x=1704917757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlRGkSxspqLt8e6uj4TsPbjrXxLpOwfPHKo5tpzsP1U=;
        b=j0n2mIwVTvGSqDWyYser0LZwVW95yXczmYnenMlGuJOClM7NXi+3c8E/gUopyfkB7n
         idLW0Y/ECQC8kzuMvNbI2v8XIes6SWAR5FtfH67pJ/N7gFEQoYJCdwTgIEx0TfWpl/Nt
         OrOnAIg8lYGDWrLDGsWy6S9KvRMBo8bKYPghWHgLLT08utjbfyd+oRJsqFDV4euUB4m+
         YKpyR2Ee3mRfgvzI+GihQsDBaLGDIF6f7oJT5IbMIIoINGSyC1T/0AMYpFLAxQvfKsJE
         oBUMjZfF9fDraSKyd+dflxywqoY6u7NQF+Z5zGlMGeCPLdKn8Q20kL+K5f9Z1STxYMlM
         d0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312957; x=1704917757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlRGkSxspqLt8e6uj4TsPbjrXxLpOwfPHKo5tpzsP1U=;
        b=HVNnnvtcowp9ADlRt6gtony9fXcmddxmbfO90oj6sOpYhfV12ZRh0fIkWEQtM+oLz8
         QDVhKDOWrraUCzPZgKwIe9OKJOqV2R+v+mS5KvgvXwftTlde9PNI5Lc02Xzumncd6VqR
         vrr7kWs00DlAwxJUutjp2P6YAEyCEwMf2Kz9eCn62VDjpxGgI6oX/uyo+iRjOs0EGRvO
         pRzKJtbzOYKkuFRna153+5JElCXmaZ+xl+kTh2+2ljnqWTmEKjxrZ6360rfKXDqnqaFv
         9japFKmYDtvLZlkcVSY+ZoiUuvZYbkZi7/mOVIvH9Jc+gjmp7V/aSRenKve7My+Y7QCE
         mXdQ==
X-Gm-Message-State: AOJu0YyRp37w5IpbM3HMZvrIi/IxwoJQk9Uhre+pwI+qO9ZrOzWmpovT
	B3jIm8b3mvn8b3GFdN5XI5uF7Qqjx5hN3Q==
X-Google-Smtp-Source: AGHT+IEVvy0cSxkpkQE7xYVxHf/U0MKSkUruQtZANnzecQeQ2YZwnD/BWk8zALBpd1fT9kVrswLqCw==
X-Received: by 2002:ac2:58d7:0:b0:50e:2737:f603 with SMTP id u23-20020ac258d7000000b0050e2737f603mr7182940lfo.48.1704312956978;
        Wed, 03 Jan 2024 12:15:56 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id fg9-20020a056402548900b00552691fc7f9sm17549670edb.66.2024.01.03.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:15:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 21:15:35 +0100
Subject: [PATCH v3 5/9] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v3-5-a66e698932e3@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v3-0-a66e698932e3@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v3-0-a66e698932e3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704312946; l=5031;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cl8sg1LTCxzGU52mzB+vk83BznWR80LOUN+g9wXpRf0=;
 b=pvj8+pAQlY7Mrw9NDRswB7bRzDGoa0CzPM1aqi5SgUUCLigue33wE/7OY8OyV9EaJGEsyVmEu
 RxTOKHepsBQCfIH8MRcYuTLSVHAyZ3EilGt6Q2fSgp7YQK+vvmOC7jk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some nodes are abusingly referencing some of the internal bus clocks,
that were recently removed in Linux (because the original implementation
did not make much sense), managing them as if they were the only devices
on an NoC bus.

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 53 ++++++++----------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 775700f78e0f..513fe5e76b68 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -606,9 +606,6 @@ bimc: interconnect@1008000 {
 			compatible = "qcom,sdm660-bimc";
 			reg = <0x01008000 0x78000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		restart@10ac000 {
@@ -620,28 +617,17 @@ cnoc: interconnect@1500000 {
 			compatible = "qcom,sdm660-cnoc";
 			reg = <0x01500000 0x10000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
-				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
 		};
 
 		snoc: interconnect@1626000 {
 			compatible = "qcom,sdm660-snoc";
 			reg = <0x01626000 0x7090>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		anoc2_smmu: iommu@16c0000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x016c0000 0x40000>;
-
-			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			assigned-clock-rates = <1000>;
-			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "bus";
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 
@@ -686,16 +672,12 @@ a2noc: interconnect@1704000 {
 			compatible = "qcom,sdm660-a2noc";
 			reg = <0x01704000 0xc100>;
 			#interconnect-cells = <1>;
-			clock-names = "bus",
-				      "bus_a",
-				      "ipa",
+			clock-names = "ipa",
 				      "ufs_axi",
 				      "aggre2_ufs_axi",
 				      "aggre2_usb3_axi",
 				      "cfg_noc_usb2_axi";
-			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
-				 <&rpmcc RPM_SMD_IPA_CLK>,
+			clocks = <&rpmcc RPM_SMD_IPA_CLK>,
 				 <&gcc GCC_UFS_AXI_CLK>,
 				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
 				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
@@ -706,10 +688,8 @@ mnoc: interconnect@1745000 {
 			compatible = "qcom,sdm660-mnoc";
 			reg = <0x01745000 0xa010>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a", "iface";
-			clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
-				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
-				 <&mmcc AHB_CLK_SRC>;
+			clock-names = "iface";
+			clocks = <&mmcc AHB_CLK_SRC>;
 		};
 
 		tsens: thermal-sensor@10ae000 {
@@ -1186,7 +1166,9 @@ kgsl_smmu: iommu@5040000 {
 			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
 				 <&gcc GCC_BIMC_GFX_CLK>,
 				 <&gcc GCC_GPU_BIMC_GFX_CLK>;
-			clock-names = "iface", "mem", "mem_iface";
+			clock-names = "iface",
+			              "mem",
+				      "mem_iface";
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 
@@ -1288,20 +1270,16 @@ usb3: usb@a8f8800 {
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_SLEEP_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
 			clock-names = "cfg_noc",
 				      "core",
 				      "iface",
 				      "sleep",
-				      "mock_utmi",
-				      "bus";
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-					  <&gcc GCC_USB30_MASTER_CLK>,
-					  <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			assigned-clock-rates = <19200000>, <120000000>,
-					       <19200000>;
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
 
 			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
@@ -2204,10 +2182,9 @@ mmss_smmu: iommu@cd00000 {
 
 			clocks = <&mmcc MNOC_AHB_CLK>,
 				 <&mmcc BIMC_SMMU_AHB_CLK>,
-				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
 			clock-names = "iface-mm", "iface-smmu",
-				      "bus-mm", "bus-smmu";
+				      "bus-smmu";
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 
@@ -2324,12 +2301,6 @@ gnoc: interconnect@17900000 {
 			compatible = "qcom,sdm660-gnoc";
 			reg = <0x17900000 0xe000>;
 			#interconnect-cells = <1>;
-			/*
-			 * This one apparently features no clocks,
-			 * so let's not mess with the driver needlessly
-			 */
-			clock-names = "bus", "bus_a";
-			clocks = <&xo_board>, <&xo_board>;
 		};
 
 		apcs_glb: mailbox@17911000 {

-- 
2.43.0


