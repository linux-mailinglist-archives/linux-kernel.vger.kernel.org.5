Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF747FF7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjK3RRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbjK3RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:16:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FC10D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:16:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49647C4167E;
        Thu, 30 Nov 2023 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364613;
        bh=9nLDbjfs+ETvIRCdX91WOICNCR5DUplnKXVMUpaXXB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnEsVTJdjSBUQaLPsCQL0d2FNDhsnCvl6hHPfUhJyz59OJTEAytUzQvzizXXw5cxU
         6KH68/88eackPZ0fLFaAhHZ30S1oLoysIVlSp/a+yw6whuayJuy+rIk9iM9Zuj7GxW
         5I/n7E43rVg3MoSfupdD9KU2yHQHaB/7+JRAGwemo7Y9dHTYAR9XONXXAOAgPCcYKj
         LJjtXYwvtsDRIGJbji+L9rwozmxwwWAY4BkOMbSYUHHsjbeM//6OFnrvHGoujquE4L
         DjF282SnZk3rKxPS4wurGq40mY0x6mYpS9cbchkbS7vZ7t5rRAUg0/iz9PVYet1u+i
         utUzEpQ5KkkuQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kfG-0003Cr-2b;
        Thu, 30 Nov 2023 18:17:26 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/6] dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples
Date:   Thu, 30 Nov 2023 18:16:28 +0100
Message-ID: <20231130171628.12257-7-johan+linaro@kernel.org>
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

Clean up the VADC examples by dropping a comment, dropping unnecessary
labels and adding newline separators.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index eb02715bf691..40fa0710f1f0 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -239,8 +239,8 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
-        /* VADC node */
-        pmic_vadc: adc@3100 {
+
+        adc@3100 {
             compatible = "qcom,spmi-vadc";
             reg = <0x3100>;
             interrupts = <0x0 0x31 0x0 0x1>;
@@ -284,6 +284,7 @@ examples:
     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
+
         adc@3100 {
             reg = <0x3100>;
             compatible = "qcom,spmi-adc7";
-- 
2.41.0

