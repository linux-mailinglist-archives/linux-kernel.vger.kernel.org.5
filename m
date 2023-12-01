Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD586800BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378988AbjLANUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378972AbjLANUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:20:54 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB110F8;
        Fri,  1 Dec 2023 05:20:58 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1DKdZP025410;
        Fri, 1 Dec 2023 07:20:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701436839;
        bh=/vJBQ4nzoUomUKRd845/P3Sdh3dCuG9qMZr5n9MVhw0=;
        h=From:To:CC:Subject:Date;
        b=vCD9f18GXx3+lcsPN/bcSLfr9TeDGyRcXMD6Hro1Yvaw0GrBqpMdPbA6U+SvVBMyL
         Oq4tZ+E43xHGcPgC3F+Y8k0Lvf1WpWINv2yV/s+MiOkgLNbXCP5hIknLO3TADnowaw
         eNQjzdNffB+zcEy+slTpJmIwZ25lGWLOUXRHipT4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1DKdC3063270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 07:20:39 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 07:20:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 07:20:38 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1DKYdM065841;
        Fri, 1 Dec 2023 07:20:34 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <s-vadapalli@ti.com>, <rogerq@kernel.org>, <nm@ti.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH net-next v3] net: ethernet: ti: davinci_mdio: Update K3 SoCs list for errata i2329
Date:   Fri, 1 Dec 2023 18:50:33 +0530
Message-ID: <20231201132033.29576-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errata i2329 affects all the currently available silicon revisions of
AM62x, AM64x, AM65x, J7200, J721E and J721S2. So remove the revision
string from the SoC list.

The silicon revisions affected by the errata i2329 can be found under
the MDIO module in the "Advisories by Modules" section of each
SoC errata document listed below

AM62x: https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
AM64X: https://www.ti.com/lit/er/sprz457g/sprz457g.pdf
AM65X: https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
J7200: https://www.ti.com/lit/er/sprz491d/sprz491d.pdf
J721E: https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
J721S2: https://www.ti.com/lit/er/sprz530b/sprz530b.pdf

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v2:
* Removed revision string for all the affected SoCs

Changes since v1:
* For J721E, retained the incorrect SR ID and added the correct one
* Add AM65x SR2.1 to the workaround list

v2: https://lore.kernel.org/all/20231020111738.14671-1-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/

 drivers/net/ethernet/ti/davinci_mdio.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 628c87dc1d28..8e07d4a1b6ba 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -511,16 +511,12 @@ static const struct k3_mdio_soc_data am65_mdio_soc_data = {
 };
 
 static const struct soc_device_attribute k3_mdio_socinfo[] = {
-	{ .family = "AM62X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "AM64X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
-	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
-	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
-	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
-	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
+	{ .family = "AM62X", .data = &am65_mdio_soc_data },
+	{ .family = "AM64X", .data = &am65_mdio_soc_data },
+	{ .family = "AM65X", .data = &am65_mdio_soc_data },
+	{ .family = "J7200", .data = &am65_mdio_soc_data },
+	{ .family = "J721E", .data = &am65_mdio_soc_data },
+	{ .family = "J721S2", .data = &am65_mdio_soc_data },
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

