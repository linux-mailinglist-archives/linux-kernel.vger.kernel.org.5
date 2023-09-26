Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781477AE41B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjIZD3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIZD27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:28:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E57DD;
        Mon, 25 Sep 2023 20:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVT/OAjFCDh4AB0gE9fmVfBnvbvzBq4vqjvcEBigH0m5vix9h8fl0ILuJwmOdulx3kpcT7q9cX+8YqKLYip3CaiVFSbw6hlP4hkAQZ97byaZD7Nm6KqeFvyMShZKU0MUwZGpq0A6t2wAoyXZ+vjV+fRTMhieaHMPGoMrbQcZfcxlVg78+ZWo+5Jw374v++tUBhwbTvWDwZUGDpvKZymtvesY79WPvGIVsAmGjLeEy29wX40DB2fC0O3MdWqXQhJUt63U1uUGo5a33J6xO2IuO0uvbLDE9SHZ+YpJJjph1Cmkc0TvPO/1h9Js+bzUbn2Jtfu8JxcjOrw6bFVoK+kdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0vCdVPbYpxRxPq+8c933kiOq0iU0s8054t1UCYl/9I=;
 b=Hkce9jhiw5bwcJOL/hi94VcU8CcjNUcq3/Q2kInpaDG90MESXLuE+aKkdFuh+MZVInBPvP4w0nV/86U+OlPkaS8pkCl+qZiCNcSYkCuadND3F9FF7mSFNB6QVPFr3fkTnvBstRA8buZltU1ntrpG2GYeEs2PJZo6sR0/zrpMGwBI5OBU7Ny0fV1xwpzhkwxptUC9W8TDkRTtGbBDdn3xXVaY+NljkX4eoMiGA+bT8DayaAxiHb43do7kbgCvIESPdp0Gc86unCtJTsdIfoBF7edLXwcXgPIBGIYJkhLT24W7baTrqjVMzvIhzph8FE8luWXLkKKcqKRdXa8SdwgXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0vCdVPbYpxRxPq+8c933kiOq0iU0s8054t1UCYl/9I=;
 b=fa10QGly2DA+TPkqcGcOzoPKF24TnrVIjyHXtz/UzhTPmAHa1AGlkJebtRKrTCQZx6iMWDvR/uwJbCUyrYfX6IjXeCtAixEtsq0IckJxB8XFqfQAYOMLDBewS5qiBd8H3e6ixgoqiG5C/2bniL+LA7BsxMCJjElsnJA6ir1+UII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:28:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:28:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:17 +0800
Subject: [PATCH v4 1/7] dt-bindings: gpio: vf610: update gpio-ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-1-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=924;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Lk1/PR7ux5rPSbCqB5pk04ID0vKBmWjRU/5SR75uwqc=;
 b=C4TOCHct4qsdRmEk5F3JnaLAN0iDcrXxfCnOelwUC0t6qd+mLTTqwHf5mL6TG+SGbV7YGgfRR
 Yy7zMzCOIQJCqChFte2+Gv+L/1Df3q4Ew2PgRs+xCgC7HvwrIAcHzMo
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1467c62f-55da-42e6-2bd2-08dbbe40b31e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CFc5V3CUX5EJ1WT7EUPBvLvmTTTlU7evVX0hFm3USaFjrgcjrLmKVUY38cBCc3D+Hd4wcjaWVN0uN30U9dyH84ckvDB0FiQTT06Vax5mtvFEsdoJHP7YbNl3t38q+BlryUxZ7GwtgbZ4mOX/XemTNzqbsq4/evoxcAJlQF4cYy9o2t9vqTem/trGWajbLFa51gz/sbqCQm4VfmBYRJsBJoT5p9Pf07yy7OrzMlLXHVHEU051WjdoZ9hWKbibO2PRfRXVz8jv/cNeB4ZGZ36h2yYAILDWPc6e9FngKOmAceIuwYN+LwSdIhcjWZho0opbiqPbgyCzgw1NSKnq7rpzmFnNhiq50IAIrKTVSnTcP1tRIOkAM+CUzH9HghqgFPUxo5Id/2+6ZYCp2faqgKDKdCrxJstxV6ueSkR1hCySM7QHv7xMdfU3Qa4B7CNy/XoIPaCsdBGSrQthiZ4ceTvuB8F3WcHWeXHaeCUzgwDEIx+peN3t3jQZYobhkHhwptpwBjm3z3Tm/6EpSCl+xrQipC/sa0KboXyhMt/OTuse+EV/M3G/c9FExKzgrMRoqBaf9vFNHlCeYOKf5ypcd4nua4wFOURRnkOa506k1/G57yMJ0YZAhoZnCI5OVvOuqdNyZz6y3D0ffmx6kBuBmTU7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(15650500001)(54906003)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(4744005)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk13c0k3bUhSQmtEWng0VlZDdFRkejZhbCtyNm1iRjlJN1FLQW94NkVTS1Rs?=
 =?utf-8?B?UkxHZjVRb1pZQ1gwOHhVcVJ5OHBpT2V3MW5ZUXdDaE50V2NJUVJQc0RFSnhr?=
 =?utf-8?B?RFVQSnBaUE5QNFpxL3pCREo3SjZVSVgzLzZaVHo4MmpLbHpkRGFyVEhVcTFy?=
 =?utf-8?B?aVlkalBXL3laWjNRTVhTeWoveEtvWEFLU0xVK1Rad0VFMWp2UFpPZ1dLdG0x?=
 =?utf-8?B?S01XalBFRC9KM0c0L1EycUp5Uk9rdjZTaTNJTHFQNUZadE4wR2NmZUJxUk01?=
 =?utf-8?B?UU1UL3RrSThsVXVvZElxZFVRYy83ekJrWDAvUUVhR1pPTjVROWRQdjJCMUl1?=
 =?utf-8?B?TFBEVzFPTnNXc0ZJOHZhNmpvVzFmTFZJNkhuK1ZyM25nU2I5c0pjb0N3MHM1?=
 =?utf-8?B?cTRVWFdBNXM3SXZVUkpGYW10c3p4VkFwTHM0RERETExhVFBKRjJNRVhuSU1q?=
 =?utf-8?B?cHhZTXVyQysvVjZTcXZ1SlhBQlpDcGRnNjRPTlE5cEVPOE5sSGJLWStWbzNl?=
 =?utf-8?B?Y1M5OTBkRUU2bGZNcmtSOEdtMTNNZEt3Z3lPblk4YmpPVmtScE12VWZQYjdE?=
 =?utf-8?B?d0c2cFF2YXNBWFZoRGN6RTRFSHhVWW91M1lwOW9rZVdRWjVnSUdMNFlTWUxT?=
 =?utf-8?B?Z3A4OFM0UTBiMmszNEtmdC9WZUVFOUh3NFFDL0g0RkdzQ3pBSmNEYnRpN3Uz?=
 =?utf-8?B?M3lZMEE1RUp6ME1vYXlCWVY1MjA5SVI3c1Y4TEl2UXQrUk5tVENRRHhvU3Yz?=
 =?utf-8?B?TTI1SGdTcUg0a1pva21Zd3dGbTlPVzk0QTg1SnJCRFhkWlFvRW0wZlhFNjhp?=
 =?utf-8?B?d0gxakNGc25KKzFacUNuUTVIbGdIcmpNcUQ5TzI0dUVnSmtjWVM0OXRtL3R6?=
 =?utf-8?B?SFNVNnpkbmg5OEZ2cDNQYUJzZ2crcFYxK1JuMEZBcm1DVllQbFlkYWdyMldm?=
 =?utf-8?B?c1BLb2R0R0ZOeTJpeG4zMFpkNWJRVzh2QmFNNi9GRWloaDhJUHdXYnFlNnRk?=
 =?utf-8?B?QUtQWGtqczFjbnREbkh6RjJUaWlrQ2FSMHE4VUZoR1NQMmhvQkIxMkduWUh1?=
 =?utf-8?B?dDVPWlVMaUxkY1RGUFBWaWh3S2o4dEtxN1hIZlNUdHltYjlPMit0VDBxVXdp?=
 =?utf-8?B?T1RVVjhxS2RmbjUzeWtIY1VQbzlqKzgzV1VnVHJTUkZaRGh6VkU4bjNDSlcz?=
 =?utf-8?B?Sk8zbTZJQ0NaTFlFMFE2U2dDeGlVREd4UDZNNlRpcklvc200Mk5qTHVmbk9m?=
 =?utf-8?B?SHpPYmtGVExaUFZtOVovMFhUU2w3VDhxVTFNTXlSYmgzeUcya0srd3paRk5R?=
 =?utf-8?B?UnpWM1dNT0IzVm14ZUVERk4zc243a3E4bUtLRkM2clFwSFB6TEoyenRMRndp?=
 =?utf-8?B?anNXdThlbVNoeGI2NWYrK3NwdmorZmQzYXNwdDdKT3lzUGJ5aVdDc0dkQWEx?=
 =?utf-8?B?NFR2ajNiR00vU0VuRlFGR2c3eXVqaWhVTU10YnlHTThISElBYmVWZzNYRUdr?=
 =?utf-8?B?dkVnRm5LbEN2VkJ0ZHhvSnBTc2l2QldsU2w5MWpwM3JkM3AxRFIrMGFIeFl5?=
 =?utf-8?B?YnIrdWpLQ00xdFF6MHB4NUdJakVKODY4YXk0OXN1N0FmaHVDM2VFcGtYaXpl?=
 =?utf-8?B?TEYvZ0xtNTRJZ2M1MnI1RlVzT1pQcThvL0w3THhXeUpWcHBxamprZFZQVURi?=
 =?utf-8?B?RE9ySHhLbXAxbUNITk12dzNLcFczWDZieC9sUCtTdHFIV2l2VytVVUphWndS?=
 =?utf-8?B?U0dkRCtyUTV6bHhUREl4WHR4NGxWV21QOE1lSmFORjF1bHVZVSs1YnZndy9n?=
 =?utf-8?B?OHhzUkQxNGZUNW5adDlUci8wRHZuaHNxQjA5eG9tc1hHME42OFBzNHlEOURU?=
 =?utf-8?B?UW5XUE1FZjFLUFB6M2RRMVQ3Z1FSay9mdmNJTklyTTJLNUxBa0dYWFF6emJj?=
 =?utf-8?B?aExaeEhROURvTnh2TXE0bDBERFpzNjVCSGVLaitNM3JUOUJJRlQ4RFE5V29t?=
 =?utf-8?B?VGRVRDRya2JOUmlaNisySXJBZVdoLzE2ZGpRRy9LSUV1eVphZ1VBRmtLSEt1?=
 =?utf-8?B?WjFYYSs5c0RaKzhGMTZrRDdkdUtTeHB1eTVGY3JzQmlvay9mWVZxK1FZZWV1?=
 =?utf-8?Q?ny8wlRW3YYbJa7EvT3iFhN2iF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1467c62f-55da-42e6-2bd2-08dbbe40b31e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:28:49.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTWjhtvi5hTbw1NZd+60zM/lchSxo3WVsJwDI5d0kY1BXNENHdmZVFFq7NE8x/Q5qc0IZ9AxmAvG5I2l/ogQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 supports four gpio-ranges at max. To fix below issue:
"gpio@43820080: gpio-ranges: [[30, 0, 84, 8], [30, 8, 66, 18],
 [30, 26, 34, 2], [30, 28, 0, 4]] is too long"

 Update the gpio-ranges property

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 7c2d152e8617..59427d97adf5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -59,7 +59,8 @@ properties:
       - const: port
 
   gpio-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
 patternProperties:
   "^.+-hog(-[0-9]+)?$":

-- 
2.37.1

