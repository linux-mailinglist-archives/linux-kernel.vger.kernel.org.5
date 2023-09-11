Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53379A33E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjIKGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjIKGDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:03:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61710CF9;
        Sun, 10 Sep 2023 23:02:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38B62GNs032429;
        Mon, 11 Sep 2023 01:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694412136;
        bh=LPxXyUs8RX5bABb+XFkWKu4GB85y8rHgJpI1cOUNgGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XcmxuqyQZZ8r85/H/8tFdfPWZqAVT0A+zGy3TmPoQy9+RcvOpXhsdCwoaz64vrxP8
         +u6FUODzsUdc41dPUUSOhJXte82rvIeICqDRX6XMukjokFc8YnOENYepr2/T4rSTxp
         2XhEtiyVRIzg7Oruw0VO4Zk9cSU2Js0YQZIbGAso=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38B62GZi107655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 01:02:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 01:02:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 01:02:15 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38B62FgR105252;
        Mon, 11 Sep 2023 01:02:15 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38B62FL7000517;
        Mon, 11 Sep 2023 01:02:15 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for Half duplex support.
Date:   Mon, 11 Sep 2023 11:31:59 +0530
Message-ID: <20230911060200.2164771-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911060200.2164771-1-danishanwar@ti.com>
References: <20230911060200.2164771-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support half-duplex operation at 10M and 100M link speeds, the
PHY collision detection signal (COL) should be routed to ICSSG
GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
property, "ti,half-duplex-capable" is introduced for this purpose. If
board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
be added to eth node of ICSSG, MII port to support half duplex operation at
that port.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 311c570165f9..bba17d4d5874 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -106,6 +106,13 @@ properties:
               phandle to system controller node and register offset
               to ICSSG control register for RGMII transmit delay
 
+          ti,half-duplex-capable:
+            type: boolean
+            description:
+              Enable half duplex operation on ICSSG MII port. This requires
+              PHY output pin (COL) to be routed to ICSSG GPIO pin
+              (PRGx_PRU0/1_GPIO10) as input.
+
         required:
           - reg
     anyOf:
-- 
2.34.1

