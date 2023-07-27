Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252BA7647BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjG0HGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjG0HFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06888448E;
        Thu, 27 Jul 2023 00:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrMGg0VoNOb5BL9E4PkFmGzJ6fs3b8malkIC9PyGqMJlsHrOKAfYcDBYr0XwLf2t8wUA0reCMqOy/WbMFHYAi1ptnNzYWsoQwS02380IX75xdy2GUdIregF3JiAWX9sXmWibFQFjMgDslxJbwQ3UPbDU7Kh7arzhapc71FxtioCYkqW0/kO03KFNgqGLKKjj9P/LGUKTF1nFMR8E72uBdfZQChIDouBGz6k8+WpQq61mjtM3ZZKhpg4xbH1tWyyre9E0Jre8jsXVxVtcrGtHILtt/rJGMV6EyI8RxlZ2hqObr1j/Ir/78qfwppAcGcdCt37wsdl+pYPeD+W+V8lgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=MeeaEKrXaEshNhaf4YMer+1fIeDuPs1WJrBEl9w1Z4MIm9oL6GyiJPZPB9zfvm0pEzJtWCTviMeBjkjjolVIZ5meASObCqsVe2fa1LCalGump+qqrEyHJGWTCty5aAvigQf8uc6fAuxshMpHFEYNjegZcq5Aif5tcYTCRgORFftYqVG9Xwz7bcObDa+a3tyrDzmL+Bz17KpNLpPSl7kl6iE7rMCtjPi25GUkPGaxt/6ihy4XATGR/N+m0Fg5owfeUnTIFySpjkyTi5MvZmYxcTq+04eVxNoq9vhrQ/+QXCIiz86+pPC6H1l+02dJCXE3hVr89ggCX6crGRw/fvCHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5jSVvTfy21nexuFITYTeRJZPViozYwLNoQA6yut0bE=;
 b=X4uEj3J0X9lAfGTbA5/KCkv9O6ofhqPNtdRH6syxfSj2Rfh07FiAg1Ubxj0GKIJ3WXEj1DO29pWpdMqcVFFbNJbDWlk2woN/J27+sZhjqoO6iShRyrEJ6fF/xSesCLML20KSilQnYPTDQy+58K6bUP3VqmCow2FBlIyV+LoDefrFVRI42UGVe9GN3tFKXjppt4PAGGoAED8ntAvfm+wkI01svaLra37vwZZ1PGPbltluO+6D+1ML3TfhPkXJ4enmMU6Dx9bPihhBbvZMWlms/6GmeM/5ofvO9gv3lNNgD1Pl3BvKBZj9ktpk03KEyX4F40X/wR1I43VQS7Z+5MP8vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 58/62] mmc: uniphier-sd: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:47 +0800
Message-Id: <20230727070051.17778-58-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: f64abb1d-ee8b-46c9-c092-08db8e6f78b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzCw2saiXh5oij8OiezOTxeXiP66wLtzh2CijXgl3EuxhEXJAw6cUAgzahhs1pT3dlzPrgt0fvq+ExwVaNPPAeVIJAXvXrlqIF9gqXGATks1qAFuJ5G9NJeON6W3f0A4BrR/OdOBP6DWMF3L8zNmzU2kxy5KgfxI8MBsqjL5Pdw0Zry74P+BwRut70MgYDgBWvD1wuIcBT/84OzxCIA7N30ghOKlFmHX9FD2IkCku3taWqQ1hTPdTr4UsRNtdxSudO+6giexUZwguuSxVDGzIA+aVKXuG3DvUhfD4DD6SFMMLFjjEmXdlAdl55PNAPnGSbGJXmYIxp9YttMc9THY2j3PsiYYit6dq+7yMRlauw9PZ5VFebs//s77RhZqJxxj5GsxQ141vH855hq/vhvhXRTpkB1YEceVdjJiquvTleD2pi22mQK39v3btyIMMVK7QJt3tKGLS8WqGerhpHJWw1x8AMjTbE+6ZREmXR62BSvBtBAu3Nk2E9c/4Qs69cF0Sci+aVWvPY5YMyI+88QdkRWUbz3a7fOf4PsazMAaC4QzUiLL5Ob34DgPTaHEj1dXJsFSRFbM3xzOf4XHFmstxV/eZTrmBKxsW6KaxhZx0vdMiZ2bKwftU/efZEjC6vyS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(186003)(2616005)(5660300002)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWd1MG4vOUNZaTZkRnJXdzllOGtGWGdRV0N1azg1RHViY1BWbmtvRUNOTjZu?=
 =?utf-8?B?SjJQbXozUjkrQmc2WmE4Rzh6YXA2ZlBSREsvY1p6bnFQOVVHQjZLUjdEYnkw?=
 =?utf-8?B?b0RneHNFR0hOZFlzUHBXa0trZGd3WTJLOXVlRjNDb0h1WTJ2eHc0UE5KN0li?=
 =?utf-8?B?OUtCL0pHd0RTdlloUjBubFI1ZjNtSkxKYktPRzcrcUFwQStDeEhsSnFGWjBw?=
 =?utf-8?B?MkJSMm9LcVBKakdQZWQ3YjlpRkNNWFJDc1JNakExY2dQS0tUYmsxMUtkVWov?=
 =?utf-8?B?NnR6blRVS0MzNzh0TW92aExZcnBYeFpBdUlZL3RNSFlTaEpjcW96VHJTUDJq?=
 =?utf-8?B?TS9EUlJEVXlhUlExMFM1Y2pQL1hIdTRXd011ejdzSzhOeHhBWXAvRFFuOGRQ?=
 =?utf-8?B?bmxCdXlNMTQrUmZZSHNsaTAxNEZYVzFyNFp0dGRrZ01GaXJ1WndqMFB4Qm43?=
 =?utf-8?B?bWJ3RkV6ZnJZN1NCWk1WVXNYV09xcnRCOVZhS3FGdHI4djY0L1VSNjJXUm1L?=
 =?utf-8?B?Y0J1TjVIYjBDeEpydXBFb3ZkdG43UVdDblFuTjVDU1lUelZ5d0F2ZWVrbjZG?=
 =?utf-8?B?NURFT3JxQ2orbC8yMk9SZVZmRDljNkwrYnNYYmNKNXVPc0h1WEhza3ByZzFF?=
 =?utf-8?B?cTJaVGxKemJOZFF6RitreU1jWmNqaDc4Zll0V2NBazN1NVVQbjRyMzNqSnlk?=
 =?utf-8?B?Y3JrbDNmckdldS9wOEx2SUxkWkY2U0dGbmNuV09Cc1l5bE8yM3JjZlZQZVFj?=
 =?utf-8?B?KzB6T05QMTdwR2orNkZyTGo5TTN2Nmo3S0JoMjUwSjFObmt0SjlpSWdqWm8r?=
 =?utf-8?B?Y3VJR0tlbHhVOXpHd0xDWjBtaTFDaWpxQVFEUXBOaTZBZTRDOHNUdG9HRGVG?=
 =?utf-8?B?blg5MkF2bGhrQ0c5eEM2eTN3UWl6VXhqQlArbDlMVHJtTitETnhiL0QzT3VK?=
 =?utf-8?B?a2ErSlJ6ekl1S0tyQys4K04wTjdTVGN6U3pQN0QwQWV2M2dUU0FMY2dWcnJP?=
 =?utf-8?B?dWhxcGV0dW02OS9tVDhEUWNqb2xjMjE4dGIxbEF5aEl3VjAyWkQ5UHJzM1hT?=
 =?utf-8?B?NGYzVjVaSEVPV09rZmRIV3ZzYW5aaU51TitUQ21PTXhTaGtxaFpHUkdFUXBy?=
 =?utf-8?B?b21ZS0NSSGNaR1Y3K0V1TzNiOXBZQmVkWjBjeU5Mb1E4c3hpM0ZZeUNZMk5G?=
 =?utf-8?B?bVB3c2wyL1Z5ZWMvNXFYdHFXVitwNEl2L08wcGpkeit3WFZjalI1VHZnTUVI?=
 =?utf-8?B?NDdtdEJEVkdGSWFOZWo5USt2aTNjUlF1V3VmYVRSUTF5Zk9mZit2bitmM3VK?=
 =?utf-8?B?RTNPYXlQaUZPTHFCN243aEM0WjVST3g5UTFZRStvL0JoMjdwMVJ4ZCtXay9J?=
 =?utf-8?B?RExzSTVBdjNvV1FLWHIyY2RKeTZDenBFMHVtWWRkRHRrUFliZTRqUWhTZC84?=
 =?utf-8?B?cHcrTWk2bG9OV0FwemNsbGUvL3ZSOFR5SU1EQThKVVFNUWtCWUdYNlRnTUxz?=
 =?utf-8?B?VlhobFJyYWFPd3FzNzVlOWFVcVYwZVRuYjlDNmhXMGw3RktwNlI5Sit2c2l3?=
 =?utf-8?B?aUU3OVJZWWtYMEtrV3VuS3AvYUpDa1J5MlphMEtFc2RHejEvQkNzZEthejc3?=
 =?utf-8?B?TnprbU1pZW5LRFQ2blNLRU5BeU92UEdCejZScEkzQlY2K1I2RW9MOGk1Rk9u?=
 =?utf-8?B?dVB6RGsvUmlpVU04U3dxOFlYSC9LMnZKbjhnNzlLUVFxVzdScVE5N243VVVY?=
 =?utf-8?B?TytsMC9ZWWYyeTI0WjRSTXcyOVkwM1I3UjFwYWN5Nk8zbTB4MG1DOUo0SDZF?=
 =?utf-8?B?aGdnVlJHNzJzK2c2WHhYNURvdW9LUVRKaU1teEkwN0FjSEM4MEcwekpNV2JH?=
 =?utf-8?B?UkhUVVhaY2NLODN6a2tuRVlydFd3OEh6SEZXUnpTOHo3RXhWdDh1dGFZOTky?=
 =?utf-8?B?TC8yVnhhWDd0MHVoWlMwQ0tML2VlMll1THM2SC9KNEdVT2NnU1o4SFE4Mndx?=
 =?utf-8?B?elFISkMvaDM5eXZOTWRlYkhoempnd3BIVmRIY0VrVzlCRy9nQWxpSVFtSXYy?=
 =?utf-8?B?SmxDK0h5VWtTMVBJTjJZZ2dQMDczN2Y4cGhLcTBURkNCY0lvSHlScTVUMmVp?=
 =?utf-8?Q?7nES1d2cY+n6dKUwIvljWi+Uk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64abb1d-ee8b-46c9-c092-08db8e6f78b6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:42.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /248dpgNnj3tYJb7auMysIoahVR1WPleQWcFUJpMOe4B2EdSbPJEhzYPlznDTuSD2QjVjefggUnPOV6nPWhSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/uniphier-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 61acd69fac0e..33a4d1c6ef04 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -727,15 +727,13 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_sd_remove(struct platform_device *pdev)
+static void uniphier_sd_remove(struct platform_device *pdev)
 {
 	struct tmio_mmc_host *host = platform_get_drvdata(pdev);
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
 	tmio_mmc_host_free(host);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_sd_match[] = {
@@ -757,7 +755,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sd_match);
 
 static struct platform_driver uniphier_sd_driver = {
 	.probe = uniphier_sd_probe,
-	.remove = uniphier_sd_remove,
+	.remove_new = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

