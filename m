Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1195576916D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGaJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGaJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:18:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67A10F2;
        Mon, 31 Jul 2023 02:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4x3PRBFu1JM367dpLyFlKtJlJD90o808aix6aNjfYkGsXtQJmDAp1v3VbIa/7NnGrmf6a9q9iVRT2v3Sqw05PHdyUOgd4+f9mVOdc8ma/WnvUQFH5dOJDfK7SmNQ14ajjCpiERaDlRq0meSDAHZ5imF5U29jdlZTKITjZXqYYXFqA9USvMCWY0xI5Nas2AZ8Vyu7JfthKacSVag8reP8U4KdVzmROMVZrrtueWC0Ig840j778rjUPeulGWeo5CcAEfxn6MwGMYtieHcFG2Mh1kycoJOBrkE7HYvCwmibj0KxrrDT0RWWvt3z59bZSVhnG7ku+Y1VcdHGGPuJMEW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SSvGfdvgxmU5a1fmlz7mWdNPdFnHZddz5c+DkLDpJ4=;
 b=iU2iKQWrjqJZcrdmSjDe+fkZfA0mD1waEwZhh+GZyok/IiS6jplWVwa+MWEhb4BexAzxVB3j/wNqqJZ5dU+5O6cOCRFS6w7rvMCRqso9j7kZTHfBZCiHOZ+Pg5yQyocy8u/flfMusqJBqvBF10mbGm7eToOOomspuxGfb6oji8D+ckLi5ElcRTxWOMfGp8SRLYO9OrAqxq4IgmCvgwdggwJNcrUmm9rJIPq3s0Pt14JEyxctP6DnmWVkNDxOZpg4LabZTjVM5Ja3+uWpyloniF2dB/Xh5BeU6TZzJwO/7h4ds96DmmoRj9e0PBdePdOU/4pDqh8CW6Q4eua9NZ0H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SSvGfdvgxmU5a1fmlz7mWdNPdFnHZddz5c+DkLDpJ4=;
 b=Evv2jL17Gv4Ih1E1XVGQvs9RTzldPEpVcMhsYGT04rg1O1/+w0atprh20b1sJrM9/vu6PSdl4gzisy7jy3e3Nr/8pmCypGf/fsOYEm7mg43IPJCaqa+g5Qxq7+U1MLUKo/X/lULm24zmlV+H9cqI9k8gcSmYQOBR9E4FCF65klQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:47 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:47 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 11/11] net: phy: nxp-c45-tja11xx: reset PCS if the link goes down
Date:   Mon, 31 Jul 2023 12:16:19 +0300
Message-Id: <20230731091619.77961-12-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fae117-03c1-4cf5-eda3-08db91a6dd7f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6/tJTYtxxOjcmHjmEx5bOIblW/QgQ8VV+D5//rRV4rnefu8+eAuiO4tDdnyM4iyMLNLbfCQEAE7+vxydKSfgFgaWL7b1bXQWpfGyxSeFXpCIM2F5pB5IS/hwmZWHQ1BlGCQcbcKfQhq81MCsGrJEelbwX5eD6bc4HGetgknjXa/1YNLi3O6PVIIyqM/oAg/9CR78sOoUL60+c6FlVWIEC14c9eXBFnxLieIGrSidamGALI8Y1VbqgZ6bYO8NOjcuvFafpk2QMoORwm+UNFaJx0/DHlSMqBp/nGCSr3upGcDGy4Re0Pz9fBAFbRhsglYhl2GotrwlLRKcRFFtknQImyg0mf0+EQrbwVmh/ta/sckVcbJP0CMK68vpc2b76nAAK/QAD4TkpluEwh6AJQ2qfuTz9o5RAvGXwW99PS3fAa6g+/1yPpmSBfsA97SystZlgUWyUdrnq2zq8NOCAn1z96SFOu6vo9yFa9G9g7+Yr4hrO2W9qaNxmXjmE3cwvFTMPsJAvwvbBi48XnV3mTEerr5mAs0z58ofTdK52YK6LU4uHeKzTCywaiIfLVxM7LbntgeeisrBu+C8a3lFcgQjf6P4qBx40f/mKXjRHanq1OsoLzen/ccxzHKW6/czsd5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+p7I7aw+Uk+4/LX/ysV88ZNKfGxb8bB//t7i64CeSH/lkTDgXCIjp7C9a22l?=
 =?us-ascii?Q?+aSjbItUZya3BRrazlJ8Q4cJpgUZ+/BOhGvAUc9RdsgH3XoIGRFMqZyMfaww?=
 =?us-ascii?Q?kynF0LuMe5aaBDFc8O7sYMCch7hzTJS/LbQcf6Uc5ihKoB2pys1w9eMq6lB0?=
 =?us-ascii?Q?g4NsLYTSqrjbr3RXCboxRCQh2oDa+W4jDTD/7kC5PIM6MAhk8geWLc2CcpTC?=
 =?us-ascii?Q?n0ga0Oskl2YTkC/T/rNZmIx3Kn9a6HFHCPL5KKXb8itBiHnoZP6jen6Bh6nn?=
 =?us-ascii?Q?6vjuMEAM9ZwJOayCyJSagr9h7qLw/DS49wu7BtLM2dv3EaHOHEew+WQSkiKx?=
 =?us-ascii?Q?JG5Qddl5xqgs+myXGOMfxuAeuRvLA7ehi7xoW3bLB+I3xXCdNg7kJYDAr6Z3?=
 =?us-ascii?Q?c6kHj2WqPU190zcfbhWNCdlEUPhLE9ITfRrP575JlWBFxIf4rBGV+qQ++Vhp?=
 =?us-ascii?Q?ZoISY9G95Y3EpdWOQEHgG8FTuI27bZyVywDSuJBryS+gCyxjutLaTrM4dFTL?=
 =?us-ascii?Q?MP0cP9INI/Fbg/bw9snZNq6YZPmdy2hi29d8OHUl+oxUtdQMrBFNLfHqmhW5?=
 =?us-ascii?Q?+2Z32J8Y/oTW7Z1hm9Ppc7pEhTpD/dTkgztuOD7oShAlcPvMufKZJFSwok1w?=
 =?us-ascii?Q?LYuc31gAW1fJMUNwqy3smzZqBK1PAiXnpdwgK1Ifa0nUTT0cR27DTiqNh0Oi?=
 =?us-ascii?Q?E+4LfJ2bqnf6yXQecjr1Pavv+ogt7bb2nUlkOvQ/dd/ZPZMwyTaysa6YBAvh?=
 =?us-ascii?Q?hev+HxTs/d774P6jtA/SMGA1Y0hun1G1ityIITvRAzokSE3rmbzOLWW2qBJs?=
 =?us-ascii?Q?4w7bv2lX3+8ANO+/n1e+cHX3/h6k4Mh0NGCWTqB3MYwhfNeuyBn5I6khVWvW?=
 =?us-ascii?Q?ilS/rQazPztBq3+ifNWhqMRBbKmwKT3YvmyKTKvL8xLzw/zBTMXBDQN04Qby?=
 =?us-ascii?Q?7VEuAjqv4gMHvY/F2Oov/1Amv4lums7dFhrEvgxR2CqQKkSATv9rvQtCY/yr?=
 =?us-ascii?Q?R8W8kAXmKnpCEOnycNAy3ykNn1Ep13rRC9J5EvgnKq2VNH91iL5DK++aet2q?=
 =?us-ascii?Q?LxSwXELO54VP9iC8Zr9Za1XEYMOpz6C4UpC8FovuI6YJlwsjpJBl+d0yN/TZ?=
 =?us-ascii?Q?zJeiYHBUH8g28z7gU2IaYqsfU8lUZiKWs99Duc8d1+SBTm5nKWeD6gveGAiP?=
 =?us-ascii?Q?TlXpZiqPS0RPXfnJwstUmRz8kTZDKY6h88CV/uAoU40w1d/zOX1lo6IMh766?=
 =?us-ascii?Q?SEG4nymBDB0qX00jmWxspB+9Rw5OHDSLGb/J2n6yoDUQk9Am5zoWfIIEcpp7?=
 =?us-ascii?Q?HPIRYI635Ou0pUm8gkiEz7S21PPy1GtiuRRiFuMA1yBfA10gUGH97gaFJrcf?=
 =?us-ascii?Q?g7aOOacyx8GmyPjNInT8mjcyEzN+nhSv4I+T/BhQdvsFrX1bUG3+qvarGUW/?=
 =?us-ascii?Q?gkSxun7509yzTL411XSzEnPzDGRbS8FZpv8ULLE4mdXVQsXNCdgnl2MsqYst?=
 =?us-ascii?Q?pT0HLmh732hXh2ftviNWIEhiAIDfI629ZCBMaPpL4f0zkf0EpNzr+nk/nE/D?=
 =?us-ascii?Q?8KXePUO3BHfeznR2T8Lqi/hTCUZE9WOC28afijf/m8fqdsf3G6llZZHu3SU9?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fae117-03c1-4cf5-eda3-08db91a6dd7f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:47.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKuImiAjMnOSP8h9Hgg+lzh6Z7oqhQ4r5Jt2643ZtvaCuJTP/3FzO/pMO/h7Wjl1+V52lybP7Sh6ZV8wdiqr1I7AWwBqF013sy+jMBiXqYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PTP testing on early TJA1120 engineering samples I observed that
if the link is lost and recovered, the tx timestamps will be randomly
lost. To avoid this HW issue, the PCS should be reset.

Resetting the PCS will break the link and we should reset the PCS on
LINK UP -> LINK DOWN transition, otherwise we will trigger and infinite
loop of LINK UP -> LINK DOWN events.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 48657307ffb5..7ab080ff02df 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -56,6 +56,9 @@
 #define VEND1_PHY_CONFIG		0x8108
 #define PHY_CONFIG_AUTO			BIT(0)
 
+#define TJA1120_EPHY_RESETS		0x810A
+#define EPHY_PCS_RESET			BIT(3)
+
 #define VEND1_SIGNAL_QUALITY		0x8320
 #define SQI_VALID			BIT(14)
 #define SQI_MASK			GENMASK(2, 0)
@@ -1371,6 +1374,19 @@ static int nxp_c45_get_sqi(struct phy_device *phydev)
 	return reg;
 }
 
+static void tja1120_link_change_notify(struct phy_device *phydev)
+{
+	/* Bug workaround for TJA1120 enegineering samples: fix egress
+	 * timestamps lost after link recovery.
+	 */
+	if (phydev->state == PHY_NOLINK) {
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   TJA1120_EPHY_RESETS, EPHY_PCS_RESET);
+	}
+}
+
 static int nxp_c45_get_sqi_max(struct phy_device *phydev)
 {
 	return MAX_SQI;
@@ -1932,6 +1948,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
+		.link_change_notify	= tja1120_link_change_notify,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

