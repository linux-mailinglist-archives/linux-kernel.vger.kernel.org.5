Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEC79CB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjILJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjILJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:15:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CECCA9;
        Tue, 12 Sep 2023 02:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELsCnh1iGen99wYP+rY8XM8QQYBJQdIY1sysMuhVO6z/GVPPz8hg3WMzBkaclSVpeXIXfPr3yAZmAg4Q9bFDZEsfK5VerIFYxD9ronVfWIbgVM63aYZITbwWF8W4E2tmgR0aEJ4cSJLRbxtbPZv9r1/OX/GJr4P60VXNYXecHcwXiagWeooeawU+4cfWxoJA8E9gBfimor9zSy95AlCYZKbuAlJ7DwlG/f0P7j/xIq+QfaJu6xSskDEewgif3pRWumftupbD2MJ0LS5ZroRF7WroQbmcms0AV0XosET7QOki0a4CE1eDvvIEuJ0N0r6+1viS289NOEHRKZTttg+ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZlI+rIIh60bS4PRlNde3mxxvdJCQwiqdsOb0L6PEY4=;
 b=YGn/XSauKy0dPoZ/zowBVhp86do4t+ctfYIU42oxR1VMJ9jUGS1+YOZcnTOyiMaIhv9oY23CmqNQ40EB9ykBWtfxYk0L6vraJKFJ7Gv4L9iPRpREMFNJbua7A5qfSnAl3uYEKBB8LLe4B2QWoFaC0upCyTi1BL3Mv9eXUgxCW6VGWs/bAiHCIqTYb1mNdhjPwqXTiac5qx0wGgvFAFCLdrLy1RNM5dE+DD1mra8Iwr+QLBinZbbvip4XsxQ8SooTVmbp2iPjptB0Bbmhw7FpJwE2tQZOo2KbzGfEpZ1whbhMn6VmlgGXU+4x/x9NkM+PXEZ2BjR6emKgGB3ACuImMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZlI+rIIh60bS4PRlNde3mxxvdJCQwiqdsOb0L6PEY4=;
 b=IaJ7ET7KkFG04kREv5fQAQAQDoBiBhIaDBgTGX2SPyXo/CZtoLk8EP2UBbhTb3pC6kcbM7lmTfekoz3Bwi395O4v5b+/nwPXwDgUuqhx1N8jQhzfonlX82DWOtOIaX54npqik5Q1IbkyM00PHHFf+xOFiJ7N1YRDqxjFyjfsK9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:14:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:02 +0800
Subject: [PATCH 4/7] clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-4-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
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
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=750;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=USdN4vkPanCh0KK7ApCda4FsAm4FAJLak7LhitJEzNE=;
 b=6e+N3/I3md6BjVbMi6OtdVOf47OalBpr1n3kLKoJDrOTZ+4XPmIlNurusunVuWAGB3Sq+ahRm
 mmF5JxlLEIVDfcxvdy6p78tx/5Esykuj5kwd3Drd9hVAjECK338QRhU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e2fe68-797c-4dda-3f4d-08dbb370b92c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /p636QFkkLA/lxh4GxkfzW67FNtP30qvgC+iENQOcfevHLSzgUgFnzBnNZWUxwAg2EK5KtT3XIrhjA9uYjIVRxAn5jXWSmrRIusLb7tgcs+LwGO5Mq3pa1cePcxlFUjHfQEG76IfQC2s/bXmqYaH2M4FCYQWuYhmlk1Vdi79V7tQv2cH3WXvLyeGjIWy/ba1lXQudesS7xPP0ktPlKHg9F8/qkTkdDfkBFBZqIvdlflgZHFHruKLgevin9AwfvYkY6HWDZAjmqRwcapz14OnsgzK1uDOKRCH0SZFwgmDeV4P5+q5oEFdnKYR5t82jQokF5jOFvn0hgMpe3+NzR3Bl4LSCziG2fb393rCqn2K6hdC3+w3wt/3jIK9o+2vCFHNLzYRSOb/1kEFnGWXEaxG6N5BJtxCcvZxHdkdMioq9aPlhxbAwdoHHbQ23CFh317MteEjwNN6gpdWxX8r3oseKKgd6pEDE+tIr1InCm0AZGXpYs84eiT/yKgRUM8NKD+MqcB0xlxOVmFoBAYSDfLwZIPNq8V+q9MX0dHYJpGdxJGuSVZ6yH6bTUFEl62J0b+2qX3LraiFtZZPyjGmnUF3Ttby6VpIzS1Hp+ctrwqZez9XWbZf5uj9Z4ZF+P/TF9Ze/6ND2fqpFSC0gvKGvBYmKv7zPTrQskZWs3jUesCGUAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(4744005)(38350700002)(38100700002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhQUWp2dDdMMnRBRC9rcnpRaTg1YlVmZmNUTXhQVU9FZEoreEN6VHZNMDBZ?=
 =?utf-8?B?RUVXRWtaZ2E0Z1c1VVAwQ2hOOWdvYTd5eVJ5NnM3M1BSS2Fxc1JWZmk5WndU?=
 =?utf-8?B?K2JUZW5iaGVJa3g4SWFNUG5pWE14UDFDblJvUWY2NTBHd1VIaUE1ZWk5bk5s?=
 =?utf-8?B?M1kyMUlTanU4UWZDT3RRZ25kTVpvYzVnYzhxNnlYVmpQVHVyOWMvZFlsQW1J?=
 =?utf-8?B?THpNNi8yMEhFNSt3RzArSVByOFJJNDFCY2ZxYzE4bnN3QzJBNHBxb2ZnTk90?=
 =?utf-8?B?akJkb3BLTjNRaGY4VFc3a2hjc1pJM1ZkVzlrSkliRGVNYTBGS1lXT2RoZXIr?=
 =?utf-8?B?WHR2YWdTWWJqTkVodG9ZMDRURFl4VUJHc09wQys1eUJhQWVTWVhIK1ZQT2ds?=
 =?utf-8?B?ZW1xYjI2dVBQRW1VNUV0VEJCUzJra2ZoRjI0UGF1RDN2KzAwU2RJNE4xa2ZX?=
 =?utf-8?B?UzhZNzRZLzNMNXY2Wno4aGtlaE5KNG9Jd014ZTcxYVdOdWozOEJKVll6dDdC?=
 =?utf-8?B?ZE9yUy9INm80MmlpZGNhRHNwRm1mZWxrdG91UkdwVUpHa0wxSzZnSWhoWk1J?=
 =?utf-8?B?OENHV0xoSTQ2UDh4TXhjNVUvSnppeWpKWjFJRkdsaG5hWHgrblA3c3FaNW1E?=
 =?utf-8?B?azRQK0FVb2FDMU9JS2ErYU9MSjQ4MmdqY3M3aVJMV2g1dis5Y2JrQkx1RFZK?=
 =?utf-8?B?NWlhMDF5MHpOY2g3d1ZBYXRsS0ZlcGFhR1JNdU1LK04vVTZURlZDVVVyZlhu?=
 =?utf-8?B?c0o2Vll3YUVsbnRHTGYrZFJjSEI1VkpnWWpBS2o4SDBqVlJ1M2tYczJ5UW5a?=
 =?utf-8?B?NlhSdUU5ekJ5RFJMVlArU084ZDRodjY5VFp5TTJIWlJ6RlR0Wlg2eXdwQVJJ?=
 =?utf-8?B?a1MvUHluUVlYSDZsd1A5RDI1dWpXdHhXQUVkcEhOcU5CVTcwdmhQNEpDUllm?=
 =?utf-8?B?akNJajI1T09BdFRrdnBDOU1FeWE1bUtZTzZTMmtFQVovOTRhQ3FIRFBpcU0r?=
 =?utf-8?B?RXMvOENoaXp4SkJsMk9wSllkbk5xN0YvSklHVWFtcVV1K1RLREFodDlPalFr?=
 =?utf-8?B?NXkvaURWazJ5MzJMV0FBeUYwNExqUzlFUkh4VXdWSGtFNFJiVWU5RUk5ZXRa?=
 =?utf-8?B?UkpvTUFSbmtJMDZkY0pWcU9RK045L0VNUzFuWmR6WS9SN3l1ZjNwSUlIWWNJ?=
 =?utf-8?B?WElaZWx3QVRORHpkSFdSZWVMV3ltNUgwVlIrWHVUZEF3a2Zja3FLSGJIUSta?=
 =?utf-8?B?SE9SVXFtemJNQTdLNUJ2V2lUTjhVRGxOR2tNdVN3V08rR3hVZDZvRGNWelJn?=
 =?utf-8?B?Z2dncVowV0JWQXBPaFAvam1RQldGYWdNR3phbmtWVHI0SXkxVjh0d082c2Vj?=
 =?utf-8?B?SzhxdDdzLzl0ZUJlSkRrRmIyajFTRExZbzJ5SGxET3ZKbGtycUxKb001a2xu?=
 =?utf-8?B?YlhSNHIzamtxV3RWNTlrSlVvYjAwQnpwSUtLSVJOd3puYVB4RnM4SENVcnli?=
 =?utf-8?B?a0ozSEpTQWIwYkwxc1B6S05MTjNSZk9Mdm5VNmdIM1k5MlRSWWRNVnNJbzRV?=
 =?utf-8?B?eG8vYWpUT0Jya3F2TS9iYmpvdERkNFRSQ2NyUEFIUTdIanhQamwyZnJ2UTVF?=
 =?utf-8?B?V0dkN1pwQjhwRkI1eWx6VDh2YkRiOFpPelF5ckZ4dVNMbmlZeE55STZJT3VL?=
 =?utf-8?B?Yis5ckgyZE9wN1J0UDVOR1QrSVNNaklzTkIxWDdMS0dTckpOZEs3K0loQzM2?=
 =?utf-8?B?MkF2TGptRE1lQTBiYmc0RmFaRWM4aTZuZnc5K0Y2cVRNckdtY0hnYUNHV2Ez?=
 =?utf-8?B?N1EvZUJvOXBiK2dkRm5NSUNNTXVjU2NpYWZRbkNmZVFvUWVrc0MrczVoYnJQ?=
 =?utf-8?B?Vit4TWd3VWxaL3JjWTRsSFI3V2E5anZWWGVZZGpZUGI3OTJ2Z0RtSmY0d3Ry?=
 =?utf-8?B?UXlZSjdMZzVwQ0haNFdROWJUR0FJemxVc04yNGR4amo1NGQ1dnBxNlFhQ0Rr?=
 =?utf-8?B?d3dsSzBnODJHMWdhRUJLVXVibWVLOEgwQmE0dzVZWm1sSEdWZ0JKOTV0QkMv?=
 =?utf-8?B?VjRuU1pPQWkyVU5zRndwYURwdjkvakdiY0xoQ29mUWZxY1J5ckh3R3R5czJa?=
 =?utf-8?Q?K9OktYANTlI1wvqDn+ZU4WqPI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e2fe68-797c-4dda-3f4d-08dbb370b92c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:53.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyKB1qtm/WyophLQKwDmqnJ1nNCdbNuDrwAWdGBJyBZ2jzbPGG29jhvD01Ab33lZyx+/RoJwiO211uZmvyxJOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

IMX_SC_R_VPU_UART and IMX_SC_R_VPUCORE was used in i.MX8QM A0 which
not for mass production. i.MX8QM B0 not have the two resources, so drop
it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qm-rsrc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qm-rsrc.c b/drivers/clk/imx/clk-imx8qm-rsrc.c
index 87e0b6ac027e..8412fa349569 100644
--- a/drivers/clk/imx/clk-imx8qm-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qm-rsrc.c
@@ -79,8 +79,6 @@ static const u32 imx8qm_clk_scu_rsrc_table[] = {
 	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_M4_1_I2C,
 	IMX_SC_R_AUDIO_PLL_0,
-	IMX_SC_R_VPU_UART,
-	IMX_SC_R_VPUCORE,
 	IMX_SC_R_MIPI_0,
 	IMX_SC_R_MIPI_0_PWM_0,
 	IMX_SC_R_MIPI_0_I2C_0,

-- 
2.37.1

