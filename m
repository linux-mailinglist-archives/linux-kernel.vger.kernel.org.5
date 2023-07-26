Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4007629D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGZEFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGZEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:04:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CD44A7;
        Tue, 25 Jul 2023 21:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGIENbdYjRbiGW0YhVP0b07eMC5DMUN5orG8xs24xgp5PF62Empy0NE9UEgPCp9Y8/xUgeR7h+vTU9QJRuHgRNVA4gYFpnV+OR/f6SDBF8XWv0lghdTzglTWgeGCIO9uP+KZwgsbB2BSenCDHw6S4InRKGHH6NlsQ5Vh1FgoxLfVaCukZJnkLnjjNuEUWnPJWaP11AJSMHz370WlDUw5BBP7KyFaTdBkg88FzpWOxPrupuuOuaBn5YoByp2HITIL4x13hGA3wboRe+D8mCpVV72IIwfjq+DXxD5qdG8nAWcTn2HTQCUaBLmtnNAIi2TMz0lBP7ZutLR1fOu90v+KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj+WD0ujQJJoGOzm0bS7zDFDRH08DzA9OwwXsON6vZ4=;
 b=KkakbZmMxcK4WMzOpqPm4Z3atFYKKg38f1ef3u5KurRK/ZY+i8qtYpv+fammfuJToEr5Wsd9dmDKL9hVVHTr2Yyy4nT1EbMYghtNMsgiDS8qirg4WQDpdIt04IU+kqcmrq7YktIFs7XhVAYgbeJdSUS4xsMiWX3R2DpkYKkQgwolPzmQFObA/NDwkazZXaX5ZO1Ekwgm0MX45qxzJQCQ7qoAaNlsarABPIuTHbaVmE+FgDS5mV4FD0AHfJUW9b3d5bWvBIUFUApPxdeDhavAMQrTcWcvymmpALTfSi22f1r3AJyCYKjGZ2raiv2FCGynUXBbNnc/5EM4TaTc1V076g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj+WD0ujQJJoGOzm0bS7zDFDRH08DzA9OwwXsON6vZ4=;
 b=Yv+0WnfCRU7UzwqiIqY6jAU30ernzXVcfJT4DzxlD4KxWJbS4l5RHGJ/mkeumE9vHeolS+v0EhSS0GKfRXEUD/SatGoIs9iBcgQamgX3YcKtLty2Lw4FHfU+q9IIVOyAtLQD58GAbA5iG8myi/d0z7Raw/tsAlHVnn6+PMJJ0eaYzcVBys0TpNm15TynLilVx5B4LUFiTKmkPKmFo8SHSsMuTfSGKRPZ2WIXTlYIU1uC9NGniZoHCBTqW5iq1UY9ZGbCrDp6rOWeguJ9cWk0510XItSyRSy7hOtOkLM+FSuT7OtPNW9/gisUtRLEQ8CK9zA0t8Uw5z0zqokOAXFMOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/61] mmc: sdhci-s3c: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:01 +0800
Message-Id: <20230726040041.26267-21-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39a1a542-a6ec-44a6-9ee9-08db8d8d0107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VMWCiDM1IY6H+4vXU5+gmSA3r0RwIMTJrjfWCMK+Q5stOfyQVrKohh+K50fXRiK06epvKuCE+Dn9qXASN0VZCPAM7E7SAh6SeLBWwpxh6ibyJDjcgnRrHQoSSZpU8Cv5uxLzxEroJuvxTGUho71b0VDQWaHpzIy2fJMo/iS7XChTcHiSBCI24spww7MFQlY0qS3B4mbAtSZHlUaJeZ7taSXmDUSFms2woRj5SMCVXiVvbzk5x881vC9/9nYCF66rpmsYBCKu+BmaDF4NsygUzwPdcj9fRdVvfIcN4Z+R3UGparCSM8vhEKOB8arJYsSNZPdQHZOe5uJuH9Bgvrg0JMk8LVm6LNOjelNLc4R7icyzS9F9zhufEBI36VGCUm5ZX05r5yGewEvYlppDWOTKi9YiS2YwvASf9FX4GsaXGZ2I6jxk5Ob9GQeCmlGcp42hxhjqBmGTHw/NXP2xsQHjXcTmr12RRR4a66sTwvweyG6/jtJ035i1YROwfA66N1HgQLhCocQQWdsCxMil0/15Pi3tWVDmK69ZySQHVCI7xS8E8LSWy7QwuZVN7hBTghXlQ1fWP91UYpeHMhHOYnFNQ1j9ATD4y1sdUOo5LEFCNbQnXOtwwNlLFKZwGm53jx+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJwaTNJSGJyYThXN2d6OGwycWViU2JhOGxUTmQwdDhzOGpHMVRhMm1RelZp?=
 =?utf-8?B?OTliakFJRmhCdzYralhDSndMSnpoK3RFeUNnWk1kVmI3RHRYUXJ2MFMxZ1Mw?=
 =?utf-8?B?dDJxNEZxSm10QitycjJ0R3ZvUjE3VmltbUp3Y0NERWxiaU9EUEFCeTdnZ09O?=
 =?utf-8?B?R3NxQjRmNFhjbVZudHBGWkJzeER6eHd2MC9vMDNjdlgwQlBONHp4V0VxZzNh?=
 =?utf-8?B?SDQrc2tPa2dMcVFVbHJjOEFsYithVW9wMjJoNEVJZDlXakUrL25LUXNSc3NQ?=
 =?utf-8?B?NGpVVUFabFByanpVUjFjL241OGxISFQ3VDB6cVRvbzdreEpKdzN2c0l2cHM5?=
 =?utf-8?B?NGtMc3piR3pBd3FMZ0grRzV4Vm9pT2RSUlVEeTFzNjBuZXRoQnBMTjVMQnZx?=
 =?utf-8?B?TW5FWWgxanBFT2FQSzdPNVBOQXIzT1MvQk5PTU5weUJDQnZoM0lHRVdnZkRI?=
 =?utf-8?B?YVJOcWtGNXJCcUpuZWMvTll4Q3RNaW5CUlhNalgzeE94UDE2anBGeUpqK3Zk?=
 =?utf-8?B?aitBaG1IaTQ0VVE4REJoTXhva0tiaDVSZjJDTmdmVUxveFdFV2pWd0YrS1pN?=
 =?utf-8?B?VWE1YjNMSnhLN1ZpV1JrWnBJQnpRMkxZdENMMmJPNHBRbW1YTjhkdTYzZTZq?=
 =?utf-8?B?RGluTTArcjExSncxelZ2OTM3TERYTGdaanE0eHFIOFNGNU9kSHN5QTdURkpI?=
 =?utf-8?B?NGlJZ003UVhucmM1bkZXNzloYVo4bDBvQ1NsLzBibGJzYVFlbkdSbU4zaXd0?=
 =?utf-8?B?MXExbksrZWhBQUllQmU0VUJ5QWs2a200YUxIUjhKNlNqSEF3N2loVFFTMXN4?=
 =?utf-8?B?akxRSTF5NXZhTVo5a2xjb1hDb29XT0F1WjF5bmcyZ1lQUDdHcjVQakhTYzVp?=
 =?utf-8?B?c0xnSkRINTdVMDd3bHVRMzFTZ3JPd25LNjVoQmNJODdETHZEcmdsc3czYmRr?=
 =?utf-8?B?N0dOOVRnYmU4a3FsTVU5VG5VRTZUd2IrUEhqdXhNd05JdjJZREZJQUVsaXhC?=
 =?utf-8?B?bEN3V0EyNCtBTlJyUzAwVEgrblNGa0VxSmNBV1JRM0kwL3YzRjRrNFQ3Ymxp?=
 =?utf-8?B?OXcxcTVLM3ZyTlZGQnNQY3g2TEsyMXBGRXQra0JFbEtqemQzcTMwWUFaSHQ5?=
 =?utf-8?B?bENNQ3lmVHlCN09HdTNMbVVHR1RTS2UvM2tJZURFMjluMUpzREZQTkdZOTRp?=
 =?utf-8?B?cmFFcmdnNHBwWm9sREdwZngzcGpCMXlaYkdzUThDUGNsOHhEeGFBSlNDNnNh?=
 =?utf-8?B?WE02VHAxanczY09XMU1oV0F1UUFzbGY5MDJMWFgzK2IxaUhnSE9ZZ2tzYVJz?=
 =?utf-8?B?OXVmUWNrM0U4OUZjUXZlRTRDQ2xrVEE0RXNzakN2cFlzcW5CUCs5bi8wSHgr?=
 =?utf-8?B?amxna1YwY0ZnQStCbTVuNHhXeDRmUmtYSjNsUDVDT3YxektOcU5hbXdRRUVl?=
 =?utf-8?B?WGtiaWJNbVJWUTV2N1hjK2JxOURUWG5CanBPZW9GaS9UTjRtcDNBTzNGRm1M?=
 =?utf-8?B?M2xOa1drTDkyK2ZMOGxxUDVmeUUyOE83dG9RVVB2enpiZWFjeFBUL1pheHA5?=
 =?utf-8?B?WnhjWDdIM3VhNSt1ZUNLcWpJbG1sWVgvYjhSYUs5cXRTNS8vWEhtaWgvTktk?=
 =?utf-8?B?Q0Y5OUZZbjF0WlRTK1dHd3R3WlFROG0zTGhUM1J0MVZYY0NSSHF1U0p2eHJN?=
 =?utf-8?B?WGxPS0VJc21Wb2dITUtjRkQyd2JsTE1ZR2F3aUdVdThGUXVoUzZGVmpMN2ZJ?=
 =?utf-8?B?N254ZDJ1M2RiZHQ4b1hrZDQ4dWdVZDJycjNEekJ5MENJZExqOEhOYlhoMVpO?=
 =?utf-8?B?S2FyWGdsTTEzZk9CY0wzNTFqTkFqcW1GRWc1bE1Pcm4wU3ZwbWdPUWNKVTd6?=
 =?utf-8?B?cm42TGlCS2dTUTltUjloWjRYcVBWcVBvK1pSWFh6ZUlJclVVbFhxOWlsNjNy?=
 =?utf-8?B?TDZJRTkzdHUzTjMrQ0R2MXNFczJrRDJmSkpyUDZZV3MwMjJMNXZ5RFVacnEy?=
 =?utf-8?B?ejFFcTF1QXRvZFlQdVJwZTA2ejBDSWdzRXhNdUNVRHE0a1lMK3E3N0xzbW1Q?=
 =?utf-8?B?am02WndUbm5MMi81bUd5YzdySE1RMXdsczRPV0dvaGtPSzZBcGpaejZxOFdI?=
 =?utf-8?Q?vxT8DMwkres2XofLEd9JIxbsA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a1a542-a6ec-44a6-9ee9-08db8d8d0107
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:35.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgsziMUJnyKkrDRiYuAlX/GatOzSfry+HMJtTdSRasSp8qJjJo0YT291pHMScVMKgvVocAyIT9wFBWCOr5ybbQ==
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
 drivers/mmc/host/sdhci-s3c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 504015e84308..b61f12d328e0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -668,7 +668,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_s3c_remove(struct platform_device *pdev)
+static void sdhci_s3c_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
@@ -688,8 +688,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sc->clk_io);
 
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -776,7 +774,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
-	.remove		= sdhci_s3c_remove,
+	.remove_new	= sdhci_s3c_remove,
 	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.name	= "s3c-sdhci",
-- 
2.39.0

