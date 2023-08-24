Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E46786B59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjHXJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjHXJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:58 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4610E67;
        Thu, 24 Aug 2023 02:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwUYuYyrStB2ReSqRbhgCS/Fhw3UVxjufjANXAK4ctsc1Xa2M5oai8//LsbBUv4jQIDApT21JQaVobgr/u0xVZrqQmgZONjSgkpF8eH5yJr8zupljtQT9ooHRU1k6ENz1RMaKilSHOknWcnOphZ5+u/cgClwQPhcOT+f2+5NoOhR98QG2sdPHD4xLj7a+BdRuRG5qhzRB/3TCbhefISe5Wl9dXNBrLAvg9NKRETZ8J9Y/L8ofWhzE5xXK0KlovLS+UIBrnqGUXqnzgkafOP2UkYJf8suphBKRf8ZsF4r1VRGnVLENvUVmn/r1Zi1IBOsB2uejNnoiZKRc/ozhwOchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anR/htTVF+0zb+XilB1FcZ6pnbSQGbLTJ/2FyLpJZSI=;
 b=AOvSFSLsGk5DaxpDWe+vzKwBZrDhVDgl9mgJOgi6pjYx/mB8P6jcv+1brOa09hHm5q8S18gmR3/w/XylRuHbxPNyG6QqMdYN3uEkIK5BdNFTYYslIPFG7oJzpI8/jypCA4CwMvoOFaUql757JtZiN1dbjKIdptAy+HGAMwZligkcOWdgG75udJPixL953cetG2Df35KbfdRto2AZyocb8WTZt9tpGFTjdJiW2nKpQDZyMFUPN1fSwenlDG+C4Yx4HQqt/7sDbfBGZG+nOCln3TRxchrjuT9Pp0vqaWYX+A/DcRrz//A7UeOqw2XGtk3LztIMFdFK8pnrs9n6sHYm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anR/htTVF+0zb+XilB1FcZ6pnbSQGbLTJ/2FyLpJZSI=;
 b=UPS7x/V+I6icgjnITWFAYG1ndpFAazcbK8GBYjTOJAoGp0XUNp9eKFDch1FeIq8/kqn2feiFiwvOxUK+PWW0L30nExmm2wiMJGxfyrKbhMX49QXLFhCw/TtSVy/fmKFkKpw189XaTsU14f3TKyFmmPd+LrSrYUH4Tqyahh//xdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:52 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:52 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 4/5] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Thu, 24 Aug 2023 12:16:14 +0300
Message-Id: <20230824091615.191379-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 711b7e44-c657-420a-62da-08dba482dab8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jM8HhC99nDh+OLqF+V0hiVq1yrIpKsUrde8rh3HiZKsU0uqfCN5Q5XxH9diAEPQtL5Ne/QSdVmKoG84aAXfVz28Lb79JiqJUDrqJH9y4ED/MtABy69Z0f7j2H18AxwGPmMj7HCrSXYxxFycg63SEOKMbiIMxa9vlrHwR5Tzd+DU9qsZQVA/pbE7eqyZ+c1eejZMcVUiBTF3dHvOepryEwMQjpFOG0OLJGjVHo3pdP2rn61vHSrkOnK4u2o5I//bVtodQ3DbGXflFuYmLz4LIRqDGpJe6v5bDOnVufRvFJs48E8UtD1BqqkvLwQB4p/opImoibUWXlUnTVHyKwcUqTIKjr8QfdIFfyPLbu7C0etFXf3BWU4aD86KhWDm6h/dSCf5zdJPHrGZIaMlVHwFOYkmYjXCgMtiDO5w/n7VsfYGG55P4YiuLFy/uP2ohNd0R1GIIaecjYBDfj7xlzrYW5muAWb7tDGkRxSvuoyH2dNyvkIUYY0Ho0VR9xNrX/n+7Tefg1RvPO4cF1qwd4IESCEek8mp7uadfXny2TuSGTof+KRsnu1UuZJ/armLweeQlOaMDfuohJuqE5oSHguJzQ8ghGyOr5jfsMQgjgwaI1Aog8Ju+sAMvk4AxWibu9bpD9DMJp2f4Phcp9a3mJ3wdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(30864003)(83380400001)(7416002)(26005)(38350700002)(921005)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(6512007)(2906002)(6506007)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDRy74y2KeYWOs2j5N6gpuU8f6ThPTnXiC+SiYuQYtf/LcBi0jtR8c4knvqN?=
 =?us-ascii?Q?lfhzafs9cKYkkgNLVRtZrkmAeOrbIlIIrjpqJBzKk0JOBG8XKroydBjira3j?=
 =?us-ascii?Q?r1Wtv1BEN2x0lgsVzQnVV+TLuSFd4gRBBJWvgovLjy5hde7VF8KqKYEpoc5H?=
 =?us-ascii?Q?RasRBf1bkyuz3ZPekBWBxhezs4GBDuA/DtdEBnDqq9Hd8mWIsMeg//7JOpcb?=
 =?us-ascii?Q?FZSmns6VRCdijt+PJT6JrEYshJZ/97Mgg8z1Ek0xPyQ1pWPKM7flhuzccKXg?=
 =?us-ascii?Q?jMih3n/AoWTbpHZnXvd9CmKs14MKgUf19tVwI5GjBh8q85Aw186+4ui3L+Fj?=
 =?us-ascii?Q?Uel17NNQGWv5KWPEfe9fAJt8Z9//fPERosZ76nU5+eXy9s5SCHwFWyhC176w?=
 =?us-ascii?Q?v8InYJI5KdBWC71hliwrmkVp+IwccPdYwWVILpf1IcI5uRzUuz+eKeBCASZB?=
 =?us-ascii?Q?lG2M7xK42PJZEwhYy6g5VOp/rqticVvM8WXOKqFYMoM/gLPdpiAEByDXCw5F?=
 =?us-ascii?Q?g0mwqjNyPvkAOyZvoC/3anmRTH3pzawwpjr7ciPkZfx8xaihE9maZJQYIRl9?=
 =?us-ascii?Q?FeVU32nIYmPWCv7VohRCr1/8+M6nPsaPYYaC/Pfo6rHRloPAzKDkOgoHr8HZ?=
 =?us-ascii?Q?s47GSni9BaqmdRSEFjwsZXHWHadZI2iGtFo/PdhJSSFWAWXw37kJ3GQkTZog?=
 =?us-ascii?Q?VrWyGQn+xgNlSi3SZxfkABi2vDgmmoCvds5xOFsMwTckeckZUp2FNGkSU2s7?=
 =?us-ascii?Q?wTURn+TTeKn//ydSl++s/aBPBqqLxxdJh89BqsHJzZa7m6pl2M/ntHJbdvFZ?=
 =?us-ascii?Q?7laU8JoBEZHjI/AdQaqSVal7OBCxJbOyTHFLjccvg75qdoojSf1bTjUVnTeu?=
 =?us-ascii?Q?wITIDQoPiMBnqrzhiZodM4E8tRKCtOnSK08ZocyoOUaQCGT27W6+TkqCIDNR?=
 =?us-ascii?Q?FLg5VmGup4MwgvAf4s85emYMFexnOHCI9P0vXCyzDI39a7EwrFzu1hUXegNi?=
 =?us-ascii?Q?TKJdn6lOBqTAIwcxV9+odBMGqIV9kLD3GDHBMYbENsCCfpBq6jttSDrz7+uD?=
 =?us-ascii?Q?/7sIHKaP8H+7gnbZT1Ki778BRoJ0b5jGa+dKfBTYJAr4EF9sPNGEFT8ySuGr?=
 =?us-ascii?Q?WIi8MS4EG1fvIRXLnPPvxXpIKDBDA6AIhXzTg92Lx/Tud/p8zC6PW7/ADian?=
 =?us-ascii?Q?eAFxvcrxLvrFmA7W9gQ7/UTudi1kk+SNR8lYzV0yqC+ajjSpqkAlzJwhqUGD?=
 =?us-ascii?Q?/l5TDuIMiy0vDmQALCLeVAin8yu0zxWngUXSLiY/dxkPBGqO5LwElGQeFD25?=
 =?us-ascii?Q?kLSzWbvvm9V6uj1XuzXOEMy/W7toVnMx/iue11lqcnQ3p89+8wJHsj3JIGn+?=
 =?us-ascii?Q?P/lQuT2BvIYTIngdeVnqbiXpEFM2skFX4kWvMLd9iGj9OkAHNyAh9/fNKDjo?=
 =?us-ascii?Q?g8IeD9CMCgzcQ8Itlz2TM+bcIEGz9os7NrK7nO7nc9cX6ev9EPBAq0NiwwHf?=
 =?us-ascii?Q?6fYy/W+GM4M4CXYGSU+6SbZBBe7oFrrxCLDa2+ooQKxyEifk1gs+EXSsheoh?=
 =?us-ascii?Q?bGpwQlJPeeFKJffIIiragxxyN6jA4ldZL18R8FwVJP4rWVuMgvupuHYj1+O6?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711b7e44-c657-420a-62da-08dba482dab8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:52.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPkDMlHEoC6vYDF9BhHeE1uG317yqDjsfVo/3U9xQ4qXS75IgB4P3mmQja2OFv0rdNfjhrswMU6CBd7a5uFvUfutQkyTmywvq6G+VkfizN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 416 ++++++++++++++++++++++-
 1 file changed, 415 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 1567865b8de4..edfdd2540d39 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -140,6 +140,33 @@
 #define ADAPTER_EN	BIT(6)
 #define MACSEC_EN	BIT(5)
 
+#define MACSEC_INOV1HS			0x0140
+#define MACSEC_INOV2HS			0x0144
+#define MACSEC_INOD1HS			0x0148
+#define MACSEC_INOD2HS			0x014C
+#define MACSEC_RXSCIPUS			0x0150
+#define MACSEC_RXSCIPDS			0x0154
+#define MACSEC_RXSCIPLS			0x0158
+#define MACSEC_RXAN0INUSS		0x0160
+#define MACSEC_RXAN0IPUSS		0x0170
+#define MACSEC_RXSAAIPOS		0x0194
+#define MACSEC_RXSAAIPIS		0x01B0
+#define MACSEC_RXSAAIPNVS		0x01B4
+#define MACSEC_RXSABIPOS		0x01D4
+#define MACSEC_RXSABIPIS		0x01F0
+#define MACSEC_RXSABIPNVS		0x01F4
+#define MACSEC_OPUS			0x021C
+#define MACSEC_OPTLS			0x022C
+#define MACSEC_OOE1HS			0x0248
+#define MACSEC_OOE2HS			0x024C
+#define MACSEC_TXSAAOPPS		0x028C
+#define MACSEC_TXSAAOPES		0x0290
+#define MACSEC_TXSABOPPS		0x02CC
+#define MACSEC_TXSABOPES		0x02D0
+#define MACSEC_INPWTS			0x0630
+#define MACSEC_INPBTS			0x0638
+#define MACSEC_IPSNFS			0x063C
+
 struct nxp_c45_rx_sc {
 	struct macsec_rx_sc *rx_sc;
 	struct macsec_rx_sa *rx_sa_a;
@@ -148,6 +175,7 @@ struct nxp_c45_rx_sc {
 
 struct nxp_c45_tx_sa {
 	struct macsec_tx_sa *tx_sa;
+	struct macsec_tx_sa_stats stats;
 	u8 key[MACSEC_MAX_KEY_LEN];
 	u8 salt[MACSEC_SALT_LEN];
 	u8 an;
@@ -787,6 +815,113 @@ static int nxp_c45_disable_rxsa_key(struct phy_device *phydev, bool key_a)
 	return 0;
 }
 
+static void nxp_c45_clear_dev_stats(struct phy_device *phydev,
+				    struct nxp_c45_secy *phy_secy)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_OPUS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OPTLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE2HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPES, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSABOPES, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPPS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSABOPPS, 0);
+
+	if (phy_secy->rx_sc) {
+		nxp_c45_macsec_write(phydev, MACSEC_INPBTS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_INPWTS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_IPSNFS, 0);
+	}
+}
+
+static void nxp_c45_clear_rx_sc_stats(struct phy_device *phydev)
+{
+	int i;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPIS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPNVS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPOS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPIS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPNVS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPOS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOD1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOD2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOV1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOV2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPDS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPUS, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++)
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + i * 4, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++)
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + i * 4, 0);
+}
+
+static void nxp_c45_tx_sa_stats_read(struct phy_device *phydev,
+				     struct nxp_c45_tx_sa *tx_sa,
+				     struct macsec_tx_sa_stats *stats)
+{
+	u32 reg = 0;
+
+	if (tx_sa->is_key_a) {
+		nxp_c45_macsec_read(phydev, MACSEC_TXSAAOPES, &reg);
+		stats->OutPktsEncrypted = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_TXSAAOPPS, &reg);
+		stats->OutPktsProtected = reg;
+	} else {
+		nxp_c45_macsec_read(phydev, MACSEC_TXSABOPES, &reg);
+		stats->OutPktsEncrypted = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_TXSABOPPS, &reg);
+		stats->OutPktsProtected = reg;
+	}
+}
+
+static void nxp_c45_tx_sa_stats_clear(struct phy_device *phydev,
+				      struct nxp_c45_tx_sa *tx_sa)
+{
+	if (tx_sa->is_key_a) {
+		nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPES, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPPS, 0);
+	} else {
+		nxp_c45_macsec_write(phydev, MACSEC_TXSABOPES, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_TXSABOPPS, 0);
+	}
+}
+
+static void nxp_c45_tx_sa_stats_backup(struct phy_device *phydev,
+				       struct nxp_c45_tx_sa *tx_sa)
+{
+	struct macsec_tx_sa_stats stats;
+
+	nxp_c45_tx_sa_stats_read(phydev, tx_sa, &stats);
+	tx_sa->stats.OutPktsEncrypted += stats.OutPktsEncrypted;
+	tx_sa->stats.OutPktsProtected += stats.OutPktsProtected;
+	nxp_c45_tx_sa_stats_clear(phydev, tx_sa);
+}
+
+static void nxp_c45_clear_rx_sa_stats(struct phy_device *phydev,
+				      u8 an, bool is_key_a)
+{
+	if (is_key_a) {
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPIS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPNVS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPOS, 0);
+	} else {
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPIS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPNVS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPOS, 0);
+	}
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + an * 4, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + an * 4, 0);
+}
+
 static int nxp_c45_rx_sc_del(struct phy_device *phydev,
 			     struct nxp_c45_rx_sc *rx_sc)
 {
@@ -801,6 +936,8 @@ static int nxp_c45_rx_sc_del(struct phy_device *phydev,
 	if (rx_sc->rx_sa_b)
 		nxp_c45_disable_rxsa_key(phydev, false);
 
+	nxp_c45_clear_rx_sc_stats(phydev);
+
 	return 0;
 }
 
@@ -961,6 +1098,7 @@ static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
 		if (old_tx_sa) {
 			old_tx_sa->is_enabled = false;
 			nxp_c45_txsa_get_pn(phydev, old_tx_sa);
+			nxp_c45_tx_sa_stats_backup(phydev, old_tx_sa);
 		}
 	}
 
@@ -979,6 +1117,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	struct nxp_c45_phy *priv = phydev->priv;
 	struct nxp_c45_secy *phy_secy;
 	u32 reg;
+	int i;
 
 	phydev_dbg(phydev, "delete secy SCI %llu\n", ctx->secy->sci);
 
@@ -990,11 +1129,16 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_disable(phydev, phy_secy);
 	nxp_c45_tx_sc_clear(phy_secy);
+	nxp_c45_clear_dev_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc) {
 		nxp_c45_rx_sc_del(phydev, phy_secy->rx_sc);
 		kfree(phy_secy->rx_sc);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(phy_secy->tx_sa); i++)
+		if (phy_secy->tx_sa[i] && phy_secy->tx_sa[i]->is_enabled)
+			nxp_c45_tx_sa_stats_clear(phydev, phy_secy->tx_sa[i]);
+
 	if (phy_interrupt_is_valid(phydev)) {
 		nxp_c45_macsec_read(phydev, MACSEC_EVER, &reg);
 		reg &= ~TX_SC_BIT(phy_secy->secy_id);
@@ -1188,6 +1332,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 		phydev_dbg(phydev, "delete RX SA A %u %s\n",
 			   an, rx_sa->active ? "enabled" : "disabled");
 		nxp_c45_disable_rxsa_key(phydev, true);
+		nxp_c45_clear_rx_sa_stats(phydev, an, true);
 		rx_sc->rx_sa_a = NULL;
 		return 0;
 	}
@@ -1196,6 +1341,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 		phydev_dbg(phydev, "delete RX SA B %u %s\n",
 			   an, rx_sa->active ? "enabled" : "disabled");
 		nxp_c45_disable_rxsa_key(phydev, false);
+		nxp_c45_clear_rx_sa_stats(phydev, an, false);
 		rx_sc->rx_sa_b = NULL;
 		return 0;
 	}
@@ -1323,8 +1469,10 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 
-	if (tx_sa->is_enabled)
+	if (tx_sa->is_enabled) {
 		nxp_c45_update_key_status(phydev, tx_sa);
+		nxp_c45_tx_sa_stats_clear(phydev, tx_sa);
+	}
 
 	phy_secy->tx_sa[sa] = NULL;
 	kfree(tx_sa);
@@ -1332,6 +1480,267 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 	return 0;
 }
 
+static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_dev_stats  *dev_stats;
+	struct nxp_c45_secy *phy_secy;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	dev_stats = ctx->stats.dev_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OPUS, &reg);
+	dev_stats->OutPktsUntagged = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_OPTLS, &reg);
+	dev_stats->OutPktsTooLong = reg;
+
+	dev_stats->InPktsUntagged = 0;
+	dev_stats->InPktsNoTag = 0;
+	dev_stats->InPktsBadTag = 0;
+	dev_stats->InPktsUnknownSCI = 0;
+	dev_stats->InPktsNoSCI = 0;
+
+	if (phy_secy->rx_sc) {
+		nxp_c45_macsec_read(phydev, MACSEC_INPBTS, &reg);
+		dev_stats->InPktsBadTag = reg;
+
+		nxp_c45_macsec_read(phydev, MACSEC_INPWTS, &reg);
+		if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+			dev_stats->InPktsNoTag += reg;
+		else
+			dev_stats->InPktsUntagged += reg;
+
+		nxp_c45_macsec_read(phydev, MACSEC_IPSNFS, &reg);
+		if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+			dev_stats->InPktsNoSCI += reg;
+		else
+			dev_stats->InPktsUnknownSCI += reg;
+	}
+
+	/* Always 0. */
+	dev_stats->InPktsOverrun = 0;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sc_stats *tx_sc_stats;
+	struct macsec_tx_sa_stats tx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+	u32 reg = 0;
+	u64 stat;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sc_stats = ctx->stats.tx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
+	stat = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
+	stat |= reg;
+	if (ctx->secy->tx_sc.encrypt)
+		tx_sc_stats->OutOctetsEncrypted = stat;
+	else
+		tx_sc_stats->OutOctetsEncrypted = 0;
+
+	if (ctx->secy->protect_frames)
+		tx_sc_stats->OutOctetsProtected = stat;
+	else
+		tx_sc_stats->OutOctetsProtected = 0;
+
+	tx_sc_stats->OutPktsEncrypted = 0;
+	tx_sc_stats->OutPktsProtected = 0;
+
+	for (i = 0; i < ARRAY_SIZE(phy_secy->tx_sa); i++) {
+		tx_sa = phy_secy->tx_sa[i];
+		if (!tx_sa)
+			continue;
+
+		if (tx_sa->is_enabled) {
+			nxp_c45_tx_sa_stats_read(phydev, tx_sa, &tx_sa_stats);
+			tx_sc_stats->OutPktsEncrypted +=
+				tx_sa_stats.OutPktsEncrypted;
+			tx_sc_stats->OutPktsProtected +=
+				tx_sa_stats.OutPktsProtected;
+			continue;
+		}
+
+		tx_sc_stats->OutPktsEncrypted += tx_sa->stats.OutPktsEncrypted;
+		tx_sc_stats->OutPktsProtected += tx_sa->stats.OutPktsProtected;
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats *tx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sa = phy_secy->tx_sa[ctx->sa.assoc_num];
+	if (!tx_sa)
+		return -EINVAL;
+
+	tx_sa_stats = ctx->stats.tx_sa_stats;
+
+	if (!tx_sa->is_enabled) {
+		tx_sa_stats->OutPktsEncrypted = tx_sa->stats.OutPktsEncrypted;
+		tx_sa_stats->OutPktsProtected = tx_sa->stats.OutPktsProtected;
+		return 0;
+	}
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_stats_read(phydev, tx_sa, tx_sa_stats);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sc_stats *rx_sc_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	u32 reg = 0;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	rx_sc_stats = ctx->stats.rx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	rx_sc_stats->InPktsInvalid = 0;
+	rx_sc_stats->InPktsNotValid = 0;
+	rx_sc_stats->InPktsOK = 0;
+
+	if (rx_sc->rx_sa_a) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPIS, &reg);
+		rx_sc_stats->InPktsInvalid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPNVS, &reg);
+		rx_sc_stats->InPktsNotValid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPOS, &reg);
+		rx_sc_stats->InPktsOK += reg;
+	}
+
+	if (rx_sc->rx_sa_b) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPIS, &reg);
+		rx_sc_stats->InPktsInvalid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPNVS, &reg);
+		rx_sc_stats->InPktsNotValid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPOS, &reg);
+		rx_sc_stats->InPktsOK += reg;
+	}
+
+	ctx->stats.rx_sa_stats->InPktsNotUsingSA = 0;
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + i * 4, &reg);
+		rx_sc_stats->InPktsNotUsingSA += reg;
+	}
+
+	ctx->stats.rx_sa_stats->InPktsUnusedSA = 0;
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + i * 4, &reg);
+		rx_sc_stats->InPktsUnusedSA += reg;
+	}
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOD1HS, &reg);
+	rx_sc_stats->InOctetsDecrypted = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOD2HS, &reg);
+	rx_sc_stats->InOctetsDecrypted |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOV1HS, &reg);
+	rx_sc_stats->InOctetsValidated = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOV2HS, &reg);
+	rx_sc_stats->InOctetsValidated |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPDS, &reg);
+	rx_sc_stats->InPktsDelayed = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPLS, &reg);
+	rx_sc_stats->InPktsLate = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPUS, &reg);
+	rx_sc_stats->InPktsUnchecked = reg;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats *rx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	u8 an = ctx->sa.assoc_num;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->sa.rx_sa->sc)
+		return -EINVAL;
+
+	if (!rx_sc->rx_sa_a && !rx_sc->rx_sa_b)
+		return -EINVAL;
+
+	rx_sa_stats = ctx->stats.rx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	if (rx_sc->rx_sa_a == ctx->sa.rx_sa) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPIS, &reg);
+		rx_sa_stats->InPktsInvalid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPNVS, &reg);
+		rx_sa_stats->InPktsNotValid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPOS, &reg);
+		rx_sa_stats->InPktsOK = reg;
+	}
+
+	if (rx_sc->rx_sa_b == ctx->sa.rx_sa) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPIS, &reg);
+		rx_sa_stats->InPktsInvalid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPNVS, &reg);
+		rx_sa_stats->InPktsNotValid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPOS, &reg);
+		rx_sa_stats->InPktsOK = reg;
+	}
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + an * 4, &reg);
+	rx_sa_stats->InPktsNotUsingSA = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + an * 4, &reg);
+	rx_sa_stats->InPktsUnusedSA = reg;
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1347,6 +1756,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
 	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
 	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+	.mdo_get_dev_stats = nxp_c45_mdo_get_dev_stats,
+	.mdo_get_tx_sc_stats = nxp_c45_mdo_get_tx_sc_stats,
+	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
+	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
+	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
 };
 
 int nxp_c45_macsec_probe(struct phy_device *phydev)
-- 
2.34.1

