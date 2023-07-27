Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FE7647C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjG0HHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjG0HGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:06:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FE44B3;
        Thu, 27 Jul 2023 00:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIv3VZgrOEvUZg6KYHvJOioL9zbIlCbryYXvRstH45R7ovpxqy/A1OVy4H6OXfXU11VKNTH1LlJYExaYaMUvWpvOtmf1EfqU5sS83zLJmNaewjlqIUsnJbMskfdYmSWdb1B47+DXB73sDZI7sDsGYoft1DkDD//MnGMip4A60BdKNTOKr2B21WeI94QGKd93bz0WBx3siCgoEM/XZPxcXricvP5+L8aQaUeokCtUQlS+XlM6nZ0HqnxVISxzA3OF1kLKSMf5fKch0jkm1P5jYnLadtpZCpZ3G9kb/cOCL2YDdpoWDlF7AfwHjGAjcCSKDF8FSf4AEGg8k2D7/brrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=B0UV7JTyB8xaZOKhrMVWbYJCSAnVu3MWCmjQvPp6mGL0/ZFJphhAO09KzBSBh65JDXCYER9IXZXM5i5TaHTIef16MREr/dIobAa/mXEAGbHsZjN4nFor+FU0IaWUzv+JEfrMRPjgpiVirrxzKG5+rq44VH+11k5ebIrBFt13rB3lhw53WVQmB2qKfivONPpDAprIHokZ+xzN/ZzuMirT1rOE2v+jMIu6QIcFz+m+UPDJnp301cMmOXKLN5SC/b+ExZeZYo1srlm7JSilsCS8kqlDKoqBvZWr+Plb1xSVmsGki2KMJahwH8tMKTkjwJYN8zKVdeecqmr5v0lmkV7Ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1UBCsQ7z6bjOfCJhKMKvjOrHl91zL75OXa3zGFD5pw=;
 b=fMMh/8dW1RSXQBPsjhYwA5legf64bx17XUQWKt+KqCbme/QIqY5/hmYf91fnK2ll13oczYJY0TBqzqiDIAmcMGoW7sEbFq160szHxNgUfsmBv5Qea0rg2HaeolzlI6WLfazWMEfWCvetHCJfEb+83Ipa9sdM/XjGKySkVcN4RPIr/JIW6RKmzPSh4RlTaqXpvgXXoenHJqXa4TNe2pSRc8MNcBiux0o6UDxHmwYIoPAyMGDI6bxpMO9JGN5xdOcZNDU3TlYjaj9k8rCDwDwF9Jtn4n+wHCPCz0yY4dokNOEoFKZbs1H3vbp/DdF3eN7JuCPDGhEEF2UkF0gJ+tEDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 47/62] mmc: wmt-sdmmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:36 +0800
Message-Id: <20230727070051.17778-47-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: f71a7c0d-ba85-40c9-9066-08db8e6f6ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1eWJu1UibBBRRZjg0Q9wiHipteNm64q09G01cufsxd0EUj4AHlHiQ35T0TWa8fc/xzMkUCyFxlmJ3ZwHwccoPxvx7R/z8Qvv9JaNu1s6bv9rosbLsLZVm0iVb0Xar5cb6tM7Dh/S67VCGrQ5hbI+Y2GsQT+93wcNl7QH+d8Y2r/c97lT2SuuThg/VRNhEFcBnG+wKZ9cVH2gJMzlOKDHKrRO9ZCb5gnUQu54cNZcuRtiuJu5UTdKGloxwwwcbRjvZhxGhuKM2VVqNwoPTx+VUHMdijX4J0h8/Ncr/WyycFpbZqLTlywRjMpNReu7zQAYcOV8JulHC4tzq32JQUQBPr4SyQB+JikSw1WZs+z+wKjmExgLg6V9aWCPfdbKtX9WUCGioDtxolzKjleBlCufsQe22dn7EXHyyYfk2fWrl5pl+9MZEgRVuTpUhyo3AYOmqfuggWyEoZJWRnqYdenpYvcAsnQVJIQk1hrF+EnI0TmNra9MqThX7VyyVvCNau1SG3nP8D6/VsyVeKHFki1auDdw3oXLKpepv4S0nSipexK1EVrcuAEuhllzmmReQjW5xPoCMWKEXa66QnX0Cr7NAYnPnbMQlygS1m08hCCAQ/4lAaV33eJj0To84st2m+e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(6916009)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9IbFJTUWF1NnlKWW9lVHJ3Y2NEMVpBczFMSUpVZW80OVFNcnhEN0p1b3o1?=
 =?utf-8?B?aDN4WUJoWHRXVFovVmp2dmhWTUxuN1BPTXpZbDM0Z25xMGxIUHE3NFQxOTh0?=
 =?utf-8?B?cC9wNnRqK1F4R1BtYnlxNkpkczZ0T0daOUloZmwvT1JwaFNCRlVidjYwTWlK?=
 =?utf-8?B?dS9FWTBCdkoxQ2s4WGcyTHVuak56bXJPWFlLQ0xJMnpwNk40NDZ2K2N4QXkz?=
 =?utf-8?B?cElpM25qVzlSWk13alMvYkRPU2VnQmxxbDZyVkFHMVlZNjIzTzJCNTBHbVJX?=
 =?utf-8?B?VjRWajFod3BkR0JEMEh2YUtVMjZEcHVwT1N0TVRHOWVHSFZHUDNNUzNZMzM1?=
 =?utf-8?B?Ym5vUXVuNWd0OWQySXVvTnlCNXRYOGJrS3UzVFNRZWdWUGkzM1BJTEJMM0ND?=
 =?utf-8?B?ZTlIeXZLSVpZMFAvTlUzZTJyMUhXSjREV01UbENxQ2RCTTFQUVBLWklRYkEz?=
 =?utf-8?B?NnkrRFpGelFUOXRmUEJlTDJUQW1kL0xkVnpRUmJJZVVuQ3FnN1EzWGdkWlhz?=
 =?utf-8?B?VjdEb2FQVHVIeVhVVDhqNVk4Rm9WSzhaZm5NdUNtekcrdGJWZWFVOVY5ckE3?=
 =?utf-8?B?b3pBaWNDNXpVRnZ2ZjRpN1VQNGhxL3QvOHl2NUV3akNHTWlIbENlWG5EMkUy?=
 =?utf-8?B?UytMMXlXM29sN1M0MVFuazJNdEpxZzVUNURnWG0zMDM2M1JhYitxQjlxaWlP?=
 =?utf-8?B?VXNqUmlTc0oyK0JNZGMvL0xUMEMwVG5pOUNmbFRveG5salhoLytidVl0Q0JQ?=
 =?utf-8?B?Z1AzbFNmNzRRSDZva000RVFqSllucnJFR0hucnFzSklQaFhFa1Nzbi8vUi9l?=
 =?utf-8?B?NmJoU0E1clEyRVIxNU9Id1k5Q0JTVjZudERqK1ZYZ2VLSURURm5MWm1FZWov?=
 =?utf-8?B?VEdYZi9MR1JURU4weTlkVk94ZTZ1cjc5V2IwZEpkNVpnMkVuNlNvTWQrV2hq?=
 =?utf-8?B?Si9DTW8rRlBudW5pdnEzeFNUcHV0YWNOS3pOc1I5Q0FIelB1azZRajlMclQ3?=
 =?utf-8?B?aW11Q0k0WFlmSWM5NG45WWJ2b2hYd1ZPMWlhVWswMXZuczZobmdJTFJYVG9G?=
 =?utf-8?B?aXplRzhvMmtlRWNFTUdZSlc3bmUrakhyczUxb2FFeXZ5V2luaWFKV212c1dP?=
 =?utf-8?B?L0UzWWpGdnFsN0VDWTFSVUZxejh3Nm93bSt2NVdYVlBySnVJYkpVTVU0OTBP?=
 =?utf-8?B?NnJkWVFZaTdsK1FEWnNldFdVNzdtREVOT1MreXV3R2RsVXk5UXMyWkNWd29z?=
 =?utf-8?B?d094aEYvR3Z5MEFlWGZwVGt6VGlXNmpGLzE3cHRZTkg2TUJIb3pSdk5JOGZ0?=
 =?utf-8?B?K21YUXkzVWswRGJWWWJxUTVJRUZCVkJVNjYwNjhuUHhKRVhmMjg1UDhnb0Yz?=
 =?utf-8?B?VTNvQSt1Qk5UVndaVkFhREtMUm5PdDJRcSsvKzhJMWd1S0J1VlROZEN3Ykdo?=
 =?utf-8?B?Ung1TUVNWFNvQlZ6MGZBSi9xOVZSVUczTnRTN243TTdJbUxBMzVEUUdJVkUx?=
 =?utf-8?B?VnFzVEYwQXl2bDJ5S0FEMUpUTGVzeXBPSkdFUWxkbStFcHU1ek5YNCtHTGZm?=
 =?utf-8?B?RDlyZzM4YzdpTzRJQk43WmFiNkYrZEVIUHFNQ3NXSnZOdURPREo3VkJKWnNK?=
 =?utf-8?B?TEJsRVJMSGM4SXQyWHd5SUJIOGJodVkybXl6OHlqdlRrUEZsaXRNS05qb0hG?=
 =?utf-8?B?TFZlYlhveWNGeklxUUEweWhJcnpQdjdhK1hnUGhjWEF4QTVtSnhFaU1EZjhD?=
 =?utf-8?B?ZE5sOFFIRmJpbGN5SlNpbHF1bmNmWlBlZlhJMWw1cTR0SHNQb29NdGp2dTNw?=
 =?utf-8?B?VXhWT09YMVNzNGZJdlRwbU9MdjZacjlrTnY1T0FyVGdVc1M3d0dYU3pQcmJt?=
 =?utf-8?B?Zk1FUWJOdDZWMVdHdGJTcWpBeTM0RUdCTDZaSFJsUXRVT1FxM1Vyc0F1a21H?=
 =?utf-8?B?NzBhUlhBM1JoSHNQUjdvdEVicGgrcnJQdUhMcjI0WUF1MkplZnVMQVMreThZ?=
 =?utf-8?B?QWZEUkx1dVd4aUF3WFNpMzdsdW1aS3pQekJkTDV1QXRReE5sN1VlNDRKN3lE?=
 =?utf-8?B?RjRWdnJvVWtRNldHU1ZIVU9jaTg4WTNxL1pFTVVJWVM2YUF4R2dpSkF5VWtw?=
 =?utf-8?Q?ubcoPB2PGJBXAOqrX5cRMZk/B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71a7c0d-ba85-40c9-9066-08db8e6f6ccb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:22.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYt1kRh0/WdbLuYibW5FEi2QbE0BZSCIy1kP0bfiw+zV2gAf5lkC2edrf1xS2/fQQu427h5cJdmlk9/j9PTXtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/wmt-sdmmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 68525d900046..74c475d071b7 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -880,7 +880,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wmt_mci_remove(struct platform_device *pdev)
+static void wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
@@ -918,8 +918,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -989,7 +987,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
-	.remove = wmt_mci_remove,
+	.remove_new = wmt_mci_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

