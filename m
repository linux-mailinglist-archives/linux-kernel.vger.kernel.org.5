Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120DB75F98A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGXONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGXOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E21E54;
        Mon, 24 Jul 2023 07:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFV3VMG7iwFzoac7IqrYeDw4VV8ndXElFBx/zLJxxK2W4Nnui3iSoR0Kz92ju6q95zlFg5VuGPQHtRf9kBLvwzy1KgRG1jux/aQXBMPvCnWTBHFML8fjG92ngF7RvzH093tLLjEWlK30ZpdAMGWa5KLmNamU/0QyHF5pbdDaHedV6fNfSUzqK7kcYBL52nYexU2Cyv/KGJPNG/S73wAAxkVhPZM9eH1pOGYInGIvKUl47RuAFJtjBWvvSzcHBEf4h8bvdlW50SHr8pEIXdj+tmyrcRAxsYF5N7Z4xVmj1QdKqj4dAusksnQDiAyyQrq5VCqg25LxiJrG05zBg9OVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=Jc1XoqGFXzHXmzs7PUVC4dOoUft5xSYA18b8fe5p01e1zMjGhAxyCJz+Nkd9qWL9pXOn2qgoLBVZwOmE8SS+ZmH/mNXqQmIJnwV5IOAV+pFhF1bXRVLCz8D2vKPcecuYR4KBOoaV7xflWAQNwZ/bnznJ1Lv2LjufvSSVI1TaCGZo+a4YjXI3viM7o/rVP4B+wxQDDYZtFC/JJ4v+EL3sm7/K29GhwDuskGqfS7E83TuHnULJ+j/X4OVn7pk3nvGrspE2e9kYert4yD8yimS45gNhuVQrIQ7V2mVhsxIhTOyiO3A78dsmAY8S22sUYJDExaA+0H1IYcT4LcbmLQVMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=WsEYbP3MH4BGAHjZA5+UqJhtH61s35eB2fPVnwwFmlS90KMV9RE7iB95Z9gH0SZdMTJQHDN0mOm/xc31f/wLrlYdNkXGoIsDNIGyLwRfnXzWde1mKwiLImrMw1pzMowpoY02tFOZNAcq/F8Lmjkx/a5jtncWxaWxziEXamarO4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 14:12:45 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:45 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 01/11] net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
Date:   Mon, 24 Jul 2023 17:12:22 +0300
Message-Id: <20230724141232.233101-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf3b0c7-819b-4f38-b136-08db8c500d39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3c0XV17Zj5OslTygIMyJ7D2YsZyr1lVSI2VGDBSrq7P9u+DLiGKhica+dnpeuslLfMBmcUMsdba/QIzrpFgyNpMq6j6d3AGP7SnStc+9qM5+bzXJC6icPRcEQEoo1EIl7LlsHsrMuyiasjQT3Z3sVPPC0l3t/M0JC+lB0uIT7o4bbV1mwXV7MeEeHdNmK5thlG783mEnl79a8oHwelizK2hu1HPz9quSLSBqNo1PF2ecb2YjT3tsiGENZ3LqP3T78JvHU2i4v0BV3dmF1cCuEG0doaBTFWVyU4rbYVwK4KfjhKrJHyTeS8chYgA2EuomXc9oOa+k1bmFcTDM9f36UfNM6d301lMRheKPGDeel8mYm2F1L2wpzPdigV3MNCKd4JRaUQF+9X5gDFYjA6P+DHCwTkRWJtGBVgcDb6JRBnvYnLt5PeC7g6LW2ad+idG1bp0b8FSeyobHcqlqtrFvozJ7Cmqha2WVl7pWbKH6lSuxmUg+a82iKbPyPFLUeY1aNyeORsXvdvcy29izirZ04LYnX3EzLTWMJNkucf4em5TzqBPqvzJUAxi+5FmhO/WWxBTWjws1gQ4Q23e1FvIctUl0yzTDqOt/xFV4tdiBASasdxVjMfKsfTHO1nbzWIC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(52116002)(6486002)(6512007)(478600001)(6666004)(83380400001)(86362001)(2906002)(186003)(2616005)(26005)(6506007)(1076003)(38350700002)(38100700002)(66946007)(66556008)(4326008)(66476007)(316002)(41300700001)(5660300002)(8676002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2I3x7PcNbfkpSFwnzNeEQzYFIGiaLAae71Xr0eRqNQ02ycG97S9FdDgNlfc?=
 =?us-ascii?Q?QT3CxH6eQVcMHyYnuYvAH2KO0k9HMN1PhXRc/nEvhvzZnGxHO8yEnzIFoHzk?=
 =?us-ascii?Q?ymJSh8moP22xUFGPGE7Oz6u16Gp/kEeVSfkdhGgrZby4wqlE7jxBpzFOnjTv?=
 =?us-ascii?Q?oUBPdb08sZgC2rCqSTWPiSamuedG74EAELdfJe2B3qsmpOu2Ij6epHl9PDgG?=
 =?us-ascii?Q?l4idS+NsgIa+ujypbS6htHOhX6UsqirnfnRQxFqshAZSuzEImscBVkv+AOXW?=
 =?us-ascii?Q?JVeUppg3PHYZ1Nell82wvaVeO/mfmUwJx7TPJ9T5APmB63m/Zqpf38IPQ46Z?=
 =?us-ascii?Q?dvviaZqP7eFLkGqYMnTyawzgK6H7ZQrQf8YIgbuGYXlH2aDLK89vXqTxqJet?=
 =?us-ascii?Q?s3d2Y7BtKaEjcxi/r7U9XUKolQEMY/vc4NStop/BZCAAviBF0p7AzSSMEpJY?=
 =?us-ascii?Q?3JX0TzvBlVbLUWJMPCRaM62xNMUI7fFGfHUvndJuj2UuncSgl1lpXpaXASPT?=
 =?us-ascii?Q?e+1IJsiVUrQqp1wrzSev5fgJXjcJvPrMdj0wX+Oh6kGkL2hgJNvfflCfqi2+?=
 =?us-ascii?Q?E1pl13ZuXIlJmBOZAG2GOVTA/cIC38thxX0mt8/Kk8k6fx4U/mRWkfwv2yWF?=
 =?us-ascii?Q?nWE9BH6twBnrlz8yRULEHoW2bFzv5FnNlzD1Xd48g6DIB2kg/rcI7KB1mWo7?=
 =?us-ascii?Q?Q6E7S6bfMgtQSGSPwz2O8UVOgQOWh1z8wQi5SBK+3iONBHTHITNOFLLEWB5Q?=
 =?us-ascii?Q?SoH7d/xG0CLemyua3A/0E58y/4gVxsZCWV283gzpA8MD88IABohF1XTGae9C?=
 =?us-ascii?Q?y9pyacbHAPi37CPqMKq+qAr041DCirJFI6O4bo5AudHwPF06/4nVYXklABGJ?=
 =?us-ascii?Q?XmNcW+EzjZNKV8vttVCqf5v8Ey5yfLaeocHAMmkP/WIPjAH9si/e36t1+fxb?=
 =?us-ascii?Q?rHgPz5lXIr3iaMpYixbzS/wc22+UTQ7o8e2Q9vg8Ygzpy6XLQ2kOZdJM3ueU?=
 =?us-ascii?Q?S6IbDqvMGikyKOXA2jbg/658diiUTq4OJ8F1AtzGSFxGISIEio9RJ6cQf8+h?=
 =?us-ascii?Q?gZhPhlbRDIfglaGRsgIRJBspMLOPi4tA9HYrO+LG7nKpzcKaZxY24gy57nM3?=
 =?us-ascii?Q?JBM0heC66f0342IudKgubcCprHuRKtKHKkgyC8L5SZLPq0iYLRRZcP16sMn+?=
 =?us-ascii?Q?8mmzoXqz+ue9MbbiUFrqfP3uRJaHnLhFHda/QvTQWieu0ne++93KflUxqBi9?=
 =?us-ascii?Q?zBHbqMq5G3a01KBFn/GDbKgJq6lNSDMLWd/PY06Lkwtx+u713h/bmNu8MC1k?=
 =?us-ascii?Q?96W7cmqrrh8UvTOJTmRdvoIAo9wV3WoZ2L2JVVH0UTUzfxY3XTRrkoXq+gcb?=
 =?us-ascii?Q?It8j7YHyUGq4hURvvtPNmlaMrn1Lx9bUbaq6EmL+XpxRc+sATOs1eT8nK1SC?=
 =?us-ascii?Q?bdYbMi0aU1h84T/LgNg4NFyJf4ZUyc6/8mpP6S5D0kMGbSDm3Bu/1Ax3H+Yw?=
 =?us-ascii?Q?Pp/BzKQvmIDMwEJUxf1Q1i1/iIRUUCVnryfM2wDepr/j27Dgf6q7s0OVVCke?=
 =?us-ascii?Q?C+mHDwpL2WUXPkaUscAv3K56NN+PjNVQHrm3NlVEL9fwceDfE4OPrhs2ynjx?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf3b0c7-819b-4f38-b136-08db8c500d39
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:45.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkKFDxL3/6KP6O8p5iCXxvx6uM1kkRgYCcgnr0Rq1TxHnQRKGojbfeLPo2s3cE05RZKuKqdFZIF4qA87vKtaKAAczwl3T4r31f0La0uq+Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

