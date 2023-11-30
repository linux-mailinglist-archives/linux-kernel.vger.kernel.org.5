Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640767FF7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjK3RQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjK3RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79A10DB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC9C433C7;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=/8tQsSzXakQvV7ZmsK9dAEqEDr5RhMRB8tCyWBIx1O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTyb8IeZDOkZEoNwPOZxLdZNvFFbkNUfQ6TMLDPgwLrPbix9LOgXwehpmvqnIzcyB
         uK1EG6SEDWs16muAw0JIwQMSNVwvB+FaU7NTHa5HYp/y8Ua73S5BZQah4ro59NTyeP
         iRQdqqURGvMTh7oLOZLT9W7xP7ByuHYcT2eBjdUv0T9mNHokb2CMEOcvkOL+ElYBk8
         XbpBAo3beCxxdf1xD9AAqKRm9R/URATP30cX5975CtGp40ZOtT3n3SFxXHyoV8NKyf
         HGSkDCdVUC5+d3AmYyVu8msaEWtJisN+fTRiqZ0i0ffu+c4PaLvxzvhqvIW7Bdec4c
         5qyU8QBvmPehg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Co-2N;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/6] dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
Date:   Thu, 30 Nov 2023 18:16:27 +0100
Message-ID: <20231130171628.12257-6-johan+linaro@kernel.org>
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

The VADC is a child of an SPMI PMIC, which in turn sits on an SPMI bus.

Fixes: 74e903461b17 ("dt-bindings: iio: adc: qcom,spmi-vadc: extend example")
Fixes: 5a471662b5d9 ("iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index ad7d6fc49de5..eb02715bf691 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -236,7 +236,7 @@ additionalProperties: false
 
 examples:
   - |
-    spmi {
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         /* VADC node */
@@ -281,7 +281,7 @@ examples:
     #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    spmi {
+    pmic {
         #address-cells = <1>;
         #size-cells = <0>;
         adc@3100 {
-- 
2.41.0

