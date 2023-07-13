Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C186C751B21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjGMIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjGMIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DC30C2;
        Thu, 13 Jul 2023 01:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1y8neyrvkY65NEuUIK5m49Eary57PkagbwpYeJmAxtl7S5TSoI007cggurLFqMx9tO2s0i+i/J6SQD+qExW34Pl4/cVFHXv8NSSh8A7F/fNYAYVbWyUoWQATcOTHhjXNMxQrrbB8k3ThLFyJA5m65QLx1+2sHXX3WfMCQH1SHzNpKmc58YTmqst+rAQ8j4CRoxMCd7/+Sx1YTMuy1ccjH8+YQEAfwWVo583aDGqe88weOoCke/bt+x+n1SQp2r8UNcqV44EJjAEUXsDn75SqEhDRRVT2TZs3st3FjreD4OpulaICN05+bTKVm/87aYTrHa5jM/e5PcvwaFUfiAFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqLHw9NdBMcVTHEOA1IaAb63aa7Km95uMTjhpgdnf2w=;
 b=EVXNV8ecrIrej4j/5Fx4IPtLXZlAAConec3HU5soAM1+88RqTMwTdM1eVzIPFiMbUOLAlDquDoyhJ+BDvA+FfUM5Y5PpBMISMD5DdsEiRziWUPhrIK63wwrqasnN/znqIE3jo9T/+NdTXIZMnWs9BhwDjI/u+rtR+DuRxmf4c2RvaaAV8FpUOw8a+hEAK/01g86w3m5BigCxvSmts+Z6HOmXeuSoVKpSY4n160NMcUIG6qcADjU/dKjg49/5d1lf4ROfCL6dXBLH2hd4uY0+AQZ1MbAafHoFDziRgdhx7SMYZ0r+wBXpt+WF1gdfoD7nRqjAlmdu2iAYRKLPqljf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqLHw9NdBMcVTHEOA1IaAb63aa7Km95uMTjhpgdnf2w=;
 b=VxvKT2/5PJdjIsLYyj7IdiiHSWsgkT+8HMoOJTiJVbkOyJGTCXEiJvDpf2l+koEs/OFeIWNzo7Dfjfaa/o/SIUqEVoPrpUKlk30oBurgFGCq2kvgBQ8PYM7MG9HdoCKAqNZRxEFDSu2eCJQdMhKMRVJvt4bUex3kwTWe+L5B1k4kuIVrZhNpJIruN36ANajd2hxAk0LOhHiarWVE1O1y1L6WnLgAUihhEAC2Ot3x8lbO6GqssxnhIWJzX7sO/QMEuK3tqU0xZQ0TQmhosQP7cTKfYsWDvYt3so4BUSKOauzGfs0QA6wE/oaig/V4BmJk5TRgYBN/8HKaDKP0xJfDhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/58] mmc: sdhci-omap: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:42 +0800
Message-Id: <20230713080807.69999-33-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e953bd6a-a935-4e30-d894-08db83787407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orirhwI29w7CNbDYiNKv4hx35GIRk17RYrM5KkvGP+WFTAiOxh6EGWWb+tG4GUIbLoY7mD/R3gJmyRnME8kGEkVjtqC150P5u2piQH9a4ymOAOaENkX9VhJwV8dAHiAZLJM+ozMD5g15r7vZx87wgbmGmCNgGvTjNjXGdmKhoAJPy1CmBurGFQqZzAh151AnoBevvLF1Rhjoa8jBjT1md04Fntw92l4jYW+krztXcAlX6+tiqFpZdvnCEjXFzL0OlyNB9q3W48ChA/3z+rXT+a/Os8AnlctnC8QjIh9/cibHPTlTn524SM8bqwhYMrY2gHaxhRAaEZC8VNXxUFUm/fnjtVzufTteucBNo9eMNBPxQXVOYJsmJ1764XIQG9fPe+maUS/osgmSe462y9wpPztvrjblO0NFj5jlOoFAxu+mTQsA8HDTHNwRFGNsGwk8JL+ro1xu66k6SSbxLVXAYagUzatNePL0mXMHP1tapVndTOgo7oVTpZSrtg5Oq9hQecjoloN1En05jIWtBq2dJJ3aWspI7bKsysurx6PXMgASllA6n5Qk3SXRA11XdydB9auYg3iY2Fucc7ZBuecxFDyYCUcvz1RgY02jHDg8VcTFNpn3yuJIWcxWqVmwCW5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(66574015)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndMUVJycFl2SCtzWW5HRHVjb3h0MWVQWWVSNytzQ2NzeERqdW1IWmFzV051?=
 =?utf-8?B?MkxvRzJsOGpSbXJCSU1leFRVanZESHMxVDN1cWJHcm9HSVRpaXdNamhhUElL?=
 =?utf-8?B?WkhKRnEwOTZJM2t1ZkFPa1dRdmF3QnNHeVUrYmFzVE54dmdQV1VPRXFPaFdm?=
 =?utf-8?B?T01tTDlOc2JZM1JoTWxpSjJwd25YTXh2TXV6MjdzUVcwbWNmM3lZVTF2NHN5?=
 =?utf-8?B?US9HdHZrYVhYblJ1MTBWR1pWOGFPZFprR1FVemFUMXh3RXhBQUFGVllwZzIz?=
 =?utf-8?B?MTAwdGVyT1dSMHBDY080ejJheTJlak85cUFFb1VEb1U5Tm16aU1zZGxCYW1v?=
 =?utf-8?B?MUtPbW9SL0poQlV5Rk1vNGlTOEo0bjRNMEJaU2x5OHVSZzZzakg5bVhSSDNa?=
 =?utf-8?B?alFPank2aWpYL0M1ZjlpanRvNWFENy93eTE3dEFMT2hhSFFSSUhRMmRyVFZH?=
 =?utf-8?B?bUorUnRlMERURjNoTEpqSm9lc09SbWZwUzU5ODBwYko5cWI4WkJ0MGlweHAv?=
 =?utf-8?B?MXYrWmpSV1loc0g0dzZKWVYycDQwVXVkRmx3TERYSkQvSlErcHVYZ0lwWUpn?=
 =?utf-8?B?VE5SaytGTEgvdEdGMnFCaWZnblBCVmlVckRIclZzTjR4ZnZOMGNhMytiUDVi?=
 =?utf-8?B?NVRIWDRKdGp1elRrV2lHZ0I4cXl1d3BUNnlJSUFjUFl2NzA0K2g2TzgxdUR0?=
 =?utf-8?B?bk1UTm02SzdvbkpyQldEckc4NExnVnJvdVM0WFFhY2ZlSWVybXA2YzhiZW5J?=
 =?utf-8?B?YUpzZ2lUS1psU1V4UVBDRlVsKzNNMVhLOXNEU0lGbTI0VE4vWmdSMGpNbTd5?=
 =?utf-8?B?dDEyanR4aEZ3b0hpU01UZGdTRGxGL0IxSWtDWm9yd09kVmVLTGFlaEpPaTlm?=
 =?utf-8?B?K2tueFF0SGFvY2JwQ2NUVWprb3dRTVc5b3lBSXlJNElLYXl3QXExdzlxeDU3?=
 =?utf-8?B?eW4vUEtDMnpvdkNlSHpWNDRmalBJR2N2cEtkV3k4U2RIaERIYzBwczVDTU81?=
 =?utf-8?B?VFJyVUEvOWtFS0tQcXJOMmtjaXQxajZ2WWdhOHZoeE9aYWtsdzhwR1N1ZHQx?=
 =?utf-8?B?Rnh0azRCUHBZcXZ2UmVIS0tmZGxBc2pVa2RENlRpMy9vNkNsUDVZYit0OHFU?=
 =?utf-8?B?UzNyeTAzTFlFazdDdzN6bk9EVFY2YlJNUUViUDdlREhZYUZ1R3BVNmpRYnNZ?=
 =?utf-8?B?cnc5WHdQbEdZQUZZZWhPWDcxVStRWTV4OUhURWYvWENhb1RDeWQ2a1pWNTNO?=
 =?utf-8?B?VzlxcGVJOFNTSGhHQ3VzUHRRdm5DZ0NVTXQ1eFh2MnVVb1A1a2dxcVprakJ2?=
 =?utf-8?B?cS9FeVo3ZXA3OGlqc1JxZTFjN3g2WlJ3K3NCa3FVdUpxSkFHOFdsaTkveWFq?=
 =?utf-8?B?OHNVZVl3NFVGWkdqejdLdXp2a2RXVUJGUnV5c0VLbk9qSldVb0tzcjNYY1Zk?=
 =?utf-8?B?TXlLYzdpSGpTdDl0dWpCWFdUV3kwbUUzM2dlWmhYK2xCVW1SRWJTbWJqN3Zn?=
 =?utf-8?B?TC9RbmpRQUZuYXFteUFLdEl6cjd3L1VJSm4rV094eHIxZlpJMURmc3NTNWYz?=
 =?utf-8?B?c2ZlKys4U3RQcXdNNndqbk9QRENxMm9ITjdkRmZMalZzWnQ2MzJHOEZNK01W?=
 =?utf-8?B?cTIzMGZxaWxOd1J6YjlSQ3E2dTFTMEt3TFVyZTFqd3M1eHlhRWRUK3FtTVY4?=
 =?utf-8?B?NGZBdDFKUGVmWXVGMmNyUVhhaFh6L0xmTWhxMEY5TlFqTlFHRExzU3dDNlFk?=
 =?utf-8?B?aXZ5S3ZXRXE1ODZ2QmE4QWtHSmxCNVVxbHZqQWxZNTRvcVNRdnNKdExNU1Q3?=
 =?utf-8?B?OGs2RWxSTVRBc3o1U3JBeVVObmwyMlA1WEhDVlJEb0Q4OTZ2RHZ4YWwvdzdz?=
 =?utf-8?B?MjJqUVV2eXppdEN4Zyt0N2JtYWFuSTVMQW1iQWdBeE1yYy94Q01nWmJlVWZs?=
 =?utf-8?B?SCsxUTBjMFJ2azZRYnpiNldyN1pmOVh5cFlBNXJqYjIzNmxTT215SlRqeG42?=
 =?utf-8?B?WkE3OTFjam5UZmpLWXdiNWUwMTdBMXJBVS9VaGxmUXNIUFVTQ1JFK1hoTkQ0?=
 =?utf-8?B?Sk5aVlRtbWk1ck1mcFdpM1lwZzBiZEJIWjR2U1B0YUFEdWVxczNaWkFUMmxo?=
 =?utf-8?Q?vA9HPvefB8eFUJQ91sD2TcnuB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e953bd6a-a935-4e30-d894-08db83787407
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:17.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgYoXJiUfqbFHwRqCB0XpiVpYRXFTIrkLD8EE5E2ZHzfiVLSOJCiNOKwES103vRqtqulJyPUT/mPkHP58TbaLA==
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
 drivers/mmc/host/sdhci-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8ed9256b83da..6aa77eb4a3fb 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1394,7 +1394,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_omap_remove(struct platform_device *pdev)
+static void sdhci_omap_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1408,8 +1408,6 @@ static int sdhci_omap_remove(struct platform_device *pdev)
 	/* Ensure device gets disabled despite userspace sysfs config */
 	pm_runtime_force_suspend(dev);
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1478,7 +1476,7 @@ static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
 
 static struct platform_driver sdhci_omap_driver = {
 	.probe = sdhci_omap_probe,
-	.remove = sdhci_omap_remove,
+	.remove_new = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

