Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8976916A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGaJSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGaJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:17:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BD1A3;
        Mon, 31 Jul 2023 02:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwqZ9ezzDso5FBhXfZ3pVNHUbS/6yC4Qy3lxeabnNAKY5pHV2C8xAXfClIkGHydBJNhteq4LhA+PsCuathsoPMZiYOcJ24gDsXSA1wzAYyUw258Ns2Eb4TvdB1CcUEGGMygSG1OaC+PgTDMtEz+KbK6uzh4Yd5kHm9VGvhMU+SvmoXeU9hofGeLZQEyTz5zWbuAC7jucxTCIVa3kVYVcNxfx9m0CnyAUgHaRKo6OtcoMChv2WCOmeu4bGlWC31aEc1SX2mh71tZB2g7loR01BVUGX4a+msPnUDb4c700K4WPbG8rXgDwDYJJ5W0IyfLV/wiH8bgp7EvS/CZ+8v8z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWi9UadLA8/urKLSFIFXU5D2J8aMI9wTZH1k1WcvyG0=;
 b=Cq/+N9YUNabO6gjBgv5l5G/Nqhxm/iUFzpjbiJEh3mNs4WNitZVI0GOp9xn5caKDihxq8089JEolZJvj1Z6DCkA/RKqF0t1bz7z3cufU1TX3nePzyk+xtzfGUKNUJhq88TZcU+7WGUgEGIOwABp8OnHSrh+oqLYXLkZ9vv4J/9Sn7i/UznFeZftjbt6iBCpWVUsBA19OdwQlX/E4eUpH4aY/OQ91p9eperXjDPrIW1oBCjVmbBpvJRihei4RFN4+6pPKYRBhgjVwC+cf+RCvk4iUQS0hFNYUnmvneFqzgI0EqHdfwcvI8h3PTsTl7tgYcn4gS0/Kw4aJKARDyw0iMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWi9UadLA8/urKLSFIFXU5D2J8aMI9wTZH1k1WcvyG0=;
 b=FbKiVkNtdlBrwPwWsVYjWaeMOXQ/TsQqjoBerdnjr2LiQSl3joj73P4icI3VJ7maPxN1rQUkuQLezfnVcxDpx28ALyuMjvCEvskXy4/Ak5g57wesAzydxKj52cRO6ZmJ05i/vXaZ+g/fQxwIeITmDD2TdhJ0kMhf6MlqJKlk/0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:45 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:45 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 09/11] net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
Date:   Mon, 31 Jul 2023 12:16:17 +0300
Message-Id: <20230731091619.77961-10-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: df892fd4-1839-434c-c90c-08db91a6dc8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxIKpugkolkXJuMJIPxuIoCCoL4z1VemFarnz1FKhEzfoo5e+eIGKroQSW8zV/0YH+JjgqJ/SeaU0M68d65j53aDzj+BKTkg0dnNrCmWL7fGiVF8dRunc+yLG8w5U2B683bMieAbYX/cvlVk3ypOHoSIrmY9v9c+pAG0jgcEyubTIs5R4++7YkcR1ZGe5OWejfHyLoB9UIgN/SolL9Q0aCFe9HPB1dgEhuLGImUOMzzW22B8TPS0YLs2dtAagzxSbYfud6e044tgVnJ9om+QOZ8UQ81F6DQB7MBob3coJvZVl46S6SkR+h6U5/RVKCqup5DX/dvQZyTsC8tl00Q2KTqIDwrm+ha4ZfO80dg3xvddLUklRh7DYd68ZEt3+Hap1AN5TqLchV3JCUzym9QE2t4hP7y3haXHwgzvyzSLOq3g31nqCRhlkUNfrvkbcGI0PPVKxJL6yuVUYhJgpLbXJd1fakNUvI0VUPxboWHhj1q5GqGerbrPlsfgrwVrjNgcPaLiFRrZQ0Q647Nuvu4no5gxD/43H2zjOBwku8NmqQNIAchK23ZRU8XPkbVe4d6sTN2iPd+zo8oBAR1rGeGQwhNTwyk2241tgu9hmEzavv7h2f8ElELK2DeAZ+TzGuZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vF2VhitbWbM480GsKnACWBg7tUKTK2SBytxj+Hffph4fh9fRFoQgxcRElSS?=
 =?us-ascii?Q?rv5v8JC/F0cM6AsbQDYvXIRVPzqpgyIdf+7sjjyfcv9GvY8/GBB4KCmauXq2?=
 =?us-ascii?Q?SqtBOAwfk7oSQ3OxMM5Qldp7nQioZ4WpshOgbovlwrw+NtBn0bUIoYIty0+8?=
 =?us-ascii?Q?ROrJWK7Bw3b3mcM7pr4UpPw/TWL5BrWz+Ofn7MzT1ntvOXiCpIqN2fTv48aH?=
 =?us-ascii?Q?RTaN7iutIFRR/iSPgsjUKCJitIwtwr6rl11keUCCyBxU1/qUqpqUJx5N6pPd?=
 =?us-ascii?Q?zdy+UAesyPZwXg9VMfRQvMfmCDPquEczT6EYZMNJtdLlI9KkIK0VugV7nVxq?=
 =?us-ascii?Q?N7p4gRy56KjFNZSnrxY+t5Lc1rSV71y36u4VVZgNmQkfjje/PcP7ucf8QRZH?=
 =?us-ascii?Q?geyGthLmRJRy16INYnuFMi3s0+li1Wm7eneAu9759TuqTxIPkwv0U0nztoyN?=
 =?us-ascii?Q?XXn62ZBeI4z+l1GXo3IBNMOkuUtNTCD0v88a1EFzmGeG08KvGriI4dZwHjIL?=
 =?us-ascii?Q?Dcj/OgbvyGA50BcOyEkScihTdmEXL9U2mD9eko8e4K/I8SnWzk6PwgkUPKoX?=
 =?us-ascii?Q?nNmSZsNzbLoSgXcvZjk7n+QyrehUNiyitrEAOZoXlvs7MCtQXEUG1HFzEThh?=
 =?us-ascii?Q?F9n1lzs9tftgNhgOm5dSap1H88yJ3y7xv1JWxh0DXIFRysnf3IxkuD7jTe8L?=
 =?us-ascii?Q?vg7DrAAJE7W0DxLIp/JirmunTKhHo6d6WPbycHmjNA53U+TopEHK1/tMp1oc?=
 =?us-ascii?Q?GQRi25FpK5/Ha3Jk1U3wOTkSTj6vjFBIBM6RoU1WOHC63I6qI+OABxMUwjt5?=
 =?us-ascii?Q?hlddrjcMxZiAmhKHb1USx8EqMSar/GjWiaynzk2ELcOMd2GueRDR4ScPl+l+?=
 =?us-ascii?Q?vcd+tK5cvnaNQuIAWfE7B7Eu89+xCKOdAvAfHtL+yPR7WwruT/iV4ri35KEQ?=
 =?us-ascii?Q?yB8coJl7GGihFu52uQxN7NjnRBabPC1mzPPPNY1R8Qq/ve95s8n224jV2jKo?=
 =?us-ascii?Q?KzU6ZF8Q+IvVWW3olqRn1KY/AX2WKFtkiPQPKaNl0KadEqSGUlupWzb9vB0L?=
 =?us-ascii?Q?vfOexyIWdpSJT67ZwJVWV9gvnNDVS47PUrrHmLZWo20KF0+zwYTP3WwIwbDQ?=
 =?us-ascii?Q?OO//SwEZKeQElN6qVQbqqGXKEceLqeXE9t2Ktal4dDwkIBOf3Bwr5R0oKTNY?=
 =?us-ascii?Q?dA4KcQ+MqzrSPf+xK0wR9N87b9sMSp4V/h03+SNcCF/DHyBmyvv7pAJVmK+X?=
 =?us-ascii?Q?b6xeZOJtjT7Y5LBVyn7j6PZXHjHR5lRyM6cQX9+YYXHOeyoShoGsgKymQE8N?=
 =?us-ascii?Q?e0iLTdM/6V5YVgVBvNqSRd45/FWqW9JJ1BC7sWHHzHvvgA+9lO96zyWRLipP?=
 =?us-ascii?Q?V5ttq9wBfdoeDmVclz772f2A5+FjnjqWL8OuBS97zjuMuXeA7oShGsolWuMa?=
 =?us-ascii?Q?eDS15uJDU41bcT8g6wSuqlxodg9uXDJxcEer+O76AxiMzJU8tn06jb7jO8Ur?=
 =?us-ascii?Q?GtF8pvGlQYiJjbhay3hVEVPK7Xf3SQRE/rpmFOAiZSE+2Mg3sR+2D7zxbTTl?=
 =?us-ascii?Q?2CGhVNA996PfHPwPzEbZJbVhrpNn35OhmyvDLZavGnZReLM+tsub+rwI1fCr?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df892fd4-1839-434c-c90c-08db91a6dc8c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:45.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ2c5aII9lvG1LWU31u0+JLhZTzMpvD4LXc+v/AMCEfULtg0NsKBhOcF/x831pwYJ7CqxHYeTzJz6wa0G4K7bEcaKdl/rjuod5RrAMiEbyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For TJA1120, the enable bit for cable test is not writable if the PHY is
not in test mode.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index a52067da9dbf..92a2eca2a02c 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -145,6 +145,7 @@
 
 #define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
+#define PHY_TEST_ENABLE			BIT(0)
 
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
@@ -1258,6 +1259,8 @@ static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			 VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
@@ -1299,6 +1302,8 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
 }
-- 
2.34.1

