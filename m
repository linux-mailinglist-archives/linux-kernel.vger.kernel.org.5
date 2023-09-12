Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A79C8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjILHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjILHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837910C4;
        Tue, 12 Sep 2023 00:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505011; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qOdQVWmUls7hOz2ZuWGqGaQn8Gpv0FKINBZaZWur3owBqjXsg3HLIk7DNcQbvE3Zl2
    GbKPsKwErfYoFlFvEwuMxnMi/ucQDj4CrRM0SZv34qpQIo4wy0KgbsJa2a14NK1/dceM
    vADyBU70D+J1jUfvJ3QuD1dswjG4rMxrGPeVbEXu0FsZxQ0oSURlH9fCXslYzkhlrd+J
    AUYuCJONbt3OpgAB+OuOJiiAYj1W19ij2+LKCNHie1jkUsLeWj8BG8qnzAGNhxEYdgFh
    Zi3erasPqFzRZdkZcZePeMVfVWmi/wjHc+meLfwXmabL+/JFI4m8+RDclAzk6l2SNd7J
    y4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=L/GhP++3ntz+tiVHjTtfdN0t8NIw2lLOzuPYeZ0wQb8=;
    b=t1kSAWZlkIBmcV7B/9v3ErYueu2G8cYYu1AAT5iQGDN+EcD24vt2FUFsmUG1G1UZ8a
    IXisC+NEZO95yk2o5sxfBVzW2HBTYkg0hbrdqJLlz7socLfqvlK1YYLVmxe2TeWAojsc
    0/SisyMyYe4sRzbWcdD438CVUmNeywzQT+Y0/ZU4gn01loM7K510Sd48clUSqCw9+4Pm
    Ez2/Kpn7/oPNNBxeybwwuYqFWQOvHZjMifAdB0VEHbA5tJ+vcb/9D4+Ih30arF9VchNE
    jrOT/W2YUKBmdTatHoYRfeDpxcLkoTzaIZthh1OgFhdHSuyMXEEd/O/B7jUMXFn7VHo5
    E9HA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=L/GhP++3ntz+tiVHjTtfdN0t8NIw2lLOzuPYeZ0wQb8=;
    b=AWm0QdpzMZvXlXaCc9KXRldje8YIcOfIkNjHCjp7iYJ+9SnXiMRRMcN52zO7N7SgBp
    9pPzA96lPTABNMwFX2Ib6/gD+gyeyMIngooi74YePAibkH2UjfCQqtJ5nkGJ2BMVVsZx
    0Fvk98QJQEimgND7K9MR7AaFNuNxjEIWySJVxOQV8JO7n8VQyRabU5rUGimy6XLtK2Qf
    I6v7FKjNK+hQR9Qh9PfxTSpdC6PtnQxer/Mf/mG9qOEQ2XGBOXNWalEwZUEQiXfu0+r/
    4bK9CpEfTr9IUPlJip0jFfQrxnFDA6qrhJIJdaRxbJ3TYXeZT8lBELVztPlhk0agVX6x
    rAuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505011;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=L/GhP++3ntz+tiVHjTtfdN0t8NIw2lLOzuPYeZ0wQb8=;
    b=MPcsBaY3i6wqLxVrwbCO/lIwQYU1G10xy5HWwzoEYkf1Yiugz64DjYWtpcHsTmert9
    GYfHM7Xb2MhLFR4L0FBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oAcKm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:10 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:49 +0200
Subject: [PATCH 1/6] dt-bindings: regulator: qcom,spmi: Document PM8909
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-1-ba4b3bfaf87d@gerhold.net>
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
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Document the qcom,pm8909-regulators compatible together with the
necessary supply properties to allow interfacing via the hardware
regulator registers directly via SPMI. This is mainly intended for
debugging since the regulators are typically controlled via the RPM
firmware (qcom,rpm-pm8909-regulators compatible).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 .../bindings/regulator/qcom,spmi-regulator.yaml       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index bdf34c2de96b..765c31246cc7 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,pm8005-regulators
       - qcom,pm8226-regulators
       - qcom,pm8841-regulators
+      - qcom,pm8909-regulators
       - qcom,pm8916-regulators
       - qcom,pm8941-regulators
       - qcom,pm8950-regulators
@@ -206,6 +207,24 @@ allOf:
       patternProperties:
         "^vdd_s[1-8]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8909-regulators
+    then:
+      properties:
+        vdd_s1-supply: true
+        vdd_s2-supply: true
+        vdd_l1-supply: true
+        vdd_l2_l5-supply: true
+        vdd_l3_l6_l10-supply: true
+        vdd_l4_l7-supply: true
+        vdd_l8_l11_l15_l18-supply: true
+        vdd_l9_l12_l14_l17-supply: true
+        vdd_l13-supply: true
+
   - if:
       properties:
         compatible:

-- 
2.42.0

