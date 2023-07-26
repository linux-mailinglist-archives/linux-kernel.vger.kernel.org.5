Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDEA7629C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGZECs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGZEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3826BE;
        Tue, 25 Jul 2023 21:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY057Tfhwgdy0BUfSC9gZwNAeHnb/t9YvFPpdjREDiaHiHeq1oE/F+0SRE/TJHUet9wcTRuEQPa+7I7Hk6W2p4TO25r7hM96jGigf6h9pJ72gOtIq2vm/CCh+1ikxn6ksjC02XewxonJKsGLMXkJCutHmEmHh9TW0joakaJOgdCq2EqJ0S0Fsulm+Z7/2MvebzCX+gQGNpuRMyRApFtKbkVKusA1gDmb+q33JC20IeRJXHrR/0BKavztccsOC1pjWcj6iMgm6p9aVZSLJRsnUezmUNTRqLwQJqwV0Tdr4nI+0lHNfNfEQxwx/hN3sK0ZHApcR98+HSbaumv7tuh+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=OqqFZ1+en6kCqadR+K9gqTU4KMnMEr0UhAUnsl/xopgKNKnonUqpAaWN0gFGy0SF8jRw0fDMaIY/O89DzfKmL90iomU4H640RWsrTF2yLUrBOL1DEj+dnX0yqapKa/0BOX+I5WnUrFBnH18N7asH+faKZZNk5Nd2byXnmM8XrgrKtMPd+thTvl1SssdpMO5/cuVLxkrBho4YH1A1aRg8M96upNLmBZWeokKW2YGxpkNB93Dc9H8ICP5KarGw796yahRSAm5hw9edpyEpr/Soj8GXJvWifGMmtdrOQ9zF2C8C76n0oLeMp82TGmpBTemYdLBD+LV1MVq2mvUTGLD33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkUpr7l0pDttVGz3kqCsUAr3ho/CgWL/40WVT1faxUc=;
 b=SRBEHQlamksChbKgSfHcY1AqxC/Ij6/BdidGTaxV+EQleUR8zhqQnd4dt0C6A4g6s+w5Gv7br71NSF3GVNu8v4zeqYLA5MQCJInlEsb+jVBOfWHcv73XYqXjmglbSDwwdOcNvxCUbMOY+yQq6BcNiikWCeIIoQSBEeQzGAw9Oq8h8WJ638NpBmNdzx0/yjkcCK2/ySsV7DXXsRz/9qxTi1mSHjH01YxR+DagpUskJv8eGA3Bt04cJfQpvxQw/gOhJtHEcp4jvcKnXijWC7G9/X5zhO8yXwKQb3SpO2SRPVC726ZT+Y0X2yzMIt6FfKfa7rtksCkOFQ7N/IA60IYGDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/61] mmc: dw_mmc: exynos: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:54 +0800
Message-Id: <20230726040041.26267-14-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 90722416-c551-493f-8c1b-08db8d8cf981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wX6EFvNIuIQd/649CJtu3yTHPnck52lzHQmccPYxKC14qYXI8SlBovs6aFAV/JT29q3doV5BnGud2fo9fgRze8yzbpeWydJXFHcoFby3sKppeQ1ckK/9J9oSmaDfqTQEO1ZhBOIXKP3ilHNqXfHdoEZpY+KZu6yWx32c3TtM9cCYvevGCGT+uloXnZeeVKnDC0zzOPghu3Zdm0yhK8Vhp08Bbo+9YWUoXADn4IX7BvUnquDKl61faitCFyIRvSOEyyS9DpM6bgB/PlmTXyI5z1u+5KAv0eO88rvTdtIq+ciKi1h0CJ6tLfWfWyjxB6zLyWW+vV4tPbD89oMae/fYR4okM3KbuBVdLMvKufQQyoFGzv6MncS8080PMF0r8KkQuaNMERQh6b7WDae85vVk7VZte/8wcYnv3EO1L6fWAnJEIwn/llPehqLrw7MDEQv9iKkl6NYDGRO7UA+VpqaDtpzgYQXu5yPKQI9s1RWTcrYSDzJnPHZTMhjch73DH7qamgu7MFk85SwvX30Sk8uDNBVHqGu63AwVXhQ4W9mzNRY0ctm/RqsqIIMORtADzdR/o1OFqQ56pwMAo/TUxvlwUhkIame3DDtc1gBH3mchbe6Phy+bvrrrdNClWfpBQrsf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66574015)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGNEdlNaVzFmdUl4M2RLMFh6K0haT0xRYXhNUUdtcVJuQ1YzUDNWU0FHdWF4?=
 =?utf-8?B?NEJxSFdZMVRyU3JJVUZEOVB2MUhxdE1IaGNyU1o4V2g2ODFUbVZHVEVzK3pu?=
 =?utf-8?B?ZHo1Q1lzME5SUDl2MnMwSi9XY3R5MnduT2RvNk0yZ3RwcllEaFJrMlBSUjRz?=
 =?utf-8?B?bFA1aERSNkNHMnczcXUyOGlQSVhmUmd3b01pUEh4cFluTkMwTU9XMTZLN0U2?=
 =?utf-8?B?YnV3bFBQZ3BYSy8zaTlCMHNpWjR4Sjl4N2tHRmR0TjB1NGlKRWRtNXhyM0pH?=
 =?utf-8?B?emF5dXhnMmtMeFZxYnl4dFh1SURaSnZMbVEzTGUxak5YdEtoVEFMUlVFNGNi?=
 =?utf-8?B?Yld2TUlXR015TzZHaFNoeDJZU09qRkEvZDFHelZrQmtPZmJnRzFhNC9QUVZ4?=
 =?utf-8?B?WFpnUW5QVjFZZVhSbUd2dkh4VFlja20za2I1UUludmNpbCs5ZUNyeHFUNWVF?=
 =?utf-8?B?eU5xYmpVaENqM05UaytIdEJYWjU2WWNoS0trQUVuOGpaK1B2MENVVEE3Z0Uy?=
 =?utf-8?B?aHVzQkFBV1lRUG1Za2ZxamhocHlNZjhEU1ZJMzRod1ZhbmJadXhuWGhJaGNR?=
 =?utf-8?B?VEZqNWFweWc2RFRzeUJqdEt0SGVWWTlNSnlQVk0wUHJoSExBRDlqNHlQeDFz?=
 =?utf-8?B?N0hFTVhEZGx5U3RwV2NidjJ4WFJTY3pueXhWUC91R25jdExyZ3Q1V05VdFhZ?=
 =?utf-8?B?dEo2YUFZSjRIYXdLMUprcC9HbGpldjErTThmSXdybHd6aWhnd01zZmtRNkQr?=
 =?utf-8?B?eTV0UmJqaW1SME5UZDZOaHE0Y2grWXZua2svRWUxWXBDNjhMVkMya0ZsRVQ2?=
 =?utf-8?B?aC9rNFd3bkZrZmhLNEpSR0hmSytkcnVNQXVidk1JNjJXRFBwVWlTY1lYRGR6?=
 =?utf-8?B?NzZOOFZrRElsVDFHck91YnUwWkZrZWVWdW80SWlvVW5WL1JYYi9VQUlHZ2d6?=
 =?utf-8?B?bjgvb0IzRnBBYzNvVmFjUk9TQW85a1JMbTlIWUpQYjVPZEhUMkJIN0NyL1N0?=
 =?utf-8?B?dFJ1dldHWGVYdlFOcENRMktjM3RSZ2c5SXY4bjZLS2paU25GSUF1aWlBckN6?=
 =?utf-8?B?WURnYTkzTG9ZS2I5VjhjZEYwUElxNHQvNmREOUsxb3NWRms4aS9oYnJ6MTAv?=
 =?utf-8?B?ZkRRL1EweDhxa3JGWW5CWlFnYTRweDg1KyttR3UyMkE4bmdvM1FtK21RWmxK?=
 =?utf-8?B?QXJVdWNrb2FPTzBxNlYzcFpxeFFtbkZ2bmhVUGRkczAyOElOdjBpSkJKMlpr?=
 =?utf-8?B?Y3o4UmpaQkNQcUdPMlBid2xxaWRjUkRLdkd6ZDU5eVhHYmxnNzBXdEJCM0Z3?=
 =?utf-8?B?aHAzN0VHQlNYWVBicFhGcnVmeUtDcUIvM002MVJBb2l3eDQ4RFBCZnBTVFg5?=
 =?utf-8?B?Q3puU3o4UW1FVllpWGMrQ1Nza2Foa3hsWWJxNUR3Qno1VUtwTXdMOWk4NXhG?=
 =?utf-8?B?VEdhU2FiZU9jWnlFdHI0LzMyeENNSVFXWEZlLzhBZCtMWkNNcTlOV2VIZHFK?=
 =?utf-8?B?aE0ySVIybGl3ekdUSjFZSXRHblUrQ3JoS1QzUzZ0WmxzUUZkVXprRGY5aDJW?=
 =?utf-8?B?NURhNkdFR2ltbG9XK1lHYVh4ZUtSSjRqazJObk1CdUE2KzV2bEgyR1luaG9x?=
 =?utf-8?B?cnA3VVptR2F2WnkrdFB6Slk3SGx3Z0lIQjdTdzg4dEZSMDVCNW9SZmVPQXVL?=
 =?utf-8?B?R2s3bzFxSTVpd2R4M3FBQjNUZlhCYjAraFc1bnhMcDhqZlI1d2ZyOEd6eGps?=
 =?utf-8?B?L1VjWEJnV081dUNKcFJ0SEppSlRMRHF3VkpPZG5kYjFsbG0yMzM3QlBDZ051?=
 =?utf-8?B?cEtrYXlENUJ5bWQ1ZVhCKy9JZzA4ZDk5SklZUGNZK0NDeWxBU040T3ZkV2xZ?=
 =?utf-8?B?VkFJRTJWSk5WY0V5TURCMitKRWV3K0tMSjA3ZE1DbmxsTkZEeTYzTWZPR1NX?=
 =?utf-8?B?dzdiNHg5T0hIeEU0dGdOS1dpcW1lQlhoS1VCaDVOVFNjT0o2QmlhUno4WWMx?=
 =?utf-8?B?bEJUdWUyRDEzdlhvdGVkWFNHeWFVMnpYMjcyNEhBUWh3L1A1c0k2d3RWSjlR?=
 =?utf-8?B?OVQrT1YxUFlnWEUzTFpOQ3lvYUNiT2N6U1NwVnpZN1M5YjJ0YXhna3FyUFl3?=
 =?utf-8?Q?VatfueOpUGEEzSNyr91UGCdRY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90722416-c551-493f-8c1b-08db8d8cf981
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:22.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un1xXXYFNLo+qJhvyWWu9J/Vqx+QAWFJCNkKIO2pQRRnSdYZWCw1tJEMlY7TGD37GfxXfldPngq2OBpc3Ocnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
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
 drivers/mmc/host/dw_mmc-exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 9f20ac524c8b..698408e8bad0 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -664,15 +664,13 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dw_mci_exynos_remove(struct platform_device *pdev)
+static void dw_mci_exynos_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	dw_mci_pltfm_remove(pdev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
@@ -685,7 +683,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove		= dw_mci_exynos_remove,
+	.remove_new	= dw_mci_exynos_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

