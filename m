Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7C79F7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjINCRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjINCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD51FCE;
        Wed, 13 Sep 2023 19:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hsuzl+PUm5GS/Vs2c9GyDpt32FrPZ8L2HjvsjRsH86OM+hA0c0oLVco/y8Tvvb+Kd03pm8XJBSkj1SqcRky+lEhKD7IrKa54lMsGcSlt+l+6EVpq7KZ4UKKnSW88R9mBdPZm0TndyTMBpcoFSWu7d80J0a0QFFGeZ6kU/vu3ANbeV/6eBMqgEzlVhOm6LYSd9d5tJQv1btHpMXIg3Cnhqj6lAqACzGpDvetq1qshmzN8Xb+WpiqZ9thr9jcoeWezJkPIf2bvd/RAHL5GWgqUHeGv9tXxwjzzQH+ezHME4M8XOkymrwwVw1FNb5cWRKi9J4c4zloV4uvzMJCEwq2pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOpglW9aCtWKW6qK8GvD0WlBW8UF3DcX8iYwwH+kxSY=;
 b=LEoi6AaCZwyGSrzoCmEAq8fGLFYtMIHltLqANWyvMjsevKQZJRn8Y4FseOpdLm7NFuh4lOZVAALGGnc2grmxnTtvKHbS1ij5UAYe1kfGcWBtzf8KqKr0a6kPWR8vWRmX4trHMwFGTQ42BQBxRjxCPoEoD+9HcC1UuYMgTUQOqb7JOeYODOrWF1NWnmYdDYLF9Zh12p+SWaSaZkgJOYtwM01TlTlUE040HKNggdh3GRFmHITfUHihkGsmEOnD11YYwTTfaHu8Q9zz3v48p2sqD5hrUR8x8qT4tfJt9DMwBRyfYqHBZNr7S4j1HmxOkAZH7v3RKRi0kzlq0lYK7nBRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOpglW9aCtWKW6qK8GvD0WlBW8UF3DcX8iYwwH+kxSY=;
 b=SWw9dbOzGx2x5oNtC7D1GrQ2jhmfKfUarSCSG9p9ACR9ScaA/gs8m8DvIxZZPWnr4lVKxqkp5A0R+HSJYBcsdkR4U7hG9Of2CofThA4uJtYxdSDgqnELl8mADpXGXZdPS1vQEYVZM41GAti1emQfSQ14cwCqMO3K+3MnM5il+E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 10:20:59 +0800
Subject: [PATCH 3/5] gpio: vf610: add i.MX8ULP of_device_id entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-vf610-gpio-v1-3-3ed418182a6a@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
In-Reply-To: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658076; l=805;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OPiuO3T0/WorjjvFLYLRoNgrADNWE9MHLlWso3afXeo=;
 b=vPdoE3SNxYa4yZPKCmzwOHv0PYauXLxUK1HDXi8Ib15F8YXSTmfRSShHVMqA/Fk4xTViYdeGh
 P7WoBhBDij2A1E4bUJiGKOymHARg+RY2u4nz0nhQ0fdVbaPwHQ8JDfx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e88fd03-f01e-4b83-5868-08dbb4c8a287
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ol8iJp5pzecQ4L6ddshosy2/Gpk+3NlCa7tFR5YtjzTzOsizgJ+hp2uzy0PVLVZqZiSilrOmdj8vvurbJa4jEOwt4YVpfHaHhtBWOLZm4AwaGoyiqYftOzvmrvXlzc7X7C1hTutmrIXDt1jhRLGU8k5Hx33HtFeeMf6JgyL5CBdur5taIsI0CdwUJsYd0DJpY50YvX5wwWxfSZ+sHRbgxHrbb7n2gX1iHVkgTVM4YhD6CFuDGVfo89yYHES+n07NDYQxJitSh6j3QRyfRA2NfP1pov1+UrR5eQFe9tySBoYNwYAkKaHaKFVH3zYVw+eYeaI7LOis1pb9rj2IqrQx245mcWKkMSpNMZh8NJwepLX6gb5+9BnlU9FZrK43EjQGQjzkR6p7T5LdLDkxq0dQJpH+TrecVE/uCgUNUtd50MsSWw7vSe+B3fF7fjUwr3P0dJ6qABg9HTQU7TU0PmQrPRjy6cCWvLSR6ulos8whP7LLvMiGDoqetO0rnFbXN9Q7XEkE9ziicpoI0Zb9PxEOGpfp/T2O9zCI9MJWPs1tBhwMOkHoEQMpEDsMrGfoD5+4IDP2Y/BQ92QxoZn+XN622Q/iY+CkU+vJ/6RcJKDW2fZci1u952j1Y8908hOpTyaPcK8nQn9SAW3oBNM+BQXqLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(4744005)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(36756003)(921005)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME0reHYxYi9aV1VhVjdDUDArdnhZZFZ6ZlNmTzAvaC9qL2llT2taU1Y5U0ZD?=
 =?utf-8?B?YUw1RTJDb1BmOEJXQitmMnVyditZQmI0ajhwTkhGOTFqSW1KbjJyUmpkRmFy?=
 =?utf-8?B?clNmL2xhNUFPcE56MDNQamtUVTVGN2orY2VCWkpaQjIrTm1kam5JbnVmZnRQ?=
 =?utf-8?B?MGlaTC9QT1pJNUhLTExEM1d1MnIxVHR1c29ia2Q0ZVZOUlZmQ2ViOXZPTDhX?=
 =?utf-8?B?aStZZlpNaXlMYkFkMno1NTREcFBTUVBKQ3dUNXNWaFl1UEplZmwxZDBmZ3Jz?=
 =?utf-8?B?NmMyVlFkM0VpVjZudFNjbC9aM0V4ZGpnQkVBSGFjVS9rWHhLZjNHRGhHYkRM?=
 =?utf-8?B?STdkakpINW9KV1RQQ3o1NUJuZnEvVUpkMTZSWG11RmZnWXd5c2YySng1dWdX?=
 =?utf-8?B?YkVjaU9mUjU3aWxldU8wT0puOFpicEhvNGJPNEVjQ0RaMWNhOGtibWVBemFv?=
 =?utf-8?B?K09YWHhjc3ZGcXozOGVyYTN4VjZxd2RCdWdZM1doTDNZVThCS014TWZFaU9Y?=
 =?utf-8?B?cTNkUXBmK21ORjlQd2pIOEdXRHVOK1lGcHBpdmUwWHFJb3I4N0g5ajRLUGds?=
 =?utf-8?B?Zzk5RWFHVjBqc0RJTXdHUnZuQXFLSSs1WGRMZXJ3WG9Nc3QydlN2cjc5QXo1?=
 =?utf-8?B?QTRrbUVYakRPM1UrSExDS0ZQZlQxZWg0NWNlMm9tajZ2R0FxZUgxc0xMY3B6?=
 =?utf-8?B?U1JHZVFtcWJ0K0NUYTdDZUl2bytEVjcwQWd4UkF0R3pHdzVEaXd4WUhtdWFG?=
 =?utf-8?B?SE1RWCsrUFg5SE5JOEoza2hZZFpaZWNtZlJOYWFSYld3dGszQjJnVEw2dk4z?=
 =?utf-8?B?NmFZakV2Tm84OWg4Vy9VeTh6a1VYcXFrd0JoZnRIVHhPS2xLcnJ6ZmIxWXQ0?=
 =?utf-8?B?TVNLeWwzSGh4YkUyRWRvZHRZaFZ1MGlUN2VHUDBPZStDZ0l3bkp3N2Y3dHd3?=
 =?utf-8?B?SnZPV1JaL3FvQm9uaU1jenR0aGl4WG5yb0wvUTJBY0pJcUNmM1QwWS9oZnpa?=
 =?utf-8?B?MGxkNVMySUZSWmJtMG9FWEk0YUJCQTE3emRKZFFvVFdxYkNNTUdFNTBTYlpp?=
 =?utf-8?B?ZEFFM3hadjMxeFpMVEZya25oWVZHUGpJaEIydXhIbjBQdllVcHB6QlFYUnhW?=
 =?utf-8?B?N3NVOG5DSjRJbDFuR0pYSzMyTk5NR0l4Mk96dG9JcnVzU1BzUE92a0RSald0?=
 =?utf-8?B?Mnl4UUxtTUtvdEd3TkUvVjkxT05MZXVDZng5RkJnYmxCTWtOV045QmplZGNl?=
 =?utf-8?B?a2xhV1Y3OHFvcUdUMDFCV0MvaFFuNExWZTNaR1QrNFVxZ3ZwZTNyZ2wwVEI3?=
 =?utf-8?B?MG05QzdkU3JhQUlrd2hoQjUxSUpiL2FFWXJiMmRlMXhxZnl4MzJ5eXJscWh2?=
 =?utf-8?B?eWFOeGFseVhnUUZoK1NlK1FMOWFXRThXSlFwb2VRdHpKOGNkdzdZNStnZUFC?=
 =?utf-8?B?RmRCay9HU01HU2NFVWpiRUU0WFVpdWNCUVJHMHROakxwZ0oxM3M1ZTRRZUxF?=
 =?utf-8?B?N0NrZGJTWUE5a0F3RTBYemJLRTJscWhJR2k3VEk1b3JnT0tQaitQaE43b2ll?=
 =?utf-8?B?OGVMZVllcXE2REh5OWhvaG00Unl4VEVmSmd1eTBBNTF3M2Q4RDE1ajdqdkF1?=
 =?utf-8?B?OSt2RkdqNHFRdTFIYS9HbEx6OE9aVlROdm1uenRIUjhWQjhaYWpHTjVQYXNK?=
 =?utf-8?B?MnRRbFJyMmROblh1Ly81bDlIN1lDZnFESjRJS1ZUcUNDajBxOGQxYVdWdmE4?=
 =?utf-8?B?MGpKNjJFdWh3ejlFOVUzYmd5WEJscFg2Mk9ad2xrTFdPQXlzSlRTYkM2YnJC?=
 =?utf-8?B?OFo0Z3R3eXBDVHNaTmFXOHh0SStIWGRvQlNPY0lDd2c5V2dYbk5vWTBwQjNi?=
 =?utf-8?B?ZnMvQmpncjNhNURDc01oY3BzbzdVQUhyait4NnUvT1k0WWFka1V1SlA3V0l5?=
 =?utf-8?B?SHRKUElCQi83UGZpUStjeXZka3JCVzhOTG1ZdlBDdk03VGVHcExrY2YyR05T?=
 =?utf-8?B?RjJuOWNGRENzb0YyVzV0dGt2V0JrL2FZWkRIMGQ4RmUvUE5iUW5mejV3UVZs?=
 =?utf-8?B?SkpsTUJKUktiUEU3OCtyLzJUM2NzeE5wY1IzRksyT0VsRW8zSnlSTGg2dk9H?=
 =?utf-8?Q?jg1c3m+qZb+l26UWHdxi0IUwj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e88fd03-f01e-4b83-5868-08dbb4c8a287
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:41.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+v7/a2n4QDxim7hlIDQLTx4Yn++c49oshFfQh1ww21okrGb/e8MHDgbE43zF4RTvKYU4xS20yp312pg+kb4/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP supports two interrupts, while i.MX7ULP supports one interrupt.
So from hardware perspective, they are not compatible.

So add entry for i.MX8ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index dbc7ba0ee72c..88f7215cdf4b 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -67,6 +67,7 @@ static const struct fsl_gpio_soc_data imx_data = {
 static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
 	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx_data, },
 	{ /* sentinel */ }
 };
 

-- 
2.37.1

