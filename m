Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA07BFD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJJNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjJJNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:23:07 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99AA7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=93Dtf4ueCONiAn1Ab9gtN3cKkbSaUtJ5fvdA41bWLUc=; b=fyVYATsKeZCJapMQuZA7f8ixRH
        j1C3GcA68mA7DDDOAdqN9Ktb+pWCkP9Ka5+zgdLAjkyQfc/nO4EKv9AwSKGFRGaaJ6NbwK7ylXFgM
        i4LSvKkhYIrKQ8v/T+WL9H+r/2fbPvvsojQw7/9xF9DZoFxl06nGKnDGVhWkSJQZ4JOFiYOotDKSV
        83RqSOh2dBRQTZL/8s9NI2T2dHESC5wD0AbotDUUuTeDV9b9tFiddF6XagbPvukcqN77vLjNdxTK9
        1/66KXBYKN7znKQ1n9glmMS5UN+u48Am1Q61YdSaxF7IV/o0NOOBB+ryZlwDtg+jnxhCTD8YoJmZa
        UCQoZ2Kg==;
Received: from [192.168.1.4] (port=20319 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqCdY-0001j6-16;
        Tue, 10 Oct 2023 15:19:00 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 10 Oct 2023 15:18:59 +0200
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
Subject: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Tue, 10 Oct 2023 15:18:54 +0200
Message-ID: <df8490e3a39a6daa66c5a0dd266d9f4a388dfe7b.1693482665.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1693482665.git.ante.knezic@helmholz.de>
References: <cover.1693482665.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for selecting reference rmii clock on KSZ88X3 devices

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index e51be1ac0362..3df5d2e72dba 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -49,6 +49,12 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,rmii-clk-internal:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if the RMII reference clock should be provided internally. Applies only
+      to KSZ88X3 devices.
+
 required:
   - compatible
   - reg
-- 
2.11.0

