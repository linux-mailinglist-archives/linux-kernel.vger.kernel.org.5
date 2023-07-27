Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0A764775
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjG0HBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjG0HBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:01:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F08026A6;
        Thu, 27 Jul 2023 00:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N06pxx7IxGzgOyjWQ8Ls3LPOc5iRlJprQup8supgKT12d/Rk5Of+HG0+TIL/3kOHxK/PzwVY6HSc/WZW1t4CdT3qUHbiAXIps/uS9VJXKwttLa/2nUu/D86wAZ3iMQXmpt0/2X2PjsF1qQbAAykDyYwMDBGrwFlZ90QWleueBCa/d/PYhd66b4GY80u3nqaEx1W9RU75RkVEGd/MwTts/XOfWP/GGen3po05K7NFwV3pPRVDOCXhsV8Cx6mLwDESZiNbgam70CNTFywYC72qQoh0mkWPm6MlkuCXrPN9HlrZ/6sxxs7/FgSqrHkiODdzlS9IcvxslBngDtMkHrOhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqxSuEFdgd7k42jXTQq9t2x1NA379+lBETFrgOHf+Eg=;
 b=FmIM5DcUzWCeqpzCET8H623NyFUs2QQlzuwIyCPYgNTjip5shu/z2A0ZwYZKNTZXNhGwepEYCLNAje1Dt8W4CYxW7U/SrDk8wn9KBY96jztJR/xgbsENRKRlshCyamkqCSzga0RxLBzctfXwGMuhTN+Mae45VZ6NIEHayuy6gMsMEBdlOq2XueTRaZnSDqW8VY8Q4ZpLSFj91NOhsKPF3Khya/3vgnD8bLfYHoCkw14Eu6piZbWDA8AuPTtQc8wzIj+YASkVY9NfZXjKAskEF9cPcD2Ns5W73al63nLC1G1KUwOE5v/FwhxClQA9lIQpnQhha18blsrjcISdoP824g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqxSuEFdgd7k42jXTQq9t2x1NA379+lBETFrgOHf+Eg=;
 b=LWifzvir0n9+J2mou7SRy6nFjthnQjsLYbB8sdXek0945UT1afppTJ1wcQ+oSVhbdD2NYhkvTu2WkTp4WCJntfR2OqnLLRP47OK+BtnhS/PtI24xTmbVF+9MW/WBYd1G/TSAJz9dJVQbz2IUKKN9u2TaacfM1iMkMeuahQLPdB/z1/QcPIqITKG604pLR6RfMljVHQ9MdbmKjW1hAKp0mBoPJ9PJpFMS2Q7Mv4BIz8NdWatI6/U9I5mnL12CDhY+Jc+qaYuV5yB20iaDOKZZa090ndZ9RqY20mnG3q92xWCvrYjZfT6XnpOZCg6e/xK6dBKknsryMynrcBvKLNF0fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/62] mmc: jz4740: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 14:59:52 +0800
Message-Id: <20230727070051.17778-3-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b92eca-30d9-45fd-22e0-08db8e6f4023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRVeuUsH71GFGQW8I9Up1WJLAboej8bJ7BQDZa095tgDwq0K2huYX9aCQPsPRpaJsdGjg8VZcM+7zZk/Pfqre0KtpTxybjHNL3p+T3b2n+/mOS4A3XhYbSeH+0Ou75OrTcAcaOmOWrSIfT6g3dNCU9QXjti/ASRLUYnCQIWbjzVUmn/qWAGK2/kUHqpWInQ4j5QJ6ik/bOjlMk3+ftIlMqSU3p+o14xkfiVLIsZ9Kl7MNERg04YNVbbke7ZVHY3HE73BiBt6SPTs7OfRkas85liWQ7RxiNruugYaVIttwfsivmPnfTvhbeYSljWXgOwqP0elBsbjg4EdVN9G6ZcS/g97Kc2OiUFjct9fNbH9Gv82b22lcODrM8F+CdY+/3KKkuQjwZDmBBqh0/GipWhpwZe9ZShk433FlZNuowSEto2ASl9LjQWSSPtUeNDj/uEtLdcFmz3hEYagIVMQioJ+USjMb64oJEV8ZeyAyU2Wj2wUd41gcD5qubwyRTqTlwyJBQUtFv0r8Ka/kF2jjJCZWvZBeoVbEGrWmOLL4hm2MnjuAPVd366nW3Cq6t9Pq5YbBk7+Pzi1+HdxfoSVEKUlU04G+yXUzID+AflxGwuOpPr+/oNl2vYh0fLrGUb2OmWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(66574015)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzFjcFJ5TklaQTNxaEVYSkFNd0UzNEJkWHVBT3VRdHhIbWo1OEdCbThJOTdG?=
 =?utf-8?B?TGRib0I3S0trVStpNS92R2phYjE1Tlg4dG1ZVVg3U3ZYOE93RVFsWVZSMjJm?=
 =?utf-8?B?bWdmeE05ZVNQdkx4WTEvN0I3OXg1T0RJbUNhM0lXbnYrNHlYcTc4WkFUSzdL?=
 =?utf-8?B?WTdxYVNsTitFVzkrd2JLTllEU210TjJYdVNlRVIrLzRDYkhsclZrdEcxcUhI?=
 =?utf-8?B?cy9JQXo2QUZvWDVFOUVFM09BZ3Nzd1ZCc0xmbnMrbDdwR1VTWks5WTQ1Vytp?=
 =?utf-8?B?ZnVNczhNbnNUbDVXb2wvUzdMNS90Tk5FbVlDWE9FaWxSUnRnamhIaVpUQmVL?=
 =?utf-8?B?S2NMdW1LYWhOYTVRcERtRVBBODVQbmZ6SmdxcDVlRWd6Tm9FaVRpYU5lbGNU?=
 =?utf-8?B?RUlKUFZ2TkltanNTeWpYS0Rsb1BsRGJSV0NUV1VDM0pVM2w0MXBwNldxZVl1?=
 =?utf-8?B?L2Rlcm5VU2s3eTc4OHl4SFlRc045YzYrd1FDcnNrUWkvQUhDQ1RaSzVReWdR?=
 =?utf-8?B?L0s4TnoySHdDMHByY0pNRFNuQ2YrMzJQcXRUUUJ3alc0RXd1R0ZZZFR6aFJO?=
 =?utf-8?B?TFJOSmxxbk9Bc1pFWlFNaGtZbVNOSjA2VmZ5MzY2UHlXUW5qQ243NVBVZUFZ?=
 =?utf-8?B?aGwrWlZWbWRkVmJ5Tkd6ZFBiVHpyUTdDTng1M1V2S0diVVFYWkJ4WXQ3VHJ6?=
 =?utf-8?B?ajJSTUZlNytRQTllOHdvclFFT1hzdHFkMHBKb2JQUkM1aEFDZ0VmemRoaitI?=
 =?utf-8?B?Z3R3cktXcS9LOW5rMTFkZC96aHRvUUVJVXpsUkNINVhreDUrbW1LdDAwa29w?=
 =?utf-8?B?a1VpV3MyWHNLTWwwRkExbHFmRDluVFhzaGFXdDlIRHRMTkdLSCs5dXpoZUJw?=
 =?utf-8?B?L05nRk5pUmxKMWV2L1JNYVJEYnRGVWZnYit4bjNRck5iTVMzQjVDMCsyQTYw?=
 =?utf-8?B?SU5BUUkreTZhcWx6ZjdqSm9jU053d1d2NDIraFNPblFiZUMxZkZOME51RUZU?=
 =?utf-8?B?VDA1b1ZxV1FvUDE3bDg4OHQ3UG42VUN2ek41a09xOStEeXovcnhsT2lrbEla?=
 =?utf-8?B?dWkvN1hwa0QwekJiVFV5OVRrOFAwakpoby9GOUFFYU9DNzgvRG1XNzhTNVVQ?=
 =?utf-8?B?NlZhbUt4WkFaWm5LcGF1M1hlaWg1VWFXU0xHc3IweElWSVRQblBIc2RiRWwx?=
 =?utf-8?B?SU9GOE5vMmRZNnJNT0dxOGZ4R2tjTUdxN2t5Y21pZHRCSDRpUkZ1bWEvNWlJ?=
 =?utf-8?B?KzhXVjQvcHVFeHhUT3NUeXd3Q0s1L0NnclIwQlYxYXZUYTFHQm42djhZaEF3?=
 =?utf-8?B?aGV5VVdEYk96bVBhbFE5N0dxVndCUjRUL2YwK284d0Q1TkthdlpzTVNjam44?=
 =?utf-8?B?Z2dONFpyc0JVRFRFcm5xdS9yVVZUSTZFd1Q3VXJpMVp4aWdiVTdIV2NML0FF?=
 =?utf-8?B?NUtkS05RejVIYytwUHhJdnp6ODBnalV0cjZLMWd4ZHNQVDlOMHhtaERhU21R?=
 =?utf-8?B?U2g5eS9ZbU5lMHJYcWprWXlvTlhueUV6ZXhvOHd3V3FhdmpjM0RoWFRlY0tL?=
 =?utf-8?B?dm96THlIaE9FazBNRFdGTkNzRUpDQWU5R2h1K0p0SmNOVTN2Y0tNRVJ6TmtY?=
 =?utf-8?B?WU5TTGxFRUM4a2JTNjhpektPQkJNRHhITzZRbXc0QVdCMXE0eUJDT2RRb1dr?=
 =?utf-8?B?YUtEZ0dLeGpTNEEvUlpSRGJJU0JoWVhMMDRJUUlrMHJYckJhUE8wNzNLL0xI?=
 =?utf-8?B?OWZ4MnBFa1FjNU93aDlVYmlmMHpwTTZPRnNvVjhCL3JyVkV6YXJPTWlTVXpW?=
 =?utf-8?B?eXF0dXFpYTU2MmppUU1tZk1nYmJZaUhJUWozUUVGdkNQM2Zkc1pCVkl0SkhE?=
 =?utf-8?B?SjE5T1FudHZYa01PRXhRL3UyaURzckVGazlmWEpyeFJ6NmhaTnpzUkdpVmdC?=
 =?utf-8?B?WmY4T0c4UVBKcUEyVDIvQnNESVVOcDBCRHVsNktpT1M0VHZZd2xrcytjV042?=
 =?utf-8?B?OGN1UCtBRDl3TCtFeFQ4bld5RExpY21UYURXTU9LY1AyU0tUZ3N0Sk92d0VO?=
 =?utf-8?B?KzgyWWxucTdnZjRYSlRKOVovMU1lMWNuRkh0SmdRd2MrOGsyclNuTVEvcnBw?=
 =?utf-8?Q?T44IVOfPikqGR7ph0J4SsUPdk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b92eca-30d9-45fd-22e0-08db8e6f4023
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:07.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AusrcPFAqoJlZ9y+FNCuL6cPLCQPXPTLhouFrvOxIcE7lFmvP8iEGV78MusOqIIeJc9TLxrm4NUc7Q7IMJddMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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

