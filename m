Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57207A2D35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjIPCAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjIPB7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:59:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1C189;
        Fri, 15 Sep 2023 18:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5UyS7XpMnIhtRSDfWJ0deSMdtkSdoqB3D46ZFspaQ7PAKGePwHapn6oAg0WugRJnCdLhZTkkyPguyYl011ILlhEfba6+uCUkxzOOM3EsCdq/hAgQg5TI22SYI/B0pAlK/l2oB4yCAx+7YD+Pg/mZNIhVnDzQv+k/nkJ3X6jBOk2dkE9XrmyfYfIEoby74usc1pc9u1oKMESc5EHjBbHWz1UjhNMC4Irw0L7wO26IAeAgNS4vcMElkAyuW8csku4+D1mODIIIPeinr1g/QR32298TdEHHTN3+1W6KyCk+CW/z+DczQX6IQD8Xa3ZIFj18N1dF/pASYIv7tLm2DszLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OredLwUuII1QxcykR9InI5p4XXzMwosl9AXXmPiYOEo=;
 b=cNEpQY5v4UlpWzuyHOxq+U5cL835FIJSaQQyAE3Myx+lC9p7rYc+pdTAsYfDFlF+Li2s+L3kyT8NvhTpiDhS1z56R48hVu2lkBIj8O6yREfyMdtC4LKmQA39cmWokSzbk8b7/aPVqLo9fvNtc7NKgaah6Q/8Tc3SOcK71y3iMZBheYlqDiXIKUV0ZVxFmlzpySzB+1TM5gD1gs0jluyTw5UVMvo8afn2xWy5DIfeQp0snsLjBvpiN3ln11Su6A0SKZFArpzUaCzhJ1vYBfT/ZNMV3n0WlQTt9BMuvYX1HokzempHynaqyTQJQPsRpuHa+X19LvZdq8LljaweT+D9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OredLwUuII1QxcykR9InI5p4XXzMwosl9AXXmPiYOEo=;
 b=lIsLlLbZm+33gkSyG/ctXGphgOEh0CI2Wmq20BFC97xXxNJcSIGTEeKrI47YaGKrWDLrtj2wiupEByvEIB+wW+YDFQzTOIlh8lSmbCWOUAc6kmxZeYE4YVf3CmyFOiTGCtMNcx5SMeYg6SpweU2UtydGpNQESYfQuWZpuCE/kNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:03:57 +0800
Subject: [PATCH v2 1/6] dt-bindings: gpio: vf610: update gpio-ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-1-40823da788d7@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
In-Reply-To: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=860;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=cZI4+oKhuZAuqO71bHYo1FSS0Vk0Rjk+fgSV3uoIUNI=;
 b=jtPOBlK3ytaUyEbA299O0QLz2LCVGCmMzBLlLgUElAV16wlV1M4gu6p3AR0/hkv/If8cstj/w
 JB4rXO3M59UBz9vVX4FJAOSTczb7ewti67xbXPVTgTZxdCAjPMoKCdl
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: df254964-9eb0-4a76-b187-08dbb658937e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5ifTqVwJRFxNaUpRSRx/YNOfO7Vm2+ww4LSl8qadYoAMgryFlTMMNgkA5R6qktj//jIDkpOfB6jyeNM+SOsGb79DVLjXuKNiHPSVDi6mj0nylGep3ltwDG2YBULwjHWspMaX3nFM68H5zkz1465FEPtALb9xQhGaY0g8+wyAG2AeY0ohSTuleuNtq9BwYvdniSc61YhE3h9EZiF6eguuZ9zgD0Ix0BaJI3nkfPkcpmRXyoCthTilEANn/bcQttbYHk/lSQYRQTsMZJLewiHdT/dLFU4y1XDEBg4FeyYSymNyB0h4nYInxz+8vohriBg14k2AkeGPId2NhYjtGf5sSHKK90WBezhVDfPC0iUo6OEpmcnMYAs4tX3CezB+Ojtjy9ExsZn99l/csD8tvpvz/zeyu4N6X0OwZ6353FVfpsfB8hHvkIRNJqYsUiPNmpfCKvyswSJn1Dj0MhzPr2x5ISN2qzoxmG4GGDXM7DN+bvo2eiVPWtjF5B/wnLnK4UOjgcALCRN4SvIN9yxsknijF4+Vlz1rbiGFSz2ahn2jMjchkc4KJ5/uBhjFqXkUhtts7LFxqJ3srcCqpbFmCYM5rcanXslNwOT4QrX0VWojU8B3mZwO21cYyiXfoX58qOYIerlu65w3WJt00jE9zfKnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(83380400001)(15650500001)(2906002)(86362001)(4744005)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9VNlV4S3Y1THhLT2djcmFHQXM0aXNWOGJURXlVbnhHeEdmWGt2SXVtZTNM?=
 =?utf-8?B?MjlNY0M3eDRYN2VBNG5EMDYwZllUaE1sU1VZaW92bU44NUsrL0ZWOFNMbzhE?=
 =?utf-8?B?RnErVmVWSmovaHNhektaaURwRGtMYUx3eTFYRzhuWHhwSHJGMzkzMmYvbXdi?=
 =?utf-8?B?Vnd2WnJZYmh1MFhrUmNtVkdyMWVWcEFQUG5XT0dHRnZ6STU2bndRN1J1aWJz?=
 =?utf-8?B?dTFVS1BWdWV3emwrSlZZQ2t5QnovdzBlUlN4T0svM0JnMDg0bHJBYWhLQmE4?=
 =?utf-8?B?WEgyYzF0Y3QvaU93Wlp2eHRCYzJCa3hhOEM0WjhhajRIOFUvYjhEdkZiOEZo?=
 =?utf-8?B?NFV4dlVYazcxcUdIK242N0RPNE01OTdXNU8va0xrZytua2kwZFpTSmNXWkt0?=
 =?utf-8?B?SC9LVGpFU3dFU3dTelAvdXdTRW0yakx3Ui9lOEJjRnFKRzVKdENPNGVjZGhq?=
 =?utf-8?B?ckcybkFHZWVEZHpqRmU2MkRjeDR4MmU0ZVZZVnNKOWdWSTI1LzR5VkJxZHQy?=
 =?utf-8?B?TVFydDBVQTMzQ2w0aThCTHVBdmxpZDdmV1BFZjZXbnVZenI5ODZmbFdHVmRk?=
 =?utf-8?B?eVJLWW1kaXl2SXUvbnhWY0dqc0UzekpaekFRSThkd0tRZXk3THZlYVgxK1Ru?=
 =?utf-8?B?a1VVM3grRE4rcjBJWUhFcFZzQWxEV3ZiUk45UHZHYUtWTS96YUNJb2t2SFYv?=
 =?utf-8?B?aGRxSS8wZWRxZ21neFA2cktiS3NieENpS1BJNHluZDRSS0pKcUlMMVhqUWsz?=
 =?utf-8?B?bFZDZFYyY1FBZkMvb05uSWROMjhLdk5Dd3VYMGxoUWxxbVJEaC85QXFTd0hS?=
 =?utf-8?B?akxQeElaejV6RVVBZ2xXZmFYOHJnWjdETk9ha2RwWjhib1cxYkdFdU8ycDdE?=
 =?utf-8?B?a01oUUtDc2FIcTFJcGdDOFBCY3J3eS9YaHJ3Qng5cUxzSTBMbHJKczlwdldm?=
 =?utf-8?B?cDYzcUF4WkNmdlpCN2dZeHhiSEFyRjQyeERzY0FNQWdCNjhIb1FOYWtLK0xp?=
 =?utf-8?B?NHJ1Yisxa05kRkJwM081elVpN2RtS0trVzdZSURNZml4UDQ5TnNBd3dEY0FU?=
 =?utf-8?B?Vm9nbHg0cDNMRjEycmw3amEyc1FrU1hFeHM1cFNuYlRlQUdkcndCUW9pU1V0?=
 =?utf-8?B?L2FaS29qTU80eVFDNFp3eWNuUHo5TTVBUnUyMDcxRDJPNGpVaVdyWFgzUVNj?=
 =?utf-8?B?eXZWYUpNM1d4UzllY2YxVnZaQW9CYjZaNmZHVHUxUFBVN1JZWk41SmlDaHRZ?=
 =?utf-8?B?L09LQXdJeVNpblV3VXREbTR5OWw5NnB5WFB6Mk42SEJMeHBqV2dnUXByN1pn?=
 =?utf-8?B?SEJING16WFEyMlZYdWtOZnVQamZkRGhYbG9vdzd2VkVoSk9wMGVBRXlxamJC?=
 =?utf-8?B?TVFiMUt3dWkzVFUvSjZqWWZ2aGZnMmhVamdCR3FFS1I4dEZmZnpNZFI0MXNl?=
 =?utf-8?B?UDdyVTRwME5tWVp6eWk4RFJCbDRaNGQ4MmtoZ3U4NkRmQk9FakdYY2U4L2Y2?=
 =?utf-8?B?WTVSWVJLTDVkNFgxQStMd3Y1UisrWVhyMCtQZDJPM09NTzVLcjlzZFRBS3Bi?=
 =?utf-8?B?S3NuWmNEbmJwNk9CQkhOdWhkWkw5VUZSTjhteUZ2Skh1WnZLY1AyN3dYekpW?=
 =?utf-8?B?cnVRbUYxNzVUMXRSR2gyVkw3OGpQM0cvaGZ0NVpBbFZJQ2ZIZWZzejhIZ21E?=
 =?utf-8?B?QWE1Y2cyZEkyNGdnMzJrVkVXTEdOSWhwUCtTRzVhUERWTWRYd0xveTdjUWJp?=
 =?utf-8?B?Tk5tamFHOTA2cVYwWnNPWGdPTUg4bGRsY0ZNK2ZEOTZyMHhEcExKWXNFTVl3?=
 =?utf-8?B?YzRzenJQUDhNejB4UXpVRE9jWmdTTDJVcVFRbnhzSGh4d3VVc29TZ3RMSHpo?=
 =?utf-8?B?VFo4dVVYY3p6c0NNblBnMkVzY2RTRnV6dkRtYm0xaVE5a0FscHNVZEpZYzdC?=
 =?utf-8?B?MzcyNUN1MmlkVkJLTUNTcG1PeVNqWDk2Q3h6M2FqVGtyeEd0eCtzdDBMSUxz?=
 =?utf-8?B?V3JXZDlCRFdXUTJWQkJMUXhXZEh5bEJkK2JvK0t0UGltMmt4UmhnSEY1Sm1s?=
 =?utf-8?B?MS9RQkpoZmxlRW9DSnBJbVJ6MjVqY0VyNmJHOVY5Qjl1RW9MNVZlNmdWcnpM?=
 =?utf-8?Q?oq2cOzovThITrgi1aR1KgaZvd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df254964-9eb0-4a76-b187-08dbb658937e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:35.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erfeOKK66E8u1db6cIk9/3diZIWt5QjN+uKnixnXsa82Pk+Kmz5VWeFNnePi+0k06cd/RcaAkSI4/8NPJXim7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
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

