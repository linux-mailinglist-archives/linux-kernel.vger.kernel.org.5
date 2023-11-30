Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431FD7FF86E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbjK3Rh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjK3RhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:37:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0B10DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:37:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E20C433CA;
        Thu, 30 Nov 2023 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365851;
        bh=5MZWbyU3vKXf6N5p9b/TD52/d407uLP9/uelkdwoyuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VazD2NWxYudT7gv9XbCQ9/qQeRdf3Dj6cRCYDAiZ+IHRo9T/KNSiXD2yV3g7P6JpR
         eBtg8oEl3JpGLhjDyShjBilkxnv495557n6LsJDf+vY7X01Vd2OcpsdtFc/8Irb62e
         7HuSK/3imYvMoaaMxj/0/52T0YWfpKz2ZkMJ0KcKwmZ3ewa0WLwIcwQbovF28/VrmT
         XSHScbxgpFroQ+ozlEWzOFcsYAh/l5wWvPBmsvY/SkQSjzLzyOCplGBDAGCgCm7RO4
         g5jS+/rV+RfzjWCqk/fZ9ofxnLgTOO341a+ZRDTgxbmUMkMPm0m3/ZblGWeVOBOalW
         z7Mj4FSpobacg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kzE-0003OA-38;
        Thu, 30 Nov 2023 18:38:05 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example
Date:   Thu, 30 Nov 2023 18:37:57 +0100
Message-ID: <20231130173757.13011-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130173757.13011-1-johan+linaro@kernel.org>
References: <20231130173757.13011-1-johan+linaro@kernel.org>
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

Clean up the binding example by dropping the unnecessary parent bus
node, using a define for the second register value of the PMIC child and
increasing indentation to four spaces.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../spmi/hisilicon,hisi-spmi-controller.yaml        | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
index eee7c8d4cf4a..3ccf35de3719 100644
--- a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
+++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
@@ -54,20 +54,17 @@ unevaluatedProperties: false
 
 examples:
   - |
-    bus {
-      #address-cells = <2>;
-      #size-cells = <2>;
+    #include <dt-bindings/spmi/spmi.h>
 
-      spmi: spmi@fff24000 {
+    spmi@fff24000 {
         compatible = "hisilicon,kirin970-spmi-controller";
+        reg = <0xfff24000 0x1000>;
         #address-cells = <2>;
         #size-cells = <0>;
-        reg = <0x0 0xfff24000 0x0 0x1000>;
         hisilicon,spmi-channel = <2>;
 
         pmic@0 {
-          reg = <0 0>;
-          /* pmic properties */
+            reg = <0 SPMI_USID>;
+            /* pmic properties */
         };
-      };
     };
-- 
2.41.0

