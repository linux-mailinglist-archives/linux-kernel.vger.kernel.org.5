Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6B79CB45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjILJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjILJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:14:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01F10F3;
        Tue, 12 Sep 2023 02:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+REgBPMSZrJ4Cbgkw6Be4Jc7xwenu3NpR99GHOb2IMxwnOWvOQeKG/3IxgNbfLHNcbgu8WX4A+gaVS7UjEOK7w4T63rn9kQyN9i+ZAUfOdr8btrs+qI1YAImRHMD+G4hIxDJf9ihodI8/JvLBcgDDJPI7yyImZCqF5iQocklAcUgN+I9OUmlwJzEWXJMMsdG8V1/Xkgu2b0gliyHuIk+D6g+alLaPNonJEs7ZG6UboKL4BczsnzlPQcs1WmQCpvI3urw3TotpsBqmKxXaEcrm3IJ8g3fpgQfJrFGE4tS/QtfUo9oWKA9+Bt81q1OfJDGj4d7AYqwQofskDkTuQySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvQ0Lvbi1X4gcqA6+BsgQZ6XSP/JXXfqOh2b61ar7vs=;
 b=BstbXQbAxpTiPc8eHxALm2VGfpI9X3RPnABHaPUY+I1QgFiTUsCAo6Cmo2OJeHraSfcDmeGV7qMYa2EJakKjfbifu23d0OoGNFWrGl57G1csr9WPaIFwDLqZzApUfco5m+QYIr7hfRbw5JDat0OwyLAY9/VeBxCdJwaIIoydjUxjC6Pys4BEEhEz0muMl20WWLq3Z2zpZy+tQbdWSUBMghP3u1/qVzYmyqNdIalE5Y3Qi4HTdwFVRyD+PbVXAFRsvF+eqE4uLi8QmU/dEvhfyMdWqAw6rYPbc2x37l4BU62ECZA/tOx7K9aH/aIw5AU8cCHpL87b5U652NSNQTR1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvQ0Lvbi1X4gcqA6+BsgQZ6XSP/JXXfqOh2b61ar7vs=;
 b=k1frb0aFpR/AhaFSEzoJz7PSWA7jCFV827xmNtBXj03cIIV+dVxCO+nJULnXGqRM16sqrD1WrOhD+q6NElsIgF3ecKFzujycd4oJBqdzu8pYQiwmnSIml7Z9orR+cVtxjPsNeFdMvChIAVynzEbd0BfSOjAc5m7wghrJyRFg4es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:14:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: =?utf-8?q?=5BPATCH_0/7=5D_clk=EF=BC=9Aimx=3A_misc_update/fix_for?=
 =?utf-8?q?_i=2EMX8?=
Date:   Tue, 12 Sep 2023 17:18:58 +0800
Message-Id: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAItAGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Mj3czcCgvd5Jxs3TJD3RQjAwtLSyODRCPjRCWgjoKi1LTMCrBp0bG
 1tQCJC/ZpXQAAAA==
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=1239;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rCGBKw0HjM6NFIIhPjo1IINPSfJom8L0z4OY6/F/uPc=;
 b=9ZJsso7DPNh9nLrgNsqDKcNKfAz/iElew2OjIuhrBGRxqG08CH2+EKCbYigZOZuyGI27CLKsA
 mMwzXAgc5wLDjbX19so4c8DCYoSHARtR9ry2m7GsPkcw73dI/Q7RJUw
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcf1cde-795b-4f81-d6f8-08dbb370ace8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih/v3diJ9eTEmT9GtDjm5FfFzIORHDne+e5vRgbuXwbFp2VA7pgcnjPGJDoHap9bNPEXQUR6EwxEl/JEFHhHLLDtNBAx/7HTIRnmQG4ZjZmBH8cAzHzF7ryTp+ODaXtoZwbxEtqWdKcqlgxnypLZ/SUUM3+jUFEKb4qmFp6EO7969OCwU1dCmApI1GWnbjxZPc0ojdUiKxWBSrs/2XAzDMrm6sP76Nvyd+kK1rg//T1je1cMTQxzzSizes5ueEQGyL/Kv6nNyQZm9H2+VWq6GRZbv0GdEBdIr9VGtV5yJHe4ITidfbcSFzvaATkpD0J/Zfnxz4gQalwbrR3Bo5ZJHNR5VlG0Abovn+l35WMbbZl10iSQwKGhTLnONexts+q2X32LTqc1LCMhtf2GvKjvLKqiQO9vJW+8tJLxDvTkZHT3+mC1Wu04qVVjGH4Lr8cszmLNIS7Fvb7jSGTjmlgouGFIVXpMYx7naOJi2tqD/Or63e4uSdxS3Jujir9Ks/CV3p9PNlxqRf1UdTDTjfOTijruv3x0WD83pfkJEy2tcMTU/G5Bm5+W1piLe4mfPKIqNbUQv2Sk9ZRgE3l+ll2iWReM05q7sQheEDUKQ7+4UcXsn4C57c31LJB4PM3TNoipUeMfZzjDT8/bqQDN2quxtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8936002)(4326008)(83380400001)(6486002)(6666004)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(54906003)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxmUFlRVTFtTXUweU8rNVB3UGlFa3RjTDdodEJjMG1xMnFxOHBEc3lhTzQ3?=
 =?utf-8?B?cjhEcW1LdUpqLzd5bGhsK3JEUnBZNkRLK3RDdEpxMUl2SlJuVU8zaVRsTERY?=
 =?utf-8?B?VzJMVkNsQXpMMzgyR2QwZVRmUGsyOGgwdlVCM0JvNXpFamI3QUVmSWNGYjNk?=
 =?utf-8?B?SnNmaStGNmdEYUpnR0RlRFViU1d3Q1pBWnkzVjhrOVQ1TllMN29nQ1ZrWHcy?=
 =?utf-8?B?cGRKbHY4T0EweTYvVFRNeHJVSlc0aDY4MEtxbHBkY2IxK2VINCtEajJodXNa?=
 =?utf-8?B?emRGNFA1WUpTMCtqTDlKOWxWSXYrMzZsR3U5amYzOWhVK1Q5THBQWVcyRnpk?=
 =?utf-8?B?SFBaZkFTbHBuOXE0MjJmMmtlQ2UrNWVlWmRCS1VobDZqQWh3WnRnbGswcjhF?=
 =?utf-8?B?RlF3dGJVWXNqNUZja3pqcmQ4UG82RXF6OFI4UDlsMnhpQzlhSTZ0U0lrUDRJ?=
 =?utf-8?B?K0w1TkRQZkU0dmJ0MC9zeE5vWlNVK0QzMjd2aGdLYUJheEFLNXdmZVBHVlpD?=
 =?utf-8?B?WDE3a1dDNkpJTWYxZFdiNXhrNFEza2Y1RXpJYWU1NlcxK1oxbXoyM21mcnpx?=
 =?utf-8?B?VkxlaDIzVTUrMWw1M3UwNWJ5RUtHQnJIOHF1TnNOcVlCM2xtTWZjaVlPSy9j?=
 =?utf-8?B?QXNHL0FlNE4xdWhnbkk4RHdWVVovZ1ZwWXJ2QU11bDdIR0NiUXBxOXZ2VEpm?=
 =?utf-8?B?RTRJeXErSjVaalRySGNkV3JIK2NEQ21qUDVEZHdjc0V3MHJxUkE2SGVqbmEv?=
 =?utf-8?B?ZDBqSlFZQllHK1ZORElubmVQV29reGREZ2pQVkxDbnMvRUdleDF4d1lSc05u?=
 =?utf-8?B?d25BRktnYWhsL2FSR0puWkZCV2pnWGhscmdwQkQrUWtBV25rTERmZjYyZzla?=
 =?utf-8?B?cWJtOHViVVlGWDlUb3NOandWTzRENDJuaC9FelpnWWdnTkRGaUtmTnNacUF2?=
 =?utf-8?B?NjNLQnJYVlZYWmNaZS9YV3QvdVh2a0hXSVV0ZDZXamRPTENqb0ZMTnpRVmtq?=
 =?utf-8?B?ZmZwaVNHQ0g0Y1lKSnZBVGF5cWNBRURaemtNekhYNlZteUVVYTJsUkxJSnMw?=
 =?utf-8?B?aEM2dVo0OE83OEg4THJ3OHZpM0pzbktwSWQrM1hlVnFYWUVTU0IvaTcyYlhK?=
 =?utf-8?B?M084Q1c5aEtBa0RSNFdueVlQUzh0cW83RUxJOXZDQkMrc0wzVWFmUHdqbW1E?=
 =?utf-8?B?eHZQd3FIaVg0MnhiQTZRQmtTVzh3RmFjcmR4dHltQ0RUMUNpZjZNcFNTRWY2?=
 =?utf-8?B?TmswZTNqOUNmWVp2UmFWd2U5d1ovV0QvRmNLS0dpeFduQnNNQnhOYTQxRy9i?=
 =?utf-8?B?NUtKajhEc1Y4Ri9JZTNPZXRwNHMzVis4NVNZVHYzNkhQeTQrdCtNL1d1YkxW?=
 =?utf-8?B?Z1h4bWhjdFc0TUNHWWMrQ3VEZ1lvTG5TUXNaYTVBcHZ3c3NvbEdjNWkrZ044?=
 =?utf-8?B?UzZrSkRPRFB4SFRaQjFzanlsUXVrZWRQbEZldXBKSndMaXBFNTN3TE9BSnZv?=
 =?utf-8?B?SWNseEkvTm1YZys0R3hyTFllNGVac2lYeTVwWVZHa1lhdU1yQVplK0Z5TnZl?=
 =?utf-8?B?b3hDM1kvbVZSZGdWcnZBa2pWU2hNdmthSzhycjlERzJxRm5tNUZvR0tKeEc0?=
 =?utf-8?B?MHNLMzB0ZzhINEkvTFh0Nm1TTEUyczdGSk44OFlneVkvVUZXMXMwUGRjYmdV?=
 =?utf-8?B?ek94dzA2OXFxNkRkL2s5TGljeUNQUWNnN25jaDI5R3dTUklXcTR1WC9VSGpw?=
 =?utf-8?B?aCsydUpBdUd6MXNadlN2MG5EYmIyWmczNGVlRnlLek1nWW02cHJuZnhPbjhq?=
 =?utf-8?B?UTB1eWRiWjBRVzhob3pCU3VXcXdNV1BWZTNncDg4ZGFvKzMzN3NLWmI4MEJk?=
 =?utf-8?B?cnVzZ0FGV3BveDRmTHN0bjkzcGswaGpScU1mY0tIQ2o1Y00wK3RoNUVZWVRW?=
 =?utf-8?B?cE00UGJsZWJoTUEwZkRhb2RsV3BTeVdPUlBmVzBPWFU5SlBUTk5UTlBXOGZW?=
 =?utf-8?B?V0xpN2wxWXpydzRwTjRDdlh6UzIyL2NwUFhyU2JkNFBFTGtGWHUrbUo3c2Y0?=
 =?utf-8?B?eTB6T3dQdk90RjMreTMxanJOZ25wTHA5bGhJUGc3cDNXSjdGaXhoL0RsTExi?=
 =?utf-8?Q?+7udf3FlFZXauMrPe+evKT2Qy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcf1cde-795b-4f81-d6f8-08dbb370ace8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:32.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6OJWW7jenOsO7LUVoiZvi4PUzcwfxBsejhk9SiS41oZrC+PsjpsOwLm0zFQTJMNM+cKrs7pPP2suX7Fb6WORQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset is to upstream NXP downstream i.MX8 clk misc patches which
has been stayed in NXP LTS release for quite some time.

There are a few fixes, but should be fine to put in next tree.

---
Peng Fan (4):
      clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
      clk: imx8: remove MLB support
      clk: imx: scu: ignore clks not owned by Cortex-A partition
      clk: imx: imx8qm/qxp: add more resources to whitelist

Robert Chiras (1):
      clk: imx: imx8qxp: Fix elcdif_pll clock

Shenwei Wang (1):
      clk: imx: imx8qxp: correct the enet clocks for i.MX8DXL

Viorel Suman (1):
      clk: imx: imx8dxl-rsrc: keep sorted in the ascending order

 drivers/clk/imx/clk-imx8-acm.c     |  6 +++---
 drivers/clk/imx/clk-imx8dxl-rsrc.c |  3 +--
 drivers/clk/imx/clk-imx8qm-rsrc.c  |  5 ++---
 drivers/clk/imx/clk-imx8qxp-lpcg.h |  1 -
 drivers/clk/imx/clk-imx8qxp-rsrc.c |  4 +++-
 drivers/clk/imx/clk-imx8qxp.c      | 13 ++++++++++---
 drivers/clk/imx/clk-scu.c          | 20 ++++++++++++++++++++
 7 files changed, 39 insertions(+), 13 deletions(-)
---
base-commit: cd04b2fab5ee58862674e9bab3cbc8e9a8576845
change-id: 20230912-imx8-clk-v1-d2089920a23a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

