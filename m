Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F817F787F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbjKXQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjKXQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:03:16 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E112B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QU/2BKYHRqdBHTOru/osB5OFNh+RaSLJ8fy3CcYNZXE=; b=fPDPvg5aSSCt9qC0RqC/Yt9H5q
        O5wc6RVAvlkeV9ZzgSW9onAtjGJ41mHx+PxDxzhjC8b7ZdbEO08eTwtK0UfwGSuBJuQsGgxTAL6Wf
        FqvlgYbRv4TG84SNUAlPXJBBgt8yqdahjvosyQi1F6MQiMC+38yBaYpF21yD8fpYgpqURK26t/mA9
        wvGfpGNMksPVLdYNBY5UfPospUz0WAuJU2bDvE4l41YCLdrPClhMqWiDziRvfklGqfNWWCVY+qgkh
        pWv6tfZee5ZEVD1C76Hn/UZbDbkdt9keRF4Ekri1wdgUQ2J/HL3n7Ebyn5dSAlPj54vged5zxTUzt
        lCalnIiQ==;
Received: from [192.168.1.4] (port=8299 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1r6Ycx-0004bZ-0j;
        Fri, 24 Nov 2023 17:01:59 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 24 Nov 2023 17:01:58 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v5 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Fri, 24 Nov 2023 17:01:47 +0100
Message-ID: <0ea1db6b2f2e93c3531645f98888775a4d3165d4.1700841353.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1700841353.git.ante.knezic@helmholz.de>
References: <cover.1700841353.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for selecting reference rmii clock on KSZ88X3 devices
Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index b3029c64d0d5..3cebb9c9b1c8 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -11,7 +11,6 @@ maintainers:
   - Woojung Huh <Woojung.Huh@microchip.com>
 
 allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
@@ -78,6 +77,43 @@ required:
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
+          properties:
+            microchip,rmii-clk-internal:
+              $ref: /schemas/types.yaml#/definitions/flag
+              description:
+	        When ksz88x3 is acting as clock provier (via REFCLKO) it
+		can select between internal and external RMII reference
+		clock. Internal reference clock means that the clock for
+		the RMII of ksz88x3 is provided by the ksz88x3 internally
+		and the REFCLKI pin is unconnected. For the external
+		reference clock, the clock needs to be fed back to ksz88x3
+		via REFCLKI.
+		If microchip,rmii-clk-internal is set, ksz88x3 will provide
+		rmii reference clock internally, otherwise reference clock
+		should be provided externally.
+          if:
+            not:
+              required: [ ethernet ]
+          then:
+            properties:
+              microchip,rmii-clk-internal: false
+          unevaluatedProperties: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.11.0

