Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA427A4442
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbjIRIOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbjIRIOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:14:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF7191;
        Mon, 18 Sep 2023 01:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvoeQGCkuOeong3JG9KMJwAXINthyyg8rBexaAO+wLuANsezhh/VPwQGOZbftlXuzae0EyD4yx+DiF+eOXy+uWuhKHCWGky9gQMOEwdCg831ZlILgD3OzrWeC0HElF8b2oawD8jM2rteH2e28+a2fd/LndzLmrgkI0B8qXuRH3xq/O0BCmLJUoQwMIiWusw4SQH+5zM6cTk3/+MO8deFx5IjEc38DQSrZMeMTJTV5HEcxgjebxW7q7ax9CwCjIRp+MLkxtW9LiB5atfoL65+YQQyX9qkSuBr+aBXaql1vqWJTeuPBGVlSEP9cBHqJ4jexNrOQl32dENnQi8WuMiKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm+o1IvBBi6qd6oTPQe1raZgW+ZkPhPwH0d7cyrLe6Y=;
 b=PuANLrLsJBRCDBr1RFnFObz4YsyCHBHtDwbnkWQwJMu0eiEasizx7GHVyHIsIhtgSZadzErhmI7RrgjPnu4iOMkqtLiC++OaBbR+zhjaV1RjRz1mkjufEY+Dj8hJXM80nzKIxttvtAM8QagwOpdqOQHAWMBU+sU8yM6wqV+/lhUYNsKiO5QCqmcy8suCGPW+6Yc9pK/JZAAOvLPf8/4pfLhoyf3U03qL8cWINpGSDp9B7+d0Ssc5dEeOyy98nasp6T6sGHJrncA1DjvBTQRDNh8zPgM532I7Wy/3N2/fjCsteYQVcavFaI/a4LMjxUgkdbrhDSU0bdUa31m6dMFp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm+o1IvBBi6qd6oTPQe1raZgW+ZkPhPwH0d7cyrLe6Y=;
 b=g7VZj573VkH1T+V4d5a+Q/ElzBVUHRykiryclEk9goTi0Qk6RoABOA+y68iYn0zlRSGkGGgN5Yga/GSvyMwUa8UoZk1Y57vM+EcA39fjX8ShWeXVVugXqcKQ71ERLJ8vy0KoEl6y1o6iyR4V7OvsncOYrurrfirUXbOwS4G3Cho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:11:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:11:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 18 Sep 2023 16:16:06 +0800
Subject: [PATCH v3 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-vf610-gpio-v3-2-ada82a17adc5@nxp.com>
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
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695024993; l=2533;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jRTdkgbDeDxjONBLC+VbNYyEaH9i/EzkpCPJbf7+S50=;
 b=j2ZfI4UWbt3bbwJQXuegM08823tKbn57xYDK1ANMw6k3MFMjyKaRS60wc+qMQbxzXjQ7WwgxN
 vHRF36R840HDxEC54imyQll03RZhBrW3m+2mKwXqaozujGr4Qj5+1o6
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 60433705-e794-48f2-2139-08dbb81eeb24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayuIzBNeiTcxTA8ayvWg3+bHkGyCwoh3/b8qqvSiZeiZCh0JxA+FN9N2ZFgVzGCE7x82lbCapOgOzLJOu0f/gK+j3QVqT2goi3OLapg/efDHJAUnrAVWIp9vYhG5+EqoxWqp6bmrHJZ15T71su7HePYbP1dEnuMIlh5IBqldKojT/I2cmJtuPqvXJBlvGRvADN+OG/EBIRI5KetEKwMveU9JaXi/yFbl1KTKrcg0cIw0r3gQ6cZwWEC/pdmMnT5qaE913hYhJ9wqX6oXo+Og7Ga7aPscCx6v9tWfVm5KvIERgQjJSSykWaF1MIcUivXjYa0JnbS8XYnTIkGji99FF0CML5qypOTZERw1J1kaSwgO0J4sxJjpplkaGQ/WPI2Q/XZIIM0Y+ha+n7Qd+iXaQF3oqmKE2XQRhg597PpifDFQexnRYI8FQFFNxp6YZommqA11A6v53sLW8AnraAmHCC4st1Lj3kDEiC8ItAdU3nvjSBPFsLXhGvASczNoA0Vrf67WkW7/dk3WkXXCNHRDF62GmGS6HIWwgST9bO38FnOgDKS69EDhH5Pq2CJwhT08YJ0jdOLelfNc6H4OwY6juaBDo0YyvlTHggXiySz/+hlsM26PFvscGdidHw2VwLvNkSyPDiANx2TRSaQOXNMjbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(8936002)(8676002)(4326008)(921005)(86362001)(26005)(38100700002)(7416002)(38350700002)(5660300002)(66556008)(66946007)(66476007)(83380400001)(110136005)(2906002)(316002)(6512007)(9686003)(41300700001)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBHcE14b2pIU1ZUQyt1NVlEM3pIYUhPZDVFdHc3aEFpODVaT1Q0N1VzUnl4?=
 =?utf-8?B?MFB2MGU0LytVZGdQVm9mUEpmN3dIMTlKZ2VsZ0VzL0R4Y0tSbkpVWDlPVUJz?=
 =?utf-8?B?c3JjY0NBS0FLejlQc014MHUrOEMrbXFJT01UVVUyRk1tL0JkUmFoZE41bElF?=
 =?utf-8?B?TC90ekpEN1VtMG9qMFJxNkpURHBleGxXOFU3b0NCRDdqcDFMb3NaS2c1M0lp?=
 =?utf-8?B?bjBZczhnTElnb0l1dVRGdWdsVGNaRGk0QnFjQlhhV25vK2o1OXBMN2FENWpx?=
 =?utf-8?B?dkVWd1dsd1VMSjZqQnlnUjVRbWhkNmJMdis0bXhVMFdaWEVHeU5adi9aVmxL?=
 =?utf-8?B?eEtsTVhmcUsxZ1hzOGhROU5pMklUV0wvcWZBaGFpMnpielVrd29uSVlaSUxt?=
 =?utf-8?B?eWpabXhreEtlTTVYWlBEaFJzcHpxYURtQ0x6M0o2K2dqRmxHM3FqQ21JOXBM?=
 =?utf-8?B?Z2d5U2JDbnJtRTdzK1Nyem12NnU3c3E1ME1Gc2Q1dzd5eWdXTXQwZHpXZ3Vy?=
 =?utf-8?B?MmlQa01RM3hTWllPN2hYVHM3RVRxN2JzTi82WHd3TDhTMU0yZ1Fucms0emNu?=
 =?utf-8?B?K2FETDVNeGZiUVRaMFBHTElLaVJTQkRPdXg4Sk1DTzUwcW5uVFlwcitYbk0w?=
 =?utf-8?B?Tk1PdVU4U0pYVXI3ZVlPYmx0S2VSc29IL0pyOHBhUlRhOFdKWnpvVDNNd2t1?=
 =?utf-8?B?Z1cxWUxsWFcrMjFwZjZKdG9TSVNCaVRyQWxGcVkyVTYwR2VWYmR0anl5K1kv?=
 =?utf-8?B?TWlOMndHWjZXdDF6Z0lWNlE1SXczRnJBM1R2eXV3Q1NoSHV2VGl5aDdINnFN?=
 =?utf-8?B?a2FJeFZkcVRtaWVYbDVQWkdCK2krMG9zTVVicS83M1NOZWZYQUNRRUxibWVk?=
 =?utf-8?B?V3dxOEtIZzJud2NvSityWkhSaWwzTC95M0owSkJDeFZzeU05RG92eVRDSFlL?=
 =?utf-8?B?Y2dGY3ErZVcxUkNoeGZSb3hmMzZVbU5PUTVlemIweGpJdUFNOE5VSWtxdkF4?=
 =?utf-8?B?clh5RE4xcm5FMnN1RjBMT3VPMFQ4Vno1RWVENk1ONmhaMmJDbzVjNUZQeGt5?=
 =?utf-8?B?bmU2NWo4MlNoZ3dDQXNnT2dxN0tXTjhhUW1UV1o1MUROeEFqNEdIemI5TlVV?=
 =?utf-8?B?cDArdzV6SmY2ckNIeWNzNjRaWXhJZ2xmNk9BYWllNjJ2Z3BTT05ZUnU3OENW?=
 =?utf-8?B?SXZvamZRV3NCREVXdFdtRlI1cTBOTkorT1REMzVvOC9sVWo3VmlSWWc3WE5L?=
 =?utf-8?B?U2EyMXRoZXNXWU1MYnc0NmhNNm5ZeG1FeERxemhKSE5ydG5SYmdhTHRBK0J2?=
 =?utf-8?B?a0JSZG9seTJGcUJTMlpJYTAxaUVxMVhpMnhmKzQ4UndnZm9NNzV0ZCs2Q1pp?=
 =?utf-8?B?MlBtV3orM2NGaVY1TFg0dGdlaExxbGY5M3RJU2VMRVdyN3ZqaFZDSVlEenlx?=
 =?utf-8?B?dUhkQXd3UHFJV3lTSnVqbThqSHV4R1hSVEhyS2kyZHJFMjhqdGNCdmw3TUda?=
 =?utf-8?B?U2ZYU09nYlJQNVF3MSs3Q3czdGIrMWtwSFUwWU82VFdvQ2xLelRKMEtMek9X?=
 =?utf-8?B?UWZKVjJtckJGQmJTVlhIT3N0ZFMxNWFlNUdJMmRFa0RSdHFsc1Zlem9IUHlZ?=
 =?utf-8?B?dDZjdkhyeVFpaTMxdW1MY1kxZjZwdTRYSEtZcDRRbitRd3Y0NGVoaTdVN2l2?=
 =?utf-8?B?MWpuNTZCUGx2TndrdGRTdTBOejRZd2JSN3E3OTZFMVFCQ0JNdjdNbnl1d2lX?=
 =?utf-8?B?UmZiWENkU2JDZ0lhS2RKRC9sSFc3eG4xeEVFM2xCZ1V6c0xQb2ZxQ1NXSHRP?=
 =?utf-8?B?QUhtMlpETitEaEFTK3ZzRTFWOW9SeWhPSzJVT1RBdnp2ZTd2N214aDR0bzk5?=
 =?utf-8?B?MGRFRXJjUGlOMnhzd1J1OTlNUlZkQll3S25ob2hmUXF6T3k1bTcyY0pRd1Jr?=
 =?utf-8?B?dEx3OXNvSmh3a3dYbWJ5cGJFbnZISy9KdTFCNldqY0hYYzR1cHJxN1QrbmIw?=
 =?utf-8?B?TjVWT2Z0YmQwR0crOFY1MUM2cUFqdjREbHNvNGxVY3BOUjNrenpMam5GSkFa?=
 =?utf-8?B?QnZQODlqREU0NmpPYWRQblV1NVRjQXo0QksvRHhZUmJYVlhkYWZvdFZ5NmNQ?=
 =?utf-8?Q?ypNcPSFCy1U4UInsejlvLLGz7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60433705-e794-48f2-2139-08dbb81eeb24
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:11:53.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gGt87grLukGjo4r1pdtqR5fhF26Ifnijn2S1OpfpEgiOrTNrogHM4f1hLFomlEfohJP81tllA/GNlI+f98Ndg==
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

i.MX8ULP and i.MX93 actually has two interrupts for each gpio
controller, one for Trustzone non-secure world, one for secure world.

And they has one register based, not two as i.MX7ULP or VF610.

Although the Linux Kernel driver gpio-vf610.c could work with
fsl,imx7ulp-gpio compatible, it is based on some tricks did in
device tree with some offset added to base address.

So actually i.MX8ULP/i.MX93 is not compatible with i.MX7ULP.

Last, i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
compatible with i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 36 +++++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 59427d97adf5..5243b4cf1235 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: fsl,imx8ulp-gpio
       - const: fsl,vf610-gpio
       - items:
           - const: fsl,imx7ulp-gpio
@@ -27,16 +28,17 @@ properties:
       - items:
           - enum:
               - fsl,imx93-gpio
-              - fsl,imx8ulp-gpio
-          - const: fsl,imx7ulp-gpio
+          - const: fsl,imx8ulp-gpio
 
   reg:
-    description: The first reg tuple represents the PORT module, the second tuple
-      represents the GPIO module.
+    minItems: 1
     maxItems: 2
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: GPIO Trustzone non-secure interrupt number
+      - description: GPIO Trustzone secure interrupt number
+    minItems: 1
 
   interrupt-controller: true
 
@@ -78,6 +80,30 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,vf610-gpio
+              - fsl,imx7ulp-gpio
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        reg:
+          items:
+            - description: PORT register base address
+            - description: GPIO register base address
+    else:
+      properties:
+        interrupts:
+          maxItems: 2
+        reg:
+          items:
+            - description: GPIO register base address
+
 additionalProperties: false
 
 examples:

-- 
2.37.1

