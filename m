Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2591751AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjGMILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjGMIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:10:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ED35AD;
        Thu, 13 Jul 2023 01:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmQ4N1hc4WTk8EgW9ncjrAk9sIAFr1OlZqcBMcBbLR86/Ojt9/eIJ3gHtmBj0fzt4CgFkasF/lOww+VxRI4oq/GoUrNdlpSx0N1vEjoz+x2MMhnwR1zntZUqmWxdG8ibx24MPEnmUrEuxxEcaMn5QF9xK2I/eYfDKrxk8/f0iUAzd3AnvOpVK5d+zVryCg19dNBrs1UPmDlu2ayyBfBkILWUsOJFuYwwFsluyKlCqdamia9+b6ivtqJ75SkhnXAd7grLyPaKuWtisJbf2O84yZ+kORiKllTpkjz3hq+qt5RTXpkfUOCqxuQQ4skptolbGwgiEJ01dGhBCixVWRT/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=YfdbTvevFjus5JfIE1MhUUU7dQIt6ZgCsuGS8RLr7jcrdhNCFPMgMBr5qJ035YQTvTH+uvWwtfE7LdqiSKcCsNsn2i7qOMkrJ69LPXdjv8BZYHhdSKhPG+8FoVauZ8XEAefqY+MOGMBeIoNwtoC+tf3Sz7mYwnUDM3A2Zg4ZGZd448lgTH8E8gPDdUhjt4fv9/1GbxYt9yvBUEnOaiEq4tzbP7VI8xA2wholnU999zEDWRHe+x6N5cvegZCGM79WvIwvYd7qgiOYEUBLa1rtukzajcrw6d0uEDkDjgxRTZYpwpv01jlfLPA+XvWA6UCM83cOFctlivnTG36VkW4TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nbEbIK1DWhnXMWnkEWTsr0nKaN3qrg8h4rvOqRdbbE=;
 b=VhpwgQGAqqM86pyduds8zesmBFCRkX6kpsI8UU3iWXoASkaR/KmZJlAXcdNR/BRm2OCBhY1cJQq8Eeng++QYl7hNKAcn3ghJcXUYV51uQZHcaQONbuTsitR/vcrKkoWPzQnPsowemwVpZYv+h76g6T9xvXK6UkgnWe9F3BzLdKj0YmUEG+p+YbeNoenw6iqGT8sHphVkZ81or7qpagYVt4V/fSmhFV2vSGMUJNq1P5S1XhhUxZK1PYrsnkYnd2ZbbJxvv2pGuOQ6A9osUbk3/dIuPtHV/acrTV+5Mp2mZKkXoT7KDgThYvX++KEiEBjGYbvcbh8tD0uajpDUTh0S+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/58] mmc: omap: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:22 +0800
Message-Id: <20230713080807.69999-13-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9caa5389-43a3-41cf-3002-08db83785f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBriEl5jQ3udrR+MC7H1qFdlvocjloz3bghRZl4MyPHF2UwSvcHs+UT8npjkRqx++DQJMOP3p3cTlx7S5r1IY1hb7xHHFanlZvgZ1KCCsiQ6Venus9lxR7dP8DLJLvT1/GZz03vLg0teaP7IZyuQCLLv2OLgNgs9Ik9nm29kYBRm+GQ8du1DXFx4DdwPV5wgFl5RrPD8T5Xi9L2+agj7ADVrbwmRUC4ReAdYHLb0ytGJIAIagJ5/Z+WSwAOZwqJIkrLDqiM7FMn07H1oNXZspz+VTN8175Xut6O5eLWD9/vDviKT2FOOMoyIZc4YqZXMmFG/WWQVO2pRXKDrNKvr9S7tOMB1r9Pm2mAweQufxCwveJCRQA/eV3BMxWbNXSzO7p6uZCBI6Uz7muCQKSxZ0eMMky5Y8UQvsbKwGaQAyTkgxN1LPZ96L0DhJhfG4oY4T/yzDJHAX6vUWaSil+PB9nEQ/8PMWQBCX2t9z1050ly784QbsJ/IxvgSuKBG/ItxRdblK2FEniT+E1W66jqkKhuLq9ObeD4Z26OajA5jPWvPX8BWVxjw46MZaSJkGdlODNfne4YtxfogCyr6R8fHxe03R+LN1X223tHNg5ZHPmpIuzfdKTx7rfjPt/N3lE8CBeLb9vXyD74OtNqbTnwifI4f4JtEnHy9ydvoI3MLtvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVBSDZrdndXUnpZSHg1UUhEUkU0aE84TXpDU0FvbFBKTXRucjdPOGFWd08v?=
 =?utf-8?B?d0l2Z0pwbVR1Vks1bDFnVUQ3T2M4MmMxUk1aQzcxZ0RCUGxBblFoeTIwL1dQ?=
 =?utf-8?B?SjBuR1JHOC81MkpUWXlHcEJWeWtveTdqQ2llaEQvekhwVEE5Qy90UitleTBI?=
 =?utf-8?B?bXR1TXAyNU11TG95VFRoTENRSVdnNjB6aC9BR2hoYWk1ZldrM0NTaFdzUVBu?=
 =?utf-8?B?SUtSWFBtVHFPblNQdDRING02UkplbkxmUmwzeU4rUHdlSWxpM3dFZVBCSk13?=
 =?utf-8?B?cE54OWlXRGJLNU9oZjJTNlBaNmk5NWR0dVIrS1cxd1ptODRLY2s0bExKeHNx?=
 =?utf-8?B?Mk1lR3EvdUQwVlBwT3dZVjRiVzBTWWZ6T1E0cm1DOHdmUnp3WWdCb1YwZlVt?=
 =?utf-8?B?bGxpNklhZTlDZW9yd3ZETkpmd09QeWE3THNHNFIwdmlPU2FXM2dRaW5ETDVm?=
 =?utf-8?B?UGhnM2VoSE1PMjFKNFQxeGRIVFF1MWNPYWxkOEh1ZkpWZmhpRnZQMDBRVUo3?=
 =?utf-8?B?SEJEM0poSTR0OTN1VWhDOE4ycjIyNzVNdkZCUTRtOStQa3MvTkFlbmtldWFJ?=
 =?utf-8?B?Ykt4UnRjbkpTOW5YdFM3MlNTZFVmZnp4TmFRclRTeUxBK1AxUWIvQU9GendU?=
 =?utf-8?B?ODdieUptSHhneWFpK2ZMR21OUEJueTNGMGQ4ZHJCNUVuY1NSc3crWWdOVDgz?=
 =?utf-8?B?OFVSWmhUOFhRMWh3TG5MNTBDMXlrazN6MkdFZ0dtSUR4c2M4UjFwSVk5Qmxk?=
 =?utf-8?B?Q3d5d2lxeGR6bURwa1NHYm1oUE9rOW1LSzZRNkJDR1dRenlKTENadElVR2Ja?=
 =?utf-8?B?V2FhV0M1WUo3aVRhbnAwa0hlUkk4UE5NVWVzeTB1Z1JqSnV0UFVad3YxQ0l2?=
 =?utf-8?B?UExNSGFoL2FySkQ3L1gzRHNKMU01eGFVNXRDZHFwSk54M1R4VXFqVzhiVkh6?=
 =?utf-8?B?RnlLbjVTaVVqY1JXbnRubS83ZC83SjBvd1BKcG9zeUJRZmtLeUZCYXFoNmxF?=
 =?utf-8?B?ZnlvZ2ZhM0JEcGp4NXBvUVlrYitKMktkVHFSZ2o5ZEtnRUplTlpXNjhrQmVR?=
 =?utf-8?B?bW41Ty9XMUoyeXBpSFR4TnNtelZGQVF4Zk5pQ1BseDJkMnMvOVVSb3NJaVlJ?=
 =?utf-8?B?UTRuQ2l5ZG9MZWlEaTk1eEFVdXdlY2poNmNFcDJkdTV0NERaUzNZNVdBbG51?=
 =?utf-8?B?V3RhWHVIc2hVR0Zab25HM0szN3FHOFVQbTdrWlQ4VEF0ODZRWFl4eFlpaDdU?=
 =?utf-8?B?dnNGcHM5bkVtbHA4QVFySHpzM2ljdUg2M0h5WXFNeHp0QUl6Z21vQXpmQ2xH?=
 =?utf-8?B?eVNDT2xWOEVBNFFOdnI0OVI4ZFMrT0VEM1NRREFlRi9Lak4yY2pVUi92RzZa?=
 =?utf-8?B?T2N0VXc2Q0k4QUc1SkJPUmV4MnNucWdWOGJCUmVQc1JGVS9GNmJqMWR3RTRE?=
 =?utf-8?B?U2YrdHVFcWhxTEFpbDBJRzM1NW9TZERrN2ZIMGw2dy80eHIvZ3hHZE0wRFI5?=
 =?utf-8?B?UjVQTy9jY3NaOGdoeSt3VkJsbTRRZ2pOcTZwblBhMDFaNVZNcjRQTW5zNTJn?=
 =?utf-8?B?dGN0T2VKamdlSTcxMnloblRKakpiVmovRThPc1JCUlV3ZDIvTnRqaVVGRmhn?=
 =?utf-8?B?ME1MZXUrTk9uVDFiRGR3QWtqeWphUmd4eVJBZDFqQWlNdlgxOHRWanJaaEFB?=
 =?utf-8?B?MStGYWdsbUVUc1dwekFKUDl1bnpjMDVIck1qKzJlOVJtT09rTWVtbWJCTjVh?=
 =?utf-8?B?SGR1TWZodVVrNGxzOTRxUDlUdTdmOC9VTEhnOFN0ZGFWYU5tZU9LaEo1SHo5?=
 =?utf-8?B?YXB6eHg4N1UrbHYwQXhjUnZsRVNIUGtUUEs2U0d3a3lVcEMwclR6VWw5NUl6?=
 =?utf-8?B?YlpBNWJ4Z0NmWFE4bG5mV09FSHIxL1VKeTRpcExGWHlNVElhaFk5Vm1BZUxW?=
 =?utf-8?B?UysyNDRKT3FsUGlwMlRnQ3YwM2s5b0M2V01EZ1NhWTZnNVV0b2c4dVl6SGd2?=
 =?utf-8?B?UVV4WC9FbXczbXk1R1RjRUEzckQxNHIxZ3RjcVQzVHE1QUJpeUJ6YmJ2enFw?=
 =?utf-8?B?QmF1S0tVMnhTUG9jTWlZTXJKOXdNc3AvN1htUTJKaWFPWllmeWdTK25jakxN?=
 =?utf-8?Q?13Ke7pV5gEwzeHuBAhrxCjNop?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa5389-43a3-41cf-3002-08db83785f38
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:42.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+bBvtYapY1H0IE4d2dLKP88FupARbFpqMfPNESsYfr4cS+Y5OUz27K6+AvXtADfgqK6+siosiox3mbnuE5hDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/mmc/host/omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 6a259563690d..9fb8995b43a1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1506,7 +1506,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mmc_omap_remove(struct platform_device *pdev)
+static void mmc_omap_remove(struct platform_device *pdev)
 {
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 	int i;
@@ -1532,8 +1532,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_rx);
 
 	destroy_workqueue(host->mmc_omap_wq);
-
-	return 0;
 }
 
 #if IS_BUILTIN(CONFIG_OF)
@@ -1546,7 +1544,7 @@ MODULE_DEVICE_TABLE(of, mmc_omap_match);
 
 static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
-	.remove		= mmc_omap_remove,
+	.remove_new	= mmc_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

