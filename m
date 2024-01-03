Return-Path: <linux-kernel+bounces-15959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2C82364E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A801F25D09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1A1DDC9;
	Wed,  3 Jan 2024 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUcD8wsR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB41D69E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso5203912a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704312953; x=1704917753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG+rGUp/aDbPyreho5pBvmK90jeiza6JiQ/BR4I5Rh0=;
        b=CUcD8wsRiXRm8uk694dGxz53rBzS8E5Nz/4HYu0rx9Wgp3IRcK16XxXtNXsg/b6GKN
         VEzgyuLeTLoXoAN9p9sDT9Agw7ZeQHI5Q0bC5Li2fhVAf92nVCS5j+HjPxb4qkWe/07+
         J8lhucf04ZJp8jdzShh0DJdfjP9MWHo6tm/ramzycPe6ZhfMh9unIlu+lDIMv/Lwn4yQ
         5SlDJXZ1Dvgd8GRZglFAafVc4xjXSp/pBnmj541ILaE0Gma6qkJHVfu2aE7Qy7TsheAy
         ub71iEyorLOOcoT/2Qm6VTV9fby0MIKFdFllgmZeWI3wtPdkwt89HRdIDfVw25ky83u0
         FEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312953; x=1704917753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG+rGUp/aDbPyreho5pBvmK90jeiza6JiQ/BR4I5Rh0=;
        b=Wd1NZpUDAH1EhVp8J9R/cY6T2K+rlM5hKf1qAIOod0/Jt4mhFP7phESA9bO9teK6Qs
         FgvQ0bPojgkazCDDDl70eP53Jpw1hJMe1rPDLOCBqeS1eMi5Hk7Nx0sOz472v+P8MQ4T
         DJ2YTQJnd24xnE1thRbjbN8ddZeVd8cAY//Fbl+thoUl1FmVrAKYCyHlnGu4AknvWnlo
         eFyxqdhcdyrPzEPp7fXOlf1IR+WWkci4QURIPKHS2UskLFKUwo5w7kxHNouIVylOAxkv
         rziTi9b8SZZIpHoGP91a2/kUdVbfZ5IeQVqBqTHrt1NnWI5PUeJsHOvLbet8T2nC34rD
         BlDg==
X-Gm-Message-State: AOJu0Yyp0YzySgTFH4e3D2i6KDUb8kUHS8qh7yUDrNks/0rARqeNYY+P
	e/xud/AGkiEudXYVPejkHIq4T0Pu6N2lBA==
X-Google-Smtp-Source: AGHT+IHQmGjzP5vgapA4A+rsvLd/epbRl1zsiwJh/v4sKcG8w8L/6Wy20/D3bS2kHz5i+oOyNfjbtQ==
X-Received: by 2002:aa7:d997:0:b0:553:9c31:b4ab with SMTP id u23-20020aa7d997000000b005539c31b4abmr11520614eds.19.1704312953788;
        Wed, 03 Jan 2024 12:15:53 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id fg9-20020a056402548900b00552691fc7f9sm17549670edb.66.2024.01.03.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:15:53 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 21:15:33 +0100
Subject: [PATCH v3 3/9] arm64: dts: qcom: msm8996: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v3-3-a66e698932e3@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704312946; l=3085;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YxJ1U7v2W6bIKmc1zORJCie36EHFesuD+RzyvvnJwE4=;
 b=Ib8hCQrhv5eBT49OArc3ay46lRUDtnr9udu3AJdS6d3VAK2bMeZkXVIvdF0bukxrsE18F3G7n
 NAeD35/S/gBBR5+my4I/uHa0PK4B0qdbzzrwKmEVwhVxhZRsJeRajGV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some nodes are abusingly referencing some of the internal bus clocks,
that were recently removed in Linux (because the original implementation
did not make much sense), managing them as if they were the only devices
on an NoC bus.

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c6a7efa90c4..4f465ac573f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -838,9 +838,6 @@ bimc: interconnect@408000 {
 			compatible = "qcom,msm8996-bimc";
 			reg = <0x00408000 0x5a000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		tsens0: thermal-sensor@4a9000 {
@@ -891,18 +888,12 @@ cnoc: interconnect@500000 {
 			compatible = "qcom,msm8996-cnoc";
 			reg = <0x00500000 0x1000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
-				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
 		};
 
 		snoc: interconnect@524000 {
 			compatible = "qcom,msm8996-snoc";
 			reg = <0x00524000 0x1c000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		a0noc: interconnect@543000 {
@@ -922,19 +913,14 @@ a1noc: interconnect@562000 {
 			compatible = "qcom,msm8996-a1noc";
 			reg = <0x00562000 0x5000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_AGGR1_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR1_NOC_A_CLK>;
 		};
 
 		a2noc: interconnect@583000 {
 			compatible = "qcom,msm8996-a2noc";
 			reg = <0x00583000 0x7000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a", "aggre2_ufs_axi", "ufs_axi";
-			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
-				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+			clock-names = "aggre2_ufs_axi", "ufs_axi";
+			clocks = <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
 				 <&gcc GCC_UFS_AXI_CLK>;
 		};
 
@@ -942,19 +928,14 @@ mnoc: interconnect@5a4000 {
 			compatible = "qcom,msm8996-mnoc";
 			reg = <0x005a4000 0x1c000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a", "iface";
-			clocks = <&rpmcc RPM_SMD_MMAXI_CLK>,
-				 <&rpmcc RPM_SMD_MMAXI_A_CLK>,
-				 <&mmcc AHB_CLK_SRC>;
+			clock-names = "iface";
+			clocks = <&mmcc AHB_CLK_SRC>;
 		};
 
 		pnoc: interconnect@5c0000 {
 			compatible = "qcom,msm8996-pnoc";
 			reg = <0x005c0000 0x3000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
 		};
 
 		tcsr_mutex: hwlock@740000 {

-- 
2.43.0


