Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611757629E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGZEHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGZEGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:06:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1849F6;
        Tue, 25 Jul 2023 21:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWoaSlAVcgObvVTnCHlYciWuFsyftkiaMdMgPrNZx+yJGi2l6D5jAi3PrMl6oAcMhVsphPoc7s/GbTY/Dg5o0jZQXz3GcZAoZW8cbz6WNndXiAzEDXspQHLg4HF/BdSp/pHbe/QdofW6DtWHB6gjwkni8wqMwN6TFNXkSWFDm7ctmarQO2+mfqOduxrqbWJiZnfIaU056F8etBc1Hqrr8OxnrPBgDvIgw0z+pcJP9VgYp8vLc7TuyBu1I1CcMXvkGoanVbgEkTgi+lvYHWaMjNjLOa6ZTDdPHTwJClMMu8Gi68Yk93lNSVnp6cUTFowIA7eRbfWIO/j7+6KYuXj1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpY6vRX9+fV+aGIzDgKV7CSAOZ5ZunmmE0jQlRuvPxo=;
 b=Zm+IluGQ8gmKJ7fkjXNQV8KQPbm5YHis121TbIgOcC33qNkbru3f9HXcNNN2d73cEm9VQ7uOHs/6Sa5NJpdKqVMveb0ifS7h6reJNeSFl81I/15TFfLpr9e4AjpNe9rJWJVt8YHfmIXV86N1GoH2N8eyQeVrAVnIXnmxtcA+nZ5kckUTeiFoiQef5029o0LhyF+JSNTuVXJyqvkSnI/guXeEK1ejcshzTr4b7N1w7/MinP6OOK+ho1NQRCalZrYFc0Vu82d7PzUB+DMHRZsEqXST6YebR+L0NRGhXEw0cij8AXbxPy1Ax0SPmr9najdvsEg78QdiGyml4SyjqMPL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpY6vRX9+fV+aGIzDgKV7CSAOZ5ZunmmE0jQlRuvPxo=;
 b=Kcs9Hb2E9wiiiyQK0VrVF+Z+XTMWUtEQRP5CdaiFmvm4v5cK1WkAgX0lZ8zfN4uHDxJWd47OlniWWdTTMlnCxAPeYMM6DuwiNkmLI822LdKvAOLOPSFXnxQWlOaNopne+kuAGz7X9NSxtwEKosBLH9CDuzTFgPXiyz4E68344s/Vo29LM5xEbOLg7ooapOYMfJujfpv8f74p85+t1WkZ7rNNV/GPmw1zoAuQkd664ZJ/cH+LequSYTMYxojk//1mLBJrlyY4+6TmjH8zSL2H5jtxU7TVLgFPNUr57yImGbh4lw9PuCfzZOS0Uuy1o8xN6CnDAmqBqw1NJuDG8GhMfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/61] mmc: sdhci-of-dwcmshc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:07 +0800
Message-Id: <20230726040041.26267-27-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0de16ae8-35d6-446e-ee79-08db8d8d06cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awX8Ert1yVo77p9waaq10jzd1wLV5XCgt1mN2JWBJ5fj/QxS6HtvOF7VM+gYqlYSV1yDENGFc+5dntp+xNqg7T6doWz4l1h+0kR+ucIn4eqWkXGBo4tNn/1Wz2O7HCNnIzvIxoGBoEJ9U5NVXIaz3Vf6qEwLKmx4dOSINMcR+l3Uz0iv0FCCiaE1QBb8AyAoZn8j0tKz+fb/MRI0dXCnFdW17O8j3V8AIXmZAqdaQOHaHMQKA1je6PUHTFOn5aQQqJNNTZJKprvsP7KRCxRw2dApPqdV/jb/HYwPCiJuZr59NgqSfD4C1Kmsn3JbkiNWQhiTcFgL6RYefYEp3ztPIKfo+EHt8Y1LghYgRU4mhxdiuYiqbal4qYegWNOkNuiLkWDOHMSov8jVH/jPpH6RBG/x1DKcjzTRZGscfYMQgQnxnGoo5nfxO100HB4rtQrWYLUgXO282xAYuCGoQvvU2KcA2xkupCRqTFzSPt66HIogz/0UK+ft7i4aJuQkmELzmkHEu4yb0DWo+LKyWd3jzr3l9duHJfHKmvDmFyWfyCf0AGZa7bxPpIduq10Q1iZr7OOHjXDUHE9gATCwhgJ2dtrxLBrOGw575NSGt9a7WuIfK6ymsmO3OsC0Nn1RLz3/o7Vs6+tygFN1lcrxItq07Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlMRVJVUk1nUGxldFlrVlVidnhxTytBV1RPUFJPOXB6dkpGUis5ZWZxQXBo?=
 =?utf-8?B?b2p2K2RzWjZ5aVNBbnZEZm1tQWsvSWFwL2llZmd2dy85TFowV2o1NlFqblhl?=
 =?utf-8?B?N2gwY3kvNEx2eFdqVURNb3NVNTRtN0s1OGJOb3ZKQTRTVm9IVGVnTlZ2dk1X?=
 =?utf-8?B?cWtYU0QxSWdVL29sYWJTeDFPWVZ1cUI5Umc2ZzlFTCtXd0JZTmJWM2owZmZh?=
 =?utf-8?B?SENmZFhOTkVIQ1psY0VCTkwxWmtmQWFDOTk3REljallWeGMvQSt5QXJES29l?=
 =?utf-8?B?ZVhQUkpVTjl2MHd4WGtmbU5JczNrbDJXY1dCQ000RndDVWpLQVBBcUVsaElx?=
 =?utf-8?B?THpqWEg3M2l5Zm9lSndZOVFTenAvVlpyNnpSV2JGQm5FVHVoU1RqelZ6SHEy?=
 =?utf-8?B?RElGbGJRblM2NmNrelljQThKRU0vcDR6ckpKZmJIVnhnZ0tDV25raXNZTlFx?=
 =?utf-8?B?OEd3TlF1SzRNbktja2R2RUh3NXFUSkZJbnBwME1PYjBtY21IOEV2VU5GbURK?=
 =?utf-8?B?ZGwwUlFneDZGejVQRXZEY3Q0aVhSdVI0THdnYm9iRkJ5WjJld0RhNzJxb1F4?=
 =?utf-8?B?dVMxTmJ3aEVDT1VxaXBrTkZPZUJRWVdHMitmM1crdVVDVzQrZ2NsYitwWHdt?=
 =?utf-8?B?UlpZNmRzbTZOTHJERWNFajYxRWJoQjBBZWhsdlBwZTRWVHFPbExjYzBJMSs2?=
 =?utf-8?B?ZmVMdTF2eVdJZFk4Qzh0b2J6bjlPMk1VRWxnbXR1RVhpM3ZqdW1pNGVFZWZT?=
 =?utf-8?B?RS9rSXQvUjg0dkpsYXdCaExkQzhyaW1Ca3hxOXo4ZGFhVG9GazJrZ1Y2RFgw?=
 =?utf-8?B?cXRKOUJjMmNpYTU4MWdaMXZzKzlaQy9SOC9RekQvVjcrRjEwZ1B4bG5uNDJ5?=
 =?utf-8?B?Zm9nNk1LWmp5R3pUUjBmcDk4Mis5cnRNZjY5MklMSTA3WlIvR05BNFhFckEx?=
 =?utf-8?B?aW5EOGdFSjNJYWdEVHZEOVlQTUpiTmNqMXdYOGFyUzhMR2RhSVVpWE5yQllZ?=
 =?utf-8?B?RjF6TE1kUW1UbnRXU0JyaGVJY1c0ZGROeit2Yk5TdmN0aWxGTlVwUFBpMmxY?=
 =?utf-8?B?WGxhVGJzOTVuaDFJcTFBQ2JEbGJIQVgvdFpyVm51SjM2MDhreC81WG9RMHZ1?=
 =?utf-8?B?RUFjVXNsL0xIWG1KQ0FqblB0R2R1TDVhdE5oM2NQTWY0bkI3b2NoYWNRUGw4?=
 =?utf-8?B?T2dCN0QvaDJBY1pjMCs5SHdvWkdJQ002N1JqbFNaY3NpNnluQmpya3luMkl3?=
 =?utf-8?B?L0xDYUJOZ3pmVWU4ajZzMDhiRDBrWmE0S2hPSVhFTnllSFRMMVUrbzFpQ3po?=
 =?utf-8?B?QncxYkNwY09FWUZWckZWMXZscGNKUkJHMVE5dmpIUTVFVE9XTjZybXY2aTh5?=
 =?utf-8?B?MktuTXZ1bWhYL3ZUOFE1eld0Q0swZDdCay9zcUk3SVJCU1JaQjF4a3l0S0pH?=
 =?utf-8?B?SVlNNG93dXB2YmgxMUpKOXE4N0JuUldsNjVmZmo3VTJjcjd1SE5JYnNXRFcy?=
 =?utf-8?B?cHRJdTUwd3JZNUNodHNLMGRSOS9hUmxnVnU3ZUx5cXB1QjNnRnZYc3hNUUlP?=
 =?utf-8?B?TzBQNmFLZldOK3BzZ3VoTEhKWWNXQ0NmWWs3TExlamlYR0paZnJNcTI4b2tH?=
 =?utf-8?B?YlU5by9QTG0yS3NQVXQ2OUxpUkhrYmpnK2xXQXBUeTdQeUNydzRhM1NrN3Rn?=
 =?utf-8?B?dURQMHEyODBQTVZQR0RYUDRaL1BtMGhBSnFON01Cd2YrR3hQVHJpRDYwMDRW?=
 =?utf-8?B?NUNLWDBsWVhkQlQ2MjdLb3k2d2NvZXI1ZkExWUxCU0hiMnBQZWdIVlFsV2Z6?=
 =?utf-8?B?cXFLZnlQTE1FYytFSVMwYXZWYkFJVjg0SDZWRk1QcklDbXBkcUxPTTRMQVhZ?=
 =?utf-8?B?Q3ZBTDExMmtiT3ArNzM1bElNWC9RKzlzUGRGdTEzQTZ4QWd1VUsyTkN6MEND?=
 =?utf-8?B?bzB4V0dWdDVZRXo0M0cyaXdEYmFkejJoams0TndaYTJvWllNUzNPT29aY2Nu?=
 =?utf-8?B?TEl0Y3ZPY29Jb3g0eFZaaitJOE44M2UwNEtIdHZxUUJnYXo2akZteEE4K0Fk?=
 =?utf-8?B?N2ZDc0t6ZEFDcDdQQ3BuY2hMYkNOc3NsR1lOQVZrM3I5VWhkeTlRYVQvTlhp?=
 =?utf-8?Q?41fXYecWa2QqJD1v3GPIfPJD9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de16ae8-35d6-446e-ee79-08db8d8d06cf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:44.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdcvNDIJbxBNL9icY999IUoxSkg+nEoD9jGlQyjhZgoNesTKHxcfEorTapCfon9pknBhzNHhGB4BX9NPMIvDlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..5cfd24cd33fc 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -574,7 +574,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int dwcmshc_remove(struct platform_device *pdev)
+static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -589,8 +589,6 @@ static int dwcmshc_remove(struct platform_device *pdev)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -657,7 +655,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-	.remove	= dwcmshc_remove,
+	.remove_new = dwcmshc_remove,
 };
 module_platform_driver(sdhci_dwcmshc_driver);
 
-- 
2.39.0

