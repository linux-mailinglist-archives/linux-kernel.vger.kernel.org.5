Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B65E7647E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjG0HIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjG0HHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274D46B5;
        Thu, 27 Jul 2023 00:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSo21CR5AlwULRAEZqEqRvnWqYN/jjVIrz1EC4bkQ9LX9IumEkEZe9gqfjIm//oXpbYz25u94rSHyQHmOd49vg1ApmS7zJyhj89N7xif26qGzeix+OmybkAqs+F8NPBx9UrGnBUF40F47f44HxNz7t0VF1VZ6y1iqRhZLGBGTyAzB/iIrQK4xem0IDJBXcNkIyA7fKs5FKrYavN7LF5hEY4o8m9zn5zdy8hda4bMWxc1fROMAikunX9m7Kn2pogptIj5Ec3LtuWOeSZc1Q5XylMHOZd04EQZiI/wcl2e8oghy8KiqRi5San+JLe7AEI10pnfsMPw+KgbRAYw/WmzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZwO81R7bbiuI82gPcvzCcJYy8CKX1m7kW4A8ZR89No=;
 b=f+UPPuPXa5j5gpzH7qOC03G9I9TmtPnpIBRtWfBcLZ1XWg8r8JRT3Nkr1DpLELRJb1Tg5IMouNUr6U/qdKcagmI25SouqyUYhJMh7WfpO4Iv5w4aeaj5TRSskagSQimONNfoglB88hl6Eg1iTRImGm8QgBj7xsuDQicBwsWGmCKEYr6bW+yjJtlDNbv245knJY9sp0VQPliQr1HchAFSP+5+wsxT90XbEMn0wpTeFvZH1Ge9qn4RwO3PM36LuBqoktn3cZHtAVJui4SRIkQiJtBMAjzBofEGVuIHv3mMpSTMstGr+SHITRprQLn0hVITRYrahRxqGmZ/guHnGJhJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZwO81R7bbiuI82gPcvzCcJYy8CKX1m7kW4A8ZR89No=;
 b=FD8UFZ5zDBlXxHNCtRjSnJ+gwjt5dBMhdBWvqFTd2HddBiYl07qsxEK41Xhg94RS6aMyTX1uvVvZkAa8A5cVywFxe+UR7AzhAX4qr4KoAcvvkEg1t92EbRF//a6tBrFPYDAAPJ6DesePz2/aT9/MNzhk2k75qZlZaDJMxg8z3aYLiVvto2sCbrSikNDFVYTkRuAWpxXZHFN/6Au1u/zCtalNEhzVxUptZFNHDkn8fQkautjTsCF2Gk6Lo+QLZrHyH3eSiRBVfp6IDa9DDfEdOa7IpS0hsTk2SdJo0bz4QmWkRF3+NfJZ6wOOwcV86wsuYMqoAvAuvXJq4fcjLDvGHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 44/62] mmc: usdhi60rol0: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:33 +0800
Message-Id: <20230727070051.17778-44-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: c3406dac-92c7-4466-d930-08db8e6f69c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KmkX6ocoWZ/CZmsyss8aWNQuFyKgjbUpQ/KgCwIpHhVVUIcvsYN+lHSKSWmIIqWmb3bu7WoxEJ48jtjSMlGXGpTAGQx3cJVkYbMlglCVmwewyqOdKW9nwlPyGnSr2eVHGS1mDcl3F7aPFg0c9MvGeBUYsuaF5FE0+5UNsgwtmQ7NXa4egIrCrhlaRuYkTdcLPudMVin4Pijh0G/1WoO2WGYqZ12x7s6+JI1M/7Q9K0cN4Bd11H8276YbAWUzgnJA+jc9HJy9PTIjbzIfZ1mTLu4M5CDq2uQ+5IHYX1jVIJCa74YQ2qKzJqtsi+1otMFmLM3/rIN4DEnx4RtFwsMW1KX2+LZkYfDIHXZguI8diHbb7vUAnSqAxxlsXquWcnMqbcLWk45ZI8r/vrbav5vHCil+G9Qz7OqqP6VGzxutvpmEWpunkBdh4GC/wpOV9dAURG26wqaKBjJpeL9Tq/fjiLrSLEHWqZ+VY70syeZxxKEVLjMTKpFWyNzfSCbNeApgYM6LrorwWqChPnpYvCNTihW3kFhgLjYxObmkdGZE7kWB5mDkLlFhELXsX64xJibWSctgbLbzeNOMMwVhv6kZPaJ55MaRAdpQn89xohx9kI3VrUX9fNRGBaQ78neSoke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9yL3R6NE0vYVIxRlg2YmF2QkZlV2NJcFVPSUs5RE1oWGc4dmx0TW5nSWtx?=
 =?utf-8?B?MngvdXVkdXovZVB0bWtDZlp4Y0NVTnB0eTExUXdZaEwzRmRZNzZudUZiblNR?=
 =?utf-8?B?cHpsTVNwdXdmRS9UMlJFUFBaLzZvU1MwUWFlZ0VhNkxVd3RCeDhWeTdCTUpx?=
 =?utf-8?B?SHBsWCtLdi92bzljN01tSTc0SUd2d2lHOTNzaXEzMTZEL0pQcGtBdlZXYS8x?=
 =?utf-8?B?ME9RNEhReTZVNmVFT2MvUTVhWllwVkxQSktUYUdlNXNQNjR2SjMvS1ZKamFQ?=
 =?utf-8?B?dUYwL0dQanRhOXlvRlpiM1pxK2g1Nm51QnBYTWFCbEtxcnNHTTBIVjZGeTJ5?=
 =?utf-8?B?MVJUbnBIdW1mMGdUaml1cmhPTVpZdjNZYW9VYWFnMWE1Y0pmUTdVOE9lVjl4?=
 =?utf-8?B?OUtZeUdKcDJRMDU4V1pTbDBRbnVLSk00NE44WDBoeTl2L3AzNG40anlqajJD?=
 =?utf-8?B?T1U5NWM4SzlNRXpQTXBpTUNZdlRPYmpwU295L2M2MXBOS1pVbmJuNlUxNzVj?=
 =?utf-8?B?Sms4Y0VseFZrUmRVRzJFb2ZvcEdxWmJZRE9IWDV3L1ZDL3VxR00yWW1RbDFH?=
 =?utf-8?B?K1lSYTRuMDZYVmgwMjBaa1ZyVm9MY1pVdlQyVUg3VDVzaWhuOEZRbVFoeStE?=
 =?utf-8?B?bHlFSjNHRzNBcFZOekN3UDBzdUZtWDVuTzZzTzFpU2lZZDh4RjFabHJ4dkds?=
 =?utf-8?B?K2JaYXZwbnFwQ0NtNnJCQmZ0am9nTENIcHF1azNaQklybUxweXBHUlNnUGdq?=
 =?utf-8?B?bGNZQ3RYcWQ3TE9hR1RmOTRWbXdZRks1V3ZuWFZUNGFQMDI3eXcxUDNObEQ3?=
 =?utf-8?B?RXAyb0R3NHM4N0VZc3kvM1BxZnhCdWphV21CVlZ0aUF3YkVXdmw2azRseTVs?=
 =?utf-8?B?Mi9IbEZQaENYM2hsT3V1TGM4VGlMdnJQN2N4UWRvc29ZNnl0RGs0T1RGYmpM?=
 =?utf-8?B?K1JaQlIrdWJMVHM5Ykg3ZzQ4RUgyS2tKV1FoS2JuSjNIN1IzTGVhZ3Y0REFo?=
 =?utf-8?B?M1JiTWYydjhRazRlWTkvRmpTOGRiRHplajVDM0ZodCtFRFZsc0tuZ1BQbFJt?=
 =?utf-8?B?WUhQdUVJZUZGb1A2VFg1YWRkV3ltL1VOb2oxMklTbVZWOCtvSEFUSGJVVnB0?=
 =?utf-8?B?djhZbi9lREIxWWdSd1ZmbVN0Tlo1TzZtbWMxTlhrMDd1aVdOSTdFZTdtSlBn?=
 =?utf-8?B?UXNKTWtiZWZ1c2lLaGR6SkNnODhXK2d4T1pVcjlXT1M0bW1SSEpHYzRwTVJK?=
 =?utf-8?B?dUpYelNMRGZ0YUxwSmZ6eC9hQVUzQlJiQUtyeXpFS0JRbGdWbUMzYkMzVnA3?=
 =?utf-8?B?bytRYU5Mdm1RdE9HaCsxdVpZc1NQR0NvODhiNnBSMWlLdCtpTHpEQzZVVGJ3?=
 =?utf-8?B?ejRmK3RHZWUyL045Q2UxcHhpZXRNZ1hFSytYRk1VUlRxQzVtQ2pvaDdpRmhq?=
 =?utf-8?B?Wm5pY3lIN0xJWU51a1ltdFBONExxM3R4Z290RW9pUWtoTlZ6RXlGbnIvYlZX?=
 =?utf-8?B?UVVDL2pBS0dxTHY0cnhhNmRmQVM2R2NsN0ZHTkxtVFBya1BrL3ZwbmkyeDF1?=
 =?utf-8?B?MXdOUlluZDlJRFVlcVhkMXNaOE4ybVo2aWUwYzBiV1pPbzFEYkQvbHBOL1NM?=
 =?utf-8?B?cEhpVnBwK0l6c01xaGJKNmQ4dWhOQ1NjeWcvNGJJWERHVHNKZWxsL08rU1p4?=
 =?utf-8?B?cXY1bnJJa3RMZzBaMlYyTjB2R2tsK1hLY1d3ci9oTEQ2Vkp5d2VXemNGWlhu?=
 =?utf-8?B?MHlxak1pd2toSjFRMDVVN3dUQXNyZlBVclFOR1F1d3NuYzRUekhHRWdlL0lu?=
 =?utf-8?B?OUIwbTVuRStiOXNYMkNJYSthM2o1aUtkeWRFUEFXN2RPVHlNVTR0b0QremxM?=
 =?utf-8?B?N3hlU1M2STJBVzl3UndJZUE2K2kzcElhTVE4S1NYekVIVnVLeWJLVUNveGRX?=
 =?utf-8?B?U1F5cWdXVkwrZUxaT0JZcDVpd1djelNOTWRGemRSYXFhaXZlVDYyNzZiaXFJ?=
 =?utf-8?B?WmlNRVVtTWxjcUVFT3NBbkdONzNEVkpYZVJTR3dMZHhMV1d1MGJSWU13NGdK?=
 =?utf-8?B?MHlGNE5kZWNQdlpaOWFHNDBSRklOajNQTmFRUmV1Z1dIaDMvZmMwT1YzdFZz?=
 =?utf-8?Q?hW7n50mY6HsvHREu6mNJ+7QU+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3406dac-92c7-4466-d930-08db8e6f69c4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:17.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPQB0WRFxiwTMHpy8f3oOjINW/ue11XvsYRtbKFOc0ISuDQaaJWSI58tN4gcsAZx3fH0Tz5r0AyhG/HNH79BSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 2e17903658fc..6e421445d56c 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1884,7 +1884,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int usdhi6_remove(struct platform_device *pdev)
+static void usdhi6_remove(struct platform_device *pdev)
 {
 	struct usdhi6_host *host = platform_get_drvdata(pdev);
 
@@ -1895,13 +1895,11 @@ static int usdhi6_remove(struct platform_device *pdev)
 	usdhi6_dma_release(host);
 	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static struct platform_driver usdhi6_driver = {
 	.probe		= usdhi6_probe,
-	.remove		= usdhi6_remove,
+	.remove_new	= usdhi6_remove,
 	.driver		= {
 		.name	= "usdhi6rol0",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

