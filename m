Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543DC786E42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbjHXLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbjHXLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:47:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143C19A1;
        Thu, 24 Aug 2023 04:46:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OBkdqa112767;
        Thu, 24 Aug 2023 06:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692877599;
        bh=cy7oov2MXjhUPVaJvwKR9Z1zL7WvWV+6WO7MxCOepTI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OkAejbp+BdPh44JVIhJbGL51+o2L+AR6xeS0lbFDgYRc/9PaMpFYY1xtCLp2f+oWV
         NSqy5nQulMP8DrBv+cM9nOK6d/aW29On+c/PgVFbRtv0LzWX1xhWopwHqvatMk+8pz
         4t6TltLJxcz4kG3ksEd2IUwYSGyFGoD3Oqcx/AM0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OBkdYV029585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 06:46:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 06:46:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 06:46:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OBkdju088464;
        Thu, 24 Aug 2023 06:46:39 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37OBkcFG001804;
        Thu, 24 Aug 2023 06:46:38 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 2/5] dt-bindings: net: Add IEP property in ICSSG
Date:   Thu, 24 Aug 2023 17:16:15 +0530
Message-ID: <20230824114618.877730-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824114618.877730-1-danishanwar@ti.com>
References: <20230824114618.877730-1-danishanwar@ti.com>
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

Add IEP property in ICSSG hardware DT binding document.
ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
of ethernet packets, PTP and PPS.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/net/ti,icssg-prueth.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index 8ec30b3eb760..311c570165f9 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -52,6 +52,14 @@ properties:
     description:
       phandle to MII_RT module's syscon regmap
 
+  ti,iep:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 2
+    items:
+      maxItems: 1
+    description:
+      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG
+
   interrupts:
     maxItems: 2
     description:
@@ -155,6 +163,7 @@ examples:
                     "tx1-0", "tx1-1", "tx1-2", "tx1-3",
                     "rx0", "rx1";
         ti,mii-g-rt = <&icssg2_mii_g_rt>;
+        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
         interrupt-parent = <&icssg2_intc>;
         interrupts = <24 0 2>, <25 1 3>;
         interrupt-names = "tx_ts0", "tx_ts1";
-- 
2.34.1

