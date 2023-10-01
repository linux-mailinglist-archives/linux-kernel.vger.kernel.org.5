Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7847B462F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjJAIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjJAIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE510D;
        Sun,  1 Oct 2023 01:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn9fosKB40QokRaYaXvnNgbrqH19f728dIILlZNrxqemV66a+1140tyab32imfL3otZUKO/u7feuEAPnHlCZ9F4z4U7RKOUZGxiFo4WCDDTmBQZcBoxajwEansCYs8TwQucbcDgI4PYnt23KvRTDKTJ77dX0JgxlUPIUi9esUpeEp4a4LkuMI67iUrW2fMl8kEA1outLWPZXPnv/OotohwbJZKbcydNXEyEVHln3hxVdsRJqJXMw7yWS6THNMmm2G9qDFsXB1aVEmx5v5XjRptyWPaV947s9ezwNIWTsb65oBBowJ9CgKvWQh3MWHoHaRr/CS7AWAqcFLwQueudYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUYg7ecVMzlJxOq90M5sG3FHyN4xSPKHy4KtOlukKkQ=;
 b=EtbGEB/tk4xBCwQfxgWcd7relzKYl+Ds4tVSvZuP7APr/3tRZEQKKZjsdrHX+JP7ekIRsqZgzEOTV4h4k2+8msZnAoVE2rtlyZelTisbTdCnRXUmhk1DFGnEk8ehfkFN88ves/9XfyYNLBbpzydFIHFFSKubo9ozjSke1YfiQ5LPux9SLzUf1SdCia+OkxsrPkxsL5ybfwWy4qHLNL1fVI579WoGytHGzbOe1cbhM/1+VkWdv1p59Wd1UxRJbXzez/AwG4j7RPi7RD0sid+pBG8tklvaPzqewIbZl5RA9aAavjthT4bWgMb4Lo4ER9rEkVSmi20f0C6x3rPY+Op+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUYg7ecVMzlJxOq90M5sG3FHyN4xSPKHy4KtOlukKkQ=;
 b=bomE0gA59t4qE8J12NduU8qZqZdqXddO5To8TvZEUOOtp/Oy3a8gaychiuvJqnSAWjEzLNa5sMFB4rwT7rc3TUssTxWTWbiuQs+wuOOYN7PEux/C2sh7kbaEXspru22Awzu8ovXXW/moYC82u5mdi0WI1IsFNkSshRkIv98dXhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:23:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:54 +0800
Subject: [PATCH v5 3/7] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-3-8d873a8f224a@nxp.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=767;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=bqj5w9KLakqJpVgkOAy+Vm5e7QyS1473PO8SpQf9Vaw=;
 b=18MqqXjhZeRkJU4coeuHK5JIo+QdKpUOkaHXhNM/VRLpbAk3dTP8Q87OzMHIn75ezld03yeHN
 d7wQx8yo9O8DNBuAfuy7QYbprgHLRHm8qSb40V9meIt8uZknrqCkUtq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9c0785-0ff1-4a13-7e9f-08dbc257b3a7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR/X9fVzdIJ3Wf85fpSvfP3o4OQwjskoBnrY4u2tCjNtArDZwOLS4uwmcOQpcoycs1dUSSrYSTFiqW3UXgpp1/FYKl5kJsgSnrfinbVddmnY4BCw7xbO9Vf2dimrEuzfc33MdDALIpW/nvZ0uGVTOS8Xf5N+91rno9hmtsU0Egl8462McpV4lklPhQLaE06rm67/QpI+cPEgxESjHdzvoVR9vyT0Shd4UijDKj/f4Ev3aRnPmlJKAZOzqC9We3Mq0D6FPyvwyPzTzv+c54wJSBCGfDKZeDIfn5byHzTxbSzipKwVHOi7oPsnryGwDmwYV72JNZ5cB3papdY654t/7IGZgrNr1bP7x8uEepjZs29elCshe9n0O2MHwbxrXdlLZDmcLmyDmKpoATaFwOYdBXBEL/ujKNtfnyHuOKKxui7L4zX2UFF3mg1b3aPosq9xTabsBsheDb/wVkK/Kx30nDXSQP9Kl3cg80FRGGN99FB7TkKZ10Cou9yBiqtB8ZzDQjHJCDG8HlzmWchBgz7Uz4Hm/tNjEG3KKjQ8KaeresXx3MYGBWTJyiY+CD8I1oQDc7EYSADewnCkr5mxV6GGOKuHKFKkrDdjCrPHYGeQX6V3fcMhlgmGUX0Iy+yRpuPRupXCUHac5DKTNiXfoORzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(316002)(26005)(2906002)(110136005)(7416002)(8676002)(4744005)(5660300002)(66556008)(66476007)(66946007)(8936002)(4326008)(478600001)(54906003)(6666004)(6486002)(52116002)(6506007)(9686003)(6512007)(36756003)(86362001)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFpLaEJBaGgzamlEZ1RhRFkreXFKRUJ0Qng5OVlaOVlKbGxRKzhuMEhucTR3?=
 =?utf-8?B?UVZSd0pVQkRYZ3ZYTElnNFhiaTBBWGNITUx6VjJaazRXTlFuSUFHeTY1Y21N?=
 =?utf-8?B?YTZTdkNRcVBEcDFMVnM4aG5ZQkxYVWVEZWNsRWxSVXM3RFFZRU16cmQ4bTR1?=
 =?utf-8?B?R0tPdy9rbnhxTkJ1ZTErcXZrMmQraW5QdE01OTlzNkExN2x0U0JWM3JQdWlR?=
 =?utf-8?B?ekZDK1hBVTVGQ3VOaTF5b3NCbjBxV3FmRUk0UzQvT0YwQS9wQ08yd2dFdUdF?=
 =?utf-8?B?b01uZlVoa0x3bldwbjdzbSs5QjNXR0xpVWY5VTNIVTBsOE9Ka3ZDNEh5WUhG?=
 =?utf-8?B?Z2oreU54WGZ4cHZnYUNna2ZWd3Vmb0hPT29iMDV3K3Bvd0RNeHZxVnFob3NT?=
 =?utf-8?B?a25wd0M3WllaS01Zb2w2Y3JnUnU3Q3l5QWlWQWdPOEtURndZMHhrOE1kUmto?=
 =?utf-8?B?Y1FjS2I5dnZCS2szSUJBUG5kbnpzcW1FSndvbkdxRmNZT1RMS2o0SlF6QnhE?=
 =?utf-8?B?cTRMV0x5ZXJKK3pSamdES3JuS2tUOTJmTW1ITFIwWDBmdGtxMlVKbXlxRzNt?=
 =?utf-8?B?MXJSYVJ0akE4WnkvdUpEaHV1b3dXTGNQQjlJRXJYQVkyR1QxcWxubU5IMjc5?=
 =?utf-8?B?VjdlUS8vUWYrQzlhZ1ZXalNUYUFNNkw4L3Rrc1NodWc0dWVkZkxnY3IxWkJj?=
 =?utf-8?B?U3dwYWxveWxLNUFNSDN2NjZwKzBkeEkvSHdYRERNbWt5ZFVBZWREZ2N2UDd3?=
 =?utf-8?B?UHgzbW00UkhuNGJpYWQyQkl3aldTbkVtRmY2OW1QL0FtRHF5cW5oTGt1V1M4?=
 =?utf-8?B?d0hCL1FpdXpNWXNZbHNQNlkzN01jVXhmbm9hNXFVckhRU1I4THo3ZUxsNW1q?=
 =?utf-8?B?T1F6cmZhT3VVbXg1NW5PRjVhTk1GQkp2ejFWak4wK1F4aElwSWREVm9Cb2ps?=
 =?utf-8?B?UkNQdzFlbUpkUkkydEhKTWF6bzlHV3pHNlZ0Ym9FTVFibURrWmZST3dYVDJH?=
 =?utf-8?B?NnpUWHlNbVJaSWp5U2cveS9lSUtJL0hwYisyUllDYzFxVSt2UmZiK1N1STh4?=
 =?utf-8?B?VURKWm9wS05aRHZXZmhYcTROYzhpRklzdHFPWHZONDlWQ3RvTER4cHFkZ2xQ?=
 =?utf-8?B?OXNGcmMzUnFGY0lnVkQraWIwa3VEOTgyTTlnQlMxVEtCeDEvT2lnQ3JWcGR3?=
 =?utf-8?B?bGVRSzBtdmdHalNqUjdDN24yN3NacitnbWJWQlZ4Sm1QZzBnWEQrVzJEZENa?=
 =?utf-8?B?dTNLQ2xlTGpCRnNKUmRmNGlrdW5pdGprNHRBbWhCT3AwaUo1Q0kzbk9MRUJ4?=
 =?utf-8?B?MWsycElzWG9SY3lISTJHUE9YcHRNTWJFRENoKzNZMWpDakNHNTRrdDFOcitE?=
 =?utf-8?B?NDFXUFZTK1orMXdITEgzNTl5TGZXRDY5TWJ3bVMvdVNMVTdQWWJwejRML3pi?=
 =?utf-8?B?bU04a2c4ODl1NmZ2ZmNoZGZ2UUtzRDBsTFZQUWtZWGFGb1l2SzBGVWpKWk5i?=
 =?utf-8?B?c2F2T2N4czZpVFViRW55M2FxaGxobml2TTh3ejlMZUVhNEI4R0piUGhMNG9t?=
 =?utf-8?B?cEJTNGlwVU9mem9QRk5zRzc3VmE0WTN2TG5hbitFUzgraThSMG0wQ3pCMmM2?=
 =?utf-8?B?K3RteFpqL05DNDQzbmkyMC8ydkc1L0xncDhjbVBDcml5eHVCbUdEdjhNaTJS?=
 =?utf-8?B?Smk0cEx2UmlpS3hXQm90MGVzSVY1enlwQVZnVDA5di9FZDUwbDZnSlU2Q01O?=
 =?utf-8?B?bFlvYUVVL0RVczhYMG5VTStjcFN0Uk9GcEZ4WXdnNjlzVGk5a3ozZmkwMkhC?=
 =?utf-8?B?SlArU0VISythaWd4TzNMQnkrZnlzNHRDTXRxdE40Y1kwb2RFQXhGbXlUQmFy?=
 =?utf-8?B?TFlMV1lwVXMzZTZpYklXc2NzRnpFTkFLL0tzS3RBNXRCa0YzYkl0bTZ6RXJn?=
 =?utf-8?B?dkRmd3BVZUZkS2t1TjZyR3JRMWl1NjdxWHE0TGJaMC8xQkIrb1lXNU5vZnho?=
 =?utf-8?B?SmZtUmQ3azhHV0VwUGZ1UVBnOGE2OHRhV2NDNWdWOUsyQ0s1S1V3U1NkMjBN?=
 =?utf-8?B?THVJOUFtRTNqckozeUFyU3NwUFlCVjZ4a0VUTXh4YUxTNlU3ZXhXamw1VUtl?=
 =?utf-8?Q?nipe/cGM+sByhT8tKg6xA6nYT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9c0785-0ff1-4a13-7e9f-08dbc257b3a7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:33.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHZkZsngWElPblJY6gbDHiSNSsJd8t6Ml5Fdmj+dGxr38HIA0SL3HCWGFNqZHQ2rVPesUBbDpw2lIlVz/OhlpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 21199bf221ef..a27f92950257 100644
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

