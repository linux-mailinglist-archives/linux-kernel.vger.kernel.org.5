Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664D7534B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjGNIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGNIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8346AE;
        Fri, 14 Jul 2023 01:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/d7OQh9ESy7BVVBe5oJZ2I+VYmrHxPL1exfJ/330j4eKnSNJ2z4nb3AFZGCNPGnTXjxxmW+13NuSIUqSOGotSfFTxeFY3J8RJHBSNOdCoILw49wxirN/UaA1qSFieaiJ82JRTKzjRR2MZKQ2VXP3gQwrpMws1LWG7jnxW4w3ye4XdtPPSzxBj5ZCn/14+vSwqkWliAFTsAkROLki+U4KQUBNz4w6E3MsGl4akQHiGrf9mmcGSjxgYrl7OVOPShY9nIWEHc8kf11H9eGujzhtoO3BFxtyJrxd9N3DhxoQSOAhF6xjPEfj+6SuHZk+B1ECvZWyTbab+IhsoPdyBiuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqsTkL3/qOWLcMei4l6WVHfyAej9duTSmbc9tQGrdDg=;
 b=aJu8icG67PEWkhtoqrIIlA8Sa8JiJ497ZnB4dUfPJoivYgQtokxvKJ1ukNYlh/ZbMBGvbNkRFOHWx4wxF5BGmPF5pjaWjdGGuWzxL6nn/iogItPjo3Bl5sW99MhUOnairLyUl+sitkWLPQNZ5WFWsM/3UM2QcBR9oR9zjDk3SxUHXrpsKMT/bQ+1Vr1YNWffzRDzY4PmcgXgv4cjL59qPV4p+VpfCA6+Ar7fy8+vCI8UT+12HhRMCJ48EYwHakkwk+J7oygaV6/49ULiwEnvVayNbfc2XKAlJcAE5ww3KrpbtDLjLtsH4zlIVocIcmJ4fSN8mwISE+bOhCYZ5yK5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqsTkL3/qOWLcMei4l6WVHfyAej9duTSmbc9tQGrdDg=;
 b=pZ8Uw9i1obj6NS3BrbkRP/8j1QsR6M7kTzDcnQBcNFKQiHO29wfho6EItDCCAL9GwL0kCucHgUKruODy4f9Niwjuc36SuO6lLU2qQbRFGKRP2OSGbd+1vWs6amkuMCU27JUZOqLVKeVIk++MCGDJRGhxdx5Zwo/RGFHcaf4lM8tA3vsSE8PtY7lxkfX0GPcG1N6IjS9cQ9DxZEo4StLltZRlSz9Ck5+3U/1bvqrKDLnL4n6W5HtvqBpS4rNtL1dpP/ZOZ+FHrYjLtiJ7FN6q84T1YSCN199ZS9gfdHNRa/4zUr1JY2qyPjyT0umHmiZBuvLlQqVCcPpv/wWXLNb4pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4059.apcprd06.prod.outlook.com (2603:1096:4:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:06:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 08:06:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Input: sh-keysc - convert to use devm_* api
Date:   Fri, 14 Jul 2023 16:06:09 +0800
Message-Id: <20230714080611.81302-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230714080611.81302-1-frank.li@vivo.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: cd876983-03b3-4417-c318-08db844139a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fz69zHx2zoW7YKiEsoqTf3GkwzQlCnqdSxgXEYvmP3jrOkHCRUqUN+VXyn+CoTTlULIdmEbTisZVdvo8DHzTWHWLQsTgrJ5kCFsGE/kNShuHi2KoP4d0i4hHVX4q1KJcLsXCNGTsU2Mghb14vqiAvNC5VHk951bdQIV5MX0LkJkziuPrjEDxcHnuwHixpDUkz4Tjo90rEVYVVCWW/D4AdyTRVomGDB87PQlBLEh37kjod7tSTmzeniQcp2WijtWOQI2xZHkTGUwTu6S3heZmKhQWnjWsFjGa37uLwSiF0NlRUyODsU+eH8crOcCQUq/jUV3dD2nRDNqhIK+kg1oWecKqDEuoM8vdwxS2NX7sFuTzo9jFzbtaJgQq+tiUB3jUKR6ldBzxKwRfr/T2xc1569umEhVKOGdJeTUJVGsH2Ap859eE0JBTi1ijfumLzffoNNeXBV3928+5mdhN95axJCbcFeyfGGTH+VgK/mghQcA5t1IA6jLOCsOuR2UQvV8PEbdP8+5S2l2MDV80kOf2l3NPhiYInWI2J6sfMqeI7xtk5zknFZM/mUX7Oo7TQGs6brWrUcnh87jJadm+FdASEq/TnID3L7TUcSCwx2YqL0SqFDfD/SCcVIzYfUINIE5l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(52116002)(6486002)(6666004)(478600001)(2616005)(83380400001)(36756003)(86362001)(2906002)(26005)(186003)(1076003)(6506007)(6512007)(316002)(38100700002)(38350700002)(66556008)(66476007)(6916009)(4326008)(66946007)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uefcU7vm4vfYFgaGc6WUJdS6Ibpk1HEZVq/LC99e1FLR+9gbg/cjJolJuEJb?=
 =?us-ascii?Q?p004KRXzUqPrnflpfax0rTUel6zyFabVUm9f7Ha42LdCt+KjOzwmwC6+jmJR?=
 =?us-ascii?Q?9nImlr0JEqcUmpLCis/Hu8n4IaW+Jbs/GYepmVcaZchfcDOguInow1e42xSM?=
 =?us-ascii?Q?mM9h/w8+aKBRijQ+iafSUDYD7CppJGQG25ZlfT0I8NPcdbWbhLCdz0M8ueO8?=
 =?us-ascii?Q?K22Ysvzu+Xh46TB8GXsi+uBBCbMPJ0DnY03B6WvMq6OqJz43r/w5fE9it8Ik?=
 =?us-ascii?Q?u8aRvU/ICiw8yE2IN+x+IPtHS6PhEa2hGk8klk5kMuzBu+9QWDOPi0HHds9F?=
 =?us-ascii?Q?qLXHYciJYviuDcSLXas5HiWz6FVL4nBT4GnlBQeEe5srp/saBsaATnNI3/gh?=
 =?us-ascii?Q?FvogHYu1qbUcoBWfrk2JB75x2V396tn+9AE81dA9MIX9VscG4NI8TZyo/fbI?=
 =?us-ascii?Q?RC6wpoqcXbp+0ivMj9YmscOdzr/7aMhjv3EQlkz41cPF07lP+7i94cRZr7I+?=
 =?us-ascii?Q?hg479I3hfRmhBpB/W/ezuvULyBtmvxS0LMK2PlHGmsgB/9Km0uwT9cpu4qjO?=
 =?us-ascii?Q?Hjc0ST4uO4NIYzNLqIEesNzxTvQe6j/dmJQCrA9CtUB86rItN+3a50jQbYfV?=
 =?us-ascii?Q?mnlwyw6yN9RploF3hRJByimPyJzwUX+3NLqQhps1RnsCuc9mdYDDY8gfUkRI?=
 =?us-ascii?Q?8TOec65LflBXN3xFy/PiW9bEdQqvaSlgX1Mex9G0AhEdBftd1PBQyE4fboVK?=
 =?us-ascii?Q?KIpTzSY2ueSncdevw4zPfdVpUCuDKFh1zWvExRjvyaeuT3kSZFbxeGDRWg+t?=
 =?us-ascii?Q?gfAI/35bHBR7fPGIaGY0m39bc49qqk77XQ4EeZviGndpDStmHYD2E49obqTP?=
 =?us-ascii?Q?nlIzOulE5orfhaAmRs1n88dNdnV6FA7VEAvIjkk+kjWHDKMNzN5mIBs3ynXG?=
 =?us-ascii?Q?H1PMApPC67rf9eYRlpTnI1ErZaeHt0acxYNYWIPkNnJ2m1F4F00zrnfI9aPk?=
 =?us-ascii?Q?ogg1r9730mSwN2++0m2kw5xOaH3U0CCOGxWNDkcrQnD2lmeoB6/IomykWMDa?=
 =?us-ascii?Q?1amMGE+uV9/r4u8HusR0/oNnSvviQADKsjXaVGZPxIOSZfaXQA8DcPp9O7kJ?=
 =?us-ascii?Q?d1abV3YhvH3my22Km8d/FMBv2F5txUTpDikF/ck23IQ7CBEc7I6oSny+/pCG?=
 =?us-ascii?Q?sKotwquxOU8YSEyc+9JojTg72QtIYdmvWrcomXEyFQEAZ9i5mnMRMcBpIRAV?=
 =?us-ascii?Q?jJpDGPds6weXYIurI5k3KhWIDTXLhbe3mA2Nwhm2ou1xfY4Dt0wMWBLFwQbK?=
 =?us-ascii?Q?XeMrDqQQGXyTQ0BKcBbt9EJkKfGH22Fpz8zLInfbXjGWmqnUGOduIXVnweaP?=
 =?us-ascii?Q?0zUcYZgdSuHLWGG6k428Ck6olmDnZosjMVCTe55u3+LWu6qhAIFqsixtvg9g?=
 =?us-ascii?Q?yj/ZInVc3OMYuq5qFsdTEPiyTrLG1eju1ER9r82BMQL40g4jcCKSFnElGucf?=
 =?us-ascii?Q?MELZocT9BbaBwY4+qbkoxNl8zo20acuKeqgNVL1r8Z1vClFxhtV43DQc3Mh8?=
 =?us-ascii?Q?CJ0Hy9cSguuaLlKy4hAGOIMGnJOX9XFsmM1YSbSw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd876983-03b3-4417-c318-08db844139a9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:06:27.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaSdY/QwJ8XqiCDo5azsGY7GAmDbZyqC2OluOZnYbFvKKpVwHt2fg2B+YSl3fUW/mO0iiwppjynxan2WbhesBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* api to simplify code, this makes it unnecessary to explicitly
release resources.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/sh_keysc.c | 50 +++++++++----------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 2c00320f739f..388fb87f9e56 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -160,6 +160,7 @@ static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 
 static int sh_keysc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sh_keysc_priv *priv;
 	struct sh_keysc_info *pdata;
 	struct resource *res;
@@ -169,44 +170,39 @@ static int sh_keysc_probe(struct platform_device *pdev)
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data defined\n");
-		error = -EINVAL;
-		goto err0;
+		return -EINVAL;
 	}
 
-	error = -ENXIO;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		goto err0;
+		return -ENXIO;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		goto err0;
+		return irq;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		error = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(pdev, priv);
 	memcpy(&priv->pdata, dev_get_platdata(&pdev->dev), sizeof(priv->pdata));
 	pdata = &priv->pdata;
 
-	priv->iomem_base = ioremap(res->start, resource_size(res));
+	priv->iomem_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (priv->iomem_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		error = -ENXIO;
-		goto err1;
+		return -ENXIO;
 	}
 
-	priv->input = input_allocate_device();
+	priv->input = devm_input_allocate_device(dev);
 	if (!priv->input) {
 		dev_err(&pdev->dev, "failed to allocate input device\n");
-		error = -ENOMEM;
-		goto err2;
+		return -ENOMEM;
 	}
 
 	input = priv->input;
@@ -225,11 +221,11 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	input->keycodesize = sizeof(pdata->keycodes[0]);
 	input->keycodemax = ARRAY_SIZE(pdata->keycodes);
 
-	error = request_threaded_irq(irq, NULL, sh_keysc_isr, IRQF_ONESHOT,
-				     dev_name(&pdev->dev), pdev);
+	error = devm_request_threaded_irq(dev, irq, NULL, sh_keysc_isr, IRQF_ONESHOT,
+					  dev_name(&pdev->dev), pdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto err3;
+		return error;
 	}
 
 	for (i = 0; i < SH_KEYSC_MAXKEYS; i++)
@@ -239,7 +235,7 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto err4;
+		return error;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -252,17 +248,6 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
-
- err4:
-	free_irq(irq, pdev);
- err3:
-	input_free_device(input);
- err2:
-	iounmap(priv->iomem_base);
- err1:
-	kfree(priv);
- err0:
-	return error;
 }
 
 static int sh_keysc_remove(struct platform_device *pdev)
@@ -270,16 +255,9 @@ static int sh_keysc_remove(struct platform_device *pdev)
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 
 	sh_keysc_write(priv, KYCR2, KYCR2_IRQ_DISABLED);
-
-	input_unregister_device(priv->input);
-	free_irq(platform_get_irq(pdev, 0), pdev);
-	iounmap(priv->iomem_base);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	kfree(priv);
-
 	return 0;
 }
 
-- 
2.39.0

