Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD48B751B55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjGMIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjGMINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DF30FA;
        Thu, 13 Jul 2023 01:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScS8WtdKxI3XA1LzSkpiF8KSotMCiVzE/hf+AhiwXbESGD5VZFoyBOECI1+dMftkCxRSiMqmNBJcE2MNOVUpgOVrtn8drHOp5KrIK7VZFvWmhTwJadA+7+rvGY5biy2bZfScSyACjQvW15N1idpCLOYmH7RrsqN3flCz2skGs4genCSV7rTb4+UckkevQEF+Z/kip/gB1L2JEBgZ9ZVokB+7pl7kHDiWJy8sFuenzXmIJLv2ieIRu1LKYhAH3W4tbFBdu5LxlZZHLTF75er/JoqXFEn1ZFroZs36y5xLJ6Nv/yDr5TBmWsGaX4g9nEj7of8It0AAPwIziJzE+Gnpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=iBERjDZMRoLb/RfWeENOv36L1BXtr7o+kv86jyi5Jqy6rEDk+j9wX5ApifMeKm7j14fm/e1qID/0TtEJQRE7ZoSXYWOT2zNGNqwxxx9DsnqSGXlf14vG7sTlyZzj8mcuQa9MPecN2GhGtWOEticBPdvs4D5PCv8JBByh0TI56iNxjimRVlCIfAHr7kjsiC1Z7oJRriIVvMbEQe1LZHfDjFk1oHAcbKlaCEDjEz7o7obW59t5f47sUlbV+oIJ/oulGa81dYT7eazF71oNhg+QG9MuO1M7LoOLH4w8Yu9QWE9xOs+BiTvySo4Sus6VtmGwIfTD6LFoC0VziSLB2LmTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AftkKfw0z8AD4ham5M5MC4dYIWJjDbvgy5EIjA9X60=;
 b=QT+w1ceXSfMbToH130vZIrUe1yap1JASYqnTbAVUCt6p6lF/x/TVr+FSpMdSVhlpsUA52YRqjNXvwhYW/Ml1eWcklEpHZDz0uW+QdD2eepNhzb1/tFDiYaNW6BIBZ852TQK8DETG0od15aJsid2JwhlsaxeJhxIiQvkFr7pyA1nyumCJS5Lg7dKl97NRk5OgoQaOZSvew6GnfXHWgh9j9dSNbFbQTfTmJ2VGAKyhhrAq1KYkOCz4Or1pGuHAOadVytMffckVx4Fnn+G4MNmvXYJf+cFKa2HeWJdK1ZUQ5gF1hoKnsCiAz7hZJh2z0Pm1Fy4w44L/5ORUBkKvkGUZLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 54/58] mmc: pwrseq_simple: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:03 +0800
Message-Id: <20230713080807.69999-54-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed849d0e-9ab3-4954-0ae6-08db83788b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRoFNpTjBimMAfhAP1uWc2QukhbZCA2lbV7otLGVLdsMkx/0Sl6K97c97opKgn7uI39k3LZ9ldeXqFjl6kijfVbpmQqf86veVg/ZSHAMEDgzd/eUzHXk5EonFynsDgIEyKzgHl5IOOSm2044DEdiXQR8Gb5HKvYEL15T2KaKcsW5pRj7eHpF52IM4BrbP7zjV1mFf5iQ2YSOFWkcyN2TXh1hNzdah2ED6+fIJvX7kg3jMVAsjPJUnJM/+nKN1MExrEx33rJJ0RmJZx6v23jYfHsQKhJCLAyC+kZ55S04vuDLXVoW+Kx+h7IAZ6egWP4GA/mMa8+JuVPJmFJAOo8dI9wk60/bJefn4BQ2zH2XbO7N6iMAdWqmRri9apYOs1/pf/g0k5eWsE3O2ilRdGb98BKZY06STBdPos76VMQVSdb6oPAPDWEoFCLp1X4U0NksaRDKnDZf00tHJdPVWIMv7FIqMXisD0iqsMJUz6Cw19fVYxaHCY1Q2XueAEeYa7cYDmu/Dy8DlWM8ax/8JuzmOxTqNYkccPe8u7dbgKTRbR9/ZvZn93keGZuMX2D+d5ogPceIy5rUAn1tZugtz9gGbB5n3aVvxmbopyNfeT9So9LU1dmwp9DnPeWFPws5uE3R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(6916009)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpqTkxoT2hqeTRVVk9uamV4OGF0dzZjM3lQR3lCRFNVaWs2cEZ6NXFhYVNw?=
 =?utf-8?B?WkZ1S21WcWdwdXE1a3VKa1pvZjR1bXM4SnpkaXRRak1YY0xvYWVEUkFqK21i?=
 =?utf-8?B?L21tY3hOM3E3YUpKZkxack85bTBWc3ljMVU2Nll1bXEyUGp4ZTFZR0RLOVQr?=
 =?utf-8?B?NUJjcll3Qzl2OTIzOUlCZFFOUWdvVHJCN1p2ei9xQjdCL2p4cHdyUlJSSEd3?=
 =?utf-8?B?ZTJ3U3BpOUxVOFpjV3puejBUQ1BYVVZ6WEs1R2x3d2FiZzB0a0hDNzdIV0tB?=
 =?utf-8?B?L2FMSmtsUlhocW5NUUJHb1hGdWhvSWx4RXRCWGhVdU0rQUxYc29rZWJtRCs2?=
 =?utf-8?B?UGdzUFVHY25zM2xrMmFndXV6dnNLR2lpVWRRblVTdmcvbmN6SmtRSmdQNUR3?=
 =?utf-8?B?M3ZZMWZrS2VRVnBoMlVXSWNzTVkxbVlRZVpLVDI2OFcrRGx1OHFJdkdaVURz?=
 =?utf-8?B?YXFJKzNsNHdIamp6VkRsWjR1UFZSNlhuby9oWVpabHlCSXdaRHpzQUpmSi9t?=
 =?utf-8?B?UTJzL0d5Z01obHRKRlVyYlZ1RGcwOW1DT1FPem82V2s1NUkwNFN3d3l3Rndy?=
 =?utf-8?B?dE5qQnFTUmNXbkNlT3RKQlFPbXZISlNDcG1ESFU2c1FoM2F3dHh3YThjbUNx?=
 =?utf-8?B?ZTZRb2pWcmdXNW5oa2sxdTNCTWFmeitob3p1NHRyMkhZcWc0VzZBOXlrMjRx?=
 =?utf-8?B?Qy9mN3pId205RHd1SVJxZFBKaTlCK1hhNldLWjRWR05EKzVXSFZoa1M2cE5a?=
 =?utf-8?B?a2s5UUl3UTdDZjQyNU5kRFZUWHVuUm5jSWhYSFZpTVZ0R04wVmI5VUtxeldH?=
 =?utf-8?B?eUJBSnpLV3FQOGo0dDJBaXYvZmk3NGdTRWhnaWJRZmZYU0szUG1yNzBOejE2?=
 =?utf-8?B?VHV5ZUFnNjlzSkpXZExDNVFZQytBWUlxbkpWTGVsL1I3eEdYL2NBelV5elN3?=
 =?utf-8?B?cU9EQlVlZFdnOXdxRUhyUFZFMlZWOGpYM2FNc0U0bVJOUzdjVENadmRnM2NE?=
 =?utf-8?B?NmZ5TVR6QzJpVWJZSi9rTzQvN1lHV2M5TXNNaUNxTmdEVmc1b3VWSjZydmp1?=
 =?utf-8?B?aHNmNkdEYzQ0V0p1L0ErUWpZNUZLN3Naclo5TWU0TzQzamlaWEhBRVRITTRX?=
 =?utf-8?B?S2duOE5IZzlIenozN3hXN3hkNW93d3d6SDFzdlBFTHpmSDNhc0hzQWJ6c0pi?=
 =?utf-8?B?NUxlZlozWU1SdW1SOHZ4d0JQcGk2Rk9VVGQxb2tTQUpDMDloTWNYUEd5bmU1?=
 =?utf-8?B?ZXdlSTFJdzRzS2U5SzVta0l2WGhzNzdXYnVUU3pYUDVSTUh3QWtTdVV1bGND?=
 =?utf-8?B?WlQxRGl5UDFrV3lWVW96WmttU0srZVR4MExrWjdpL3U5V2dCL2NpVmRzTEZZ?=
 =?utf-8?B?d3d4cDBVbTY3cTBCNFVmOXdzTld3UUM5OFJvZzJIbUcwaENPSU9Ld2liaGp2?=
 =?utf-8?B?dmVpWGdjckxEWUdNQXNLYnFwY2NGOEtTTlI0b21TL0NiUlRHUWJBOG0xUllk?=
 =?utf-8?B?U2poeVhjSWd2L3ZOV2diU1g2aFQ4K2N6MlpBQWtvOGNkQkoyK041Yk5JYlFO?=
 =?utf-8?B?d2hEL2toVUZFMS9SRWQ1ckk1WlBONy9kYm5seDh6c2xBRUllamdUbXp5c2Ev?=
 =?utf-8?B?L1RKa09taVhBSEV1Vk8xVUpaWTZ6OFhtQ3hCcy94aXl5ZmRlV3E2NlRxUzg2?=
 =?utf-8?B?Q3o4SG5YN3VVNEFQL3l4bTZKYTFZOEs3Q2htRGEzWWYzUnIzSlRqeG1oa3ph?=
 =?utf-8?B?OTVrdVZxeFlRV01oS2g3YVFCYi9tQ0R6RW1oNG9iY3N2WEtBK2x5R1pqM0dL?=
 =?utf-8?B?NGE5eHIyaXphU0ozUzNvNFN0azVyc1UwRGRFU0dNMWdHTTlHL3M4MVZxR2N3?=
 =?utf-8?B?NllHYU1RM3F0cjdiZXRiNVVqWjBTV1FJV2ZWTS9ob1M2MWRMeFRLNXpNY0ZK?=
 =?utf-8?B?QU1wbEhveEU0b3RjR3JDYys3NTVEWGZZSkUrTDJFbGNVVmdZd0dlR0svT2ta?=
 =?utf-8?B?SlRrVElUU0ZDVFN5dUpLVkVXL0p5S0FzMkhzdkpVcmFJNXo4NHYxOXBycUd4?=
 =?utf-8?B?MEZ5T0FNVnhlb2dYbndmeFNrcDdDTEFPNmFhRk1WTXBreWJ3UVdsOWFxVzRG?=
 =?utf-8?Q?7kyIXQrM84fQnXdaXnRtDN4qk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed849d0e-9ab3-4954-0ae6-08db83788b48
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:56.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmILFVXy3fRKOh57G9n19RKHfyKmulhKM2gqWGWPRZlC83eDAs8KIyiHM0tpn010GnW6Dr70nuEAYVCcZoNXPA==
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
 drivers/mmc/core/pwrseq_simple.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 3bac1e71411b..df9588503ad0 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -142,18 +142,16 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
 
-static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
+static void mmc_pwrseq_simple_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq = platform_get_drvdata(pdev);
 
 	mmc_pwrseq_unregister(&pwrseq->pwrseq);
-
-	return 0;
 }
 
 static struct platform_driver mmc_pwrseq_simple_driver = {
 	.probe = mmc_pwrseq_simple_probe,
-	.remove = mmc_pwrseq_simple_remove,
+	.remove_new = mmc_pwrseq_simple_remove,
 	.driver = {
 		.name = "pwrseq_simple",
 		.of_match_table = mmc_pwrseq_simple_of_match,
-- 
2.39.0

