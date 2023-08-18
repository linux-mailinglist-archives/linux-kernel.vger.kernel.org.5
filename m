Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE0780AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376540AbjHRLLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376425AbjHRLK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:10:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C73A80;
        Fri, 18 Aug 2023 04:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9jUQvWrTjJkXtmpNf/72W4Zyz9K3j7E2pcKNDJf+VyWQA5YfE0POdq8fhi1fd5kk4KkBeg6R9Oz4sLyOdTaOn/lUJyOcuVWmJ/ySeE0UAsDoeYT+AmtUYwis3L/3e8CjPxgMjE8BGAuE8Bgi02PFNblM5u72DU8z6z2CXEaAxofscVdQjsnBBE0XctUVD1g/xOsT+lgUHJlKe8hukpciPbdyxYiuG/mCKHiKuM8wXQ4SjfZEl5Y8Ni0rF8tZYuNZkUfgDrSDf4woK19/2utRgYaR0CwgIT1lhnh2z94apT1dTLcy5HAr4ASwFc/VRzNZJkIGY0v9zfgq8kx23/e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/kMZRWg37MsrhxB0ve8V8H3Ak3czJa/x43C8INCvUg=;
 b=fVSxCM772uhCdT2Hmb3sOdnPhIcn9Avb6nPnmFQSKK886PRaRwNdVjEWjlaVb+YXWADVyEuLdu0QbKU/qFvaVViGfqkMPNF8zBdnJnZ/vybnMMKtOWWKMp+wfBnfYHlBtHmYh+tWsmJod86lq18xvuQA5Q2S7vCqPvZ2Xb9x4/NCFj4cbMIvtXWGdsuYy8AZ1UQXFVaUfrDA95IjpOdXbVZWry1WkRbd0L9xPmXEkRu6TVQ1rZKWAzvanhecDXvjDMaWorOzRZ3V0YUvL8WhV0amUDt0EEO3wFoyK0pILt8MB8sSjAiaro4ifgfet/yaR3yhv1uh3vs4SnqbKoRmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/kMZRWg37MsrhxB0ve8V8H3Ak3czJa/x43C8INCvUg=;
 b=AHpUvTo38+FfgTB1Jaz9Y0CtMtXw+2ddqlkMWtmCzxE0E4Cf6+nOwCOV9h+XfdLIkkmPyi9HV2fPm60s3fpsnjAOEGT1LlenH7D3t5arjeiexlPxQhjsJYkXKot+eT2pzLcTaAK1vb1fTQiL5fzkT2i9GUsKX9G932F5WkZwEyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:10:53 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:10:53 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v5 3/4] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
Date:   Fri, 18 Aug 2023 13:10:15 +0200
Message-Id: <20230818111016.11271-4-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818111016.11271-1-josua@solid-run.com>
References: <20230818111016.11271-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DO3P289CA0013.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dd78b8-0eb1-4b86-7c3b-08db9fdbc97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORlIBqIfSHLWJBCidi8LAnrrzf5XiLUbwafmCizNVZT5MiUqnf68yVDDVwaFMj8NXpq4kZ8gjnBDIQ42eUVtoAFlQZryt6Ps7enKNCe2ZKhokY7ifKk0gorY2dWmgbgtrOiVdFXSH3GryRDtyLEix3rkoiSFC4TQg87VPZFTwF6cKDVSHSHEtJNBVvVUucKuOUkTcvTvLEj4Sl6dEQWm24T3ow/lhVqF1YbNhayXlwoZd5YIrSK6ungZ8FJhrkEFKYK5lY4wzN1e9vTA7r4cpMSEQJe/qsVHmWQcZZi4SxHrkDkevbG65qb+b1jWoj5d75gk2bpFAUTfErjvo2uzaYsM3ky7kLRx6f5AhSMFGfzKfi1QOP0/gqtZWnTifsL8bS1/IUAVjAmJzHFbBRpbm/Op21lKiZt66deBV/cZijgWam0yCN0DzJ4bEJ3cEc/2Gp4Rw5iNrrlhwEfEYJECuq2dvq2GbtXOlwV7yoalG8MQlbeMNVY3VdTih5bIuQYd1s/DnW0kCs/1GFm3mz+P0ZtJr4n5Be2X78EKvaATkYAvK9Gd2nAuf0yj7Z+8suZe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39830400003)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(6486002)(6506007)(52116002)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(7416002)(478600001)(41300700001)(54906003)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZVAaRuZ/eVFYp28/6v7QyL2aVDbzMqsciu9RUYJZahLmShF2CzHDPWCz+Ly?=
 =?us-ascii?Q?cCS2ve69uNwXeOoLuABAqggwWCSreJDVvx3gEaJQQMEWRFGRAYF5W3JPSRJF?=
 =?us-ascii?Q?RI2Fz1lUxmV7tFbMEiARV5ugSP41kR0DmCCxns1lv8l6T621wJBUCqNreVpZ?=
 =?us-ascii?Q?v559Nb8PJBZLBV29Gv9Pp/Seos38XQXV5szg7La9Z0Hi/AnQL0S41qTirYt7?=
 =?us-ascii?Q?DrJvr1Fg6RXNYpDG5ChzsjO38Y9jTurRDtcnlVWOBFCAGft7pBowbOJunFrw?=
 =?us-ascii?Q?EuLEohScdwRFWlyA/nOXcJ2dU072kaLAPmWBRKt+5DH5OLM4clkq5RvNHcgf?=
 =?us-ascii?Q?rmqW9s/pOwhLJQFww3Z6Ssmxjvcjn3gNn4DdjeQ0ztxfP24Hnd+dhKtCF01F?=
 =?us-ascii?Q?s2YsRZVfztKZP34rJQDkpqFEtl7gy6bJTAubgeTBKmoagkkFCr7LxbSBxspn?=
 =?us-ascii?Q?RBarmxhTGVb2o1+B5a2jE+1yuwyyQexYEmLQAhesN3qjhMCS0HRIyaJKQLuu?=
 =?us-ascii?Q?KZ0NX3H/vdVj/4RjpFS5um/qlxx+5ZnZ6v+Vn+G7Nl3nXF9cENYR8tJC8JPk?=
 =?us-ascii?Q?B3WifQ9djwSIcrwBy0kWci7jUhDte1Yl2entskBjUALI6tmWH6dhZ+HkuIcp?=
 =?us-ascii?Q?ng+pIS/XWn+oIpMkIP9JTpGJPHwptlHI0IVK46eagR+ZalB+lUvnSZZgwh+J?=
 =?us-ascii?Q?QVO0kiEI444IgT5MLcx2q+w2MVozbaiG0yqGm+8Dnq+NnamEAykEHniEX45B?=
 =?us-ascii?Q?S5AA+LhOlukopzcW68o83qZxnXMiWecpxbNifDBcF/EliR4934Y0sMSFwKLP?=
 =?us-ascii?Q?2jKA77V/0kErSVJ1Ps40OcCI9vfP0WUgyv9rh+rYFBhVJRufG2apUVzm39dt?=
 =?us-ascii?Q?GPYutj/KaSd9skZEa07q1YmxOG7NCLo6vQWIVfFUpt50sgQmMf3bJP+rURqg?=
 =?us-ascii?Q?V2/A4mn28W62G9ebr49qiE/RJwQJ27aZZNEG+8UhhS7Kb3h07v6u4dTOFuEv?=
 =?us-ascii?Q?DVslz6tQmkhWFn1sEDPKnXjiiZQUXTx3+OUButeimq+2DQKLggRspwtwNcXm?=
 =?us-ascii?Q?e3Bv6e6C1D/HCHQCMl8S3dx3qRzW22WdKdxp6l2y7p/vUu8W5InTrSgCNcRK?=
 =?us-ascii?Q?kxWhP2+6D7WG/YxafRWS0Pe4FxrIF0k/QdvAJzjHoPnYMDjYc7Bb8YCcu2fy?=
 =?us-ascii?Q?QLHt0ijlVzuUXctF2hmrLe7wpBYoqYMscMufeDfXpE+72ygZGSuhCWlR6fmy?=
 =?us-ascii?Q?/hUrc4jTTnLbGS+hNpHBjBolaNyPZMc/iwimJ6iP5OYHETK6OdCCS24p/PLO?=
 =?us-ascii?Q?GsUECYEeEy0pvdo/lBNO/qbn3EOOgeqkmjchbnSP2SvRoWku+gWr8KWUpRGH?=
 =?us-ascii?Q?dYkj7QNCBZ4UlcaAEfbZ77WzaMHGhQNui7hNcfwK2niltaaAfyj9urWGNShx?=
 =?us-ascii?Q?USaXhb2SQHhASzyMoLpBqu9SdtsWj38tUvCMyKkRg01dsro437UhqZSt+w2s?=
 =?us-ascii?Q?eCbAykIxw/mX8kgr0Ye7jt5VNTrIG59BCzlhL4QPXIRT9wea0NTA459KKr43?=
 =?us-ascii?Q?MGxkJ1OK1nUOB1W5KAPSZkuRAWRFoa5vfI2sAaF4N2WYtOumnuKFQY51sHct?=
 =?us-ascii?Q?PylcXpe5OnaDTA1l9btjgII=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd78b8-0eb1-4b86-7c3b-08db9fdbc97b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:10:53.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5BZ1Try6/zryPhWyr8dWBfDo5SxNmTnxkGfLIx8rGgR9iIg9WRhKCXR5f4VzSXIhGeuR40DDXBTDAprbztiAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SolidRun now have 2 product lines around NXP Layerscape SoC:
- LX2160A COM Express 7
- LX2162A System on Module

LX2162 is a smaller package and reduced feature set to LX2160A;
LX2162 SoM is also a smaller form factor and reduced feature set to CEX.

Since both product lines are physically incompatible,
the existing group "SolidRun LX2160A based Boards" has been renamed to
include "CEX" in its name, meaning products based on LX2160A COM Express
Module, following this pattern:
"solidrun,<board>", "solidrun,lx2160a-cex", "fsl,lx2160a"

Add DT compatible for both SolidRun LX2162A SoM, and LX2162 Clearfog
boards to a new group based on LX2162A SoM, following this pattern:
"solidrun,<board>", "solidrun,lx2162a-som", "fsl,lx2160a"

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V1 -> V2: fixed to not break existing boards
V1 -> V2: explained new board / som DT binding in commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..ff9bf9956972 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1384,7 +1384,7 @@ properties:
               - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
-      - description: SolidRun LX2160A based Boards
+      - description: SolidRun LX2160A CEX-7 based Boards
         items:
           - enum:
               - solidrun,clearfog-cx
@@ -1392,6 +1392,13 @@ properties:
           - const: solidrun,lx2160a-cex7
           - const: fsl,lx2160a
 
+      - description: SolidRun LX2162A SoM based Boards
+        items:
+          - enum:
+              - solidrun,lx2162a-clearfog
+          - const: solidrun,lx2162a-som
+          - const: fsl,lx2160a
+
       - description: S32G2 based Boards
         items:
           - enum:
-- 
2.35.3

