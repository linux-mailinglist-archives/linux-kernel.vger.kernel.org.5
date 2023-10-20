Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986EF7D118E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377575AbjJTO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377564AbjJTO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:26:36 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB1619E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zWH27i+cvXvmcutNDHehRu32MxOdvX+prdLpdMQ5kwI=; b=c/Q8FSB3GNA3R3BWeNJ86Dx1Jp
        T62AEJ97X9Kr5ESupDFAS+oPYivvmF1IDPxgzFifkzq0nkCKZNIZcack4nO62np11DWVaTUtduKlf
        kOpX+tmbbE0WhTScuyXpF/1LscsEzsdjJrDe2f9if5cfmvUJEnWagaee3nFLkwoP//U1m2uZlKXa9
        +ZykZNeIIeVZwBu5Ho7688trfV9GEJrMIkrBtPWzljlOh3d6v3VQbq254FhDtDC1D2sNC3c2JEx7e
        YuPR48IDlM0Opk4qU+oIbqXWeusLKsn2802mzl1iO6EddL/OIQCiotajDXZuAbAMDSacXQp8zXH46
        tu2x3/LQ==;
Received: from [192.168.1.4] (port=55471 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qtqR5-00076K-2F;
        Fri, 20 Oct 2023 16:25:11 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 16:25:11 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <o.rempel@pengutronix.de>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v4 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Fri, 20 Oct 2023 16:25:03 +0200
Message-ID: <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1697811160.git.ante.knezic@helmholz.de>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 41014f5c01c4..624feb1bb9be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -72,6 +72,23 @@ properties:
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
+  properties:
+    microchip,rmii-clk-internal: false
+
 required:
   - compatible
   - reg
-- 
2.11.0

