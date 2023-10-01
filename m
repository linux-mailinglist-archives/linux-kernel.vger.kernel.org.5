Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8587B4629
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjJAIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874DA9C;
        Sun,  1 Oct 2023 01:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAF4aYENXwKVepgqmlI0bgrswqCnrEEdJbIvWmfL6GIlYpRTO6qKr2hua80YnLtYxw1xyAR5gHDsZ3JxNQcAY0mwfRy6w7j6i0WDAvlj0tm/jXaUlnHc4Yi55V4KIqcCyh9UfbvT6i/CrgJYg0XdzkQEsOSevDoLZQNeZCeCfuhuwXRaUpmZZ52jzPmqf0q6hrVhf4fbAtRUXF56xx4XtBUpY5Z3o8xfYDyA4O7Un6Y0sQW5yvWEx5dnDvRh7TOA2nTKEyHVl6d202rZY8FTpFNqLc75WH2VSdzpw1baXAFdiyiDlai11KqDb58uP1pkftkrLX3nXkrZLy7zDi2WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jxHYUzZtuaaebm1QfLuNWuRl45YzujXAsdzp8+ljcQ=;
 b=eOD4B/hyUrSpaz9/8VJJ+EGrF1qpqXfboTjUnda7jxnFMsZCPZjcjx2qqrmHiKydI0OFnlF/uvjCfw6MNOEp8oTtZLzYsA4QJkWJEXf9Wqityrd57WghOMhsnzAHzSh1arKpeEjjCs4TAS0S09gUwF2nH+gMGErVTKpOZIJAJD4oQ2JB5nELBFz579Ll1zwH5/hszW6SeBEVSHDuH2AQr8sua1+eWx0UWW6fz5CZL00ZW5IdFCT5wOasacCH0mG1E6fGjrdp/njhEWA5ElHZ4AgvQ8pW/FoOtGwECO3zjTyCMcuOz0nhGh3AA64fx7nb7MaKugBX/Q3dN0JRXFGhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jxHYUzZtuaaebm1QfLuNWuRl45YzujXAsdzp8+ljcQ=;
 b=AN/7M4Rarh+srltlay7K9Qqk1hDAcCdHz7CAu7hf/BjJO9Xd8GCLbY4uoRmFMTJ1dXhgf+F2iHB9+GL8a6dIZz2+heyf3dEpx8O4a7a2ZY+p9Cd7oX8OHeGRoNmRVJE+6+mZdkJbYM7XmjO2/KyOHrlSN3aqXo77QFOlZU5abC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:23:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:52 +0800
Subject: [PATCH v5 1/7] dt-bindings: gpio: vf610: update gpio-ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-1-8d873a8f224a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=1028;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=B20wdZZiMrCGWWYq9WAZCQ3eK9afxBE4kLGOAueWbZ8=;
 b=SoPF3evwOEberFCKl2K3qkHd9I8aF7FS4vbLpax7w5qR7XCiThb5l3g4z76g5zis4u8Y6sb57
 /FGmzZtgpguBz6SnQr5rir7UxWCbT4WBQR1FUd/PmayuQ0sM1oHn9UH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8194ad-33ba-4e6d-b5dc-08dbc257ad3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfmvSAYgeg8Wa7byBy0MX3flhcw8pAPySYx780VoeTv6bcgKdWW41v3WGY+XUTOwGzB4P8jy6bkXvJTEeDTpNKNDTYFeujer72gkEhCDvj17ifqOHVER/Enwbt3c+AfJ3KejgAswHdtoB5T+zhK8qTfcUik41Sm/eS1CYClTTYiUqsYIa7Egr7l1bccVYfIhDGh81lAsqRi3f0W/D/oIInlAYrbISNXNg3n46lkT20qPTvL0Qulk1f0cfJV55qTD3GXU2Mwu7VJN1Um5RIl3MLjITJcvKNShFUIbnIIuArJxm3QSffRwisNMXZY3kocI7a4UZNuunwskEp/MXmTnxvEbgx/3mGLbLNrOAy5zqQ7dezA/gxGY+NjKSKNGuJzIXoacDYUfTnPcDo0qbUFtTnJ49O/ic4qcaWpnUUUnBF0JVxdI33fHmqxaZtMueWYhCvd58/lLxtThqHvr/R4uUolakLdxKSwHIRy6BjosBPS/IW/U37mOoBSZFGIq26NL83Gytw7yj+V6rJL8R56Y5Ibs2neEWzrgKKj/K/eTXyLNpKXpLRvdPcOk7PnOo1E/Tuj9Tmy9UYQJ8bPfNJYjFm4C6HoNEnzrhuby6roy4hLa7SNwD7WVKEbQTZTqiYuoDEg3bubE7/o5tjV3yQ3hsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(15650500001)(41300700001)(316002)(26005)(2906002)(110136005)(7416002)(8676002)(4744005)(5660300002)(66556008)(66476007)(66946007)(8936002)(4326008)(478600001)(54906003)(6666004)(6486002)(52116002)(6506007)(9686003)(6512007)(36756003)(86362001)(83380400001)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVN5VjU1N3hVTWJYdi9RdktlOHJuQ0RkUHVSMVNtSUoyYnFlL2ZJZUkyWDU0?=
 =?utf-8?B?b01sdmE2alBFdVZtWW5Pb3dsbCtxSEpaRWFSQy82ZFl4TkxtNWswSE1kbHAw?=
 =?utf-8?B?cVhRQ09JMm1oU2tFYkpSV2d0L3N6bHpoNnViSHhRd3BiYjRQL3ZGN2syL2Yy?=
 =?utf-8?B?YTIxUVd2NXFoMVJxcTZqdlRkY1gvUlhyaXJiMUtSY2JXK0NkaXJ6eDM5TnFZ?=
 =?utf-8?B?LzYwQXJlTnNHSHRzSlVKc1EzcmVKSHp5NFd1N20yZjN5R0plbVhESmVvTkpa?=
 =?utf-8?B?Mm9oYXRTQkN1WUE0QTNHWXdSS3ptem9xYzdHVUU1QmdHQWdRT1RVTm9LczBo?=
 =?utf-8?B?elNUall1UHNZWkdPQ01SeWE0K2NVcWptSzRGTVBGWVE3c0dnWHA3YzlMRUFa?=
 =?utf-8?B?czRmRmFrYUFPMFZQenBrc2NlUFk5YkNVR3FsTVd2dmpWSHY4bHlZeFltK0R3?=
 =?utf-8?B?NEVsTHovem90ZjVibXd4M0lHSklGNmFNU1BrNUlQU3hZOTRmUFNvV2ZsME51?=
 =?utf-8?B?aDlyazRRNTlJbkRGZy9IWWdTQ2lOQ21sV1JrREJianFManFJVit3eTJrR21K?=
 =?utf-8?B?Nk1TekJlZzFQWWVzTEdsejhlVDVWeWc0T0hpYU0wazRCbytLVjA0T3ZrWjli?=
 =?utf-8?B?WUZ6Wk4zM3dsaDNSRDNYSzdxNmZYMHcvYmJuMEZ6WEszajZ6czB4eGlFTWcv?=
 =?utf-8?B?Y2lMdXkwMVV4VVo3VjNYeWVvUE1hYkhTWStZNHpER0pjNnlBZ3N2QjlnVlhp?=
 =?utf-8?B?TmE2NC9sbGhvaUp6Ym1KYTZodHIrb0RZditMeE5sV2VjTXk1ZXo2ZmhPMUls?=
 =?utf-8?B?M1FEVGJ2YTB1eGdwSkF3OVpqMnJUZGlJZlJ3ZVBMMVF1Vk5wb0dxd25uakxi?=
 =?utf-8?B?UHoxMzJNSTA2YVBTa0E0NkZORjVUcjd6R25DaVo0Rno2TStaNWl6MW9EejIv?=
 =?utf-8?B?OHNvNUIwUk54OXByZlgzN05NT3BYaStYN0cyZytSdlR6R2xtc0w1Vy9xTmZX?=
 =?utf-8?B?WnRmOEVVK0VCNG1XS0V5MURuaURZV2Fqa0hDSDlhZ0xNNUZGWllLUi9QbzJO?=
 =?utf-8?B?SkM4UnI2KzlIeGJ0WUI3LzA4eS9HejNRVnlISkthM3JGV0VUYlA3RlRRQm9w?=
 =?utf-8?B?UVNZQ2YxVGdWZGdhRFNxaWNhOWpUc21EMmFYSnNlU0NuWUNsYUgwRlpEc0xP?=
 =?utf-8?B?SjNSU3hqMDJNeUszaXdvN2lIcXlCczJMOHZENU1GMUFXUHNSWmJObnQ0ZXgx?=
 =?utf-8?B?RkJtY29RNkxYVHdFMllYblp3YUQvRjEvU2wvakZiUzhxUG1DY3ZMUWg3Rkoy?=
 =?utf-8?B?cS9zZnVubzZXR2QxUEI0KzFNaG5kMjZHMUtMTTV2SEVldEN0VTZEMThZSnZP?=
 =?utf-8?B?ZUYyQkowSHZrYU9qZjBKUURkQnJrdFJLRmFGbVFPWUkyUWJEcVRTMlZjS1dV?=
 =?utf-8?B?aG1GWmlXMkV1c3FpMGxWbmh6akpDSGlLQjZEMHBYNDl6VVo4dkZtSEhLaU01?=
 =?utf-8?B?UTF5MFNYaTBoTWgxVU12NXdCSkRoU0ZlRjN4WlF3aHJpS0lQa1RQY2JzOFVh?=
 =?utf-8?B?Mlo3TVlWRk5EamZXSGRBWmZUelppNG5LN1lIRjE5QktURUo5bndxUjVCUXVY?=
 =?utf-8?B?NW41RnJveTB2VTlyM1FneVFtLzQwa1lhbGxUR2pjeW5aZVcxVFhycUNEZ3VN?=
 =?utf-8?B?UWNEOW5SSnd4Tk0zOXQ3ZVZaTGJkWVRQeEtzVTZ3TmRqdm9QT2VFcUQ0WVNh?=
 =?utf-8?B?Y1RyRitlSmlWREZMUHQ2WnJqekZkL1BNYXhWNWRuVFl3eGpzUEwrZU82MWZH?=
 =?utf-8?B?dTI0VG9XV0g1ZXZkYkl3T0R4SWpCemFZUXpLYnlmbER4QU83ZnNLRXNENHg4?=
 =?utf-8?B?L3lYZWcwaHhxVjVqZEhlN29ET0NkZTlNMVR1ZUtKckhwOEtBR3M2S3BPcXpY?=
 =?utf-8?B?eTFXMTFWTXNrVUJEOEduQjdmWlFobUxTNlZWRDVtZUpuUWxQYVAyZTFwb0dV?=
 =?utf-8?B?enJjT29vRERqeWhFR1ZFLzdQM2kzK0NlRGJMZ1E5cjZ2d1pDUE1YZFhVSG5z?=
 =?utf-8?B?empTcTlGWjA5eGlUbTdRUlY4Ny9GWkczS0FhMG1LeHJRR2M1VFlIWnFSUmlG?=
 =?utf-8?Q?PJUnfJLssZFbCJU903blYaZV4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8194ad-33ba-4e6d-b5dc-08dbc257ad3a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:22.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0afXEqHbskrgEcTMhdlmQHYcRH/wWsW6e73qscrlJ37rNRt0JbjR2Yj/WdB/JQquZKZBVEP7fY97KmPol2Lgug==
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

i.MX93 supports four gpio-ranges at max. To fix below issue:
"gpio@43820080: gpio-ranges: [[30, 0, 84, 8], [30, 8, 66, 18],
 [30, 26, 34, 2], [30, 28, 0, 4]] is too long"

 Update the gpio-ranges property

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

