Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B957647A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjG0HFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjG0HE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:04:26 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8074227;
        Thu, 27 Jul 2023 00:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er2pkWvyyNl5O0Vg/oCrK4vszjaUj0YoSOPO/FAqlYu0PkWk2N6tbSBBQti3XYuWE0N6q3iWLkimCjGtkfmCWmXjHvouvDunR4thctfmEqUHYmqht/OP2qL7FT/bJtRKZyr6WBWwE+5rDxv4Lbm2BFz5SOEWN8luHEctGsHLzPtcGXaKVYF+9PEHHaw0NvQZFDHIuNn9fNRYOuopmUHqkcDpO1QDNjj+z+sPconNzBSpk3LGlRrcSnhvCXPG8epj4Gi5AekIeuiEmTGfi67qM3AwBplnac5PUCuASnCTFZ039Z61tYQ1Uu3S2A/FAF/qOlvIAVqi5ySb68SuSSLwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=XR1KpeLS4YZdohXuq51yjE+SBihI1T/u+a3vigBgNPrNqIyzx5lX3QxhvC/Za6QUpK1CcKqGum7STXXYOXhgr0xE+a9rGm7gD+P0iaRbnOrySzmlab45rF+kxN4EuveWH84Hf35lMKPj5Ub3SeAlWVe5cW2CxES02hyNk508Ay632O40ycjrHZAP/smP/ux70PHM2UIfUk7Wig5UD/Ff95NnuRzI0+T4VkBqHJpRVcN+2wSpVj5JwgDjwDO11k9D69UC3xmHjRvmVZWULhEYh1ZI4Ie7ZJbsJMhQONHjrCvrhS0qkpQ2r0QmofyKfe9sT3L36LgBv5AdLMsIjYAgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QwyjiAPoUwvuuL+fTQzivWNofmwHauOj0YWTiKbAgA=;
 b=D+VHVwbcUVqOTEDns0WD0y3Ctc/8j/Q0qp6dN86OXlAIEV4/Hk7Y4jUE+FjbV6UF8vOnwO3k97dzy8OTgGyoQyNH2xyXtYfB94ECgNjiN0rFShdfCCO528YPwstZGgP9gAmz8HkEMBeXbKOYj560Jo3q2iDBY/4Ek6spQrFWQZkewMsB4cXDbi3Z+W2DZhYTSG+ygPvsziAuzIhP9zk03xd9cOqClqqC3FJmEtCDbVxEJAIBOM3s0fYHIfoEQ9UbePsHzGJPt2JWPYTXjC+H1zOdPxixQ9ZF9N3WfETCAEkPFRSgLbMH7eDqCISSgS+QKVCn8ovye2z2vyzb6TDwJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4276.apcprd06.prod.outlook.com (2603:1096:820:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/62] mmc: rtsx_usb_sdmmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:12 +0800
Message-Id: <20230727070051.17778-23-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f18f68-91d1-475b-9ccf-08db8e6f53ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1QtqH342EY1voCqd5z8NAuF1zRdX+T2AsgDtx2YG1gmgwo+zvNlGsPIDza1CEU7vo00DfBNKGaZ1SxhID8Enu9dZl9EXMrR7+XLYeIoPLSAcjUPLVOXba5IZECNxbBGWkNhRwh4R1jNBQvNZzp/3mnlS4Oea+CdCHAEAbAuwQjG4eojuMKNITlGVZotfCty61AT1jSmy3qM+W7KiPXnDNXMIkzSRoki/2rMhiv7u/TofGGOaT0Cp8f0L72DBpIERsgIjNtjqott4SXBjG+GRJwiUnD2AXVYtFA5EgMm55K8selj2aVfeiLJkCPhLAfQNRazycEmf77iiaE7YUUeJ/5RtiJyDYCoqnPM9k2soIlZbub3H/urxq38mjgyt7u3l5ISap+QOkzCRZZW91lU8FA9Rr6H47IGub7iCU4asVFILp9lRq/eo5FooVFhoPqbQdNUI8RsJZz/IbZYh466f7+BGh2Z7/9B2rOk3USsX1m6t8xZhafLlrIauqIjzAjlgxwcN1+Nrkur85s1W313CMIIrEmpNAykuZpLxlsR8j6dyRi2uCqooGum+BSLr6kzScNPpP7eGgvjlb1IMoj+CEFw9E1HMnXhCbGnAzC1sWWjkygaJaqHvdUq6ZrxBnuJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6666004)(6486002)(52116002)(66946007)(66556008)(6916009)(4326008)(316002)(54906003)(66476007)(478600001)(38100700002)(83380400001)(38350700002)(26005)(186003)(6506007)(1076003)(2616005)(36756003)(2906002)(8936002)(8676002)(5660300002)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnk0ZTRKeXMvcmRvVEhtWEJORURKN0ZqTm01ZjRZaU5kWEkwMWgrQ2M2blB3?=
 =?utf-8?B?dUdaZ1ZaOWxoRFZ6SGpIUmJnY0lhOVNzUnl0d01aSHZwWCtaUWlKVnZPSXYy?=
 =?utf-8?B?SlAyaDJ2SzM3NFJxSk1qckJscUlpNzJMZVRtNWNUN1JuLzJ2c0N2RFVIRjZi?=
 =?utf-8?B?YjltTS9NVVJNMGo4dnFLVFRHTXkreitlNWN1MkplUmRnZ3VPclZ4VlBHQ1JC?=
 =?utf-8?B?M3NDNFdEbHU1ZjBhNUJPaXBnNE04eWFQMkxLZUM0d0oyYjZXSFNMRFQ2OU5C?=
 =?utf-8?B?Wng2MGs5dWh5MThCdkc3dEVUam4zRnVjUyt0OXVhd0tRSGhWaW9SRVRwTVdk?=
 =?utf-8?B?cmhOOW9PcHhxYVN0T3FnUWN1b3crc0w0QmN2Qk5pelVBTS9CQzFIclY1ZFdz?=
 =?utf-8?B?bDE4OHVRbGliMHJRb2J4cWNyOC9qTFBsN1JwL2pJUVdRZ3dqVzFVSGsrUGNR?=
 =?utf-8?B?SHNVRkRkK2FyVTJQdE4vR2IzWEw0NldEbVVnbHJNejVXdDZlbnAzVEJmR082?=
 =?utf-8?B?VmhqVWJ3ejVKT2hNYm5zM3ZPOTA4cm5aczJ4LzVkUDFLMGZ4bmtSdVFIUVFV?=
 =?utf-8?B?bjNqRnYwTEc4M21wSHBYa0UzRzYyemptSjVLaDExWGhSYnFzdjBNYXN3Q0pH?=
 =?utf-8?B?dUdpbktkVUpiaWFNSXphMkhteW1XNGtva2k3UkFFM3MwOCtGdjBIWmtmR3pt?=
 =?utf-8?B?a2o4ZTdGYlk2dUlyK3FyeWo2YUkvTGFtVVNjUjBWck1xRlhLUnFhckl4SGl2?=
 =?utf-8?B?Vkc3ZzhsL0RzVFR1aEQxVUtKOGNkT3dGcVIrUGFrSnVZdGdOZVNSK21qVkxm?=
 =?utf-8?B?QS9kdXB5NGNHQ2sxTzJjVkRHQ1pUUUtUcFY1T0pCQmlOcHpyS09GU1FnL01S?=
 =?utf-8?B?aUFLVmdXcnBqYlFnU1pHZk52MHNDZEN4VVlRSlhLQWhNeFZ5ZHNtSEttZlpS?=
 =?utf-8?B?Um1VV2YwZW1jb2Jud1hSbDNveDBHL3E3THNaaWhuRjZlRVY3V0xSSVBPU2FC?=
 =?utf-8?B?dlViLzlNV0RxVTR4NUpjL29mOTAwOC9pQkxNTi9sNWk5WkNBMG1RME9PTlh3?=
 =?utf-8?B?NkRGTnFoNkV5SDBpaXo5OEZVVGlDdHR0R0JRc1phVEtKeTRhcXNJQnk2TjNl?=
 =?utf-8?B?eFNZaFEzTnREcDZVdW9POWJYMGRiZ09ydmpVVUZhakNIYmpJdUpxZjBHdGIw?=
 =?utf-8?B?NFFtanBkVHEwUnBGcFVTQ2NpdC96R0FtUThZaU1mRVJ3Qnp0ZmZ0UXNQb3Nn?=
 =?utf-8?B?UFkvT3BhbUlURE5aLytZNStVMlBsazJIa3YzTGZrNUwzS1Q2NUt0ZHBHRHBD?=
 =?utf-8?B?Z1o3dWN2NzNhVlRDREhaY0lsbjcyK3pzL2N6cnQvSXUvSmhwZGZZUlB4bmhJ?=
 =?utf-8?B?UHYraVE0dTZtdldzV0VmaC92TllQMTRFcFA3ZFRDV2RSaFcyY05SSEJBME1w?=
 =?utf-8?B?Slcyc1Ivc1dDWUJ2eStGRDIvQkJOajNlS1dPS3p5R1JHaW1ESzBFUmFiTExn?=
 =?utf-8?B?SEJpMzJkYi9yMllpeFRwSXlaN3ZkeUN1WXVyellqQkJsRTFnOXpCQ0tXdXJm?=
 =?utf-8?B?MkJucVg1QTNjUVFYK0w1MnlCNFpNMTBIZjFrdis1WjFNK2RiQnNka3AzeDdE?=
 =?utf-8?B?SCtzQmVBd25RUHYyb0ZQTUczL3RUa3dFMkVZa3BIKy82K21ucUEyYmtoTHF2?=
 =?utf-8?B?U25vYlRkdXM3aHFxVUdJS3FZS2hUZTFkRHU1R2RoOFMxb1U4NWNYVG1qT2NM?=
 =?utf-8?B?UzhQbVZDSW9PakpRcWdWZ1IwOUl6YldoclpSKzZjODRtVDBQNFJwVkxUNjVl?=
 =?utf-8?B?V0N4a1ZHSFZESHpKWnhzZSs2dElaeWs3dTFXckFIQ0NYSU5LVkg3M2NGUm1I?=
 =?utf-8?B?WFd0elhRdmM1b1JBSXgyaHdRNXlJK2JSSlZvcFZEY2FvQmxVMTVWRm1uclc2?=
 =?utf-8?B?ZkZQVFVpazYwT0plU3RWTldBbWhhNUxGYmRvNkIyWDZvUXVxZXpDbFFydjZU?=
 =?utf-8?B?czB5T0dTR3VjeU5kZ1ViYmpsYXJJOXpMcVh4bHJyQTN6TTN3OXRtMUx3S09o?=
 =?utf-8?B?ZCs1L3VyUE5ZT3ZkMTRybEE1RFkwc0h6djJBVWJLZjhMWS9BSHlRODhIM2hp?=
 =?utf-8?Q?DALeqN9EhNR3L5knzj4k3SfJw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f18f68-91d1-475b-9ccf-08db8e6f53ae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:40.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BQgd8QTNMo8wxlXvKMbIXRsty+jiW1CR2Xq0erRSJIoYWY6MW8BJPjUKrwMEnOgnxfyD3oIF1HCamifcyB1/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4276
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
 drivers/mmc/host/rtsx_usb_sdmmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 2c650cd58693..ded9b6849e35 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct rtsx_usb_sdmmc *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc;
 
 	if (!host)
-		return 0;
+		return;
 
 	mmc = host->mmc;
 	host->host_removal = true;
@@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek USB SD/MMC module has been removed\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1455,7 +1453,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_sdmmc_ids);
 
 static struct platform_driver rtsx_usb_sdmmc_driver = {
 	.probe		= rtsx_usb_sdmmc_drv_probe,
-	.remove		= rtsx_usb_sdmmc_drv_remove,
+	.remove_new	= rtsx_usb_sdmmc_drv_remove,
 	.id_table       = rtsx_usb_sdmmc_ids,
 	.driver		= {
 		.name	= "rtsx_usb_sdmmc",
-- 
2.39.0

