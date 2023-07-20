Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78A75AA81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGTJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGTJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:20:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDD7685;
        Thu, 20 Jul 2023 02:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WblEmVHgEXWW05gSh8UupR/N3s713A2GSuLPgJMMwA0xC2mJ7tk54f5pwNYHVoR0ADjsOqLNgVvHhb+L8TeufazD8goxHPKFNEqOrjU5fONxmXh87/pa1fwirYet/Zv9OJKQ1WTCfcR8LJiwN3xbSwQ+Lst3jXlGM4PJ8WFPAcwZJSddjJ/vBW4E0gCnHv+fMlQxq+otwcM2lwT+fxo1rH4LlIsrGyJKr+8qdfi5Z1j7cNwxJglE00ryBvYQf9NmFmGoZL2aaWYTDyGt6UQKgSFGZy9kOwQMcg+xeaYlAQrVishTJbwTjxcKMv2XN2cIy4z2CTb4RtDfm9HrwQd6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1jq0mu9cDi4fqyhTjBuenl7jPGKB8P1/r7q8Mn14c0=;
 b=QMg0pm0ImfqllAAkcY9nehvlxNsQoxvwI4GWKsw1lxz/t+NI7FrmOgtuCJye+tZMvZXmpKL3h/TuAOV0MSDMMEYerTPF2D49u/+gnpBT+2QH64CjZ6rBujE0yWVuemllFUnS29jLh7a3EOdGkX8rK+HHrkC+E3owpXm/rkorub3oK9086fcLhCQ2FnNIUfv8Wykw+ailFZESdNeNv0SPeYwybxQ4rjFbS119QMOjGFBIhwyYsmWnnsClHN8vZZbl5+q4P/2sIdy54jRQcBKcXWOBbGzEWFMzIuSqqbjPj1lPY9C3TPjzDbEBDCT193qZ5+czs//qewVpLZ5c/mzTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1jq0mu9cDi4fqyhTjBuenl7jPGKB8P1/r7q8Mn14c0=;
 b=Mgajs8J3ajgcYK/7sf7zBPKWOiVADHxy4EEUkCROi1pPe6VxwZnaa+YyzE4cn9husx9WkGY8qLzA1ehmGD199x703606bD/TMR3E+FwRvD0cEtIDRdsy6G0a5KBeLbQ2eQCHbJfIfdjrZ+mzqeWvghygLqxbl6OfG5JHPCJLmg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 08:59:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:59:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] genpd: Makefile: build imx
Date:   Thu, 20 Jul 2023 17:04:43 +0800
Message-Id: <20230720090443.503525-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7ab4a7-7856-4168-4650-08db88ffb0be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI2Hn2MGqpKvzLs0o+LC0eEDQ6UKHesaJiSMCDRUmrhro18/ztxUh3Z6bvI3zRkmyksHzj7Bvcvgjv7jWs732IS7WbVtooSuK4X4cpdKv2RqjQOP4BKdVyyDRQPvJscD/NN6XCwqheAx2oka3z/US4BrQSRyuTxh1kC8JvklNdf5R9haz26unox9Ac4GCxXLmrpjZD4yK1ZBSHt5Mwf3pVECldeUVNLMEHPicqM6WX+bwkPHfFsA9qrcysQhfrRxiqik63V7O+bROnYbWRTNYsZf2hkMx9siUIsMvc8H8I8qgDn8w03ggmC4CjbhWVzIC+GNRdEWkL0pBwLFdYfmYbRw/yl3hG89f7CHIbhdd0X+WwzcfzF9h7V4IKQ3wysalqkiWNN/t5YB0KsBsCJJjaZPK99Si9+BRICTU0Nnng6pa+9OtNrUSrAL99SR5dAetfWivfZld2owEBq9uYlN6cGhw1VljdsibvEGFIY0vRyRkRDyhatRvhkNqixR/awmMSPMiZcsm7NFnoPPOJA/QwOq//b4+55JrGNgwiQbXyQFGIduQk29OJLnSBJ+i5yP3GWqjevRT9IHpCJCsj2Ta9hSDsmZHBVHmL0laVswKt1fhaaY7rsyaN95e0oJLxaZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(1076003)(2616005)(6506007)(186003)(52116002)(26005)(478600001)(6666004)(66476007)(38100700002)(4326008)(6486002)(38350700002)(6512007)(66946007)(6916009)(66556008)(316002)(8676002)(8936002)(2906002)(4744005)(86362001)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5ucqaK4myfngYVY8obcOs3dWjlI1WKwPSitPM2SU3Oboy8upt+hHP4km+HH?=
 =?us-ascii?Q?/BAHJtX/OsFCdsiI3kdt/Q8vPHNpy9b6VXDUTufB2e1mAO8X5WVFTOLgPmVO?=
 =?us-ascii?Q?tCokjqNo/noQQSsaNRHg25X9kf/1bpaUJ+1p5Axgw7pEgyzP6xjptEVNlRb4?=
 =?us-ascii?Q?adCaqkYWDhSiHaoSLiv0dkQ1xUuErTl4adiy9FvHEgFRk8VKmeBkHfl6IfJr?=
 =?us-ascii?Q?MY3ylf0DOH15TPnUgH2O3oJlBjVkodMm1MRcxybTKKBHIiLMR8xRR4TQiPto?=
 =?us-ascii?Q?950tmoPo08PNyiI8PbBMQMsgk7FE2OSpeOhusCC3Rza9onmtfqLqulOMVH5+?=
 =?us-ascii?Q?3CgFIAoQbsp5ottYCNi+rNxan9kcDnNqsNesBIZL9iuw2AUgLC/xwBr5lFvF?=
 =?us-ascii?Q?YPaK+K69xupSMevFWt6EFlBj4oyBZvNibUjBwvajC2did2r9OdJ8g2fzOiu8?=
 =?us-ascii?Q?D1VQj3XjQ8/8IdcKbz8nZGIcM5ZVTsdOg56LbYBMAcaZEQ5s7HxBVbD5PhS2?=
 =?us-ascii?Q?ZfHvlz0cxpmUEI8AbzbXfqXuxk+3tOKcrR2X1vEibMyk1LepvcHWXaIcrOpY?=
 =?us-ascii?Q?HSgHUzq+n+4seIvM8HVzQaUJMTaGQyxDY5lQjcDPVt6yUHkqvW1GbsEVe0hh?=
 =?us-ascii?Q?7xW4M3abU/vz1KG5GJGso2vNqRKRhQLQNKGX+8uSRNDsjhj6js29V7y4K7sq?=
 =?us-ascii?Q?kFV9z0LEDSGWZn8nDPWTbpoxEafEVAIAfLK8qFgxPfMPr5BJ8+CgHJCSH/NZ?=
 =?us-ascii?Q?gYwGoHdWNREXltixQqVrGUHB5JRAbc7iQoNOI8PWe8Nfkg444O1PFJBr0k+x?=
 =?us-ascii?Q?VzaP3TpMPMZs6gP5ouH9Pk03uYJLFptEDqN/QC+d4X7oHXeTBImqb4iSEzz0?=
 =?us-ascii?Q?AK50+Wfx+/gxDRPiDvno0tBaQbV+SshgPzl47MVsmAwTLezJ++lxbxZPNhTU?=
 =?us-ascii?Q?7H8BVlNb7hpjXUYWDfEZog2K93eziKCIZEQQb+vZiScHA0w9/o1RxPbQtzCF?=
 =?us-ascii?Q?VjBd74YEYbMRBuhJKFwUkrFhTas4bsEWr8ehdCG3Ts61+gbSi22H/SYuk43m?=
 =?us-ascii?Q?QBcQvY/YG4mhQZQoTTghaYNDxMIXUhWKIeO2S5C9Gex/9yphbiGzjEO9E06i?=
 =?us-ascii?Q?6rusD+XCBaI3j5pLyse12OSwYiQ5eVIyAGLdwwj4bJHTWZ0sL/U+CB0naQma?=
 =?us-ascii?Q?6GZfZxmpU8pDL0QDINk9wHcLx/AjmUVgJQzPE64DlOwBr35gkYPBuHp7BUxz?=
 =?us-ascii?Q?AE8gHC/rIOc9JC9uJ8KNCCZDlo2EabveYyuT676t0iAxM6rNDtf1dfw6Dz+F?=
 =?us-ascii?Q?zl8r+RLY1CsZFml/xzOhIQHnEcAcmFmC2VT/MFYjsWYn3qTdxItzT8KrvrnE?=
 =?us-ascii?Q?qi/IEbe8A2OUw7raekfYvL6tmNyF6yoZzrWjigJmave819OeHWjy/9nkRdkj?=
 =?us-ascii?Q?rcIhfsc6CDDyF+sOhW7h/cj+0W0b3ve/iRHNFjNAE8X0fwHQrGrA9g1fEglp?=
 =?us-ascii?Q?iD/It3LLFQrSMXHzSQeGP0zQxm2GRib3twQgcbnJkRWA5PxhFSk+6dF0FG/3?=
 =?us-ascii?Q?dzIj4V0aIccYh31PATvS/VPFJK0dYMuyWGdS9J3Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7ab4a7-7856-4168-4650-08db88ffb0be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:59:57.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB2oztcgKGU0QoiDJP5AFWrYy22fzmdB14/a9QRIOV/BpLoS1rM89sMJ8evBQvqRddjYMtGVHSnPsojy6L5XFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The imx genpd was missed to be built out, add it in Makefile

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop scu-pd change

 drivers/genpd/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index c429485c13f6..666753676e5c 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -3,6 +3,7 @@ obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
+obj-y					+= imx/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
-- 
2.37.1

