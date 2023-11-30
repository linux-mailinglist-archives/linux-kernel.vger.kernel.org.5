Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16727FF7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjK3RQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjK3RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0710DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11242C433C9;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=4MvuIkotlM5v0azTQRz27GQ7u2cpqGPTVAW6vocygAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdG7j/lIAxBP7TZ8CJ1EyZJIdXgVdM05abTwVJ/edPcsRn59jedppdTJPM3i7bv6j
         U9THyxyINKw09aXL8XurqtVdLZuMg3r5D70aNkP5LeG2JQr1uV+zknK4FGf+lcXNyM
         qGIBp9LLGMTZ80l4nt6ml9S3KS6BVD1BZJd1vRhaIRrXYPBENDBBxIvre1Q+Tk2iau
         jeyU4MKBSUa2hz0CfSkWAa3A44zMH5LpvODbgzNMgq050fSwIZCIGnKGFRKuLjpKMW
         DXBYweJq6oVBx7bgQZ4JM5hFiGVZij0+tvH3bjk/0/2/bFike3rfFMcIsj1CCCbK+2
         UezkC/fgPX9Xw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Ck-1t;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/6] dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
Date:   Thu, 30 Nov 2023 18:16:25 +0100
Message-ID: <20231130171628.12257-4-johan+linaro@kernel.org>
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

Clean up the IADC example by adding a newline separator, dropping an
unnecessary label and removing stray white space.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 16889d2d3575..5ed893ef5c18 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -54,12 +54,13 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
-        pmic_iadc: adc@3600 {
+
+        adc@3600 {
             compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
             reg = <0x3600>;
             interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
             qcom,external-resistor-micro-ohms = <10000>;
-            #io-channel-cells  = <1>;
+            #io-channel-cells = <1>;
         };
     };
 ...
-- 
2.41.0

