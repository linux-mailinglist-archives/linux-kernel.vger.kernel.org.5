Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0D751B50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjGMIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjGMINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C92727;
        Thu, 13 Jul 2023 01:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEVKgUIX5ptW+J++rQJyPea6R5hmFJTD6CeGbRe8YUGEaC+Gjm+HKPHajEx7FXt/yTflLHNEfMznxE+KVEqiqErTIKnqdH99hZxsPuw9vM4sb2lWszY/p08vkB4YDfVQ2hgEkqWmOzgyE/nKc2iTJQaB4bRrGZHu3EBRcS4ENdCpZIQqvXL8iRJwzipWLmt6euEevgeisRJ8jUN9HwTdKBmx+51wJoxRbKRAsxYBDvfNnO3zO0WfBpEiNi9wlKjdJ9d7E5XVwHk3nxy8kleWRf0ojc9tImph3UrGpoFvjD6YXm/6Zh5vioxrJqEa3UJ9dV4+Y3WgHk7Ld4k84tBTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg9rpO+O+Vuwq16/2wqHAmJUAen0JpqCAiTPkimHe0w=;
 b=LYEvBE7zCwHc9em5Vv8ErG4yhtQwyvwHH8ltzbc82UbobPwmOPwzr/bm3hi1d0t6Fvn047gx1AkMXBVeNE+V8LrBC4DyUQz6Onml3pT9gnW2hBsmfSh2LqOHvZPJzpL2FeLCZXtAa3JlURkLu4iUVAd0YQgXw0Ym5m/Pray/FeWDZ6SZas5rYMQz7+zuxfQmelRKhceUDjznwMtKraM8bERRFeQsrsriJ+9Y/k8jVfPMTrLGKd0sPsqKzTv/jul12FeuwtyGrlXucTgWHIebKc5ycFlLDN7kQM1i34QCXLsZtdoKCLWu9WFXMVM8gmwCxlwA7XB8xAWcycFBqqUaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg9rpO+O+Vuwq16/2wqHAmJUAen0JpqCAiTPkimHe0w=;
 b=FRg4ZNPaNY3/os0KGxbNeLiB5gOwBw1IiQI7E1aj9G0mHBXS+/a7ex38O0UHorbgRpIMICjcOB5l/K6lQpOrs7uOrIRK81JDGJ6yaExZ0iLngBt/0S0KBhbly+XlBwe/ZU8c+tCJesJZxPQZXm/Bue8far+8XaatZRm9sTdJIhK9Fs+OKvBV1kq5XWJSK5TvvYwb/Rzo27ChoSzdd3yJauYRGUMAsr2wKCq83dVykD8u7N8b0e3zv0TxTHl4H4CyqujnAtjtXWxbuQBADNNyygr4MgcF4O4/TegOkHN8Vg33EDnVpHcGJSrKx9v5OBgcRl5ri2DRPZVmnkYmdSxugA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 47/58] mmc: sdhci-st: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:56 +0800
Message-Id: <20230713080807.69999-47-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713080807.69999-1-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 949d9c4e-d828-4641-75bb-08db83788466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHBab60dx36JBcUZOeOFHs95I9VPsWPHpvJnmMfszYPLqsOEzc67HovDmj4AiajwtxDgmYOXDiW34775CW6y6Z1J9uLp2Au7w92FY3SpX5dF3oFktrrSmmADZ3AFWfCypXGqPYompg7+8YdS6HBrcK/8FKgyKB9k/3zW2yL5/4HtLV1oExnQxCOlGbubfFzVVoam7gA5AHkGTnNQC7xZ3+HfIUDElmxXdoRGbS+SiR8EReya9LriZTcQZAdnnRCjbjblLcDoOoxO8wn8RLX6uf30JbaRYzJtqGfy2c4g7yTw8Pj2MraU0Kk66k95yqbqJvQKOCRZWQo4jTXaK4OssLUC4NSvW2K4srL77brxY/hHOBpN3DZw7FKVMGmSGUSlyX5LFyd5y3LbJN0MF7a8CMgAHIlcBUcE8m4dUcZ1q1jS5FR+8R3ryxjWGzp7Sfb+NxPxxCSWibsimpNpRu6q0w33w/wsJ8TXtPyi4ylkIMzCkl30vxSfuv+BceuWYLI+XVfNcf41zIaTkDaq9bBIy3zhFCvngMfFrc5KuaXSjpxz9p240Cw4WwT7Vvcw4PBLdxdVUMm4ncGBLOk59kYfoBkqvh11uWLB2SNsLhDtojGCBg0yaWJMR+Ud/vGqCnIQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(6666004)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mks2UXQ5V0NvbFVYeFFWMWxCSWxidXhnSW9rZS9NcDJQQ1V1bkZvMm40T0R5?=
 =?utf-8?B?WXRnRHVzTTBYSVJRTWd4blZoQXFaOHovNmxXTWI3VzZvbHB5azFaTTdwOHVs?=
 =?utf-8?B?VFR1ZFhjZU8vMzNmV1FmZ2hLK2RORTR5NDZ4eG1nenpGUzVLVElsNHdhaUVB?=
 =?utf-8?B?MVpmbUhPWUk4VnF4ZHFKemhBT0liKzNjOWVBVWMvaW81ZXJTRzNsa3VZay9W?=
 =?utf-8?B?ZFZvTGozTnYrL29BLytNWmg5OHZ1TzRka0JWL2JYaUNyaTdtVE5YMnJzUFpK?=
 =?utf-8?B?OHBENS8vTndSU2pKK1pqb1hJbWRHNldTbnl4N2dtMHFpT0lRdXMyTnFEazNO?=
 =?utf-8?B?RnFqUnJrOFJ0ZTZNa05xZDNLdmJNK21GM2dNZFdJM1A3eXl4NWRVLzNZbjVH?=
 =?utf-8?B?KzBmTkhIdnZUSW5wd0kzMk1xT3o0Wm1DOUQ4QVdHeE80bStrNHlBdHFQdkRi?=
 =?utf-8?B?NmlwN0VEMUtoVzFIVm5mSi9zd2JhOEo5MWVmbW14eThNNG8yNUJUUU1zaFU1?=
 =?utf-8?B?THY5Qm9FNERFTkhET3cvQWZBbUdlRWozSGVHRHpFR0tvZ1VPVTlrelYyZyt3?=
 =?utf-8?B?US9UYnR4MkpSbkszUmZ1VXZJVmpLUDhhSURiZWpScDgwbGFqTDdsTVpBOTIy?=
 =?utf-8?B?RmkwL1M1VUxWQU9NSVE0cUJQNkJGTzNhUjgzVG93cTRzYnJLbnM0Tm5jY1Zm?=
 =?utf-8?B?SUgrSXN6Y2R1cmJvakZkMWhzRTVZNGdndnVyQmZNcW9MVEc5ekZ6REN4cEZl?=
 =?utf-8?B?UExDMS9YbGJ4VkhYWGw4T3loaG16YUZBdVFUanpmNC9DOVFvdHdnc1NrQlNi?=
 =?utf-8?B?dnduYzh4WS9TeTZ4YXFRcmlUT1c0MHN2U2h0RmtSLy81azNJS0NIVmNQdTZC?=
 =?utf-8?B?YVNIYzFTVnNqOUZSOGo3MWk2Y2dEckpPeS9xSTUvUlBBTmdTTXlwZklxODYr?=
 =?utf-8?B?Mis1eTNXc29GaUE5WitFaVpaM2E2K2N1eHlDcU10VlR5WUJyeWhOVTVzQkRJ?=
 =?utf-8?B?cUh5SXVURGFPL3ZET21RdlRXRG5rVWUrSGVDYy82OXZtenlZU2xCMEhjZVdR?=
 =?utf-8?B?c20zOWZxTG9BVG50b0lBL3hGOGpRY2ozK3UvZVpCS2pjUHlaYXpaREQxQ2Vt?=
 =?utf-8?B?dVM3RmFpZDQrcmNnZE1rbUFod210c3BUc3F0dlRvYURSUlRheXBxMUtPaFZG?=
 =?utf-8?B?QjFqMm5pK2RJeFJWMFJkdkM3M1A2MUhMVUJXNFJaRTlJMEhFOEE0Vm9mRGN3?=
 =?utf-8?B?SG02WDU0MVNGOWZaOTRwYlFEQWk2NTJSR1locVc4a0NnNVhQUjdVLzJ2ampG?=
 =?utf-8?B?dlFFM2wvWVNsanRkQ1ZNK0hNQU8yMFVmQ0dGdkVFcGdhNWo4d1hranR3UUlz?=
 =?utf-8?B?OXN3eXRORHpOVFBUTTlaNGdENitpODZhREplMGx0SSttWmFsWmI0VCtkSjZw?=
 =?utf-8?B?VU9SMkh5U2ZRcE9kRXNRaW43ZWJ5ZW9CRkp3WjZJemV4N0FQbEFjMjhFcEl6?=
 =?utf-8?B?SUFHSUN5U2toamRoaEd5TDVoYTBuWE9CVFNOdlk1MG9VeUppclN6d0VUUnRK?=
 =?utf-8?B?MGFsT2owNGl3aHNneFNBVHE2bDNOcDBqRFhiVzFQZnRBRXZrRVIvYU5EelhL?=
 =?utf-8?B?TVgwVGVOZTRQamZPeFNvdFE4SU9OcmtkZ0lneGpnNnBZTEhIZFJmdVA2Z0lY?=
 =?utf-8?B?ODJzZUNLSG9GNm1IRVlHMEkyb3Z6RXhCTkVRK3lsdlY3UlJsK0s3eFY0WjBn?=
 =?utf-8?B?ZW95TlFzRlQzdWMxK20wTVFMS1BqME53a3FabGhybnlCRWZBNHFUWW5KYXFF?=
 =?utf-8?B?OHBDMTZvU1prR3k5dXNlVmNBaHhmV1JwTko5Sm84aG12ZEpBOGcrYjBXWThw?=
 =?utf-8?B?b1h3QzdaSTBId1JISTBwZ2xlbysydUp0UWFJTldLMjJ2R0F6L0ZlOWJCVFdJ?=
 =?utf-8?B?TGRJdU9YY1ZqQlV2S1VjR0daSEw5RlN1SmovYWNLbGIrS0VlVmV5S1VMUG94?=
 =?utf-8?B?MkIvbU1rSVNNS3lGaCs0L2dEdWJPZHY4ZGVqMHRrUzQwYm1jcHhFSkJ0ajZF?=
 =?utf-8?B?aFZHMzhjWlpmejhKY3hkOStjZmxTS0ZuS3BKMHYrY1l3ZG9OVFhZaU52U0JZ?=
 =?utf-8?Q?5tlesrswxQm8cVxvlbir8Ttq7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949d9c4e-d828-4641-75bb-08db83788466
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:44.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty0m3SmZoCGk/8YKYAjw0UaobfdzimOnWIvoxpBSi8Z2PShjrmbSKKT8lHD5D3FkAKhFpmNJodcYuNSI/7/Ifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 6415916fbd91..d955b5f4b7e9 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -434,7 +434,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_st_remove(struct platform_device *pdev)
+static void sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -446,8 +446,6 @@ static int sdhci_st_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pdata->icnclk);
 
 	reset_control_assert(rstc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -510,7 +508,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
 
 static struct platform_driver sdhci_st_driver = {
 	.probe = sdhci_st_probe,
-	.remove = sdhci_st_remove,
+	.remove_new = sdhci_st_remove,
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

