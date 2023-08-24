Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6D786B57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjHXJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjHXJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:54 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EEEE67;
        Thu, 24 Aug 2023 02:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d96RtTeURTrKVJCGdNyiOkbuyzDXGfMaKClztol2/So4OkkralBQHYgjo/ZyXac7AWp03FTk7PDUF7XHWO1T44/gfDyvpg+U5NaF0L0Y8laTf89tu1PZxGbMqYQO4JZc71E4AL0m2oR3MjmucrTlTdCExmeGiGPhK3VIUYP2Tdbesy0vmlEvBqGo5241r7w7iimW8B6+mREuCYiv1z99tyHtjcpZxAxR4SCvaWXJ3In0lKsWaMW25n3eEHDSO42/L/0HAgS8m6NkhM53sXs34TeV0MM1iqs8cP5h/9NQXDENk0oDmjEfk8UaoTbPBU9dGZ33nFMwXoP8zPS0WTMM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgx0pUFZM7N0x0EXfoI1OD2JlPRCOyOFZ6OmvcuZ+tw=;
 b=clvE8/ZNFPj0/4gsbPD3cVZkl/3mA2yxiTyWyiETGHl0pnBN2cAhXjx+WJs0HBB3z4prQGW24yiKcatWLTTNHBb2y77MtuDYLvl/wxhPeA+5ZrdsSuBJcEo7LxmsSHkD1qBd7kNIXgwYy2d1dW+rZ/R2sNy3EmMxYVG6YWU4PFmITjbDOOaMvHfIcTH9Yy4SpKhNU/aharjwzxIwqNuqgzdu7TiGm0qQcp+xXMRlKsEAcWTmvefCP0kxfbMq8SnNtYR7DCAudarV5EFDggkO5hPd3NWC4ku+S0V80FJuaCx/Rk75a59wxN2nVTasO+fFX14pciAtnKFgQIfij6yYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgx0pUFZM7N0x0EXfoI1OD2JlPRCOyOFZ6OmvcuZ+tw=;
 b=fW0aVbZmPh8yB8LJkD0jLlHU3bHm3kN70vlNO3O/9OMofdEF9WIkKF0VzrYqC+LS2wOypT4e2uIf259hQyArS482hsQN4Lp5p2o50hx9uFmh86BWqCrczcz3DfuXwJlg4eHKIalO2BMcgws3L00Wkhi2Z5ab6gS1LAMXc5o43cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:49 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:49 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 1/5] net: macsec: documentation for macsec_context and macsec_ops
Date:   Thu, 24 Aug 2023 12:16:11 +0300
Message-Id: <20230824091615.191379-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: bc73f032-9cf3-4c15-c953-08dba482d8e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJAY/OdrQ9y4AwPvic847JtKHLa6DPlS3PeEU8wpGsYCUY+Fyg+OPH9ez71foUkeGQUoIeBhZ5jpukbZXVyLMh24eywZAQF2wZd+XgugztSn8e4whP757VQZipFUOd7ak3OAWH04RlvhPCE2BUPqRED4gVb4TwyguIqVrj1CxPq2yWP1yUlqfvJfUQFdki5tGmw96ocS5ZG983xOwN4U6Jlm9nxb7ZMy1Ufseza+ALsY6V86lQrpeHgORy8nUq0H/1KRlzjYYD5CALFJhPha48EdTm5cT+7rZTM5HCOz/w7u/qxZV9AERNpj7Ya4IyaGxpdzjaEIe+O+qadVnCd14DN0WUsdW1orWHZ9H8h9JG0NmfEfoIih1zdsH3O0+Co5G+DwhNnbBw2DJDheLRICUnuXm+fMYR9JElaIO5vhKXu+0xs7RWVNua2EFsGt4Tz7FiLfRocwyduJmhpSx3RUunBjXmz9mMb+y11M69PTkk8RClVjDwWYLt99jzaypp6Pq978w4OJ9VfUAiL2fqKLJdhK6qfR4QcMG05K3XILlHp8pRAUZEfMF+1V/ujEhZgpaRsvkMKdstI10b/cVqBF3UazmSAnv/H7AGnISfhzDtotC+YihvNUNmzfzvomMmS+TBZW00AR0EpzyjTuQe/bAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(66556008)(66946007)(66476007)(316002)(478600001)(26005)(38350700002)(6666004)(921005)(38100700002)(41300700001)(52116002)(86362001)(6512007)(6486002)(2906002)(6506007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrdinqX+XJ6lq8q/KIdc6lui+RYMF/7OL/XRSSJGDzIuSEOZc2L9KoWt8hKY?=
 =?us-ascii?Q?6LQ5zPNT1QayETTGklUbNI1Zc/aJsaJ8XUVqcuVO6F8YhDHzCfDqCf4brs3D?=
 =?us-ascii?Q?GpQMpAqtkIlNGCFLF6qRz0H2Ejsm/MNP0ZE4XTvryLwMpa59lkQy3jfGeFW2?=
 =?us-ascii?Q?AH7kNHkkwm4TKHJLXP/D23t6QAAZ0INj+ouEgHosplzwLlUF5qhq/kXbKIKD?=
 =?us-ascii?Q?NQKrQ8BuIlgXMuHg+swSyQqpHbZdI7w4k0Ok8WtjM5b2MlR89T86Zr2LCMNu?=
 =?us-ascii?Q?oiQlGqFCke9BEFawAjWa2TU4yGXNChFbOSvMiXBjULI4pBszBPXeescDqw9W?=
 =?us-ascii?Q?yWf6zRejrfEJu5yNfo94/s8/qSDbVdTQXHf+DTMFlwooOouWEjgu6P0spXSY?=
 =?us-ascii?Q?FokZIWGQX0VwjiDEtpWIKC+6052WNCCwXAftBYPuQ38aSSPySxsqyxcDn5uM?=
 =?us-ascii?Q?Ptn8/W5tQlMEfjLG6IyW1RcRg8U3xIbmnyLM4q2FyHSxU+LSTd3KxnJrRNJt?=
 =?us-ascii?Q?znGcqq2aoS0P+uhYbxSroppIKGGjZCy6olLyfUCcChoKRsy1d+65ZcQyLGsE?=
 =?us-ascii?Q?s9Nm3Ev/9YW2xZ0420NoWMMRz2ifl9gzL8eqbIrPqpSAJlSF+zyQ9Y8W6aHm?=
 =?us-ascii?Q?zqAgx+5/ubKFnIEzkcyRczWJzc/TonXlVPuyYn3TMGY3X037jL3wVfRo45Wj?=
 =?us-ascii?Q?/Shg+DRC7vrCp83AKVvLRkr231J/IKHBX4JeKALg+NAOkksUaMQAd4iGC1XB?=
 =?us-ascii?Q?v2gx36+jtUZgho5o/gyKDE7bf4MveMd8y31qH3JoINP5/cSyuUq1aipYuic2?=
 =?us-ascii?Q?WnBIpUlfnWu4gIHMgn76QlIpZTJ66+FoIOQvGATtsPxqyh2tDWh2CVEYusTI?=
 =?us-ascii?Q?KmOIzVzg40dJ68f1R6DMkeyE574OTzOUfJa845tttocE3+dPae42525TCjIX?=
 =?us-ascii?Q?hlk2LukiHa9UxDjH0KvWPEw1/FiLwcIZuLT8uAAItssY7HS+h8JAisCPXPPL?=
 =?us-ascii?Q?UCM4PDun+kQSEdBaXUh1v8ReglWUpkvX7eESMj/FEq73M9PJHm6FyPG/diyH?=
 =?us-ascii?Q?2D6q5cHstD46mV2QRd1I1DRAp8U9P3bV9Lx9hycd/nVYZbbG7saY6YIMaeiG?=
 =?us-ascii?Q?LaRfM01KFVlwGeQXnjClGvL1EncK5/+IEppqgC8kvOyzYFYWZalo/iwVunHX?=
 =?us-ascii?Q?4GTe+wOnnXvk9+x9OACkdvvmwn3pfjkzIJDNzl+nmWw1LpXVtRIgEkcbv/e+?=
 =?us-ascii?Q?YcCIK4HqnoJo0sAm2Q46950px2zzntYLYqXC4V0LhebuQnCmOTZS9k3gb3gt?=
 =?us-ascii?Q?pCELlotQQ9lSMZH4TYcCDyUMUjqWN++Pg0i9e830GPB4mGCc0EcDdh00n7Xz?=
 =?us-ascii?Q?ldJ1sDPeQ4K64n9rAlg8ycsa/Guwp8B2T57KM/JCVA+mQYUhmITgHEcVZzYM?=
 =?us-ascii?Q?4NRqCPuTeks6P7bqasOfcbGnyF7B4zQqsWIZ3Bybx33O9TqEw4Dh1W1Q8LRt?=
 =?us-ascii?Q?QsbW3T8vfF7O72GOTK5kqHMxFaaruLWl7WlwGVENmQwtTJSf3VnRyWbHijTc?=
 =?us-ascii?Q?58lpg+iVkysL5mzEdgmuaLneopaotDlJxt85eGw5cFHBIHse7enWW20anWYH?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73f032-9cf3-4c15-c953-08dba482d8e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:49.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWWig6xyQZD9DN8EJ4/A3eP9j9GyXQ/ZShBsTcNQzgS24QVHIBOilIDAGy0bYQkIcsUB2PPH3a9z0IG1zMzBTpl96TEpl7rA0XJCDfilgb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260
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
 include/net/macsec.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f..76f024727bb4 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -247,6 +247,20 @@ struct macsec_secy {
 
 /**
  * struct macsec_context - MACsec context for hardware offloading
+ * @netdev: pointer to the netdev if the SecY is offloaded to a MAC
+ * @phydev: pointer to the phydev if the SecY is offloaded to a PHY
+ * @offload: MACsec offload status
+ * @secy: pointer to a MACsec SecY
+ * @rx_sc: pointer to a RX SC
+ * @assoc_num: association number of the target SA
+ * @key: key of the target SA
+ * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
+ * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
+ * @tx_sc_stats: pointer to TX SC stats structure
+ * @tx_sa_stats: pointer to TX SA stats structure
+ * @rx_sc_stats: pointer to TX SC stats structure
+ * @rx_sa_stats: pointer to RX SA stats structure
+ * @dev_stats: pointer to dev stats structure
  */
 struct macsec_context {
 	union {
@@ -276,6 +290,28 @@ struct macsec_context {
 
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

