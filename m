Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688B7FB639
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjK1Jsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjK1Jsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:48:37 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A290DE;
        Tue, 28 Nov 2023 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=oHIdPeCtrx4tEmu1lgnT9TOC5wwT1XRZku7i/59y90A=; b=Pa6RZ/uGw1NL1tis/Y6Zzpxpbx
        sAOdm8i3M32HbbkJ2TVFtpo0OWA9kqdQNw/0yqDyUZuxfWZRXiwcDFh+GxeVKqauMWCDczbu4dJEg
        LZA5ehmlcMaOKneJEzIIoQaOCFZ9DjlPj/vqYu5XexB49dLdV9kYWPPPGSiILku7+4faut/rUOHxV
        JCpLL1arLmGUEGtvxmQ97MO8pJlIUWcISl4i9vofMkJaZC27CqQ+7I6cpVKN4TcA7sJzk/UvwJ4II
        sMtvPKOGdbZ7Q7eFRgeIoeNrRHRjYDE/iVCqA0NG2uDEKcZxI27kutyzjYFcnpmxpnatCDYK0VnPc
        9nZkdM+g==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r7uht-008Pi6-0Q;
        Tue, 28 Nov 2023 10:48:41 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 28 Nov 2023 10:48:35 +0100
Subject: [PATCH 1/3] dt-bindings: i2c: qcom,i2c-qup: Document power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-i2c-qup-dvfs-v1-1-59a0e3039111@kernkonzept.com>
References: <20231128-i2c-qup-dvfs-v1-0-59a0e3039111@kernkonzept.com>
In-Reply-To: <20231128-i2c-qup-dvfs-v1-0-59a0e3039111@kernkonzept.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to qcom,geni-i2c, for i2c-qup we need to vote for performance
states on the VDDCX power domain to ensure that required clock rates
can be generated correctly.

I2C is typically used with a fixed clock rate, so a single required-opp
is sufficient without a full OPP table (unlike spi-qup for example).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
index f43947514d48..fc3077a7af0d 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
@@ -52,9 +52,15 @@ properties:
       - const: default
       - const: sleep
 
+  power-domains:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
+  required-opps:
+    maxItems: 1
+
 required:
   - compatible
   - clock-names
@@ -68,6 +74,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-msm8998.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
 
     i2c@c175000 {
         compatible = "qcom,i2c-qup-v2.2.1";
@@ -82,6 +89,8 @@ examples:
         pinctrl-names = "default", "sleep";
         pinctrl-0 = <&blsp1_i2c1_default>;
         pinctrl-1 = <&blsp1_i2c1_sleep>;
+        power-domains = <&rpmpd MSM8909_VDDCX>;
+        required-opps = <&rpmpd_opp_svs_krait>;
         clock-frequency = <400000>;
 
         #address-cells = <1>;

-- 
2.39.2

