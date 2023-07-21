Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AC75CBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjGUPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGUPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306AC3A81
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fddd4e942eso3000963e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953771; x=1690558571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTjKmbTUoKZtW5LXWjKkpdkle/49HkSEc09M87FklNo=;
        b=hlq0hxQUQmlpWkpjMS/jk9PyaX0Ik7KQwX8oy2OZUdcTwuiYNRECG7UkKxH2ABPysj
         vWvwhSGhDYvs++GCrr9t2E5H9F3+sWBA9+uuo3CYDngcdX6mjO6G6Slpo27mRQQyzVuD
         KFr1XBqUegbnX9ykut5XuXuHKvsAhghfh8kqbNIBfnEAesF0fp+KErDtylCtVKVw6Plv
         47VGq4iaeGLaeIfIxGoq+HMOG9sLopDMnWJndJ3EpqxJ4t85wWa4fAwJ+IqkqhIhLFwt
         XOnnjz+G1W9GTAqTParvahWzMjoVzRH82Yn3TzcQsgY0pC7/aWeGBflqhfTR00wBt+GR
         G/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953771; x=1690558571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTjKmbTUoKZtW5LXWjKkpdkle/49HkSEc09M87FklNo=;
        b=VB978w1p598RAkUiEm5QSNboQkCnFT1gTZDw89gNL0JkoTR5jR6Dblg5I4K3Ip57B6
         57JWNQS6s7C16tlkVI/EtqSZLJ8d0rmFE/HfR0vmD1kK42+ev0B451/Ok2RIxiXAvdop
         xlga6rWZcxDr3vtStVqpatGEfNqzmGPUHAtjiwbQqxvE6u4CU+qzbEpiRhHXDZrh9QKl
         9LDCBKCPXG6ATS6oYb9bFsKyp9IcMCc2zCZHvMIz/hOLiXd7isg1OYZk0b1nJx9IBtYn
         l/tNZ6ervx0Zu94zMPyfd5v067ASCxafzFv5M393eltZB9IbMaURPqZmsYIi3oAkpPSS
         Fd+w==
X-Gm-Message-State: ABy/qLajDnuVyHqrgW4gLB6EPH1gRj2oFAR1JvcGSpZUoE2PHktmqVCr
        IK0wQMo3OCiEGdS5aYTd3Dc/wQ==
X-Google-Smtp-Source: APBJJlHUicZ6/ambRORd9BD9VLQhmImUJLHUmsPmbWq/5qT6U1CKYe1Y0KCUzOSiVYtMelndfNlhSQ==
X-Received: by 2002:ac2:58db:0:b0:4f8:586a:8af6 with SMTP id u27-20020ac258db000000b004f8586a8af6mr1539094lfo.4.1689953770865;
        Fri, 21 Jul 2023 08:36:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:04 +0200
Subject: [PATCH 01/11] arm64: dts: qcom: msm8916: Drop RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-1-cf6cd5c621d5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=1386;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+PfDB+JO1ckaONFZ5XbEDUUOVQudNaE7JPqu+DdyCuA=;
 b=oRqZ6bfcsvDVVyCCaM2/xP8d81Wrkj9U8zvNE+TTofWT7DIaecb3U97xNpFWLS4Ht4TR8YEB5
 qU9L/iOANl0Aq5TMOw2WHPffz22Kdqf5jcoeuQy+kLQk9nwNf1vwePO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c4d673904698..ffdb620f6a70 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -519,9 +519,6 @@ bimc: interconnect@400000 {
 			compatible = "qcom,msm8916-bimc";
 			reg = <0x00400000 0x62000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		tsens: thermal-sensor@4a9000 {
@@ -554,18 +551,12 @@ pcnoc: interconnect@500000 {
 			compatible = "qcom,msm8916-pcnoc";
 			reg = <0x00500000 0x11000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
 		};
 
 		snoc: interconnect@580000 {
 			compatible = "qcom,msm8916-snoc";
 			reg = <0x00580000 0x14000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		stm: stm@802000 {

-- 
2.41.0

