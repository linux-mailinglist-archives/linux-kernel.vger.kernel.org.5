Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587376902D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjGaIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGaIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:30:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550B127;
        Mon, 31 Jul 2023 01:29:58 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8ToIR048208;
        Mon, 31 Jul 2023 03:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792190;
        bh=9LgR645lZLrFFA7lQFjm1WM/f1mokP1YHKB+NlsbgeE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oXfCcASeE03i7GLGf5xlfoW7fmOQ31/L3YpSkH3RoMCU0wzn/HVSOvlbGatuAtaQf
         2yWZY77mI+t2OEkZuD8unCPBJjmG4bEhRGFvGHjJb3zLoWO3QsKs+VVmNOX8UFviia
         ISTLU5z9R+VpAb3oXsb1+Wmu0IRjKRr/xvTqV2uw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8To7q012001
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:50 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TnQO084133;
        Mon, 31 Jul 2023 03:29:50 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 12/16] media: cadence: csi2rx: Populate subdev devnode
Date:   Mon, 31 Jul 2023 13:59:30 +0530
Message-ID: <20230731-upstream_csi-v8-12-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=eSA4U6A4/SSKyVUDIkygMc1P9OddrvAOS/K4cgLZDBU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xte3Tt15SGxTpMzq6kykX5xIR2+qSdZw1m7
 DBO3wYwChuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsbQAKCRBD3pH5JJpx
 RWMBD/9CtydnmtsMPcme0fi/lo+JDSjH7FC+5qGNTZw12e+atbK6KlooOQ1Kyc45R2F9mSBzTJN
 RvbagxsYUqAxaDjZCoSc0RGWEAY4gv86oUjxNesFUk+TWTCQw+TAGUpxqlNfd/GFXG2FmWbibJl
 TKo8Y3qDYJkEMqpV0y/tmKZVGo6qdveUJjQciI4FcDPQod5KYjqxYtZUKrl55ezr4EituTdhUwB
 yrwLHESLnYpsADlg0eMLA4+TGnUqCyYm1ltf59aioYa2dUJJvaCG9hEpAcOxpWex7iNEzsZQWO1
 aw0vAlA/vYwoy51yfn9AETCawS3UaP/rW57tsDTzUynTucZtwHqQlqSVUGPVe+a7veyAzoAdDd0
 jEX7og9zCNFafndA/wB+rYsZ5oH80EQhu9lnaCw984yXA80b7rxC7NjEWw7VIh7mINtP0+ykorX
 Y/OVl4pzVQ905UJGgjRRn1iHsnIcgFONX//rCI5CKSgI3+d26yAJAdP2x8yTjfHN/qMMO1cgFIb
 3aKvVcAy+Dt8fhIKTfy1nWZYWKDGMfhJQCzqgoP0+LcMll4xX9SvbN2EeJpV12nr5KA3LcHnXdl
 r6Af4+u+EH7wWKaiU+lJyhbLCyiZr8tYq1X9Z/uoeXcnaGENSlh8WXcoazQpAaEWlCJ4XenwZwn
 MgsdBURojZIGsMQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The devnode can be used by media-ctl and other userspace tools to
perform configurations on the subdev. Without it, media-ctl returns
ENOENT when setting format on the sensor subdev.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v7->v8: No change

 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index cde7fd6463e1..d82a8938932f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -678,6 +678,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
 				     csi2rx->pads);

-- 
2.41.0
