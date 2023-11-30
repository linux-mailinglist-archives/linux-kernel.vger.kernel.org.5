Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACFD7FF7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbjK3RRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbjK3RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AB10D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18632C433CC;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=AowRuTyqJMXQ7HEnVFHNnSTtCHBVspL3ySQdRhlv0+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVd8TUgECZ3Ltm18UYL+yMIBPmjh9fIaAg8O44hlvh37FNdLjzT+PKv9xAmIq1bFT
         9LYOD+GDKOC2FHtS8nX6EABu00l8tsZ/eax4/Eb+CNwoh9StRoh9Z8wro5B33Cl9bC
         gh6HzUHQNgG34J82HoutJ+nNjwtumtY4bKfjcIyFS+L+UOsJCzOIMjCLzD2GyHIBq4
         XqpOazbJX6O/EX9POji3EYZpmqZY4DN44YeBjFi+slZOnf2RZvJwvdcu9H5ik+nXt1
         rGZ1fXx4EKm20KLNORGZuoV5pzkDp9FVUevuIdGXaAqcYSvul10RKrt8Bwi5W3m8GT
         UqQWZ1+2xCoSg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Cm-28;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/6] dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
Date:   Thu, 30 Nov 2023 18:16:26 +0100
Message-ID: <20231130171628.12257-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130171628.12257-1-johan+linaro@kernel.org>
References: <20231130171628.12257-1-johan+linaro@kernel.org>
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

Clean up the RRADC example by dropping an unnecessary label and removing
stray white space.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
index b3a626389870..f39bc92c2b99 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -43,9 +43,9 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        pmic_rradc: adc@4500 {
+        adc@4500 {
             compatible = "qcom,pmi8998-rradc";
             reg = <0x4500>;
-            #io-channel-cells  = <1>;
+            #io-channel-cells = <1>;
         };
     };
-- 
2.41.0

