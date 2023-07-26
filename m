Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70820762A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGZEPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGZEOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:14:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1BE618A;
        Tue, 25 Jul 2023 21:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUXG6YmnK1Z80f5PhW227slnL8at8rMirwbfnwKwsDE6mqTX01Jtxg+x02qpiGMAKuQ5o2Sxe0BWAW66kgGPDdeMXtJ6jvGJSHKpZtdXtXT9vh4evfMHSzifRC/xdsplDP38CuO3H103FoEW/wttO51A1vFkLnDGunUXIn8cxRn//6auYFfXoS5sli/TCmtDTFM1BlEgVvvt6oJCmSsMtXph5DtRBzhB2EgJN3PfXhjCKE3aEi3LLnZe+TCc3Nm+lrBmh293eAyFzrvj+9hVnjLxdLAx2IncSkHxlQx/LgQdMQZSXf68/AR14MJz1kzk37NDgCzaJIXB3+vL4VGhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkhpTrP1fBy6oKTGfSv4gzzCC9zrpbviYP34vWBotLo=;
 b=dvzCqjfeKLLs1+RgszUOg58Y5w35CkUYXFf3D89sxVYty9WDo1B+WiDwS6DpPc8pmKOq1Y/COwz4SNMJDbFWGv/aJgds4jk/yu0drHu68qSfVSG6cSkpTdjgC63GpidjQ9b4eTZiSo2n1lFNLToPFO52zMVdZT67SA+/bJf4UMq/AjyLc7O5+rG3i2IvR6+NaDFwNAuzewvloelvdMPiDlKY3gTymUWUzvToGOISJ69dUTux5i92467NMwk28BZmZolc8IDcFMeE+otk3p9NHGL87YTj3PN5zSUP6S9Y3MG33YGHnC96dHDZIYQe9YcHeZcbSyNmD5qRwkj3X93TVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkhpTrP1fBy6oKTGfSv4gzzCC9zrpbviYP34vWBotLo=;
 b=kIQLS3Y9SXhofHcz86sXCDYzvjXYQvdmSqOZb6jm7wws32n3X90C7vBfHYKsGr9ltnBWYcldFE28/dS6OQz9tNyOjunNkVR6pYBfPYwRTfJ09HGn2Y7+9lHUfU3CmYmmFjclc9JSYiv3U5/4VVD1L7DaKYabIy8imNh6xnl7VdKS0iweCHUuOvfB7JpoihCRVCkf82mYVVrbQg6U8Ij58m6dkcR+F6jqsVdxFE5h5dFGwATsMi5g8gYokke9207l4F4ycb4KiwTA1MaXjyxFUn9oiPIjKTMswHvbZfCelVDf0c7+xkH+I91Ggeg0UuHoTeRGvG+3A+Y5bT3yzx4Sww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 04:02:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/61] mmc: sdhci-msm: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:20 +0800
Message-Id: <20230726040041.26267-40-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91ba5ada-7bfb-48a8-d9a7-08db8d8d14f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38f8Cqay50/4rKLFEniBB8EKnNrR/D1AYgVJp2oxfm1icjYyYBPwjwO691R2gkx0fquSzW6VD1bB6HucmZ9ddkRQ+DPp6XFKOe5O+HCJpu1qGfmzJhrmbM/9tagU/rqQqA4r70Of7Kc4d9i19sUhzGFHx88yJANYdrcZxJacoziStMqDRew1Kb8Sp97tm+EMQPPivu3KM9JqQPUBhREBF2LZqjITRplNuKtU0tHcbEDO2xF1e7v7z6XjWig1EFG+f8lIcuEoYgvWi8zyvUZEsDpdLhkHNVcJRXH5gZF7HbbF/81bTlZMkke/VWuJCD5tJ5E0cCXkCCiw/WJ2gUzkSwVe85cb3Vpst1MwxndPbmu1dZ/Dzbxn7NjxXwuEGB9mFKq+1wgKCQ96qZj6K3GJW14qTZBNxEgoAAzqR/34lXIBXqTdf5KFI0bi3tXzyfwsiLEeEY9sAj+zZFPdKtUPSXfckJDdM6MOznbKl2ol7PRNRLCWqdaO/Cl0y2/EgGrkdydwlCpXdEycuEYCJWetURmsPa/CkBaoNk76+hMEqJxfgRO+K3ngbSBBQLEevLKrSTQ1unsSBkgolXzBrzFzPuTVvew/Hy6lqZVt/crvFZ7ItmnwuQYKAiCK0qPDPaQi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(66574015)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRIMmVLOFpiZi9CNDR0UDZRV0hiYUZIcEYyZERRaUwwaVR1YmhMbEU5S2RC?=
 =?utf-8?B?Q2dLaEMwcGlodDZ4TWFvVXEzMklXYmlydHBHRk14a1hVQjdBVkJtWTVJUUpi?=
 =?utf-8?B?cmJrNm05ZXBRTS93OXlpRHNqbWZTR21mZm5TYzBFa2ExOStWa2I2UFRRM0Nh?=
 =?utf-8?B?UVNkR3lQblArMWZ3ZWVtSVAzR085VGZxL2hibFQrUDlabTFGeXFJeVBNTnRN?=
 =?utf-8?B?V0ppZXRMcmljWXAwSEd5T0RLVmNCU1M3dlQyMmFpREJvNjRoMlVEc2VsdHhH?=
 =?utf-8?B?Q2NibXR1ZHI3UndTbldZVEV1bEdLQ1A4YWZ1UUxDUG44WDhIYlVpN2VSTElG?=
 =?utf-8?B?amVGN0Fzcmc0bmNxYTJ2dk9BcGdobXErQjVXVlo1VmlPcTFVYlpVV0Y0S2Jq?=
 =?utf-8?B?T3M5SkRBSlM3Z25aMktsdUVUbG51MDhYSTljd3c2MkRVTmxIOG0zejVxc2ZF?=
 =?utf-8?B?NHphczJzYVY4UTk0U2wvS21MVHdEUGh6NHpnWFpTclg5WEhsSVR1K2pGREpu?=
 =?utf-8?B?emlaUHllMTBNbmJxa1NnNEpHWlYzTDc1N2xZWFNjWFZ0SmlEUEg0L1RXK2w3?=
 =?utf-8?B?RHJ0NUhneUtjN3FFNzZ1R2NnTm5yT1ovU2s0ek5EYmhWTjN5MFFlWTZkTXdC?=
 =?utf-8?B?c0ovRXBEUTRITW9LQUVtVlhQZ0RwUE42V09JRFRvRS9XeHd2NVZFZ2lwRzY0?=
 =?utf-8?B?MGJidUxjRlpXZGV1SWNBSnIvNHVzeTk4TDZyeHhrc1NOVXlnY1R3RzliQ1VE?=
 =?utf-8?B?ODV5YUNZZHVrNUdhL3BpNUFNUTNQeXo2ZW1mWks2UitHQmlyc3lnaWVDaCto?=
 =?utf-8?B?T25jN2F4amRoRGFpaGNJR0R1dU5NbEdXVDBMcEd5QXg2ZmEwM3ZJM3RJV0Vl?=
 =?utf-8?B?SXB1N3ZVc08xc2o3eDBWOGk3UVpUdTRHcGpma0M0ZEpxb2FweENuTzNmWmVl?=
 =?utf-8?B?UldnUlZMbUY1WDFSTVN1RDNNYkRBb0RKa05oWEtlZ3QxYldQVEJyMmkrWlZV?=
 =?utf-8?B?R3ZkYk1oVTFnalZUQkttSHpzby91djRoQ2FQbHJnTTM0MnV1M0lTV28yT3d4?=
 =?utf-8?B?UFJXd0ZGOGVoRjRPOWRwSUd2N2RRRnlEd3Y0SVc4eCtlNGNxdmFjZHN1Z1dS?=
 =?utf-8?B?QzAzeldDTU5aZTA0RDZ1ZXlIRkRXS0kvRmhKTTgvVDJHRUlPMFJUNytBc09I?=
 =?utf-8?B?a3Q4YWpqRzJiaG9qbEg0OXRZMnhCZGdJZVhGeFJPaTlNVWlhaEhHKzZza0cv?=
 =?utf-8?B?NlV4MjJOVFZma0pYOVJ2RGZSeklRS1ZOamRTUzQzN1I5Ukd1aEk5SkpMcnor?=
 =?utf-8?B?Wm5yWVgwYkZxTlByM0V1U0MxZlZyZnNTYXA5ekIvVGEyOFk4aU10MGhVK0tn?=
 =?utf-8?B?YjFEbjZIclAxRUk1NFJuZ0ZmN2lRR1lVc2hVdDdFS3ZSOVA4K1lNVGVxSUh1?=
 =?utf-8?B?YVBQNVFCQnNzQytNdTNLNDVrOWs0Mis3SFYwL1NseU5wT0tic1o5dW81K0Zn?=
 =?utf-8?B?akJpYWJET0g5MzZkeExMRUZDVVkwcUg4OWJEN29idXJ0U0ppUkZnYWN3WFNK?=
 =?utf-8?B?QVZuNktCZGlhRnpxQ0hhT0x5dkpVdXJURzM5aHYzUHVMNGs0RFlUTzRycnJN?=
 =?utf-8?B?d1lPQ29wQ09mYys4VWk4S01IWGRxcnhxWkpuN3FXTk4wY0Z0b0EwVlMrTXZL?=
 =?utf-8?B?b2x0M0k5bUR6NjZuQVlGNEx1U01OSGFoeFZyYzg5L3NEL0pEWHBSWll0K3R0?=
 =?utf-8?B?M0ZLOTh2ZUtCUTJ6MFRrV05SQzRhRCszWEFJZTVPVk91czFaY3U2RXN0Q3NL?=
 =?utf-8?B?c1c3bTZlOUJIV0xEMFgvMS9LZ1dkV0RmZ3hvc1d5cmhuOXNJakRLVktRd0dj?=
 =?utf-8?B?QWN5ZWJBT1hhT2p4d3Jpb29NZmQ2bCtNelcvRVMrb2VySm1NMWZQMUJwNXdH?=
 =?utf-8?B?MVlmc1ZqM2V1Nm42c211YnVkL1NUQmkxVTUyOUUxWnR6UXNxckQwd0poSGl0?=
 =?utf-8?B?eEpoVjRRWjdoMlN1Z2k1Z2FvQlJFOW15NWl0eVA4S0pBME5BMjl6eEVJbi8w?=
 =?utf-8?B?aFhEbURpTnpEZnorOWJGMndBZnNpK3JGd25Yc09Ub2lLbU9uVkZUMG9mbzVC?=
 =?utf-8?Q?sDRUJjJnJmfTcXtjfUaiMreI2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ba5ada-7bfb-48a8-d9a7-08db8d8d14f4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:02:08.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFY/JUlA3AYG1A0n8RNiTnMizM6HdIhMnUSahb0VUrzwLzweyuiQux32ZB9Ji3tFm3o1kK0hESXcWgmKFCfUtQ==
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
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 1c935b5bafe1..80e376802ee0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2668,7 +2668,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_msm_remove(struct platform_device *pdev)
+static void sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2687,7 +2687,6 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
 	sdhci_pltfm_free(pdev);
-	return 0;
 }
 
 static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
@@ -2740,7 +2739,7 @@ static const struct dev_pm_ops sdhci_msm_pm_ops = {
 
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
-	.remove = sdhci_msm_remove,
+	.remove_new = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
-- 
2.39.0

