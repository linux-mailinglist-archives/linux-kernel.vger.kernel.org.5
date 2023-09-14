Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971379F7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjINCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjINCQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845A198;
        Wed, 13 Sep 2023 19:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkJaQkd1zrei44uULFKn2FpKqA37hysHXxlDhZwEdFiorh0oiqapfqlxBiTPvP214oNKwXAd9cMoNmM34PY+Q9LQr6Cm71oSF6U85GUTZbWMnLzpulOHpmfMEjpazfKA4ibZasa5B7r0h7xbPpP7YOcJS+6y5Vt4BLgyRnK5JUPi+Lx5qok6+rjaWmaWr5mX/a6BVJmzfI/bMP95LDxe8QzLd2axhmFGgocnGbQXvtIhEmFPgl5B/uOQ5ubA1dKbs4EVlmWuHaEK9ePbjeBfp1ST2bwo0K8z+50n64TkUd0Vt6S6aRu6Oose6//2MtVwU6T9G0C8ICdnbtR84+8CTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpCdb4CRNaltDNcporD6yKPBhCO5ohDiPGfX4wQXwrA=;
 b=kF4pmGQmI9S5MOW+CFwqF0Jcwjszg0W3i4eRR4aD9CBktrxWl+o1PaGksXfnyO7rwDEucV2+fgOJqmbBWldjGbLqVWQrPuSwFM83jnSSGaFf+miv6DKtAfzHBxDAv7JV8GkMFF46cWmqmb6Et6+L2py0uuz4bZIs3bXrThWaMFuIBR3/g1xxN/91LUZ4/N7UamTo3HDLSw9Y3OWXMTeSapmhNcpj9e9CrkA9KHaNy1/V+3aD5A0HVe6dn6cxWsODtUViAPNRokqzeRm4GVljUxlX8R3zz/016qdn8Disu0GiPicdxzq+Fcdt1ya0eXcntDjz7ipFhnm2zlO7wNhEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpCdb4CRNaltDNcporD6yKPBhCO5ohDiPGfX4wQXwrA=;
 b=ZlUzCD/jiu5YK0OmxFGD/WQNSdncU/zz4qk41W/CVeE5/eRohsymM0GpsaFsazj63feHn17x5i3jdOFsHpGwBlRbaH4qxjEIOAeQDP/BW9wsOlhNucSD2kRIbu/bn3j+Vw/egJv+ZT/ntFHjOyImVP7E4AqjykDlKg5uZXpL+rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 10:20:58 +0800
Subject: [PATCH 2/5] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-vf610-gpio-v1-2-3ed418182a6a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658075; l=832;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rpWOgpuqItSJa1iDFn8ReI8GyzbSQ+jT3LV+1JzbP48=;
 b=PeNpZpcCbFNcZHauNc29GdD56SdIFmuYQWByv/m9+xV/zkRZOSCubfXKbaP+GAUj/OX72EgrQ
 6+WLEc21RJNAn9siNBWbf3AyYkgPzHcooVqlIPH+zbtJKf+2Ov80JRT
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: b2673689-6837-4a6b-5722-08dbb4c89f34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cwBUfPV/27haY9MT+P0VEVM2X9TqDpm2j6ibUQOCWAdGW66GMzTChVn4qXAOOFJZRwQrfwxg2c6oSeF/GDfIoAxfVc+QwRFJYI+Mv9/kf8jj5wcfmvxXXayBEX3aKHFjW4dZ2P08nK0QQEOXlM4iRTtGW5ihgLlcfKGy0oHYK7DSgBIvpMlkZ5hTx1BoHoVwNgCGoETOgckFHZfqghNih/ibTbIOYhjodb5MaUzXF2KWsIXQmyAUbUE+bL4JsFaX9cdCYB6PmZDEQivGZgoeVZEhTRT6LiogDKZtTWpvaacbaXrwFlWw1P6Sk42lu7lQEIq8Ca+XDcJJkIR0U9FTSAEhn72fXnlLzDX2cYMA8LbKJ7iSQWzc0XtApqiLZlQCSKp4AuLP5984kXp57OJ1CFzAYd+ISRRwt/86VdBRcSx1ZqL+BIxIFEmtogIGMZcmz2Xy3Knx0lIAFCKUeZOy8t5177uJqeSFErc8ZVLOy3e8/pUwXaEEhlXlF1CWXsNGzbOZaQ7eZ/2YzCxScdZqnWUUVPAjL0EaLWvBI3mt7aW6aYg9Uv/uwj2M0uDc/pH/7sHIQjZNwtJ1ga2QbXHK35xWg4jce0+RCdvEpd1fDyyq94gx1u8RN/Q3EvMGmv/PFunjdg9jANT5ZgEHdCOYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(4744005)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(83380400001)(36756003)(921005)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJCTUhEcjhkdUtyK0JZaTNTVWdBRFVONW5ENDlkUysxRVo3OHdjQUxNQTZq?=
 =?utf-8?B?QTdoRWIxWFRDVEtiRTZSY2tmVTNUUWt6ZDR5ZzljZXRPbjg2NzM0a2N1QWJT?=
 =?utf-8?B?TTNlKzRIVEpsajVJclZmL1RuamNjSEdUK2Zscm9PVnFUZ2ZoREEvdDRPcE9J?=
 =?utf-8?B?MUFZMGdhaGhqMmk0Qkw3VHd3VGs0em5UcGZ4SE93Nno0QzVnZzFyeWR0WUZL?=
 =?utf-8?B?ZHJlSSt4VTFxUFVQaVRocEdtWW45NGhER1EwRjVrVzBIUmQ3RThGV01tOEdF?=
 =?utf-8?B?VEUvY2NVek9yT3o1SUtLbklHRWdNUnFUK1U0K0dDSitIZWJEMldnd0FlSjRj?=
 =?utf-8?B?cFNWNGlyVWVWVllkRjNMYnJZeHZOZ3BENEcyME9EaDZWNTRPUTk1ckVzUWFV?=
 =?utf-8?B?bm9lUzFpTDAyUEZwYlJPRlRvUG9BVkJmRkpxVUJDd3JRUlZZMURpbXQ0a3g0?=
 =?utf-8?B?OHZ1VEVjM2xIVnQrWklRUXBvay9ta2NOcG14aVhYUXhQazFaRGtGS3o5RUI5?=
 =?utf-8?B?bHpqTnVZbmp2WHZHVWMwbjROWGsyVDBEemFyTk1Wa3RBODRoTlNJRHZMRXZL?=
 =?utf-8?B?NDZNWjRkY2tSd1Z3OUJ2TDIzNlFoSXVUWDlQZHY4QjYyK0dDQVR2VVoxSDBh?=
 =?utf-8?B?UUd4Qi82MWVxU1pGZUR5R3BUOGhFRVNYbmpHWFllQnRkbjllbnF3dEMwakdD?=
 =?utf-8?B?TVN3b1ZkUkdjZmpIeDRQNkRRdzhlYWlIdmpTNVhiVllXbHR2K2M4NkxHbkxa?=
 =?utf-8?B?ZVFQRFkrOVBRMGVlYnYwanUzdzUraW93V0FNRHFEOGxrM1A0dmFMd1NENGgz?=
 =?utf-8?B?dlJUUE9tTndtMGQzZ0lUTVpob3Z3OWtBSTlwcGYwalRjMHVxNXRnaGkzeFJi?=
 =?utf-8?B?dnE2V0ZScUpuc2I0d3Y3MmZiTkxONXBZRmdjKzZGa1U5UzN3VDI3dERmaUpn?=
 =?utf-8?B?amxKamVhU0RjTVJ5QzBVRytjZlVvdWREVS9weDRuckEwWHNSK3NTR1FsMHdJ?=
 =?utf-8?B?TWd0WmdSRmFxVzNOWjJ0M3VDWkl3dlNTZXFicHNjVkd0NWhINndpL2N2bWlY?=
 =?utf-8?B?WlF1Qkc1c2FxUUFMS2pvU0ZWdURZaCtRR05DZjZCcmFyQi9icFVPUEJVeC9J?=
 =?utf-8?B?S2VHbmlhR1dNYlp3TTBEbUxkVVlQSFB3WnI0TDFVdXBobjhnNFRPVVhEZ1Jp?=
 =?utf-8?B?Ujc3Qm5xdXAwd05tYnVDaDRpVUl2QlgvZm54RFJlZDU4Wkh0eHUxdE94K2JI?=
 =?utf-8?B?Tndmc3pwZTZJRUhWSEVMNXNPMko3YkE3ZEwya0EyNHVUeVRxUEpXanNOTkd0?=
 =?utf-8?B?eDErZnR5d2tUeE9lTjFFRTk4RFdvRDV1bGtRK2QrNCs5UWhCOUQ5Qk53SFph?=
 =?utf-8?B?K0h1SFZOWlFrczkybWZCYktVUmlNM2sxYWdtemFIa2U2QWRFK3VObHBOMEt4?=
 =?utf-8?B?U29jcWJBOFd1ZTFoSFlWc3IrSzQzYlpNRGV1bjVDaldFZUVtRjE3ZFQwM2d3?=
 =?utf-8?B?WC9sRER5Z3V4N3l4d3RuNkIwVUVNMGFQMDVwS21aOTRHdngybWtBWVBnaEpP?=
 =?utf-8?B?Z0NzZW9Id0g1Ulo2bWMyc0lUb3dNeVB0RG9CRWxXSjVaMkpNZFErekk2MWpm?=
 =?utf-8?B?dDNmYTN4bmgyblFUS3VsMmFRakg0ZnRBcWdvYnlSNS9RcFBjZWYrdEZSWjdG?=
 =?utf-8?B?MVo5ZHFWVzJ3VjlieDRBMUhFb2ZyZlZnaEtmVlAxays0RGpBWFUwbEdzODEz?=
 =?utf-8?B?NnRMU2d1cDRLeGFlalUwMTRWNmhBaWNiYWxnQnhEdnBKQXFUWTRvMWVLL1lB?=
 =?utf-8?B?Y0UrdTRpUjRHT3pEa1k4TWx5bGtXY0x6K3dCOStVYy9Bb3lpczBkVkFzdDF6?=
 =?utf-8?B?ZGNZdjBsVzJEL0luV0tnZ0xjQmw5aEdjU0Y3TW1ZNFhJUDdQTmVJQlRBR0pV?=
 =?utf-8?B?Qis3UWN1YVh0OWh5VXJ0dFpPQmpwSE9tanIrOW10VjNIR1I2RDhBZ203YktK?=
 =?utf-8?B?UnRFUU81NUloS1MrR1drM29nd1BCN0dKcjlmb2RKV1V2bkhMWHJ6NDFZMG5W?=
 =?utf-8?B?TGdxS2VHRlpmVmYxRjFBV001SUQwSC94TFJHb0VSQ2V1VVNxRk5LSUpoRitH?=
 =?utf-8?Q?gHN0M9yIzH84nFZDZnYzdNUdu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2673689-6837-4a6b-5722-08dbb4c89f34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:36.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Log2ECkVRpQL9oxTblsRHIAwlVYaGeYfSp5aZ0uCNLWOKcvh0t+R7VreeLSu4ZRuK05zMWQLyYK+WCVLN48yag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 compatible string which is compatible with i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 2593cc96fcbb..d0db2089cfab 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -26,7 +26,9 @@ properties:
           - const: fsl,imx7ulp-gpio
           - const: fsl,vf610-gpio
       - items:
-          - const: fsl,imx93-gpio
+          - enum:
+              - fsl,imx93-gpio
+              - fsl,imx95-gpio
           - const: fsl,imx8ulp-gpio
 
   reg:

-- 
2.37.1

