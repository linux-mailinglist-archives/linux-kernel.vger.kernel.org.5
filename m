Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74C7D2F61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJWKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJWJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:43:55 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F410CA;
        Mon, 23 Oct 2023 02:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW5mXuZzQ5Lkx1TytnyFsPZrq+93YXfhWiRrln+w3bB6q9cisoumzJJRQk+6DOd9/DcR+Ata3APR6am8ESnQhD4BfHxyacA2hQ2SZpS95t4wc5UZRP/X9FipY7CT86vD5rfsao/Uuu/kB27s7eAPEDkZnKkK5rFSSaytnCQSSKsxXoz9Hh1B+8dQKqOQ41CcNmK79nSHDkHGB6QSoAgVQFRUWth+Y+1V4zBf904x+m9RngvdC2OilhqgmbBUndOE3iAvCgnRB52EZapqGBVpGfXXc/AqLJI+5mzZIdcZINC1bto3+9f+EUUkIWfInpSu1rOQKFhK/A3waYA8Dd62Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71BvX4j3gnzZ5WFxpKluLgk24w6PZJ4HD1CmYc/RySA=;
 b=Lqc61BMyfYEvh36iPy5vgG6a+ZEO2RQSD0YsODbaWW5oBKxBYDKpB5T8env0YtpJmMpk7WcDceBoSTAEHHNM9BieaJMGddC4fXe/rYHRIFEaOrElJSWBVDvey3U8oiTBUHlK+yZ5CPqCCpfKIGTRq1G3pyAG3vhaiS+4Sld/dKDEbAY28tvM6L4G4k6BAaRf3YjgbZx0cjynZ2jxTHfKTLAr64EjRovRActrAwOQILk4jliUXDHCcL7cBFkyYvZsBft2SMyAwZhkyREIhvt6Y6DYmGLVAvEHiTl4batm9uh0qXZQpwHt6crtD2EhOhuJ5swGe5Mxw6JyXryKvz85qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71BvX4j3gnzZ5WFxpKluLgk24w6PZJ4HD1CmYc/RySA=;
 b=RHFjZ22TJtn68pDcXZhC1hpjcMXCZFdrCY6Dwc3GovlPKV6/yH68i+voYnlRfnvanhqFDJnHkRrkGgrnundRUYE1EYX2dPI0V/omiZVRZiE+AXXiaeNvRRJq5x2pcxN7e7CvfNPJLce04tSxlFSfeZ9j4UbsPhCDCmmbVofexDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:49 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:49 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 2/7] net: macsec: documentation for macsec_context and macsec_ops
Date:   Mon, 23 Oct 2023 12:43:22 +0300
Message-Id: <20231023094327.565297-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3798709d-262e-4a6e-e18e-08dbd3ac8f1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUnaLT52+IhQiEwYOQL6tsqmty/1vFhEWGi4+alDbNunitOLrUtN27BNXJpm7ySsWErvQbDmc+jt+6JRaB05LuMj9XiHqnYvpMcXSSOGh6g+MVhpeXxiWu1JN8CXHICGqEWt8FZT8pP+3apDIRm15xs0t2sN1tcNnfwUVHbjJbkKQ5rGZw7KAD3spkKxZd6lMSnMEgskmIyId5qrOdGs2aUvfJQoSDQ8VGz3syZnKhBDeu8rFHxrBg1k60RvzG7fmWnh2tFqnwX/Ya0IHGa/2w3ltbJx0fxeQKh556GuHDye0o++n6zuR4stxz95BipCN7C5Ey6MqpW62IU/d82ojaQUanqdPQypbP6PthxZs9nOE904C260WVKyAReB/49g+QVzNxxOo9lHhYs8zvdVXL9h9/F/GZ/QQnNK4OiWQZo2f4awMxCOGOuqO6WT1lY1J8JEWPue5RhbivQ1U+HEEAGdC+u7S8olh5dxiMtaA2oVFAaPW/OPecfKPnk+RNoIt3HwxYfGs7ZkvWUp9J8ge4Q+Tsosd3I2iDWleMFy3g6wWMuWubMfg6lCGTOYc/LUnyJ6+ebfowpPw4cgVpHPSiyTo8+YhIlxYFXqR4rdzV4Ik++RoMThrYAsTi9NApyy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(83380400001)(6506007)(8936002)(6666004)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EfIM9soCcn4AwRLgsfMF6H8az/qgIQrPQgClE6Ti5HwXj2SH82NVDkC4iEN?=
 =?us-ascii?Q?p4j9VAq9n9mmeyysFzxB1FkmLaKO2fNyqPxp1THAVpzZaINBjGTXR7iSE3q8?=
 =?us-ascii?Q?qWNFhBtnu6dINQEnhH3guFiBYtIQ4mHkZ86+YK8JIeL0z3ERwK+TpWcvKoN8?=
 =?us-ascii?Q?rDL69SLSepRTZu/gGw8pOKfvwwG4ZfBvxpE3H6PoVOwEiLmg5kkDkX0DaNop?=
 =?us-ascii?Q?PAPUIkQCvt52kwwFSdLByTxhZ3t4/5N4jdLQLbB3DnuxyTyzyDvc77hq7zDJ?=
 =?us-ascii?Q?TTRvPgg4kLJmCiLPsAARODWnFR7C+tnFwCe+2g1CJiG/DMy/3pDo1rAKmQjH?=
 =?us-ascii?Q?kBy+z91KWNsstXZ8esFst7Y3eQaVnnmx6ftSbJ6YiJxXsE7jpBG47R0IMENy?=
 =?us-ascii?Q?uhnoRcjbkJYvbnnS2ALj1TqZ06En8JctS+3Rz4Y9VbnGEJpw4RQDgIwuczt3?=
 =?us-ascii?Q?7oqwL4LmjV6qy6VUDBayVJeVCdeDHWAFmBSGDBEg8kpVOeXX+0fXibcX357U?=
 =?us-ascii?Q?wCJmF2x6di8y8x5vlIhj4/dPp96C/gvcOIBQjKLlnuyYN3GvHEhxJ7nUnw+m?=
 =?us-ascii?Q?yuJ0eOtZHgV5uXudY8RPWkCztApabyIVXs4s8bgPuuFY7bYspZTFx/zDigHL?=
 =?us-ascii?Q?9GboAcBLm8cqW3bkMweja3eVE9HjhA4v9DdYCmk64zX6HSTAwp2RsiUGFT2u?=
 =?us-ascii?Q?OAKzMqiBhbJGJbBJTscICBRr0PlairNPWB1AOqIaOAFekDY7lpjkWoB+8mY3?=
 =?us-ascii?Q?zmq1TZZcwA6t3Mqp0x3DAqTdOhTMhTrr+b51CmJAyNEQobaTvWsc7+DLStJE?=
 =?us-ascii?Q?gr0EJots/v16oxSgXBK9TmpFbLi0KEKEmZ4OhYK/owPqfWNZn+NkHEZ0qTVo?=
 =?us-ascii?Q?mpQi/K5OAGC7mwSWzlZ0Nf/f5WoE/y5BU7VJLUkxX7x55yN4bHivmXCgFmkN?=
 =?us-ascii?Q?Ai+rNlcUCRgG0NlKUqOZUWefJWf+HW7aCSAOSMecTClWKUvw4pFHcYmpZx/x?=
 =?us-ascii?Q?NMqXKswBvXIQ9tquoW/aHg+KC797RbByk2+zsB3aGYYSanqcaOSityCvCI09?=
 =?us-ascii?Q?4FBB+ZPh6FvI5Xm6RIR4ovTRdmEKvm06zawLGYJyH4FjcD8rq8NoNeCBpAI6?=
 =?us-ascii?Q?7aKoCOs7oc+fZ7NahwTTsDxFN+EQGVw7Ff1bI885HI60A92xBspsql8cGoxn?=
 =?us-ascii?Q?h1WeGsdtSO6k3hiAJWxM/MTGFgRAkzzU4uEb1Sb5ypRK08LuaXMlcdRWbrBU?=
 =?us-ascii?Q?5PYleNagdMjxA3l0BoEpn9QwS4WdnGEufw0FeknFY1wdclxPtbcoixASUUgj?=
 =?us-ascii?Q?Xvn1g69HSHF20YARlj+Xuto5hCPX/k21BgL/TdlyevLed8ACr48g6bpKI2hO?=
 =?us-ascii?Q?tSoD91QkfGgnK7d68mCLMBMndpouZDxl+al9+HylJYnfksE01k2HQiPIOcGh?=
 =?us-ascii?Q?+yz2irEzEOIdxIPyUuD5ahKtiD47XJYVTIU6Z4PNMdLtsHtvjbanc60GQZaB?=
 =?us-ascii?Q?P1phc+ZYGfg9+49sSsL0kHFlTjhqP0ENQV+mrxeT8PnyMHpPD01yr+HPCF0q?=
 =?us-ascii?Q?czdZ+4DPnY0eNTcKiqQtrAnVnpxik/W/Gi9NIwVQC5n2+eN4CZQqFqko5iPQ?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3798709d-262e-4a6e-e18e-08dbd3ac8f1b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:49.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbEPNyo2Z9bh/OT3jtefeIMUUkda1IfngBcwv32yUY9lkAc/twYBdoK6vegPdk3rhw7qZoRgvYSFel/oRoeMxggOxlDJp1hlkgTAJyyq/v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for fields of struct macsec_context and struct
macsec_ops.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v8:
- none

Changes in v7:
- added update_pn description

Changes in v4-v6:
- none

Changes in v3:
- improved description for the netdev and phydev fields
- fixed typo in mdo_get_rx_sc_stats description

Changes in v2:
- patch added in v2

 include/net/macsec.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index a5665e9623f2..0821fa5088c0 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,23 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: a valid pointer to a struct net_device if @offload ==
+ *	MACSEC_OFFLOAD_MAC
+ * @phydev: a valid pointer to a struct phy_device if @offload ==
+ *	MACSEC_OFFLOAD_PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
+ * @update_pn: when updating the SA, update the next PN
+ * @assoc_num: association number of the target SA
+ * @key: key of the target SA
+ * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
+ * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
+ * @tx_sc_stats: pointer to TX SC stats structure
+ * @tx_sa_stats: pointer to TX SA stats structure
+ * @rx_sc_stats: pointer to RX SC stats structure
+ * @rx_sa_stats: pointer to RX SA stats structure
+ * @dev_stats: pointer to dev stats structure
  */
 struct macsec_context {
 	union {
@@ -277,6 +294,28 @@ struct macsec_context {
 
 /**
  * struct macsec_ops - MACsec offloading operations
+ * @mdo_dev_open: called when the MACsec interface transitions to the up state
+ * @mdo_dev_stop: called when the MACsec interface transitions to the down
+ *	state
+ * @mdo_add_secy: called when a new SecY is added
+ * @mdo_upd_secy: called when the SecY flags are changed or the MAC address of
+ *	the MACsec interface is changed
+ * @mdo_del_secy: called when the hw offload is disabled or the MACsec
+ *	interface is removed
+ * @mdo_add_rxsc: called when a new RX SC is added
+ * @mdo_upd_rxsc: called when a certain RX SC is updated
+ * @mdo_del_rxsc: called when a certain RX SC is removed
+ * @mdo_add_rxsa: called when a new RX SA is added
+ * @mdo_upd_rxsa: called when a certain RX SA is updated
+ * @mdo_del_rxsa: called when a certain RX SA is removed
+ * @mdo_add_txsa: called when a new TX SA is added
+ * @mdo_upd_txsa: called when a certain TX SA is updated
+ * @mdo_del_txsa: called when a certain TX SA is removed
+ * @mdo_get_dev_stats: called when dev stats are read
+ * @mdo_get_tx_sc_stats: called when TX SC stats are read
+ * @mdo_get_tx_sa_stats: called when TX SA stats are read
+ * @mdo_get_rx_sc_stats: called when RX SC stats are read
+ * @mdo_get_rx_sa_stats: called when RX SA stats are read
  */
 struct macsec_ops {
 	/* Device wide */
-- 
2.34.1

