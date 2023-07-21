Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1475CBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGUPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGUPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F3030E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3322385e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953773; x=1690558573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3NPnuiSNZUn11LWRbZ2MODGSya3GaAu8O7pEYeyDVM=;
        b=DE/ZPdRase7WTfWSEA9TOdQZa3d38SY0IUuQ+PtXCunHKthoPsnE5NACVmx5gVyR4y
         ga8k6/EXKLnQPtfmffSXaQ9ZlvcA0rRW6ld99S41Ua29vvqNwEOEcqPM4PU/m8zBG/mk
         qWwMrWVggOhmWe5Ae4sezHC2bb81SQ3LBkb7N7WQTjj9SODdH7HGR3hznVdoSlNYBNFz
         z73MF+myvNYlaRdgveXAyU97ofvtOpsNOXldKY9cRQQMk3AnkQzQjVXk3loM1SX6mGI8
         Urng17AibZyc2HgwW1+JF4JwlHbHclRLje24JQtTtWQuoErwoDbm13eu2ziY4E8Xbxp5
         j6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953773; x=1690558573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3NPnuiSNZUn11LWRbZ2MODGSya3GaAu8O7pEYeyDVM=;
        b=FzG5fRgk182ZiLXxpz4VOP48j+1k6mEG9o8vrW5fjaD8AZLeUTOpHGgUDT7Lu8+XYM
         nj2nwrCNOWeV/xKVP4sTW1itNjasCJV0FVUPhZAd/4kODweovPhrdlyRsB6h8wy6XZEz
         S/JsHEaaLoLAXIAVFbt8jnS3JNC2+Pjy2VCdnfYX93oJ1GuK3k/4sbQH2qZpYwe+vClJ
         uBRO3CFgkjpopXv43xWPnqJU5ionlQE084+lH4odC6nBpcVX4ldaGpmOVCMC4pci883H
         eJH26gpS0EKnw6CHFK5yOBUWT2sgR4xW1ZTmM5bGWsVxYafvcSQc0VEmKOv8ErccvMeS
         pS6g==
X-Gm-Message-State: ABy/qLYLPNH48Gl+FUVHTOpBErWSwxgA7IOsYIEtXqVj8ZDHmFQboFhl
        mZ872UqjyiUsCKb4uszp9zuSFQ==
X-Google-Smtp-Source: APBJJlGO3EGsyLQ9CvV4g1OEE1jzrhCMzMfFuyk9Jk42JYsj0c1+IiV1WiuOFP8bRH755EcAnIKkyA==
X-Received: by 2002:a05:6512:b97:b0:4fb:97e8:bc1c with SMTP id b23-20020a0565120b9700b004fb97e8bc1cmr2051339lfv.54.1689953772699;
        Fri, 21 Jul 2023 08:36:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:05 +0200
Subject: [PATCH 02/11] arm64: dts: qcom: msm8996: Drop RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-2-cf6cd5c621d5@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=2848;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jEC2qszgf6wzq6do5/+vqhfRa/a+2pz+WPIQyhPAgwA=;
 b=ZEFbgKrCPxnNy+DNrWd/Cxs9ehtwTfhte9Rt3QZRVcfa8eIiUIO8Vy6IKS7MmwtY3rGFqSWZu
 UmMd6EO2I0yD/mp+TkCVgMYGO8pAayTPawhiV9pfW6HhAzZBxUXCVg8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 440557c8eca4..0e1cdb5335eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -798,9 +798,6 @@ bimc: interconnect@408000 {
 			compatible = "qcom,msm8996-bimc";
 			reg = <0x00408000 0x5a000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		tsens0: thermal-sensor@4a9000 {
@@ -851,18 +848,12 @@ cnoc: interconnect@500000 {
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
@@ -882,19 +873,14 @@ a1noc: interconnect@562000 {
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
 
@@ -902,19 +888,14 @@ mnoc: interconnect@5a4000 {
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
2.41.0

