Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9286379C8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjILHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjILHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:29 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4CF10DA;
        Tue, 12 Sep 2023 00:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505012; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LonhuwYkkytTATaw5ve6ZtA8lrM3sZdiKlTK2zQLicpgp3XFP8pKaoe23lPk0bAYU0
    e/HmlQW3KUk13FbnSgiu/tvB0uYg09p2YJFQo4ZJnMtp3g/uRMrQu8qrcBtqxW5KShGh
    MSF2+T4J4m0bgVAxMSjn7jb+A5eK/3QvVZrfKnBThBfGg6rtsa+0AMvLVzOEt5Ggj579
    DyfuflDRt8pY7fI2wSR0v92x0dpKTAyy++50fGcgPmxG2cCJHRH/S31p8brvQpEDFlJv
    wWYTBsZIDJpnz471dWmZyygUNJwQuB1Ep20UoQcn/065DdsDBsHMLEFGaEvdnhplv/LX
    1X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8RZIiOJxTChJVlcH8og1reLl52uYP4ns/TSqtnk2nms=;
    b=GehRxwnKNASf+wbai6LQrdw9sS2shqXzfoG5+VkLCemSwknA0D99+nm6oy32IqoW4H
    ZTcDizlvxF/e2RwG60YCg8Q+stOpiZWicigtFamj9J+DZB2yXf5lMGiL4FDJ2m6K2wVG
    44l+51mqbEfUlwd58FfJPcGfbDc/Ytltz6Qf8tYgXGknFSuWh/J3avMrGE7hqNzW8qbg
    tqd6VPpUeVIKkMcmeTQk20TnaI0R4CyNITzBbT/lDvegPkKfPip0TfPhUiNe2Yq03bsT
    IPXNUIraa0Isilvb3EeIne/2Gi3Vzqan0Pv52xAIBvLy0Y6+orF+Cmyx3NqFkSR0iKem
    TVdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8RZIiOJxTChJVlcH8og1reLl52uYP4ns/TSqtnk2nms=;
    b=QuzG7VPEFpTaVjytLNT2ElrNvTOA6qX0awGvDJe3Hgdoy/QmuDjVkFFvayRMwIBFP3
    6SGiHbio8RBN22VbpMc0NbqRekNc4peTNru35Owe7JwS3jOWQhNzsIv/8782O0gqD2iy
    BLAxrFNVXC+20xkfP6wfX/fcPrRbjowLN0T8oeWang9BQhND3fLD0DIeZyPQxSPDA15W
    4/9U719I7Lm9kMMaSwQXhfpplIyGFdfGdU5k3gW/djWxQfNy5NOHL9zpWpSr19XBG/CA
    5ZMPbbMDFvO1/q0Os8UFvc8iFzn5MB0SEt/RPRVfNaxce9L7MSJ7yJXJeMWGsVerAgGd
    qjHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505012;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8RZIiOJxTChJVlcH8og1reLl52uYP4ns/TSqtnk2nms=;
    b=hepHxnrLavN7eJXruGrfYeVbK/w0SxfAWluj/QSKUXiX28qDGLXhZcoa1I4B4in3p7
    u/HVu8EEWM5C7LRxBQBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oCcKs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 12 Sep 2023 09:49:53 +0200
Subject: [PATCH 5/6] dt-bindings: regulator: qcom,spmi: Document PMA8084
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spmi-pm8909-v1-5-ba4b3bfaf87d@gerhold.net>
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

Document the qcom,pma8084-regulators compatible together with the
necessary supply properties to allow interfacing via the hardware
regulator registers directly via SPMI. This is mainly intended for
debugging since the regulators are typically controlled via the RPM
firmware (qcom,rpm-pma8084-regulators compatible).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/regulator/qcom,spmi-regulator.yaml    | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index fe6898a89ea1..7a1b7d2abbd4 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pm8941-regulators
       - qcom,pm8950-regulators
       - qcom,pm8994-regulators
+      - qcom,pma8084-regulators
       - qcom,pmi8994-regulators
       - qcom,pmp8074-regulators
       - qcom,pms405-regulators
@@ -34,7 +35,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
 patternProperties:
-  "^(5vs[1-2]|(l|s)[1-9][0-9]?|lvs[1-3])$":
+  "^(5vs[1-2]|(l|s)[1-9][0-9]?|lvs[1-4])$":
     description: List of regulators and its properties
     type: object
     $ref: regulator.yaml#
@@ -334,6 +335,32 @@ allOf:
       patternProperties:
         "^vdd_s[1-9][0-2]?-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pma8084-regulators
+    then:
+      properties:
+        vdd_l1_l11-supply: true
+        vdd_l2_l3_l4_l27-supply: true
+        vdd_l5_l7-supply: true
+        vdd_l6_l12_l14_l15_l26-supply: true
+        vdd_l8-supply: true
+        vdd_l9_l10_l13_l20_l23_l24-supply: true
+        vdd_l16_l25-supply: true
+        vdd_l17-supply: true
+        vdd_l18-supply: true
+        vdd_l19-supply: true
+        vdd_l21-supply: true
+        vdd_l22-supply: true
+        vdd_lvs1_2-supply: true
+        vdd_lvs3_4-supply: true
+        vdd_5vs1-supply: true
+      patternProperties:
+        "^vdd_s([1-9]|1[0-2])-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.42.0

