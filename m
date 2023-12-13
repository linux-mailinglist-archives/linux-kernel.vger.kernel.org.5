Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE5811B16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441879AbjLMRbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjLMRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A910D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:31:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926BAC433C7;
        Wed, 13 Dec 2023 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488711;
        bh=0lSIsKw57fQKAbIpEwj2SrlosSdAJSq5HP2yiybviRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CG0jUACSvZre7kYHHPdmX45hiGSCQ7lutou/ZdXrHPYrIp8zPVi1+uQ8YIDMGHaT4
         liBBO2cHs4raP0yXIHvJQFrahSHcLRUXnJM5jdwhCh3/LSyzarOynXG/UoXPw/Muer
         K+kWZdaBrIN6cYgdqtrZYGUUsfqBpHdKNL51BI97h+TVBuu5nJTByUPtCSQ125PmbD
         EIWA4H9U5bJC7ria+4FhB3bgoS5H0r5rQKQFw3hZfKdewHEe2wgXtpBV13l33ET+rE
         NhgEwbIX2/Wr3t7+wWgXUWD4IsE+5eh7OPbScrPv6YYtdmefypT2KFUzqkPD84PdiS
         wcfWfnwkB2L/w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDT5J-0007f9-03;
        Wed, 13 Dec 2023 18:31:49 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/3] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
Date:   Wed, 13 Dec 2023 18:31:29 +0100
Message-ID: <20231213173131.29436-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213173131.29436-1-johan+linaro@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PDC interrupt controller binding expects two cells in
interrupt specifiers.

Fixes: 9d038b2e62de ("ARM: dts: qcom: Add SDX55 platform and MTP board support")
Cc: stable@vger.kernel.org      # 5.12
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index e30dbf12990a..0864c99a3da1 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -612,7 +612,7 @@ pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
 			qcom,pdc-ranges = <0 179 52>;
-			#interrupt-cells = <3>;
+			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupt-controller;
 		};
-- 
2.41.0

