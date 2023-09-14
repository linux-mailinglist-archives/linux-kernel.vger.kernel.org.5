Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3479F7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjINCQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjINCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:34 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB742CA;
        Wed, 13 Sep 2023 19:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF72bbTOcd7trvF1FG5UvyltLV/ooy26IafczL7t4RBJcOhkUlRm4ymDx/MwUiHmF223R5HcuWIG3lMQ+TXkWP7tkpHc7LOVQjBgjE/jCmn+wmMVH/rHyWyHAqHQ5KQGO20stTAs11JDmIwvY7zcTKaL2zJJfX7n2hcg7X+AsuDh43O/UNAKgxZzq1lmZHomDKsGfLEj9wGF3II2RPL4oaEhS92zuJFh4dOsa4Qxtk6Jx5VMiDdfN38mmmY4NcXjHYmoQv3NCrpvCbJ84EGSSB8GFkPgldwmOCQeXZYYgUFj/ImJGjVSg38RbvCo5OW8Y6srq55y22hfTscnvNVmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I7gqN+EAKW49XnWUQ8jds5wOD0XMg1a9O2vshuuLmg=;
 b=cutnwLbXj3kofgiW3zdV0cmkEamo9u1Xmcsfe6eNid5RCxdo1AN9lVo7LAGLqj8kd7imR010ZHFBAJq03JlzBu2VJog2VVaPPKdK+BH4VS//+5ZJSILdHw/ulrgKUlpLgAVR8KHVN1MmogDvhMa6om8ULJDKH36aFdSq4I15flUuZQcbVzlGzCFq/nEekgrdOF/iAZ1JEdmAQA5Y7FanmFYp9cTkI9v8yCXYFK1yJPMm7KjPcvassH6fKmwkeV4v9vXScwdgD3fqy5GnpUG3ulcO7EAlKICYBMApOmGw2lhAcN68ezyzRPTOe7/iOOLGQpObDYpfWardzmgekuLXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I7gqN+EAKW49XnWUQ8jds5wOD0XMg1a9O2vshuuLmg=;
 b=e9MzElpbOkJkf+Dp2BbXp2wpIIeq0kAgglSJ3T1Ltdq7J7AsdDtiquJM/dvSlPBzlYNbtOwSlk2MSDTfpm4N756+fv5bSM14bbU++HHeN1RMAe7dTl29iyqJ2pa38kOLoBw4sAgzJAC1O9TJm8FyroHP934UwUnhym+/LQdRSfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] gpio: update i.MX93/8ULP and support i.MX95
Date:   Thu, 14 Sep 2023 10:20:56 +0800
Message-Id: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhuAmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0MT3bI0M0MD3fSCzHxdE7PUlMTkFKMkU0NjJaCGgqLUtMwKsGHRsbW
 1APFkLhxcAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658075; l=1278;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=4+0HG7fZrhaEVAm9lMV/Ei1bi6rJXZJR6VbH4SV41yw=;
 b=H8Fu3sPLeuUsMTA0EORUTta4c7fb4Qmrl65j3RwAKizPd1rPyl73qmpJGV7r/O2VVukXYugXv
 nrO58xZJZDcB8DaWipRIkr0bjx9liGhZBHj0wxpjpeZGje26Qi+EoAs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fb97bf-024f-4913-1920-08dbb4c89893
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLFcaCpT7UoPNrb8wUSCDJS34c/n7qyw4RTn4FgbqczwOtNJ8SDVWC+i+d+dqV2c8T54w59MRrqF7uKUpCffWWTnKNAB2vvcr8oLmNox8aOb9ordCMBo/mI8nC0bGUi9kfFzLCcEVnljgXcVpYlcn5vfTojQ1QI9RnEBrbutVMcT6l/scO4SqjXlTJsQBt0o7h0xIrjRTaK5bxzpmWBwxO4AOJzrtPXkHeeh7LyHTKamE0qkE2VYm3XQdNZxf5ygvMLeiMdEFyRohAAn2FXpT9oeaYn49UuzQDQqYStEQKkbLIEZsWLNadByIVxQKSshl4XotxsJBqdBinDRK5NmqGbRPQCZTa03vfFyAF4AwgHbwxtNLGx4lr+jxjJTCrIBiNdBopide6aQvsFeL5xYBBuCaE7FuFA209vX29bXjHWhDSHMCb0EvVIrbVer8dG/cwtunAQTSAcP+NPg7uiaVetX1V7bt1bmGaw9dxhuma7pp7Fecq2ZXWEGZONLUKFVBKh5968bbjwg03j0qaOe2PaF9TwtWQxay9lnVuA1S3zosOJ0sr16qAwrSQF/0zN/158U+xHQiB7+D5pO1sUhY/UNtJuJ7KcfQ0ZkLPGq1rWvBF3B/ECONx4n337vOXePKAUp/SOERSqZMz3UEndJRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(15650500001)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(83380400001)(36756003)(921005)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThvSXdja1luYmtndXQzcXpJSjdEai9Lc01WSFN3WGhqalJLWUd6eDlxbjVO?=
 =?utf-8?B?dno4V1U0NEJkVmo3dWF5NTRoRlFaSFhFSmo4L01DNDhFSlhVVGR0a1owMGJ0?=
 =?utf-8?B?Z2FsQUFpUHpuUEFIWk9YZllmRE42MDZqT3d2MVcrV0QrclhDTGlXdUl1emtt?=
 =?utf-8?B?VkdJaW83V2RvY2xTNkZkKy9NeG50UDUxUXR3OEtKL2tGKzdBNUlVZnZ6ZVJP?=
 =?utf-8?B?YUM5VVp3Y05tbzVsbmFyVDJIdUhXcmpFQTRDdTZQNzR4cmFUVFBQSllCMGxZ?=
 =?utf-8?B?QzZpNFkvcTlKUXlUVTgxeEVkanpJTDlwRC9GWE9sTW8zanhFWFZsNFVScmdD?=
 =?utf-8?B?WG81Qlpza0RNMEFOQlVmWW1CSzhTb0hybU5nMHVvQkRHdVdSaGVWQjdxbjl1?=
 =?utf-8?B?aEhlRU5CVEZKSUpjTENTeUJpbURFdFN6QXVSUjBKZDUrdkpUTC9PL2xZMzZh?=
 =?utf-8?B?UnM0L3VwbWNSTjBNQ3pBc1FDbkVDaVJNWTZ2d3UxUERRYTdxcFk5eG1VYWts?=
 =?utf-8?B?dklVb0N2M2tUczRRWDNzakVRWXB6Q0owUGI3THZySGVLM0RNOURWM3dqczgx?=
 =?utf-8?B?UUlHNnlaa1ZHT1RGbmlwd0pQVENkbjR0azI0Y2oxbVpQeHFIckxyT1FNdzJI?=
 =?utf-8?B?SEVzbzk4enJ5d2EyZnZnKytFY1c3cGlSUWtVYzZlZS9FWlBsY3hGeE1jWTJv?=
 =?utf-8?B?ZnRuaFMwS1djNVJ4R0Y2NkdzV2htS2x1YlFQUklsWFFmQVpPaVBaR0JZWW9q?=
 =?utf-8?B?WWNIL290SkplK3UvbFJ3OU8zd3pqMjB1ZElCNDN3Y0lkNEUyaXppZlgwNGRR?=
 =?utf-8?B?bzNKNXVWTTVGbUV5M0hIbSs4MWNyY1FTMGtNL09La2w0N29qU0ROSlV5UG1J?=
 =?utf-8?B?MWI3MG9IakJCaWI3VEVuOXJwZHVZdFNNbjZHQi9vc1R3KytRSkpkSlIzQ0lt?=
 =?utf-8?B?RFhPT1pRcnBuQkRVSHlPZjU0K1lGalpKNFJ1dXhwN1Y0WUlBaVZLQm9Id0lL?=
 =?utf-8?B?VWYzTDF0MVp0VTBzWWFVTXpQYTQxbURobHh2c1dmMk9ZU3pXYXR5MGV5a05s?=
 =?utf-8?B?ZUdDZVlJelBUTTgwRThoQTRDa0g2TVJoTS91SFRTRzVXQWtMUWRHNVZJcWx0?=
 =?utf-8?B?MUVlcFdUMExsRnFYMWxvdTlPV0JUWmx1Y1U5UUdsb2dOMHAvZzBua3FuWEJZ?=
 =?utf-8?B?YjZJeE4zTmo3QkNVLy9nZEwyWjVBdnVLcWE5NnZwNHdMWHpaclhaSGdIMzU1?=
 =?utf-8?B?OUY1aG85TTNmb1ZJdDVubXNqQUtHN09GdTc3bXAyajRONkFwTVBWbjlqRkZn?=
 =?utf-8?B?bFVPdG51ODlqQm1OSUNFN2s3Q1N3cUVVNEJHU1I5cUtwc1FjT2VSTjRoVWw3?=
 =?utf-8?B?YVp4cmdveFE5K0NublhuSFZpc3N2RktoYXEvOXRZU3NjckVUK1Y2MVpVRTBJ?=
 =?utf-8?B?ZjFZOXRtcmcxd2F1SDVWS2hPZVhQczhTazZpcXpOME8vMjdrRmkxRHE5SThB?=
 =?utf-8?B?NnlPNno1cm9USSs5QlpaNVA3RUZ3dDdOSzQ2WFBacC9tQ2JLR3lKMjR1akE2?=
 =?utf-8?B?Nm1kNVZENlNUUkNKNlNRM3FxVUhXSzhJY0NkN3RibEp6emRvbXlFUUpkOC90?=
 =?utf-8?B?ek03VGdJM0RsY0NTWlRaYmMrWDBVNDFSck50cnYxeWFKb2Jod2ppdjdkSlRC?=
 =?utf-8?B?UkdrZmg5Z1c1TnBYaER0c0h6OW83czh4WFRaS2xKQTh4T3ArY1NORTJybTBT?=
 =?utf-8?B?bi9XanVYTTU3WHdzWWRQbHM3OWpNOURtaGNNck92Y3AwdGZ4NUpsR0dOUG9O?=
 =?utf-8?B?TkxGWDBKeTk2V3gwbUFYNmw4VXBwaFl2dkpFbytITjNFZ0t0QkpLNDVaaVRC?=
 =?utf-8?B?RzNwbWxVcXZlR2J3VlByUnFrL3BERzhSSGd4TWhPdlU5M2ZiNDNSOFd0ZUlG?=
 =?utf-8?B?NmNJd2NsZFYydkdhZktHSnFZSmpFeERSQXF4RXFUTmh4UStGQmF4d3JrT0t6?=
 =?utf-8?B?MSs3cFZjL09WMzlvVEFDZWtSYWxlSG9wYk1mVU5DWUlDWkpYYUlLYkJYMnZq?=
 =?utf-8?B?Y082b0pPWTBYSHFMQ3AwbXZpSDNDMmNlSFFoVkxXQU9nOWpRZFc3MUw0VjBP?=
 =?utf-8?Q?noQiiNYwGaHRDvG/wXV7aMxzX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fb97bf-024f-4913-1920-08dbb4c89893
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:25.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2epbMq7gsFJ7PRUcNzL5iGR2ncVKnF+OPQ0CM1oKZqLyoqHvpmlmpqKhlJptyGeJNlTsyPJhTAdXDFRTFKUnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From hardware perspective i.MX8ULP GPIO supports two interrupts,
1st for Trustzone non-secure irq, 2nd for Trustzone secure irq.

While i.MX7ULP GPIO only supports one interrupt, so i.MX8ULP is not
compatible with i.MX7ULP.

i.MX93 GPIO is directly derived from i.MX8ULP, so make i.MX93 compatible
with i.MX8ULP. i.MX95 GPIO is same as i.MX93, so also compatible with
i.MX8ULP

There maybe dtbs_check failure if only test the 1st patch. After
the patchset applied, no failure.

---
Peng Fan (5):
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93 interrupts
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 25 +++++++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 15 +++++++------
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 20 ++++++++++-------
 drivers/gpio/gpio-vf610.c                          |  1 +
 4 files changed, 44 insertions(+), 17 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-vf610-gpio-46edacd2b513

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

