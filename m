Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0A7AE17F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIYWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:05:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F1116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F298C433C8;
        Mon, 25 Sep 2023 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695679524;
        bh=H4jPOTCta7deecGCFZSg91gHO4eF5tZipTzNxDka1fc=;
        h=From:To:Cc:Subject:Date:From;
        b=YsiWcjhPsQdx8BhkOak0BQnIP6/PyKjreGSE1FoJowCn7x4tkGxL2IJWJyN3ePum1
         zV9eMnG9xI95nOvPD/AoP3K1bSM+v7jO27cVG0ORvNdYcXiFGRu4GQ98JlBe/3woRl
         gov+dtq00vnipriX/C4L9TPpr3hVZvNvxc9u/YuVWz+9WnAsfkUahXTJckCrs+ISmI
         S/1dsZHwd+GjRPHm+YVM9wi3s5a4J/uQSkIo1SVavDbW+GXEfLtpM23hiQ/MSEg7dn
         U2KXurs33xuWywDZ2mi25KX8oMN8Hs6CbCeWocgqmsJxCDMd8FryfwjR2Dm5X/vd+g
         nYyKFr3JYWv1w==
Received: (nullmailer pid 2026838 invoked by uid 1000);
        Mon, 25 Sep 2023 22:05:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm,coresight-cti: Drop type for 'cpu' property
Date:   Mon, 25 Sep 2023 17:05:05 -0500
Message-Id: <20230925220511.2026514-1-robh@kernel.org>
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

'cpu' has been added as a single phandle type to dtschema, so drop the
type here.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index 6216cfb0a188..b9bdfc8969cd 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -92,7 +92,6 @@ properties:
     maxItems: 1
 
   cpu:
-    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Handle to cpu this device is associated with. This must appear in the
       base cti node if compatible string arm,coresight-cti-v8-arch is used,
-- 
2.40.1

