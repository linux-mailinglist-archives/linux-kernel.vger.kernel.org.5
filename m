Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C8751ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjGMIKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjGMIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED4B2735;
        Thu, 13 Jul 2023 01:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRekJdXKrbUA3RkD0Ix6MV+aExOMQSGtEbcq10l2L23fIv1RmYw8it/1dk0pWzY8plMd4aHCYqq6XxqSuf4LMiROnQBISWrYSULAHiZMObPUGEdkvGM+orp30OR82ADoGK/McriiI3HwOrzowRkYfFIPOjqP6hex0ko/ICSJ6AIxX6yFu2/7uQ8HtLC586s61lgV1iuaRCnIQOuEbA/mCczfEWJQXoeuWWcj1Gc9isJVPJC/M87DcnYApUqAJC9noSDfAOo6oXYZNW6M7ree6ehSjd5ahz+e8mri747w1+bEPpoQHLSEUS6Z8vQSJtk80JAcoO7HVr18q+6ggWiIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1raQ0367OxAGgkvChHBq/pbYLsJPiLq8qCsfVZ1QcKU=;
 b=mXejBKsIyAQmOBNTR8jrpWRRrAMGGhJzMIY/UJH6mlhi1neJGuocXjLM6ylgCcacqKp0VQBNofcrqwe6U9MET0S7pc1xC9rrik29k4XzyvdqlaJczmr5oeLxPqSA4vjILuCVbBuKV+iD4quDN9GIvCbXRpTWP2mBPoDPmPfeAUNWfM+SQOJnoLl/6IG3pCqUnbey+DDXVslbxGZ2M2XjZSUB+jo6rBAODt+YQ/1yT0ML9d5IM/nhv4DbCjsiE+C3K6aOjf1EFNbgdZpvql+TSDCI+hhi8yMBP8KocwZTVHQmge2NdBnWvNDp7csNfx8lnNm+DLKI8YVsot/gUouM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1raQ0367OxAGgkvChHBq/pbYLsJPiLq8qCsfVZ1QcKU=;
 b=dU0lQsCGaYRGqVyRBTe0NLXMM8kE14a/c+xj/PP8ybdFN+CcF0dcD+nRP/KUf8AKnJeKhXGEzgJ2In5JyiaJfSVh6bLOMaFnTJxd+4dsuMDOdsDtc/wndizKioDN53oIz0+OP6JKVJu0R0SU/61nzXxXfrfUmOH5gswvru9uUxuSnl1UDTdkvrCH+OBB0cmpg/boaaxzKM+fl79tEGQkXQmrYCUKMJwVYjEDtu96owVftueuMB65UvqA5T8BQjy0pLYX6LXj95ZHa+xq6hrseRGMzP6Wlv1O6rEzS24XpiZLaY26YoqK4209sxonmepQmbOYCdY61IpjcMKf/kCA+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/58] mmc: bcm2835: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:11 +0800
Message-Id: <20230713080807.69999-2-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7305fc-47b7-4218-a401-08db837853d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbFkiwVWkoKSgF1d3khTJT2t4/Ar3T0ZJywFGBUTZqACTYpOVJJ4is/VvqJlDuFfZlIThxAmMsqe7sEndaVwkXmuY+UQ2AvFMTOY0D0COmrzwmWbAHy0xAnqxtQDIWplJTIQIt1FUKgT3NkC7YD3K+uZWjt1wpaAdaIZ3TWVbcLAtf3fESw0/7jNDh9Bc8wKNunxHabzu89nnbm4e6E6VIrH03931Yz9q1xmk2V2zdLPWwQEKfPj1y2YtE7yDXTwB80vC0r0wgeXG/wV7C5GXhfp/iclLyhNdvbnktMWCNVrtQqWLHoro9SH0TcBlmvOSrzHxf/2eqmP6Vnb5Y88V+au3CrNMXoyo9+pKFAtFbG0FDBO5Xif6fk6cWdrkapAMnfasuelREKFrhl+nd/tazBd+6QNB4+2Uffv6pSvSPE8Bz271SuORXBgOYJ3LJIkbQSvh+CVxiSNq389bm6P6qEjVdS1kVZ7h0lDShtF8qbHyawRxxN+0c9x76uX/jehHQbC2Nw4xb9/5Bh4Fr0rsIZjC1CcFBSysn7LM9TXl4LvNIPiUniX7KJbPfh5bpDgiUye+UpTi9Xcoiug2IEbD5ca3hZEPtYjxjKh7YKfHpd5qfRlewi8IcM5BTaFup0bSB62A1I6wekQcn5qP4WgNxN34Bx/LzvrPHRVNGtqYos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(7416002)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFN3cGp0Rm56cXFSUjdsWkE4a2grVkNYREtNUXdWWDJ5THJDTFAwVjlQbWVv?=
 =?utf-8?B?eGhqL2dtWUJJM3l5ZHBjaXJsRWNoNk1xSlB3THUyUlBGR0hhaUthRDcrd0pY?=
 =?utf-8?B?WksydkVJaytVNVhkV2JGRzZRUzBabDh0cmhYWVZRNTFYWlo2aVgrR0g3MldU?=
 =?utf-8?B?OW1STCtjcit1NWg2bXh0TUNMWUtHNEI3QlZwblNQWW11QkkrMGptV0lZRWQy?=
 =?utf-8?B?VXpTVldHUDBNSVFRcTROVzIvNkIrM2dsYXdMQUN3VDFOUkNWVzlVWVZEcklU?=
 =?utf-8?B?aEkweVFwWVJENUZsLzZNRmRHbVY5VENBcWpnSXdya1ZIbmtXZkREZTBtUU9w?=
 =?utf-8?B?QS9NUkR4NUg2OTNMMHZwOElacWhDTkhKQXFaSGpYR0tKenN1d0g3ZkYxV2tX?=
 =?utf-8?B?WTNkN2dwemZyS0thSlIxT0ZkSGhoTCtnQWRJWmNmTThDVUZtQ2swbHZ1eHJv?=
 =?utf-8?B?TlVoVnZpUHdkVkY0aXp4Zk9ZcWRTekYydzZUZUdJUnMweU0xZW1HejRVUmZs?=
 =?utf-8?B?K3N1d2FDYVFVU2hYMk1Hb2FSSExGTFBGVHhPOWIwVDd4V2FndGg5TXE1aGtR?=
 =?utf-8?B?OHV0NUJOTWtJVGFwNTYxdEtaVERsNHNHKzNER0RpTXRBVnJQQnBVTzVQQ0Zz?=
 =?utf-8?B?aUdBalR6d255SjNpSks3WHJzRnNUM1FBcnNhUVltTnZyQ3ZNSHcxQnRjZldq?=
 =?utf-8?B?YUNYbFljWTdaOTl4bVlnVDY0MEFmUmg2UzhubGhuUCs5WlB6MytmTVc1V2h4?=
 =?utf-8?B?SVRVWVlicUp6cVhRMktIYStJU1p3RU1jYmNhcGJSZWYxTW1jOHdDUEpnOXhm?=
 =?utf-8?B?YmZyU3g4VSsxSW0vZ2QrcEg1T2FrbEpxVWtsSkRRdjNqY0RsRHlCYUFlUXZz?=
 =?utf-8?B?N3dRamIwVXJZNmVTSlNNMGZ3eWdXVDNuRnJLR21McWVYRWRVTEZnVGRkK1Iw?=
 =?utf-8?B?MDVxaFVuNTV1bThrUk5EUGJTNmlkTmNoNHYzcG1HdVFCNk4rMG5Pa2c5WVBh?=
 =?utf-8?B?Ulg2MVlNV0x2MWgyd1l2eTc4L0ZhVUxTL2k5eEtMTjhYc2d2WUYrS0JyMTUx?=
 =?utf-8?B?ZWUxVllrTnZhL1JTN1NyM3hWZmhTSDVoemI4dmJBOFcyZ2tsVWZUMkpLVU5T?=
 =?utf-8?B?UHVSVXZNZVpNOGh2VFJRTUxieXI5aXdGays3V0ZEMmVNME5kWGloV0ptdm1o?=
 =?utf-8?B?QlZCSXYrbUVRWkNVelVtYWlUT1FqZUt4dlcxODBjbkxZaSt6bHBqVm5Iamwr?=
 =?utf-8?B?TCs0aVRwWndWMG5INkZJY3Vtdk1PSXhUYlltN0IvTU1YRzFURnN2SGcvRkRt?=
 =?utf-8?B?TjZqYXhZV00ya05wME9TYU9vekJSaDVGSk4vcFIrdklHUEQybFBwc25nZHI0?=
 =?utf-8?B?NjQ5ckhjd2FQV21xUTVsWkNmNVhhZFRzcE5CaEg4a2kxNWQ0NmprdTRuQ2Ft?=
 =?utf-8?B?eFY4MHJJK21PQWVHb08wcTlRSm83WUxZK3ZMc1BnQjRvOG41aUNhTE1ZdUVU?=
 =?utf-8?B?QkZsbk00bEZ2MDhkSHRlQk1GRlNLUUR5UXE0Y3gvUEpteFR1dGx0R0pQUzJE?=
 =?utf-8?B?TXdXRTdIbDd3SFdUTkpQcEU2TW9DTkd0QlVyNEkra0dsRzZXb3J6Yk14WllQ?=
 =?utf-8?B?OEFKc0ZEUjNLTXcrY1dMWGw3MGg0TkcyaStBRjNNQ21ENGY1ZTBQaUlZMjl1?=
 =?utf-8?B?dXp3cjYwTHNWUXNtcXgzVk4zSmRwbGJiZTJhTWhmMlE1TUx0VnhkZ0VZcXVP?=
 =?utf-8?B?Z2luNnZDSTh4RVVrQ3pmUVN1Z0o5VmRGbUZnMEtBMkJnRG5ZM281UFNCTEc3?=
 =?utf-8?B?VEtGay9jb1g0SnNmNVlDdWxGdyt4N0pkYW9CZm8rNmY2UUhKZURJckErSFlD?=
 =?utf-8?B?UUpFVU10U3lqclByZXdzZTl1c0xJOHk0T0did2drR3UrMEhMK0hIUkIxR3k1?=
 =?utf-8?B?bmNWdXZzU2kzVkhpSGVCQk0vYjB5S3ZEQnZrNWdWbUVNZURNZVJXZTA5OEln?=
 =?utf-8?B?UUFOYXJMQ3MxQm1KY2h2clpCZUpsaUg1eDV3VUJJL080RjBzSmpncENyOHhE?=
 =?utf-8?B?Z3dNenUwTXBNbkQ2WWZKVmZQZnd0eFgzZXl2ak43N0h3aXZlc2J1aDlTRk9Z?=
 =?utf-8?Q?JHjdmucpqL0n0V1JQnkYrNvtY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7305fc-47b7-4218-a401-08db837853d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:23.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qexXGbKL66gAmMci/TcD+sSOpP8kXThM5D2QoU6IMVzhJvg7pcDpijdYbjJh2fegMQ0dqC9v20wuj9lrPqgH7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
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
 drivers/mmc/host/bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index eea208856ce0..35d8fdea668b 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1431,7 +1431,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_remove(struct platform_device *pdev)
+static void bcm2835_remove(struct platform_device *pdev)
 {
 	struct bcm2835_host *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc = mmc_from_priv(host);
@@ -1449,8 +1449,6 @@ static int bcm2835_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_rxtx);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id bcm2835_match[] = {
@@ -1461,7 +1459,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_match);
 
 static struct platform_driver bcm2835_driver = {
 	.probe      = bcm2835_probe,
-	.remove     = bcm2835_remove,
+	.remove_new = bcm2835_remove,
 	.driver     = {
 		.name		= "sdhost-bcm2835",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

