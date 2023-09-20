Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E231B7A7733
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjITJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjITJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CCB9;
        Wed, 20 Sep 2023 02:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQko9bKJFLaRzesngqxwFiz7HdOGt78t8CpIgib5VhDJ2yA22TmK620M04xLvqcRb2UnybqdSKo8dRGokUSmPCZXFlHuHFMZVbsg+hCRdN89/n6n4mX+t3XwiqiF5WDC8rj5m5Zlue3TRki45ufM5eHG7PAAv6XAzgULfkoIwDDbNBc5E4iWgCi91pPeRkLf55yh/vmYylct7tGrmSO2Bm4ar/8lLferQTySY4PZCBnrQkTMmlGqth9+1kK2Tz/c9BnbZsHrbdLyi/2n5E9f+0f7AA94MHJ2MDftMv+NuH6W5JaMyvrnlTUDIdudMquRxDtACnNXFRLldSoigUT2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87ykIMiXJbMsRPDtmkm2B6yamO//9eOEBdznNjsrxt4=;
 b=LrbfQREYUgsQtrPGeITDBnmf9Ytata9eLT050ovzEertMAk76Vd2DKntGSfOw7dJ6OO8spQA+65jGUUxvbsfQW4TbbWFuVk4aqdLoHDQlR6l3u6HdSF8y+/eOvYRL5dZywqhYUCXyMfNbW4j7TkJEpvXFIgO1Td0zGgVu9JcT5GVhgjBhp2uTZbPedRR1YW3p2RhheiWn+gsRGJ17bgqgA1YNz+/zK9jnKv0Yb3TKEiGussZjXYUCsSydBakoRUUQLWfxvN2etAxlcTEZe7Ns+eWsRcZx9Sx5n418u3PtAc4f3AbKTl2Shrir1y/iy6jkIlJn1I69wpfktobeW5Dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87ykIMiXJbMsRPDtmkm2B6yamO//9eOEBdznNjsrxt4=;
 b=VkQ8nxhUiVbDYIofshyLPNklKELCVhL25D73sVCVa//iLUOeH8TAqjKGVxjQfggVoIacutu1MqhGMBBHy56/w+5hhBAfE0wn3Pj+Y1RivMgOYPdUvV394zqFOEJmZ3zA5TDeyivSUMxJA04nLU+8bkxak6Q+vNIIQKR177gzfIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 09:22:59 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:22:59 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 2/7] net: macsec: documentation for macsec_context and macsec_ops
Date:   Wed, 20 Sep 2023 12:22:32 +0300
Message-Id: <20230920092237.121033-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VE1PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: e09d50d1-991c-44fd-11c6-08dbb9bb2e6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfUScNLQawnqB1MKbOPI9UcupxHbpXM2Ot7swKrjmko371gnEN20PJRIarK71/3dstyZYCroAuIh3Z6kH7FADOVLibMbJ18qxSRyDuslScvNYrbT90bStsywknkV5zcCZpSeLOl/ssujaAbhVRn8DVbtnvnCV65g3MXB21rCgYZRE4srIvih9cbEI4qaQEqG0LrLj/U9kPqa0dbUOXhNeImAugiYzb16YDDrdkPh7lTlAUeSh7rUsBZMk++3Hy/FRi0tqaG434cEF27wUuUigveCXSdZXD3ZO7cWuI28U7AvbsNDl7xLP48C3/iP99X8LmzsEpyYp91vXOuU4HC/64FsRhiy6ClJM8dbsL5ejibX+MAhr29bDwPE3/wU3hZAcwqSq7+Iw5UUxwcqVtHZE1lovM4RieX8kJ9b7v/i1vNT3bgdyxAi+d8syCZ29nFVdnu443jneu7Pk3pyTAQPtlILhxDbPsVhCWZcljPRWr6Cb5lmTYlTFDXYlZD3DDqT4lWAgOmB+bWJmo42l25lWmolAFMCalbZd7xgFo4/au7Ur0tYhJwpHtaj56/v7S5MiJHZTsRqUsxNL29x1Onc157qx1+q1IWXIfc3nIS7o3+eLerRLieJT3Xw7GFnv3Gw8cGICGPBxdsqN0I0zxzfpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799009)(186009)(451199024)(6666004)(6512007)(6506007)(6486002)(52116002)(478600001)(8936002)(8676002)(83380400001)(66946007)(66556008)(66476007)(6636002)(316002)(5660300002)(2616005)(38350700002)(86362001)(38100700002)(4326008)(2906002)(7416002)(26005)(1076003)(41300700001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rk2nOQ0pHxRv3Se7vHP4NAaQWkCFFtyUrKWALhQ8l4Pev7HITPBh754ghx1j?=
 =?us-ascii?Q?txGdzamIPzIPdygBCqWLBlwj8xy5CbjjwVsi8BV8tMAfQeBgjghVkQLU0bY/?=
 =?us-ascii?Q?fiMUaBTOf0Miojbi21xMnK+LXIy8T/HmPXmfJWLXgE9ZG/FZSnOtMQnm3FCu?=
 =?us-ascii?Q?J1BTLbRzP/l/x3Yu36d3rfzMv2qrlJAP5MNYecfmwqckDWCIX4LNZu4wDGzI?=
 =?us-ascii?Q?SrZFB33DXF/qO21ziHGyD029AC1+sZxDweSP/pA7svd3yegnXvrJm0klJqga?=
 =?us-ascii?Q?jn8S4IXKMdtfegd4NoIlCcy3HUw04kxTjf3T2s2/c5JYU18xTKulMe0sre4r?=
 =?us-ascii?Q?frrP27YhK0bUmml8ZZ+jTQVDs3Dx1U6Ll5MjSvRqb4yqfLwaZc6nlM5WcjAq?=
 =?us-ascii?Q?rnLPkPWun3EvNCBljvmKDH4ygvcO7RnZDg/UWOJjsX5t7s/kTwVcXJTk0oi4?=
 =?us-ascii?Q?uFR6HhhYZ8FGa/tPSeVbPa18mXs6vXt6ssD4vRjDG0DaaBAj6pXmqspndzDg?=
 =?us-ascii?Q?ntZUv4yGim+9tNtxLm3gKZws8aJjjJNm0242fXJ2Sgiain/j7IP7XoGSXVdG?=
 =?us-ascii?Q?yyOq88z+K72yicM1GPAdyBY+WAuLZsUPaIgD1OE92RRjWet7o0HojEb9agkd?=
 =?us-ascii?Q?kThjBJtp4je5uWCwfldRi2V241TNAMGFH3//3N3xZEvd4TpDtTFWPnitL/PT?=
 =?us-ascii?Q?t+CxKwonFUSIPzIMDJ5Xkd/1X0OJ02mEJX7T1j4TnJb4uQCIO0aGe2nH1fTl?=
 =?us-ascii?Q?AVhaVpWzym9tDpqlKM2V2uDqnMLtpRXPNZ7CLSkWEQUXVGYT1uCzDCtmnhZ3?=
 =?us-ascii?Q?xines+r0+eVHBkykumJRk1+6CM7iwspnQG3+qSAdo80Qy4j+/bSOi0Pgzdyy?=
 =?us-ascii?Q?SqJdBiHdlODyaqwsV2JGNA0j/9sTZLvCAEpSHZKziVSsFxnXwwWHNO5Lphfr?=
 =?us-ascii?Q?lzcC13KOpcOaPUpWLRDo6jNyHanMYcIPk/KPGdJem6s+B+NQr/GMn/Kgatac?=
 =?us-ascii?Q?w3nzFQtH56ydWDkKPkH7T3riRXaV6qYAii0ncm2X+OMLiOwU6EB17wt4rkzy?=
 =?us-ascii?Q?Z7e75X6rJTthV7GpkeJ/vY+esKo6d45dqqv77RP4+P17iFq2jR8LMSSIXbg3?=
 =?us-ascii?Q?Rbif/d57qpjfsew9Bvd/43GhWGx0e0eiP1RnKhdzQdfjPxSnS5aLOK6q9zro?=
 =?us-ascii?Q?LD1W1ugcco1QbJ7EN3N7Hw1mzQXiXG+mqOWX6wVOXZil9hQibYx2v5PR9YVY?=
 =?us-ascii?Q?GALXyS3ViWXpiNqdQU4I0OmS5g5vP/uPpTM94tsoSjPFHG4SYt2ektxDRdG5?=
 =?us-ascii?Q?tc/622ZiMUgsE7N5z13Zv+bC/rTKwfnBBmyqNL1hxezlVeBtsp02JXZ54RRt?=
 =?us-ascii?Q?jA25IcuaAM06JxMVTrcYoTZisImBmwp6E5GzlRuw3zRqOvKzuVfI8RZ0fwYt?=
 =?us-ascii?Q?QgEsZhson1BpfHCOkHy9ByyaZefxPK6JAgfc5/0S8qCuLbRXcs2nxPvd7bUN?=
 =?us-ascii?Q?KbXZJlfbVkl3jWEjvWkSepg/Gu+B57k8FZgxqRP4FjFfq0HmRlXduJe65Azn?=
 =?us-ascii?Q?73PEnctDKDJX9fqnJUmJYNwZ8bZPQQB1vF7ZsGH72va9NrPgun5SUx5O3POa?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09d50d1-991c-44fd-11c6-08dbb9bb2e6c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:22:59.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DUKo8kk6kvcbtZ50ZLjvih5emzNtJoHQKTMr/slarI62rEfwccRASwuNXGi8/wYnxanfoIUPJnKxDrnEUL0RSicaQ6ogHXiQddXTKfrSiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407
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
Changes in v5:
- none

Changes in v4:
- none

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

