Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D327629FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGZEIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGZEHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:07:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA24C23;
        Tue, 25 Jul 2023 21:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddVRsjz0BTfKBE2Ot4aIDiqZLO2JnG9AfSaSGoqhSGwieRAXlptPpLdV9z1UAcvJ+BGkYChbQgI7usJdVLqOvuYa/+dM15qUV9sxbEKpbQtZD6P7siGtkZIhpyEi65RD6hy+wGnboEaIjY0MuCjipH38ck44Iq6BzwI0MEqaYcGEEUCwsj+4MPw1viUyhdcQdTMgxVrdsw2HB3fKx17LAMyW9t7+vAakgKyg1KdKw/EX4A14AsWUvaM2n9MtyxegEs6fmc6um2KPbVFDtd3cvAqHwEHYKdaNHQmf+LfiaqkgVvk4d1MB458TQ0WflAsA32bfpWlavQixvcf8F3x4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=lcGInNIn1daum7aPzhd0S+sCrJbLEWlA2pxieQ6gJQLLWQoINnoj3C6sdFoN1lEhBzNQswNT9WOixG34yg7vQG36dq46SOefsr7/76Wdhzs7o4tKdGEB4alI9SbZTauFEdQqhh2jsBpgsX1cseqWYpRbLBf8RxSf7VsXWAVT5UYdqiw2UR4DmotznhkgN4gQUNQWVUyNzBPAkibrsE3ejGDNLIT708EKO01oOuw108Y9njBWZ9HAl9DVk0Y056WsvkTj1aSVkArF6T/Haw1ZRK7PKjFDLi+mtI95z5g52TzObWZl1NrnXYwRfm87UdLb9YBzZVP+AeDodtWBiWuxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsecs0FraqEkVI69yYtZuIhcDu7CE/3dvX42vrGL9bQ=;
 b=FrovvrouhvcIgVgCtDFuShO7t35t/7dQj2XO7E57ToUMDBYENC/UHlp79lhJF30JW4mR2GapIJxFZC4+z8WNTgQh/KzIk903bNI87yN9icGNzBEu2Y/k7WQRZRcRzwXItN5ht5pCLfPFhELGECS+b5taYdXs1W5DczNgzU8LQMX9blHGVUJIMAzbZEoFCBLLqC6Cyn/FXhmmnY+4YpxCSgc35cqJwga2UoHDF5FBw5TniCmITdjf96CE9gCN7zV2Nz/hVvfeRhZPGt9eCUVW5y/7ngkC3KflBk7Pi4nXr1ILediyDM6ASohn7G2a6oTYSAt5e8dsadnbNiVRBBtBZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:28 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:28 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 43/61] mmc: owl: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:23 +0800
Message-Id: <20230726040041.26267-43-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6190c62f-deb8-4770-a388-08db8d8d180e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOb1sAtihy6ZYroe+Le6swXes4AO8x7s0EG73WlKiiqLCqYQL5+XXapIYL6+vm2XCoc4HrQUMpi7W0iuYM8kSo/x1SbwUu0nus9l8vbaOudzaPGYxEODh2Bgnp5UcnY/yNVNwmA3MvdBcfawwq0O7Adh5N+hoHgQj+rq9QVnezpeH/mMY0lF6T/+QVoMj2i0lTq2XThTktHhmoDjHodak0hxMjvY4LxrnIpEgb6bD5vAc6q+OxgN5vut0XnAz2DrjxOWVszKD7aNDPRA4ofp58BqPKITRyL1Yl4/OxlPQRo2xySFIUiuIiBNoSBZvwILm0dl35FQF0AJ5LAiN4o/3cTRHaLktS0itQNiUgaNssOSudOmXkJ66Cs/p2vDU5ZSh+skn/L0nnJfPrHpOk5OQBAmBrRCUmhlcR7nKa1nR2fzZPoblwOkpxazjaT01pqVCCsjpwjKKDIXi8m00PrceCazN1mpgz5MjFbG/vsK6gHlEPR9JWhxd8nmeDriLbg+OBNSqEjnKx9V2IdQNHkKTb4ZTpJdJmZ9rgLs3r7OdTDQJLcOmB+NsnTTut8TMaORnixeioszWH1YV3SmnTh0tjvuqiKkzru0NYdkFKbdaTRLW5+70RW85SeP95HIKFcm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRhaGRjQ0ZqSCttb1ZyRDd6ZUJaQ0IxTTlxV2FqQmVwaXNJV3RCRit4RWg3?=
 =?utf-8?B?V1BlTVlGRWtYSGVDYW13TDFUdEk1Y3czYWd6N0pab1RHOWtSalJ4aTF1MWtT?=
 =?utf-8?B?UmpuZGs5bTVCQ0IyUVc3VXBhSE56MWFPdTd1cy9vNy8vYjhwbnNEcE1sU0U2?=
 =?utf-8?B?OFFFd2daYWREQmVyNTlrQU5IRHZYZnYyaFc5VDg1RHF0eUphdklxWDNPZVIv?=
 =?utf-8?B?MmNNU0laeTFndDNTanhzOEhGZDdsOWtpYXBtR0VjYkZoMzloOUFTNTVFU2JC?=
 =?utf-8?B?M1hRR2hpSm9GZmZPOVlHUVZIRWhQTGVIVU5LclJWL1ZNRGtIbFhabzdQMlRT?=
 =?utf-8?B?UDUvcU82V2prVkI1RC9BekNmL1JQN3JteS83WFNjYVpDQ1hKcFYzemJaOTRo?=
 =?utf-8?B?aXl2OC9zTFNNeEU2eWg2OVRoN2tBZ09nTGY2WUFidjNVbDFMcG5POURnS0JY?=
 =?utf-8?B?cFlPeGVpN0JmOTFwUlBCVnlRd1lGMTgrOU9EQnFYeW9xdFRyWjBsRVBQVE1K?=
 =?utf-8?B?cmZad216eGVxSE9laDB5L3ZIR0dlV1JDTXNWQzNFV1hQb29vc01WOE4rcE9C?=
 =?utf-8?B?ZUZ6OURzUjdEUEttakpOTVZSWFh4SFpHRlZNNTdsS0dQWnVGTTdDdnNuZlZH?=
 =?utf-8?B?QXZEeTZaK1VkN2tON29taWZIbGtVYU9UaUVVMjUvWXFNRkU4dHlCU1puTVpB?=
 =?utf-8?B?dHZWdE5zRGZYQjQ5WVA2U1l6MDk2WjQ4WTNOQksvMXVPSmJ6d3dvbnk1VzFL?=
 =?utf-8?B?N3ZTU0dTemtESGhGSGVzMEFqZG9XdDR0SGdxbnIxYUZyampPMDZKTDBrN25p?=
 =?utf-8?B?bFRYcU52eVFQWFhwS2JpaWk1bGRVZHhZOVZSeUxSbUE0U01FZ1piL29KU0Rm?=
 =?utf-8?B?cEFaYTlaOEdXZHErTU45eUppWHJMUDRrOTRYbGtGeFB0dUE5Vi9ucW90L3Vz?=
 =?utf-8?B?L2lyR1hqT09MdE5ZNkpuSHJHU1pmQjU2bm5qOFJvSU1oZHgwNjh5blZWNWd2?=
 =?utf-8?B?aVVEcDNYdGY4V29mWXY3QllyeUJoVGJpb1F4QmV4T1p6dGRXa0VoVHlkbFZ0?=
 =?utf-8?B?S0hoSDQrSmpjTmdWcnB2eGlxRFo1R0NsdTl3bFUzSlRLOVlGQ0s2bGN3Qk5i?=
 =?utf-8?B?REpxL1ZadDlUdWg5WGtrNDV5anN4NFV3SWNDQTZqdUdvT3Vob3ZDSnFJWHR6?=
 =?utf-8?B?SW1vWGthZE1qNDVQWjgzNDJsak44SDU0M1UwOUFzK015VlI3Q0EwdXhkeG42?=
 =?utf-8?B?TW5xMXZPMll1MWgwQWl3WEdva3I3Njk4NkxiYXBtRy90bGk4cUhOUUdUbm40?=
 =?utf-8?B?S1NVUVVOdTNxa2lvelZncHQ2d2pLMkZVUmU2SjUzaE5pNThTNlRuZmhMaUdX?=
 =?utf-8?B?RXNFUHJVM204b2VibXhVaWxmMXU0dGdGZHFzQWZrVVcvdGVmQmc2bHlVMkly?=
 =?utf-8?B?WVB6TWVXbi9qQ2N5ekFDYlc2aWY3ckIyNjV3SURHWlRhREdtVC8vYVBMZjAr?=
 =?utf-8?B?MlRuallGZ24yRGdQVnIxNmhwNVBlQTdzdVNzVmVUb2lqcHcrV2F5MlAyWXhQ?=
 =?utf-8?B?N0xhNjhHVGJFeXdrTHBoUTJPL01wZlEwelBYK0ZuMkxVS01kVjd4YXZRNHhD?=
 =?utf-8?B?WmlhRFpiMDBZL3dYbSt6ZzBnN3VDakRNUFYxajZxSXJuRnBiTkxEWEpKc3Jt?=
 =?utf-8?B?N2ZnVzRtbTdIUTJzSWtQZ091UTJzL0paL2w0cVBsSUZOVHExVmhZNFQvMXNM?=
 =?utf-8?B?eG9sL2NnK1YrNWV1OGcyazkyUHhlaENuQmxhNnd0a1lIeFZVUXcybFQvUitD?=
 =?utf-8?B?aWNCYU8xVUFYTUc5MUZZU2pWcmd3SU91VXcvQzZPM3kyY2kzczV1Q21SNXRU?=
 =?utf-8?B?NnpyUkVNbnZDdElKbzdpWGhPL25rNmswOEFuV0pRaGMySHZzQ0lUOTluZUln?=
 =?utf-8?B?azZpZDVQZHF4TzdEOGlTblJ1TE5sd216MUJQM0laMzRZQXJBV205ZFR1dzUz?=
 =?utf-8?B?ZHNRRnVTckVGU3lpL29SNFQ4VnYzRlNXa21jbGoySzhsSHZwaU15RFkwdjdM?=
 =?utf-8?B?VzQ5b1JmdUEvRE5TYyt4Y2xRUjllckRkL0VGVFZIb1I4UTVzOW1LTkM4Qmtr?=
 =?utf-8?Q?ipxhTlwoBE4Q04CPlGkvmVCI5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6190c62f-deb8-4770-a388-08db8d8d180e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:13.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOjIQOqcszs0to6zw6eKaVi5/M4JmjfDLlN7g2ajIUtSnRpM1wVSEJFT/SSWQXi875szgsruIb2OFfaB+gufzw==
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
 drivers/mmc/host/owl-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 1bf22b08b373..a13bec42554a 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -667,7 +667,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int owl_mmc_remove(struct platform_device *pdev)
+static void owl_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host	*mmc = platform_get_drvdata(pdev);
 	struct owl_mmc_host *owl_host = mmc_priv(mmc);
@@ -676,8 +676,6 @@ static int owl_mmc_remove(struct platform_device *pdev)
 	disable_irq(owl_host->irq);
 	dma_release_channel(owl_host->dma);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id owl_mmc_of_match[] = {
@@ -693,7 +691,7 @@ static struct platform_driver owl_mmc_driver = {
 		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
-	.remove		= owl_mmc_remove,
+	.remove_new	= owl_mmc_remove,
 };
 module_platform_driver(owl_mmc_driver);
 
-- 
2.39.0

