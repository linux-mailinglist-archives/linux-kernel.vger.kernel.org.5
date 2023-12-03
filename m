Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7C802543
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjLCPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjLCPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:49:20 -0500
X-Greylist: delayed 516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 07:49:26 PST
Received: from mail-m25476.xmail.ntesmail.com (mail-m25476.xmail.ntesmail.com [103.129.254.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A99F2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:49:25 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5828380009E;
        Sun,  3 Dec 2023 23:40:33 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date:   Sun,  3 Dec 2023 23:40:30 +0800
Message-Id: <20231203154030.532880-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkhNVk9KQh9MGEhKQklKHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c3056a3e8b03akuuu5828380009e
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6KCo6Ezw0GgkPLT4JNxxC
        UVYwFEJVSlVKTEtKTUpDS0hPSk1MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUlKT043Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock provided by XO is 24MHz, not 20MHz.

Fixes: 5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v2:
* No changes, resend due to error link to other threads.

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 2399d16f147e..d114c8096347 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -621,7 +621,7 @@ usb3: usb@8af8800 {
 					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
 			assigned-clock-rates = <133330000>,
 					       <133330000>,
-					       <20000000>;
+					       <24000000>;
 
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
-- 
2.25.1

