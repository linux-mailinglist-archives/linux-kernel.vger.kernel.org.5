Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC2801109
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378558AbjLAQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjLAQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553C1A8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E1FC433C8;
        Fri,  1 Dec 2023 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449206;
        bh=5VDnDHEln3DKe1zG9t7qo9Eo+6x9j+qVjLQOECvlRlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mmy9tmurniIFtyjP3ziw7xjSYjUEYDmIScfc4kqHM7UqmbzUZ35zBFY2pdDes577s
         tjRX/Ayd7P3WcUW6Vnug/ydDlLOVj3QZFrD8D268psT1enu/5lv9PKOp4jLV8H+xAu
         DJiDHIbjSHheyDl6iGgUX1UFMDjYWzhyEVRk0fIc9yQP8726oGaOq0L2zozJ3gRiLp
         oXZ4gYVOkl14X0Djv6abQvVP7dmLFOWO21vMsFOR5JfdvjvS4roITxotqkoqlMwgnE
         x0R7MvzDA88sNRo4Gt3CHMh2vH/8JWCXOTWXGhxTWJF5PDJlcFcZzdYCRzQSPDY64T
         gqGQ5x+J+VAIw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r96fj-0003IY-0q;
        Fri, 01 Dec 2023 17:47:23 +0100
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
Subject: [PATCH v2 4/4] dt-bindings: mfd: pm8008: clean up example node names
Date:   Fri,  1 Dec 2023 17:45:46 +0100
Message-ID: <20231201164546.12606-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201164546.12606-1-johan+linaro@kernel.org>
References: <20231201164546.12606-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree node names should be generic; fix up the pm8008 binding
example accordingly.

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

