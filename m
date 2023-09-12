Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428E79CB49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjILJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjILJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:14:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5210F4;
        Tue, 12 Sep 2023 02:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3i7A4hMd5zdEAomLgF3gHmHRzf3jHnlukZn4wyfR8eVWTJVsn/Vvx997lg0FhkAO9SwFWxstl4IGjAcwV2W4gEAfTX5E5hbIDOvOdRxzdtIr6ici4NXENYoJ+ODjA1HBZdTJOg92ZBHWci9yKKGRIn/N3YjLpdRkD+uE70dZ1+Fp053A1DDblwJ149iZLo88i+4K5mzmKi7Zn0TGde5fYR74j2g04DP8mzZ8ZwB62VOJVcj/vnU0h4eJVXu9D46zeY9oJtN3H7OB+Nrnds4XPokfURiqQllqk16whrI0MuIontKBkmpKMcvybCYTUSDrEBnk7q/mcSv9JWY5zAl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymeBSYf8reKv+4Cc2E+IkWouronSWNF/LGvxLtE7S7s=;
 b=eVtzlVfF7lcF/6APadrBIMql6hvXyoMByBEzXFJtDdFWFP0Xe2TqT3nEprx4GSuotn/4hxlAsMXvK9eQpCNyiTF/HnSp2b5mEBPcuWQdtPr6DBgQhSXh1R3wb/HVCKsbbkmhR3Y/mWZNrxZIsMfYGVLat/nU9gNhrCoqnnj1bApQcyDeWpW8sGtOuPMjYg3mxFiaEftq0ZJ4tef6mle1wE6yfVxE4Nrk6QsnwcCWMIYq+z7Byiau3dq4cPgxPJEXCohgeQqZaaDjCE8R9icbtJkeKpcWTU1wxRNBTU8jFrY/NSGtVj/eHn8D9sDOIQYHUq4YFWX1dWZ/JZ3kkCszTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymeBSYf8reKv+4Cc2E+IkWouronSWNF/LGvxLtE7S7s=;
 b=Ohw1I6wagRnhieRHQCLS6ZIXUV3zn31t2Vjt4nkgrVOfE/xeAFUBygXOj07HKZbRJkyg0+chVWiP+K3gfmYWWG1w4nmKFs0XYgWR0EUmMkJZiWx2FM4KY/NlaXRVgSe3Xn/LWIAagH5IviuStqo/ASXMadeu4aV9DtbWMB71dO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:14:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:00 +0800
Subject: [PATCH 2/7] clk: imx: imx8qxp: Fix elcdif_pll clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-2-69a34bcfcae1@nxp.com>
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
        linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=1593;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HGb1cYkCIgm69oG6TtMIPPTMlWRPE2ieXP89fwsR0U0=;
 b=YwMU/7I4Z5oMRzTN5BLZ3u0ZS8SKCyvSqRVI+l5JiQYwsppLywdS/6XL3rv/mBg0fKHgFDPP7
 tFtOpI7VX78ChK18djCIGC0W94VxntXa0e6hnzY5QQ6exVrQ6kkLfLK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0898d3-a63c-4845-5168-08dbb370b366
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfEqn24t/Ip+8QtaUD/dj5rTp48xYr7rjsUsmWqVt0xGTSWuVB5ijcgKQ5g+IVMyMhaOhKm0x1RZZH6pHa+tpABXbx/MZlnR92HvJ1VL1IPKznQJwM1Y8HJ02fxEynpsiDVl7KD1Dq+HMcbgnNUetxd9nREhWH7THCntV+G0gnuq9+YlH+BIW89ANI0T1ct7U+7TGhxxn0jGObqVC8Nk+dfwFQ0BnT/pn/rynvumlrqSrovOJuQSHXo4AnM6bHxU+Dh35d8lyFZoDgUtVAlZQUTDpDeN+4ejaQBTgNfawVDPP0XwLxGKLHwGeaI8vUM51zGbZAPKpafiQuqLal9Sw6x85O7x8HhGDAj0cdrm9dbPf9khs+itRsclYLuBoGWbbeQCs74SL4YjBpC4h0PzshP1zT56bOGBdOaHcRFYpYt30WBu5rDIIzsazomDgkA/zVyHpVMhdHkqyTnWNxzkB9CUQSQ8wTOnUyzwJey2amY6t33cz+0HVMHN0yUcaEBu2bTcT6896/7TTlhQ76b3eQeaTFeNRZdbK57miNZFiXEkvOlHm0I5UIDPrrV8qVmShU638zQ9L1AaIizcaY6ZTzWmB6Xhy0UIY2NwS/tsoRTWOE8ZdbKanWt5R3OuJ8qbQopABAhNhEci99S/WleAGUu5fJR5HwvdTxiTpQ336+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(2906002)(26005)(41300700001)(66946007)(316002)(110136005)(54906003)(8676002)(66556008)(7416002)(66476007)(478600001)(4326008)(5660300002)(8936002)(6666004)(6512007)(52116002)(6506007)(6486002)(9686003)(36756003)(83380400001)(38100700002)(86362001)(38350700002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckd5b3A5WkZORUprcWhydUtXYkhmMUZrS0ZGYk44NDdsNUdzdzMyVTFnYmI0?=
 =?utf-8?B?VHFrZWpQQXpVTWV1SC9CMVYzbFA4c0xrYitzQStjUFM0eGtKNnFhOW9aRUtM?=
 =?utf-8?B?U2hOdG4vY0FZK25DSGJvRXVjcUtvcW1qazdKVno3ZGlnSENjblNvbld4UjRy?=
 =?utf-8?B?d2JmYTNOM3RHNGVBZ1V4THRKRi9hZXFZd2ZBM0dXTVRPSmQwWFhwYlI4ZlZO?=
 =?utf-8?B?a2dNWWFTNUNqVTY3U1RPMjlGSlRmRjNKTjZoM2lHUHI2RzZhQnJ4c3Y2YzlY?=
 =?utf-8?B?aTZQaTFXeFluMmFsM1VGbVg2cXJ0UHk2ZUNIZTNzOVB1ODNPckxKVzU4bnNP?=
 =?utf-8?B?ZFRlZ1JwQkJUcGlmRTJJMG5DMkVPekVMVEI0YWIyQUY0ZTNGQnpVelM1Q1k3?=
 =?utf-8?B?My91QytCa0lkZHlsN3lXVzlENHdWcmswNE1oVEk5ejZEU00wZ0pmZi9qSi9i?=
 =?utf-8?B?bEdjK01jV2QwV01tbE5yM0tXSkkydEl6cnBJd1JITk9GOXhmQTZiME9zVXNV?=
 =?utf-8?B?bEpJUXNkWW90YVo3UTNqNXF1ek5ZamZ1TldSWHZQN0xvUGYyQ0RNcFNlbkNE?=
 =?utf-8?B?bGR1eW9oNjE3MWdpN1IwS0ltTWVTWll4UThTQ0FLbzhsUVR6Z2VmN1pjUC9O?=
 =?utf-8?B?TEhjcDVYSEZPSXFrQlVtVmJjWFRIVzZ4V0t0dmhnNXBBc1BZR1Y3ZmJ1S3Zi?=
 =?utf-8?B?NFJ0dE1Bek9HYnlwOHZQSTI5c2JkTjV6WmtFK1B0QlJMWDU3ZDNXZFNYODJk?=
 =?utf-8?B?SVc1ZGRVM1hueDFhbGM0NWhBVGZ6V2Nld1Zsa242Mkt5dHhvczlGRWlxQ1lH?=
 =?utf-8?B?RWVzaE1QNXQveEwzaktCS1NRbFFqalRDaGc1dHVUUDNUMVFpeEliaVd4QUVL?=
 =?utf-8?B?RzZaUGdZZ2JzMTFHWE5DMTBjc1RnNnhWM0F3UDVHSTlUbkl5U2ZKOTFQazNo?=
 =?utf-8?B?OGdtYkFIQ0M3U2M1ZWd4UlY4aFcrTDNwTHF5dFd3bkllOUM1alJIWVJiN243?=
 =?utf-8?B?L2JWd0N5a3FWdVZkcUtqa3AzTkRrZWVER3psVlZXekxyZWZ6VUJxa3k2Vkg0?=
 =?utf-8?B?OXhFL1N4czJaTFBvZ28vQlZVQVdEVHowVGErU2Fqa3U4UUs0YkY5Zmc0aXp5?=
 =?utf-8?B?TjRKNUU5RnppQzNVT0l2QkgwTjM0Zzh3T3dRbXNuNWFlRGV5REVOU3dRU3Bu?=
 =?utf-8?B?OGFrVDFYYWpnNzdZSjkyOHJrNE9kK0RUK0Vham9xQkdXbjNEdERUL1VzTDhz?=
 =?utf-8?B?cHdZbE5ZeUVveWo0QWEyNzc5dW5QUmtOb1NyUG9DWVRpZzZHMk04SWl1NFJD?=
 =?utf-8?B?YksrRDV6eitlUHExYlZiZGluU012TURwS3N3Lyt5ZGdMQTFRL3BSdDU1ZFlD?=
 =?utf-8?B?Rlo3RXdTR1pvNy9qZy83blVvQThyVmxCc3R6Sm40N3FNeWtPZ0hLa3dNSldl?=
 =?utf-8?B?d08zcW9SeFRsLytyS1dmbHo5ZXIySEY4OEZpQ3F4bVEwY096dStKOUpiandD?=
 =?utf-8?B?YmRkT0tBeFlOemxLZ2tYeTVrVVAzY0h0TkRoci82amM4TlllRXNZbUxQd2RS?=
 =?utf-8?B?bmdTMnkzbGZ0Qjd2MVdvRUtYQUp2SUVUK1I5aFllNGVxMEFUcXAwQ3o5TGg5?=
 =?utf-8?B?cERISWsxcmNaNnNJbnFyUXFRdDU1UWVwN1pkQWZVd1hLRjZyZ0VqSThhNU93?=
 =?utf-8?B?UHZuTS9ERDV6dndFUTUzeW1IQWY3UXIrUzJoSVZRRTJGTVQ5YmJSTS9VSFdR?=
 =?utf-8?B?TTcxcXh5cnFyaE8rdDhZN1JKL0NuUiszMmlJUEFFbFlYTWUzYTFJZVFzbDlI?=
 =?utf-8?B?RGRUWnRMaEFudTV4OWlkRnFEdGxzMUZwQjNXSS9rNWJPcStuMEdiclZiQk5J?=
 =?utf-8?B?ejZXQ3dZR0cxSFZSazJCSllRTldneTQyQzBKTmpROFZvSWMrTlZ0QThOd3M3?=
 =?utf-8?B?V0VaS3dvTHIrb2tQWjdFeitkSFNja0lCaEF4RFFSdXRzRzlFdkNCdm1oUXhy?=
 =?utf-8?B?NTBPa1A5bWdjZ1pMNFpSZll2V0dVeWdpQ1M2SDhROXhYUEdxODZwWEZMVW1R?=
 =?utf-8?B?VDIvMGhBYVRlcWtoUlR3K3EwS3RhbFlhc2RtMnp6OTJpSk5YQzlmOUxtZlNF?=
 =?utf-8?Q?5Y4BkVvR/VGL4V0voelZykbDg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0898d3-a63c-4845-5168-08dbb370b366
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:43.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vLZjgQkO3tEt96xYohHW7YE1PEbIastQOC+2h2gMeA36eWSvBczHR/iQPqm7mmqhVisRUrziWQuB8qwjXWxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Chiras <robert.chiras@nxp.com>

Move the elcdif_pll clock initialization before the lcd_clk, since the
elcdif_clk needs to be initialized ahead of lcd_clk, being its parent.
This change fixes issues with the LCD clocks during suspend/resume.

Fixes: babfaa9556d7 ("clk: imx: scu: add more scu clocks")
Suggested-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Acked-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index cadcbb318f5c..4020aa4b79bf 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -147,10 +147,10 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("adc1_clk",  IMX_SC_R_ADC_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);

-- 
2.37.1

