Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCF7A358F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjIQMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjIQMjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:39:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91B186;
        Sun, 17 Sep 2023 05:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUGHTIZW8Ce3gnyXmYQDL1p4s6ZTMM5+IW6677Zq/4C3GCsFQBCM2OPmiQVpnH0l0WmRJ8R8ZY6BGzPKt/xDM9xHKQn5xuL3NExUQ+ChKCsQXtgu+j1rVoT/AzsD7NN1xooh4qQgr5UpdDdPGIrMBe+alfU868Qf+jBDvkyEnedXsXSkfDqj1OSAqyGvw9VPmFpNAIUfo9MQAp4FwVomqop/9PzibpXPr+xMG+AW/KkKbpyY9fTqdqV2HzD5e8zH8G+yoAfSrRzZN40mSGHXfxXIJDpEzWk6ap89qGHwSyO5vbUfuahV2dpVNVp59l1BBNolCh8xlaBlS7+pd22iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stq79GsEWG9ge9V5k2+Db8k6wKeQcCF/1WkCVehpe/0=;
 b=ZDsFcdtNQVnnfZsGQbrznSRItFn3fv3XoODfNgsuD/wwAjE1o7Jyi/L/a/caL+RJ7iCQiG1dVH7yGkQyoNN1HmU1jcdbcthBuVYlbA851JgfRSOEvvO3cp8uS/ZichtT19LBieNkwmetNeXlD09iiNYUyVajbiN1eLGX2PlXVWPIA9QEa5zKbLUtO3ej5PneZ6jh7fwG2Hd1dYLgHX2p1W4cGyQb7k//6tY9BT/naSwGmMBJlw56pKktkxgl8UQO5+sx0RMKiJRQXdlS2lEBItM8+Wm6+rBCOA2aYdocArg0SwnhTR8P1fsZ3a1v6QRv2eMgMdSAy4zPkjx92wfvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stq79GsEWG9ge9V5k2+Db8k6wKeQcCF/1WkCVehpe/0=;
 b=e/R6IVopLRsmEzHpz/bsNxBzVEfb8Z2yMAwVTA9zqlN/863KngzCEQVuj7wu+dc2jk3gfCUQI6Mj7ZiEKNIj0qNlSU0heA0dO3fyx+cgcl277DUHXr8fpOMbmE5S+8TAepwWQMNUjbQGyQB3ukuS+Nc5ZYnXsuuqvu2qg9SQ9G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 12:39:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:39:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 17 Sep 2023 20:43:50 +0800
Subject: [PATCH 1/2] dt-bindings: mailbox: fsl,mu: add new tx doorbell
 channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230917-imx95-mbox-v1-1-440245287356@nxp.com>
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
In-Reply-To: <20230917-imx95-mbox-v1-0-440245287356@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694954643; l=1328;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SMT+6TJT/lDxDpPxC4sTuV9SPmODEJcsNo46pGGAOQc=;
 b=HmiFQtfXs5ztaost6caog4qHEGYUD6ea/JgO7UkwVn0GoM+kjLBDRr0jDoakZrpjRjhB0gle2
 3a4umNL7UpFB69/H5LvD3jUIPP4e8FGw+yMYJmXBxB38bRKsAwVYPoA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4245b9-a561-474a-a64e-08dbb77b1b2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yuld+BE1KJsceY/ODV/ekMouinKzn1rVvZoJ7HqO/nUkvbDnaGQCnX87wfU0izxU+r4zZmVQGlzEj0JPSMUI6kD32nzuRD5vkAJSv/ZqcqRm91MwsDTQSYrJ7HFhWgEwMaYRtwhKKk01T8mxuZnPOhLnuhUXaPKchoMS/uwZX8tBXUM472BK6YTJywfz/QHd6pe6i8lX6l1zPRzOIao3I+vT5toSd5bqvaaOlDjT7foP7YED84rLZaU9H+TfGcsqad/ykth/eLTLSlVSPa1XcXXganl+z4YMSri9ckOigsfNjfYvI/XJvSJjge9OAd6uFMMb7IngpnW7iTVJu36YMEVBDQH/2sw9LQFN6Yb5SQ4YGwDAZYYuKor33IY9iJZqjh5As5gI4PoBK3sFo5g7k6+87s4BeSQHhvf92f7zUu1QELows1YOMIHkk8I+gXGQclrfu2gtY+PtP90fI5H1PWs8Q9dY+eWoeWd783EZB0ClpmGJ4b6MkxZSZREVBlRntOnqYgXJhpTkQgeX18xRYXATYAbf9tfAITXTvXT0420Ev708FHPHPY07kszM3TiOCyg6U05UkEuXbJUVyCEqaargye8ICgGXLc2AcR54ZzVOM/Brc7KwOk+dy2KQcQtnjFhZtJ/JHh1WmZ85UcbdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(921005)(36756003)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(478600001)(66946007)(66476007)(5660300002)(66556008)(2906002)(6666004)(8676002)(4326008)(8936002)(9686003)(6512007)(83380400001)(41300700001)(7416002)(110136005)(15650500001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC96V1ZNdFU4eFZub0N1NlZwNlErQzYrT0dhQ3RRekdjZVZtWG85OU5FMWpP?=
 =?utf-8?B?aEtQdzlJOWt5WlMwTjZlb1R4Wm9FYWh1cXBXa1ljY2dsT2ZqVnc0MzNwNmla?=
 =?utf-8?B?QzhkdUN6NlNuVjNHVW9SZGVVMW5KNm8zNlJrSlpZVk5ydHJVeEN2WENYMGg0?=
 =?utf-8?B?dE5JZDJWNEhncGlib2N2eUtVSE5VcWpiNmprUEpSQjhncDk5OEtDbDZKQmFv?=
 =?utf-8?B?VEpsV2p5akFHWFRqS2JBV3Q1bzRDOFFadWJHd1NBc1pYalJJZXBNMGF0Ty9u?=
 =?utf-8?B?K2pIK2Q2dFNKNENXRGpVZHZTb2NJMFJlSkJMaHdQQWhHMk56ZTA0cWI5bzZX?=
 =?utf-8?B?NTdCbk5KcWlqT2FKSGxOSElwakVEVHc4SFNxUlljTzBMcFZBeXpOcUp6VS80?=
 =?utf-8?B?ZEJQVVJYVGNtdlNxbGpjV1pJNW5SUXFTaW4yQi81NmxndFdzVGtXeS9NOEU1?=
 =?utf-8?B?N1Mrd1QvSHdLNTVOUXVJNWltc1Ztd2tDeFU5K004Ukc4ZWw4VCsrSzVpcXha?=
 =?utf-8?B?THVxZmxUd2JRZDJOTmNESlA4RXRlUmp3U05VVmczU1N4T1FIWFlUV3ptQmhT?=
 =?utf-8?B?cWFMN2d3MXdHZnNtQXRwRUlTeU10NDR1OGlQQUxaQWVDeW5xdk4yUnovdU5i?=
 =?utf-8?B?Ymp6Snc0NUhNT3pFZkZNamZXZno3cGNRZUdJOFFieFpLZWJzbXk4ekROMnQ3?=
 =?utf-8?B?TzRXTjh4bi9XcGMzdzNSZkJBZ0hPcFlEUEQrUEVzNW5FamRjMzlOMXowWFFU?=
 =?utf-8?B?dzhOd3ZnYXUxNHdEMDZmVkNKUlNXSGlpSzZxK1JMZkRiNWkrQitDQnovWGFo?=
 =?utf-8?B?bkl6YVJFZXIvWGYyWGpOWm1PbVlzL0dkNmVhc2RXYkloRS9qbEVJU3JJUWxZ?=
 =?utf-8?B?MHFPNmRvdE5TWWZSWm9TaEVXcmtzUVlNb0hRV2ZPTnljYzJMSlpTWlNUNW41?=
 =?utf-8?B?RHk1N0xWUlFoN0RTMXp2bjJVMy8xR0Jjczh5d2prem10bFl5TCs4bTRGVWRl?=
 =?utf-8?B?KzBzaHpOVTYwcDdHbDF0cUY2bkhtM0JJaHlNOEtLa3VrTG1OdFFDTXlIV1JU?=
 =?utf-8?B?SFhHeUNSUW5zVVhsUWZxZmpidk1MN3Yxa3dnMmF4RVhscmRLdi9adytJT21o?=
 =?utf-8?B?YXFLZUI0eUlPTjlSdFlzZ0czSDA3ejVJQ2NCS21CMEZDb0ZGN1FPdjhmb3Er?=
 =?utf-8?B?a0MxKzQrTmNNcDFoY1VDcW9SREp0ci9DVFdneXNRUlVhNFk3a21mZjV1N0I3?=
 =?utf-8?B?N2x5QTVTREo1TG1xaDE5ejZGbmlEVkJ4YWlyZTdCbUZCQklSNmxZaDJZaHZx?=
 =?utf-8?B?cHZvMHUrTDVmdlpjU2M2MTZ2UGNPanVnSEhRMkVtQ2h1YU9TL1FJL1lmVU5l?=
 =?utf-8?B?ODFVZzdMKzFNY1BydUIyWG5IdU01VENnQVBuWWVEZGgyalVTMGJLQ09ZVVhW?=
 =?utf-8?B?cFY2bFdnUzBockdzWElPMUdCRTlxdzEvTkp0aGpyZWNnSmNKdjZEMGZVMElE?=
 =?utf-8?B?UzVTQi9peEw0WUxPTXJEQklpa0ZNeG0zbmc2MnBWWjVtM2dtZXR3MURncWpz?=
 =?utf-8?B?Z1J1cXk0Wk1OSGhDdjNURkVLZUtnNE43bDNpK3M3WGdsZ2x3Sk1jaDVnQy9W?=
 =?utf-8?B?NkxIaVFvbTAvbTQ2UUNUYWVoUWRrQ2tTbVVPdTVYL2F1QXNaNFJaTUFhaVk2?=
 =?utf-8?B?ZlB6ajNVZnVFQXFsM2pSb0xwMkpGQ3MvRzY4dHIrNHRZMXhxc3pOdUNBenVH?=
 =?utf-8?B?ZEJhZkNrb3hvOWV6SjNiYU9zbnhENm9uOUN3cEk4dWxoR3Nzb2pac29PczZ2?=
 =?utf-8?B?aStZWTh0R1BjK09HTmtJTDBuQ0IrSFVBc0Q4djFRL3VIWWp0WmlockJEV05a?=
 =?utf-8?B?K3AwekJFYTFWQkVJV0NxR3NGQlFMRlpRUFR2eGNkNXJnT2VUUTFjNUpvZWFE?=
 =?utf-8?B?U3QyY0NEVEY4OXpXTXVHTFpvdEU5QW51VEZUVURPMGlxQm5Sckp6N2pGVVJk?=
 =?utf-8?B?MTJ6R2tWTmJMc0VZcTlmcTlnM3V1b2xmTTI5L3V4V1VpbEJ0MmsveTVtbDRX?=
 =?utf-8?B?ZU01MkprejdkQ2RtZk1ydjRUaDhFNWNVNUVGazcrbEtYKy9TODYwQk8wTmlW?=
 =?utf-8?Q?NA3JR8uJzUigLFGMibwZbtUTW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4245b9-a561-474a-a64e-08dbb77b1b2e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 12:39:16.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZnkJsllBmHDNn9oSIIRtCygcRwKZcTQzjEobapomIQN41ytDKzeJMC3uurAnV1Ff8FqiAMQM7MiT57g89kqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add new tx doorbell channel for i.MX95 SCMI mailbox usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 191c1ce15009..12e7a7d536a3 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -72,9 +72,9 @@ properties:
       type      : Channel type
       channel   : Channel number
 
-      This MU support 5 type of unidirectional channels, each type
+      This MU support 6 type of unidirectional channels, each type
       has 4 channels except RST channel which only has 1 channel.
-      A total of 17 channels.  Following types are
+      A total of 21 channels.  Following types are
       supported:
       0 - TX channel with 32bit transmit register and IRQ transmit
           acknowledgment support.
@@ -82,6 +82,7 @@ properties:
       2 - TX doorbell channel. Without own register and no ACK support.
       3 - RX doorbell channel.
       4 - RST channel
+      5 - Tx doorbell channel. With S/W ACK from the other side.
     const: 2
 
   clocks:

-- 
2.37.1

