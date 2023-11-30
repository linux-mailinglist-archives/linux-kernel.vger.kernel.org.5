Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F87FECBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjK3KUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjK3KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:20:06 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69710F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9b5b72983so10050101fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339611; x=1701944411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lfu2ORpkeCL1UpHBva1eJY9Hjq38Pt6Ou/3N+ye6TmI=;
        b=RB4pPBgi1V9pVSg7gkcypUpBis2IyEgau+OoOfcASm5JV8gjBUwl7hMsqdsWbtPKr2
         bTPxtrMY56qG5WTGV9SU3iPaK8PZDZJMmpKkGFLQdVGNS1Pq3dfmVbuUdatkWLiiVPMM
         Ewio/+B0hiL6890XlH/fZcFk4T82IlgdAq5ONw99frSijjKx+qfgFhndE/lmuS5xkwgO
         yDORMMPE3DvVSFljmVbm1yVGoODKgAPLPsV3a2h2aOi0kY0jta2nV+6UpJ1C5w8YqPmL
         uE7hIh1SDUHeTU5kxwvXRplIQuPjH0QuGVkUYCLb6neeFHKdL6WARuXXXa7Epm4iuFTU
         2yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339611; x=1701944411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lfu2ORpkeCL1UpHBva1eJY9Hjq38Pt6Ou/3N+ye6TmI=;
        b=Uzra4QaS+Dtg83H7Cuw4PG+2iLSWSqRUnKzi3DfhY43zr1RELITQcTHr6LJRh7AzDL
         HcMeMCuWlXYBn+F2FFa+17a6o7M+94AJI2ZlB36kCLz5B/Ecf3oPtqpqRKHqt6/Fqm/+
         VJO+piaI2tbeJMrCOS2Ilo0hWa38vyVAuaqAZrhtheSSk8kc5qoCGV6CSxa7fcVQRWh+
         /3ZkywOhDz+bMVrC7W6JK+xuXZSW7RifNBH0sAbXFqGnjMjaKQkpADYCgai1tLtyj3Kg
         BU11FyZqWYivfMQywsmVf+qmcRnc7BZ9aARSscuMjbYkB6OPh7tXaTnIHlUlK8HVz8Mz
         I87Q==
X-Gm-Message-State: AOJu0YyTg9qyGr3kJxdctCC7bKedTyQvrAhjHJWiLDqJvaeJgLQo7tBI
        QAhxdpB6Kb6b/hqi6qFThrzTZA==
X-Google-Smtp-Source: AGHT+IHPatP7YAQ9gGVips4GgKyPMc20O6qjxoThtSC5VYr/m4B0unixS9V4908mh+LCSXUmucSQXQ==
X-Received: by 2002:a2e:a4a8:0:b0:2c9:caf3:e748 with SMTP id g8-20020a2ea4a8000000b002c9caf3e748mr723497ljm.5.1701339610943;
        Thu, 30 Nov 2023 02:20:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b00407460234f9sm1465217wms.21.2023.11.30.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:20:10 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 30 Nov 2023 11:19:58 +0100
Subject: [PATCH v5 3/8] arm64: dts: qcom: pm8550ve: make PMK8550VE SID
 configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-sm8650-upstream-dt-v5-3-b25fb781da52@linaro.org>
References: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
In-Reply-To: <20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GxogOVA0VSEH06pH186Sg87gTWs7OvO1dtqJiV/PY6g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlaGHUNj566fqfpERlGUbsGcDnIcereo1jprKLfaOS
 0Jzp4GuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWhh1AAKCRB33NvayMhJ0Q5VEA
 Cxu2aWJLdHaW4cXFfxXOjQxGV+cOkPT+IUN+kyyLsQVYS1aOkCUZtaBfoYcvau8ZQF/Jl7gQUsywnT
 PQoAFxwuGUfetp4l5MgdqYmSc70HEhtz0ztJkRTHxRIOTOUlccAJTK8EbHnp4qnf4Ql6y41RX7+Tia
 7Jm0v6PwHY0lsmUbi5a8u4B/4/COZY2uSiIx5GUkfbNqsbXOh48GFsjpp5v3doKEnKEeIzdbkkzyaF
 cxbFgjzvVT9V8tq4CcPyb05VPkrb7uaY8WXl9HAHeCrmja5NrfENAP6xcGxA6jSkEyYYjGMW3W/9Wg
 SwMlanxBNjd0XbpJD0L3HSnVjyfQ3a1NcB6rzFRP06noWZOXjeC9TZ+24fkB90lCTc9CPsrfCLWLdv
 4dzAztQg4tP//gRhNNoKxJD+7tPUgW2cMApYdLaoBSKV9eXqJf1OtI+rlro9xjBTjuPSwYfF5TI9MX
 m2RXKDQsie53bYEfanMJBCfx1nNYnLnkAnHMRasp7iaT9QsH90mvjyztDokeZ0Om4CURNFTf7v9+UB
 gRBOT/IHfIldlgA5gol4B7i20FFj+eDIx1xRxhZW7QWC00sliXHzMQKvIJKE5colj+1bfB4wL2t+oY
 F3AKsUuZAiukaTrDsLFzBb5JofVTuo8A6GqzW0X+7ENCBmeDF3e7TNzQupXQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm8550ve can be found with a different SID on SM8650 platforms,
make it configurable.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi  | 6 +++---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
index c47646a467be..4dc1f03ab2c7 100644
--- a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
@@ -33,16 +33,16 @@ trip1 {
 
 
 &spmi_bus {
-	pm8550ve: pmic@5 {
+	pm8550ve: pmic@PMK8550VE_SID {
 		compatible = "qcom,pm8550", "qcom,spmi-pmic";
-		reg = <0x5 SPMI_USID>;
+		reg = <PMK8550VE_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		pm8550ve_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <0x5 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PMK8550VE_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 9a70875028b7..ac045bfc51e5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -10,6 +10,7 @@
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
+#define PMK8550VE_SID 5
 #include "pm8550ve.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmk8550.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39b..6d5c2312960f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -11,6 +11,7 @@
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
+#define PMK8550VE_SID 5
 #include "pm8550ve.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmk8550.dtsi"

-- 
2.34.1

