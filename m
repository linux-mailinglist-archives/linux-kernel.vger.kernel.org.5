Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31C7881F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjHYIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHYIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:24:36 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D71FDB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:24:33 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD4D1A1303;
        Fri, 25 Aug 2023 10:22:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 55A041A12FD;
        Fri, 25 Aug 2023 10:22:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C5D17181D0E2;
        Fri, 25 Aug 2023 16:22:41 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        marcel.ziswiler@toradex.com, Frank.Li@nxp.com,
        xiaoning.wang@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and SERDES0 power domains
Date:   Fri, 25 Aug 2023 15:47:15 +0800
Message-Id: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed PCIEA, SATA0 and SERDES0 power domains for HSIO SS.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 84b673427073..7b8c2689b49c 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -165,7 +165,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
 
 	/* HSIO SS */
+	{ "pcie-a", IMX_SC_R_PCIE_A, 1, false, 0 },
 	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
+	{ "sata-0", IMX_SC_R_SATA_0, 1, false, 0 },
+	{ "serdes-0", IMX_SC_R_SERDES_0, 1, false, 0 },
 	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
 	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
-- 
2.34.1

