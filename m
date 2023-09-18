Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAA7A4440
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbjIRIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbjIRINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:13:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1801982;
        Mon, 18 Sep 2023 01:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVFdzbAnb4pcrz9K9t+0u37az7BU7WNdbQPX6Dkyb0IjZVDjfiSKuA05TWI9konYITIzJpb2/TIciF8+7Volevyq45jPoFS9w4IES2hjG4KYyC9hXAlxgGQEK0aM1CyKTDL59L5SWsR8uQ0Gim8yQ0JTlge6hXD12erf14FnBdBxpBECylBAXxivHCSzlN+KDNp7RT/6ZEAi0oiLBfKNUWVzTdLT5m7Y7wXAeTAkEDbDRRJjMShlhofkwHrn12I/3LmwUFFcGpRgxcGshQ2ZjhpBJtIxNXTO+NryI48iE3WcBK4OkMvOwuQOtA9BkcziS8Tlx24dFPUsjLLF4nW9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGnoxuOAQGgQtBvdeSMLQN9cTcCaevqK4mjNgrrzlek=;
 b=TTzZMmxwAwO2/Kb2VG2gisC4Va3233NLlw502M6XgbNHwKWDdKBbBH5+1AZ2dGg2mXrSBtazRIsFP6wMW0ZBl6zhKeO0YP45so/xM2blXrRzfrZic7Vg1hhwGFaLB/E/loCRiwOvs/SVq8Mc3sJLR9bwk8IZrEfE8Ok2p+cUXf24pBV8Li6HjcBH1pDQ1FqSZlkg+ABPH50F68Hdjrg6oCw/BaiDyr88R2nFD4p24aobO78JYQGwFGTuHsebZBCaatl4ciprAvTy3AiH1Nh7prZkp6VPESB0Z7KwTyuT5ylVieGDBYsjnmHDoM78/U9UA5d7Ewe8sPyim2l16QkMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGnoxuOAQGgQtBvdeSMLQN9cTcCaevqK4mjNgrrzlek=;
 b=fIVy14uLHIEG6cRHCAHujecYNhxt1OfUisXMwxsaacHPmg9eItrT4bXE4SiBolbGZWr6tJxAT6IrKSkrejJpBUahCzG24kv4ZSAasnkL9b+Ni0ybPOA1+QQ5Gy6IBO5bEhQKTG/iq997JlxI5VVLsMVkxg9qdpqaBHGJ4didQ4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:11:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:11:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:07 +0800
Subject: [PATCH v3 3/6] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-3-ada82a17adc5@nxp.com>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
In-Reply-To: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
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
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=767;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=q2Mzv9s+ZpEPMBmwTwSmQLfkBDqXMnlTtFPinw2IdFU=;
 b=Gej9VfWpuxf2ycbGdPEiLg7o1lVeTFsYxVjhJ0+a/eh9kCcBSnw6JYuf/G+g5XmHEFWEhwm3y
 CAgLBRr+cflA/PjxHn73GZQaqe8+ikfFRgG9D+LfhLXrgDprRYlGhIW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f0500c-88e7-492e-0f95-08dbb81eee64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6UvpaLkgohOVnpu2541xMMW8lyga70uKkNOp0v6k5ezk+ccCdmXfuziP8AuYpXwpeqZwDrY0RS3k8x+8eHao7/oZzWdi8e3/dmzo3gUOsDRYi3KCU4m9uEjHnrHafEShQUUv+b1dT5Z6mhf8fGxpl1fkjLnoBGbDUPzRqWd7tBdruotS1TJ3HlEXFIPQMQMapEiSZ8ICDEOgRkvUu0woxQg65JGweitbe50wTYOywbilMCq0egAlGh7WWWf2UBbvh96bl+ODN3wkervlycBdxJLWNA13WMABfJIpcp5v8O2F5h2KhPN/dYwgiXbbC2Pq/LkuOCfsef5nAaB9iYWwdCnHmRQxyz0OV6KtUAZ2HGMjL/bXUIKRUmoHzUgAeF3kKJGYt1zcZZrSq4XAd76QOUzWV/aLZn0obeNgj1ymJN4eLZL6WSB4+RYRw5PmViesACFau3KYyntu6SMv1K5hyJpNzXcj/cR3to+VWuzrGc8NDIj/BAHGVe2O/tEDkBWVpmat8sHDk3nRfCOKpl3medO5FC60fCnnYmEAZ2QKwlwTycU8M1gsIPmsGq8hrSRQU5h7BShKvPk9Q/iTesOQBCZI8WN8OVIuarTd/996VlJsVica3wVRWrGUwWYHs/E2ocYjqAySAzZ8xIovKWZJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(8936002)(8676002)(4326008)(921005)(86362001)(26005)(38100700002)(7416002)(4744005)(38350700002)(5660300002)(66556008)(66946007)(66476007)(54906003)(110136005)(2906002)(316002)(6512007)(9686003)(41300700001)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZrZ0twTlNPL3loSGdvbWxGVFltWlF5bUJQQ2FsZDRIQ1NGbGZ2OWY4bWRX?=
 =?utf-8?B?UHNhQVQ3dk9lbzhmVkJ6bHVldGdwMHA0NFZCOWQyZ0V0b1FOL3dNSGdDOERY?=
 =?utf-8?B?YlVtZWZvTW4rLzNoeEw5RXBnM1pDZkNMQmdHN0I2OWhaUzU4aVBHQkh6ckhS?=
 =?utf-8?B?aDl5VzNDZDlBeDNWTGg4ZEd5ZFBjQXdnbHNFbzI2ZWd0elo5ZnluNnh1Tmpt?=
 =?utf-8?B?NmQ3M2VJZ3dKTUJKdlF3WHc0bjJoZW55aDBoZzRySklhOTA4TUxTM2ZQNHlw?=
 =?utf-8?B?SVJPUmU3b0RNNGV5SUFwak00MmdhTDhQQnpUV2RBWHVhREhNeitLVXFqY0hs?=
 =?utf-8?B?dWtFd3NSU0lvaFZDR1MrcUszRTN2cXR6MXI3dmkwZ0Vlb1g5N3pLbGRuMjJO?=
 =?utf-8?B?K21aM285ZnU0aWh5OHhuRk4rMmlHT21peGtIL3JmeGwzUmZ4dVdOWXNlMlEy?=
 =?utf-8?B?c0E5eERsY1BVdm40eTlkTXBFMUZEL09oc05pQTM3RFFUZzMwOEIySkJyYnd3?=
 =?utf-8?B?SG1NUTNqUjgvaERUT0pseHVRQmorMXpuSXpMemxZamVYQm1NdEkzS2tIUjhW?=
 =?utf-8?B?d0dWb2h4eHN1OHBYRFhmYUU5dzhZYjgvWFZiNFhmQ1NaNjNHcC9MTmcxN1ds?=
 =?utf-8?B?TzVKQjJhUlc0Rm55SVZJakhTYWhqbUtCV3hyS0tpQlJuZWlLTjl0ZDVQVTJK?=
 =?utf-8?B?VUFOTUFhWTBMamtYNVBTdlh0MHpYclRlS2VlY3BVN212djFGZ1V1QWNjRzdl?=
 =?utf-8?B?cHQyY0RjS29vMWoyNGNqaXpndnF3ZDMwajYvNnIvNWZYMVZEbloxanUzMVN2?=
 =?utf-8?B?eUNlKzdhd3lld2c1SWxBSFNiNjFtK1VmWnZER1Vickc4K1U4TWVpT0htRUl0?=
 =?utf-8?B?dWdWOHIrMTFhYVlYMHh4UkJSR2w1d1ZLRERDNVA2YVlOb2xvVnpYV1JWazdx?=
 =?utf-8?B?anFpbG9nV2VKajN2KzV2UnljNk9reVpiY3EvaU5Sc0UzRWYzMXlEbG0yM2pm?=
 =?utf-8?B?SGJtMDJYb0ZyMHptbUcrWDYrQ2c5NUxaYzQzc0xZR3ZHbEVKOVpwSVd1VGt1?=
 =?utf-8?B?bVZkZksrbnNRdGovRDR3bDB4MGhqYmFLb21hN1FSK2V0Q2x4c3Z3Z09vcitP?=
 =?utf-8?B?RjdRQ21haENiZzJmQi9zV3FBSWxyd3ZqZStOSFNKWFd6Y0VNK1c1dFhPc296?=
 =?utf-8?B?UEkweGF1NEEza0pkd2JrT3lrSnFPS3kzV3Q4aldVc3lvWTBKdmdxUVdYK0dN?=
 =?utf-8?B?bWZyVG9rNVNPZ3EyaVNkU1h0ekxPNVJ4bWR4T1VCeXN3TW82YkgwaWNtWk50?=
 =?utf-8?B?Tkh0ekxxQ1R2R1VIdXRqNjZFWm5LU1RRS1d2SGYyZnNzTU0xMWswbExjbzlT?=
 =?utf-8?B?Ynh5NUdwcy9nTUJBWm05b3FxT1QwT0F4anZNdUczQlAxbUF2MmlsOXRFeE51?=
 =?utf-8?B?U0k4WEFpd050ZEd5Zm5HUTFVZ1M3QkJFOXdrYTVIMnBuR2x5Qm1JcnpOTXZn?=
 =?utf-8?B?eTRrbXl2QWxvWlJqUUtzQ25hNmdkZG1JVTNwTWFDaXFFa0l1RDVHbzF5Q0d6?=
 =?utf-8?B?M1dLL3FrM0dRczNKOGtCQjVqUGhTeVJUdUQ4YXJEaUhuc1RRR1J2R2R4Z3dK?=
 =?utf-8?B?SFphSERMNy9sMjIxaWliVUZHbTZuQ0NqQW5zVENTY2VFVExRcVN1WDMrYmd5?=
 =?utf-8?B?NVptNVFWa1VVcmg3RDdYaUczYmtyVHM4NlQwZSsyRlo5RG8waDg5U0xEdmJp?=
 =?utf-8?B?K0NhZVFlSnhTaFl1WGg4SmR6ak15RUxZY2h6ODR2UmllTFBleTNHQUt2Mkk3?=
 =?utf-8?B?S2NCSUFBVzlaUlRUTXdoVXVRVWxVRDRSK296b3NQOUZhakNyUWd5SDZwOHFX?=
 =?utf-8?B?Qnd3cTh0NXBsYmE2OFVsczlvS1JyT05NZStzSkRoYmpVNWVGN00wSGVUUHM2?=
 =?utf-8?B?Zng2SzBBaXo1WG5lYWhaM1ZGUkt5QzcydURjOWF0N1p4bExFck83NlhrQ1o1?=
 =?utf-8?B?ZEF3SEVRYUgzU2tBMTM3YVFiWFJZWWFGays5bkdmMkRPZU1IZUx4ZGhOMzlm?=
 =?utf-8?B?Z1EyLzU4dll6cEIvTFl2WEZFS05tNW9mVno1T3EySWxpdk8yTDNuSDR5QUFt?=
 =?utf-8?Q?s6lf2wO3A00dyYNv4wv7/Yi3s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0500c-88e7-492e-0f95-08dbb81eee64
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:11:59.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UmT2zjXxJ1G9vhVRTmpZK+J0Qr21GlQWbQmnG+CJmUkxmu40Hs76sdcJOmiHuVivGEyDKcgNcAT1lC7auFoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 compatible string which is compatible with i.MX8ULP

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 5243b4cf1235..78979b32ebc7 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - fsl,imx93-gpio
+              - fsl,imx95-gpio
           - const: fsl,imx8ulp-gpio
 
   reg:

-- 
2.37.1

