Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54887AF107
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjIZQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:44:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE1BF;
        Tue, 26 Sep 2023 09:44:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAE7C433C8;
        Tue, 26 Sep 2023 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746652;
        bh=ctKEScjla5NGO0X3e5QFF7G0OrRljAFnMXyX4H25Oyw=;
        h=From:To:Cc:Subject:Date:From;
        b=H2gLaC4YPBRroqQ/fVEPrIAR9cwiCU/58OtIk2xUoqfShDUqevF5nC6/eF30ajZbo
         LGv6b9YKLV9RmrpAOWouMtAcVONPDQGUdBPsgHaVoNM5xKZGRMrPLPXTzsdmSlSRku
         YdZc1TFbWBXes3JVO07NtJVTnpYPDjM+99Xlndnf9INyjQhSvs/2caS1x8Q1N7EGG5
         +N+vW4A65/q7dSDbFsge6BFcapqQpCkuTLBIV74MK5iVK5zLcSmERdF75K/dVJldqK
         iQxDpmA1qTVhABuGpTH9hcc9WJtPMrl13+I/6VyzDt9zfo5LzquPcCi++bfe8AM40L
         +kFK6viJRjRiQ==
Received: (nullmailer pid 100735 invoked by uid 1000);
        Tue, 26 Sep 2023 16:44:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: adi,ad7292: Fix additionalProperties on channel nodes
Date:   Tue, 26 Sep 2023 11:43:50 -0500
Message-Id: <20230926164357.100325-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"additionalProperties: true" is only for incomplete schemas such as bus
child nodes in a bus's schema. That doesn't apply to the "channel" nodes
in the adi,ad7292 binding, so fix additionalProperties to be false.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index 7cc4ddc4e9b7..2aa1f4b063eb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -61,7 +61,7 @@ patternProperties:
     required:
       - reg
 
-    additionalProperties: true
+    additionalProperties: false
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-- 
2.40.1

