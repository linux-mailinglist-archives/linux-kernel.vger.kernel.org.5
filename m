Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A647647E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjG0HIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjG0HHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:07:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C69E0;
        Thu, 27 Jul 2023 00:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZmCHmTEMhCbD/7vGHr9vp+LZfBMVDQ0yZT+g8Z2P2gLjnc59IWiuCamZV9YNugSzw+gU+hjSZUWrkboCfhflm0U5mgNXOU/BtsgzhWfLw7zIKt7peaW8l2HPEtu8MdMP81Xe1n+aHIF0Nj/KO3OvwEq9ud4MqMnI9a06tjYCboGaNCXTggS6qUNI72QCZGCzowIGKWpXLDzM1ALBbMXJhGbCR16AaOSaALPiKoWgbRcyguTHzpvap/OVjJbFyI7cBxOQQgOKP7cqsNb6rzLEuM22TgLAr3rGVXWLSGq+IUzJAV22nW8eOrEjaUmjuBRYn0dLmYSU/byGVORJlTCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Wq3D3MP18gp00gViiexlDEzaE6ODfTIsN21lyfNhC4=;
 b=UUZXl0TwLfLyAZ+KilbasVyAOgFFfmPpr5faEK48dk5wIo2JtUwWMyMoxkmGPECyQ04gJHGptDI9H9k2laTuxtTBc87094gREnbLHFpWPfhweQCNmWjrJeYU/BSrDbe3a5WAq6rI8Y1RvS5tEkxVVcdWoJ4qigxQDZZ8WdfixmxpFwD3TZPikbrBsCbgkeMAWi5z45haCsvYkhLFwhKRSFMCeBLPz7/Lreu52sUGz3q2LK8Ly1NZtd9bDgAxU8oB9kTU5O2APotOBIGlHldcwQB5pe5Lze8vABSLS/3AKKEVHGofoNv/YZw1wxXqft4XVaZgIHcUF/GlV9BZepG0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Wq3D3MP18gp00gViiexlDEzaE6ODfTIsN21lyfNhC4=;
 b=iDNb0JaUjEm0NE71hxkwX13JWMSchrNaExE9DOq9ZClKM2jXmifaQWUZIva4pTjjuXTkDXEPU3wg0N2ALlJChPDu5gVkNFrfrYg/JlyXNrv/PrmMNxfGPLuw4IXGfeKqpnWqCbafyLiyen2b9tELGklHF4fSmq4q/crm3vZwS2gOo2fgTgYlmunbyIhZkfWg24pqMgoLN1ODF5dGMXRbf5XY78pMql7cepa64e8OfH5N8lyrWKtWZt2/+VSdYVwVpHL6olDxG4U6BpPyD109KV2etOk69L9eJX5KYy859wkg16Ct25PSuFhqZTV3/PZOny05wPOFnw3A+BRHBTVl7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 59/62] mmc: sdhci_am654: Properly handle failures in .remove()
Date:   Thu, 27 Jul 2023 15:00:48 +0800
Message-Id: <20230727070051.17778-59-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: afaafa2a-a1df-406b-e7c6-08db8e6f798a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcWnBz+gIw8bqywvX1/HTp4Y21SGp1Tr8MvJ4F+brgQ06W8fQiYBfZj1/LBz/yq+Ok7i6+S4NqoeRChZo1zFBJEuJso/dZyb9NZxmhRIjLvkVM44FC+BRc2qYt7Eql2MRnSQ+mk4TVsIMICg3s9rBZ2S5oPAHFE9clznVHHJmnyIVaOMZ2v/XytLHLoQunWWEaa4wylF0tM7TKgCbiaidnEbZz7LgQz0Zpq60sb+njoTiuVF4hDKWyGQmF73jblEVl3DVLIavhhoClZecTEvTZ8LHapiWQ/yUgykcUQuSRUIoRU8Ks3CNIui9U+ghGCY1H+meZqecsWdyHrE1E1eJA965FJBXa3nFQCkBrMe52/xSgmb+vPO34Ui6FBSltrycY5/EHNFhykgOuZwb0vEIaeVtI2wHqVTzqPOKsKjK/m3TA7V2bUONVuHLG3PBdeCD5nwjRMQuJH5Gge95DWVrN3iTgFcJ7qoNneqg+tEsNMqwJAkuaemRWjCBP3Mb5TDfzH76+FsWlfrNobFQJv6T5OL/JIe3TB2tCrujCf01MOo/saiLcaoAHyJtuzIH/Ga3OwCJfnOzkFTCituf4pfKsfmszicnYaV8ypRPbqnEb0JgGWkrEHqRxcmbQtgytT/ZN0iKJhdCDjcL9ixI1w+VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(186003)(2616005)(5660300002)(316002)(8936002)(8676002)(2906002)(41300700001)(86362001)(36756003)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xkWFNSNTlqWEVtN1gvaFpBYUxXblVUNndkZVBxQlpEWVl0NVRrQ0Q4T0tO?=
 =?utf-8?B?ZjZjRC9URkR6MmYyamxqcitDK3dSempLZUJDTTFEaGtZaVVCdzg4QlU2WG5i?=
 =?utf-8?B?bGNYSFd5QzQ3eGdTSS82aVBFZ210NHR6dzMvT2hqeUQzQ25SakxyckdSTW1o?=
 =?utf-8?B?OFFiWVREN09wUDFwczVLaVpmc1RrM1YxRTlVdk1XMjdJaFIyZnBaNzB3aXVm?=
 =?utf-8?B?RlRWMzkxU0ZmZk12akJ6R0dMb0dLSTVtTGhhVzlTTDFVSGZLYkpZUnY2d2Ux?=
 =?utf-8?B?UW9WQWRDNTZxcyt2ZFRHMmcvRTZEVnIvVnM0WS9pSmZCS0tyNjB1RzlvMDE3?=
 =?utf-8?B?OUJWTkhENXBqckZSME9OaStPeWxaa3UzTDJUVWVWYzdVKzR2VjJDb3gyL0NR?=
 =?utf-8?B?WHJPVEpERHpTTVA0Znp4RjJ1NjNGM0xLeG9NOWE4a05WT0tnQzRtQzJhZGV1?=
 =?utf-8?B?eHIrcTRXQlBNNXlzbTZlODVQdTJ2VUY0cEpvdkFhei9oeHVzS1VrL3FxVkR3?=
 =?utf-8?B?Nll3TWY2US9xekx3dFAwUFd4TzM1dDFRMDFPWlBnWVErRTI0TDF4blFIbVpu?=
 =?utf-8?B?ZUprS2U3Qk9XOXdkNVRZUmJYQjQwV2QweHQzbm52MUI5ZUNSSElya2YxUWVj?=
 =?utf-8?B?UjFZdzlaNm56VWFDZkJtY3JkSXFuZzZ3cnhQY3NjZ0dWL1dHWGlCQUFZVXhn?=
 =?utf-8?B?L1pKRVI5MnQxY0VvM0VYMklzVjJ0WGtkUWk1NE9lQ1RkNXlzRUFHMDRsS1h4?=
 =?utf-8?B?SUdzSlcxcHBSK1BvSHArNzZKMXlOVTBUSjlXY1VIYmtwMTZ6ak52eTB5S1dh?=
 =?utf-8?B?T00xQ3U5UG9TM3QxNHhjMDlYMVpjRTdIYTBxenRoRkhDQ2dZaXZURG9WSjZ4?=
 =?utf-8?B?eXpUNDdVaUd0NzFDN2VDQ2lwV2dGYjlsMTZmWjk1YTlWM3FDVE5yZ0lGdGNF?=
 =?utf-8?B?Zk0rUDNPOHlJNy9LYzFaR2F4bTFTT1JvdFN0Y1k4VWd6S0w0elFVTkN5cWQ5?=
 =?utf-8?B?a3FmSjBBc3FJV25hdkJBOGtXbkQ1WUl5VEsvTTlSWVo1NWY3M1dMUzV4ejdD?=
 =?utf-8?B?ZkZNcTI0UFo0Zm5uUXBLeGhUbEoxRUc3OWllaEdZZzVnbWxwZUZCZ1NTenA1?=
 =?utf-8?B?TXNlM0o3c2FkNW1Iek1SR0VJZGxUMHpqM1B2SGVDREtEYVZ5S1ZQUlAvMEov?=
 =?utf-8?B?aDlRVWkzNy9hV3JPMHlYVkVMd0paWkorU3FQV3I3c08vSTVtM1IvS3crYXFP?=
 =?utf-8?B?UkFOd2NibW15NzlLRU90eXgzLzFtQjR3S1psWWFnbHZZQzROSWN0cGlveWNz?=
 =?utf-8?B?UHMwRVhsMnEvMVduQzRYYjRtOUNKOEMwVW51aXpJQ1J6T0JMNnU2U1BCQVN3?=
 =?utf-8?B?d0lacXdrT0doTFp2QVNHYnZ1MkQzdXJna1J0cmZ4ZytZa2MzVzZ3aWVTUnZB?=
 =?utf-8?B?K0hsTmo0ZDl2MEVES2xEQ1NpNXkybXF2WDNuWFdDa2dGRTZiaHV4LzhKZ0lo?=
 =?utf-8?B?aWtXcU5Iem54TTVuMEZYdVBwUlZHbkF1VWJBUUFhTjZTMEx0OVlNbmxxZk94?=
 =?utf-8?B?VkU2Y1VrTVlSN09GWXhLZUhPMkVsVnltYjBGalRvL1pFSkdoY1l4eVpOb3M1?=
 =?utf-8?B?MFFrUHE3c2ZVVVBkNzQyQmhwVDhzMEgwZG53cVhYbm4xRFZ3bVlMeFZnbXUr?=
 =?utf-8?B?dHIycFpYNXdpOHRPYXBQbEd1THJ2OEZqVG1CVVhNcWYrbW9JTU5DS0w3Qk5J?=
 =?utf-8?B?WG9BbjlmdXltaldKRmI1d1JqNDZzeXlDUGd1Z1dRaCtTTVp3cklmU0FQZVVh?=
 =?utf-8?B?N21la0ZUb0R2bDVXdWtZWW9YYUgva3VacG5adWI5SjlQMXBIdCtrQjNRakh5?=
 =?utf-8?B?M1ArWlBqemtnNFVBMW5heW8xMFI2c3A0ZHVGNWk0SVlsYkM0WEtVU3FjN2Vn?=
 =?utf-8?B?YW9ZMVdnYU1GSlhnVWZDeTBwMDJWeDdwLy93MGNaUWxQVmduTnVuVTgyNnZR?=
 =?utf-8?B?b3duYVdac2ZXNk5pbFpGT1VYbGdyZmpobGJzbnkrM21wS2F4ZXp4SUpyUjlF?=
 =?utf-8?B?eGQza2VTQ2lHQ3FsSWt2SS8vR0ZWeGtFa1NLWWxMdDNrd0IyZGR0WVlzU3Zs?=
 =?utf-8?Q?zx6EaVu3d9QfgwlZUi/fh0JS2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaafa2a-a1df-406b-e7c6-08db8e6f798a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:43.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKFCjM3yAPKXNTcm+9+ZYdlmR4IEkMDe8J46lnS4KWVknFJv2Q8R8HROkkunF4s8ATzAWhGELBuhOTuO2z4gTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning an error code in a platform driver's remove function is wrong
most of the time and there is an effort to make the callback return
void. To prepare this rework the function not to exit early.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sdhci_am654.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7cdf0f54e3a5..1cc84739ef2f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -870,16 +870,17 @@ static int sdhci_am654_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0)
-		return ret;
+		dev_err(dev, "pm_runtime_get_sync() Failed\n");
 
 	sdhci_remove_host(host, true);
 	clk_disable_unprepare(pltfm_host->clk);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 	sdhci_pltfm_free(pdev);
 	return 0;
 }
-- 
2.39.0

