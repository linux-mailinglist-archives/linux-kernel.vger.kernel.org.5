Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD49762A15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGZEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGZEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:09:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DCB10FD;
        Tue, 25 Jul 2023 21:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtEYlxloX5axZx4BeX3VCE5WQeJC5Ipybp16FlmIw/MbiL2c1Oo5VzTgZ8j+tjTNzawxBF7CM6xhlF9eIZVvK17cgma70H11M1kAC/swl2HtFnjZO88tThQJ61Eq9H0cfaVCnS1Jg04mIscNxfAF2YMAhpSrl/gv5+rezZEL5V332xz/P2KZB/7XEXKHoJFfx8ulqU6dB/ym1M9jdVDW6tkK8ruj3ZiBnd8GwdnH47RFAdlPFIA48GyotAtT5OnW5hqdpnVqFfpF7H3fQJ1o/NmHnxQ3A/j5isUtOzLBCbkLhsfeUlUAGr/s3wltnrRIuLaCohmvLoJMbFXZudWX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=Nr64vaYahLzjogNYX5NJOebtpnoP/kQjoeuZ3cP5XpCM5hao7rXF8RxyewqHwvWPl+oW3CUfiItUNgRwdF9iB3aUi+E/1byo2jCJRPoyFto8zcskY+W7g4VKyGIBr9vaOEO9jCFb1806+ZoukHEJqH0eYAfmdqcFF0CP3rHPMl1FGpTXyy4YKHcrUVzrwLqQbKyPIpRt0PIPbJ5rWfAC8XiuAQeg5an781W71N4jQTr23Nnu0gEsziTxPmjw2onArqU9V+Y+Qp1e4LtU+0pYnO4SnQqm+/hdWNVC7gwTdTbUW97dAwCj/KwdDbgrHIxnSJcj7nGIj//RKg7EgtL0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=htPkndb4I7o2fT/YTB77qbP6kGRXk6m33JaTBiA6itx7BD//IW5kuxRISiNArkZibAhkgq+FJhMc3h7UqBZby1g6oIfgq9PpuPT+TBFKQBh7Gr9ho8L7RP9H705TJRadN/3jrKliQPLQS7ZNx+Ee9nVosnQKTuYDrFmKaXMTxH3A57QvkTjXZxaNuNqHM9k47G4xhLpCadg9NxHHwjS7sA8eb7PEMBg9KE1P7ga6RC26IEFF8diAxNQd6qDusvyWtSEu8IUrkE+M0+e8DMoT9Krpjp+alD0BjN423qNvvZYZhWKFTShTLy++MBWEko0jbaY36xvpmAbpezGQqDJa+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Nicolas Pitre <nico@fluxnic.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 53/61] mmc: mvsdio: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:33 +0800
Message-Id: <20230726040041.26267-53-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9048407d-38c0-4672-b455-08db8d8d221a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3RgvNhkKnTKokoDxonbEs1L4gsw6ZU/kmyEaXlGCROKEqOOQ/7YI19OBgRKkLpYh9SOv3Ylnq6cOQ0Bli9uJt12dsLMiSx0eomNcJhVW/V7TerHrNrzAROGUzdYH6RnyWkoFjgATd06yy2LPwKn+hNgkwl4hHEnrzaJ89ajdii7Cz/xc1ihoT0wz0xrr5QC3d+3KrW3L1LPjRZhVqw/mSV/2AzgDcgpi+XWngVCIJLJwi6aPH3Pee46MlI+7NPl0luYmv40TNbxpkZbgQ0iLVeXjbrf+kmExByxdF2djuzHYFTDnCvyIZdwM4lEf1IzFsEc93OE3ThCnfevIiPSrJHjMNj1gPvOIsX/bdT8x18hj4b5t+CUhghYYUStXwqkLB8HosvaF6Ldi3K0i1lC3m1Bu6KYB7l66U48xveX4gdK5Xn/6+tJHfhB0zk+jcviRK8GR8DkAs4FZxdIfGNY6436sbBArg1NdxstTNmR22u6CjBv0c11om84UgYrx/VHBBMoDZuDZDsnAgg04bK9pXQ/X3nIohDJ5PzKM7Da+zd9JrfZJ6Xft0kpP5jx+4/nxk351o4S+kGS4FrPLcN+emAki3vhBL+MDITD3ykjLEsiuICZxfBeVL+AnfwtoWwJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1F1cVpTenQrbzFDUWVGNWhVVlNaQ2U0UUM3ZGJVc1FjSTh6TjU4S1MrYk9G?=
 =?utf-8?B?UjA1NHNZK0pFeittSklGeFo3akpoOVZ6T3BETmxlanQ0SWx5YzRnaWc3YlBP?=
 =?utf-8?B?THRhWms0K0h1UlhVNmFKSWpBQjNQT2VOL2U1UmhpdFdpYi95OU16RCt4dk1Z?=
 =?utf-8?B?d2FkUXdyNXBwNXVXd0VCdXpsWnBUSjVFRWViZ21JVFF4SHhsOStNWWYwYXVD?=
 =?utf-8?B?TG1KdXdBYldvRXRpeTRuYjVjMThYUEVLbFJQS0RoWHlUT0tnUXZLS0plZis2?=
 =?utf-8?B?NnY5cXYvZlpSeU9BVjR4RnRBNHlxa280YW1Edy9OZTJYZjFFblNrMG1RTzJK?=
 =?utf-8?B?SDcwcU5ueVNOYVk5S01IVGNicG8vMlhWQS9XS3Y1VGNPbkVmMnhSdURNRWEv?=
 =?utf-8?B?T0VpUTVWcUhodCswYlVXQUdwNlhVMzJXeFBWR01aMENKZVRMSDlDVWJFcGJ6?=
 =?utf-8?B?QktPbU1JTWJtWW0wOHRrNnlXdUFCeEdMNUw4Yjljcng3WEFlemJwWDNGZ0x6?=
 =?utf-8?B?bGRwcjlENW9tc21RaHh3c3VhTUkvRTdOaEx3R2ZXTFZQZTNqbnZPOFdNZUdy?=
 =?utf-8?B?OFZkZlZUT1ptYzVpMnl3ejZUZDQxRW1Qam9pelF1d24zdlJxdWgvMDZzTkF6?=
 =?utf-8?B?N0lock1rV1M2aEV5eDJXWEp4TE9vSVRtbUxNTi84RW9zL2pzcmlVUFdTK0NX?=
 =?utf-8?B?MWVsNWk5UTlVSDFmK1hyN1ExbEo4OUVzQ0I3NUU5di80YXlYYmZvRVpJWER1?=
 =?utf-8?B?RkdUbVNRL0l6M0JwTFRuRmlwdm5CY0pKUk5TTjZkd0VpRXNUODBNR21XSVVR?=
 =?utf-8?B?U3NCRmplOTJ1dzBNL1B0cTJCRHNwejNEdUh4YmdDWUsxa004T0laZisyWXds?=
 =?utf-8?B?em40ak9lT0ZrT1VNNWl0dWVNaDY5S1JndndIUENRc1VjcGZEVmhJeXk4OU5H?=
 =?utf-8?B?RVFLditiYStYeWFXdDQrVE1FSkY4QjZoam9EbHFZM0o2WTJGK2p6WGcxVzBi?=
 =?utf-8?B?R2RGOGI3NFJsejl3R2VZSkN1cFpKQUhIUk1qZVp4Wi82OG9IRVEreTdRUWtu?=
 =?utf-8?B?N0w5QmNLdEs3YUFtbmxrYjBsR0FuV0VLakdtRnE5RW5pSTdMdVZkSWpJdXpK?=
 =?utf-8?B?SlFocnlRQ2tFRXdJUStKSUZydktUTVhWQVYzSEtMdkdlSFFPQXdTREQ5REZ3?=
 =?utf-8?B?ZzZRZVAzTm00QXFvUGpiU1NBWlA2ZGlWOXZJUUY3ZTZxUys3WkE5VGt1RU11?=
 =?utf-8?B?dzVkQ2tYVjh5QUk1b0RKbmlJSzNra2R4UjZRaG9kNHFXWWFWcHpEV1NnT2Q2?=
 =?utf-8?B?bGEzaFBDeU94cUI2dWN2OGtrdWFJRWd6dEI0RUQ0b2ZJZTBoanM2ZDV3K3Iy?=
 =?utf-8?B?WlVGQ3RpWTNJSFVCd2NXTHhHRC9xdWdDeWFUTDUrUGo4N1Y0blJjTG4wZ2tr?=
 =?utf-8?B?MWRiUlFiNks3SVJNb0tURGlSWGpEaGNEK2JNZG9oTGtSdlRqUGlkV3V2Z3RT?=
 =?utf-8?B?Qkc4bzlPMlEyQU9uaGY5d0s0RDZQZFBtT1QzU216dElCZGZmNEdSeWdMeE5U?=
 =?utf-8?B?eWdMcFNCb1VTUVZUR1p3d2FnRUxOTkxPTTRrU0lCb2RJTE04YkNzc004MGZ2?=
 =?utf-8?B?MHd2MVVZTU5EUWhOdXdOenVndHIyM3FONDRzNGp5ZExIekZ2T1ZwSWd6TnJJ?=
 =?utf-8?B?TWJSZFZ6ZEx6RTB6a0FZcEdpcHFQcXlVZjhIQzQ3NW4yb1QwekZoemN3MkpW?=
 =?utf-8?B?QmdITGFzaVhhQ241by82SUdjLzExNVcyeTBZaXJjY294Rm5kZitwY1pXcjNJ?=
 =?utf-8?B?Qmh3RDlUN0lBdGQ3RVdSa0Z4c0ZReXlXanVLbTlOdXlpYThzV2ttSndQTDcr?=
 =?utf-8?B?Q0pQR0cyRFp4MEQ2dGZjVkgrVVFXN2pHYnZHbkRNaGxrZTRMUnJPa2V6VUNT?=
 =?utf-8?B?aEIydkZtRUJLSDZmbldRTDlpcGE4cDR0U0JHVzlHK1JFUXJWOC81S2xxdWZk?=
 =?utf-8?B?eTFBakJWOUtsREpXU0N3dVJ6d0lLcmh1c3ZmUm1xWEpOSWl0cDIxb29VRU9O?=
 =?utf-8?B?cmRYRFJDYVhtM3hseXZHbmR4bVJhcHR6L1VNMklMbGo1WEFCSUtrOWQyOUNn?=
 =?utf-8?Q?dWg+PsiieYnZX16rhHRYK1+Hs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9048407d-38c0-4672-b455-08db8d8d221a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:30.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15KPZ/xfyuXs1zJFJ1sTNqY02xX5JwDpN12Wf4Ji0njwk62BHHZK6FtO4yN3cF0gXYLPfc/OP3s+axp8L9BDcg==
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
 drivers/mmc/host/mvsdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index b4f6a0a2fcb5..ca01b7d204ba 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -796,7 +796,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mvsd_remove(struct platform_device *pdev)
+static void mvsd_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -809,8 +809,6 @@ static int mvsd_remove(struct platform_device *pdev)
 	if (!IS_ERR(host->clk))
 		clk_disable_unprepare(host->clk);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id mvsdio_dt_ids[] = {
@@ -821,7 +819,7 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
 	.probe		= mvsd_probe,
-	.remove		= mvsd_remove,
+	.remove_new	= mvsd_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

