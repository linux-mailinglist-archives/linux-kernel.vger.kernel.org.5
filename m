Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D4D7FA4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjK0Pfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjK0Pfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:35:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2A18E;
        Mon, 27 Nov 2023 07:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNyN5qY5hO7rqy2coWv7BCaFcVGtAhUWadBx3YHVnAAj4NGTRf1tqyxdTRwtTtFYyVqdaMDvq4MsLZDdNwpnoKUMScgtdxqzqpXKfxOIvh/6g62biGUNCxisyn70FID2lcdSQ9DCWk5mIcYaQI+Q9Ntc0eFxkljRLatD20Sq6gLeoeq9cSes7j4EgcA+9d5yJ7mj0zFFkSu0AIvlqZ66ZWHtqDSpZNkaRAYmAbqP6dS19EjRJbXCKCYjIRJDXSkSx7+aGhhaW7mmxYcUKbAI0T3Z+Gf7qy/e4LuDpbsdFMDluL3ca3Dj551y4PupMDCUdQQU8yefuz1Faau089dnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mykukmwqw1C/8rLGmGVNA+RCw9YlZlHbkBIs/hRJERw=;
 b=loFQGPNnB9a8lP2Yrm5bmzos2419spbQ773ziRs4MB+RjMA9HeS0IkA3w6KPohaP2ACzFccJKPwn6qv7UJ7hXW7pSD3aNcluGtqgVsZX+xxoW/tqDWG03lzObsohJ5DGfUYRaq/KlNHckQW29gCGU48zVupXXVmDxjkcU7UosHdESAHv2mWNMM53xdwy2PJo4fIM3MrFcHtokk0sUbvzstOYgsxPVJKAfzFHnXOxqcwuU5lVaMqHixi+883V8b5wngeDMeb1tjkQ3iiUEUn99jFGx/KdJBQhJdEJt/KlcBlezfK+efX16Ikjsap/poj0+CNXP1NNATpveZCxPeu+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykukmwqw1C/8rLGmGVNA+RCw9YlZlHbkBIs/hRJERw=;
 b=SFZT0582vhcbtxkSi1bEkudxnOLctOos47Xnw8uTIw7lPylwZFXF4D7ZgxbJto0fNSgtNpxH/fDzzuSmeGhpmfwrOnaPO1opOBy6uwvNxB++VkUR+CLunsR6a89xdnozyvChZjpTQ/uafzUcHOPUPmBta/HprmR1oFNWkCdE+Ho=
Received: from AS9PR06CA0398.eurprd06.prod.outlook.com (2603:10a6:20b:461::17)
 by PA4PR02MB7006.eurprd02.prod.outlook.com (2603:10a6:102:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 15:35:56 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::3c) by AS9PR06CA0398.outlook.office365.com
 (2603:10a6:20b:461::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Mon, 27 Nov 2023 15:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 15:35:55 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Nov
 2023 16:35:55 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Nov 2023 16:35:55 +0100
Received: from pc45945-2140.se.axis.com (pc45945-2140.se.axis.com [10.88.125.80])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4E726EC35;
        Mon, 27 Nov 2023 16:35:55 +0100 (CET)
Received: by pc45945-2140.se.axis.com (Postfix, from userid 10564)
        id 5E5B774FBB39; Mon, 27 Nov 2023 16:35:55 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 27 Nov 2023 16:31:39 +0100
Subject: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
X-B4-Tracking: v=1; b=H4sIAFq2ZGUC/x3MQQqAIBBA0avErBtQI6SuEi1MpxqIKTRCkO6et
 Hzw+QUSRaYEY1Mg0sOJT6nQbQN+d7IRcqgGo0yntbHoAguuR0CvrPHdYgfXO6j5FWnl/K8mELp
 RKN8wv+8HsnCvxmQAAAA=
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|PA4PR02MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666e1b7-e313-4d29-094b-08dbef5e8c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dAcCU/YETZ4SlgkHTwP0T448erYys3IWXr9IUw/YHoX4MAeVzcOziDHoW5m6Fqwa0YHzdig944YMvJqPF2NtB8gOTBeo++xe2tpffypAohz1S4FIdznh/hwxrH2y1/i6l6JWqqVvdFN3T8OvxFeguram6DsiLvIcumDGT0a52AdMR7AM7G04/7+HM5mbXlBdZ7CGcA6IjlHSEHLB6672Mm/cgEpbJr0RGMMkGr1cv81MdMHX5eticWv4SeWT/QFuGe7lrDsrf+jQUBuIsHIqZBcQBLkw9TIkR3FrKM0Nytz/znbKKUlrybp8wuLwkPOhMasKksXpFYqX1z/diSKlbtNQizzJIH6uiP/tslwSN1UMRFG1wD7IIestcMbtrWo1TUtuOElS5ydLTUl5A4YdNfK4Nran/O5tZhbbwrbzQ3R/mk+XxSLR5qtRWvfWLGe76c5uZ7fmmzIGrF6xPt+xvWUKnz8YP5MT8J6olzmTgqZ8TEChZKBvUHsjdCYya7lhBUdmtOo76lamcJXP+xp1j2GVQ26Sz+6veHj96VQ98W0djLF+0N6qsG5DEUtiRs8vM5SkleAWTXTVgV1bw9SMWdOoQeLbzwYxnFoSAJ70U+lmo/cGHk0ui1mqltruW3iS+RY65j2m6sinw9LlLypJyeFi+Fwzg/Fd0uL8EBvJ2k9LiZf0w827E+Pv4JYeAuuDZQE3pAm7H9UQjDjeepyCC0NwTrp2u4ymkCjDCcBT68aGOo2lvG7kspjCaF8mi+wV6l2rhG+iMbGy1Rm5Bs1tg==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(107886003)(2616005)(26005)(6666004)(8936002)(4326008)(336012)(6266002)(426003)(82740400003)(8676002)(7416002)(44832011)(5660300002)(86362001)(478600001)(70206006)(70586007)(110136005)(316002)(42186006)(54906003)(36860700001)(83380400001)(356005)(47076005)(81166007)(41300700001)(2906002)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:35:55.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666e1b7-e313-4d29-094b-08dbef5e8c0c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to allow Fast Link Down (aka "Enhanced link detection") to
be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
have this feature enabled by default.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/net/phy/adin.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 134637584a83..2e1a46e121d9 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -68,6 +68,24 @@
 #define ADIN1300_EEE_CAP_REG			0x8000
 #define ADIN1300_EEE_ADV_REG			0x8001
 #define ADIN1300_EEE_LPABLE_REG			0x8002
+
+#define ADIN1300_FLD_EN_REG			0x8E27
+#define   ADIN1300_FLD_PCS_ERR_100_EN		BIT(7)
+#define   ADIN1300_FLD_PCS_ERR_1000_EN		BIT(6)
+#define   ADIN1300_FLD_SLCR_OUT_STUCK_100_EN	BIT(5)
+#define   ADIN1300_FLD_SLCR_OUT_STUCK_1000_EN	BIT(4)
+#define   ADIN1300_FLD_SLCR_IN_ZDET_100_EN	BIT(3)
+#define   ADIN1300_FLD_SLCR_IN_ZDET_1000_EN	BIT(2)
+#define   ADIN1300_FLD_SLCR_IN_INVLD_100_EN	BIT(1)
+#define   ADIN1300_FLD_SLCR_IN_INVLD_1000_EN	BIT(0)
+/* These bits are the ones which are enabled by default. */
+#define ADIN1300_FLD_EN_ON	\
+	(ADIN1300_FLD_SLCR_OUT_STUCK_100_EN | \
+	 ADIN1300_FLD_SLCR_OUT_STUCK_1000_EN | \
+	 ADIN1300_FLD_SLCR_IN_ZDET_100_EN | \
+	 ADIN1300_FLD_SLCR_IN_ZDET_1000_EN | \
+	 ADIN1300_FLD_SLCR_IN_INVLD_1000_EN)
+
 #define ADIN1300_CLOCK_STOP_REG			0x9400
 #define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
 
@@ -416,6 +434,37 @@ static int adin_set_edpd(struct phy_device *phydev, u16 tx_interval)
 			  val);
 }
 
+static int adin_get_fast_down(struct phy_device *phydev, u8 *msecs)
+{
+	int reg;
+
+	reg = phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_FLD_EN_REG);
+	if (reg < 0)
+		return reg;
+
+	if (reg & ADIN1300_FLD_EN_ON)
+		*msecs = ETHTOOL_PHY_FAST_LINK_DOWN_ON;
+	else
+		*msecs = ETHTOOL_PHY_FAST_LINK_DOWN_OFF;
+
+	return 0;
+}
+
+static int adin_set_fast_down(struct phy_device *phydev, const u8 *msecs)
+{
+	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_ON)
+		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					ADIN1300_FLD_EN_REG,
+					ADIN1300_FLD_EN_ON);
+
+	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
+		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					  ADIN1300_FLD_EN_REG,
+					  ADIN1300_FLD_EN_ON);
+
+	return -EINVAL;
+}
+
 static int adin_get_tunable(struct phy_device *phydev,
 			    struct ethtool_tunable *tuna, void *data)
 {
@@ -424,6 +473,8 @@ static int adin_get_tunable(struct phy_device *phydev,
 		return adin_get_downshift(phydev, data);
 	case ETHTOOL_PHY_EDPD:
 		return adin_get_edpd(phydev, data);
+	case ETHTOOL_PHY_FAST_LINK_DOWN:
+		return adin_get_fast_down(phydev, data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -437,6 +488,8 @@ static int adin_set_tunable(struct phy_device *phydev,
 		return adin_set_downshift(phydev, *(const u8 *)data);
 	case ETHTOOL_PHY_EDPD:
 		return adin_set_edpd(phydev, *(const u16 *)data);
+	case ETHTOOL_PHY_FAST_LINK_DOWN:
+		return adin_set_fast_down(phydev, data);
 	default:
 		return -EOPNOTSUPP;
 	}

---
base-commit: e1df5202e879bce09845ac62bae30206e1edfb80
change-id: 20231127-adin-fld-c072c3b79a5a

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

