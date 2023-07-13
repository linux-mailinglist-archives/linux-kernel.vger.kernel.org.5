Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA874751ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjGMIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjGMIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DC2728;
        Thu, 13 Jul 2023 01:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlCbDpAc+xsIqszROf2QZ5pqYJ427AWUKvXrYS87BqVp0IKmoTM7nMt/eFd/jjeI9Cke7nQ/nArg0T4Cwana4Og0gzbAC2Kd7taucRIZVL5czAb5BKCbX0Ddck+B4gJKTqItkIqAFYNPkh7uTlwPRrnj5EP6fbCNR5WPduLpegm5cpU1lhg746iGdtBIFbJHx0tHdq7fVVlVU+6mKBY8GBc97z1z341H1cTCZnmEcGzrSw1C/pFX2e2/z65riS6Kjk0ZGN2oeHHZNRH22zxmeb9yMray9bHF41vWMyCFI4E8b+OVB78YAKimSm6ipLl8EXsZI6GG7MrkHk0+13IIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP1v+X2aVc4DKwgxtQDwQRCU/JULLF8ZyOfeP9A2ytw=;
 b=mrq8VGk4rwHYA/Uud4xIY3UiK38UCPeTslQ/pCb9eG1fve2NsKpXLNtoAzpy8z7/KHCXU3gGqNVw8eMkJbLX6tczs8EGvaCelpSRJN9JJp3Fp7PW8/EihP7x40doauYDs6a3w31ig9qYoxhgRlgeQAtUhc0IT2/+Ac/7VKV/tMujPUygeAIMjmpCh4PVO67ExPeI9vlBlUOx0GxhYqCkANcBdFrdacqwCbssj3ngQ/425Yl31Mhr22uNCQdckjcvZ8PkXyn+zYknrvaF5PXICivVVIN4+syoFVPNrM2Bw64W4lrzdMLJ2B0CSJWX0W/849sAk8i4qY4vEOw5ljBWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP1v+X2aVc4DKwgxtQDwQRCU/JULLF8ZyOfeP9A2ytw=;
 b=bl59gsStgmf8yApfy4l221w0ABUg41HAXgn+YTwnB1z57EnS+FaiB7DpFKc16yQqc3ikfu9xPUloBCGxoBWAGGus0MJVAIhQdDX0pB+UGLkV6zmGO+5Eqh6xvXYsxNoVkC8mjtlaa3S75rzcEANVExyqYINWibev2nbiaVUYFlUSqooASX+fuOAIQLqs2FmmmEoxngn2wz3hhEYAk+GExm6akGoaZYiVEptk+IJML+wmW5wYIloE+SHQUbp86WsgynwJLvDYFyEbSuEsUgiL0kKOpLzTMQ66iicxHDVX7ICbltAQ86hGUUUTubCRS9mpDPO5nmiPp/poH34ra9Xlfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/58] mmc: jz4740: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:12 +0800
Message-Id: <20230713080807.69999-3-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a9563f4-e10c-4f98-03c0-08db837854c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glPuWNhoy14xkL0JNnwn44B+DTbY05ZBvefxIsJzy+/8czzFsfNVn3VjzZXVg4atyT1vEBOgIZbawspXnEQd1cE81ZaKapQ8xlgS7e4wKJUvEOj01+DacZFzJpkn5RsKq0zT35xlnKrhWdmn4pxbP3j2mNFPrUOHG5Zz7AiUbNpTHcByMjCo8DWNwPoUWuIwY5c4mDLN55KB4f+Z7b/FZnLssbhQyKe7sDQ5gtGGvDNIsQUEG0OyRClA/d1p5VxgGNI+YhkLLvVo6owwaH183P5Y2LJK7vB81sF3Xfhsyw/HLLE7nVtD+HZNqh0zJWul9dfKAVkz9pm0wa/eU7v8KG7UVbrE98KYXZjkyqcXPgkZQbRG54hhCNW/XQOIRQ/+nVZZuV4gZYIgddVVlAshfT1susdRONvTi+FfAC4K/jf3B5xcPNLmuM7uThpKaDfoV9x9yW9IxuSZUGXj6PWtH7/nu6bNA9mQdD0tttAP+Tyt8B72VLla8zDyF2K3Y/JiHEIZaqSykYFVpn1zIFZ/V05zIUHoDR7TiniJ9o1EkVafKvYYMIxkcuhcSkP+fGIeGtMs/HL9qwrsQ27RC+MkIWtJMvrbQZ4Bvh6TjwqqIwAK8/lWvSR2ub8xw+iu0pa4LEBqzwgbZulXZIxd/br+LrQ55q/SIEqpbfUpydUnEbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(66574015)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFDMjRlSWxYNnRnQjVYM05DVTUzaGM3WUR1OXo0ODU4OFFGcnh2bkxOS2xp?=
 =?utf-8?B?UFV0ekxHZ1FSS3Rqak96MEJ1cXcvTldNMG9nV1I3MWowWDdNQUtKNUd1Tno3?=
 =?utf-8?B?N0VPTmFiR1J0ckpGWlpNYlFwMk9QcU93NDdlVGlaVFk0akNTMXVGUzZZZ3M1?=
 =?utf-8?B?dkd0QnVwQjBsTThOdTlTd0ZCKzY2UUxJUGZTODFSNElUVWVNcVFWb2M2THo2?=
 =?utf-8?B?Y0phWXo5RUZqM1hIQzVmUW1sdWplUmFlL1RqRFNCK0RRWHZGRUJkRTR5YWpW?=
 =?utf-8?B?KzBBdjE2Y2xQMDlWVi9iSFJtc1pNdkVkM0djeDZ0Q3IzNmhFa3ZNTC84SmFJ?=
 =?utf-8?B?eG1NMjNoR2NxWWxJaUlQMFhSKzR5Tm5YRVpIR0VqeUxGNkhYalI5ZXhTR2tB?=
 =?utf-8?B?dUdFaEZlZEtmbEQ4TlNNVjRaMk1kSVc4SzZwL1c0Qm9CcG5JVzBTRDFDRUw5?=
 =?utf-8?B?V0NLdlpVVWNGVm9UajBjRzZRUVVjRitQVUZXdXpXQyt4bXpnRi9JTlBhTFZN?=
 =?utf-8?B?Z2RtOTYyUTBVYk9Ed0d0b3ZaaE84RFF1OVJnaFBYNmhYdnpTRVo3UDRmR0E0?=
 =?utf-8?B?L25DOE9KUHpWY1BFeWFRdFBtN0E0SmYyWm5GSjNOVExGYVg2ZTZsc3IrNXhC?=
 =?utf-8?B?OGJvQVEvNFl3eGdqVndRMlB0UC81K0FYRHBaWXEzRkhPTzcwWGdUbm5EMWxV?=
 =?utf-8?B?djM5Rmk3bFQ4TTVIRmdFdTVxcElwa1J4dVRzRkRqLzRGeWFteWRGMDZWZ0dK?=
 =?utf-8?B?WWVJeVJqMGNNenVabTNQZTlHcnBtUHp0em5LdHJQZFVsU012OHVvbEtRMllC?=
 =?utf-8?B?dGt5QmNZZ3pia3VLa3RSbW1Oc0R4RzZ3NG5lZWdnMHZ3bWxFcGtVL244SGZt?=
 =?utf-8?B?cWExS2tMV0phNk00ZjRJc09DVmo4UkVSTTZuL08wc01GeXVRMnFhTXU0RW01?=
 =?utf-8?B?cDZocWRVdzBLOWxOSzRkSUJGOXo2WXdVbHlhODg4ZTFrMU9qMEJEWmpSTnBv?=
 =?utf-8?B?SHcvdXZuVnF6cWwrOWtzcjF4WlpjSmFlQk43Q2RkVjhhM0FGZzhSZkJqTTVD?=
 =?utf-8?B?T1Zja3lIVW5PK3ZBQlUxOGJpcldnN1Y0RytxTUlkNDgxZXYzb1dwRzJXYUdO?=
 =?utf-8?B?RDJvMU5ZUDVHWk5sZ0lGTnRnQjhVRThiMTdScmJNb1A4dlhZay9kY2JUZWFv?=
 =?utf-8?B?Y2hmakd0R2NQdnh0NnlWT2hPYXVQM05kVG95aDRqVlFncEU3V0ZzRjl6d3h4?=
 =?utf-8?B?OUl2cmoxWmtBT1ZiMzZrN0lzdWNYL1hGUTNHZkRCb2o1bWhIYnliOXFEOS9P?=
 =?utf-8?B?a1NNSkZBZUNLYXNsQTZ1ZjVkZUlBVW9CMjYzUUF6ekJvbUUrR3RYT0tYRDNO?=
 =?utf-8?B?cG55S1M4SHZVa1JsdEJsVERtaXRnVnlWRU9vaFBvRm1DUTliWkpqQS8zWkRh?=
 =?utf-8?B?OWhRbDJySmorR1k3V1d0VlRieG9BejEzZGFQUkZEa3oxaUNhRzc5U3c0U1dy?=
 =?utf-8?B?Q0tBZ08rSExQeWhqcE83YlA4Y05qNEM1cnVTQ0M4elhDVFBZeFZld09BQVJy?=
 =?utf-8?B?TmEyeERxWUdNMC9OY1N4dEpNeDBtcXFqSUprZ0ZhRnlUNVlqelVncksxNUNP?=
 =?utf-8?B?STV3bVZ5ejlIdmFMcWZDR2tkRnB2c0JRTWhYT2dzMG9FVnQ0N1g1aDN6VHpp?=
 =?utf-8?B?UGM1SWNXWUJ1UzZHaHhjV3RwRlZnMGJGajlpTHVoaW84c0tLcmFHVkZiamMr?=
 =?utf-8?B?V2lHekZ2VjlJS3Qwdk0wSFJUZ2U4YU5hZ3dHSlVzdFdvZmtpbmN6QjE4eDZn?=
 =?utf-8?B?Q3hwODJUZStXeTNQSVVId3NlMmJJWk4yWkNnTFhqOTVrY0x5eHhtbEtaVmR2?=
 =?utf-8?B?TGgvTjBTZzlVZGplK3JpbWU4emlZb2dUMVRRU0NrRXlUaG1lSFZ3ZEhRdmh0?=
 =?utf-8?B?RFZPeTVhZnlvZjROYnkxVmRRdjE3NFgyRUV2ZXRPY0dmUzlyWmRlSkhEVml5?=
 =?utf-8?B?a0lGeEltMVNzSWFzZXhML01ycXhuVXJnTTJURTlkS3RaVi9UTW1XbTRPZVNS?=
 =?utf-8?B?Q2ZyUkFtcWNQRHJ3azhsM2JCSjdVN0hyRU96RUlaM3VPTWY4d3hDUU1SNEEz?=
 =?utf-8?Q?4U8xNkKHcxpytBkp/3LTlRxmk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9563f4-e10c-4f98-03c0-08db837854c8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:24.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBiotzHYLx8vHDoNcqWQuzVU1zAXCQY37rW+nMusE4Awn4y+mbCWDmuLcWazztk+cPJgI7NbZik7x4PKmde5bg==
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
 drivers/mmc/host/jz4740_mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 1846a05210e3..f379ce5b582d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1163,7 +1163,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	return ret;
 }
 
-static int jz4740_mmc_remove(struct platform_device *pdev)
+static void jz4740_mmc_remove(struct platform_device *pdev)
 {
 	struct jz4740_mmc_host *host = platform_get_drvdata(pdev);
 
@@ -1179,8 +1179,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 		jz4740_mmc_release_dma_channels(host);
 
 	mmc_free_host(host->mmc);
-
-	return 0;
 }
 
 static int jz4740_mmc_suspend(struct device *dev)
@@ -1198,7 +1196,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
-	.remove = jz4740_mmc_remove,
+	.remove_new = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

