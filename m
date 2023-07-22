Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014A75DC82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGVM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGVM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:27:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731BE2D7F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGT4Yylyq2Ixh8ScKvDPh5Alf9um4XFuxnZ2TDAw7MVwMMBcabCo7AJ+nXHGuMd9CV0c1xUfZGTUL5JFyf5S1wmnyuWAm2CwEZ83P061UYFxk/5Iz5VEkeYTclf13fGwery+ei89d8n3ETja08Fdk9k0SnCETFzzy1fuX9zAaMqGcjI9m+1BFrTjuJ/1foE23SBJUz/HsNuCPYowm5bjeSg4FZobp5YWCZn0qZgLbkpwfX1kGpflsF2T7YYZXzBJvqymr1b7kv/LK7O8qyGUlWOu56Rr5Ek0hLVT+toaiSfYtHztEpkCHQd9kB7XH1v5H8An+f7F6pRjy4WOy6BUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=VcRVsb4Egf277v5vu0shgf/wWm9t5yj7jCKq2k4J3FTXuzN8fZF5opn7CV1yfkDU8KTqnPGoblhN1XwJJh0igO/uq7THX4ysged+QNrYEllTrrbKd/NfotF6C3mc2OfjD8bpN0OO8ghJLuy+eRlLp3SbuzkstibQmkC9MEQ0cyP4xnql1pf1stafW56+I/snMBNEJAjLh43ru1++PPIpheFDepweLfcEjWx9jYldVqrX5J0w2E/BRP+sg0zOe0cHZ6occlRCrl+KGU139yg9I2RgOwsOfrzjS0mQ+dfZqF3doRIPXwuzFvfCqUnjjUuPkPlKYMrFVHaGSIVvop5YYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=CZfh1ffGR+XVZeH/uVZIDWbKxb/y7Mc9Doslhis0jxqZVtcXA00cBxvnUBLJnjWxigbRpY+bngTW9HFGdqrHUXbaDFK7szt1Mr5O7eFfa6tMWNfGK0b73Se8yh7PbDNV5f+T0gzo+t2UhfzgI5ozCqLK5aPSaffwZKxuJcujzZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/8] firmware: imx: scu: use soc name for soc_id
Date:   Sat, 22 Jul 2023 20:31:15 +0800
Message-Id: <20230722123119.1966998-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 38277c58-ee6b-4b99-6063-08db8aaeec4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oq460kv+SDADex3PeFRuejWZv0q6CBIeYD3pnTZ6rhMsyho2frhJPPHdwSztpc1I5LtkjJt+MebMScwinc33pQDEWaBwxjkD+l0tizKQCFQ2Gyiuk9ukuUEpCIZfZeLLTHF9sVqgM90By4eS6HQXOfl8RurbRnvOgMrGe58/7bVznIr9TPS0cKwfOkE9ZFNF38qQPaiawU0gTKhDitBLc1pW7FUSl9Hr13xG+Jyw6qvACpt5jCyIf+/zmVH2ao9UZ/d/OKDch3cGljZ4gWBLbBu0pmeIFBk7PmzWWEqBT54UGtZkF4Ium6FIqFZYuzNEBkS5Bsh3BbUXk5jfhcFQupPcvmFcE+WJs7tEmrB6pM0aKg/wiNRfMJQfA74darhu+DrI4VtdngeQ2WmP0e/seBJ9pma0uV8o8W/fNOmsWqdjBrK4PgY+/+/slsvkicbcp3SqS5Ix9DKH6qz+KRjYag4XzcSqNQyN5CnpbAJPJyWl+fNo1f4SsJ87w9owdK7qOlAMG6RS84OVOe4zjTQaZDjOFsFuYSnb2OD5zDuyIoRYOvpYGVpd+yVUN/Aam+74ZpmQPrc5aNQjErIpV87PP4ZWxtX5Sgs4wsiCWP+23Hotu7kjaTKM87fgRgZDnGDH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmRGsAdOUeC6Xx1jrFp3G9xabxcQAItETagq/U/TeD0FwxG0OO5rC8IWfOvq?=
 =?us-ascii?Q?NmAMCO/xSO72uT+fWN9El/Qm0vcxQUQ2UK82GXh4WiV13YMs1VaLBD8mIzvs?=
 =?us-ascii?Q?UhNdGNqFczqe1dzL/zQbstpG9tuzamy7FL9p8VUtsz2GU63UpFwHc1FYXCdC?=
 =?us-ascii?Q?5kT9Uzq49f4AC95G5EU/fbzxKp+EzqmM8yqPrgmEGNTfGz2o9jNvcrZeNeBu?=
 =?us-ascii?Q?9YwC2CmmZ9gLJDL4MLmo1vsV+uZPlCE/rzcljvi3U7oNvgKm7Th8X9HZDdt7?=
 =?us-ascii?Q?YKHkzDw4IqWZ1zsO929QmeE4wvbEOM2Zvej0+uL/qJ9SasVP5aUVM/zj+pqv?=
 =?us-ascii?Q?J+gbIY6nZJyvJf7oBypaghAUtcL10tYWl3RYhdRQ3JyYiRyF53vpnbX8tuZA?=
 =?us-ascii?Q?4ljJOpPkcpHqOI8x/EiFbY0/ORhu9l/Jw1IfFzwUIp+i5b7s7NFFi9iy4fAe?=
 =?us-ascii?Q?RfYgc36h4zH5rKwc7d/aJyH1b6iLKPf7BCNvESyar8VDp9mhL8G8OykuWttd?=
 =?us-ascii?Q?6FQ/4rzPAh5kHedhmCufOt50HyI2x1pkweNo8vAdmpaAbFMBlQiwtZTGQacy?=
 =?us-ascii?Q?RDGxl0xstaKkSSV9RRltSteF4+d18Hmws0iOsNjTahHFwd8VytkeHc0tTUg8?=
 =?us-ascii?Q?5ZMi+E8AMmKMxoTdWwR7pREtuFnMPAHa5KQwjBCQSqsH0pXmpdo8yC/oPyjN?=
 =?us-ascii?Q?FfrOelOc9z2lP+6tVGTiut+vxsZMIEeyzBcba3muML0eAJaeqwNP1jY58z83?=
 =?us-ascii?Q?UfKCn3/7KY+WS0XkOxfWlUoL5qa0izew7VhfhZ8JxssXnq+Pz9iVVrwVwXMo?=
 =?us-ascii?Q?cX8RMNDXt27F15N04R25QKazcdwnbjlcbMRH9rs4SxGsSCxEN7EmiKMn3PHD?=
 =?us-ascii?Q?PWQQ5xkt2lEn9GpU/h+NBP/jetClVMEsmTMuIjM3Guq7byDkdxXOXT7z1AON?=
 =?us-ascii?Q?p7CZrte0gn3npDB+sxOF+HTrohDCt45pKDC+HLw9f7fKzVKV08/rSTNSDkE6?=
 =?us-ascii?Q?SrrVKRm1t/CgxM9n76oUtl9BhAh6if1x0yFUUhIgnDigRpE2mdjPl4A4HQXs?=
 =?us-ascii?Q?3ZwausWpDfUQzSZ+2MoJ4ntctNF6Bma3JPdCUv+9HE+SuqH0htn/QrdjIYSE?=
 =?us-ascii?Q?Q8g+4pti00S/DaNr/FArFr6VtIgOfK9YuJHu1S/GHya7OqzZYXIT8VIj04+r?=
 =?us-ascii?Q?mwROg7kqF4G/Wai6HFqdq+2iJJEdWcmXYG78g/gExRBtxjTtM55YDUVwsYK0?=
 =?us-ascii?Q?2cPD/kC2a4Wer87QVPG5w+NOIljcjpQJBIR1DFmUsm9daMDKp9DRdQkvbboR?=
 =?us-ascii?Q?L91BlHSu/+37emgFzXZ3BnLqcjj9Etuhn8CE3cNzT1Js6gEH8Gq46d1S6N0S?=
 =?us-ascii?Q?+ClcHiU0e1jndiuJns2n+16WzJXdGFlDgsCOysNpkD5MfSoN6PCNkovgxdPV?=
 =?us-ascii?Q?MhZejBRGgb8NlA25F/sLVuSRF3BpkOWPlLvBwdsy7zhN0miZO2RZM/K9fJCe?=
 =?us-ascii?Q?UaYzuBeXNM2FBFw9NxRkUwp/0fcHtYBWCg56vVEj63T/aFSrbFiXlXlXsPy8?=
 =?us-ascii?Q?Jk0KqsA2A1Hlyp+xSk3lbtdFBpEedQVnsh0uheGq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38277c58-ee6b-4b99-6063-08db8aaeec4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:49.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzZeNCQQvWHn2O5zKl7QRT4BE5tsNoWSDa4QqICkTBc7HTqwmIiem79yqL4mYbypCPbS/SGPFeY5/vo3KQ9olA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same as soc-imx8m and soc-imx driver, use soc name for soc_id

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index ef9103987e76..cb8377670a7d 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -107,10 +107,12 @@ int imx_scu_soc_init(struct device *dev)
 		return -EINVAL;
 
 	/* format soc_id value passed from SCU firmware */
-	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
+	if (of_machine_is_compatible("fsl,imx8qm"))
+		soc_dev_attr->soc_id = "i.MX8QM";
+	else if (of_machine_is_compatible("fsl,imx8qxp"))
+		soc_dev_attr->soc_id = "i.MX8QXP";
+	else if (of_machine_is_compatible("fsl,imx8dxl"))
+		soc_dev_attr->soc_id = "i.MX8DXL";
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
-- 
2.37.1

