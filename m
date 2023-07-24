Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1775E981
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGXCIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGXCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:07:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81F30E3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0AyQ32r0r3utqRQsuOs312ESM57dipnp57eJrQfgcfHewfQm4nETDWKB2o+gDFn/bPITjXWN03vEj0ebNOol8xKT4apm2J4GDk/Vr/flBShNuZkd2h+VC9kZtrRaUKp4KMihAJMlcqdsaWQCpqhVuh1VBz5gLJgncKA+6xy2P0OouwI/sZK9Ovl9AVbu+O9sZCRN/EYpcjc9oE+hgE1/i5DMYnruWj/is9anrRfpqtiOphDUJ50clqye5aMyfr/OdHgglTqVH1hCBY1m8V3y9C5MigoAg7xefH1nW3Q72Gceb5aOSSmS7/aUsRtQSPQ7B+TaaP0a04yIkA5UbriIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=Zzg/zwURuspkguwGuj0OCQvUBkXbcRZxEIEKfPFfNtbddSoLjn/9p+ICPpdXLIjtw1x0Nc00Ev/kmf2xj3/XCAqdJh0WvwnpWtCzv37FjKpV6dCBKMN8tt85z30Sdc9ZCUui7AvQ3jWO+6kQ/e340aeK157W/CqlprhX/NdP2ye6h2nH03XcN/R51UQNWhzg8jMXRYDzaHUDTlraRUt+8DjGGmmbBZcEo5WPrMBSOKYzhvJh+J6Qe2cY6Gy2cdvwUEY+dUj3NU2s/1Dkd/p7m1DFk5Xca/VHPuboqEyNzzt6L3hO7BAsPOcDqi4+8x6nXPtSnXrg+0KmCy9AWY6x/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=ECs78Q3zUkktSV/0lQw4hNoYWht+WzQ0xEJ9sam1LXB0sdQPXfd7ufiOaZyRZvPsScu/KLtIlS1WNRnL38x+buWBH9c5knssVBKJbahm2QR73nIicSr8+pvkbxRbPEO0vUpiUF23gAKxv/BHYnUOqf4yt78opDvUVD0bQO/d7y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/8] firmware: imx: scu: use soc name for soc_id
Date:   Mon, 24 Jul 2023 09:47:05 +0800
Message-Id: <20230724014711.2048958-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: c998e18c-44a4-463d-8169-08db8be744e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMe3NnyQzWcKpAC0vX9cltKXbo3tX4oZwHNIMtvfUFfNLaipZxe7PPpFOe0aaq04VY8ZYDt1Gzobv9zkRVqnxUro2tYRy3Ml6vP7yXnu7cyA4pF+Qii/Nrls4mbfX1BwS76ww3hM19nJ4CsSBvvzoCQSuL30R6EYZGDLt3+wJej31UjqjX03soN9yoML6xSnL8O960CxGVD5ZrP+AforCODqaRAUkv/73Yk++Eb68Ilc2bUOmys7Yize6UFAIrSFDC3h8s7/5D7XZPzkz46e/3SsCFzl3jBzGDm0hO59eEDn8MI8b9rPuNrsuvItLD8UKh75wIf2iqXWANfgang9Eeh5v5xDDsiL6tv76RsRxgB7B145nfO5pU8/mCwXaMAHW9+hU76IWJkbLv/uRQcnU0iaDwLgrw/yhRTjvB2enCHHTUseufLHzfIXaxOsN7IM/ZVYBkd1Jo7ey80ES7QzBOfSjOmZQjyHdAfzeeewBHwycsyjf1+/PzZ7d1/JYpvYOuElovfo9FkqgrF/Ys84vTU99nMAtc8XTEcpVK1R1LmyhieLVzsKcvw/fisw2BhdZ6QuwcSI9+c0tu066yzi6Xl3oA/u+MJEBjiSXhYMgwuDdmVGAK/KJn7GkzglFNQM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nif9kvk2XQKddu701TK9Q1UFxQZqIlkAPKRtLjcNdFeSBmgKwvWRunMBZiNn?=
 =?us-ascii?Q?tk+6w32ZzxgcR3aSxQcp77UOzofVbXFCBy9EHta6bEWSGX+2Lg+7OjEK5hiK?=
 =?us-ascii?Q?bCPH8rewjGgxaZxyhQylE3X3S3RqydrPBQdu5neUKBZik4RPmen88yAZjuAR?=
 =?us-ascii?Q?GtFgdws8+aF+uhZXw2q/68V7GJw0q4LtVABcPCW0+9gYreUN+NROdbMYCIrP?=
 =?us-ascii?Q?pQfPvceYc0O4d7j5Cd6uDJnoCQgkksXV1i3nHjCuMjubyVxotsdHYuXDnv6s?=
 =?us-ascii?Q?GYiZ7Y0z+EaYdAcW+lDW7UoPafZ237HuD4IUyamCj38eGD9XGBm20pEsIvyw?=
 =?us-ascii?Q?6FDrw8U21IuolpFRZhnrw0LRIZPtuketfooKeGcYloh++j9NRvht2b+6W9hU?=
 =?us-ascii?Q?iLaA/qYFmDikGb1RngQ0A3mU4ux2l76h1d9IpT8uHQhx0H0fhX+TNc1aCpI8?=
 =?us-ascii?Q?nIK961vjnzcM1STNuTa4s1Yh/7gsaw2UR7w6+CSuCGWmvdTAo757/76PsWse?=
 =?us-ascii?Q?acBi+idXVTjQO2xVHKZnarGk1v5Iaq5la2BJzLxsCLaVbUww2lyfoRcw4rot?=
 =?us-ascii?Q?Ym2UwvSjk0m61ZTaD8LkYKMzrzmHlD8Ki5i0MvsapnbidbS+C8DG5BjRKPNd?=
 =?us-ascii?Q?NT1kjGuhOenFmpVOaWVR2Hm+LLf0AAgFIyuRRTdMdcLDPOiIPCuJ8u4dborT?=
 =?us-ascii?Q?nttQWh9bvMc1eXM0FAWTJd9dRedjhtRwLgxl5sp85ZXIfCUaxM/oj/MDgf+2?=
 =?us-ascii?Q?b9eivUCsPqmIutaOrGFQpn+ZwtXCyIALW+gcSxUWhJtLdbSkEJw1c1KNZbc6?=
 =?us-ascii?Q?n8y+xLQUY9xZ0NCQ/i8TnuNjeNxO2IkdlONdUjLSCAp5c0xYbFqnWdCNw+Eo?=
 =?us-ascii?Q?0UN+MKKXf/29cnQbP3kEJ674NkxHVOMba8BrBy2do2tD8ej561u0SezEIYSF?=
 =?us-ascii?Q?FiyvngLWCjmefZKYpb9PqpFvOVNsRb0mPgRObC99Dh86abEiekt+fSZmE4QL?=
 =?us-ascii?Q?+snd7MrR0tepIcS5ArkGpu82MdF59R5op4Lwp1ewJbIc31HAeLpt8MHn4B31?=
 =?us-ascii?Q?6n9HEIqvmJ74FL5nS7SuLuU6WDQeScIYT2rsDS5FAcfcEXo0KiPoONxsg8h1?=
 =?us-ascii?Q?RUsEAZZth1zZyr5nsmyFrKojxaXCO8ip2zLqMBZbql0+npymsAjMydu9Y1TU?=
 =?us-ascii?Q?wZrWR5KPdOUFsdQnVpon2JKDQtPt/OUBGQbp9XgN5Lu6x3giHyRCXbxibV+3?=
 =?us-ascii?Q?TT5vL5c2l+9JQK72GmdNXJgkKhTa31yB5HX/YvJQBO6FGFNu/v5+mMnN47jn?=
 =?us-ascii?Q?+7makVCKu1pdwNIOlVuJBoCg/LEOLbAGnm8nTgOrR4zDar7vvEAGw0gpMHHE?=
 =?us-ascii?Q?OqQSnNcks3mw/Vrkl7Ofm2NE/GxkChn6cip13F8uvBhR200/89kOCF0QLL6W?=
 =?us-ascii?Q?ifHJwrw/FJUwi24F6pQw1J4JfzrlIjSytg6RlYxzlbe4xDftfFDobIeu7dBE?=
 =?us-ascii?Q?ciRUfkBLirSc55lAhDHTpzJAytAC+Rocyfb8W+kmrqsZ7SjWW52u0Mk53/RZ?=
 =?us-ascii?Q?AFrREK5fR5QK2Q2Qhbzh5DoqPtyf/I//YCKwYKel?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c998e18c-44a4-463d-8169-08db8be744e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:41.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFJr1vOw4tBOJtPcmSFurOMmLkX8n/eH3Rp7vVSPu7nAn/A8btiRcHE/8bHx4pp1MkQzMAzoIdm8SSfg+c9hJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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

