Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E777C9B2F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjJOUDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjJOUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:03:41 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53419C1;
        Sun, 15 Oct 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697400213; bh=kLp68k9o+Z3NX4GK3pTddX18ul/eLURnuKSPZR5q97Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=iZYKu6yb9DHMMwmDG9Er8Fd+KL1D1rEieDtFmUEezF0KCyfjsR/QPiHZrnOwj8OHC
         8//xnOhd8vzsjYhQHJqothiczc2IWnzEtE7Tys+LELouHF15NdOJKfbbLPfv4FaA7j
         EcLCiZCbXd7cS4G69+klB1b15iaP034/K0F25tso=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:03:09 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sdm632-fairphone-fp3: Enable
 WiFi/Bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-fp3-wcnss-v1-4-1b311335e931@z3ntu.xyz>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
In-Reply-To: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=kLp68k9o+Z3NX4GK3pTddX18ul/eLURnuKSPZR5q97Q=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLEWTrklhyEZhz0lKiMUY6LmIk6xmg/ijZ1rGz
 6UtFtx/ZlmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxFkwAKCRBy2EO4nU3X
 VnKrD/45kk+lDiujez6dk+vdMqJ/6yD0XBxjLSrLYSbsOS6OayfTF9nbznHzoNIQYyeJCiXNt31
 /NRAg/gZXe94EXZdMWAeAk3GrTMGaapE6d+S93PyH81HrOxZR+b0OmGF2GibbItX0OZvkazLbvI
 vrorYRzu2b7Zpcs+8U8BpPLXzqkiPSax7pab6ZBpJFLGxzqgfJxpS+PL2cAYw5OrrL5hE1rs/UH
 Mp0tooxIkhsaBs00Wf0ZgLB49cpb8QgZWJZKHVgPZNJFbpJpTNQi6aah6su00wwGyEiVeX+2cTO
 r0RWE+xn6+QcADozVIRLlO2RjidwWGgaVXcAzaXHUzDn+egxGCqGPffuCHeNvehyeaaJIsF0ih+
 B/sxccssMEjV8jZsKpO0cW1JnOXwTaOHT/dd15W0P1N+0zax1eFriayoq2kBfUMPqhZTneK1NCp
 y1ijiqdiK4Ple4wW6NTlDLcL1dbvjN6Au5CKREwqo6xtc2u9e5lhfWlFyQk6bSLYkoac9jgmUkH
 zQTs0aBASH4d1GLGt31RHhgkClsaF+ws9xtIiNOJKJe3tWPRE7i+8NJ0sHZUHx0DBqPgME/C8TT
 421wfgBiv74mvymR+sv6CwDQv6tZGPsO/QTTmEp7A+mx6rUs1GUf+pe+y4g8kxN51rrwJkluYoV
 OGXNKrGSYXVEPpQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure and enable the WCNSS which provides WiFi and Bluetooth on this
device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 301eca9a4f31..addf56fb7937 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -239,3 +239,18 @@ &usb3 {
 &usb3_dwc3 {
 	dr_mode = "peripheral";
 };
+
+&wcnss {
+	status = "okay";
+
+	vddpx-supply = <&pm8953_l5>;
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3680b";
+
+	vddxo-supply = <&pm8953_l7>;
+	vddrfa-supply = <&pm8953_l19>;
+	vddpa-supply = <&pm8953_l9>;
+	vdddig-supply = <&pm8953_l5>;
+};

-- 
2.42.0

