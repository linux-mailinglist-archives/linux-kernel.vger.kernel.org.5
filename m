Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919D7D68CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjJYKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjJYKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298C1719;
        Wed, 25 Oct 2023 03:34:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75C4AC433AD;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698230089; bh=2UlV2SAeLThisZx2CDUzVQIsXFCsdphm0WX5MqF/paA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=0Z1BfXWgfx5rvEQovfZHR5PrOerqx9mtKj0gvUKkZkvLL/uGDjnqG7M8qQEBqsGWE
         FBRvTxMCS6UaSA6UX29G/K9+PczmVEOaeELWTjn0aGlf2dtH/1OKCeP6tTf+4GlS95
         +t0vUgeDr1AUmkRnqwma+kPTgNod/r0EHNBtZFRs=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 599C7C25B6F;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Wed, 25 Oct 2023 10:34:14 +0000
Subject: [PATCH 4/4] dt-bindings: hwmon: ti,ina238: add ti,ina237
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-ina237-v1-4-a0196119720c@linux.dev>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
In-Reply-To: <20231025-ina237-v1-0-a0196119720c@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698230088; l=666;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=2UlV2SAeLThisZx2CDUzVQIsXFCsdphm0WX5MqF/paA=; =?utf-8?q?b=3DqVMEmSxVR/Bx?=
 =?utf-8?q?f6+PrpumfMpyFJL40+yFqvVmuDr8yuDujWEFxZ2CGxoNMGcrHJR8tHp9Rf4n02pU?=
 YDhZzYxyBzu4oeagPUqVG4mczsszD7wqGMgouzCpDI++hLYnLHSe
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ti,ina237 binding to ti,ina238 as they share the same driver.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 Documentation/devicetree/bindings/hwmon/ti,ina238.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
index aba89e5f34b3..17408076696c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
@@ -22,6 +22,7 @@ description: |
 properties:
   compatible:
     enum:
+      - ti,ina237
       - ti,ina238
 
   reg:

-- 
2.40.1

