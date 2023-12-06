Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850880782A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378673AbjLFSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378511AbjLFSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:53:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2190B84;
        Wed,  6 Dec 2023 10:53:28 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrDRa057745;
        Wed, 6 Dec 2023 12:53:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701888793;
        bh=j6pVTx71jC4M9dRBdsOBU+0xWIU2eiGYumxglCXZgKM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xxBO5h2iwAGPb908xVYV3Z8uXSODJVYbedZxtCOpJf2MyEOsHHKAnly3dUr12Tq0L
         jpE0/J7EMs1Ac7rlN8dyFYGWoTHecK47aE5eobERShZfGVcmZ1OlxzVBTcTQ3FxH40
         pkrAdVY7YjcMqVpwB/GbqK8lBvhjcZXqk5BwHLIE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6IrDIf083696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 12:53:13 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 12:53:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 12:53:12 -0600
Received: from udba0500997.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrBNE020337;
        Wed, 6 Dec 2023 12:53:12 -0600
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
Subject: [PATCH v2 1/2] dt-bindings: media: Remove K3 Family Prefix from Compatible
Date:   Wed, 6 Dec 2023 12:52:53 -0600
Message-ID: <20231206185254.1748473-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206185254.1748473-1-b-brnich@ti.com>
References: <20231206185254.1748473-1-b-brnich@ti.com>
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

 Bindings currently reside in linux-next, meaning that the ABI will not be
 broken with the removal of K3 prefix. Important to get this merged in
 prior to being moved to master so that K3 prefix does not need to be
 permanately included.

 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
index 6d5569e77b7a..471840e858c9 100644
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
-- 
2.34.1

