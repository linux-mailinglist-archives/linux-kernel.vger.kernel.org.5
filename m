Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2082787019
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbjHXNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjHXNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:17:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923319A;
        Thu, 24 Aug 2023 06:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcAOMdzd0wH96/mFg9dbGHa35kZsxIEKLR2SUXVasfvGPLEKHbPXZlbADmllPJhp1SPsrG8heEHulf95SfzIg4hgBk4YNx+JTFMno5OvUnsKyxy160nF1JGOBSycl7XwuNwKz6tsxEbpSgpGLRtxmlqW5OIbBVLdMpZpT4+pXX9BODFdq3IFn1J3o0JRQ/JZNeem61Y0yG4cJ1XSbcsdSxyY7VBu8ZazSrxiBQf8eCcVKOMkHu2d94vTRR0O0jNe3JomSJIqoFZDS2dzMkN+NpacsQ6UJqtchg5DqEFDXFNE8P5ZsGLlUdk9CvcwBwiF3idC6UB2E9jaCuCbNcn0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYdtFDDBz9yufg0hNLisSjqXC3yZme/QuGXLfwrwy58=;
 b=HmEq4/yCUiM3zYqsUa+AcU2fZIcNJxn09uoSsiV/mZ9ZdL5OIB0B5k2Bdb5aOfLJM2nxiQHjsBqVwXbzW7kcz9Q5Fs/sOO60bqp5wIVnh6rih0UV9EZIHgVA+xAl5fNuzM7t+ACbXOUxlHpzp+3SWNqDePaz/dTz76sS2qdbLf9phwRiYq4XHVNAUWOqmMAcZoBBore9dzB5ztXA51tOckXrRaj+S5fBVsM/jBp+Q2LjDcsuLZ+ggtLmv7VW+YKxW+ZK6dwPEpiPnRR3m3qhtQGchN2f8mnumGQjT8hVbTygc7NYfBRjH3Rdk2UeeDJTLLrO8+ZXPVx+rqWkzpAxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYdtFDDBz9yufg0hNLisSjqXC3yZme/QuGXLfwrwy58=;
 b=DtQTLDMgSI6l58wM6sC+O733i23rQiG4414//s6pOb0PA8dOtRIBJyYiqKGFBCyhhnW15Tbl9hvb4TE61cmMmHw/Nu1yVfxtrDUt5OdPTo8Psw6QqL9hEhEhsQlBGckrOeQJvyx1EQIghRu1WsedrljYNEPcMLJ5YNcek42QlMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 13:17:47 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:17:47 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 24 Aug 2023 15:17:12 +0200
Subject: [PATCH v4 4/4] dt-bindings: input: touchscreen: st1232: add
 example with touch-overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v4-4-5c6c0fc1eed6@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692883063; l=2479;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=44cgFwtZzL2OXOflV7LmrL4zTle4mGDX3x0vaww9+g4=;
 b=9+7+UTtVdpzK1oVd/L4sTJvBrbxdOJ6P0EV+SUj0CO4syjwj2uZxr/JP+DjUUDvwjNQQMbAHw
 Z2AZUfSUWmwDKYPSt48xEEmQ8GHyWVtHNa6KpsiUphfcZPg1wBSXiv3
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 841a9e08-cf58-489a-16fe-08dba4a48266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi7yxZgzvMUINLQhcz5l3N70AFpAL3QgqoxTdVsMHEOPalbIEuNCpKe2sa3PPoVFW9F//6rxyl1pGk92Nvcx3wo8jojk5AwidC1+yd6HMw6mKiTTr1hmyov5dgyuXSeCIss8uVDFBRKRn/Cx4ByzA2JmIALd30/lugR5fZp9GpwjV2O/MBOLIHkZ+rnCIbLLWTMaHu4Y5EilAuVZAMEsrAxZ6PtXUghZuTsCkELESMZJaz+iyyUxgykmDURHp7HQTh9fmgBPDs4KWt4NKdvz7c6MtkUV7p+BU6qR6VuZn+6KbQU90CKbciCncSACXUosK60YkUx9p9SLcSfZtVQ8f0PsyL1mvOBWpza/dbG2zWuYB7TJEczBsfyQhySoN2egV2Y3qJAB7vIYzgjLYBe23CK25NHURWN9xTzXRblq68cxtH0FfhXHfdfAApQF08uDemIcsX1IrwC6OKahs3tu4Nr+kBfxob40+uqVvsKCYzelIYlhyVMueoNHOcW01LDEdwxXVW7+zQ0kG0Tl0D6XciA/utnPo9IcHYYrD7eDlwMrPqCb9+aPurDgqXRbeHvXgZApCyQ2KnRPTdUVxDuv9A+IkRtwWNVQ7BJYt5+Hf1cVZ19Fv11wlGE82MqvKMj+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(38350700002)(52116002)(6506007)(6486002)(5660300002)(44832011)(26005)(86362001)(38100700002)(8676002)(107886003)(8936002)(4326008)(2616005)(66946007)(6512007)(66556008)(316002)(66476007)(110136005)(6636002)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdEVmtkTlJjVWhlTXlaVGlqMXpiWGJ2aHlpazdIei93eEhRVDhJY2paRStC?=
 =?utf-8?B?c0JSTzVBMDBGZDBsKy9BZVAvNnhIY0JFUDV6TEFINGxVNVNGdjBpcjBBQXBj?=
 =?utf-8?B?WGUrYjg0b0JpL2Z5MlpKSGhjeGdhQThIS0gvb2NwSDVUV0FqTmF5MFhiRzhp?=
 =?utf-8?B?NXFWTWdXZlJOL1J0Y3hNYWcxMytEOUlsSWxzWFRySzczTEt5NnQzRHlQVzVx?=
 =?utf-8?B?N3E5UXg4aW10elhxNWYwQnN3WEJxdE9jSVpqaHNIeW8xeE5yeHV1UWxLYTNs?=
 =?utf-8?B?bWhDZDJGYUphSEdRd3ZmZ2tRRFZnb2hPUC9SNjhOaUw2REpkOHBPQUhyclBx?=
 =?utf-8?B?aVlidmV2cVM4Z0JndGZEMitnKzQvajJGU0Z2cVBycW5MdTBMeGZPcUJNeDFq?=
 =?utf-8?B?VjlrOGNEUUhidFZQbE16aW9IcStVYXBPTEtrTWowQm9kSmxRNW5xaXZINEFs?=
 =?utf-8?B?MUZPUVhFd3d5Q0p2cmFBM0hnUTFwTHJVWllGNGpNdFVna2U5bkpVeUE2Y2hW?=
 =?utf-8?B?UUZQeG0wVkNjZ3l3RzlFUVBOMVNOb0JzNzA3RnlRek9ZS2RPSDZ6OHVVM1o4?=
 =?utf-8?B?SFJPU1dweWZWM1ZVQ0hJNjhHVUlEVzNvTTRtV2IvNWJBbnpWcjBsampWYlJS?=
 =?utf-8?B?UGJzbTVHL0d1MUFQUi8ydDI5Rk9IUmpXV0NVaTI3QTJvQnI0ZnFPcVlQdTVN?=
 =?utf-8?B?Yy9iTlQ3UWVkZng0ZHdtMTdoQVRhNUcvV0YxWjVKTVpQQU1weEFyTFV0dkhl?=
 =?utf-8?B?QzdpSVA1Vkp0VTJQa0xMSTJtNkg4ZlpXZEovcUpqRzA1MFpucHh2Rmx4RG1B?=
 =?utf-8?B?OWcvanVuTU54M29VVStjdUVYYkxqdzFBRm8yRFdvdXJHVCtuWitMWWNFcmZO?=
 =?utf-8?B?VjVRTitFTGRFTk92MjFXd3liUWZPUE9qTWpoTmdxQ1JyYjI0SkZDbDhCc2dk?=
 =?utf-8?B?cXVldy8rNTJBeHc0emFFTGY2WDRHcTlaMXk3bmNXUStoeVJyeEs1bXZ0V0lB?=
 =?utf-8?B?Zk9UeXlFeUdHUHMyTWRxVnorY2RwalkxYUpNUEdnaW5SQTFQK2tVTTF2dXln?=
 =?utf-8?B?OFd1a040Q0xnaldNdDk4bnhGMEc0TWVQeUpXWVM3K2JIbkUrWE94NmJDeUJS?=
 =?utf-8?B?dklFZmQxcTltTU9UUFJ0QlY3QkRYazMwR3lWVk5rMnFFOEFrUHZsaXdGZkRn?=
 =?utf-8?B?ZGI4Q04zRk5pdkdpSTJCVS9HcUx4aG1NalZKOVhvQTFMd2VFZUUwZlhobDUr?=
 =?utf-8?B?MndUQ0tXaHZhQjJPQjFrbzR1YS9EaEVvM0h6N09FMWl2bUFaTnZHOGlpUWZk?=
 =?utf-8?B?SmwyUytpY0x6eEhJRkphRnNweEpnbU94SG5ONGY4Mmg4S2VzOUt5VUF4Yy9y?=
 =?utf-8?B?TjNIUlNlU3kvU0dXdS9mcERPMmMxZ1hGc1ptd2dqOVowWjNlRTYwMTZXVmlv?=
 =?utf-8?B?WFErTWRyRG1WYjNONnpVQVErdGV6azVrTzZKSFE0MkF3dm16RWVTb2dFZVNX?=
 =?utf-8?B?UkJzRWd4WDN0elVGLytZT0kzMUZENmdBdjVSV2J2cVNaOFRnc3hSeTM1ckZl?=
 =?utf-8?B?ZUJDWlRqN21IajBBck5tUFdSbDBhNWZGSkQrMW0wSzA2UEx1VmE4ZUlEQjda?=
 =?utf-8?B?anRkVEFzM0NXejBsUU1uRUt6MTlKL3Q3WjJtN1pPRWNoblFlOVhpYWsvZkhx?=
 =?utf-8?B?Mm4wMUY4SW55TVU1RnJoZnVQdWJyb3dmUlcxUTRRNVRKSFFWbUNEUGs0eDRh?=
 =?utf-8?B?MEZLV211ZnFZaE9RRFpXRVAvLzNoTDFrelpzS1hKVVNCdFJQUmVmUUlPVTZx?=
 =?utf-8?B?RUdjRlk0elBaaHdSZERYTmF5Vm9LdFRBUG14WDAyalM4R3VQSHNKZ2pESXZY?=
 =?utf-8?B?YnFuWXlOZjlNYmZGMWpIKzh3Q0dFTFNmU0RzK0x2bDN0SEU1ekwzSG5vWEFC?=
 =?utf-8?B?WngySXVxVzFZZXFtVmNoNmRSczdlUkhXN2ZDWW1hZ0FmdnZmSVZwNTlNWkZW?=
 =?utf-8?B?NVRHYTBubENTYjFmTW9rTmMyalVFUytEUGZ1bGx3TG51ckx1cmw1ei9sRVYx?=
 =?utf-8?B?Tm9vMVlaaUxkMUkxeDdEckxsT2J4TGJIOWNTMndTVXZWMFh4RDFjS3BsWktx?=
 =?utf-8?B?eUgzZXBsNUtLbFI0bmEzUFhrOWhQckpUNFZBaTJtQUh1RkYxUUhYb0srcWRR?=
 =?utf-8?Q?3SRVuTgccnsaLVK+4f+gN6g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a9e08-cf58-489a-16fe-08dba4a48266
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:17:47.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2ZPFgEr1G54xbut8jO+byeoIod6HAK9+tpbpdrgdhy616GQjguWZDCYQloj8cUNNI+FttJVNmAsPHR4nMMISfw68Vj2eBiz5HA9seLcW0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 driver supports the overlay-touchscreen and overlay-buttons
objects defined in the generic touchscreen bindings and implemented in
the touch-overlay module. Add an example where nodes for an overlay
touchscreen and overlay buttons are defined.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..857b611f84c2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -48,3 +48,43 @@ examples:
                     gpios = <&gpio1 166 0>;
             };
     };
+  - |
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            touchscreen@55 {
+                    compatible = "sitronix,st1232";
+                    reg = <0x55>;
+                    interrupts = <2 0>;
+                    gpios = <&gpio1 166 0>;
+
+                    overlay-touchscreen {
+                            x-origin = <0>;
+                            x-size = <240>;
+                            y-origin = <40>;
+                            y-size = <280>;
+                    };
+
+                    overlay-buttons {
+                            button-light {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            button-power {
+                                    label = "Power";
+                                    linux,code = <KEY_POWER>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
+            };
+    };

-- 
2.39.2

