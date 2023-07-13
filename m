Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F82751B20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjGMIMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjGMIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729030C1;
        Thu, 13 Jul 2023 01:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd1DWizDWwyRnVwfOJF8eLlVhQ2vzfX7vHMGaOQD6QHuvNUQIekz1Nq3PelzPgiqpuXQWhe4au5Q4xeAAdQLs8PaT6e/udouJsB5e8N/I9fBC4Vs1CjKhlyQqQTfSmXMPfDr8+KAFfGwFMI6SFGpDbop3taj1vvwMJ5nTb7GGdAkSe5IV6LjXusgjKCFi405SZ1WxOG5DulLfwPT942xbhfJUYD1EUtgyy6BmzQwym7pOg+NbVGtAA02+OTSPXN1F3Y4l0npM2vjratD6ef/5UpYFQaB7J+2UGbkk+sT2YJC9NPiseLrjcnb8kaY/K5Yt0//ftNlTbjqjURsTFLJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wifvEmyuIqm8s70tv9XlGEIJA4YhoVtEMbmSaHweM+o=;
 b=fTWqCr5JS3HEkTeBRqh9psD/fH0jUFwc0h/0916bSKkkNcUk6XcFazXUileqvkFaZla+p6OtdQDBZF/Cl/8katfC9IihgRwKmJpmvIQrU4QnkH+kTXzVHV6ZBDsSIughnAnlQCI0YSUvdOT8+NpB+6e74PYfBAmDGWcg4C77jee6/BvVmwP0aPUOUgxU+KizsJq502fCBKzDF9fGgCF3a9aT9c79ehi2BWU9oXrizDM5E0C4+BxsFYiIi228BzUKIVSKklL/T7YxJmjihluB4IJ8JGQrOPYQ6FX46w7fCXcUskghaY6B3onuBhHjrzfbrZ2oQ4vEUhK6kVA1/mLwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wifvEmyuIqm8s70tv9XlGEIJA4YhoVtEMbmSaHweM+o=;
 b=j0V6J1jyKx9Dj9+gsH/uNM2jBTjDwD2gnhI4wW0gjM3jWDLMhttPXLRrgCn3YK+HzhrW3CrrMeM76gdQLmOaRniqbIv8YQcBvs1yjvZDkbxb2l98ia2I9LmEfu35A6N+ynF9AMUQgOZLXNlU9M07po1YPRwpRVQOA5TkqPWdLfKpkqRXLVjJEGGymaGSVPV/rtZqzrCpDGCU4dP00KvfFdosoxoMAP7BEr1ZfvKB+kpIO8QcXWhwYJAwsI9vyAQWnvikA1v26mOqnuyRkhz8bd448m2/jbOBF+4mZVthUOisWK9aqFR0IOHwwCL+2L+TK0mtOJLn5Jd9dUx+rUI7YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/58] mmc: moxart: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:41 +0800
Message-Id: <20230713080807.69999-32-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e05fc2c-0cdc-408d-78cb-08db83787319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbHvsRVkHupX0Qln1hb0AWarMt+pzPqCnCuCA0HQ4aCae1AnqeWroUPWLD+3iqxRR9msUDPhHHZO89l5+NCB+GJLpmoSMHQAe/VS2z3rreccYcnUOpbqnFOrCAX8iVFVs1d0mDMMql9kRerPMX5LJHrtEnOEE0jvdBNwJOBGEi3W3w4rjMa4tXKYi5Az05JNghVKedWrqt59RzNKHzkqsxC04LVgVgtCHDfzKvQYDEuCB79Surhwhk/rN5hs/HHFlv7RALAgwxu7jxUW6MoEixkjRr5bcL6Ps9B7qpDtEOYLsRJwBS3bUPdw98s7B7+7v432H9xXs1M7CnBFui+LgPm6aEsl2SlVrzLrWyJ+g7qMZ0AnXz1y+rC7OYBSGMwzidTulGSZBc2+8Hgk0QNi2XKhaV73R+dTw8rNCYme7N2vvn1hlxlVsOBjJUG1ZyVI1+qPokiMoOR+UBRZZPY7SoOKhTwAQ9c1z6Ypgpp5yKN1oEiL8UY4Rg3Tj5SMIXZKPCcsSqO2VjEZxZy+VZyAIrdncbTFpzs/IuFXvMeCyKEQ0JaEtuMmFTFtcHT4MQN/3fC35F36TgAIQF1UyMBxvFRqarXh0Cb679Mld1gduwuqadSzh5cBp5v6aMUrrKu2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(6916009)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znhyam5RWExud2Fsb3dQNWowNk43aTFadUczcDM5cnZBWDJXR3NqdktOb09q?=
 =?utf-8?B?MkFqUk9nMXFZYTY2SHBJT2QrVjdqcG5pUmFvNWhQdmMrTHdTaHdTSXd3ZGt6?=
 =?utf-8?B?YmlYbVM2b25vaERheFVPay9pU1pBY1BNR0RXc0VSUnRBYzlrT1UxRUV0NDJX?=
 =?utf-8?B?dWRVLzlUZGxCR1FwVUM0NG9Zclg4RE84U0FlOE5XalhhRHIrWjJxaytqTkxy?=
 =?utf-8?B?MXJ5SzIycUFTSjduR0pkaVFHK0ZOdG44UDlyQXZ0dDB3d3VtSWt4ei94U3ZP?=
 =?utf-8?B?SnNUTFN4eEg0RStQQjBFZTA2ekZSUkNlY2lid3gra2Y5c0VneFF2OHJqSGZ6?=
 =?utf-8?B?Y3hEa0xQM0Q5cEtWekpiTm95aHU0LzRXT2JQOWRUMFFhcmF3d29ZOW9zT2Zs?=
 =?utf-8?B?akpMYWFnc2VnQ2s5MER1ejlPbEdIRWJZcnRhbUhsaktGdnkwVmJtcVJDRzg1?=
 =?utf-8?B?WjdjRmw1OVJxcU9TR2pvN3ZsczlQK3N6T1E4R3NMaU02YjJSQXlxQXZBQnFW?=
 =?utf-8?B?WU9tYkJKdTZqbzNmWnJHRUZaaHVhMjM2bVpuc3hGWER0ekZuRUpvZnd5d01R?=
 =?utf-8?B?YlhubnpsKzhQVzVKNXNNN0t2Qk51WStRRkUxV292eDFhaE15UEtMMmc4VVpL?=
 =?utf-8?B?VHBlZGJxeEQ0RUV0VCtMNzc2TCtQWkszTjZkdTBVT1ZEWHRKSVJDeDM2VmtP?=
 =?utf-8?B?YU9JWkF3NFViZjdDWFdRMEZWeHN5bWpaWjNEb2g3MEpBbmhYYitkSjlsdmFh?=
 =?utf-8?B?bzRsRThaLytEM2FJSlRrYjNoTE5aWTE0TXIvQkZLa3I1TDNVVHJQUzhwOS9Q?=
 =?utf-8?B?RnJydlpJbFhpY3VQbll0Mjg5N1g1dXZWNDI2UXg5TTRYakU3aVdQTGlWbUZH?=
 =?utf-8?B?UUpxZEo2RC9rRkkxTDB5MzFRcHJEbld4UTBsamxwZ0Z3TzVFZ2JXd1NhWmg0?=
 =?utf-8?B?ZU5uaGNJNkxjTTgvTXZmMGJuZnh3YWJaQnpiSk5yNGJ0YXBwbnJLakFHOEc3?=
 =?utf-8?B?MGQ1SGEyWTNhNVBkZm9GcXRwNWg4cXpMb3JnQ3ljSS9OSHM3Z2hCVWFadzRE?=
 =?utf-8?B?OWo0dGRoOERPc3BHRkhnMHFPc1VEeW5DSFFxTUQwaE5HQ0x3aCt1S2ViY1gw?=
 =?utf-8?B?Uk1VZXV4Vmg1MnlqclJDejhhQWlaL0xzeHVLdlltZmdrUURFMGJJQUkzZVJX?=
 =?utf-8?B?L0xTa2xIT01xbHd0blNXY2EzL3pMbU5ZY2UybnB1Ty9YajNpeFIrLzNNd0l0?=
 =?utf-8?B?ZHV1OGFnRnZKUm5qZTB1VmdkeUNIMTgra0drVUZBTm5MeSt2SDFQYUNsWHBa?=
 =?utf-8?B?R1JQbkRYWGFMaUs3d0lKQjJUMmlMdURxQ0I3U1VLRm94N0dGTnhYelJDZ2tP?=
 =?utf-8?B?enNxbW5pSWY3K04yeVhZcVNkekUzT1VjejlqcFo1ZUxoZkovUG5FMXJNT25D?=
 =?utf-8?B?TVNiNWJYbTduSldnKzNHN0ZPRGtJZCtNd0N2b1FEeU5NNHdwZzY0b2R6YkFN?=
 =?utf-8?B?a3JjQUl6dXVFRXZyMzBhQjZ1ZUIwbVBYd09GeUpEaHJBOExTcmZQcUp2TXdx?=
 =?utf-8?B?S2Z2N3lxYkdwczg0UWF4bll0WDFGRm9haldieHJ1dFZXMVcvT2NlaHhxUmc3?=
 =?utf-8?B?MWthSjNnbXI3K3RtRFZVNWlMS3k4Wlk3T1FHa3NaTzFXUENkL1R0cGlsZTVQ?=
 =?utf-8?B?SkNHQUV4eHNRZ2dGOFEza2RyS0tpS0Y1K3FKMjNMSXNpWlg2KzNkOFJEUFU1?=
 =?utf-8?B?N1VLbHZvVlZaMCsrT3JFOURHNHNQQkRqTm1iYmtJODl1SXY4a0F5QTlMakdB?=
 =?utf-8?B?aEFhbEdHTVBBZEk1YTAveTVwc2dBaU4rT2wyZEp4RFZmK2JQQlQ5akYzQnph?=
 =?utf-8?B?N2NzODRVaTFSamVLdGVqWHptQ3R3UUkxNkRPZ0tEYU0rajFXc0ViNEZYNmUw?=
 =?utf-8?B?WWlxYnEzQWsvVGtDbHRMUTRoOXVyL1kwRjJEL2FlK21ndWxLZ0JSYkhQZzUx?=
 =?utf-8?B?NWpqQkVCZ1JUV3M5MSt4eGVveFcxU0RpS1FiZVNDbG1QbEdTSG4xclJlKzNu?=
 =?utf-8?B?d2hPTDNVMlhpMGMyVVMvNlRRNW1aV2pZVEc0NG5uZ1RVZzBEeUZnRUFkd0tt?=
 =?utf-8?Q?3iwO242MbDyxq2x8yV0jq6QhN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e05fc2c-0cdc-408d-78cb-08db83787319
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:15.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykh6j87FJvUE7UqNACcsoNUM0ffY9qC8Z9DZc5d4yCoP7tZYS8f+Nmtrkx2T6rGEFMLxWLSuUhgLOqEcGnSUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4409
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
 drivers/mmc/host/moxart-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 2d002c81dcf3..7d35476c9ef4 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -693,7 +693,7 @@ static int moxart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int moxart_remove(struct platform_device *pdev)
+static void moxart_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
 	struct moxart_host *host = mmc_priv(mmc);
@@ -711,8 +711,6 @@ static int moxart_remove(struct platform_device *pdev)
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
@@ -724,7 +722,7 @@ MODULE_DEVICE_TABLE(of, moxart_mmc_match);
 
 static struct platform_driver moxart_mmc_driver = {
 	.probe      = moxart_probe,
-	.remove     = moxart_remove,
+	.remove_new = moxart_remove,
 	.driver     = {
 		.name		= "mmc-moxart",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

