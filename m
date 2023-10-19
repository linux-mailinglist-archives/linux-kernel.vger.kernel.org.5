Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578047CEE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjJSCsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJSCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:48:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF2193;
        Wed, 18 Oct 2023 19:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXAU2Xd9wutNj01XC6RB364kzfd182KmKdVjsaxq/rxKi9hAxjZjrGP69azfIKxewwOGhp+RL+nnca5MC5W7nRjJMOMBra/d5DgkOIB0jyNOfYwwPdzFR9seK1Y4wCyzE4klvxd2uvaPdKz9XLLXekrcyPW6tjDrZwKncIjDZOcW7q7TgXvifEe1VAf4G+cyCLXHkgUHIjCyavJtO05BMPlcMB1KdpoJX6wAf/pzf6ZCuG240D5jq8iAmJ7yHQz+ubqmtBeFDUIMa+YgGRoW4cw8EKG99p8LxB+w3Lwfwlup7EjSF8yiANnQvtSmgOxzGwqWwjXhAxmTQ8fL2bMDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEWFVWZKinvQdrxYcIrxatj85NQhW7EW8uxc7yEPn2Y=;
 b=S1s3/B6OdN4MOmaSBPF6IJ6uVIzMdQYKut4yP3i/vns1JldOOQ5U3gqcNIR8WRydeMkCHZag00P+1aBNe+fRH0RaIKjNOhqmze+7Gn8c+OADgC213xLIgiles6bPrMzyBhvCNlIQgcpH7836rW24AkXi4PaMKzHLmI/GfGlRfJHk+cu7unWKbNg8fNJrd+/uEJa0ESTy8cVkK7it/YI6bO01x/Pu7avARrTTiCfUIh+z7ZzkKmjDagQTAvQE1ygvXPzVH3bJKTREtm0QHCKzaqdlWqFkcGU9QMTK7U45yn5z2ri27VHVosD9KsgB0R7RjqDatx267T0VtoZNaGuL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEWFVWZKinvQdrxYcIrxatj85NQhW7EW8uxc7yEPn2Y=;
 b=Rl053gx+1W87jVOf0uNrjg5GgC3z5ksBTwEYv4x3WjG3aawmvLnqtNAJWWAznzSs/qmWX136kp/hHcNxA472pVuuU0lIVGwFGWLVdJX0VcxYzXckr2hgWWXf5nRtr6SHPbaSWHkkkaDi7Bs7hhM3FOvqFk03VvbZogvUERDwkF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 02:48:38 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:48:38 +0000
From:   "Ming Qian (OSS)" <ming.qian@oss.nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/3] media: imx-jpeg: Add vendor prefix in slot property
Date:   Thu, 19 Oct 2023 10:48:02 +0800
Message-Id: <be1f8907582ea344f8826f7888b277534859e0c4.1697597713.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1697597713.git.ming.qian@nxp.com>
References: <cover.1697597713.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3400576c-bb36-414f-1f05-08dbd04de53d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laW823mHqSxU+aq8ctS78uwJloTjbBZO4xCWew5AqduA2+1K97SwBELiJkPfv3xhfzXZeRuByX0LAhkPxpSBj1EcCnQ+fjBFAT4dwmRtx4aZZOFNr6+7qrso4vHMB5P8CDuMmkhunojju6WDQASFMlGF4/aBden7CODynCAkW9IuWvlG4aavbxv1zMTMgN5g/+pKmacDNdwbDR74sS8tw4FIDUn/w8xSNSrt9tTk5NLcT6LwCfCg7iUuYwUqsAOsAs4JZq3ly+g7N1EpPbsIeGoupvdh0BbCKupLFQmXwdZFGAShBDfzIKByknfA6MAa7X4kEA+75PE2V7qWA9RDMfYZeylJqO+NrcqfD3jd/kIyKLBFyCOf/RDhddkrkERi7/Wm21x0M9E4+F6MjUULaBh9N8/M+HF3WppZnj2cXSPEko72/eYOF5fclhVeUubAO7629X/vhoPLF4FAiYLrzf+Cb66DD55/kqeBdpVi90oLKrUBiNCZbb9eQEnQk17b1qfFVNiYC/ErRTV4ODwFDKmkaP6hOp0Wt75m6K/6Je/Mor/E7zLvmLYCFPy9YrN0lA+uN3l3FS5CkAPrWlt//BCos4Pqlj4iYZ+4d+YfW1eG+GhUxYLdGbgtcskZsYBi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(6512007)(86362001)(36756003)(9686003)(8676002)(66476007)(66946007)(38100700002)(316002)(83380400001)(52116002)(6506007)(6666004)(66556008)(41300700001)(6486002)(478600001)(8936002)(7416002)(5660300002)(4326008)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qv/PK6Osxi/z4zpK7ghbD+EWV3da5u81+PCUC/gVNdODbCHdw1VHBdi2lHWh?=
 =?us-ascii?Q?YeUADxI/tbbn2OJ+oURhAwavHEHrjB8l9ew3L2gutABYNWWcOznVrWSmxAAp?=
 =?us-ascii?Q?lKge7GVBweiaf7IjCPAGiMejjwYm6XQBMZuA0sK2lOU5aIT6Aq+k2MQJa3CT?=
 =?us-ascii?Q?kMYDY5CA3K0gutvvEouugrxhkhDwiw2A86PvFo2zyeHCeyaxvEfp+UXyEKI5?=
 =?us-ascii?Q?ZuINHF7lMTc37GF9+gTlpAmuii9VfgOH5tMCEjPHoNxmTGL/jGS84DnJ2ktC?=
 =?us-ascii?Q?3/D8sG126cek+l9fw6mTU/C8Wzc/sP5vsTe00BI55b7xhyPDrV3o0Qi28B9o?=
 =?us-ascii?Q?ibOkXyVspp/MT2hLTS3Sj9OW3rK3oRcLw70Ks7JCLp5DRDK7lqz/m7rcnnbu?=
 =?us-ascii?Q?n6O0kaLa2V5G+jBL6ELFQBMPIwvobU1TwHHfLQxLCfaz/XjqEB5zvMlmyyKJ?=
 =?us-ascii?Q?y7rdQtylKYZBztfC6LBipx68AMABMbSfMAghG7Ihg9nyf0mxrwjgh2my5+bf?=
 =?us-ascii?Q?cDT56LbT2QxnYoT8v+hdlr7P4S54/kYKI82+a//I8sNZ0tK66Ryczj9a0nuh?=
 =?us-ascii?Q?SzjXjTBlZcXVqeTIpjv0pdFR3gh/Gosmpgr6JJygA1aMaXzXBnn4DXsaR89Y?=
 =?us-ascii?Q?bZFNXxvpKlJxDXMh6AqNUmxNDXX0gqWc4K6tOeWag3HJnT+kDlvKmagY1KeN?=
 =?us-ascii?Q?UNv2sPt/+K+OLrOvf7ZtuohbBh5dMg/Ss/j4gIhk4L0cHQ1aroakG4HeWK8C?=
 =?us-ascii?Q?fZyF5ihfYuNVWkQSDExF+rQLvMtPaMtw+Yj1yOSufwhtnHl4MZjrRCir6A6t?=
 =?us-ascii?Q?5USFunAk0xwoBvtMDOlF7bSYB1PH5+1CkGIVMI0GlJcnRUxlRiyZkbZ91T0S?=
 =?us-ascii?Q?g7SFsTr+KbkEVwXwzF14GEugua9gLcXBD1oLZuId10dPGCdcge7dhzWHBmoR?=
 =?us-ascii?Q?EiQ9ujScrZgFiGv6D5/smMEKEZg35WKXMaozF60jMh6g3PGZlXRoLlVc4gr5?=
 =?us-ascii?Q?eQ+2+xLuvRfNlZPzWqeTO8Czn3uU+x9dzHbqnqb9Mr/j+aWLV4A7c5C12+mR?=
 =?us-ascii?Q?YRpp5sIatcY8EjwuYRqwJJTAT506bCe+OMw+jLe5fFotWWeLOZQddacUJ0iI?=
 =?us-ascii?Q?CG9WHQzhBX3kALWn9acH3JjHwtqC7KSi7NK2WTNLv/g1MKU0mdZPKOTXFhX4?=
 =?us-ascii?Q?XYieS8OJs6hEOEgYPbupVUWyISmiE3vXHE1mzUPYqwQd/KCDUBeJXXx5ewJ0?=
 =?us-ascii?Q?E/3PECGWqJmgh0dWr68ufShd9r8sJqsDnzgxxop/VR3qwxqtB7/eYhdFi2go?=
 =?us-ascii?Q?zHOZ0Ln8e6H+X6kR8ofIkn0Raws7yy6u/syYSgClgFE0AsgYBBCe8dRNmXSi?=
 =?us-ascii?Q?al36EN2BopE7C/xMg7eBPeXRsF/dqk8sezvkAiRZcC1b68XTVVEdSsjvH3mu?=
 =?us-ascii?Q?HgnEeIIj8t/fjbb/VQrf4cTwCChMfZVWVUWOk/4CNBvjwRAZWDq3B7xkYcp/?=
 =?us-ascii?Q?PcDKybVFGw1ltjwavdTxRQTAd1nq1J/D1s9RHLXCH4cMIuOOV38mqaH67Q9S?=
 =?us-ascii?Q?A6uGVZiAPwUnNp1sjWu/XMrIboeVlvu8SIwjLoch?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3400576c-bb36-414f-1f05-08dbd04de53d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:48:38.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbR3gqLD+7IZjDaOU0O4BPvqO9+DXI4/nplvyqh50TC0x4PTK1sATMBWpwEsdtofO6+WqAU6lkeEXOOM6Ks54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

The slot property isn't generic property, add vendor prefix. Change the
property name to nxp,slot.

Fixes: 53ebeea50599 ("media: imx-jpeg: Support to assign slot for encoder/decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v5
- add vender prefix, change property slot to nxp,slot

v4
- nothing changed here, just modify the bindings and dts

v3
- nothing changed here, just modify the bindings and dts

v2
- nothing changed here, just modify the bindings and dts

 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 64112b63298c..f8b99a292ad1 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2762,7 +2762,7 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	if (IS_ERR(jpeg->base_reg))
 		return PTR_ERR(jpeg->base_reg);
 
-	ret = of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg->slot_data.slot);
+	ret = of_property_read_u32_index(pdev->dev.of_node, "nxp,slot", 0, &jpeg->slot_data.slot);
 	if (ret)
 		jpeg->slot_data.slot = 0;
 	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
-- 
2.38.1

