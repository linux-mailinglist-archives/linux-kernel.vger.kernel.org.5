Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F5A769149
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGaJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGaJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B46F3;
        Mon, 31 Jul 2023 02:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwHZOAnB3i3DWqNvqHmaxt6wuFVZMlkM6aatYCTqPcOk3L6QXAnQiTA86iesivqRCfh3nSZbmn17oLjfNflpMBLeCvMIIYuvlf48Dp/a1ZTTrxNXPYcDBkwn12hLj8yseY+DlTcojzEp+e68p4/s187V4NOMU/0RRy3z3LdRJVJNsukvRPq19hvT/a3Ytf0LT5+Y48m3GXmgV1hVYOaiZaLEBctS0l4G5dyqLB5Q6SntXppNwsxs+Bg/nddk7lF1lnfJZodeps8SWWWLsnHhhjWWxdXCAeDKwwcuruBsTh2Bp06OSp2r9vZRES3oqJHvIeLmSGt2itgwkL6ZU/YFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=hJCotG9sc5dNmw7cvWNkhvOVe9jODw/FCGp6+NSfoIATQ0bDhKDXEZ+39oMwchWYLAGQ9SI0HZ/0vN/nY1HhEeAhs2Mfj34siqq7axmtmIiMGFpwB0IhqSLIUszs5595T/NFwhi9wfStNuYgCuV85fxdwIxsz8bSerScqu7nYAWJfWmO8RlCtON+ub1024nC31bwLCDgs8oTDdWt2hvR1PXd8dy5s3uNaXe9lz2Zsb0ltjD6G/fF/pdP40g0Ts7BFrkg/kArOx8oJnx/E/wve2rZt7KQhD4bmZdTGv0v+R6GAFPkE/2mXunbO83GV+QDVIP2ofDEfuoX2IKOzZ3Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=KAiNfXx3yxOE5UOICHIERecj6S2CaJCt36qVTgOHw6WOG5RlJu9dK9GxNpzzinqJ/Wr67zbcqmJymbnvK2idQbIwkVN4xjv2sKtwKYuEfXCubbQdrQVYAf63IhZm7XSuqW+YfDfOhgI2gMekaOVM9Lzgz1qluK6SnqG/3oCc5tM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:38 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:38 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 01/11] net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
Date:   Mon, 31 Jul 2023 12:16:09 +0300
Message-Id: <20230731091619.77961-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cf0ac0-9ef0-4aeb-f77d-08db91a6d816
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXe9MI48lBIK2NwYjTjOVeYE3bq4nkUL8VEjIOMo2j9oxgCRflA6qJjvLG7D0E3hTjZqEw2x6SRmqtJ1TilU5lwqObfBEaj5IlDq5HbtGLuhHX+PzRjlTFAGFogW88JnH227GrvO72+aItuqmgUxYUqbtCA7b07nR1PCfpDQSoScRR3Lkf/QwCYkUVq2jjtOOxw5Au2E8TlU+QAoqlC2zpeaJK0FF+JLUqGT887DcC6R9ZbxdIlnfhuKGC4rA7WMh2m0vCwZPUnJBaw9WyGssUyqf/eT7/h1VbMVYoo+KxDfL7HhPo3Fcx/kj3OgVkf5q/+k6z9CV9EmlLi3eF0U3NiMZTJwreexJMQee0saOcX2hZnl0SosnDPVA0M6D2cLRzZHayo0OaXCFvZoe42DgeyV05VVD2sszHkG2fmmeO6auWkgvL9aw4xSrNXSuGBxtIWLd53MDJRfllPumuj/r1F7K4bzYlS0u3bVwE/jnEp4i+Lej3nnwBKMRwRg1kWKbqVoA62mGWbH1BXRDempx2J6tmJ6ZVJOJ7os/90QVLXfdCMwW2MfjZR2XBK5NUcjrVPPuqpGgiInhtQjIvir5vHTwIrn2Ub/VroS7G11GgZx3q8MGJzDyu9ZJRMS4zZs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxgZQqr/YU6AviQd1HeYRNNBfn3h0jQg1OQ+OBJ8M6S/AAzJ30k7qjOLrJIZ?=
 =?us-ascii?Q?+F0UXmjuOKAAv/g4Ar+AvredGDSpr+7X8/3cL5JTZhhs0TI1hkz9O+Xj398H?=
 =?us-ascii?Q?tyLwH9WI3NFMFmM4VyizygY8jBiexfUNIoPE7E46e/gaeGPbh4axPz6uKYzh?=
 =?us-ascii?Q?aEtVmgd8a3T2xXl061lGaget0pFRg+RlLcn7F/WEmQdZwEupQFwO49gRdUV/?=
 =?us-ascii?Q?fGng3iVK4sJaiVPfjCsz9ghzfPTu/gTpM6Cko1uRA6NBSHYVnnIDtnuo7lKl?=
 =?us-ascii?Q?y8GsAZQgBPu2fdXrev7TBst84Mwyfo9eiyYYYdii6y7WFrIJuHUuikHNI9+B?=
 =?us-ascii?Q?7/rQV0cUyeGuqQUbmM5sdefvU/JWVjNg7fhFeqx8poAe8KlkeLPd0icI8dwx?=
 =?us-ascii?Q?5b1evYS1ebzbRPYoqSnr0NETEuPDNmOxOK1IUaPvUcDLN9zQ0XEpoc3uMAn8?=
 =?us-ascii?Q?J6+ifdSnudGKOW39W+4DA/bN98p5lLBw+zbZnvEQrKb2hbq7za+wiMUrgKZI?=
 =?us-ascii?Q?54jfN67Bs/n6VsrLkHEw4g3WXAw50Y799mVbI20UNAxoMDGjJr6sLxvFAYcK?=
 =?us-ascii?Q?q9MYedO4hyLF125f4eZmRKX5aUHtcAiRRFvtNiGPO/FQYa7iA/a0+SMiKo0r?=
 =?us-ascii?Q?A7BVEOquZynXAoBAisIFNfpF41+PG5q4Nw9ozQJn9TMlIfOhlhSG48iHz9D0?=
 =?us-ascii?Q?aIscpLEyFVcJY3V2Ba160JAB9QIYyGjvi5ij2ifh+zYKIwYqkWjPzpeVLJOM?=
 =?us-ascii?Q?B0wx9QBxikQlbDOGoKF09HsYWg5pRJJ54VowQd/ol/3cQ+2mk+9PCYYcfdAs?=
 =?us-ascii?Q?I/ivZPndgWAGLrwNTFj6fRRxdr3UV+8hM4GfmmXE84Bh1fq+MfjPDIlJPM8Z?=
 =?us-ascii?Q?ctaD6RdSuxfdCJpxHIF8HwwOzr4w2DNXOrOraljTJm0sxW1xI3HKFa2gbaQK?=
 =?us-ascii?Q?8tdi3WTQ4ysSVpto9AfiKWzcgpBWeuWXNCR0FNInpFfpKRU779uCNk9I+x0P?=
 =?us-ascii?Q?2hmnCZ6LUptDMzGsOu2uuk9JNieKrY2Tgqqvf0oj7Km5C/9weg7tfpqajflo?=
 =?us-ascii?Q?mt9TnIWvc0Pq5PH3URWkxEuZ2MFUUljWgKk9OlbcaX/StIUhc/I0v3Wwb8IC?=
 =?us-ascii?Q?vAdsJFKX++vq9a53ZnvxOiDW9V47BFH/D+YX4YnvNa2WcNe9qHDTU9lRk93W?=
 =?us-ascii?Q?bVkluYRt/otoZXcQlbsm3wkYw07IpUwahlZspXhBSnhJAo1ETkyNxkhXLv9v?=
 =?us-ascii?Q?S9Kbd/M8eXc3nLXbqvSZFhRmgqQZTpnTkcHjq4LffRJA1fHHZKZ00dJOHGdM?=
 =?us-ascii?Q?mahpO8LOyP8uFsubrl7zO35CED1HMuhxYvCaipBxkwxwUGNTbwfAUSDCOno4?=
 =?us-ascii?Q?YNrH7dcpKJOFlbqne9LvcpjiYLATApJCBW+mSzIac/9jp1OYp42sTTtleAt0?=
 =?us-ascii?Q?5Ac1j4kQHK+hQFDLOzCKiENRjNidQU3qtccJ0WXEqZanhLuD1tgTcN2lA0FW?=
 =?us-ascii?Q?6QfSPogyAjQzQ531um8ifuafIiUFogaP4vMKvXRxbyQkLNcAk2bIl2hYh12J?=
 =?us-ascii?Q?IUEmBck2CZ02HHbCk4FTSJsGnWlJ3ULdQG0U9Pel2W7EachouX7bqcz4dp80?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf0ac0-9ef0-4aeb-f77d-08db91a6d816
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:38.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SCGph4aWMX8bC97HFp/cJAAJetA8xOrL+myEe27/HkCFrr1mXiLZ6ZB6JHO8mq7bKOoxJtLUST9W7p46j/NyyrQ3F5mLuKE0rNk3mi+lkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the custom implementation of master/save setup and read status
and use genphy_c45_config_aneg and genphy_c45_read_status since phylib
has support for master/slave setup and master/slave status.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 77 +------------------------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 029875a59ff8..41b8af0547e4 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -19,13 +19,6 @@
 
 #define PHY_ID_TJA_1103			0x001BB010
 
-#define PMAPMD_B100T1_PMAPMD_CTL	0x0834
-#define B100T1_PMAPMD_CONFIG_EN		BIT(15)
-#define B100T1_PMAPMD_MASTER		BIT(14)
-#define MASTER_MODE			(B100T1_PMAPMD_CONFIG_EN | \
-					 B100T1_PMAPMD_MASTER)
-#define SLAVE_MODE			(B100T1_PMAPMD_CONFIG_EN)
-
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -988,72 +981,6 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 	return nxp_c45_start_op(phydev);
 }
 
-static int nxp_c45_setup_master_slave(struct phy_device *phydev)
-{
-	switch (phydev->master_slave_set) {
-	case MASTER_SLAVE_CFG_MASTER_FORCE:
-	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
-		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL,
-			      MASTER_MODE);
-		break;
-	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
-	case MASTER_SLAVE_CFG_SLAVE_FORCE:
-		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL,
-			      SLAVE_MODE);
-		break;
-	case MASTER_SLAVE_CFG_UNKNOWN:
-	case MASTER_SLAVE_CFG_UNSUPPORTED:
-		return 0;
-	default:
-		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static int nxp_c45_read_master_slave(struct phy_device *phydev)
-{
-	int reg;
-
-	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
-	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
-
-	reg = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL);
-	if (reg < 0)
-		return reg;
-
-	if (reg & B100T1_PMAPMD_MASTER) {
-		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
-		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
-	} else {
-		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
-		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
-	}
-
-	return 0;
-}
-
-static int nxp_c45_config_aneg(struct phy_device *phydev)
-{
-	return nxp_c45_setup_master_slave(phydev);
-}
-
-static int nxp_c45_read_status(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_read_status(phydev);
-	if (ret)
-		return ret;
-
-	ret = nxp_c45_read_master_slave(phydev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int nxp_c45_get_sqi(struct phy_device *phydev)
 {
 	int reg;
@@ -1355,11 +1282,11 @@ static struct phy_driver nxp_c45_driver[] = {
 		.features		= PHY_BASIC_T1_FEATURES,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-		.config_aneg		= nxp_c45_config_aneg,
+		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
 		.config_intr		= nxp_c45_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
-		.read_status		= nxp_c45_read_status,
+		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

