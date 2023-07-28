Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB47663AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjG1FeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1FeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:34:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950B35AD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:34:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S5Xvtp057389;
        Fri, 28 Jul 2023 00:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690522437;
        bh=UAY2pJ5KCobDzUjFKGI6/zs8XgzCPoAo1W3p2DYg3mI=;
        h=From:To:CC:Subject:Date;
        b=a25czI6ptSIxO9CBoutLH7sjehkGsQ3gTYTOEIEmnL42nMQLqjJeTQM7BjdN81ddS
         LjGAGFpMQBaQZpkNExUCiTK24/wmEOL5YM6X4jGF/cXkQ2gWlDIstXGr4mFGT1kt5P
         6TEoBk/veyDXLxAKuCuxIR8iuya9ACA8kTwsh5Uk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S5XvKp005299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 00:33:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 00:33:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 00:33:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S5XuER017376;
        Fri, 28 Jul 2023 00:33:56 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH v3] soc: ti: k3-ringacc: remove non-fatal probe deferral log
Date:   Fri, 28 Jul 2023 11:03:56 +0530
Message-ID: <20230728053356.31044-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the non-fatal probe deferral log for getting MSI domain.
This makes the kernel log clean and we do not get recurring logs
stating: "Failed to get MSI domain".

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

v2 patch: <https://lore.kernel.org/all/20230710104215.156114-1-j-choudhary@ti.com/>

Changelog v2->v3:
- Remove unnecessary braces for the if condition

Changelog v1->v2:
- Removed the print instead of dropping the loglevel according to the comment
  on similar patch for udma:
  <https://lore.kernel.org/all/Y6wiXlZh1MUL2WrF@matsya/>

 drivers/soc/ti/k3-ringacc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index c6fdf0ad3d33..4c1353616b72 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1373,10 +1373,8 @@ static int k3_ringacc_init(struct platform_device *pdev,
 
 	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
-	if (!dev->msi.domain) {
-		dev_err(dev, "Failed to get MSI domain\n");
+	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
-	}
 
 	ret = k3_ringacc_probe_dt(ringacc);
 	if (ret)
-- 
2.25.1

