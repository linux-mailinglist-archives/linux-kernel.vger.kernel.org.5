Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A28804FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjLEKEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbjLEKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:04:28 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD7AC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KYhSu9U8K6vgDQOGYE/J2/w+PDH6RXMN5vCD35QhVDs=; b=d9iduyf93bxApltNmeYmqbzG2T
        WhzEz5FAuMqtZjUnrngemfc1lXldoS7WOVThtaJxeoLEccVbhh52ptOCERa+4PhBKsHUDabIIRVh8
        /hrZa+pc7TFE1+guoPGQO3zmTkB7WqWdcohIad1FrKi1cf/zxpWsMMZOIGh9rfsukhxVit+HJg4ZI
        8Edr/EblX/n3rHqWvtBHPzGPEqgWU3pJbCDrq/b+TA2jNN6iFlN8AORpxI1FAay456RlRQr9EtX0S
        MMjM+RyK14/e8TtG1V4ZK0i6ZnRxYpd26GteM++X+SXN2RCOaFGHu+jbcOV5HBNUz1VvFF3trKdDo
        OqwNz+1A==;
Received: from [192.168.1.4] (port=29469 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1rASHP-0005TO-1P;
        Tue, 05 Dec 2023 11:03:51 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 5 Dec 2023 11:03:51 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v7 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Tue, 5 Dec 2023 11:03:38 +0100
Message-ID: <721693a7a37d7579d3a29ed5819dbbdf1d4ea3f4.1701770394.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1701770394.git.ante.knezic@helmholz.de>
References: <cover.1701770394.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index b3029c64d0d5..c963dc09e8e1 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -11,7 +11,6 @@ maintainers:
   - Woojung Huh <Woojung.Huh@microchip.com>
 
 allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
@@ -78,6 +77,39 @@ required:
   - compatible
   - reg
 
+if:
+  not:
+    properties:
+      compatible:
+        enum:
+          - microchip,ksz8863
+          - microchip,ksz8873
+then:
+  $ref: dsa.yaml#/$defs/ethernet-ports
+else:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-2]$":
+          $ref: dsa-port.yaml#
+          unevaluatedProperties: false
+          properties:
+            microchip,rmii-clk-internal:
+              $ref: /schemas/types.yaml#/definitions/flag
+              description:
+                When ksz88x3 is acting as clock provier (via REFCLKO) it
+                can select between internal and external RMII reference
+                clock. Internal reference clock means that the clock for
+                the RMII of ksz88x3 is provided by the ksz88x3 internally
+                and the REFCLKI pin is unconnected. For the external
+                reference clock, the clock needs to be fed back to ksz88x3
+                via REFCLKI.
+                If microchip,rmii-clk-internal is set, ksz88x3 will provide
+                rmii reference clock internally, otherwise reference clock
+                should be provided externally.
+          dependencies:
+            microchip,rmii-clk-internal: [ethernet]
+
 unevaluatedProperties: false
 
 examples:
-- 
2.11.0

