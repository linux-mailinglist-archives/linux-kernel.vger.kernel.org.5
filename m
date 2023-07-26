Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1A7629BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGZEBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGZEBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E8C26A6;
        Tue, 25 Jul 2023 21:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIZNJ2dmw1kuwuXxsa/wsxWmteNuj1oA435azdHPwkdUp46zcf4YeXosHmwNmCtIVW69UEjEr6sU05q+rkGJLQNagyha53EmWxUNh5H4ASvDLonhDrknfbXQ/cMAq3YLeEyNboe7bqMjPgtetHjJ0tDFXsF6MfdGjxFTyg5QMtAOsGWri2M1PIsrxRfSHND5KzIE8QnjXwW6mltyVwQ5naUgm/s5d9uVUQJRMZofiQODjWPQ3O0VDc+nenO5Op3r9wNb1VrZE5JxWqBzUo4ceofJbGHVx9XV4ltFzarD+1jUmZ9gOZeGrKdeq2+N1bkn9g+SQFHZdIfDLj/8C0J1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PMUwGYkEKhi1gyynW+rXvAujgXDga934Imb0yL8Frc=;
 b=A0Str+HIRj1Ju405oRMRbeE/fFh5eHZ0Cc9CoKw6FXr9rvBm+DlQLtgdbN0kV6H7QaD47xOlxpIVA+yHqUoQAmWIpbnx2awt1976r2Yw5HKCocMMdfJwN5akhVeHnk14DO0I+0oFxkfaesp9BPi3DSpmxb4jTfKdcI1ong63VnH9lNJvdvXg9cFiuvt4k7uhdH67kltO51zBr0uI2ndnEN+fOwlpfHFlrEIwTrUWrpomh0YHT93t9D4XJNYG1hljUUkBVoclbTkJnluwiNA0ckV3Bsyb0hiZlLUFXMqpJ5wUtR1sy4szawl0ILU5YmrXGQg/genEiKEHQqDs4oODew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PMUwGYkEKhi1gyynW+rXvAujgXDga934Imb0yL8Frc=;
 b=pQB+MZ/hUNndkc0XceidJ8s5uhNTr7KbDSYxvS/iUlwtLqwQoU61F7vIxKOaJ7WyIahZSIIsFYBza0vuffcadysU/VhLDxJ4uZ1l+zYzrvU+Q7Pv3hff6e7EU804KGhSUFCi3y+GIx8XbaihBkrMFzTkuojHbvdZnBqy3TZ9yYYBrQUe4cyXEJTcN/C4gzRMOdVnzAwmbOxeWjcJomFV8iyPmpMpN5iou73IFqsxakX4PggpBQb8OubEy+EFLV3uxEULvYaeRexGpdWOrjbuZWPNzxVUZ+x51qUuPYivI8W/RNTOCs/m5u7JZbJMOWGenZLHuFmj7em7N9U008S45Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 05/61] mmc: mtk-sd: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:45 +0800
Message-Id: <20230726040041.26267-5-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d643e5c-2e1d-401c-85a2-08db8d8cefc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaOqApf+ukmv648gwx0JxCMO0Yh/BL5daVNCa3kOr/LUviSCceKs+V86zPSkOvbs5XHtEWnnO7lOoIQjmjUJtZorF20BngoE96i2qdfUZhIFx8mdwOAPQU4mClRRuC1kpGuedg14oLlcSkOu9Vm0njuodtcsg7RaMQ1pUg5rJTT5epcBDi9OIvZ1cjBdWoh/ZTV4LiNcgL1M88Eai8F8YZbKJeGumtxIDeMFuhh9OF7A9Z69YcrmFRKLJdJknpiVc129Yg0aSgQl7Fe3xNN8nndr6GDpFSaKf6dGfNG5JLD6UAtvn0X2KIjWnETh3PegQAdtwU3OSB1tzZ7euOzGdq/1TgUYXK74ki5ZPYQ6ptzW6e6xzc6uFKTgGIzDgRhwxje0tNYC2lGIK6cmOIByYF/z4tw9B9YRNkF5GWN7T4M/hpMN/Q27K3DL0nDvMuVbuNddtpeikS48RVukB8J0oZkt69qEmPC/5bG6/K6oavi4R6XprR3GQHovOWjOmiExAvpi1D3XBea7Lawkb/hxilt1dfyxK90uv+o19KRaElkRpwoyFQTCT/WPd+a1O14CeJjiFHE5ePWjCU3sb1zAckqlkkZHK7WlvZjO8RUUUtOojHQeGeZpSX+j8KaNbSPC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Q0TDRkRkR4OWszQVVMMGYyazFLemlsMlJRZ3R1RXUvNXdTdDVaUzhqM0Jw?=
 =?utf-8?B?ay9aOG5VREx5WU5Nckp0aTV5bGw4dmJCQW5iUzBZcGdOSldGSkNBZkxxM2FY?=
 =?utf-8?B?ckFMeDY1UE84U0VEVlJST2dYRXMrSlIrS3lybkhiTEVJTVpPaFpGVlR6UHJG?=
 =?utf-8?B?d2xoRTUwbnEwODUzdGhZSlhKUCtPYlFFbmR4VGkyRmY1WU8zdnRSdUR1N25j?=
 =?utf-8?B?V0k1cUVobWpDUnQzTWZYWmxlWmNGb3EzY0FVcVRjQ3VGMGI4ZkpScksrQzRP?=
 =?utf-8?B?S2tDdU1SSVc3NTBVQWp0L1E4Rkt5QjhZa0JNOXZzR2VvWVExbS9scnZhTm14?=
 =?utf-8?B?Y3JLekhGVE5UZzJvSHdRZHllVkJUNnlBVTJ2VXczWnBhd29hTll5RnFzdnlU?=
 =?utf-8?B?VGw2Qi8xSXNrdjRZZkdwWnFMSnZMcCtwa1FaUEpCNk1PaE5FckpCbXNJVC9P?=
 =?utf-8?B?a2lKTFVZRHdJemJTTnpTR2hWR1o3d0dsVWRlNVNTMnhUdnQ0SXRXenN2bnFY?=
 =?utf-8?B?VWQ3aHU3SUo1ZUFySktWT293cHZ3S2xwdDJjdDZvK0Z3cTRtdFZoWWpXcThj?=
 =?utf-8?B?dk9XVWhQMmh0cHlFbTZQZXVXWGxLdTlmczNsVFVIRzNFWWpLc0NvSDFPZGE5?=
 =?utf-8?B?ZHZtR2lPbTZ0bmFxM1UrNWZNZ1U3VnVFdFBmdUNKOXgwODkwdFBvSEc1UWV2?=
 =?utf-8?B?Y0tzZXpqbHJRSVo3NFNrQUdpSnBBNVkvNFpZeTZiTU0wTmpPRkhRQ1ZpNStG?=
 =?utf-8?B?YURwSnZXQ2s0MG1WdVM1eERBUHpjS1B2LzlEQWJaYXI0ejN3RmN2UnlmRkFW?=
 =?utf-8?B?M3RJM1JOQWxaWVlmbWNZWUU3MmRqSTZGVmIrY2ZHdnp3MG9SNUhwa1BpNytZ?=
 =?utf-8?B?S05wZEdaOVlObHAyYkFmdHo2TnZvTndqZUNHbnphdmp3ckVieVBEbDN2UUJ0?=
 =?utf-8?B?VXZ6WkdablhyV2RNTXRTekFzdnkzd0ZGKzNYRGs5azJGT3l0WndnRXBFSEM5?=
 =?utf-8?B?aFU2QlE1TEJtN2tlY1ZwRERtWllaVVBQTEdtV0pwRkg3eEJ2bEEwMjVqODBn?=
 =?utf-8?B?OE1NblIxeTlNc0JPK0l1cUg2TFJwSUR1RzBOYzlDZVgxTWFBS1B6K1ZxN05r?=
 =?utf-8?B?bDBJL01wMVBpUTk5VEh6Nk45MlBxdlAyRU8xTzNEMXZKSDJhY3M3aFZ3Qkkr?=
 =?utf-8?B?M1M1MkVrTXQvSXl1YkU0TmhzV1VTaEF1cDFpeU1tSWtYSStINU03QjBISzlX?=
 =?utf-8?B?cnc4Zk9rK0pDK2NvVFIvRDlqZ21HdnBkc2syQW56VC9NTzNJQkNRdDBrQlBU?=
 =?utf-8?B?dWRhQ2dYTGp3aWpudzhEUTkvVWF4T2UvVzhGM2t1QlVZM0R6clU0Tm1ManBI?=
 =?utf-8?B?aEh6TkIxK21Zc29WY0RWZ2NpdGozUmJuR2t6TGxabncwNStSd3pKUDA5cGxW?=
 =?utf-8?B?OEhZOWhDVzJmSkdlN1NqZ0krbHN3Q2xZQTVwY0VTOUZjc3V2YjR3UldaaEc2?=
 =?utf-8?B?VENremFmMXNXZzk5U0VxeWNXOEtKLzg5Tk4wUzdEVERCbDVtYXZLK0dJNXB0?=
 =?utf-8?B?R1l3eEVobEtpM0JpSUhMdEk2OTRTM1FmSnZpalVnSnkyckw4ODBPZW1qTFhV?=
 =?utf-8?B?eFhBaDByc3luZ01vVGVVTWcvbmQwTXdEclZDcTFyN1FkdVdjL2tjRE81cEQw?=
 =?utf-8?B?YmpNOXNCYUREQzBOV0NXcDJ0OGpaWHo1N20raFNHMW00emdXK05NenRDdjRp?=
 =?utf-8?B?bmczYmJRSDFUT1ZBZ0dYU2RGOC9vb1hzM2JhNlJUMWhNR1NESkNldllsMVk4?=
 =?utf-8?B?eXVISWFRcXFpNW42dm9VZjdqRVgrdjNmUXpqUmNPMVBWWXRweUlzZTdMYzc3?=
 =?utf-8?B?QUtITnAzKzl5Y2tRWWM4S3d5aFdFZFV3dk1va2RLVzFDc2hESi92dmJleFBJ?=
 =?utf-8?B?SGZQWGp0aU15eTJzU1I5cTJRWHJLaENSYU9YWG9OY0RPRW5ZYTZnL0RzK0Fi?=
 =?utf-8?B?emd5bHNZWk1RK3JWd2JZa0IzY3ExUUtFdnhrVm4yVzBMZDZ6T3VxeEFKVVhv?=
 =?utf-8?B?WDNhbGdoT2h3QnFOQnlDVk1TRDlGVDl2WHlmUmxzUlBJQWlqcjJLaDNtMUNw?=
 =?utf-8?Q?n2e1RW3gEOmgMYngDMw8GEB/6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d643e5c-2e1d-401c-85a2-08db8d8cefc6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:06.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBKvOtL1ahBw1U8E2FSAEu4ZeyAnIikVrqxYA6VSG2+YPWbzb8TuKLq4foqcTY2jn4uDOJaO1EB/3oQOEyYJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/mtk-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 02403ff99e0d..9e2debd1edbe 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2887,7 +2887,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int msdc_drv_remove(struct platform_device *pdev)
+static void msdc_drv_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct msdc_host *host;
@@ -2911,8 +2911,6 @@ static int msdc_drv_remove(struct platform_device *pdev)
 			host->dma.bd, host->dma.bd_addr);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static void msdc_save_reg(struct msdc_host *host)
@@ -3054,7 +3052,7 @@ static const struct dev_pm_ops msdc_dev_pm_ops = {
 
 static struct platform_driver mt_msdc_driver = {
 	.probe = msdc_drv_probe,
-	.remove = msdc_drv_remove,
+	.remove_new = msdc_drv_remove,
 	.driver = {
 		.name = "mtk-msdc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

