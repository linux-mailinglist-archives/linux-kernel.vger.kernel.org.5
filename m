Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837B7647D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjG0HH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjG0HGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FA4216;
        Thu, 27 Jul 2023 00:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJtNqUind90S16XBXmX5DsM88OebyBK3UkTgXugCG/NyXrClNDnALRjslaV9Sh/221/i8M3hvzMJ0VE5CZGYiSba2q2MLnCtnbifrJpw64EalIWjJwO8QXVOcS95hvBg0D9MxYjgrdgw92YD+cj+lz7xGhduCQajlpJgjHe679PKd0F0YX0Cl7Dwv0fvFvodsyXre62s7SLVmbKUb2GtpakDUtuCs7eIQEcJMWHtuDUofsdIm3aqGnmUjyZMe6p7JdnGatImZwcnFBT040QjpxTiZUbp2mrCd1eXtJzCgFjoAwP6vE2AgdDCHMWB8H4CAW/vGdqMWERxV8eP8z/4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=HcaVCda5kOjsTYdmxEO31kkNRrQ8MrBQHyn/kt6f33tgBSjZANQX04swiZQ45BQhAT5K7W69BXBHxDahM7GRF9gun0RnyOgJiGdpjJLTNpRap4+0KqIu0vndIbQ8Ygjpbhujac0VDfPR3uAm3Z5KzMRJKbCDAApIYgc20TSkdSCFqUu6fJhLqF+tuo8XtiOJrhJz6G5UWjCoq0gpCf1XeBZ6x0/jSery1PVwpn584pqaRx6K2TPR8h7iS8hLFuQ6I3etkoFQfHO1s1gC1aLcHyB0p+bpBPetCfxPyJAk6uE0R0PTpLzsKIf3gzfdolRK+doSbxMWekBD7+cq3wrr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc43eVj8D+jXjv+UOKZmNNsyrS57jCHl9PeQXr9Ahyc=;
 b=S3kXDDXNkqsSUL79sO70cZxKvaSy+d1+OxhWnn5hmeIz2Wl0AF1bxE/B/IcUC+YdA69X54xzuBVOGPuNIWtVjpaOgvtlcbyfNSrO64yp/mZ1Yi/PoX5qp1gjVk4WlZ0qtF0SuDPz1Xn8+60lcqu6k6prhOF0TAyMH4glSiHxulIlXi+JazF8eTS46pJuES60TyDF/VZ7qFp+ycXU3uIy2K0m14X6YWLPHskk4Zw8usfOvwb1S3UIwIOosyWzmmndtXw6SHWB08o7uRSlI1uKeGEnEWmzwsnqScdXfjkoUzm6bxP2xWDOq83YioQ6+BWU90+JzM8zoXQNvPT12Dt+Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 43/62] mmc: wbsd: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:32 +0800
Message-Id: <20230727070051.17778-43-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49d1e544-941d-4c83-a5dc-08db8e6f689f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0k4UTof/FV7/J4v8u27VAPpxLVC+g8+ExehW/Nu9xK3nL10yvey9e/i2gncg3eP3d1L1l7FJv5hJEsJ6OUlGLoUvg659pw5MwLwCIWFRSWJ/OZbeJSVGkwRVa06j3ubtD8bnepU5zWNfAQwrlv2vLDARIm8I8du3jAlo38Kf95KrFpHtdQrNMcb9+bD/jpvJjrbWGwgvpt8oTlOjDFU+r+yQeWwrdkPdPCNNxjMyV7CzgRoHVg4HjPvKEubUzrfR8ot6ruaUjMphYP+7QG8FIoL5DZjhA9LjLyAaa/ohK+SJH0rvQ++qpBoL5ZfmoHDUuM3nJ+TLNQccuE8eiFw4y5aiS0bH6DWLHDdem+lySZWHHRZhuLjqqermgipuIIHoHI1qzyJxcRne5Z+eeqe/GJ6c3gM3t3KPQxmVcz9nnLHq5UhrC4P8Pv4yFES4GvrtWbxTWhWy+n8nwKPI068vI1yIPPkVAMdSUrvDkSPdHSTMKD4Kjeqzi3vwa1gUblo9kSBmJrwj+s8uRT1Iq5cBMSAdz37c5eT5FQ31HQZXTpHdkxf64g5npXauqU1fiz8cBZEZqkZEMhFYn4PtEwuo5xtyL1/BYQ46ZpXuOkapoLqQpFO9pxJ5aenq/uxKY3Wg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(4326008)(316002)(54906003)(66476007)(110136005)(478600001)(38100700002)(83380400001)(38350700002)(26005)(66574015)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dLOFA4MncxdUI5N2xUbzdBRUd4V3dObEkxT2NuNTRXSkFVSDQ1ZlJWQ2Jt?=
 =?utf-8?B?cE5ibmtNNy82Ym5USFhEaHpqa1dIQUFnRXIxb3I2ZnB5NmQ4TGpnZW5vSDk3?=
 =?utf-8?B?SG1GZnV6Y0VoV2taZW12Ny9OV1RtNVJONTNRZUVqbkJKRXBPSlc1ZEg3b0M2?=
 =?utf-8?B?ZXVRcHVvQTE2aTZFVEU0K0UwdlJaTGdKbzVRQWZWTzJpNFdlb0VFd2NncE53?=
 =?utf-8?B?WTVUQTM2dUJ1NUdzN3ZxV3BNU2pUN3pzdG9nb0g5UUVrZGhuSi8vTWdrRTdj?=
 =?utf-8?B?akFpOWNKNytJVFA3SitjUGtzeTlUK01zZThvT2ZDNjF6NjhDU0hVQ0JvVEN5?=
 =?utf-8?B?eUhldlhyekZCRW5Ld2tWWi9raFNhTDV4VTdBR2JJcStaZlBHcGtvVEZFU0Fz?=
 =?utf-8?B?OEdUbjFCTUNqQ29jMHhTWGJiT2ZBU09saXQ0ZytURUQ5dXNaWm02eWtHa3Fa?=
 =?utf-8?B?RmMyT2h6eDlra0RyVHlKNFdZK3FlNzg5SGhkRGoxVGpYbzR5L3B6aTZXUDhP?=
 =?utf-8?B?R05IT0Y5cjI1RU5uaUNxbCtmZmlUY29yaEpnQnBGM09NR3A2cmw5RW1oNjhv?=
 =?utf-8?B?a2g4WXh0TElFM2hzdi83QkJNSzVSZHJIbXJkMSs4eXQ2Zm9xQlg2WnhTeUJQ?=
 =?utf-8?B?K3MwR2hrazRzSE94ZzVDMnZ6K0l4MjJEQTgzYW1RSFcwK1ZrS0hoQmFCVDU3?=
 =?utf-8?B?ckVMZHNtMUpwbHdha1BRUEw0S0JGNVd2RjlaTlRtVG9VWVNmOXcxNEdUKzli?=
 =?utf-8?B?R0FrVnRaYy9aUlVORk13MXRUVGhKNEVoejZZZ0VtZzJiYlpvcTNoVmZrTm0r?=
 =?utf-8?B?VElVdXBod004d2tLWmYxbHdJRUVBM1hjZllVZlBtQ3pobE1Ra1BRY0hTdkIz?=
 =?utf-8?B?UW5nZ2lkNnUvK1hKVlBGak9pTFpkZUdnMi9vTVA3S2d5NCtaejRHckc4TkVF?=
 =?utf-8?B?ekJ4NmdWWmtDNWpFV0JQNnVsbU8xT3JlcGhWNEI1dlIvL29Idklkbm9ON3Bt?=
 =?utf-8?B?UGcvNmE1blJLbVh6a29nTU5WR1k2ZHYyN2dPbkRzRlRpQkRQSDRjWFgwWWhH?=
 =?utf-8?B?N0pmTk92Z1lWR1Q4RnlWcDJzQzA0SHZId21XeGNqRURpSTNIUnYwM0NsNk9i?=
 =?utf-8?B?MEpUOXNjN05qQnZhZTBBWVp0M09JeUJiK0MyK2svcXA3THBRVWRtcWlzV29r?=
 =?utf-8?B?aCttUHRwK0dZRmN4UWpFYzViRzBQQ0ZpV0NPVUdUQXNLMGJYOE9hZ3FhSm1Q?=
 =?utf-8?B?K0VmWVducnllSWN0V282UHd3OG1Za3N6RkUrWFh6TXRleCtXd29mWTZpcW1h?=
 =?utf-8?B?UjBoOE5Qb2ZhQ0tFRXlKRmR1dTdGRzRiS1lxcnY2SFhPajVkYUdZVFY5RkpL?=
 =?utf-8?B?TU5Yb0VqMHFkR3FnNkF1Wml1cnMydFU4Ukg1dk5aWU1XOExHRTZsTUtCOVdX?=
 =?utf-8?B?eGJ0amk2SDNpaUxLQ3ZhcDdEQ2ZhMDVmMDEvV2FMcHgvWHJCZ2RDeElwV2dR?=
 =?utf-8?B?MzZNREpEWjZpZXZxS0xYRC9DbDV5d2ZwcVBmNnMxWGlkRlZSUXczdEZyek5n?=
 =?utf-8?B?YzFicU16MDJwMzlWc2ZsdlNZZDFGWmdHeGY3aUxtSStlQzFocGNOVmpZTWNS?=
 =?utf-8?B?dHZpUitOc1Zxb2g2U3BLR25abENUc2tBVEZqMEh1Qms1T2tZd28raGQ5N3Vz?=
 =?utf-8?B?SDFjNHdVRXdIK1ZRWjF6MVl6NWRscy9pVTNUOEVSdlBsbkVuZWZlYWRoeW8x?=
 =?utf-8?B?SUg3YkwwKzAza29aQy9jL2F4OE1TR1VvRjYvaHhFcmMxZGV4emNmb3BlOTVw?=
 =?utf-8?B?YUFpakFjdkRQZmQ5K3pQSmI2ZUloK01WRWg5WTZTaXk1QndJa1N4Rjk2My9p?=
 =?utf-8?B?SEJyN2cxLzIrVTJFd2RiazZFZXJ0MVUwVjlBeks1R1FCVW12Y212SEMrblBO?=
 =?utf-8?B?MGwvK2VzS2t3Z2FINFV6TkpBU09uZFJsZDV1K21IV1ppd01CcU91N0hZaS93?=
 =?utf-8?B?NzlpTmxoNjdKWnhpVnFzbnlVZFJjSGk4U2liL0xDemNKTUxrSTB1VzBtZzY3?=
 =?utf-8?B?YSs5WGtSalBoMncvamVRK1JVZmpvKzVWMDltRStGL1UrY2orR1FwWVpCcGlp?=
 =?utf-8?Q?tAlp7eqqIlSkLHurTdmU+rEcS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d1e544-941d-4c83-a5dc-08db8e6f689f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:15.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbU8b6XzLNNYzcCd99/8B9sO5CvMZOE6gSop6bxSVMelOckqbob1R1tVYnhwtzq0azby8N7bueZDjZrWBgkndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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

