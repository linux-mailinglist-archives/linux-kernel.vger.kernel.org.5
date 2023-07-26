Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F37629FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjGZEIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjGZEIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:08:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064044EC3;
        Tue, 25 Jul 2023 21:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPE6dxRszVSeZIbRIKnSjaJS4ATjpPalnUOYSaW/hGO6uVhSSYepKkvIu3WObbiGgxie6S0qrNtsJ/xREGhAs7YdfuYqKRdWO0+AEPKsShAlU0l+jqghcWVSk3OhF0URC0Vaw+YEG9K3mEJtFWgnjCjSVehfPXwBb+d2sOAgGVxtfMvBVQeQnE60yJoPBsxihdEMr0tqPp0q3ppOKPuOJ+5uQLg+ZJ5FumE0PpS4/s5v1EJf7C7eqcny1z0NrlWxnUJw/uYW6bIGIzFYw4ojce99J+L1d9NhBaDAHI1QTFr96IIzogW0u3OMg1rSNWvxSHaf+ww8noCIEwI3My0nqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=LQ5xk8DyABleCejGjICE7S1S1M7Ud4H8/i/SgYWGHXEvRYegHBFLOJa9wXq3eAqlRkgeq+0DBTCrdXc4hyS0j2hxgzJX0QkBBFc4H9rBVYpEPUf7WCyGR9S09ufR+OswuaKHFl171StooXn2w3fhhs+LHD2fiPH1BlYjuPMJ7jzpb+kJfzR2YKTsOCFyOPQC8SbJShlAbBq5ASLeQeib+C2y4TkMGbEIn2pmiF4i6z4jsIORrILXgTp5SRBn25t4oM+sL65FWRYk3zxS/4zjOlP8fCiHLWj/JjpbNngAH95ub8X7VWAJwW5mC6ARhj4zaufFdgOzNyZajOq1jCeoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=LYaSzgp+q8y1vRJbdfXeHpo4tO+omEE3ETxPFYa9bGPcabrnoDA6ZgJm2RiZH0adxJZ0ex+cPjF+S6bw6B1JMRnQ3BH/bN7KNzqkWbxlLg8iBgQr3XBlilnrZZt2rU+T0aJQGZlQR7IgG+ccniz9PdTnzB0phipxWETBKsNOUQZJ7tzsmVnoc1wtom90JMdBJ27gV14B7E6DwSfkLhRkXD7VLOGt++Wo+hWV9eYLwYNB/yMYFLYqjDckrlcjQEL9l+wPN8TYicllJ76+3kHaEyCQjI1X9IsbetrV1ThhoxC4ncpKi8ZgGjWOgKWAml/4HwKIagA2l+a3IDeZLUgXEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/61] mmc: wbsd: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:24 +0800
Message-Id: <20230726040041.26267-44-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: db671ade-63f1-42fa-c257-08db8d8d193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMIbEO5DKVz9xi+KLGQwANXldswD12sXbH9ochhu1G/Akf8QuCWtDnblQ7RxLsoE1TuK1S62LQdFMFpFDZc9oE4KBsl+lMCilPDwxF3kDrjPM5QiI3dD6RNxzUuAzCnots2HcwRstxQ0isyQTn7Mzqgk5SdLv5c2X2iVQTcFXKkBQccbZifJ9+1gLJlIMwxHTbE+wrroaJP7UYhs7yZKVQQpjNHG/zwSyMvJBdISMD40Bnjk07PqEnpIUG0b1ZT4aJyIKKmf5i7kQQPF/z9+5nCoWEI/0dHA9UBDUc+31+NJp/JY5jW/EKPuC9uDhdiv14n8nh0mq8CuomvdbZ+5/m5fDLS1ckeFw9qOL9zYN/AN+udxcPyxYXcBWArsPmGXqsv1fsmMA3qYuEqPuBaEkcuoQ9ZQnYNu5EAWXzES9xxOXpcmyX46L02pD41OiIyXjNQczC36FHrrPPT6k/QDALhmskUiVez1xIifQlsFll5fggSy8WO3TaOkI3ukLLsJFw79g9zXA7RhBsafmXa0TYsmcJ07u+5aa6Yl5GCzW2SstxsJgHgdHnFedjPftqTtNHKlWxFYwqpnoF7Dv1OCQcz2b604fhu2fn+pO3Q1UPbsgTeDdELT8Z08hgO5DldX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdyOXZGYzVDNFBoMHdWOFJ2RGF2eER2NlZTTnZDUEFCamE2TTk4anVUczFa?=
 =?utf-8?B?dWFXOHZ5a3lHWGJMR1NSUGJTZXIrNGduY0RNazc0QzRDVjUvTzlBcG5WVjFW?=
 =?utf-8?B?WDZCUnU3eUsvYkw0T0ZCWmFEQWZ4WGxIY2FmeTFSZmZrNi9CWldxaDRBQWVJ?=
 =?utf-8?B?aUE3bTc5M3lUQXY4QTBYWFU0L0JWVE51eTNyUkJpeTl0TWNEclFlNVJManI2?=
 =?utf-8?B?MW9LcDZ4MW9rOSt2aGx5bG01ZStyelJaSWE0TzJqVk9pK2w3d0tWMkFkOHJT?=
 =?utf-8?B?eUZNWThjQnJGS0w4T3pSMGV2Sm1vSE9zYVk0WSttbWhFNGl4Z0hyYXZFYi9p?=
 =?utf-8?B?MG5yWFgxY2phNHJ5blR1Y1g2aHlxZDIzMXJqY04rK2NnN2V2a2I3NStxTVRh?=
 =?utf-8?B?VzZBUVdwOGtxb2NTbWFpSGtPTm1pcmwwMk55ZnhZazU3VG5KUFo3OGYxK01y?=
 =?utf-8?B?SWlpY0xNeHFaRCt0bk9sakorV0ZSbDhaQ2VUVmREYkFWVVE3RlNpcEJoeURr?=
 =?utf-8?B?OFFjUlZkYlNTMnNkdXp3a3o1bkVmOHI4VG9kaWV6aWx6WHdiNWhFeTViN2xI?=
 =?utf-8?B?eWQrNGFtUmV4Tm1wZGJoTE0wWjArWXQxUGZxRDdlU3dNS0JPVmdLdGt3cit1?=
 =?utf-8?B?SzZLOW13UTdSSW02aUM0eUsrWEN0aHhlWGlvaE9XYnZGZTllRC9KZjVIYUNM?=
 =?utf-8?B?ZFFORXJVMnBUZzBvbGFKT1d3Z2Z0eG85WEQ5REtYS2cwREZxNkZvWFZsZWo4?=
 =?utf-8?B?SDJLbi9OOGcwdUY1Tmx5N2F2Tno5Tk1jQzJyV3dBaHZEZTczckVLMTZOSW9D?=
 =?utf-8?B?QnJ5ZW92bG43Q0JzYUhUSWJQcWhxS2NzRGVEYW8zcERDNFVBa3liVjZ4Vmtl?=
 =?utf-8?B?L0lrbkJCNWZuRWJaUEpRZVhzQ3VlcUZJNG0vVzRtREd4QUZiOTFrZ3NiMWNr?=
 =?utf-8?B?dEVNank1a0JmYXFpNkFEcFREZU82NVVHS1h2TFRQSEZTKzJVT09QWFhhWkxo?=
 =?utf-8?B?c1lCM0VEUmdwM1pjS0Q0VVdVZHJUL3hXQXlVaVNDb2FNY1VZMzlHc1JseEpT?=
 =?utf-8?B?ek92RGltYjY4TW9MdjA3dHdQNlN4WHF5RnNLRkViT1pwTk5QS0xsdUNnU0pq?=
 =?utf-8?B?WkJqM0JhZ3BzUHd0NjBJbVUxdXZxZ3pGTlpTaXNQbDlxYkdPWC82TzIrclpN?=
 =?utf-8?B?WHZxZDZ2V2RNL3NGbWg3azFPdklVZ2M1UnhWeUNnR1oxOEYwNCtDcHVQdE92?=
 =?utf-8?B?enhCTU43dHBzN2Z5QnhzUllGRi94ZzlRR1k5MjI1M05PVGlsanFZZFBudWpo?=
 =?utf-8?B?c0ltSWhFbC9VdFVncHJER2NYTWNBdU5nVVprRGNZMVRldHVabUZEa01vc0s5?=
 =?utf-8?B?dWVNc3hTS2lra1FNMFFzWGtFMXkrcy9kbDR0N3Y1SWt2VWZBVWt1V3Bhelg1?=
 =?utf-8?B?a2dESVE4bFlGczVxTmh6UXlweFZQb1Iyd2Urd3NwMUtubXI1QzJUZDg4UEFn?=
 =?utf-8?B?TW9aL3hvUCswS0d3a3VTYnF1NmtlVDZMblBTMkdlWkNWOFQyTU1Id2FKcWh0?=
 =?utf-8?B?ZnlWNitZQjZHWTBETjlrMVU0RnFFLzJOUFpPOVRiMUF4UnNIL1hpYUxiNjU0?=
 =?utf-8?B?RlVhV042UkI5UU5iZllFVmMwMUxxbnllSDhMUDZOQTZvTko4VWZMWm1VUE5n?=
 =?utf-8?B?UzFiYXlFc2xlZVhJMUdnOUozSTQwK20zbVBQejVhTnlWM3RjbzhlMVIyZmpG?=
 =?utf-8?B?dzBaR1Q4d2w0elRkYnNRcVBlbXduMFFQSEo5eGRhR1JnQnNqQ05NRStnc3Vh?=
 =?utf-8?B?L3JXa2pvZHRONkNvczBVWm5wSENmWEh6OFpPUDBqeFhoam9MUE9hQ01nd2FF?=
 =?utf-8?B?SzlxTHY3Nlh4QXpNWVJEVHhPY1BWL2MxSlV2ZHNpYldjNlZvUytMbmcydStY?=
 =?utf-8?B?YkxpWTdpWXpZR09ydGlGc2FKbXRqS1VCMHM0Y2NwaXhPUUF0VmhFSDExWVo4?=
 =?utf-8?B?VUtDbEhiZ3haNjhIOTZQNE1udDhqeUE2OEs1NVFPZGl4N2hwbXFRTm1WUFNq?=
 =?utf-8?B?bVR3UXMyeXpIa1JNZklhR0o2KzIvMGFtdUhWTHA5dE5qdUUvMEdvS2VvcVM1?=
 =?utf-8?Q?391gPbpUcr93MvANrUr/xpp/O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db671ade-63f1-42fa-c257-08db8d8d193f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:15.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTTj5IkqR34zCnCzGodwaZdWac9n/ccGWzxyjuGqWFzOVX9WqNR6P+SXwDkjjGyq6nDJGbzyyryAqKg90vBpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 drivers/mmc/host/wbsd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 521af9251f33..f361cefcee01 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1758,11 +1758,9 @@ static int wbsd_probe(struct platform_device *dev)
 	return wbsd_init(&dev->dev, param_io, param_irq, param_dma, 0);
 }
 
-static int wbsd_remove(struct platform_device *dev)
+static void wbsd_remove(struct platform_device *dev)
 {
 	wbsd_shutdown(&dev->dev, 0);
-
-	return 0;
 }
 
 /*
@@ -1904,8 +1902,7 @@ static struct platform_device *wbsd_device;
 
 static struct platform_driver wbsd_driver = {
 	.probe		= wbsd_probe,
-	.remove		= wbsd_remove,
-
+	.remove_new	= wbsd_remove,
 	.suspend	= wbsd_platform_suspend,
 	.resume		= wbsd_platform_resume,
 	.driver		= {
-- 
2.39.0

