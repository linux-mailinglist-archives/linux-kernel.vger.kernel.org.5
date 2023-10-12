Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD27C6B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377857AbjJLK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbjJLK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:56:14 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02158C4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kF6x+Fgbiwq3N84Gqz/O9h8/CPuXjgmj8foJ2+MIIno=; b=BwARkRV2ZlTMVaTOSohsyEhArx
        Z2BJQOLrZNGmrMe0a5uaFtVax3GTLtuUO9ZRP3NLl0DSKToVCIeMJHPmI1K3VkrDKOzKA2jcENl7O
        VtTRtBt6JO/85c1zhZWf8dyQURo/wqdVswULqmBRb2qWRZySg+OL+EVNIOZg1fHiPMOeySyCJJBg8
        l9hEVDx6DoWg2SN9WiIlfNJxJnI5mliKj4g+J9UjlSFA2iQHYTZNx6kLEZCyWI11H90KRjt3xIwNw
        dZU4Sprlb3Qs61Ho72YQZh8MSgmYWq9gmJRtcVew542OMtEpT/ryEU4RMYZX0KotfINRPcLWeg2Sa
        Ojw/6L7w==;
Received: from [192.168.1.4] (port=44485 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqtMN-0005Tn-3D;
        Thu, 12 Oct 2023 12:56:08 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 12 Oct 2023 12:56:07 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Thu, 12 Oct 2023 12:55:56 +0200
Message-ID: <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1697107915.git.ante.knezic@helmholz.de>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 41014f5c01c4..eaa347b04db1 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -72,6 +72,25 @@ properties:
   interrupts:
     maxItems: 1
 
+  microchip,rmii-clk-internal:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if the RMII reference clock is provided internally. Otherwise
+      reference clock should be provided externally.
+
+if:
+  not:
+    properties:
+      compatible:
+        enum:
+          - microchip,ksz8863
+          - microchip,ksz8873
+then:
+  not:
+    required:
+      - microchip,rmii-clk-internal
+
+
 required:
   - compatible
   - reg
-- 
2.11.0

