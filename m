Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7207FF7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbjK3RQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjK3RQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA110D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C9C433C8;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=KSdOCdB6xW/QIXdrCIh6E061B7HLNeGVfp8JXB/WYKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYbxN6h/8sjKS050DPNMu/CrbBSEIQsmUhC7bMZrlOAM0P9SJLvRzEKwssT7T70G8
         rfY4nYWSJORT8P6jzxdW+9Svfhs7gS10eb3B/76BbDXSiaLNQuRrGIP13QixL7tVKl
         x0vKoScxZtJmP++Cce4hNxG/wJUMlPdFGOoEm0iZy5LA6K6owfc4ODPfrjd9VKZjhy
         1HnbmwLDIKpz2I15IBIL8eVzFgsHbxp1n+ly/YMrbQeNP+Neu25vK7rdxo44A2Mtay
         gZjBD6CUYyqj2UUnJ4GjDufjkkoVDCOHyy2oP5ZnYO101giLowpPZWfvUmzH4FDLAz
         ZfNIjnEf3ze5w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Ci-1c;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/6] dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
Date:   Thu, 30 Nov 2023 18:16:24 +0100
Message-ID: <20231130171628.12257-3-johan+linaro@kernel.org>
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

The IADC is a child of an SPMI PMIC, which in turn sits on an SPMI bus.

Fixes: a4e6bf69418c ("dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index e0e0aa9d5d5b..16889d2d3575 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -50,7 +50,8 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spmi {
+
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         pmic_iadc: adc@3600 {
-- 
2.41.0

