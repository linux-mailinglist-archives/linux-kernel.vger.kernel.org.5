Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1F75861D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGRUcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGRUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5E19A4;
        Tue, 18 Jul 2023 13:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2D760DDA;
        Tue, 18 Jul 2023 20:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8393FC433C8;
        Tue, 18 Jul 2023 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689712353;
        bh=FLSmACyrVItJxGL2yS/j6SnE6NSUcX7aKrzHK7k9U3E=;
        h=From:To:Cc:Subject:Date:From;
        b=QyklfGbtk3VN1ylhAY7Qw8wPNB49l2zLLLb2XZTsD7k+TbHniEmA69uxamN67xBTd
         AsZK/PkMW/bL0ZH7T1EaR899r0Q0GGqxkArQnuzKvPcyZDFx52gtzE7jnYRkQ6vSXz
         IIy5u4GQY5SqlucvIQizDc3sCEYEldKGa+so2wBr9PpLEOGWaizlR3DMsttrZZorwH
         mnzxFudb6Pr27N5Ol90+AEDir5xFUQ+eoeJVCrNmo+GXg9iM/chPilca1MdApzURS4
         s+HHIE4BO/P/UDn+dfcqGajLjpcqM5SwGu11LJgbJFNqKSMfWrMSVOfEEz/YLmi4hp
         Zm+x1fVwMUC/Q==
Received: (nullmailer pid 1761854 invoked by uid 1000);
        Tue, 18 Jul 2023 20:32:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: dsa: Fix JSON pointer references
Date:   Tue, 18 Jul 2023 14:32:03 -0600
Message-Id: <20230718203202.1761304-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A JSON pointer reference to the entire document must not have a trailing
"/" and should be just a "#". The existing jsonschema package allows
these, but changes in 4.18 make allowed "$ref" URIs stricter and throw
errors on these references.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 8d971813bab6..ec74a660beda 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -36,7 +36,7 @@ additionalProperties: true
 $defs:
   ethernet-ports:
     description: A DSA switch without any extra port properties
-    $ref: '#/'
+    $ref: '#'
 
     patternProperties:
       "^(ethernet-)?ports$":
-- 
2.40.1

