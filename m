Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2F764778
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjG0HBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjG0HBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2392688;
        Thu, 27 Jul 2023 00:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T58UdoufVXVKb2vvVqHK2Yhp6bAcBOgJQGFg+sHs+hvTAd3IULLBzaRraAcWDOLxAznf9ZU1m12jOVoHsKhVX1o5V5D0UTUimfvPruBsQx5kBHG0Ek7XbCRbDnYVMcy/VOYsK0MZik2YFwbr7y8Tli3Wfg4qZu1X/NUfeh+8vosr7WVmZMLhFkvN5/zD7wgr3WTVJ4ok0yPYhFxKkV8yoTnM6HnnpzsD9z2+pxRXkYavA8pzYcbJs5yYd0eU9aWjl7Ye6ApOkInkZB/9+gJHJxU2xA3xQZtxB0eLWYd/48q1w63wHPWMKDfgz6RrQ//kDFmioCLrOSIIrjSyxYlJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=a+cfSVG0/zTs8C85pmqzClISJ/+BfmJsx/mV9LbX6Ob4olK0BZd4zmwV50oj41CoDNDGo15SoLiFzyIv01LVLIiKGqPgtnJ7PsxuAhY96nQa9bj5ZzWDr4fI8/+aRgmfBt8NQ5t3rjEHCwiAdQuJNryretr36zyXFRnrW7QZ3ndc3JyeOge1siVr6pDFSBlMhOWR3S4Smae/qeGz7dTvGz1PCwWixHK6kJX1p1f6L+SmOMwgfYtno129+sYDGhasvfpV4EjiFrglC/6nnrqTcqn1kgT0+kfJoXV7H5q5PseBEz+Hk+0D9r1nK1+gI579/TAhRZ4IHiJxCryed5Av4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=aEKfCZ/teHvF0Y3Ot1Tcx1v+kNS09ILtcwF5uNoQI+Ni1CLzjtoqCTGUo+adFw99ZcSPw9et3YQXbtdmRRragDzMKpe4MJwNg3MJycnCTgeIf3eV3kBhMaWgxjIkmlwG65c7OmLTjIBhr2OYB5GB9l/Q3dyiUGNg95QWNmKI0pXuzMBULdRk1uU0BU/q+KqCNELR55xqdg4prFPD5wiHnlKyrLWqMLdKvUriN87wyvp5R7mbEYKYWtMw7QWBPmfeDL/NpKnsTSUS7kUqN6Kb4LX0RE92WzTa+F8qTfNg8h4FdQW4xWZzmZMsGQHDGXidzc8dfAMtyrUL4Y5VdEc/Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/62] mmc: litex_mmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:53 +0800
Message-Id: <20230727070051.17778-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 6281c39f-3092-4a35-a6fe-08db8e6f4137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iyLwjcVwaZ1qt9ZwPEvvR2+UTJ8JH6qJJCFtsdnaEUkGn3F++vl8v5f5JWuXHSXnVUu07KUI5ULSVHAHBUqLSAcWKeOin2yQPxvx7VD3uYoGec5ihqyGbjOfQxq+6qm9pvGzuOyde0WOsV7rrfnG8qGoxmqAeL9mJZsaVIkD6BIMdCxK+9fZid8rdhh7j5SHgrsfR99tEUmG6mUkaQ6UEqVTFwcobXs0VYUoTpdzmtFjFPyXuTV8vCFKylw/a/olJTikzkKg8HS6UJBeE0YKbA6QkFhZsxpNvk+l3xIQH7Xos3ZYBL/tM0/y2s1BMiG4qvZuSk4mNOa9bh3LB4ocB9w6+XhT5AiqaFNr3WHLGTfzbN0wZ/wPojvfzx9hep/KMfV+gCpvccdcnnVHdrnhN6KrzgGybdkHCbtWoAhWA3vsi432g5QQ32erQVFrr8+bX68BKwPboiM3UI2RULf64MSg0XbpF/Zqgdrme6nOnt85y/nwb77gjA9jBhpFIuvbSbRh3x4FXzAv872ROS68erIAJkL9EVRHQL+BEKgfgpnZZJwK79iJ2rxioYzB/G8lSNSTwlZjad4Yo7gbGu04jEfRHCuj05gKZNpWexRZAw50T+3rrpG52beltVjGyj9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qld1Ym1vVWplQjlORnF2Zks2d1RySjdkOGZKeFFiay9xMEhPUmJDRHowS3lh?=
 =?utf-8?B?Z1NGS2plWmVLVU9zS1hWWTVPeUhlV0J1QzlGNjJpa0JPeEFGQkF3eE1MdnRK?=
 =?utf-8?B?U2dKODFadE9Md3U3d3pIMEhHTUNqeERvcFY5aFRXV2ZKc05ucHI1cWZIK2Zz?=
 =?utf-8?B?Wmw2SjNXOWwxTW9vN1VNa0FFSGJuU3E5U3pBdW9MckxEVkFjK0NFK2t0ZDFk?=
 =?utf-8?B?c3RLdFprVDlaTXFDTnI3b0lHa3pHVTZ3K3hCZ3YvUzRWb0FoUmFHeTV6QU1T?=
 =?utf-8?B?cFZNVGJDUGxZNnZ1UGdTU3BBL3dvcEpSei95Uzk3NXo5TXZmNTM4TzAvZW1U?=
 =?utf-8?B?K0lLRi9BZzNrSWpIbkEyalkva3FLNEt3Tzd1UVhYb1lGSTJJOTRCZ2JsbVVQ?=
 =?utf-8?B?dlRQbm0wekNqOUowTVN0NUk3K3B2a0QyZkE0RVdEZ1Z5elo5S3Y3V0ZhdFVN?=
 =?utf-8?B?WFhjM2ROR1FFVWtILzJLTWxQaTlVY28xdWRwZDh0RGxUbmRjTWJIV0NiNGVS?=
 =?utf-8?B?Y0w1ZnJZaTgrNjd5czl4K0JUSXhMcFVHTGwyY2lKY1g1Vk4xekovZ3ZrQTlm?=
 =?utf-8?B?bXBzL0REaEprM0VBK1NDWngzbmU4R1BuRXNwbERrajhZZm51d3d2Uk1TODNX?=
 =?utf-8?B?L0N6U2xuQThyNENmQmFncEdMMit4WHRlam8zWXY5Wm9DMHkwNU5tS09KdUhX?=
 =?utf-8?B?UG1ncWlsRmoySkNMeGpaZkFCcHdHYVhXdzJJUGM4TXU0WEdZanRFNTAzYllF?=
 =?utf-8?B?Tm5VcGFya1hLa1EwU0lkU2Y3VExPMWorbi8wQUk3NElTWFZVTTVPOTZxWWlS?=
 =?utf-8?B?S0FqQjRGRi82cHFpT0hHSTNYdk1WQmZyM3VaM2JLejVYOGV4KzdqY2cvR3JF?=
 =?utf-8?B?ekFCQUx0aVRtd1U2UVJHM1l1ME9TaGE0UkNaSVRSN25GSmZJNlFSdWszRlRl?=
 =?utf-8?B?ai93NEdWc0Rtb0dlNmUwZHFrdGRXdk1XSEEwMlQveW5uZ1Z1eCtCViswb3l5?=
 =?utf-8?B?bHdjT1ZSSDNOQlVidmVSMEFuWHZkYXNNY0poQzc3U0cvN0FkU3lKeEQ4cHpO?=
 =?utf-8?B?ajk3MnJ3NkI1ZDR1OHVyWDJ4TFVOL3BCektpUWdnVHpLaWNPbHNWSzhjU2Rj?=
 =?utf-8?B?TzlUL3VTNXpHcmd6WWZiWmpTRGwxcnQ2N0lzV0JTamorK0h4cFJITjF2Vkxv?=
 =?utf-8?B?cGFHdE5LRHdnSVN6bTRhSzJ1Lzh5bitzbXBjeTNKaG91Y1Yyam5RQjl5YUZW?=
 =?utf-8?B?alUzRWgrUXlzQmlqYWZpY0xiTnJoS09oalNUZFYvTVNrZGxYRWtCcVlsREpL?=
 =?utf-8?B?aG5LWWJhR3FieHhuMGprL3FtYi9XRzdYQkRsRDVPRnV0TzBzci9MTVJEZ0Ey?=
 =?utf-8?B?YXVLVlZ4OVJsWWNqaDhIS1B1TjBTTnNSVEFNajN1S0JXaFZueFpLSmxzc2xE?=
 =?utf-8?B?aFJKNFFkcGVDWWZVWmJqRldVUmhrZUxiUnNWdXlwNGwrTDZkNmIvbFV6bjhz?=
 =?utf-8?B?MXhraGI2dExsQVlrTHhpNy9DL09UU2UvTEh2aGZTZUFKQ0lpTW1wN3pRNkxO?=
 =?utf-8?B?eDJySmdQalpTNU1DL3dsN0dCbTRRL042cG5ZaE00M1duWlRYMklIb1BRZ0o2?=
 =?utf-8?B?VDltakNlczk0cmhDbXBPbXZ6a1B0MnVacUZiNURIZmNxQlQ0ckJBQUd0Z2dR?=
 =?utf-8?B?UjB2djBoQ0RRd3BSYkV2ODBCYjFSR0hjcjJoZ09VeGZOWUFkZ05mYldsMVpU?=
 =?utf-8?B?cTYxaTJtUk1WSWNJNG9XTndhVEZaRTE0dDUvTFl4MmJNQWJHbmdOWVdVa0Ru?=
 =?utf-8?B?QTZ1USt0RnRONjVpWG51eEdDVFlqaTcyV2w2S3MwWitpT2I1QWRrRlR0MjZN?=
 =?utf-8?B?NmRJdnE1dVBZZnc4UWRsY3hxeHJXdjl2Q0tRa08zYmhpaWpPeDFMNlRuVXZC?=
 =?utf-8?B?TThUSmNWNEgxSmt3R2JVaTZobFFiODA3aUJnOTJ0cEU3SW9YRit1SmRId3BE?=
 =?utf-8?B?VkMwVVpOMjVuRFQ0QVRtU05DWUkvbTFUS2NhS1JzeGowenJIUXhCRWhJcU0v?=
 =?utf-8?B?eEd0Q3NrVTE1OGJZdEFhYlZQK3lNbWNMWXVwbTZtQ0dyd1pUNXVRYXNnV3hL?=
 =?utf-8?Q?CwMyTTahledP7Sf53i4n4VSv8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6281c39f-3092-4a35-a6fe-08db8e6f4137
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:09.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGXpyvwRqXWH6y9cozQHNmJLuawhEOHNBe9qg7/yjgb3ufb7JYcsZRFHEetU0FYFXYcnXT2JcNr8kLlCRLWeLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/litex_mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 9af6b0902efe..4ec8072dc60b 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -629,12 +629,11 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int litex_mmc_remove(struct platform_device *pdev)
+static void litex_mmc_remove(struct platform_device *pdev)
 {
 	struct litex_mmc_host *host = platform_get_drvdata(pdev);
 
 	mmc_remove_host(host->mmc);
-	return 0;
 }
 
 static const struct of_device_id litex_match[] = {
@@ -645,7 +644,7 @@ MODULE_DEVICE_TABLE(of, litex_match);
 
 static struct platform_driver litex_mmc_driver = {
 	.probe = litex_mmc_probe,
-	.remove = litex_mmc_remove,
+	.remove_new = litex_mmc_remove,
 	.driver = {
 		.name = "litex-mmc",
 		.of_match_table = litex_match,
-- 
2.39.0

