Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0767C9B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJOUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:07:01 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADDB7;
        Sun, 15 Oct 2023 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697400417; bh=gLXzkJlcOtiiXEeg7Iuty/PC2JvU2OIZdV/PvF/Q3tI=;
        h=From:Date:Subject:To:Cc;
        b=RN0J6xnJHoJM2GqLNuKraxSEjdpxtnbOWwlW8bSFR8bzyC1YvwKNIsWIkLN/vHi4G
         Tk03S+7MiiBou2NRuVn0XSkeOhnRviUUDAzTYQKw0G/wKrutKC/ZGPzEAxDa2nRRfG
         Z7PJy89ExVXA72jdu4ZGzwRfj+pPUYOoU4MaK75M=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:06:56 +0200
Subject: [PATCH] arm64: dts: qcom: sdm632-fairphone-fp3: Enable LPASS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-fp3-lpass-v1-1-4d46a399a035@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAF9GLGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0NT3bQCY92cgsTiYt0koxRTI4MUYzPTxCQloPqCotS0zAqwWdGxtbU
 A2KJWP1sAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=gLXzkJlcOtiiXEeg7Iuty/PC2JvU2OIZdV/PvF/Q3tI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLEZgmq7oITq5wM7PXUyggGCfRXuX9mJ0KLTY/
 SozJ5Fy2cGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxGYAAKCRBy2EO4nU3X
 VpfjEACcqk+1T732HNrdfn+AJ9ugYpgKXBq9bE0K5SK+axr9bvZt6uRvclCYev4ciVyZ4ppoVcw
 rt+I4J63pPERvCHknnsTgye+0w6HwPtvbrWLlS209Qz2HvGx5XYFxyGSJno2YofRgtSTJPtAOrB
 dilapKAbC1RSfJz5MOkQCm0Av+Z2rJWiijswwuM/WHL6wlG8FcUd+fKCigWLewAQfVSTUfnWoL2
 5Usr2cczDIbU9Si5qBbwRnFIbrBbV5VB696J9y6/qDbz/7J7YZ6IAn7jf9af3G3sfuKJZA3ccMM
 wDJjNpKoHVHJm/y1Dgdp1LwEusonryq7ZgY/8uEUQQiOJHWWGW4H7/nXWK8WP97gNY+ybC+6fSf
 XFywaQD79CsQejuQvadQmkemcnckdS5fALY6KkGdjKnojQnX47TxemxnWow8RKcgKNinVbE7Uff
 qkwe94C8BzqHeaikz11F+C6VFhfy78vvwEvf3YmekeJq7bwOo+PBDDESi3MQ1GJiS5vPnutQ4sF
 o8Kfb8V956/TYJNmEPWDCy16YUeyFPIVi+KId206+jbUKRY/m/x1RpyA/Fx/JGEqA9TS+hKqmPh
 QbdpHfA1sLICOPA1BiUW7uJcAevHkAmthkkJol/Fs1FNbnQPc398x1j9ccT1SXyqGzL1qv4vL6R
 7ObCugIq3Q3hCbw==
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

Enable the LPASS/ADSP found on the phone.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 301eca9a4f31..50309b1a6b7a 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -80,6 +80,10 @@ nfc@28 {
 	};
 };
 
+&lpass {
+	status = "okay";
+};
+
 &pm8953_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;

---
base-commit: 2933a1156742d8c47550493a77af8e2d81cf3c84
change-id: 20231015-fp3-lpass-b2d520d365ab

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

