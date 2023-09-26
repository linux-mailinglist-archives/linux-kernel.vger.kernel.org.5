Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A37AF10B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjIZQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CA10E;
        Tue, 26 Sep 2023 09:44:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0549C433C7;
        Tue, 26 Sep 2023 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746692;
        bh=wzH7s8yJ+PPGQfNK0z9FUL496ECuBns4yWKve8giPsw=;
        h=From:To:Cc:Subject:Date:From;
        b=vAXayQmr1uRxFuP7LC5taokFTQwH+M5Au2lRNnRrNiHnHNtYFO0FwUZDENedPI/hy
         dZg1vLUenEXqILI46nHfgyULQOQHeqqCujwQYD8ihL1cAe20sVjKOyRSzLMcLDi2aG
         JiXuejuxR4LESVEr/TcH2sChSVWrLc/amPC3Sf1IRDt/KnJivC2ZDUt7MGltJRWDEg
         JV9yWuHdPwdJQRu9Zjgd6Oa3TT4pMu5AVc8FEJCKevmL6wYbY7KCCTQNwkB32TRAPS
         O0HO+2JD21Ctq+0IKx8ieUF8AbMIu7pAKKciGs+JMDfOkc915K26hQdHnDCguIK/2j
         GmkL9l6sKPUMA==
Received: (nullmailer pid 101563 invoked by uid 1000);
        Tue, 26 Sep 2023 16:44:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power/supply: sbs-manager: Add missing unevaluatedProperties on child node schemas
Date:   Tue, 26 Sep 2023 11:44:42 -0500
Message-Id: <20230926164446.101327-1-robh@kernel.org>
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

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Add unevaluatedProperties as needed, and then add any missing properties
flagged by the addition.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/sbs,sbs-manager.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
index f255f3858d08..2e21846463ba 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
@@ -47,6 +47,12 @@ patternProperties:
   "^i2c@[1-4]$":
     type: object
     $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 1
+        maximum: 4
 
 examples:
   - |
-- 
2.40.1

