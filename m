Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A478DFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbjH3TNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbjH3LcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:32:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009E8132;
        Wed, 30 Aug 2023 04:32:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVm7w066426;
        Wed, 30 Aug 2023 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693395108;
        bh=u3APWIh5k8Vg2dJ/vOsFM+1RXf6HySdBxjqNTzcYcC4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=x+N785e+7f/NEr61i7sVaHSVWEj16Am7U98NmPoBMMsEe5A/LzoyL0cRDu3DFCwcx
         HZhmDXBN2RjncmiqBFOflCGPmT2x7rjuvMd6VVlFFE7lHNXnGj7hyvJSpGnNtz103b
         R2sT4OrpIZSp0MrlGGDLsGkHRybQUuQutuo3s7SE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UBVmwJ038257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:31:48 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:31:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:31:47 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVlTM047318;
        Wed, 30 Aug 2023 06:31:47 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UBVkZZ009969;
        Wed, 30 Aug 2023 06:31:47 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 1/2] dt-bindings: net: Add documentation for Half duplex support.
Date:   Wed, 30 Aug 2023 17:01:33 +0530
Message-ID: <20230830113134.1226970-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830113134.1226970-1-danishanwar@ti.com>
References: <20230830113134.1226970-1-danishanwar@ti.com>
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

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 13371159515a..59da9aeaee7e 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -107,6 +107,13 @@ properties:
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

