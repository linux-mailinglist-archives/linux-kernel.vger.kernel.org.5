Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE794326
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbjIFSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbjIFSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:53 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D266B173B;
        Wed,  6 Sep 2023 11:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP72kGjd226rggbrlsXSapxRUKxt6UbOpsrMv5NYFTYrR3XieE3lDrnsbX+rhkOBq063vV2oDDs8zKg3+OrlqZzgGspEPqsUx7iz8v7gms1cnEo4IWsPr3QAZcsRipfQyvjZ7yJZaylRDibWZrR0Ct/ArvpKsRs0biBZeyJY7plyX8+tcClzSvngWWtEm3QTHe4V8Aml67eqOYIHrfkbcRTMJoh9a48L3KCG8NLV1nHsw6rR470O0MaejmaW5cZzjj9sGjxWoQfIAP7stZ6r8Zd4Wibl6KdLpLQ7BxSN2MtQRi/JBXF3b6o2VGKC0gxsjpARAXSTLqebvl4TkdIYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KwRHgBeI2RfFlpa1CWoeEYlzYH93l6sFLUa1kihgNA=;
 b=lIcYsV0qBIsRTAEbmOlswGAVR9Q6KjtUJ63GoP5Dlr7VM4kgYf2jP0HE9m4ZRAi82TmRiQXNaH9uFdXk8eNQ8jLe290pPYVSbU8CJE/h/lQ6/aQEps19KxMOr25jr+dfxGZqq59JD44MOxZ8ut5aKYi57iDyHFllP7QAC5SOWDrj3FRPSnTiBybsXAOccQIYp3W+t4Xvob5E6FHr0oaxUTKyVHjU2DlYG9RaFF/rtQZndFGI+vRzr+8l7PjDVu1j0WtOU7Ie25Cm3ghh+Vi1VNNJZg7kjjXQRC3rhU6kIMQGg48OfPt6z3zL3kdIqgzuwdLY/yIWAlcBK3HYRIThsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KwRHgBeI2RfFlpa1CWoeEYlzYH93l6sFLUa1kihgNA=;
 b=Mou5g47HNNytPrCuB8Z7Tnfhb8NwCftsGYnK1USPd6MD5msvPNfx43Pb0beM/41aBmAyj4OO2cHGw+D4lwenkdBFMubMDbfXa2Y3TIdywK0DD38bbV1iMWCzSzqfjly0uEbBAbuS5LIJnOxBDPeWjrQ1OTxUW90MYXUEj5MZTCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DU2PR04MB9148.eurprd04.prod.outlook.com (2603:10a6:10:2f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:33:27 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::374:6c14:7fd3:e932]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::374:6c14:7fd3:e932%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:33:27 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: nxp-fspi: reset the FLSHxCR1 registers
Date:   Wed,  6 Sep 2023 13:32:54 -0500
Message-Id: <20230906183254.235847-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DU2PR04MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b06311-1e2b-4904-ebe2-08dbaf07c275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEqT4Xn+m2r9j2Om4fdFknmFldBuBtNIt7sTO8GnGTGvb2jS2VSN1c/MoYlFtINOV5xR/f6ZpsjOpUr1uTflGZMfNWjW6KNw1ll+YWopSpbA6hcA5AOElPQzketWhGFG4EwLxwgGuBbxKJZXoWb7Ce36Yqqd9XjGcbH3T2RPxY5L6aosQ9lNqtVvIbicsvzwE/MrsCZWq+34k37mnmVJkZH1a/CfyT0cZiMxvxEgMgSZhkXbltE1PrQq5nZ7CzGZ3a0//5B6g28pKrxYwWvBzP087hsGdM2Mpg2IgVXuJHP2SbvYNDbI5YOjCz6R+dkWte4640oD57nORzWrkVquOy+tFw4mwmikeWzIFkvg8p7rXQj22Kug/t+m7bXUsRRshFg1Two2UDotcY5z58BnzTr8zfkdo0xliFU6frdPOtb2HbTKSbJmw63O27kF/q9Ax6ol2lTqgLhnavwUXUMLws1ZP9IR+m6YomZ4Ks6JhMReslrR+bU5zVdwjmFv7WYI3LJ3KHfKOo1a4wstYGHlHOyBUxosL4D0daJ/ucibhVUE6w68EFqf+TD3X+GtXni/RTiA8KBjpdD06gZBKX98E45TGLYbf9T1RPn2MfXz8z4F082y0NrZ7Ohki9wzJBet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199024)(186009)(1800799009)(6506007)(6486002)(6666004)(52116002)(6512007)(478600001)(110136005)(2906002)(26005)(2616005)(1076003)(66556008)(41300700001)(44832011)(66476007)(316002)(8676002)(66946007)(4326008)(5660300002)(8936002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?be4CTWYP7dJ0dAmB7zPXSTeC4VmRNxov7Spyvf05BRUCkQzuMQFuPH0cSwwF?=
 =?us-ascii?Q?sfKDv/uejGbfrxwqIjspFcbMB1udqWY4KSGW5sV2sOQ0Wzc+Pod/HBMEwchn?=
 =?us-ascii?Q?tqAqsHKv1wYgYrQPPoSfLzA3yy1S9BFw432sCLoRpQXSQhgGUabpXh8JQXD2?=
 =?us-ascii?Q?PyCOa5X9PnbHQvKHjR6wSiM2R3CpzXyqo6zRKhiDidqpwMshFPwR7c/ZGOWK?=
 =?us-ascii?Q?yNjRHPBRq0xK5ng6IdnXrramg6/Ct7dKpanw+LhrZdmT5ozp3OAhI9DwtCPg?=
 =?us-ascii?Q?hMt8Co2qu2TrAJPYF0dzmMya8uYE3KYEKPGD0aJAGTLapeP9wIF/0K/rrDSo?=
 =?us-ascii?Q?eOlVrmNUGc7XY9fckBoUu46J5AnzAFfcctzwlPdlSTe3ZCVUKRiE6dO7tg/r?=
 =?us-ascii?Q?2imOO1BaqlpHJbluSiY6xxZaYNMXBR4Zthp1GLGIPCFCM5tHhdNYDgNIOeNg?=
 =?us-ascii?Q?R62qnjzlgVMr7p6VGFqBkpi2JpaSSSIm+v3uBe+Pjn5USJkolDsL9q11ry9K?=
 =?us-ascii?Q?9GUNvOFe9zAMwqpQIb4wjQZ3Hb6oWigSJS6hnDFrlkxH4+COGE1apYmlEofh?=
 =?us-ascii?Q?E/tZv79xcgB5iMoi/3j8P1sjZxN9mTmFVeTA2gM/xNv+MO5wCyWQU1Fx23f/?=
 =?us-ascii?Q?QaLjb6Namccq0QHDi6z8VhIOCjvUJbCNdNqNJ+8DryV/sv5Ub+SRPzI5yqNF?=
 =?us-ascii?Q?009LeKsTHI/D9Sc1YY9kRzFfkhTgTAFD25+sQK4EhFzdVLHWs2UA+kaON3V/?=
 =?us-ascii?Q?Ju6wwEpXWgxA3EvAesJSUYZbX0V4rtrVOiLgTk8TCaOoVR8TcLK0f+t1KGpE?=
 =?us-ascii?Q?6U0SPJKu3Hrl6Jk+F4E5Aw1LPKM7OBeEwa2Bwj+3lUv0e2u08Fmx0MMc37bi?=
 =?us-ascii?Q?oL/rkrZNFPA4c+MpDy/RbaNbYo1GIV/ZX9KC99U2LfaW1NLaJ7BvoBleLRVP?=
 =?us-ascii?Q?tKES25chvrTj3r7x+VYWvqh6LPfY/BMNUlVKBgStnJv1v/n7FpxVNsLvPd1f?=
 =?us-ascii?Q?dOIGPkWFKWkvdV7W4UhNYZua8/oIpvzLa3tmU5LvPiaPHo+n6peKpIBuKr5p?=
 =?us-ascii?Q?YvwAnxXHMkJGvfNX/m5UgCh1c5pZB/Q+uLrk4yV/oqPXVy3ZCRalSLL7HGuD?=
 =?us-ascii?Q?IPF+/FNhx6UdHLBn6vJ2/BPb+GR2rbMhHJriauFiLBr8zHdYplpgf4oNyekI?=
 =?us-ascii?Q?jvnbK2h+0i9Doq/g+gLkR9w85uQkyDUQoksLFZ9KkRMDy7DixpLfrceiDeGR?=
 =?us-ascii?Q?r2xPJ24660s1qxzJROjMxxNRSYkLIKfY0xWkI41FvP9HV6J7LBB7MpB/izfX?=
 =?us-ascii?Q?JvV3Iz8NdAWs/5/9rr1lhfd1FcPERpXBrBl3ZBLr9p8tvES7l7s0zk0XTUZO?=
 =?us-ascii?Q?mSKmdtqUKunwdUlIEDQHMnqyoG/OAiaOPAltH1bl1DcKXr0qmPofLeTab4GY?=
 =?us-ascii?Q?hPplT/xovC7KyLnoupGwbzLNcPXoKb1FHWL55dbYSSPspWvpqdE+ol5NlZl2?=
 =?us-ascii?Q?zAvaJh3NfLs2kvj1ayHmneozgwzUq3OD6CrG4kHsrsbPmG1y2VmfA6PSm12S?=
 =?us-ascii?Q?8phhkgXsIWYpabqKsuw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b06311-1e2b-4904-ebe2-08dbaf07c275
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:33:26.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqEfzzsTGcNJ3TSW02SqXaW5dcKptR8DsLisPEdqeZEqtzSPofzQUbhKGR+T3VPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the FLSHxCR1 registers to default value. ROM may set the register
value and it affects the SPI NAND normal functions.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 45a4acc95661..c964f41dcc42 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1084,6 +1084,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		 base + FSPI_AHBCR);
 
+	/* Reset the FLSHxCR1 registers. */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-- 
2.34.1

