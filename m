Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD77FF830
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346231AbjK3RZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjK3RZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:25:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72F10D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:25:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0731CC07615;
        Thu, 30 Nov 2023 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365126;
        bh=hSnEWQ5BFd65oW3upSVnQ42R/owuCp6Usl1kLC5b1FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geoC9/gWAv6GcCrKW2qGzId615qUlwWxVb1ElZClUBeFckIAtvXkxTszffYp2we0P
         LZvDG/pGS9thgKwWHFuRzGBlnTUD//23Y0E/7YEzE1O4jQcmOX8rIiBu/KhTgLnXd5
         q7oktWMzroeb+ay/Q7MgZv8ciwm6g60cu3+C2PJ3wdKliW2LjIDvtxaE+ZDbuifSu3
         S9iKTcKNJH+6PWb4pjfzyQx+srdgZjnJkTi0LNloxr8u2QDILbgszAUkXrUSeHFLhV
         vf+6v0p+Fs9QrjsED2O0nKERxwNX6J4UhVaFof94wAKpoG4UVBa/BuTg91CojLJDn0
         +ebrEI1FaseAg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8knX-0003H2-1m;
        Thu, 30 Nov 2023 18:25:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/4] dt-bindings: mfd: pm8008: fix example node names
Date:   Thu, 30 Nov 2023 18:25:47 +0100
Message-ID: <20231130172547.12555-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130172547.12555-1-johan+linaro@kernel.org>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree node names should be generic; fix up the pm8008 binding
example accordingly.

Fixes: b0572a9b2397 ("dt-bindings: mfd: pm8008: Add bindings")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index 24c6158f73ae..32ea898e3ca9 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -88,10 +88,11 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/gpio/gpio.h>
-    qupv3_se13_i2c {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
+
+      pmic@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
 
-- 
2.41.0

