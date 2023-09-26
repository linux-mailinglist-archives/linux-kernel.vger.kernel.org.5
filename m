Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705B7AF119
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjIZQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjIZQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC511F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:46:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0994DC433C7;
        Tue, 26 Sep 2023 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746760;
        bh=0M5UOaMPiWsCHJJxpEzVJNXDt/gjIIbRZQm2M8yq3Pc=;
        h=From:To:Cc:Subject:Date:From;
        b=lzNc0KZG6oPTgue2S7gWMo0xFppK8G9rNF4csG+AFWEid6oCTctiTFW4vHiLQPxEo
         x6W/TwCV2gOELnXth4ZqrIqUyPmDQa5epypDhvr3mAPWvSXJ9CwbnlGNQNWWXNWjAx
         7PhcBXgKnDxPmDoessj92cPG/XAbzdfyPeLSqeV3b9iCFcQQjQMB8NIbmeEPVBOjAE
         t7DK8NWaJxxmFCy4dMtq+9gZBj2boTME2Qn0fx2FNN4GgzEoId3KD1GtsjWJ82MXUN
         kBQ0c2nJEyAPIWS8NyXRomW7Dmya80/lug7SrOIhXboNcI7w2BGngcT60natzuFt0R
         sobKSJj4l+Fww==
Received: (nullmailer pid 103271 invoked by uid 1000);
        Tue, 26 Sep 2023 16:45:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm,psci: Add missing unevaluatedProperties on child node schemas
Date:   Tue, 26 Sep 2023 11:45:44 -0500
Message-Id: <20230926164553.102914-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 0c5381e081bd..cbb012e217ab 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -101,6 +101,7 @@ properties:
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
+    unevaluatedProperties: false
 
     type: object
     description: |
-- 
2.40.1

