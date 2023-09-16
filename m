Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD47A2D37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjIPCAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjIPB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:59:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7311FCC;
        Fri, 15 Sep 2023 18:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE32wp4a9B1HVOhT3QS4hOXI74OOKdSkQHn083Gmt1MW/6bRUtXj7ew7pkdhjjurujlUvX2SJ0ngJLymRS9sHXOmr5BBvYGd5wNVBkjneNFR7HRlTNj7Bhda0iGL5JsGlAx0Noz3OQcitkS6qeokiHClWhyj/ZtwcTsuwQWYALdx4p1UTwshNkleRj+hbncprTXPgakwlsXU+tTaKSyr9dulPsZTaSIu3LD7M8xeshNi3VeVu9yOr80YOvqHlRchoDxC/jCSGoOsgGer5LyMLKIuKBT49spLER1Cvqw0EbbHiXGc76uVUXjRO4+ZD6RRrnptvuw/1x7yfnK9ZUMCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtFZwuxIHhIdKyjQLQMBUQmgC1y9ewWizrNiw6CwZ60=;
 b=TLC+3ZL/V006NhjH3t+kwx4U/cW8uJx03O4ScpYhXUNoZUwvu1y4Cxze01RDMSiUFFKokGUo6vFCzAARa3ZVk4C/ulaA7WhZlSzzJDbuzc1Z/0jf0YLYZqc0KP8xf6L+SSRJTSp6fKPXcS3DpWrU1SZBdk4cUsGQZ81UErYFNZkMzB1n9dU6GOwF5uYgXeuTU4uvdHZwqeKie1zS/nQI7aUZBnLNdnjkCjd5QRZcyYUv0q+3jO+qQALnljqb4WUlxvqmCU6ZWOvbqqydyGiCTjQB368/3PLbRY12z7zQlXpCdj8He+9/Acb9E1NBDQW7Fad1PnQ9pyan8Z/s6wz2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtFZwuxIHhIdKyjQLQMBUQmgC1y9ewWizrNiw6CwZ60=;
 b=HVPZa1LpN48VHXSVDdasIV0tAS08LMJY6WFe+xehM2VReKU0feDNiw0wB8CHUUgPKAZPb6PpNWowUyOE1Bk/gvSQRYB2GwDeYTrX/btdSdwnjznLWi/+SZPST4OjFqS3jwUygOULcaXdNmKUkpBl6top6MDAKDSumyZQNUrNX0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:03:59 +0800
Subject: [PATCH v2 3/6] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-3-40823da788d7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=703;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WC3KgWsJDHtqAAqHProMeslODB+9gXZCZ9FAQz2YKbg=;
 b=AnCaMi4vyr1cbX0sKhIc2LspPi07hlfKC0nuqf4UlPbCYTV5X3UL/TdKDKRuEx+u/FHQzXflm
 ebhWR8ZC7nAA2OaM0693CY8912AFCCw0E8aO5aajSHMh7Xig5SVCTGt
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 42aa63ba-7b87-45f7-d028-08dbb658997d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZjfLJ9vaPSjur6MHwSD4YSZoY6Ujq2G93jRQsZvFu2ElktAe3x5/LL6pUejfb41RQMwk+1VM6i0kKQ/2UQN9cLQ0ut9yPtPipp9B7T68A2JsyYkY0vrP9PA7ex+E0Wc0ViszqlyXa8+iYUXei4Cbh/sfeX2qee6xc63ZWrPpEO/lYifrHZjUjT1zsgrYyB/kLGHcC5xWC3eZpXeXeYAGlTxoNiic3I9Tq0lQ3fZBvWd1XZBpwdA0kXkZmshi/7nxMdYZp2P+iEdoX++BY1+IYwRs0z1bvyAvaoVvsRychfP84ksHvhsx7JizMDN+2Vy9D+kAajAVjzaFNJ9VAFB4ZI05mADvy+phTZsjW1da/HAfH7aQsFgBpzJudP8VUtpLfhcfP0w8StqJEmpzCz6HeQsCeJkw7E6iew1f2J/JMS4xcjzu9j8sYleajb36VnSH/O800pC/tY/iDXdTHKZHccqRIdRnvx5T8OJxWDlm5/bCM5vHR0T59E86OV512Z9cbMK4pYY/pBZTBM+m4gzploRvMxhQkxcXG0RcR7LzRzulTGpoQpRxXbBoVdJOpEepPnRKAuftKSi+g77KF5hBK7dUhsu1o6RylBnHSER+NZtnx3UoLga/qEIEvgEkVGIN7AGQAVWbH5pQwGGNcpa3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(2906002)(86362001)(4744005)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBNcUtKN3ZVdDI4WHJiS0RvbVJwekJSNlhaQk11L1hxRXB4L3EzRkFtVDhO?=
 =?utf-8?B?RzF5UDhQODMvN044aUpQcGtpTXVLRXdGdTk0MFZ3S2EzSExXVjc0T01FRlhs?=
 =?utf-8?B?TUVRampGSVV5L2RUd1pKcVY2clFzWkY2L29sdVFYSkp5bFcyZEszbGFueXJp?=
 =?utf-8?B?TmN4eVA1TGs5bmFIMjFvcEFYVEF2SkJQeWFVSjA3KzBqS0NjWkZJd3IreHZY?=
 =?utf-8?B?NUM4QjJkTyt1ZjgrT1FDLzNMYWhFdVM3M3B5cm0wSTZWcisxMzZ5WGFaOVJG?=
 =?utf-8?B?Y3FPNS9WcEVLU2xTWW95MHl6QmJoOXJRUjdPa0Y3THRNN0VUOFBpSGZJYjN6?=
 =?utf-8?B?YjNJQ2ZKanpza0haUWhheEhTb3ZRQjZGakZmeFZZUGZsandHRUR0Z1NvaTlu?=
 =?utf-8?B?Vmt1YnFHaUp3Tk8zVkx0a1BBQnFzR2JUdXhGazR4KzBZSFBSQTNqZTZjeVdq?=
 =?utf-8?B?dmVFNnFQTmxnYjBNS215YjM2SGc1S3NOME1JODQxK2Q2L2Y0Q1VWdEF4dkFT?=
 =?utf-8?B?Q3huNVVHQno5T0dyc3JRV29pbVdIRWx5bDUydnJhd0JzMER0L0dOaUFvWXNo?=
 =?utf-8?B?cWpDbDdVekh1OU9OZUowK3doa2lCdzV1MDhBWnB5Um1qS0Rib0ZFVnJLcmRF?=
 =?utf-8?B?ODFhVUNuQkl4MTd4Y3dycnpMcExRa2NhbWh3RjhqZ09LMXpicDJ2cWpHQXpD?=
 =?utf-8?B?djErREQwZUx4ZWpZajJXNFluNHc3YjVWcWlFelRjRXR0Sm1PMEVVczBRbi9Q?=
 =?utf-8?B?YlZQanpKa3gxMjdMTW92U2gzQ0cxOFFDb1FYQm9pZkF2Q2ZUbzduUmlITHpu?=
 =?utf-8?B?V29KZXdwUFV0NGVlOWNEbS9ERi9rc3BBYkV5Y3doT1pONEYvektnK0VsK1JM?=
 =?utf-8?B?cDVKU1duMFR3RXBjZFV1NXBSbUo3Q1NMd3RXakUxVDkveW1rcndJRE53R2Vs?=
 =?utf-8?B?cHp2bXZBNUpaTkN5eEFpRGl6czAzMmQxZm54anJpdzdoNW5BaFRWUVRvZXJS?=
 =?utf-8?B?R0s4UmtORW96T2R1VGplYmtkYjcvdVVKUzVkcitIeWY5Nmc4UDRTRncvT3Aw?=
 =?utf-8?B?TzZ0ZzBZY2tocG1XNmZocHhuUHNydGN3RjM2SEVUOEpYaktVM1FLSWtSZ29z?=
 =?utf-8?B?SkdXWjFhbE9XZ3Qva3lLaWI3N0xRTU5IaHd1UkorOWdERDBRUGxVd2x2STRS?=
 =?utf-8?B?NkF6RUkyekdPRmdMbktIR0IyeHdKS3VjUm9YZkRqMXJ0TVJrUkN1NkNzQjB5?=
 =?utf-8?B?SCtEays3NHY0azZvYVNJOVNrUzVieFByalVpQWpxVzByL25ad1o4U3djNCtt?=
 =?utf-8?B?dk12QW9kdUtOVnVhRmZ5T3BYTlBpNVQyMHFwRzYrMGd4cWJ2YXU0ck83WTZQ?=
 =?utf-8?B?RDJrSUF2dEVqQVB5dlhNUjkxMGdMOTVvZHZRbmZiSjg0NHdXc0JQYXZ2OWhK?=
 =?utf-8?B?ZXcyWlZJUmZVc0t2a0JEMmpkR0N4NW9SRGd3UDBQSmM1bTkwU1BPdjJpUUNS?=
 =?utf-8?B?bndDVWFoMzk0ODB2SnJxK2FhWVBNNTJIR3RYZ29lS0ZEWG4vN3ZDTGhNOVY3?=
 =?utf-8?B?Y2JDbWM3TGRGME91T05YdHc2RE5aZHZIdW1jenlPTWxmNTlUVmhNRE4rMkky?=
 =?utf-8?B?cDVxMXJJREVEQXFQY3FmYTVRZ1lROGlMTi9GZzdONnRKLzZweTJlM3lGOFVF?=
 =?utf-8?B?Qzg5Z1ZvODE2L1BKSGYvdndlZ1VSbE85bWN5V0JQbTdwcUVKOE4wZlpYbWRa?=
 =?utf-8?B?eFk5WmIwbDAwWWdOSnY1TEdWRGJ0VUU5bWRkVGpqcHppWXhTRFBNVnRPRzcx?=
 =?utf-8?B?dUFOa1lIaHdlMlgzdlBXNmFOcDhJQnZMRzI1K1lBVlphSFhaTjJOWlB0Smly?=
 =?utf-8?B?TndJU2RsbXkwUzNocGRtQ3J5SGtoY1RhV0ZjaGhPWStvVnRXZXdDK1ducEhL?=
 =?utf-8?B?eExFSXJIR1BBMzN3aE4rTFFPbzlzWFVUOUNXTUsvdUhYZmg4d1pOZnZTTkhw?=
 =?utf-8?B?RjlGVVE3Y3Y4RWZ5MnlPSmN0S04rV2c1Mm9QWUxRYi8xY3o3TlpVWm9mdU9t?=
 =?utf-8?B?Z0dHaEZGNUM3RHpSRkk5d0lzUURSTnI0ZUREbUtWK0hBMjgzOUZMSndET3pS?=
 =?utf-8?Q?Vq+wnWDawGsyW2J/KSuWYIsR3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42aa63ba-7b87-45f7-d028-08dbb658997d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:45.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvo45n7VYSHacj4lR1ewKN8kaBTiGh9MyYd8i6RmrqbGqwGYJ0Q8fiJAd4Znot9R+svA6YXWo1durXSaQoL9mQ==
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

Add i.MX95 compatible string which is compatible with i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 8c1f87a1a393..a7b9e57b6d57 100644
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

