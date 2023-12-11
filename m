Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF580DC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbjLKU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbjLKU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:59:51 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D1B6;
        Mon, 11 Dec 2023 12:59:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBKxcTD065067;
        Mon, 11 Dec 2023 14:59:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702328378;
        bh=7cL/oAavDNLP/acNT4WZNS8ptOjuVnCcSbew7kl1FAM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MqgW7Us4yiiEFUoxC/Y+7vDmrGfEsfvKN0kq9+H7Xj8inNI3vayvZayYU2wN+11R/
         zI8qaTwKn1OdAVnLgfBHKdLeujKNjjcFUFoz76mLPRctaeohGxNDYBr4eNiw5IOBRr
         4QjOW54yLLFC7VgRwFfjgOMomyXHqB3tDGvCdQWs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBKxctF121745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 14:59:38 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 14:59:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 14:59:38 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBKxRo7003825;
        Mon, 11 Dec 2023 14:59:38 -0600
From:   Brandon Brnich <b-brnich@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Nishanth Menon <nm@ti.com>, Darren Etheridge <detheridge@ti.com>,
        Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: media: Remove K3 Family Prefix from Compatible
Date:   Mon, 11 Dec 2023 14:59:19 -0600
Message-ID: <20231211205920.698939-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211205920.698939-1-b-brnich@ti.com>
References: <20231211205920.698939-1-b-brnich@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 family prefix is not included in other TI compatible strings. Remove
this prefix to keep naming convention consistent.

Fixes: de4b9f7e371a ("dt-bindings: media: wave5: add yaml devicetree bindings")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com/
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 V2 -> V3: Update compatible in example

 Bindings currently reside in linux-next, meaning that the ABI will not be
 broken with the removal of K3 prefix. Important to get this merged in
 prior to being moved to master so that K3 prefix does not need to be
 permanately included.

 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
index 6d5569e77b7a..6a11c1d11fb5 100644
--- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
+++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
@@ -17,7 +17,7 @@ properties:
   compatible:
     items:
       - enum:
-          - ti,k3-j721s2-wave521c
+          - ti,j721s2-wave521c
       - const: cnm,wave521c
 
   reg:
@@ -53,7 +53,7 @@ additionalProperties: false
 examples:
   - |
     vpu: video-codec@12345678 {
-        compatible = "ti,k3-j721s2-wave521c", "cnm,wave521c";
+        compatible = "ti,j721s2-wave521c", "cnm,wave521c";
         reg = <0x12345678 0x1000>;
         clocks = <&clks 42>;
         interrupts = <42>;
-- 
2.34.1

