Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD05794104
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbjIFQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242874AbjIFQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:48 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21181990;
        Wed,  6 Sep 2023 09:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErZzb5GP6tpmluXK1YnJMyY96CSE25AfjE8Fg8NloRCXUTtNPhd8hSZNUN4Sb18mytQoPuAC09bg0ekHB/1/bgQ3nBRyx0RKLYf79aYXlmuC01cLbkC0oCgREJ3TgtrnRl3WwjLCoADyhiGWnDEMFXQvg0N65SPxgdjRY6GuC5bVUAx7QyJsF/kQz/Ar6W4It7lGXhV0DFiN6qoSO0V9amPhvPEaXBmoIBYQwQo5+PntRtdPtIXCp9+BUwTf6Rlt4STzhNx5kP1HPacZL/bStNLiArgozt+uDBbT9cd8FdOJn1aatcqkoUmzxqqW+fBHp6ErQ1KITC+2CK7LSaStxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCmXP/AK7Ch/rM0ZNZqn2YZ2Emcr1TjfcMH/KStPt3g=;
 b=Sd07OHFEFayzg/dtGYZbhEQVZZZVIWL+5wmsVe1DahD0w9qBKClUEFy5lyK9bgUDirZgmt+PZ7LItw0Esntud6FuecNTYTcKsHhanUy2Yera/CnFH20N2+nowcqo7QkuTbWkRdkRctcI3FeLRJdYRoLnrK3pXS3rehN9q3cVgRDz5SEUTAmcaUFU1/1s9SsHXvQ3SJ7ZAb6deU9YrieCBCXOP76VYwFYvl7/e8XxaUHgZfHlaDilhpeS45xPESqU1kSwI2N7LDs/Mga7AEH7TuMDY7Icsw0SWKc/eOpgNtf1YiC+ebTpRNLtYFMx9fj0KJWvIO9W3xyvwXfdHrnu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCmXP/AK7Ch/rM0ZNZqn2YZ2Emcr1TjfcMH/KStPt3g=;
 b=gn/1WYfLzeQbAC5gCzqriqHHOcOt7kBZLZjoBB7gGltk9l/ATwM4Bk2zShc3vxXBF/Ah7+x8vT6xHxm+dkF769/b7Qeabkw+jh3TK5mwi/wyyygCBqd1k/dCbkeX+xYz1KF8eipl1eyodqhc7xuGasLjiHyoYNGBDRow9O9wwF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:30 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:30 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 2/6] net: macsec: documentation for macsec_context and macsec_ops
Date:   Wed,  6 Sep 2023 19:01:30 +0300
Message-Id: <20230906160134.311993-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 311aa9fd-f44b-42fa-d6e5-08dbaef2ac4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu1Dh9XxrmPATv4a8vVOAY/qrZTnfdrWDLN97rMJgG7X/D8K5PeygUOIX/yyyvxdb9p78gIA6KZ4myOBQkTvZQyu0RrAKfbdbRSD8PXBY/C6J0nIOXczmdXXWW7EbhervGQOF7EGC5oQPM0+iBzqqXqdAxCMVkoMu68404KFHmWUUR/VR62nhLERevBHJgBCLMbrBkiuecbzJe8MqEcrsZh0kVjtj4qrALouor/Aoaf1H5Efc+Uy0HSb4+8rk2KUZnIkvlDY/XYp78RGxhx9vuY+tdzTcUhMNO1OaI9f4sPn+xortIk4uB5gggFCd3N/PhHudEuzTZ9rjcCkda5aJu53dKaftGmYGUQiuPVbfXA53ecqez2TysFrJpFiWIyupHmoDMomZvKewAEgGAzIuW4hLTm+nXHXsI5a9n2sViu/OMmB8FYwIqACQrMXxC1WVo72dPwHKwc639zrTLRRY9j4uCQye+wwZ/XOXMbqoIqy7HQxHxg3auhD9rh3FpnP3howJ7EeYOm1Pb9qM0jT6dzVzJfSumVeccQBqPNNXZ/DuBa5XoxamIbYKIXWddZTzjFt9zzizltTkKdvJJZqlkWqB/SPkCI1XcNlvxvh99hs1NOxtXuWwPcD44H/+28oUTS1FdVbo4sNBzfSkvCQhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtd7nS88sbV+JXa2ni7hvGNjVYxcZdIBjIYL9wOSfDkG6MwqnxbtPMEL6VBG?=
 =?us-ascii?Q?hXJru+PHNOo3LCz4Jr6opqntxlxDMxaTM3V0eAPneHx02qW4VtBzpqN6cq7X?=
 =?us-ascii?Q?pUIAneBIpIRosoGGxxvsptp6ZvGGm77unulOOwL81NbeVrFuxAiM1dDXhdew?=
 =?us-ascii?Q?6zLZbCQMzyinaUmJRCxgVP7cXTu+Gvcfu9pMChsyeCGZH3RSJTKy8ytnVgAQ?=
 =?us-ascii?Q?azlL9GC2HmRTOPIh4h6nlMmFopR6CjvfC6UZR0wHT/PoaFT60oLfeANFwH/p?=
 =?us-ascii?Q?Enwmov550AdhZZMyQ9DaCHtSjT2wOnlNozhKwXr/SJdI7dduP5ofKiMSio7F?=
 =?us-ascii?Q?HoII95RpC2/XO2HSOH/od2IcT8AyMeIauNQXbUGF9rCvG4QsYrpjY9lzdaVv?=
 =?us-ascii?Q?SEmhTgqkiD5p4fKKwwH9dbUxJj/fQvkLBSdxJ6I19/6Nbz8yLK1LYVs/zFoM?=
 =?us-ascii?Q?pFWc5jy6OQGxvQY5sghpM4a2rtf8d1upG3QrlcrS5lZTi3X1fhBdP3Eoxj2C?=
 =?us-ascii?Q?J09knGI85gBJ+ZLsZZOnjFakI/+rgyA8MLsdMyQg3rDUHBakDMHwrN4IO0CI?=
 =?us-ascii?Q?FV2JMy2fROgEId+E7tdxQhuFconY0p+wOBr+cdIujhUp8lvIzvHYXWu7cdu7?=
 =?us-ascii?Q?nJpYx+MFKwJrf8mGZ0QXjBLt4s4d4O7sRXFDisjNyf4GfYrjfr33GEC4gOHN?=
 =?us-ascii?Q?AgM1SAXN3vXopXbb2DbpSd1lj1SkOdPFeFKUQa8bt4+Jbn2LfHijsmMw54vV?=
 =?us-ascii?Q?a43EPv+rb0nHwmSOJIBxcZgltDz67p3aW0/bsc5Zwe5AP/c4cUAkIjjq8hbG?=
 =?us-ascii?Q?vQ2dR0AfkK5EGaDdzfbDX3u5tUiO5tR2fZ1U1Y80OgvlNQqri5XIeAT2rRWI?=
 =?us-ascii?Q?x65SceNhuija/AvN8bSIx9p+8zOT25tmawS2G+AI4gnNJQsEe3mPqznxxBdm?=
 =?us-ascii?Q?/vMsChvGGnjnaNCi1ul/sZUCBU+4JCmJJtdr+O3Ocv6auDBQT8TCCjDrUE4D?=
 =?us-ascii?Q?pyTfuYJ4u9eIwldNQvHzdR8ddWrHfhtkXIHjFap/CxGUciGYEJlpDyDxta22?=
 =?us-ascii?Q?ruUV6J13aq1dZMfRPo4YBY4TxC+PgW7WcSk0VauCLKEACAtg76vreHhLtJt8?=
 =?us-ascii?Q?qJF8p5HQZ6EcExQmBfrU+YK92EMPdRrXj3VjogJpdsUTDOqyXzli9Bejy17d?=
 =?us-ascii?Q?B6J1iXhAr7QqXk/TEQg6TlDtS5YSillgsXWHG4KWqU2tuHm36tJMhxcNPB8D?=
 =?us-ascii?Q?GASgLCDxpOpKYpp+MUF1ElAbvunQhuyCoGoO1CmvKLsUGkEGOOPFqvekYkbR?=
 =?us-ascii?Q?uvng3C2VvUBta/uaDVnv2fOPXXlDDRaZ3apqcC7qb+Zh6ZngJSZXh1gicrRe?=
 =?us-ascii?Q?quKFNDrIBbFWStw6nxeWE5u10cb7664ZFbVOha8Rsz/UYuzc1Gt9jx2P8rnn?=
 =?us-ascii?Q?aLLVTGDASFDU7RFIzbr58B8l9w90pc4ZfMSNEiWhzvyZFwGzwMC+BPgLZWIZ?=
 =?us-ascii?Q?J/QAmNaSaj2g+S1NkBrec+DMLfUbBSBo/0TXAQubLwFeeFAeZDb/rz9V4uNS?=
 =?us-ascii?Q?GI3Ps78R1rshUB3q48eTkVydc6PCW3uN62pWT57I9cY4wIz5KQMJvJ+jJXhq?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311aa9fd-f44b-42fa-d6e5-08dbaef2ac4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:30.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN8NsJlxQF0gVo/FybdijoIcABUnDnGXPbw46hxCG+281wWNG60Veyszs7Y3QVrQCZOErDJtFe7YWfwL7eyEs+xOTUVpp93NVuoOjXY9GZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for fields of struct macsec_context and struct
macsec_ops.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---

Changes in v3:
- improved description for the netdev and phydev fields
- fixed typo in mdo_get_rx_sc_stats description

Changes in v2:
- patch added in v2

 include/net/macsec.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 75216efe4818..ecae5eeb021a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,22 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: a valid pointer to a struct net_device if @offload ==
+ *	MACSEC_OFFLOAD_MAC
+ * @phydev: a valid pointer to a struct phy_device if @offload ==
+ *	MACSEC_OFFLOAD_PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
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
@@ -276,6 +292,28 @@ struct macsec_context {
 
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

