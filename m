Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482D7AF117
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjIZQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjIZQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:45:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3E1AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:45:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8626C433C8;
        Tue, 26 Sep 2023 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746742;
        bh=aLLqkdKFCxYcXITRkqjnjOM4U5KU00Rw+HhFRqy0ov0=;
        h=From:To:Cc:Subject:Date:From;
        b=NdCFrlkgfWfiMlPk83uqy45Vrb9+sQxddQSbpd9jnPWw+FcwGE9rVML7eU3aZb+Jm
         NYsgPUKVl9eRoCYDsSDt/ZHteAqW4BzDvBuvwlMal/DbwPt1tBeOwn//8WozUBOFxz
         mSMFmlggL3k7k2lAJMVq4GDAVRKf9fJqD3Iqz7pvDwdN2skzTB08WNXBNMs81o5Wha
         R9EFGdqY1uxTci6c84UevqJJauz9xYs/djLmESlIZwmIDirZWmn9ZpbZL77bY18SVo
         okdC9gV/5iKpcpjphy4DWvkt6L5JEx7rEv1xFU2xmrIJYQKWvs5EgvIjpT/cf6fWQg
         E4r+/8Ftm/yMQ==
Received: (nullmailer pid 102861 invoked by uid 1000);
        Tue, 26 Sep 2023 16:45:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: u-boot,env: Add missing additionalProperties on child node schemas
Date:   Tue, 26 Sep 2023 11:45:25 -0500
Message-Id: <20230926164529.102427-1-robh@kernel.org>
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
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 36d97fb87865..9c36afc7084b 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -51,6 +51,8 @@ properties:
   ethaddr:
     type: object
     description: Ethernet interfaces base MAC address.
+    additionalProperties: false
+
     properties:
       "#nvmem-cell-cells":
         description: The first argument is a MAC address offset.
-- 
2.40.1

