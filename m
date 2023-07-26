Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72A7629D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGZEEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGZEDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:03:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C23C34;
        Tue, 25 Jul 2023 21:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOuGWEIf4z7ANQc6Ww1CBYhujHy6sB2JTOgV2MjXo7YEhN6EEFzw/o/bfxra6yv6bPVK8KpL00C91tVlg++tJ2Bh5BSfxUip+zHzihaJfif9oar+se3KdHoce/l6N4WMVWxCK3lYPmOpHDz+8KBNtuuHstlHV1XSFzalnr9562CMQ6Pbk21uv5HIIfp3QgPMRvANiiTIP++wbEcRJM4enSvcj5G9UI19BgqFBf/jOH6mRgVE2Z43dCD4c+NaWMMqHCXOTg85JgYMGkshVtGdRbvH/44SoEMPoVYgBVDXviHvSko3BUetXv+aYtRzsvIMCBXdJYgm6gpt3Srx33erJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=J7vD7Vp4I8SdWjlY5+/f++Y3kXqtv8pRSHTy3B2GSqQ13jBDDvBb2vCg6a9MQf3069UXYR83iiICaKbIQUdC0RVaSJjDmDR/GxCeyyYiEAcVXxAp/hYZ/3TLXDdu2884cHaTLC/14D4l+6ah+QLbd8g6w1JjdT0byENme19O8xWqIzq3zde2JrktVDhhR7vpTv1TQyZhRzNXIuQ0Rbd/N6IOR7NqWIKxWhvpG7Dp3zACSl5jgtFda5LxVzk4FJFaSFFwZ0fCtqZoSuc7M3UZj0xFRgKCw2lZo9pQWDQKtd02GnslEo3/SCs7hWdTNXYhbnXDHDm4zgFiEnIIxoadzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+CTem6dHExq17DY+SzLyRt98v7BugU2JDEv1g8WLeI=;
 b=HeVOa974vcZRLKI/Ih4j+/45gLspk7xMVl6nAEvmcKOQbe+VRYzU8pWKql/YBvlxi5VHL3HtMHRPBEkP4e3W0743/CWQkBB/TfxRSuKkMLzzJciTmdkuXuSmDi8UoCsnlKU/ZUCdvDC8NHuSlmVG6Tz5Dz9sJB5rLk/9gqez1wFxQO9tGOB63IbCg5ATVXt+pd54dFj2rkxRKmqXJ+5OR99qNZrFhab1NDeU6PF7bUyCjXlcAFfbFN1CaYUhtfEiY+k/3bV4GIpXVk5Ku0y+fsXxX1KAyVPNwi7V3+8l2u2MYC6OdOObhE9J9zzEm6xbaY2ZxtStK4t9MyVqlutGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/61] mmc: sh_mmcif: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:58 +0800
Message-Id: <20230726040041.26267-18-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 5866640d-67e3-438f-1b9f-08db8d8cfd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/8K3AEWZVJUKb/Zz68mpWSQSMDGAlYgqjWFrcyXp8FLeAcXYyg3GxsXiAN/pfEay7EXEl9wqS/pN6w6mqmhnykprlGucXjjIChDZA7UDMEt3BgG51fm+1art3HzYYpJJazj5otejxYCsFCCgWZVwZkZRb8vhOLGT2exhTJ5wuhC3hDsMvOWOXLfp3/OYXlfLi0f2ZblbsujMRq8ulEfnoPEY51RyM0XpbmoslurBN8KUKnr8guRHmZ4U4exPScPYQnCA8rpaWBPGDfQ/BtsKSS4RCPf+eqGn2+PLDsNgyDoee4sbUCRLujtc+WJMnLp3Iae21LKGWZL3VuCRUhv9/cicZ5474ED0IM6mH+twEoWZZSm0zO+0KGMblYxWPZFPvC/hUSARJELr92ZdzcObmZa1usoVHf2zCjB1EN3iYci7m0fkw+obQrZ/DTDNUMDyN0Hf0LefB3nTFRjWORfUs1L6G4hB6tnqVPCi9osH9nbuVREgTe3NaeCQPsqsMuqxlxY73Sqww+Y8NWIGGSYGvNu6JaxsadqmcNMqvEHfJhjsZyMjnqayve6wdUzbr2B1KXGWo04XRA3ojEGpqXAZAK4ICKDUtgsFeUg8XEvQS0eQmdwOpVdOyPhApBdQsl+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(6486002)(52116002)(54906003)(66476007)(316002)(6916009)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FDTFFIemg0MDY2cnFkN2o3RjhRc1BuczRDanUxSjNDb3VnNGw4dVVWS0V5?=
 =?utf-8?B?VUFVSGYwcUxBc25VVlA5cmsxWjdmdzdUMEJwajZiMnhYZm9PdGROZzBQRjlo?=
 =?utf-8?B?STdzcExBUHhFdTFnMmN0UjZRZi9hcU9uQXZ1Z1B3bUxLT1k2QXE5SWU1dWFh?=
 =?utf-8?B?ZU51dlEzcG9WejNSbG1hNlp0M1NwQTRURys2cHNGUGZ5NTBtb204OTI0ditP?=
 =?utf-8?B?YnYyUDVGSS9qcjZoa1MrOVJ6U2lnRTBxQ2hGekVjRTRCbTJUUml0QjRWaS9H?=
 =?utf-8?B?ZERsblV4Y0FKSXVZandBY2drYndkQkFuUGFCeHlQZ3RZRFB2TG5SQnUxQ1pm?=
 =?utf-8?B?a252SmdQbGxVUU9ucWNiR3RtV2cvb1ZEaStxZTNQSHltYUpmNFgxWkJydVJ0?=
 =?utf-8?B?alM0R3RsYlZ2aU9LcmwwNUlCMjdxdG5WeEIwSU1BK3lyNzliSTZ4YTB3OXJr?=
 =?utf-8?B?czhIYVhFeVg5OWpxVWxXYTMxTmk2UlVUaGZ5TXpvUERiOW9vU3RicXFOS1gv?=
 =?utf-8?B?UnZTUldpdFVSRFZ0N1NZUklWYUNKV3oyRWM5T29iMm1zRG9sNitEbkFRZmQ3?=
 =?utf-8?B?NzFtNWYwRmtxK2Q2M01nNjVzU2NYek9WSzdXeDdDdlhKUm1JREZNTkFkS0lr?=
 =?utf-8?B?QXNmWXVKTkZCSHRPQ0RzbkExdnF6MmNrTVpCakhpajdvUDV1MkdsclB0R2J5?=
 =?utf-8?B?ZEtlbytDc2piRW5JckdxMUlBSFplQ2RDV1hhTFR6SGVLWmJiQWhFNW9uOVFH?=
 =?utf-8?B?OFZRUDY5dmlHYlhGTzZQOUF1RHBFV1ZuTksyRmV0eUxZaFpxWVA3aXRWaTN5?=
 =?utf-8?B?UmR2UUtMUUlNUGFHaXVVVGMxNld5RXF6ZUdaMjhURFg0OWNwa3lSN2kvaFpT?=
 =?utf-8?B?NENvVWJYU1hZSkRaUVhQZFBFQmdjVFk1em9RcHovSERoU1RKL2hkVjhoZDF6?=
 =?utf-8?B?V05MRTRrek8rdldnYSt1elcxdVQydEcvdFgyekUyOUp5d2x1bFVJWERxSlN3?=
 =?utf-8?B?VjNhV0I4VXVLTFBDb09ndlMvclBvekJwak95TjVyYmEveUVObjNJTGRJRC9l?=
 =?utf-8?B?aGRPUUZKbm5uckxCNldxZmloOTJMT1hxZU1oaWhWQWhzV2tBZ0o1YmtSZXNJ?=
 =?utf-8?B?aVNFRkNnUldpaXIyUTRTODRnbGd4YmlqR0hpbExhYkFyZGRBenYwWjRRbm1y?=
 =?utf-8?B?b28xc2Vmditsc0lxUUdsdTJqN0R6Nnk2WUpzSi9VeXF1eWlVUzYvK3hTQmVC?=
 =?utf-8?B?UmkxZUdaRlpSZGFBaXBxMTNWOUVyZEtaZ1hBQnc3SDM4RWM1L1BhZk90dXhK?=
 =?utf-8?B?SnZXUGtwL3BibUtNd2dDVGZSYVNwWTlHTDlzc1NucHo1TzdHWEdVa3pXdkVt?=
 =?utf-8?B?UjljWndMS1FtVUNHR0NoYklQMXY3RG9EYXlRUXFVdVBZMGN4cDRlVEpJVHlX?=
 =?utf-8?B?UWRoY0pad1VHMUdBUnQraGRGTTl0MWR2SVpuR0QweUxIVjV6MUFDaWxvSE9x?=
 =?utf-8?B?N0pITjNJS3AxeGhOelNBa2RtdnhCSEpYMkU4OVlWSHdLaE9qNFUrLzNSa1pR?=
 =?utf-8?B?T2kzbG45dTlmTytNZitJWkFqNWd5eHlOTm5ZcDAvbnRETUQyQzN1WlBENkxR?=
 =?utf-8?B?NitaYUZVa1hlQkhQRFg2ckJhbWJ1ckpFV3hUYlB1Y05KQXlpTWwyc2FYWkpt?=
 =?utf-8?B?dCtPYjl0SFR4REw5MjBVTWlDNVNKeWwwMmF1eFYxYnZZSXptTkN6dWcrV3Vz?=
 =?utf-8?B?UHRCUm9yUncxb2hESjZoc3J0Umc2U1VFaC8rbUFqTm1SN2VwRFZ3em1VcW5B?=
 =?utf-8?B?eHg3aEZPZFhWQkJ3VEFGVjhXK2MvNEtBWXBra0VEcC9wQ1RYNUZtMm90T1Q1?=
 =?utf-8?B?Q01DUEloaTNqTWhZNmQ3dXd4Z29uS0xudmljRGorL00xL1NPVk9vU213NnAy?=
 =?utf-8?B?Nm9QRXF6clZWSmgzYng3UlB4R2dXcFp0ZjRQWk5aWGFRdnQ1N3ZtWTA3WDZw?=
 =?utf-8?B?bVhnOFZINXhLVDZpUWxEMkdzOURTNUVkVzBXY2pCYVBBL21vcG1ZdVNmUDl2?=
 =?utf-8?B?NkxyOHBlOU9vb0pnUnh6Ui8zVHdyQmpKZTdtVW1rOGlOQVE1YkNiZWpKam5U?=
 =?utf-8?Q?1t5N/yyuLL5sF6mUif1Wb4BXb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5866640d-67e3-438f-1b9f-08db8d8cfd6d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:29.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IunwaduPF2ElWdgq+y8oB6lXUjS6FL4QIhtVrhCKxEvZgDoNM2A+E+fJ5jHTA7/V0i8vXhnTh90cxSaDsiv/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5cf53348372a..1066e0c2831b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1509,7 +1509,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sh_mmcif_remove(struct platform_device *pdev)
+static void sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 
@@ -1533,8 +1533,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1561,7 +1559,7 @@ static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 
 static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
-	.remove		= sh_mmcif_remove,
+	.remove_new	= sh_mmcif_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

