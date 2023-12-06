Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D73806DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjLFLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378052AbjLFLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422912B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:17:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7946C433CB;
        Wed,  6 Dec 2023 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701861462;
        bh=wMWsV85NWCSegh0Gab+O0xc9mK0JLvIvAXgKFlqRUBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SL/gPgdTsF/7MmxwofVLR1UAmX6VOKajZh25GWG12l+G1HsiDNJNNgd98MRd8v9kH
         jFW1puRE8Multrki2iGnJDBp7SPDsWiSsGZHnvRcVY/4vGCVVhDBBNYOIqBvqtumPk
         j3Fw4azh5uV+04vKi+WfOL53fyClkx+t+ZZfEfjHIv64du1LWd5Dc+SJbfDYfIsxUj
         xsC1RcJGM5eu344Pfvsl7owaBcqoGpDNo208uTDkAkOziVDiVejgyfSp9qSpqF2nAK
         tphXvD4GC0VRAuGt/20YGWoSzEFnxtScrgSdCeFgSnivRzdOe0uSqD4TZA6zeGnrBl
         8RphkmcOKeGZQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rApvA-0001wK-2D;
        Wed, 06 Dec 2023 12:18:28 +0100
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
        Johan Hovold <johan+linaro@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 4/4] dt-bindings: mfd: pm8008: clean up example node names
Date:   Wed,  6 Dec 2023 12:17:54 +0100
Message-ID: <20231206111754.7410-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206111754.7410-1-johan+linaro@kernel.org>
References: <20231206111754.7410-1-johan+linaro@kernel.org>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index 9e4eed34dae8..0c75d8bde568 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -99,10 +99,12 @@ examples:
   - |
     #include <dt-bindings/mfd/qcom-pm8008.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    qupv3_se13_i2c {
+
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
+
+      pmic@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
         #address-cells = <1>;
-- 
2.41.0

