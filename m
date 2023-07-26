Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0847629BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGZEBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGZEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237826B7;
        Tue, 25 Jul 2023 21:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6LPhN9ibixv6tv9Eb66+rOiCuyAVFXRI7u3VTdMaJ8B5LOsn5P49IfQs3VD0BolNeA4m2Lhc+Q5t7XHwf2FwpHVPVd+MBvNsFtOSjJw5SVrzqWm8W+9MnP72DjAxQ99o8nOLCQoA2y3yi7UKNWsT1N3cI8LBCGk/9A3KGW9qvuGNOO2uzSI8C4LtXFp0mV5yatnXfW66R6XMbwSYEkZGvIV70p/iFD0c03sQHVe1xr+syzliB/l4ZPMioHklVPTbwNciCahQIH0f6V29MLFM+YBgbbsEUuMdrajyRWiZQ/WcUT1ISXrB6n8kc2GLB5kMSAJ1Sr5h2JbwvuaZwFbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=kaf/Snv+sEh/Pg8G5cnF083FXELxXPGImeB/Au5tsMfKQKrKRItmZdjrL0YKnBYGUb6eFKFtVfYIG0pqnvbouivveHg0mBAE1TW97PmvLVt+W/OUZZc91ZWtocl8br6kSgP38L7RiIj+ypW6UGH5jrfLWsdqKjL3JdLDOHrpF4CHL+CKz0PE7yHfM2j2uWca7Fc60DkS1pR71+UFrX10JWGH/hTQLb09bjIhi6nv1WUnDbyczcVg6cdaCU28PUhXl/DXYaYRWar9NQg530qWD+ds7FAmejseHtoD/sfwaoYWF4QWZg06pc2o90pVbEnT1Zc0tzfQSqQBm/++XbMiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7okkAtAy4Ay200gbDx0jngJNeo2uhW4SadPJUa5pIw=;
 b=Rf74xZWHQb42YSn+uFw4yGdkTZZw1WQWQ1tBRjvrEo2JxCnqpyQVxTGlxUkuZOV79riwxR0TWSny4XUtND+o57mlf9VAX7N35MvyHlftWNUR0jgim7CpI6/lhAq79FY4nKJJKCeBic643jOhJ1gn/ahu/Jcd61OTeVNDiHKF4G/9yqnpEY6YfzD1M7ntLzR1gzWg6UKoR4giKujCFUI5Rg6n1LNn2Bkz/T/yreRy/DJak8oNhOun7ClsHidE3HDC+awyPQ53E0MC/k+QqTAxEiHIl/har2FUF1XftlPt3yeZMRCuXj5LQ7Q7S/4M7Sj8c3bhO1x9C6sVCCoSh2Ewmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/61] mmc: dw_mmc: hi3798cv200: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:48 +0800
Message-Id: <20230726040041.26267-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4914b60d-ed6c-4986-6aa2-08db8d8cf296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfPLXcy+B0OSU+doe+6n9k+/ihtNEEqqicfY8owA786ZU9n8khQWVwHTLNrISQBlwEiLpTMPZEluf7H48Nl+USQAyq9bY9BLBQaWp797Sb+uvOQ83gpL4DfDnTDuCKiJKld6pwo6BD9IjM4i2dzQRuBTqs8Tro/HSHNRCjM2O21/wQbO/VN4Vely6ZUtJdSVaOLtc3UjEjzY5xKS36JSXqxEgwrC1rqTTfJTZmkoOoa0lwTRIokujUqaZ21kGJ9KPaMu1rXoHmUcFTGXAZdGRqrDtspxCDjaNQDst7JLZI9Z9JHNAcyuLlCcND3uXwHfi0hzjLX4o+OzqzW//9YS6aRUCtYhDNkiwopir7fZgA4152A72ew7dXAPqSkFCr8gf5V+BEyYn39sWXVdFZ3skmlwxMv1t+p9ls/uFZWWfi9bL7khYIIoCCF7/mFd+5oJLa+ixQbrCR16IrrOSSZMz0L1Gboh3aPkFKzl9kjscnr4/rMFg7rs5a6RBA2C/sKbQGsyIsrZ28U3eFZsBIRpLavLzQx3s3DLCnN/N+lvqT9EOzP3hF8P7Fsr5H7t/YatLURJJ+T9ghN7TrcpcCfDkg8rOpDP8AUrel+BIhRd9iaTQBrJkCAcJO33L6R8oqK9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9uRStxZGozRlcxUlNaYnIvNCthYlpqSDU0MnZNcXRVM3U1bm1lYmFuTDkz?=
 =?utf-8?B?RldSUDFGcHdVKy9pRlZZek9pSk9MclZpZGcvZkc5dVBHbXNyWkVFUzRscTdz?=
 =?utf-8?B?RU1JUjdoWkt1c2FvWWMvL3FVZHZnT1I3TW5LVWZIK1VPdGExeGIwZTQwekQx?=
 =?utf-8?B?a05EQ2V3WDlSc01RbnNXcWRDR0w2RHZybXp1K1J5c3N3R0xlaUpYenA5aFZq?=
 =?utf-8?B?M2ZGNXVYUU1KNXA5MkNIYk9WZE92UnFsbFo0WWNvMUo0Smk0aCsyYVZ3akt3?=
 =?utf-8?B?MktwV21UVVJmMjBkNnViWWZ2RnJGN2JQMTNsQWtaNGd1T2VZSUh6RS9PYiti?=
 =?utf-8?B?Z0o3YXdKeDNneW9YRDR3QjNXZ212dDVpVjd3WnlOVmJYMEJlZkpkcWhRM01Y?=
 =?utf-8?B?bWZmWkNrMjl0R1hncDZVSC9uWHpGUXEwZzYzQXBaWTFqVXRVRjFXRExUMUZ0?=
 =?utf-8?B?eVBtTDc3SnBQRnZ4QnR0VmhQNUZsSjZqNGNDRlc0VEhaVDRCWG1aUUtGdGhH?=
 =?utf-8?B?bnI5VkFvNm9xSnovNHQ1VGhtbVRvd01MUjNLbjZSclNtWWluaXJPNUMraU9I?=
 =?utf-8?B?N1ZsbTV1UXNvcEhXOXJjZUZMbCt3eVRIMERndHpIa3pyK1lCK2thZUNWRTZL?=
 =?utf-8?B?dEhZSmVPLytMQzBJcTlWcHhSdy9FdC9vcGk1VlRMR2lyZlZmUzB5TVlFRy9B?=
 =?utf-8?B?TU5SNmRsUDgvM1RFZVFHQ3ExblY5ckdycUZocVphVytOcm1tdXN0SFJDZnd4?=
 =?utf-8?B?UnQzelM0aHgwWHVJa3VzenpESXduU3ROL0xpMkN6TWtnQnFsQ0EvaTJHZ09E?=
 =?utf-8?B?UEtBdXFJeU9vcHkyUkozNGJXcGpPeVlpZG5MaVY3NTEzd2h2dVc3YVZLWWFm?=
 =?utf-8?B?cElBa1BwZDBZUC9wWnA3cnpLQmtwVk1yUG5DUTNZcTZDVHpxOWpVSnl6WGQz?=
 =?utf-8?B?dHRaZDYzMW96NGVwUXRBSXVnSXM1eWxUZVowSUIxVFlNeEtaVmZHbkFKVTd0?=
 =?utf-8?B?QXNmeWtNRFp2Rk5MVDFHa1dYcXhiMFFzbFNDK2JmY0hzY3VOVEJsU2RPd2lI?=
 =?utf-8?B?YmRseVczdnNBc2dtcU9EK2JzS3k0d2VXdEhwNzVLMUp4dVA3UDZnSHZzUzVh?=
 =?utf-8?B?bmZBd1c4aTRPdVlLSmVFMGRadjg0ZDc3NjRNWDNiMEZIeXViUXhwMkhkakZr?=
 =?utf-8?B?cG0ycFBHVXc0N0NYTVpPeEpVRVlWdm9vU2ZIL2FJMGhHR25FRFFudWtIWVB6?=
 =?utf-8?B?WDhqcFA1RzM0RVZxTXZPbWlnNlhUbyt6cXViK3E3dUMyZGU0ZFJ4aitTaDBa?=
 =?utf-8?B?YVdBUzY4Z1RFbDA0dG01ayt4QlY0VS81VUNmNXRsVzRoRE8wY0t0ZTFHVjM4?=
 =?utf-8?B?MXFWVjhYWEZpT0Y5UDU3ZkQyU1I2SlRjVUo3amdCcnR0L0t1cDUrZVFnbVJY?=
 =?utf-8?B?TUdYMHlwMTRhdkhncm16UE0yZUFpKzVKU3JieiswR2lwcjUyc2EralFjbUZ4?=
 =?utf-8?B?ZS9IQVkrQ2dIc3JKeU1MdFVNaW5hT1JGMGsvbW82M1pXSGV3T3NqTnFnWCtx?=
 =?utf-8?B?RjFoR3dOalg0cHB0Z25zYXlmVS85ZWxzcmtjYU9kM0hlYVVDSmVKZjdmbThq?=
 =?utf-8?B?cXV0ZXBydFdDSEFON3M5Q1BIOEZIUjJFN2pkZzhBNm0rUktva3ZJZjNRYnpZ?=
 =?utf-8?B?VEE0N3pwRS9WWVFMam9yNXdpK1V6TzBOeGxGNGdnZ21QeHM4QzRxWlMzMGd2?=
 =?utf-8?B?Ym9DWGpJMUZaeCtIRWZtZjA2dFZ6QXo1L3NQNG5pUDYxOTBhZExVcFJMNXla?=
 =?utf-8?B?TkNJcmhQTTFWSk5Galc2YTN6RmlNQmlZZ21NZHVFNUtPV1hoUXppTVZBbEF4?=
 =?utf-8?B?ZnVENm0rTkhrU1hIa0tGOG9nd3VTbGk2bXV6elo1L3lFL1R3ZkhjSkt2UE10?=
 =?utf-8?B?Qm1tODNiTEMvcm5GcXJIMDNvV1kwMFdvV21Ra0xOK0M4QVRwNWhxa1pmK1Js?=
 =?utf-8?B?b2taUW9FY2ZsemcrUVM2R0ZCVWp3MCtaczIyQnFXcFpqMG5MSzBSbnpNRDNI?=
 =?utf-8?B?UG1NQS81MjVpdVo0WXg1ZGlZRkcvdVgwVEV3TUFxUGlyMjVHYk9rT1g2YlJy?=
 =?utf-8?Q?/pAu1vU/+vcrRevB+nRqhPTvW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4914b60d-ed6c-4986-6aa2-08db8d8cf296
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:11.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8W9Fuy5OwlDay7ItYgUAji0p6yDBKDOyxZqjfHRQKteBd+ViBW/U3UNp5TQUo5Batj4aRu+GAF1+FK5NzG9Ag==
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
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 6f22fe054087..e9470c50a348 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -171,7 +171,7 @@ static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, &hi3798cv200_data);
 }
 
-static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
+static void dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 	struct hi3798cv200_priv *priv = host->priv;
@@ -180,8 +180,6 @@ static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->sample_clk);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id dw_mci_hi3798cv200_match[] = {
@@ -192,7 +190,7 @@ static const struct of_device_id dw_mci_hi3798cv200_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
 static struct platform_driver dw_mci_hi3798cv200_driver = {
 	.probe = dw_mci_hi3798cv200_probe,
-	.remove = dw_mci_hi3798cv200_remove,
+	.remove_new = dw_mci_hi3798cv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798cv200",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

