Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95080BFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjLKDRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKDRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:17:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80CE9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 19:17:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE9CBC433C9;
        Mon, 11 Dec 2023 03:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702264626;
        bh=I2/VwSQGvh/KjP/juRn6XVQUWF6SVjlSgZaZUz/kKvc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dG76Q699uGLpWv1mEGv4AJOz+SrN+Yg7VyeJ0Gnr8c1zoVOsjdJzwEXq0WEVy+3Zt
         8ZA3hpvYUsvf8wcSLdJy6HM2L648yz+So8KXaHf0lHM8w+VbJqVjEG2RV2qcAReLSq
         8rkis4qHXut/r7/m+2uwPjm66FZPSzMsZ5rJQFoFHjnQ0k4KBhamOIQ5xHGDT2nr/W
         KP8R8K/CvbM3LKivL+fbqYjkl95F2qHWHsh1noT5R5gEz6gkhRQzMMjfy13jwV3lhN
         clrLgwEptD/Qe1FHzoiykLE+iW9kgokc3s6L30TRE8+KJbLRFRH5dKuKgwYfnFq/rq
         whNPX7681+r9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C5F29C10F13;
        Mon, 11 Dec 2023 03:17:06 +0000 (UTC)
From:   Fenglin Wu via B4 Relay 
        <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date:   Mon, 11 Dec 2023 11:17:00 +0800
Subject: [PATCH 2/4] regulator: qcom,rpmh: add compatible for pm8010 RPMH
 regultor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-pm8010-regulator-v1-2-571e05fb4ecc@quicinc.com>
References: <20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com>
In-Reply-To: <20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702264625; l=1788;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=/J1wecI9Idvjq7+Myo0iVzg5n9YS96HwefGimd5GXh0=;
 b=B2XAMLyw0PnUkBiHmr494YTzxtLfHCg1lERz5M0eHkH+P/+9iy/4BE4G02pCOVJCNkV4fcJOn
 SQs5YuqIjmkD7mRqszoRKiwFnjopSraMvK5xelAZld5KYaoGV2SqQu1
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Add compatible for PM8010 RPMH regulators present on sm8550-qrd and
sm8550-mtp boards.

Suggested-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index acd37f28ef53..27c6d5152413 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -42,6 +42,7 @@ description: |
       For PM7325, smps1 - smps8, ldo1 - ldo19
       For PM8005, smps1 - smps4
       For PM8009, smps1 - smps2, ldo1 - ldo7
+      For PM8010, ldo1 - ldo7
       For PM8150, smps1 - smps10, ldo1 - ldo18
       For PM8150L, smps1 - smps8, ldo1 - ldo11, bob, flash, rgb
       For PM8350, smps1 - smps12, ldo1 - ldo10
@@ -68,6 +69,7 @@ properties:
       - qcom,pm8005-rpmh-regulators
       - qcom,pm8009-rpmh-regulators
       - qcom,pm8009-1-rpmh-regulators
+      - qcom,pm8010-rpmh-regulators
       - qcom,pm8150-rpmh-regulators
       - qcom,pm8150l-rpmh-regulators
       - qcom,pm8350-rpmh-regulators
@@ -238,6 +240,18 @@ allOf:
         "^vdd-l[1-47]-supply$": true
         "^vdd-s[1-2]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8010-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l2-supply: true
+        vdd-l3-l4-supply: true
+      patternProperties:
+        "^vdd-l[5-7]-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.25.1

