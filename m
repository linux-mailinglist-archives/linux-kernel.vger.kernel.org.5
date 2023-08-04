Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A918576F977
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjHDFPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjHDFNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:13:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F274C31;
        Thu,  3 Aug 2023 22:11:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3745AnGQ062380;
        Fri, 4 Aug 2023 00:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691125849;
        bh=iZSGhXWJkcvSWSPFW2Rh05BrDy/p5Iyo5jUkOGaRns0=;
        h=From:To:CC:Subject:Date;
        b=qBeu2H0eoaLjzgVvcbp3wmvoMfldYY74bfrEfwxZTPtxyy9nvkaY7M0q9UJZs9hwW
         /1J3x40elIINxCaWv+7cEULeoK1F09gGlYJ0SPS+W6V4bJ99ZDRy98eZbOwC0XzGeB
         DCrVwjZZFh/cJy/TZLB/UJ89CH4rbKx5WTyt6oAw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3745AnRB035482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 00:10:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 00:10:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 00:10:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3745Am9R025754;
        Fri, 4 Aug 2023 00:10:49 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V3] dt-bindings: pinctrl: pinctrl-single: add am625 compatible
Date:   Fri, 4 Aug 2023 10:37:37 +0530
Message-ID: <20230804050737.635186-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the am625 compatible property to add support for the new
wakeup enable and status bits positions

Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Base: tag: next-20230731 + below "depends on" patch
Depends on: https://lore.kernel.org/linux-omap/20230731061908.GG5194@atomide.com/T/

Changelog:

* v2 -> v3:
keep order sorted, Suggested-by: Nishanth Menon <nm@ti.com>
link to v2: https://lore.kernel.org/all/20230803150955.611717-1-d-gole@ti.com/

* v1 -> v2 changes:
rename to use am625 instead of am6
link to v1:
https://lore.kernel.org/all/20230803092311.604610-1-d-gole@ti.com/


 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index b6b6bcd7074b..b0a10ab22b74 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - enum:
               - ti,am437-padconf
+              - ti,am625-padconf
               - ti,dra7-padconf
               - ti,omap2420-padconf
               - ti,omap2430-padconf
-- 
2.34.1

