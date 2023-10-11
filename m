Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E77C593D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346970AbjJKQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjJKQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:34:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA28C4;
        Wed, 11 Oct 2023 09:34:01 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3CE64C88F4;
        Wed, 11 Oct 2023 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697042009; bh=JWUwGDogpu1uH279Xj7i+R0l2O7xCsC50GV+X5eh6IQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=x/YFwaEEBKscI4zX8q93grF3T0i0mvvyM7FjWVhacceHDko5prY2Eyem9lZxgaA4H
         6gOOwPQc0EPTlBZQjTc8kG67NOj1coBMW+lANIwI4m5lRY++EElzQB2UjWn4ELUsyH
         gMpq82+nwyWLOgf1PUU2mDHo7kZ9ShGC5ZcDddPU=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 18:33:13 +0200
Subject: [PATCH 1/3] dt-bindings: watchdog: qcom-wdt: Add MSM8226 and
 MSM8974 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-msm8226-msm8974-watchdog-v1-1-2c472818fbce@z3ntu.xyz>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
In-Reply-To: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wkSxJhg8qrUykyVIb0Ugy6zRVaxaLc1W6UllYSVedPY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJs5WPEgvNvr4S97QioveRiwYQAGeSUC0jq76+
 GDm9Jig2mCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbOVgAKCRBy2EO4nU3X
 VoS1EACXQF2iyKjzSb6rWh6MofKhPAbD9hzHyju9b2bIUJfe7jeu+ehsEms3wZcXyfYYhOLJQj7
 R92SK7lXc/KZWidmBtkyIBQreI2WMU0ibOz9+aYLHH6PSkVXsLtBNvGaMMoEJHucF1hz99Fe7t5
 6nyCaMAOjpiU6ivviVTOcYjb87TtFLJP9yv1zpHt4n3tM3TIxBMZhhaRpJOFu6S2QZ6n2o09lha
 jjW1Xbwdf7my0kdDX/2Rnu6xkFZDZfQGaccOpMdyxywOSCPwhzOs6r2HhWPZKaILnlonCjfGgNp
 zagLYC3452L+HqCObN6kuyq6pAwiq21DBcudxpQOOUq2uUJzbRInXUhcmsB49d3HqfpnRFmjixx
 ZAZdHPgy560FT+UMM5i21UzuqD0xkQUrfmkeWNxJEnTMHtRsEJsqcVvddvPy0U1DDizrKPixddt
 WLsdGmsCshMgVQo7U14pPtpdoBKnke4dM3tdLLXFMZTybOJSy6vYVkTbfZmWipjP+5qJbDPx4JK
 zX651RHAMtYKQi0I2uUKK0DbDdqI9MU+NaD/HL6nXPUmXlpt7jbICTcKfViOsoLTt/nIjOt6xRP
 GopBzN/FqHVSiOx8NQpBLH2Z5UY8Vqi4YTHqpLaYXkO19dYibpoFnFZc1ty+fWHGzWmSfYazEjH
 fcamqVxS5kcb4Uw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Add compatibles for the MSM8226 and MSM8974 platforms to the Qualcomm
watchdog binding.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 5046dfa55f13..c12bc852aedc 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -21,6 +21,8 @@ properties:
               - qcom,apss-wdt-ipq5018
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq9574
+              - qcom,apss-wdt-msm8226
+              - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
               - qcom,apss-wdt-qcm2290
               - qcom,apss-wdt-qcs404

-- 
2.42.0

