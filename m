Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40047774873
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHHTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjHHTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:32:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC124AB6B8;
        Tue,  8 Aug 2023 12:04:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378AP5Xg049566;
        Tue, 8 Aug 2023 05:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691490305;
        bh=wsH0cpHRqqTFMyRbmu2p89xDZgzCEPqmNhQL+OnduLo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iNjRil2TLKn19kG5FTr/PDfQOAbEnUBu1ljvS7NqSpw4QQe6iqkoEuTdo9eLxGfBz
         GJZEsIkUNG2HB9/5c0nQ6wqxk60C0DT+ZQK51ldg3gVkHOOE6Ul9TiAkTGFIaESWEo
         P9ayMlHT9PUdSjlx7Mcn0ncvZB1bO1kggWhTtC0s=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378AP4Zb005467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 05:25:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 05:25:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 05:25:04 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378AO6oC022340;
        Tue, 8 Aug 2023 05:25:02 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 2/2] pinctrl: single: Add compatible for ti,am654-padconf
Date:   Tue, 8 Aug 2023 15:52:08 +0530
Message-ID: <20230808102207.130177-3-d-gole@ti.com>
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

From: Tony Lindgren <tony@atomide.com>

Use the "ti,am654-padconf" compatible to enable the use of wake-up enable
and event bits on K3 SOCs that support the daisychain feature

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

The previous version of this patch was posted stand alone here:
https://lore.kernel.org/all/20230805045554.786092-1-d-gole@ti.com/

changelog: the compatible name has been changed in this series.

 drivers/pinctrl/pinctrl-single.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f056923ecc98..92e495d13b9b 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1954,6 +1954,12 @@ static const struct pcs_soc_data pinctrl_single_am437x = {
 	.irq_status_mask = (1 << 30),   /* OMAP_WAKEUP_EVENT */
 };
 
+static const struct pcs_soc_data pinctrl_single_am654 = {
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
+	{ .compatible = "ti,am654-padconf", .data = &pinctrl_single_am654 },
 	{ .compatible = "ti,omap3-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap4-padconf", .data = &pinctrl_single_omap_wkup },
 	{ .compatible = "ti,omap5-padconf", .data = &pinctrl_single_omap_wkup },
-- 
2.34.1

