Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F5770DD2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHEE5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:57:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17AE11B;
        Fri,  4 Aug 2023 21:57:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3754va3Z093118;
        Fri, 4 Aug 2023 23:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691211456;
        bh=LbPx6unMfm99M2erei+3z5Fvj12KtkSdmpVzoBEKAP4=;
        h=From:To:CC:Subject:Date;
        b=F6HY88Q/MB9BqA7CYkjDDk1/vLCClp1nmhy3rvUMXCiKrSN8sM1AMNkOlxK+qKfl/
         jhOAvvY2AdciDYkHYOx/6AKTCuqsawTd59vmxiWiCcx2rgACAuZi8qx1ougVQGhnc4
         rzPqyVAOtSWFAlfSPXa9SUvF3zp6g08qnNX08g4g=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3754vaWG056991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 23:57:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 23:57:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 23:57:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3754vZ2l095184;
        Fri, 4 Aug 2023 23:57:36 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] pinctrl: single: Add compatible for ti,am625-padconf
Date:   Sat, 5 Aug 2023 10:25:55 +0530
Message-ID: <20230805045554.786092-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Tony Lindgren <tony@atomide.com>

Add compatible for ti,am625-padconf to enable the use of wake-up events.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Base:
*****
tag: next-20230731 + below "depends on" patches

Depends on:
***********
[0] Update pinctrl-single to use yaml
[1] dt-binding: pinctrl-single: add am625 compatible

Links:
******
[0] https://lore.kernel.org/linux-omap/20230731061908.GG5194@atomide.com/T/
[1] https://lore.kernel.org/all/20230804050737.635186-1-d-gole@ti.com/

Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>

Link to this patch:
******************
https://lore.kernel.org/all/20230805045554.786092-1-d-gole@ti.com

 drivers/pinctrl/pinctrl-single.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f056923ecc98..3a2a9910f2ec 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1954,6 +1954,12 @@ static const struct pcs_soc_data pinctrl_single_am437x = {
 	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
 };
 
+static const struct pcs_soc_data pinctrl_single_am625 = {
+	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
+	.irq_enable_mask = (1 << 29),   /* WKUP_EN */
+	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
+};
+
 static const struct pcs_soc_data pinctrl_single = {
 };
 
@@ -1962,6 +1968,7 @@ static const struct pcs_soc_data pinconf_single = {
 };
 
 static const struct of_device_id pcs_of_match[] = {
+	{ .compatible = "ti,am625-padconf", .data = &pinctrl_single_am625 },
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
-- 
2.34.1

