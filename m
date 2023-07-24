Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245F675EC05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGXGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGXGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:52:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5785FD;
        Sun, 23 Jul 2023 23:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OITovbs5ezsqG6r9bmuYKa9H7XPnAcp8jKCw+td+8TLol8nvxsfyPH51CgxNb87CHysq+uV69UVgF6lKgNKEV/fLKK4SmIlytmQUICrGSl+8bGM77P6dbE7vHVpEkVVc5Tz2Pfis019ZAOoQF2KGtD4PHq305/CumJhq08rK16L/NvSxSLKvQuNhpNc7het4GaL+42HOvmtN2YIfBjbq0xWeRu3OUXuTeOV04uzMGFtqwH/9BDE62Hn7WB8dcz+UjLuugWNSAD9E8fAXvElHdLvJlZ6dBaC4kHUmVU0FxTt5lJVrxYRDHxJWyTW8KBcoZfRZBmY72Qd78nhFI9ZLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6itRlRvVQzFc8AdVPZ6xqlahe2fkiJPdfJYxJz1efA=;
 b=J7nRSas0JLSY4oa3xvRZJogJ/WoyL6ktnmBF3kQO3JLcj4DGWOilazGFWyS56G+vLMujSv9ewBDfaAXDpi+vQrbf2bpilVOj4X+qGI1E0f8eLwaC17WGS07cIbvUvadC57zav0g3Me4UZbGYt0mIx17LyegbZ1hPz+LdCdQS7Q9i8T40I6R4xHlnG/yjN5bKnf4gOVCi88Tn/eGmcGFqY6v/M8g+KmbYWxsDSJeKXBqdt0AslibPp2cO4M1/Oow3XklkruPXc7X0Id41ZphxCZRDeg3B08hpxV1aG/IVfcEMAL9dLdqE6yb5gSThfN2L+7Nott/5orGOg4cIMRACvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6itRlRvVQzFc8AdVPZ6xqlahe2fkiJPdfJYxJz1efA=;
 b=ErwwI9iXL9ZnJTSemhPvbC3hfQoAp8IEAaTU7j24T7XZdUwLwmh1cKs58eJzN2AGm3tS4ucrD1m6QGEqRjA3qWN3l639rJfI9rvIcWs5K6v7KpHWSLIwb2g9gmx7vC2oNr1lHP7nfDwYJahWTcI9vqT524F1cZ1B2NX6SCnKDE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:52:51 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:52:51 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 2/2] crypto: caam - add power management support
Date:   Mon, 24 Jul 2023 08:52:30 +0200
Message-Id: <20230724065230.83017-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
 <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 9283bb25-ebe2-40fd-265d-08db8c129987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlGsiOb+u4xTCCyHsQxs0IfeYJcEvrQd76yW+T/W3KW8i4A21jB+3UAENECtM/f3YxVFXZd5WsL601Ci9VByibcEo0fveSjEqBvo6gFqfNp6MqvLcHRIM/U+JZMNWmZsbEqqKLYppi3tHXI3Mm+LnZwizOvqu3FHg7truKvtpZed8uJ98ccD+E6mOEqKHJhaKfZU8CKYPvAo4vZ50l2HGRa6Uxq9hziJBjGqLjPvbyQP0UjppC5dVeiEs2DEHFjf+JG4uPBHhZHx4o/toL6+iH0SEEcVRTtl3yfJqF9xjZqdXEHGE3ROKP4BmtX0Piia709c3ArKcEJrBU5FpZKnLZkp/yQwDqqoVx4hXjBLkZCEHIM+1rJI4rev/lvueTEnZ3FJMNupFXyTMOT/sSVMqONFUfo+4EdFtsqrU8qq6sMsEyO7ZSYn4xPAxdHML/PPilLoAiJXegk2S8WZirfqON6dIQ1xESArHtkOzFWagb3WDUp2bRwg+f3XmwjorOAYbqRnqA7LalWgSBni7WhGlTbSlBieH/wqQPUa4mCfcnrJ+S26zWdl/vahnC2TbDIhPFKR63Z6vvL/7z8C9dghFGznRXcqiWgZrOI38u6yTrXhLYhv0fSygpsDP3G6qGhS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(86362001)(38100700002)(38350700002)(66556008)(66476007)(316002)(478600001)(54906003)(41300700001)(66946007)(4326008)(5660300002)(8936002)(8676002)(6512007)(6486002)(9686003)(6666004)(2906002)(30864003)(1076003)(186003)(26005)(52116002)(6506007)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xloUYVZsuCvRoUG15ichGZkuvDpqZ02+jzddffcE/4wI3mx5P/rPTcbWZzp2?=
 =?us-ascii?Q?NFJSdv+PAPe0tobv6XojpcaMFB4NYJRv/HrJFd37oN1rJ1WfYm/xFZvs7NnY?=
 =?us-ascii?Q?y0PgOecdZLNejOHGE6wlnHyCoNCPTN2OYfaGVLHSbSubO+xPPFWLi/VMovJQ?=
 =?us-ascii?Q?XWNCd1p5Mv2hYWAOeJXUlcULPm1mrfMsQAgTo8RhIX22z31xbznRFN4qxJvG?=
 =?us-ascii?Q?F8e8iA/oNz3hEZ5cK6lCSzviomjXSoAgngKMzETZT56rVf6CUktruUZqwi58?=
 =?us-ascii?Q?FsnXjWWxip+d/GMIIEfL00o8BSXc8ATS1nWnLuo/Lo0ZN4rMwmSpt4jX/F4C?=
 =?us-ascii?Q?SvuSp8jVCb4n9KrOSgaNU1Go3kFRaMXL6RF7XgbfT6aa/Lw/mT78qWAvwLDu?=
 =?us-ascii?Q?TASYoHCxa827LFX4f1GvXtauZ+ccSMA3/i9XKExEy05PfRpu3hoszNUFg+vF?=
 =?us-ascii?Q?prISnYvPU1qJ3v5m/7ASVtpLV705+hghZ7k2QrlBIDfleB/HehbRZ1yj51v3?=
 =?us-ascii?Q?SEDhNb4LPFzXRZxxKaIOQJYRF1uAo8D742CK/ixm9n6Mi12aIU8VDSsCJGRN?=
 =?us-ascii?Q?wIvEx8joIptXXAGSnRI6e8DfQLNRx7FeJpv8ubIinONxKrPVjzAPVp7siGkK?=
 =?us-ascii?Q?oj9kPwxoXo+SlqQebPNf9kldJfMNPg3RW1u1QxAbBCXFa7rlMWkrbnAU8tKM?=
 =?us-ascii?Q?eCBZcUnNrzlhQ5ZkQ2cAebUzo9K5EjydKkKeCRnlGSyhRpoLDH/4ETiytJ7z?=
 =?us-ascii?Q?RzbwrvcSIkq3vxT3zAXkGNjpJ2s3Rnz1Veqs9JgAz6L6mDX3wPBwli85uIMp?=
 =?us-ascii?Q?0rPbF6rXJceCVW3pSGAo76orAhfWnyifLbXhyslM0T2thxMo6VrA7gU2BGaw?=
 =?us-ascii?Q?Co4KeTpX1g9fS+ZisaDz3yYLM2Cc889qv4NYALmtum3RUn2JYJLb2CyZIhhi?=
 =?us-ascii?Q?ynVoCc8I0fWvjVw4E6fnT4EhS88fVHZwqaUhn5wg+kWzqRAnQ4/XD9fiApBK?=
 =?us-ascii?Q?lcJIfLUxQ4OkzVPIAHlHpPxWWXf1EY7I4eHAM5WMfavvwqRhKDcRkc98E8zq?=
 =?us-ascii?Q?QHRFZJ2dS2Cjhx5/8Bp/kI0rnMxokepKih3JzjbMzHxLIAyzr6o0jNGt1PXO?=
 =?us-ascii?Q?QRf6zKKci8KessK37rkafPPo9xjLoMVAGdW2/Ix6y4ZRzTnMrXGXhitDPX3s?=
 =?us-ascii?Q?GpAVq8iJLMTzwTR8+s79BK8SQNY2o+/Mf/M4fELwWVnp1BcccmhGi7Id+OGW?=
 =?us-ascii?Q?wABJbYb0oMDlea2yEVFlclfra+iy+yRsizHtQZjbfFV1eOKLwIBztpCJQ1bC?=
 =?us-ascii?Q?RsFF1xmvLRwwTuQhY/97jjyUvaUK3DNcMYRq4tKYfKlD8SvdfcqaRmGk7OUI?=
 =?us-ascii?Q?tMEb2WC8UCS9aWqZZWRn9MODp+2KKtQ4qK4jXbIFHEIlKHXYwnTnkXyX0Y3J?=
 =?us-ascii?Q?xn4k1U3TD+egUi8xmX3cwad6S9KD5jLn0GhVc4TDqUXFdErbTpaudklRuBnl?=
 =?us-ascii?Q?fNabWo4W4vk/m/t4sioqUNZNydQGf3XrLTnCy0lKHH0ZjnDxIrOW8+o2kmNy?=
 =?us-ascii?Q?eFrSavTYs4btJx74Qots75SiwMGPOp8wS+b88cff2UQncmSPqe0VYXkEiHd6?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9283bb25-ebe2-40fd-265d-08db8c129987
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:52:51.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9fqG+eqHCGb21FrMmN12eMbgOlaH4X6PNv/NnyvdvUIFiJfxUJS8Bn42SzD1Jyf6zB3eLmdBL7IoEIaDeIyoe7YWn2jEIqMe0Xar7Kygi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geanta <horia.geanta@nxp.com>

Add support for suspend and resume operation for PM in CAAM driver.

When the CAAM goes in suspend, the hardware is considered to do nothing.

On some platforms, the power of the CAAM is not turned off so it keeps
its configuration.
On other platforms, it doesn't so it is necessary to save the state of
the CAAM:
 - JRs MID
 - Address of input and output rings

Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/ctrl.c   | 106 +++++++++++++++++++
 drivers/crypto/caam/intern.h |  25 ++++-
 drivers/crypto/caam/jr.c     | 193 +++++++++++++++++++++++++++++++----
 drivers/crypto/caam/regs.h   |   3 +-
 4 files changed, 306 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ff9ddbbca377..a7a4583107f4 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -740,6 +740,109 @@ static int caam_ctrl_rng_init(struct device *dev)
 	return 0;
 }
 
+/* Indicate if the internal state of the CAAM is lost during PM */
+static int caam_off_during_pm(void)
+{
+	bool not_off_during_pm = of_machine_is_compatible("fsl,imx6q") ||
+				 of_machine_is_compatible("fsl,imx6qp") ||
+				 of_machine_is_compatible("fsl,imx6dl");
+
+	return not_off_during_pm ? 0 : 1;
+}
+
+static void caam_state_save(struct device *dev)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	struct caam_ctl_state *state = &ctrlpriv->state;
+	struct caam_ctrl __iomem *ctrl = ctrlpriv->ctrl;
+	u32 deco_inst, jr_inst;
+	int i;
+
+	state->mcr = rd_reg32(&ctrl->mcr);
+	state->scfgr = rd_reg32(&ctrl->scfgr);
+
+	deco_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
+	for (i = 0; i < deco_inst; i++) {
+		state->deco_mid[i].liodn_ms =
+			rd_reg32(&ctrl->deco_mid[i].liodn_ms);
+		state->deco_mid[i].liodn_ls =
+			rd_reg32(&ctrl->deco_mid[i].liodn_ls);
+	}
+
+	jr_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
+	for (i = 0; i < jr_inst; i++) {
+		state->jr_mid[i].liodn_ms =
+			rd_reg32(&ctrl->jr_mid[i].liodn_ms);
+		state->jr_mid[i].liodn_ls =
+			rd_reg32(&ctrl->jr_mid[i].liodn_ls);
+	}
+}
+
+static void caam_state_restore(const struct device *dev)
+{
+	const struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	const struct caam_ctl_state *state = &ctrlpriv->state;
+	struct caam_ctrl __iomem *ctrl = ctrlpriv->ctrl;
+	u32 deco_inst, jr_inst;
+	int i;
+
+	wr_reg32(&ctrl->mcr, state->mcr);
+	wr_reg32(&ctrl->scfgr, state->scfgr);
+
+	deco_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
+	for (i = 0; i < deco_inst; i++) {
+		wr_reg32(&ctrl->deco_mid[i].liodn_ms,
+			 state->deco_mid[i].liodn_ms);
+		wr_reg32(&ctrl->deco_mid[i].liodn_ls,
+			 state->deco_mid[i].liodn_ls);
+	}
+
+	jr_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
+	for (i = 0; i < jr_inst; i++) {
+		wr_reg32(&ctrl->jr_mid[i].liodn_ms,
+			 state->jr_mid[i].liodn_ms);
+		wr_reg32(&ctrl->jr_mid[i].liodn_ls,
+			 state->jr_mid[i].liodn_ls);
+	}
+
+	if (ctrlpriv->virt_en == 1)
+		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
+			      JRSTART_JR1_START | JRSTART_JR2_START |
+			      JRSTART_JR3_START);
+}
+
+static int caam_ctrl_suspend(struct device *dev)
+{
+	const struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en)
+		caam_state_save(dev);
+
+	return 0;
+}
+
+static int caam_ctrl_resume(struct device *dev)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en) {
+		caam_state_restore(dev);
+
+		/* HW and rng will be reset so deinstantiation can be removed */
+		devm_remove_action(dev, devm_deinstantiate_rng, dev);
+		ret = caam_ctrl_rng_init(dev);
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend, caam_ctrl_resume);
+
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
@@ -771,6 +874,8 @@ static int caam_probe(struct platform_device *pdev)
 
 	caam_imx = (bool)imx_soc_match;
 
+	ctrlpriv->caam_off_during_pm = caam_imx && caam_off_during_pm();
+
 	if (imx_soc_match) {
 		/*
 		 * Until Layerscape and i.MX OP-TEE get in sync,
@@ -1033,6 +1138,7 @@ static struct platform_driver caam_driver = {
 	.driver = {
 		.name = "caam",
 		.of_match_table = caam_match,
+		.pm = &caam_ctrl_pm_ops,
 	},
 	.probe       = caam_probe,
 };
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index b4f7bf77f487..e51320150872 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -4,7 +4,7 @@
  * Private/internal definitions between modules
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2023 NXP
  */
 
 #ifndef INTERN_H
@@ -47,6 +47,16 @@ struct caam_jrentry_info {
 	u32 desc_size;	/* Stored size for postprocessing, header derived */
 };
 
+struct caam_jr_state {
+	dma_addr_t inpbusaddr;
+	dma_addr_t outbusaddr;
+};
+
+struct caam_jr_dequeue_params {
+	struct device *dev;
+	int enable_itr;
+};
+
 /* Private sub-storage for a single JobR */
 struct caam_drv_private_jr {
 	struct list_head	list_node;	/* Job Ring device list */
@@ -54,6 +64,7 @@ struct caam_drv_private_jr {
 	int ridx;
 	struct caam_job_ring __iomem *rregs;	/* JobR's register space */
 	struct tasklet_struct irqtask;
+	struct caam_jr_dequeue_params tasklet_params;
 	int irq;			/* One per queue */
 	bool hwrng;
 
@@ -71,6 +82,15 @@ struct caam_drv_private_jr {
 	int tail;			/* entinfo (s/w ring) tail index */
 	void *outring;			/* Base of output ring, DMA-safe */
 	struct crypto_engine *engine;
+
+	struct caam_jr_state state;	/* State of the JR during PM */
+};
+
+struct caam_ctl_state {
+	struct masterid deco_mid[16];
+	struct masterid jr_mid[4];
+	u32 mcr;
+	u32 scfgr;
 };
 
 /*
@@ -116,6 +136,9 @@ struct caam_drv_private {
 	struct dentry *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
 #endif
+
+	int caam_off_during_pm;		/* If the CAAM is reset after suspend */
+	struct caam_ctl_state state;	/* State of the CTL during PM */
 };
 
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 96dea5304d22..316180d26f8a 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -117,6 +117,23 @@ static int caam_jr_flush(struct device *dev)
 	return caam_jr_stop_processing(dev, JRCR_RESET);
 }
 
+/* The resume can be used after a park or a flush if CAAM has not been reset */
+static int caam_jr_restart_processing(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+	u32 halt_status = rd_reg32(&jrp->rregs->jrintstatus) &
+			  JRINT_ERR_HALT_MASK;
+
+	/* Check that the flush/park is completed */
+	if (halt_status != JRINT_ERR_HALT_COMPLETE)
+		return -1;
+
+	/* Resume processing of jobs */
+	clrsetbits_32(&jrp->rregs->jrintstatus, 0, JRINT_ERR_HALT_COMPLETE);
+
+	return 0;
+}
+
 static int caam_reset_hw_jr(struct device *dev)
 {
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
@@ -245,7 +262,8 @@ static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 static void caam_jr_dequeue(unsigned long devarg)
 {
 	int hw_idx, sw_idx, i, head, tail;
-	struct device *dev = (struct device *)devarg;
+	struct caam_jr_dequeue_params *params = (void *)devarg;
+	struct device *dev = params->dev;
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	void (*usercall)(struct device *dev, u32 *desc, u32 status, void *arg);
 	u32 *userdesc, userstatus;
@@ -319,8 +337,9 @@ static void caam_jr_dequeue(unsigned long devarg)
 		outring_used--;
 	}
 
-	/* reenable / unmask IRQs */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
+	if (params->enable_itr)
+		/* reenable / unmask IRQs */
+		clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
 }
 
 /**
@@ -470,6 +489,29 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 }
 EXPORT_SYMBOL(caam_jr_enqueue);
 
+static void caam_jr_init_hw(struct device *dev, dma_addr_t inpbusaddr,
+			    dma_addr_t outbusaddr)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+
+	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
+	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
+	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
+	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
+
+	/* Select interrupt coalescing parameters */
+	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
+		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
+		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
+}
+
+static void caam_jr_reset_index(struct caam_drv_private_jr *jrp)
+{
+	jrp->out_ring_read_index = 0;
+	jrp->head = 0;
+	jrp->tail = 0;
+}
+
 /*
  * Init JobR independent of platform property detection
  */
@@ -506,25 +548,16 @@ static int caam_jr_init(struct device *dev)
 		jrp->entinfo[i].desc_addr_dma = !0;
 
 	/* Setup rings */
-	jrp->out_ring_read_index = 0;
-	jrp->head = 0;
-	jrp->tail = 0;
-
-	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
-	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
-	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
-	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
-
+	caam_jr_reset_index(jrp);
 	jrp->inpring_avail = JOBR_DEPTH;
+	caam_jr_init_hw(dev, inpbusaddr, outbusaddr);
 
 	spin_lock_init(&jrp->inplock);
 
-	/* Select interrupt coalescing parameters */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
-		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
-		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
-
-	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
+	jrp->tasklet_params.dev = dev;
+	jrp->tasklet_params.enable_itr = 1;
+	tasklet_init(&jrp->irqtask, caam_jr_dequeue,
+		     (unsigned long)&jrp->tasklet_params);
 
 	/* Connect job ring interrupt handler. */
 	error = devm_request_irq(dev, jrp->irq, caam_jr_interrupt, IRQF_SHARED,
@@ -635,11 +668,134 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	atomic_set(&jrpriv->tfm_count, 0);
 
+	device_init_wakeup(&pdev->dev, 1);
+	device_set_wakeup_enable(&pdev->dev, false);
+
 	register_algs(jrpriv, jrdev->parent);
 
 	return 0;
 }
 
+static void caam_jr_get_hw_state(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+
+	jrp->state.inpbusaddr = rd_reg64(&jrp->rregs->inpring_base);
+	jrp->state.outbusaddr = rd_reg64(&jrp->rregs->outring_base);
+}
+
+static int caam_jr_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct caam_drv_private_jr *jrpriv = platform_get_drvdata(pdev);
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev->parent);
+	struct caam_jr_dequeue_params suspend_params = {
+		.dev = dev,
+		.enable_itr = 0,
+	};
+
+	/* Remove the node from Physical JobR list maintained by driver */
+	spin_lock(&driver_data.jr_alloc_lock);
+	list_del(&jrpriv->list_node);
+	spin_unlock(&driver_data.jr_alloc_lock);
+
+	if (jrpriv->hwrng)
+		caam_rng_exit(dev->parent);
+
+	if (ctrlpriv->caam_off_during_pm) {
+		int err;
+
+		tasklet_disable(&jrpriv->irqtask);
+
+		/* mask itr to call flush */
+		clrsetbits_32(&jrpriv->rregs->rconfig_lo, 0, JRCFG_IMSK);
+
+		/* Invalid job in process */
+		err = caam_jr_flush(dev);
+		if (err) {
+			dev_err(dev, "Failed to flush\n");
+			return err;
+		}
+
+		/* Dequeing jobs flushed */
+		caam_jr_dequeue((unsigned long)&suspend_params);
+
+		/* Save state */
+		caam_jr_get_hw_state(dev);
+	} else if (device_may_wakeup(&pdev->dev)) {
+		enable_irq_wake(jrpriv->irq);
+	}
+
+	return 0;
+}
+
+static int caam_jr_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct caam_drv_private_jr *jrpriv = platform_get_drvdata(pdev);
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev->parent);
+
+	if (ctrlpriv->caam_off_during_pm) {
+		u64 inp_addr;
+		int err;
+
+		/*
+		 * Check if the CAAM has been resetted checking the address of
+		 * the input ring
+		 */
+		inp_addr = rd_reg64(&jrpriv->rregs->inpring_base);
+		if (inp_addr != 0) {
+			/* JR still has some configuration */
+			if (inp_addr == jrpriv->state.inpbusaddr) {
+				/* JR has not been resetted */
+				err = caam_jr_restart_processing(dev);
+				if (err) {
+					dev_err(dev,
+						"Restart processing failed\n");
+					return err;
+				}
+
+				tasklet_enable(&jrpriv->irqtask);
+
+				clrsetbits_32(&jrpriv->rregs->rconfig_lo,
+					      JRCFG_IMSK, 0);
+
+				goto add_jr;
+			} else if (ctrlpriv->optee_en) {
+				/* JR has been used by OPTEE, reset it */
+				err = caam_reset_hw_jr(dev);
+				if (err) {
+					dev_err(dev, "Failed to reset JR\n");
+					return err;
+				}
+			} else {
+				/* No explanation, return error */
+				return -EIO;
+			}
+		}
+
+		caam_jr_reset_index(jrpriv);
+		caam_jr_init_hw(dev, jrpriv->state.inpbusaddr,
+				jrpriv->state.outbusaddr);
+
+		tasklet_enable(&jrpriv->irqtask);
+	} else if (device_may_wakeup(&pdev->dev)) {
+		disable_irq_wake(jrpriv->irq);
+	}
+
+add_jr:
+	spin_lock(&driver_data.jr_alloc_lock);
+	list_add_tail(&jrpriv->list_node, &driver_data.jr_list);
+	spin_unlock(&driver_data.jr_alloc_lock);
+
+	if (jrpriv->hwrng)
+		jrpriv->hwrng = !caam_rng_init(dev->parent);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend, caam_jr_resume);
+
 static const struct of_device_id caam_jr_match[] = {
 	{
 		.compatible = "fsl,sec-v4.0-job-ring",
@@ -655,6 +811,7 @@ static struct platform_driver caam_jr_driver = {
 	.driver = {
 		.name = "caam_jr",
 		.of_match_table = caam_jr_match,
+		.pm = &caam_jr_pm_ops,
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 0f87bd365582..873df9de9890 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -584,8 +584,7 @@ struct caam_ctrl {
 	u32 deco_rsr;			/* DECORSR - Deco Request Source */
 	u32 rsvd11;
 	u32 deco_rq;			/* DECORR - DECO Request */
-	struct masterid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
-	u32 rsvd5[22];
+	struct masterid deco_mid[16];	/* DECOxLIODNR - 1 per DECO */
 
 	/* DECO Availability/Reset Section			120-3ff */
 	u32 deco_avail;		/* DAR - DECO availability */
-- 
2.25.1

