Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931357E2935
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKFP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjKFP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:58:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E013E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:58:37 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507973f3b65so6148271e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699286315; x=1699891115; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pz+lvo9KWB/0i1C6RY/EtcgH2mRAd7C23ZyO/WkKZOQ=;
        b=pzoW6JFrp+FypLfDc2Y3K5D9KywA8oNZ/4VdUvU50eLUTg3DLv6r5OruDsuXLE3ne/
         07ZhZ4KUiD9x8PUS/RC/jeJictDMBmecCsJyK+qtmlulAQvTeuS5LpIeHf2fOkfaOppE
         LfrANhgDK67uOmpJkzE29X2fP/zvibRJ4y1xvObzGWIab/ulTE6grs3Z6jgKk2DctvaY
         aY+yofsPEa3C/jc5xl9LORkJOaR61Y3dgzBwe7jooMlWnvnsSdiKmCBYLPuF9HsLBjJu
         AjxTx2vBRmmRXK9k0tRZjP2gfma2NXTmx1jTa2jvJl2OVF7ebWvsSFt1I4wBmt3IjBpL
         1nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286315; x=1699891115;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pz+lvo9KWB/0i1C6RY/EtcgH2mRAd7C23ZyO/WkKZOQ=;
        b=QKH8XPUnGJmKLroBoOrRpB1opZm/w9nHBoUEuKtkhh/LyKpKmZCOXGrGG2Ttmk37fU
         KjHt6JRcGu2+HFm2LWe+rZrBjV0y3FS5vQugm/GiAhM5UhHTjhyUN81tz73fOIT2InM0
         +Gtd1tXZHnIKGnXzP+mG/AsfB+x27xD61NEApLscnZ8I4rreACGD7GZa56varexFfyuU
         iUk/kdH3ziCw4Z8HoYdqUmzEtW1HfF5dECpI6NGxFSmmtJiqq3h3fUvZ1iEanMPJjlLz
         OTIN3Kb1lQI7mmYMuI+GVGeUUOESPQiDQKWswG7G6AVWwMRg7VRiPPvQd5mxFD1jyDz0
         U68A==
X-Gm-Message-State: AOJu0YxPjBNs72iGKVqibqX/0XalFaQ5CgMtUnmL0ERmnKaUQQSBjL/e
        nZz9xFqZXBzJgkJMsFxYxDmmMQ==
X-Google-Smtp-Source: AGHT+IE7C1jByKEvpl6j51TMqPSkZhjWqwB6jxg4LPUOR/FkXArv3oKYNjCeTWC9t2cAb0W3GECoBw==
X-Received: by 2002:ac2:48b8:0:b0:507:aa44:28f8 with SMTP id u24-20020ac248b8000000b00507aa4428f8mr21123982lfg.6.1699286315483;
        Mon, 06 Nov 2023 07:58:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfe60c000000b0032d886039easm9688287wrm.14.2023.11.06.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:58:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 16:58:33 +0100
Subject: [PATCH] arm64: dts: qcom: sm8450: fix soundwire controllers node
 name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8450-upstream-soundwire-bindings-fix-v1-1-41d4844a5a7d@linaro.org>
X-B4-Tracking: v=1; b=H4sIACgNSWUC/x2NMQ6DMAwAv4I811JCKar6lapDgh3qASeKgVZC/
 L1Rx7vh7gDjKmzw6A6ovItJ1gb+0sH0DjozCjWG3vVX792Iay4yoS334eZwK7ZWDgta3pQ+Uhm
 jKInOhkm+mIgGRzHENDK0ZKnc9H/3fJ3nDzm+TQN+AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6+9hJc9qj0vwlS9G0ytuTFWYQuw2Z3HbqLNwaaRYS1o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSQ0qbwciZpCbfNkwPeyAVV3IWHBGEcLt1l/Kt9Ne
 DVlGQL+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUkNKgAKCRB33NvayMhJ0ZXmD/
 47Q7FW4nSwFahwsv7/nEUnLvhdbDAwOwL8p5VwtAvZEF+DeqfQ7CUPKn2AU/StZOYDx9NGWucAq9EX
 DfXCG41DisIXvarMzRa0DhUWma0qsDAA57HdSxCrp0moVOGfkKmierNQoZPRo1hDxYeUETyRh1zLAb
 Lvp/nkX2NC0kK9doVZ6fqFjvb5AHaTQuCWZgm/HKFWbo630plgakmYtax5yDnlf0UDa/rVCHrkR3Yy
 k+nXWEOO5sVVmpYBJPJsm8xYJ4bkw/oPsM/acXb2O0cbbU3SFzCiLGaHmpmCfZlzaAYV2rz+G2y3Zu
 c1p7dq9T33xkbRNSuaqEiBp4i4LOnh3PGCb+rfRJ10+fTuhCnGRQAIC6cuf+RnFU7Y+kMh7ZkbZ8vP
 M6g6yv/Qsu6/aFm1TnidBGdywvDWhbUTB3hvFm5PPasXIoH2bT2srhXhzkGgfLt//vl4hN5y1F9t66
 qmaI6K8yDhM/nJ1j0MTGfbr4O0if3D1yWDa/ph8I0R3cx8v/LY+oVRpZ6NEFJ1IyeHuc0Bz9QlFcbg
 xy548sOb9u3chlX9LGBvlJqsZhhwuyiI/DiIN+QEF2wMqUpV34ViyCgjhs+QPon6ExAAZO9yglWq/8
 iubk59dOpDORc/WwZ74ycu+z/Yo9ID/laJgftCD3JI6Kp2KltUzVSRVu1Vog==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: soundwire-controller@31f0000: $nodename:0: 'soundwire-controller@31f0000' does not match '^soundwire(@.*)?$'
        from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9b0ff240e678..a305f8c03f9e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2165,7 +2165,7 @@ wsa2macro: codec@31e0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr4: soundwire-controller@31f0000 {
+		swr4: soundwire@31f0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x031f0000 0 0x2000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2213,7 +2213,7 @@ rxmacro: codec@3200000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@3210000 {
+		swr1: soundwire@3210000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03210000 0 0x2000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2280,7 +2280,7 @@ wsamacro: codec@3240000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@3250000 {
+		swr0: soundwire@3250000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x03250000 0 0x2000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2307,7 +2307,7 @@ swr0: soundwire-controller@3250000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@33b0000 {
+		swr2: soundwire@33b0000 {
 			compatible = "qcom,soundwire-v1.7.0";
 			reg = <0 0x033b0000 0 0x2000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,

---
base-commit: d9ea330bc3c68e8d08e116f3827ae94568fef367
change-id: 20231106-topic-sm8450-upstream-soundwire-bindings-fix-fdd40dbabf6e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

