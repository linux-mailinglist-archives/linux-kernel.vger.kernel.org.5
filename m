Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1979C8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjILHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjILHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:29 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D510CE;
        Tue, 12 Sep 2023 00:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505011; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rqX4gv/vLK1CAASXFWZYqQ4ZIAtCRTVdw9hTqJRoYwA7OsF5HAwUygBPozwSoyhHoj
    gjqehxSH6c8G+KOkKIELDTE3+2ayGRIqbSEVYk+vcExsFSJoCPUDt5hSC4Btxzux4zoM
    LJn4xOSiIJKf3U5OgJWLqgndSN0vxZu1i7mli8LvUx+uMAktkaGpJoTo63UvomDVDW1E
    A3drZSkl5kTBK4N74sGEp033Dm5TMpm8H77RmffVqYJ9Qjeo60keArJR4sK1QE7icyJB
    G83T1jkYLcCq1zy6DaEs8uTqD5J3C3stEnRxa0W9VoCvjpVlJfp2PRVrawosFfGayhcs
    ud9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Iiu5Q8DuotQnaG8K35L+wCLQXHnhA6SyDFIEGecdGAc=;
    b=QU10HOv7c1DeTwsx0OTVnzRyqGXKbvHrVQtUJeG0y4DjV5OhYSj/wNpUuGDRgMrqbk
    H0LKm7SJuchYY4fzSKKMaM+mtdkbWxZdtBlaW4lUqv3/WwZjHguEokGLHsGF9MeMW5Tq
    GCVjWDEbfXXRB3vYiFTJe8fBZK0doyPgTA4b7EszbAmeFZRBWCsFC60z2Eoexr1D/yWg
    zdWKrVDHKCeO2S2qfFPeMd61QDduGve/5ZGlz67JlgJ6lDEalbbAg/PF15dceFwvnrRx
    TaTu74at5iyrM9y9haKVuekcdVRbJqFIuOU7VXZNOHRCLMtHnGaOHycM2CE2CULaXwu8
    DvIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Iiu5Q8DuotQnaG8K35L+wCLQXHnhA6SyDFIEGecdGAc=;
    b=U/TIv4MFoYHefuHO6JutSbhlRYz02V+kMY2Chmzu0dBGPnqvpGqaTlvAXRst4ZW4Sh
    fgqXXfm2hujwQX3l2u0I8Oe3MnSmjjE4nMuX6TE4EnChQWYJZoF0cH++QnL6JSK0iGTB
    Qja3OrBtjKrg6MEtgrlGVDqCHzk80wgk0kCnma3eSvMbOyJbYy5xIX96QOrXtI1aHkd6
    Y2k8r4DQWS2C3PzYgZ9HRA0z2JDl/SYZIX+dSFPqH627wbwea6YbGbphYULQNzvGzYpz
    YgfH1GbUS4RFEKt9wMklk5Bojg35J7rDISflaT+cZOi7ETa0akokM+S0AoLBRBZ5eHGx
    aRlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Iiu5Q8DuotQnaG8K35L+wCLQXHnhA6SyDFIEGecdGAc=;
    b=oxffIhsXSN7aOnbfLkDZxockkxvkyJvpLwon/WqqrK9OKc5VMTcFiLHuagTDvXjtnk
    65hsEpz01gc6wCLDeBAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oBcKo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:51 +0200
Subject: [PATCH 3/6] dt-bindings: regulator: qcom,spmi: Document PM8019
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-3-ba4b3bfaf87d@gerhold.net>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
In-Reply-To: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the qcom,pm8019-regulators compatible together with the
necessary supply properties to allow interfacing via the hardware
regulator registers directly via SPMI. This is mainly intended for
debugging since the regulators are typically controlled via the RPM
firmware (qcom,rpm-pm8019-regulators compatible).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/regulator/qcom,spmi-regulator.yaml      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 765c31246cc7..fe6898a89ea1 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -17,6 +17,7 @@ properties:
       - qcom,pm660l-regulators
       - qcom,pm8004-regulators
       - qcom,pm8005-regulators
+      - qcom,pm8019-regulators
       - qcom,pm8226-regulators
       - qcom,pm8841-regulators
       - qcom,pm8909-regulators
@@ -177,6 +178,25 @@ allOf:
       patternProperties:
         "^vdd_s[1-4]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8019-regulators
+    then:
+      properties:
+        vdd_l1-supply: true
+        vdd_l2_l3-supply: true
+        vdd_l4_l5_l6-supply: true
+        vdd_l7_l8_l11-supply: true
+        vdd_l9-supply: true
+        vdd_l10-supply: true
+        vdd_l12-supply: true
+        vdd_l13_l14-supply: true
+      patternProperties:
+        "^vdd_s[1-4]-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.42.0

