Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3A7CF7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjJSMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbjJSMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BE1A5;
        Thu, 19 Oct 2023 05:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmb4RyS7QzOztt3XbR/5Az1rwCoV1lI/+aHZB6ScQUR0M3pmyT5UxCzFlx287FOa0KkLGgjJ9gikjYUzEHwyeh6PQQIRlKlvyfb/HLM/lUP8miwo5XHyDM+TWIS7D+JpOwANgj+Y8PP/sPk/YOWikeeN2t/cmwHOLy+ZHre0eb4Tg2unApMzq9cMiWE+FVOqDzuqWGCfaf9SibDLOix/ENtWAah8S+v66FeUa8zqGXe4KC1Vv1IFy2eynRTODo57X0gzb7pLG1Do8vrBb1Hhui8ETVW+zwUi7xjTHBrTUY616T+S6G8kyhbHsmNZsyzCViHZT1wL0YZjJCKUljHGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzzf97LsmU+lWqSsOyQlrJY54xVth6Jr1ark7Dz4Xr4=;
 b=E96vCIp1Hb+eH2njUpONQVROTr8Gw6C9NR0n5q9zAXI0agdOFJVZcwKPWPJbviBPSZQDT6/0PG8SIx2wYW9WVBNwjuPKVHpRVjQGZWZT8adTZEq/7JW9xbIJSKyq5K0pidzl07mSfuKK4T1r1ajYIdJbwyjQgYURkD96R3LuZcDKgBmL0RW7PJ+jz8Ryl2iXb9Mcxe14iD3avRBQLyLEPEwu6kQRRaMmu8ZyBRFoJsV3LMeBmaMLko3pWdgtSYMBBslz05qYpvgAQIsrgylQF2tGdSQcIO2FHkZgjnAnGJKmR2vcYeLZGIFWpyd44tV34WBBfilNIm041FrAzsYfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzzf97LsmU+lWqSsOyQlrJY54xVth6Jr1ark7Dz4Xr4=;
 b=CnvwUIGU+G1aeMKlkRKqZF8BI8Bz2sUJnlVmoqWpXLXnXUDM1r9HdGzyb7rvUGsHI6ZSYjUJLO1dO2ZzRCTo+o247142fOME4Y30SaFru7PbaPu4N2pGgzTZwL4ERWYJZhTpJSabbJLt3jCBSSe69cZ1Gk2p8WTOR3jBWFtfYPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 12:02:54 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:02:54 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 2/7] net: macsec: documentation for macsec_context and macsec_ops
Date:   Thu, 19 Oct 2023 15:02:04 +0300
Message-Id: <20231019120209.290480-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c869b69-0d86-4c25-8453-08dbd09b53b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL5LrQl1xA5AYYpCHilSQHWv7eibXh0XMCgcrDCulfxx5TRONQ9vKVgbc8HJH1ZUO3iHMAnliCJEakQsdHnnEwmXjkmL/KICHmsK2kiBsYtFRr6MP/1KtKGOf1ritUDPTNuJcn4u2McG9aadT2Q+PQ/Co+MkBDCjfSd+Gh6Pi5tqZ/vXU5jYOF/l/rw236HGwQUtr3mxdOYIFby6bJZeTNpj4oW5k658hO9Ztn6dhTOzn8wCqgtKUDT/VH4PH2vLhaScX8TOzqhZQXHAVrhj5HXIU83KWb4arPXPzLGxN1o+JC6nFh4qNvHfTZ8VpytFbIe0bqmE+uO1OiSMuMyW7zG61h/XRLFLLdSQFgxyNhMnXPI1Kmokc2w9lIn1TQPCix/aHTce7Y94yv2HYumDrchGQOnKTuitKJslIarP6DsOP3ANlHtCTwGuclK5SvWBzEcjS/OU+B3kCCYSFKj1t08NS14jeAZPoPkglW4Psp+VVaTbUdLlbmxkvW1XwDiKSDyrxIrcSGMhxGOeA56YkJ3QTqSh6IqFSue/HC/oGT3dfqqSuFfm/l/B4FWX5m2xw950ewJqKpEq9OC+71+VEj7cQzedN8SI8QtvXNErfq6gmxtj7JL6nUsS4s7YzsXq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(41300700001)(6506007)(38100700002)(4326008)(8676002)(2906002)(7416002)(86362001)(83380400001)(1076003)(26005)(6512007)(2616005)(52116002)(5660300002)(6486002)(6666004)(478600001)(8936002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gyz/BvqYgo45mKTjl1GkR9KPORYAxMltipwQmLC5Mqn54Bn4lQk6PXuCiv+?=
 =?us-ascii?Q?Zwst+HUPMbW1SKQsScHBE5wpYRPZFEzEY9C0ghId7CmuWCs64mawX6cYZzWV?=
 =?us-ascii?Q?aBKUtR7amC+dHD7UtY4IU3WAK17yJTGwbRDDTBgCWS1/anFis9BNXSBOynw+?=
 =?us-ascii?Q?Zqq0/bHrmasdK/0ahgJwPEa9qg0uYUPpnldLa9yHhM+QRRrWLniOc4xa3BPc?=
 =?us-ascii?Q?0fGC27i5QbBU4cUzkPst1A0X68Qdga7h/qOgbM5RFYWVG5kmVFntECRqCOb6?=
 =?us-ascii?Q?lCSft3qPmiZrcSp2OdSPGmE7zo1OBTmX8etnkLfI8yIggU/0OUzcLqeQGsWY?=
 =?us-ascii?Q?x03I4NaN/JR1mPga5LmXlRV/p6vWYrxdmKltrMR4GWGqouVx2dxXNOpz+XKd?=
 =?us-ascii?Q?BFrEo/zAn0zl7iqMPDIwausnxrE+0x3HnLL565WrCE6B6c1i4rjydwEL0LZ8?=
 =?us-ascii?Q?OoAjvIEYwpVjK+1ZH3/iA5BnFKJiLL8kAPJfKJAZLEBO94X73TuNPD4Do/k4?=
 =?us-ascii?Q?M//wjzhDIWjaRu0aW1aOSU6JEXWomxPsRju9lo60p00ygOM/k7zHCnk+ELDd?=
 =?us-ascii?Q?t0iEhvYKYHCJpokWkeKhc1186sYabsIAlZQwtKuPecwMnD0i75USJkbqwVnq?=
 =?us-ascii?Q?a+BczRVlLmKxP7yIhWBVvFcwzb2skHTmWU9Eek15HlIeME0Yz8WuLGU2butP?=
 =?us-ascii?Q?0vP/DwchCX57lMU//teuDTL+SdbT4MKP+0spn0Nx8+PeA4f3Dqf/SEQNx++z?=
 =?us-ascii?Q?/PTWT9ZLSerHWUh6pvJYz6HSKSzCfHX787G+fKaFa9PG2DHWZI0blGTrz9cg?=
 =?us-ascii?Q?x4zX8VaaCBwp1nawxiUgyeiifGRKwZfvakLksVSOM+fijaj0ytmLxbQLJRWi?=
 =?us-ascii?Q?RyNZpsHQ5Ko/CpJrk+bhb9m/rS7alC/ULo+1Apg5Kn/NFteJeJbp1B1EGofP?=
 =?us-ascii?Q?H+ozh6+Fq7i2UKymKHqElx7feakDg+Jh3aDhGHA7SI69v0tuzwIbrOrkDa+C?=
 =?us-ascii?Q?ngQyeAOuG/Wk0/gc4X16UtVXmTW03ra+yPmr4Lx4o0H4lV2NppCVlQLcnps2?=
 =?us-ascii?Q?W4qov5Ibx9mBAuXUYx45lw4CtnR5AKg6chZlEVLCaOUm0olPtn0LHjDuvrYR?=
 =?us-ascii?Q?OwR2NgMvRAAJRr85UVOWpY7g8ebj3ARlAV8K3FL+ZIq87kmTG4TqSofM79il?=
 =?us-ascii?Q?Ox7V6iyP+ZRlYCdb6lV5kOJKeagWX35aO2xs/zs11qFB25WKH/LHYH9eiaCo?=
 =?us-ascii?Q?snpIe0WYuYcjauNRyZsQG2PL2RA7fjv/ouNgmAJIjzLa6EjdoEK35vqPpCTi?=
 =?us-ascii?Q?GoVKKZDp86Y18naZedMQzh6mKCljnxmjzeMRqB8ZEtl9wTOxp3Ue4bqjXz7p?=
 =?us-ascii?Q?L9qdP4BAlzSdjbZICIHlHfUt+rFgUDgzp+9pnJ1ERsMn3zwWzeRe0CBKMUna?=
 =?us-ascii?Q?/4Yf/HnF2kThmpDIlvgwX+o+Umuo4aeYj9zcjkF4kvqBiMtI4gZ0BN45w4+f?=
 =?us-ascii?Q?qTsgg2n66Gi3H/AlrvnEqSEnvPp0wcJXv/iWpWhcmApNLVyUWT5c9ISSu8oP?=
 =?us-ascii?Q?jCDcnzx04W77AgjS95Ybce6bL9OKFk6m4nvZ7qzNP9iSZr3yl1AGjAt9J3MQ?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c869b69-0d86-4c25-8453-08dbd09b53b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:54.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETvSnFqGmKXv9MgVgVu4rzzNjhNWZd9qq1RoPPGCdga5vSm0Wwx0CCoVHcHHVa0m9FQ3KJW+p2uv4AciX24IAps3nHLvxeCbrVkrWT4+wNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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

