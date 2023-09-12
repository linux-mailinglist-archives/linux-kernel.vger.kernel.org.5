Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E879D246
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjILNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjILNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB621727
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so6813217a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525519; x=1695130319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cAUp6iqIfoEYwT2Ywlf4KbJQ18NYneTc7cMa1vlC9U=;
        b=zxi+hvkSz2Btoi44cltmtH+GgjwmH1u2CqeBGEbFffx/FV2twdWtYC/c1K6qQ05Bi2
         8L2wYRTpbJYuDeXRzMGLRHfqQM6lS7vVkAUDPX4ki1iH0+Iuh5uQVjEpR4lqL1tOUNfG
         snecXhaghQ4MbwZB49T1ACO6LOCxDT+t9xAt8aTfUS0TMQN/UX+NWzFQI84QELa2JAkz
         7dOtJ9N/deoyg345Llovtu0Qe0ZB8i6YyI8Dlg5+tsyRIDpCc5+k7Bpjt12E4iScqtXk
         KVHqoZKY83mCYLldeYAtV5V5Ywryp2cirsFRoFxa7aDdUHfo24/o4CiTddCn1H6vwBH1
         lwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525519; x=1695130319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cAUp6iqIfoEYwT2Ywlf4KbJQ18NYneTc7cMa1vlC9U=;
        b=YJOH4Nz3c6MKgVeGo++ZV/LlldaogqLssXq3rGUcx2lxFTVzs7lZv+QqHOpR5d5CTe
         H91CuS8IK5FYHhzns21LysKPXTe9PuTCIVffVl+JNio1Ml352Od6QVUV0jG+gUK4oJuW
         WUHGwrpAMyye/1FdX9GjTR6tXMrp20OC0VUiLFpolSUSdOF6X5X3qeNEQz3Oicxekj6X
         rIYOHqivHtjcKZ4XzPg2Gq9UBibvDWXwwee1MIyYvZCbyXrkmAEGi9ltb8lDTdJvCcub
         D2bUIm5efoeY2KEKoA3oWCUFRtNB2VREOktSm3e18RUJMhBpC00JEv3y+quPo45Wo7w3
         oGhQ==
X-Gm-Message-State: AOJu0YwQAGKkrIXaTVcx8D/TYZd4M+oVacGdOscSbljnlxEHOcRL+Ol1
        z6PaQkrJaLCtyNhEEavkQg0RwQ==
X-Google-Smtp-Source: AGHT+IHrRow731IjuVawm62DqcRXfph0ITp9wsTkE4wa3vLzsJfkUEHjGvnNV1CIX1CT9vRI7TWVMA==
X-Received: by 2002:aa7:d3d1:0:b0:523:2847:fb5a with SMTP id o17-20020aa7d3d1000000b005232847fb5amr9100271edr.40.1694525518977;
        Tue, 12 Sep 2023 06:31:58 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:31:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:44 +0200
Subject: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=4386;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sfSwBRR5enYP/jva74He4iYb0xqA+8EzRsqTAivm8lc=;
 b=alB5BmdWnE9xT/JxFw3plJfN4oBVJBWyH/BVrel7Aq19GlTTN1KjMGBe4rU9ZDoyLdNTjNQGM
 TP7Ze06lhfbCG3qZI+o+IfoOiGCLS3T9jh2pHa0YjDzQGNiD3dTduQS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 49 +++++++-----------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index ec6003212c4d..f11d2a07508c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -605,9 +605,6 @@ bimc: interconnect@1008000 {
 			compatible = "qcom,sdm660-bimc";
 			reg = <0x01008000 0x78000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		restart@10ac000 {
@@ -619,28 +616,17 @@ cnoc: interconnect@1500000 {
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
 
@@ -685,16 +671,12 @@ a2noc: interconnect@1704000 {
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
@@ -705,10 +687,8 @@ mnoc: interconnect@1745000 {
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
@@ -1228,20 +1208,16 @@ usb3: usb@a8f8800 {
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
@@ -2144,10 +2120,9 @@ mmss_smmu: iommu@cd00000 {
 
 			clocks = <&mmcc MNOC_AHB_CLK>,
 				 <&mmcc BIMC_SMMU_AHB_CLK>,
-				 <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
 			clock-names = "iface-mm", "iface-smmu",
-				      "bus-mm", "bus-smmu";
+				      "bus-smmu";
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 
@@ -2264,12 +2239,6 @@ gnoc: interconnect@17900000 {
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
2.42.0

