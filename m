Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD875DC85
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGVM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGVM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:28:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013A2727
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQLu/2S7aIpbsNT2jfJOkULRLJGTiZ0p+vJpWumNbXnW02OWtmNmcmxcQrBmByR5W9mU1eYqWlEDloLcHK821VU2qn7mCly5+KTsfBf3E+SfbMOOG8GOWU5Hul+RPa4hIa5aaaUoCqsz5I580r0hm/m8rAFVpFxi8fpbfgjj3kKItD7OKtCXlakiniKB4do+H6BUYTiFia6Ahp3eDEjWbIxiZEDprZTE/6NWMNbU0BVIFwJs4RD5bI/w+L+R/WgEn2NbgkSo+pG6YtTTAcgwahtHSFB92LpsZoDKap485LtjPT5ISlp3HQ1Ej42v6P1wZlVdl+KeSCIXYqfDj3FEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=PENmH1epunbCn+WwhK/gBQrWCz19xvkzNCtN33FcbJrSQYRRfVLpT+L7WR5WcwyfqfEJH4Up/5zln5nqdPNInVyuuLFZ+RDgrPkHPXQWjoA+spTF/9j5AkFTMvZAe0I6hWVubtEcuoY1UpbgNE3RmlVAkQx78xvrsRV4W+6pSjs0OFfnduIncm6IPDCj+Sn9MtTMJcicWseuHOQWehzn0GM6AqR567xozXDR/zdYWu4Ec2y6xMH3F7i+PMm/LyUOutbZn1fXd9H/BMXEMztjs1J6J1Evx7Rwi7jEkCx6mmxZB7pBiyXzvsQSawZ2/IdbCUbOZ+fhRyorvvZWq5zQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=VHtxXYQ4+VUcqYkgKUVEAtsK6Hs6FJ8pzjsV+lg1s5e973n8Q6sKfiWaTd+q/8PrwXRbAZ6GZCg411O8dGmmmNekNm35LldR7EJw86+daf5VFYgeAGof5dEMCZmazpZbcAzKx9d9NtjphCNAC/xPMpThmRoOr9pqTUewJlVhrEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:27:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:27:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Sat, 22 Jul 2023 20:31:18 +0800
Message-Id: <20230722123119.1966998-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0ef87a-d04d-46a5-91f7-08db8aaef29f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBelwg6Xbe6QwzF4kDtw2gPiQKqJWsLC+6oD51W1JqFL9tyOdzyMQAo8Ceui/wo/ysHvxZto1OvEskhHI82zy120qpUG33XUzaSoU1OS8qopsq1l5bdGALCovQgTSaknoalRNZJaYEjsg5mupP+yd4L/SlV17oxg2SyQWzmeEu5RPEyojaMIWUxqSgkckmQuH95q6+876trHDeY7emz2lT8n7HCtK1scmsQ2lN0uLzlNI0lZjmE7YRw4bJ9x2r2mC7JS8gKliC4JkqzMjangjIhCEsEbHMIW9sT+eoUWYDXWxsdiwRpPWuZhwkgUKuW+HB93uQIZ0oZoDvvLxoWQG5GwbyS7VEiZJFBSWJwbGCMbNlCxCysdaxS822WXg+8Mnzr+STnKJslZ3t2t7XAv+i4k11wQl+VG2CI3JQckf835PONn3QQQdnyY/h0Edil49LV48DJZyAYhUD4gXbMavJQKu7dg0TKSapdhU7N7a5hbDnixzNA61oM5nU0+KA2oC4YGVNO98QAfA5D/uqduc+uqXZeNucrGpKSpzMX1xW+FgwnzbYDv5C3STDnsPr0/QaBjJi7/Orpz7PJU1XNWwx92YBpmpkLPV1tpMMHONModI3KZZmmBrA3RId28izcf7LYpU+153IXv8bf6CCoGjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(4744005)(2906002)(86362001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlMkIFqY2hDMaRHgd3c9CsYBJTocWWVU2z3AZJGoHBgxnZQMUQsskBXAZVPU?=
 =?us-ascii?Q?WGbIx17P2oz/1pxj4QwhuMp1/+jbqtLSB9vTp1R1wo5Ntwte1d1ERtUntRmY?=
 =?us-ascii?Q?Vh1vCWWYrdf7cLQN/D1dxXwWA8uS5y2H6VoY12UBiV4rh4+5oReNllgREprf?=
 =?us-ascii?Q?bJorG3LDA0Q/jRcjSG662bi+9J+zu04ym9sVFf9eEGYhwndEVsm0KBhQYLN2?=
 =?us-ascii?Q?fm4FSmQhlQKMTout1PzB9rtMKaDX/aTshdPkjIAXgyF9t4jaY00V17CaDpUQ?=
 =?us-ascii?Q?6ZnR9yYbkoJzZE0RFkbfO0mBH4o6YOQt5BauknfTmcwZz8NMaddhDkrUxIlD?=
 =?us-ascii?Q?D3jCxnxPw52nJFJuP8CmdwHsw5RrO1lFojrnOSM34SBCP3FUAXo/970X8k8J?=
 =?us-ascii?Q?MwZvHn25VUoJu/990LsJ6NqcjlKbqyvXjWaiLWhit4t6VJM7S7im2zDyAg03?=
 =?us-ascii?Q?aXcg77DbMdLmei4YfQwIxseS3TEXcnxUX8U5bVKHm/KpyUL4HKO7ENVdhW47?=
 =?us-ascii?Q?+BuZ5LvwpXhgVYej7HBR7/RlbcRLJsMftL8Ty5F/sRp8hA/NFmkLPoFbNTg7?=
 =?us-ascii?Q?IHm8bHI3yGN/oGCdxbV/9KIaaoeeFzVRAl7qsjRYitpKuKO8TFB+e2Ix4c+b?=
 =?us-ascii?Q?49rHT9pKPbWHOuAzW7KhP7C/LHwoO5YtLEKnzcJ+QQy/Ml5bQCoV62WmjM3R?=
 =?us-ascii?Q?v8b7PHGRtPRVX1XBct/b5lIebkJFc5BDblrazFW2DidteLZHNwzcDF6UUc8J?=
 =?us-ascii?Q?mU/YWpfNg605eTkDHfCsDlMD2y+/tZgtWEDz2B/P0nINagdunZGF3kJWSKls?=
 =?us-ascii?Q?Wf+3IZdPXhXMJewHanSAZkQBEwm/LsLzlVOw1k95geb5RlmWqwT3+2c5/smd?=
 =?us-ascii?Q?yYZaF3V2t0tsekhMv56T91IWnAbVubJoR8xIibj03/+DBMj8iP6Z4kLZu1+W?=
 =?us-ascii?Q?gvXM7K7PAaZJlNK6OB3QRkIz7bOwyT3hJB9dbQVyR3IhGaBmWAtvkSij78qG?=
 =?us-ascii?Q?hrwer5tjzAzo1VeYqcjxyuFrxT98564X9tKUnYcbqCf8tdFNZtSa4BOnpEGh?=
 =?us-ascii?Q?mKxJX9bite04ECMjVogrfmQ/ArOiYYf5jqyrCruqV/7DMXsXNnWFHmJBEJP+?=
 =?us-ascii?Q?miDTRoPaZN3FsnE8iF6NCW7jfg3BACmJaCM6WeB8w2eEMNcvP//g17l0KIzN?=
 =?us-ascii?Q?OGa55LGPl6AH244R29e8PYBX6lOTpUo8OL8Dn56o5Pjz8JVCvXGW772p/bNu?=
 =?us-ascii?Q?Liy+Jfx/aH2tFUCHS0Jg+NdeG/Et7HVxPfUDxDxnsH+saqJLaLDClGsENgxm?=
 =?us-ascii?Q?AKH7YUpoqVR2GTeg5YaaN4C0Jdl9IBCIY36NfzbjzyD2bU32aY1os+Q/RlQv?=
 =?us-ascii?Q?6Y9+pmgfcBNTo+gVtlETmzpF6hzsE5UJAj9AvA+r1TuvuRxL7DmEUry0yF8+?=
 =?us-ascii?Q?aWRjOWWQN2yBEKOKEdxIWBTQ0w4mHADFNILXjMZcI7YSy8Y3NpzFxXe5qAOD?=
 =?us-ascii?Q?5YyX8klRaVzXPE7GRJZN4gJIQrDcwfR1rcelwZCTWNFz6309zTguKj7FXSih?=
 =?us-ascii?Q?WNZRKLUzs9/LlPmN+uxfgehFWz0SZEhAvnBgwpPM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0ef87a-d04d-46a5-91f7-08db8aaef29f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:27:00.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjOGehfSHXHjpTXVHDFMi9y1Q9nEh82bVCb/3TM6Dfp9UkcYf2vcYWevN+i3fHpBqWCGwdJKF/0V0pvJr0kyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1

