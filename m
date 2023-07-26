Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFA762A19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGZELJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGZEKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:10:13 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20726.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::726])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25B2706;
        Tue, 25 Jul 2023 21:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClzoBSL9brjrcUt4PccevHiac55DZ1/sKNIeZWjrbJr8xEgM+ajbxRmSZ3ccKbHOD128mh/VRVu8oPp5ZY+9RBdO7bvETU5VPx87UWPs6rW3lMQX9fkmaDtIjLtleUofm4aNTIW7ltT5U3NCILp2Ri9jMiOgZMAPDaa1OmbQMkHsXBEtvxNDZDerIarD70HrPJHLLQ2rxG9NFHvSz72jq1IZf9iuchazNuIp8N9McHIeQYLUPDxt0e3lSfIJXDDhr557q6GIGye0vcR/ZFgQW0eTaOPaNYKIpRU6cMR9awHr83Z5TEhj2ad8TyJI+9xOdBRzuGMVooBJnTmxdjBGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=QuCueWqNKCcn1oVIn3P1EvkMwydnH3t7wthN644aq9yab0AKxcc0Hg2w++XqHwbFmrbIbKplGxRgjVsaru3uiontP62uTveEkBBnACEi17m2YdcM+ukFIpJ+KozEXsRhfbEg0+rRBY0sI/8IZcqQOKPQnKgrM5sKcnoFHU+g5mJ8rt0LMzkHN8+vkucqTknjsdpcLqfMQM1OcGZ4OAdq2Ip58nt4ebQGgGy2qpgORuBYJk0mrkeanZRsQL5Ug3T0JLDyS5kKhUS5h9nffc+JcmOwYq80vWOaM3Pt2ZWzJhIW/56M0SkFwOktCRvahvWt2GRRTD1IOxEKO3QAlvKkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbvoRarTmihEE9SfYnfLmCP64NcG9T0qKBlCHawhwDE=;
 b=X+QYr1rwFc0DhiO58whUOCKExCTX1vAhVe6Xndglb2Vw8kkKMueFiUwWYi3fgJmCIqFM25HcZm7zbJTdS0skY9CH5nOvcoyYkJXnKlbBWbdLKTMhaQJAe4CYaYKEUIXhxWXynEGkFFYDryRhcVr7SW/jM8e6dBlhjcyxK0TMj/KlY7ACjOyK30Dj5aW4rVm2NOqhnSZKpTGg8ma8iUyU20Dgh7nS279tbYDYFe75Sj2h+6cms7Mf7xBux3dmpWlkOI1G36SU8yCk7pKGEfiuR9vj5d+rk5POQqvoH5ub8FcZmG2Nl6bKdhV8VmNUaFyBprohdxhuYl7CmokAaZiNFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 56/61] mmc: pwrseq: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:36 +0800
Message-Id: <20230726040041.26267-56-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 255304e8-317e-4ac9-0665-08db8d8d2471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDuo4RgKKkmlz4DpeqahPkRKYddJwsJ8XM4dWjwXqNv1KsgpA6aGgn9y5wtc8hb80cY6S1srGYCqEFD/pa7c+GSgLxU80XpTnASgjDl2GyJamXM/Xprur+2I5GZlEN9efMb43eEZD21W5FoblBDYEZCrDWa+pFgmHbeMWPpEty+az2J7rDSUNvQNyT5eA/J7kh9Dsmtj36CV28U6qIChfBlaj+xMDWX43B4/VmMUSsctxgjHYo/JNb0g1uMBAeUtNNLvMjlwXS+3Ck5QOBeeaB6/kPk74QEiI0SKCJx/ceL+zApYD2i6hG8aNgrA/6QG3fBpoYH0XDQ0OrGFmWD1O5xGH3RwzczuI47AGBBcbaNFX5/2iy8ojRNyXKptu2YcUIGEmrXQ/LO9VEYc7ys4yYNvscHU8grymsNm3j4MPjg+zCa2vqXGfE4mZi86QFOsW9pL7HJvlF2dJrlRy1WszH+6lsA8JwXX3/nnECV4TkVzllzFETWtavv1WribtcJ8BZJv0sTSzWJdlMODIFcJ1FO7bfjUnv02hnM9gAPWmvS/O2vwKVzF4iR9ojkJUfnvRGxmYp/NOGmBXfoSnqggIX9ZNvC5lYuDIycdNQmm+rWA5mx71dzbo5N3Zpe+ZlBw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdnQk5GTy9tTmRUM2VlR3BCTWg4YStFRGlweWtCV1puZjVSK1ZCeVNDUmc4?=
 =?utf-8?B?ak0wbXVCeWtzdnQzbFo3OFRpbFV1aTVLdWR4MWV3KzJJWGxvNVRzbXF4Tm1U?=
 =?utf-8?B?QlE4ems5NWZ3L0ZyenJDNEFzWVAycXBLbXpLb0FaQkRCNnBuRnNQSmxBK3Fl?=
 =?utf-8?B?ZHBLUStiS0RGa3UrMmFaSnl5MmlIT0NtQXhXV3BvZnI5NUVqRUtJWnhQNFBG?=
 =?utf-8?B?SHJtdXZaOUFJWkEvU1l1THEyUFJFa0tZMmp3eGxGZjBGeFR4MDVEOTkxZ3ll?=
 =?utf-8?B?aTlJR2M0NkxPY2lCRHdsUEdONHhIZ1BudWNFbU1yTHBRWE1YMWhkeUtqcmpT?=
 =?utf-8?B?L3RFZW0yc293UlpiTE5mTXp0QlFiWFg0dDNsQ3BqNkNLRzRUUVN6TVlmUHBo?=
 =?utf-8?B?QkhuTEE3RHpPNGgvYkZWNEFRekZ2aHhwQzJ0VkhMbmVkT0tydlhCenlBcFVV?=
 =?utf-8?B?ZklPSGZXVVFZQ29YV0JVaG5mUmFSN21vdklVRGQxRS94VlR6UG41NGNKalJt?=
 =?utf-8?B?MkJLeUJCbHk2ZnBWeDJSQ2RzNHd5SG5iWUZPelBRYmJZeVJoY25UQnJHak5P?=
 =?utf-8?B?WVJmOG9lT2NCcDV2OVN0UWNsdU9mVkJTdmJ0eTIySUxIQkw2emFkQTdlSUtP?=
 =?utf-8?B?MEV0Q2x6T3dTNVVsR0lseUNTYm1OOGQ0YkRyV09XTnNoUnBLcHBDYTRSdzdL?=
 =?utf-8?B?S2ZjYnB0NERhY3hYM24yek5ab3ExSUJZbWRJSzVKcFgzeE9PVFpJQmUyME9B?=
 =?utf-8?B?V3VrS2ZPM2svR0ZUalhMQUcvb2g0eHBxQ3FqMnhHbkFWWGZJcUJnT3V5bWVo?=
 =?utf-8?B?SEwrK2YwU1BhZVJGdmNYbnFXZDVuU3o3VlRhZ2t6Y2xmR3JkUEoyZFpGN0Fi?=
 =?utf-8?B?OFFBTytONXQ2anVMZmhiN0VPL3llelNHYzlFbkt0aWw3VEdDVlRjVE9VOEc0?=
 =?utf-8?B?YmkrSUVGdmltdkJtem9pWW9DNUpDT3lsZ2hHaGpiOVZKWDErZCs2S1NrTThS?=
 =?utf-8?B?WHhaU2YzUFEvNldJbEVQSmxacFJVS1M0SEZSYnF3TEFHSFpEZzlNUC8xUkJZ?=
 =?utf-8?B?bWlTblBtK3BOMDRhaXNHcDRHdVVUaDRyN0FUWXBvSTZndWVpWXlJY1RvbWd2?=
 =?utf-8?B?RkZ1ZXJnS3c1UUdkeit0S3l1V0xNN3c5OGJpa0ZuNEdjbE11K3BrSXVTWEt4?=
 =?utf-8?B?eU5LWWgvdjlRbjdoS3d6MFNjcDNJWWdLNUxuaUp3WXZaRlhxeXpnRU9LUk16?=
 =?utf-8?B?aTZ2UU9JcHJoekk3K2t2ZkgvUEtJUUpBci9uNHBZdHY1M2xWTk93L1BjZjN3?=
 =?utf-8?B?MXJTejZLRzBlTnRLQjhZZmUvd0hsbG1LRkhNcVdvbVZLQ2lhSGFlZFNOckhK?=
 =?utf-8?B?a09wMUFoL3d2UnBTUzF1QVRqVjg2QVIyUm42MWo5K0FjSDNGbTh6VWZ3ZTA0?=
 =?utf-8?B?RzIrWStndEs5UkIyd2Y1SzdwUWI3L3RneUdxZ0xwbFJ4MmNyTnExak9JdGpt?=
 =?utf-8?B?UEdTTzNGNEIvNmtkT28rVE9JbEx2aXVJcUhpU2E3aWJaR1dXRXhLKzRBSXhx?=
 =?utf-8?B?bU5tMmdGVGFFUVpDcTRIQ014MmhHNUtuSDdaOVlUVjIxdmUzc0ROZGd4d2wr?=
 =?utf-8?B?N3lYbnJPTG5saXFscC8rSDZ3MU9rYWk1dlprWHBOejg3T3ZqNkE1M2dLWFBt?=
 =?utf-8?B?a0xwTzc4eXFtSklzNXJDS1JPcGU5Vm1wcU4rL0xHbWJ0MldzRm84RE96cTZI?=
 =?utf-8?B?U244MDNPMmx5bnVOaWMyaGlWVTBpdUNBTkpZeG50VC9zYTY3U2tJTWNYdWVI?=
 =?utf-8?B?dFZ6S3ZyQ2ludTYrYXdJQ2szZkpwV3JFZ1NHK0grR0xMblMrUlJHdmtXK0h2?=
 =?utf-8?B?ZE00Y2N1dUlCYmlOS21tTVRRenAzZEcvUXhRTExaaENQT3hkZ3FUMEIwdGZu?=
 =?utf-8?B?UTIvRE1rSHFxRXJNOEU2ZUtlZjhFOEs1S0Q5b01BbEFIdFFFcmhzTXZjTFln?=
 =?utf-8?B?WC9lbU4wUi9NMmo3RHZ5YUZyNlVUTHhscElhWnZwUUt1ckhIcFBsL3pHV1hG?=
 =?utf-8?B?bXc5c3BaenVHUlVMQVZlUENtV0VjTmx1YjV0VFJ0aFVoTzRBRGROK0ZEY1hu?=
 =?utf-8?Q?2SpCIwxXqAHNmfW+9zrwqbOH3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255304e8-317e-4ac9-0665-08db8d8d2471
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:34.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rSQuygig4aqXYqv+R4AvGmDGqrURJVVwSuEQTSc5LaHpYELzGfZKP3773E1Lk3n4FMV8S/5hHCe0CEndPk17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
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
 drivers/mmc/core/pwrseq_emmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index f6dde9edd7a3..3b6d69cefb4e 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -90,14 +90,12 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
+static void mmc_pwrseq_emmc_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_emmc *pwrseq = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static const struct of_device_id mmc_pwrseq_emmc_of_match[] = {
@@ -109,7 +107,7 @@ MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
 
 static struct platform_driver mmc_pwrseq_emmc_driver = {
 	.probe = mmc_pwrseq_emmc_probe,
-	.remove = mmc_pwrseq_emmc_remove,
+	.remove_new = mmc_pwrseq_emmc_remove,
 	.driver = {
 		.name = "pwrseq_emmc",
 		.of_match_table = mmc_pwrseq_emmc_of_match,
-- 
2.39.0

