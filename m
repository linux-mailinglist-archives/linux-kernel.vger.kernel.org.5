Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABFB774959
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHHTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjHHTvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:51:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17949C3;
        Tue,  8 Aug 2023 09:58:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378AOl3h042018;
        Tue, 8 Aug 2023 05:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691490287;
        bh=On/A6IE/yzAzBME7Kc1ZCU6P273S61ERfKqfgq7acKU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UagzfyMHXtD+PK8e8jJe5TnN6UcbyJabyejrF33ShOdKWFOJki8urKhrf5oI+Clz3
         NdKKvDivpSu+BiPzKEmzPL44LjZn0P37WF943ljFYnVcCvxYSCY1tMjw1HU9ZuGZxp
         lROUGTfioc3bnnOEx64HfriPwobqTY9i1ppqfXgs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378AOlrj024779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 05:24:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 05:24:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 05:24:47 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378AO6oB022340;
        Tue, 8 Aug 2023 05:24:45 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: add ti,am654-padconf compatible
Date:   Tue, 8 Aug 2023 15:52:07 +0530
Message-ID: <20230808102207.130177-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808102207.130177-1-d-gole@ti.com>
References: <20230808102207.130177-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "ti,am654-padconf" compatible to support the new wakeup enable and
status bits positions on K3 family SOCs that support the IO daisychain
feature.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Previously, this was posted here:
https://lore.kernel.org/all/20230804050737.635186-1-d-gole@ti.com/

However since then I have tweaked the commit message and also the name
of compatible. Hence didn't pickup the Acked-by: Conor and Tony's R-by:
https://lore.kernel.org/all/20230807144323.GP14799@atomide.com/

 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index b6b6bcd7074b..45a307d3ce16 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - enum:
               - ti,am437-padconf
+              - ti,am654-padconf
               - ti,dra7-padconf
               - ti,omap2420-padconf
               - ti,omap2430-padconf
-- 
2.34.1

