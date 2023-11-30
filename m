Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A347FF7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjK3RQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjK3RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8110DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137BAC433CB;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=NP5nEKKAbqzx7TvXe3SZBdwhS28a3lTCzwA7uNU8zG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/g5oOz2xuqaGz9szs6S3Gitcw056NUkC39XnJcmxlvIVI/n+f7IUFgBXTvPB/wqA
         fDqkxRnyKPIyfEPYQFVswnTj5a91wOE5Qdm4OexMXpgco6pwUlKlz5E9zFxdSF1JpU
         aOy6W4GzWi8FOuS7OSRi1Qc1tGmdjE4l27Y8Y0FxRkzicHFZofLDTWHPL6TYdHqL/F
         zNEC2g1PdGL3ldp5UInOaA/mbd8886I7DrYsc37qYNhKH88IQfIdL3NnVwTOjE3cAh
         KKS+IGbHzgNJ5S4HSazLGs1GTgjGU3BEEwEImxW8dnz49wMmB5j/cIcsRiBgupS7LX
         DAfQ9/9jnBHFA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Cg-1L;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/6] dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
Date:   Thu, 30 Nov 2023 18:16:23 +0100
Message-ID: <20231130171628.12257-2-johan+linaro@kernel.org>
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

The IADC register is just the base address in the SPMI PMIC and does not
include any length.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 73def67fbe01..e0e0aa9d5d5b 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -25,7 +25,7 @@ properties:
       - const: qcom,spmi-iadc
 
   reg:
-    description: IADC base address and length in the SPMI PMIC register map
+    description: IADC base address in the SPMI PMIC register map
     maxItems: 1
 
   qcom,external-resistor-micro-ohms:
-- 
2.41.0

