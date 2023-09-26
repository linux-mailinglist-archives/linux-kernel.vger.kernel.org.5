Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C37AE417
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjIZD2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjIZD2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:28:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E10B4;
        Mon, 25 Sep 2023 20:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6tyuNir3dKB6mIElpuAomwoGXqGAbUSKjd/rJoUoJmU3ySmqgetQ1PkCM2kQ3CmZtVA3gjQw4ItGeFi/uokcjSMdqVRgZMORrHp0i59+QwZNRAJ6E2Wvsxyy4FGH/zXgGdsabmInITTCTAoCtT2lp6rni+XT9kKKL4EWl+PgfR8W2IKb/Lz4ia6HR+qjumj5r0WY97twXp1aSuQWqU5EX/IUPFbsW3Qi7CvaMAfqblf+HsUhMisspwekHDVqJxIl93YdETLkNAVrQkQkWvCUhTWTzZPwSPTbeN5oj7qcFcod/7FE/i3tEGz9Mcal28fWZo+QW1Bm23Cjz9MFzonWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAGPgxhWjWTDvcZq45nqhwDz1PK/yjFE22YWhHHJ/Zc=;
 b=F1CjDAZE4fHwyUOEY3EYGnaoWVwsgQJJISgOWlrNLbGHjhDspzDBI7aUlN+itJ+rleiEZ1dgzc9uVkQHgw3h7KLTEB5JIE6/d0utA3tgI9Duu+52LQrFDMW0rtKiGMPP5Q257NAKgre30lWfFNkP8xjZqKE1+6RC1pP46Ts1MfVCANyvoZNSDWY6H8gKc/fYRW2eGuHhp1TN6AtbTNq2UPkwyy6M1a2+kEmRPyrO/0QhmOfiFZtzJMkNJCWH05S8zxO2TLidCQ21HsFt9gil6MjaFx/bnyPTcJKDh7BF4AxZ8NQRzAqzgAH+3TcH4kfa/xnhtTr7lUz/uq8fQLyTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAGPgxhWjWTDvcZq45nqhwDz1PK/yjFE22YWhHHJ/Zc=;
 b=j6i/YB8WSvatSm0rkFuI+fHS0IDJ2HPv92JkTLBKpfrcVkgAqeTqVV8UDzRoIFfnx3QSzwFEsUOhzy/8TnGTtN5TzFzR/x0XrAbcpPS4g33nEEvgYPnNhP2It7/svbWvutW9gs64dvSaITMLCrdKJwZqLt+w8H1UXaLUKJGD8xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:28:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:28:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/7] gpio: update i.MX93/8ULP and support i.MX95
Date:   Tue, 26 Sep 2023 11:33:16 +0800
Message-Id: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxQEmUC/23NQQ6DIBCF4asY1qVhAJF21Xs0XVAGlUXFQENsj
 HcvuqkmXb5Jvn9mklz0LpFrNZPosk8+DGXIU0Vsb4bOUY9lE864YBeQNLcKGO1GH6hUDo1F/qx
 BkALG6Fo/bbH7o+zep3eIn62dYb3+zWSgjAqHEjRobpS5DdN4tuFF1kjme6gOkBcomeYCTaM1N
 kco9lAfoCjQoCnfoDFo6x9cluULwVQwxBQBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=2468;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2Nepb8Nij22uzn/NLfiezry07+mH/r+coagcLrbaMng=;
 b=VKOTYaLdocwp2X/v0xEJKngTg3u0VczomK9PVXcVejHW3yy+8XNnSoD0sKv6wpzAbMgZbV74d
 P44bhBgyUxUA21vc2/dRa7yUpyRy1oBhWLJROL+qFgwGP90NMP+I5bM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: d2578260-0ad0-4dcd-38bf-08dbbe40adb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzDiilOA2P4cNFz3gXv2fZbkZ5hCEqk5yivC2VO/3DAIHJUJafiYsvsf2ILl1rdUILyAUe17PpQgSKAk/lBdN4IG4YAc6/PoMPPI+C+wvtzPGBHTqlB+/MNbopW1jwNN4z9fZjP2omrQgIfYrPZ9zuARUt0jNUcUEntFTbngG6c6x2T4nSGFxT1mnjj15vVmxPu8MOs71U/HpjZ7l55/LjwifwPt6pOs1M3kk4SmiQ94vGBQTJTbicLBLpoEtvaPnXQxqaFj7ZHoapuH+tMsNaxGEsHkv8XUydbwKHs/VZSSYd6BPjZt/nUF1IICqYsLcD3Sol+DItcy0/Xqa2SOffvVSd+Syo+9K4rDoeeUAOTD1aWf4OTvsqxShTlBkOcSvd2J85u3vuQKBjZfKcU+jPlOZaIq333woFVcIHfItpwtrt/Vugb4jcXVO/+SOgBAbBG1/MWvdymgjMIYO2INqJImgXAcLpDU4xcp12B+PHW2Es5zkRdHuCtYVJAwGRIaGiF116z8QxR+w4ekjwIYGZ3nQWWTrU5/OCMv2Zw8G+p3gek6jBdqxOb7kxlAP3TgYIMsv7bRlQUdSMlkgTidbHsKBxe9BcnGLZ5kQ7yQaHw2+3ic3SsHANAi9kOvkNQo/UTDoTB5mqcgB/ny3xuQd5vyF8Kv00DTo5ht2TtuIps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(15650500001)(54906003)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(966005)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRIOHA2MGZZTU10QjMxVWNqTERKWTVUM0ZnaStUb3RoaFJENkZLOEk5RXB2?=
 =?utf-8?B?aWJzK2l3c3VSbTJXMkR6YVBWRzN1LzVIeWZ6NEtFRTFKbGIwU29rNnBsT2x4?=
 =?utf-8?B?TXBwcFdKN1BDU1dISTFXU3BISVlnYnJkc1RsSWZKcTA1V29KMzZadW8xdG9m?=
 =?utf-8?B?SnZkNjYwOElObEZhZVpja09kTVpQR1ZEbFBiSjNFUTdURCszM2J0OE5Bb1Q5?=
 =?utf-8?B?WVhjWTU5c0pVeG10eEV0Zkh4bklHUGpFTG5VSEtvQVg4VkFHeHNVLzdBM0NJ?=
 =?utf-8?B?eGFPY1R5TVU5d3kwQlpBZzhDUDVaUnBEb2RZeHR5bkVkY3BxaGZDTlM4Y2dt?=
 =?utf-8?B?NUVLVnBqSGcxSGhzYWtGU2x0VzduTmJycEFUSkFYdldMMVUrNzZLM08vQU5r?=
 =?utf-8?B?enVZRHlNajZBQUlXU2dKVFBERHZhRU1lVnhQZWk0czY5SDQ0b3NpTGNxNmtJ?=
 =?utf-8?B?STJQWnZhUGIwQUh0dTEvZ2MwQmlGcUh6Uy9JdHBkN3FXbjJVOUV4QnIwdVR3?=
 =?utf-8?B?NWtzUlZzcmhwangzSktOZzB2c3RVRDBLQlJTYzdiTFpBTnIyeVVUeW1tNUEx?=
 =?utf-8?B?cVZjS0pVYlM1TlFDWk40RjYyS25JcTlpVW1BcFdDQXJ0S1FLTVBSSHRaa2xK?=
 =?utf-8?B?L0txc3A4OXdlb3MrdHB1enBQNXNnQXp4Y1d3K0FYRWxieGJ3bnZwOWtaajNv?=
 =?utf-8?B?cXM4bjJwd2N2QkpIdHg4RzZpN0EwanQwbElhcmwwck43Rm5uYnU1VzVOb2wr?=
 =?utf-8?B?eUNnRVRmS0Z4Y09IZE5UYU5XNFF4K3VOWGtFMU54Vzl2eEZwWUQwbDhpdDZt?=
 =?utf-8?B?QS9LcGp2NDg5M0dPL1g2WkFIWE53c2NveUtHbkwxbnRBVys4STdlS0Q0VVpV?=
 =?utf-8?B?Q09GUGR0Mndad2xmWVcwdWZhSXMzSXZmRzhtMFI1V2hseW1hSTFEUHpEdUpp?=
 =?utf-8?B?OW1RNVRBQTlscEhwV2R4dzFndnRkbkdjZ0pKT0tRaDdPSkV3QTJpcUU0a2Ur?=
 =?utf-8?B?dEtvTmxEWmluUDVqNXBjNVlyYm94c3dNZUhuTXBuaUk4YW9iaERKUHh4aFl2?=
 =?utf-8?B?NnozVG5hT29Uc0hLQ3NITmRSK1lrb1ZYdzJXVmFaQktaUURkYzBYZVVQRTh5?=
 =?utf-8?B?LzFYSGcvQTd5MDI2RUM2Z0pJWXBSRzNoeWYwOUo5MWY4cmdYQkd2WEM5eENX?=
 =?utf-8?B?UitLcDlQNkZkczVhNlUrMlNmVFBSODhlVDBuc3NsNEs2MG9VNXlCcCt0dGdt?=
 =?utf-8?B?elhud1A0RWRnbE5ISXFpdVVYTFI3ZTFtZjlIZmV2Nm5rRzlQNDRMa3RnUWh0?=
 =?utf-8?B?bnhJenpndzRSYmJITUNFMzRrOWJkakJ0M3NoMWJqZDhTM2g4UVlYL2V4NGU5?=
 =?utf-8?B?YmE1eDNXRzBwS3VZTzFTclJYWk5kVExsdFgyQS9YaC9kM3RpZUFlWi9NZTV1?=
 =?utf-8?B?THNuS3ZsWEk4MDdXUDUvdC91elVsQ2dneXpVejVIMG1uZG5BWHlSMmhIRytV?=
 =?utf-8?B?MmNPMHdlVFpGK1lNM296dmJXSS9PUHlrNDhSYTNPeWxFdHBWUzE4UFdYSzkw?=
 =?utf-8?B?RjltTCtjSzBMSklObHJiZkwyM1o0NFVldThiZ3hKSGduSVM4eXFHcGpsNjBa?=
 =?utf-8?B?VURtdzB0ZDhaaVRMbXdURFhoSTlHWjZMbWFmSDdjSDlHOSswdjRrY1kxVGl5?=
 =?utf-8?B?Vk5lTUFCZGtmNlFyNG0za3hJRGNVZ2laTlhTQmEyanVwMUVnM0FmQ3hteHZ3?=
 =?utf-8?B?QTJ6bGdBZ1lkRENWb2p3blhZYy9DUXRsSDh1R2ZBcGw4VXorWldMQkR0UEpG?=
 =?utf-8?B?Z3ZFZGVQQlJOclFKM2l4NjFkZ01jdjh2Mll0SHNrNlM3RUZXR2NUN0xERld1?=
 =?utf-8?B?Y211WnZoMmJtZUpEUkZyNTg5a3cyQk5UcmQ3V24rU3g0dVFHaTk4Tm5DeWo0?=
 =?utf-8?B?NXJLNjA2c0x0dllWVkRmOEtYWjFvWXNUTXpKSzhvdVVnZnAzVDFYdkswb0R4?=
 =?utf-8?B?UXQ1S1NHZFk0YmcxbFd6MHhqdWJaNGxsakVXRmNTMTRjWDc4SzgyQmZtekdI?=
 =?utf-8?B?WjV0VlJBaG5uWlM5bDU1MzlMMUEyak80ZGxFbmUxVTFYTWYvejcxbDZOSDh4?=
 =?utf-8?Q?lt8vUF6I09jkIZZQqsiR9KD82?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2578260-0ad0-4dcd-38bf-08dbbe40adb5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:28:41.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnLV/ZnR29/yKZzw6L/GqJBDqvCS99jglRJ/tyNFBPkDjej8qZ7b62oSirj+IAc5SK7faZzULniMpEOz30M3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From hardware perspective:
- i.MX8ULP/93 GPIO supports two interrupts, 1st for Trustzone non-secure irq,
  2nd for Trustzone secure irq.
- i.MX8ULP/93 only has one register base

The current linux gpio-vf610.c could work with i.MX8ULP/i.MX93, it is
because some trick did in device tree node with offset added to base:
  reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
But actually the register base should be 0x2d010000.

So i.MX8ULP/93 is not HW compatible with i.MX7ULP.

i.MX93 GPIO is directly derived from i.MX8ULP, so make i.MX93 compatible
with i.MX8ULP. i.MX95 GPIO is same as i.MX93, so also compatible with
i.MX8ULP

There maybe dtbs_check failure if only test the 1st patch. After
the patchset applied, no failure.

To make avoid break old bindings from work, update the driver
to support both old/new bindings.

---
Changes in v4:
 Change to minItems for allOf: else: interrupts 
 Update commit log for patch 4/6
 Follow Marco's comments for patch 4/6
 Add a new patch 5/6 Per Marco's comments.

Changes in v3:
Update patch v2 2/6
Update commit log in patch v2 5/6
Add A-b from DT maintainer for patch v2 1/6, 3/6
- Link to v2: https://lore.kernel.org/r/20230916-vf610-gpio-v2-0-40823da788d7@nxp.com

Changes in v2:
- Update bindings with describe items, add one reg base for i.MX8ULP/93
- Update driver to support one reg base, support both new/old bindings
- Add a new patch 1 to update gpio-ranges found in dtbs_check
- Link to v1: https://lore.kernel.org/r/20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com

---
Peng Fan (7):
      dt-bindings: gpio: vf610: update gpio-ranges
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      gpio: vf610: simplify code by adding of_device_id data for vf610
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 40 ++++++++++++++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 21 +++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 28 +++++++-----
 drivers/gpio/gpio-vf610.c                          | 52 +++++++++++++++++-----
 4 files changed, 104 insertions(+), 37 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-vf610-gpio-46edacd2b513

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

