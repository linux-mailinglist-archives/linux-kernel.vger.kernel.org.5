Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25500751B26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjGMINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjGMILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF21BB;
        Thu, 13 Jul 2023 01:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8TN/RY/M++kKH7+r5s5Z2vBrf8C3UkF2myQXxhwkps8NtIegn3HYZXyx1cF7K5CjSdaKmK5dmIn4/mqjLP8X+dLPl4R3Q4rmtuCie8o6sd8yYNYkgrfJi1mLIX9eawDgFqS7NDCYMtmyW7rRgJzxxsRvWw4l5NXtym7JqZR91bRVc19+CJWLR6jhVGsEQ9D39Vy6yWF+bUHdhk9wbhmdWo/zNY6ItjfYSXh1PJ2LCA3X2n9KJBPlSDwKQf/E9OCf7/oA/z2Rnn/M5bX6z/3KjDWMjPJWFkZv/8y4+kUdu5+EBVPvvm5WOG27wRFVwmIMUveSWZ4z7Edbqn8jouUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRmZXFCwumSmLXQwjvRHThU5yBcyjcWZ8ZYYoqniSk8=;
 b=jsSGgsy8eEQMX509+bxl52GLpLeEE7fjLnU+TzkPIkrAKd72Fucx3w/KzocHBs6WO9NqZgwpxclM5fjZ9/moMbZkckO//5RBd5gRzF/1Ey/XnQ/Tgx2fly8zNM2AyiCNV+HSTomO86UtV4VEcpyy5c3cfAvwfzfnS6+cQJTQknprELFDYhmdl5xsJPE2j3oFvJUDeck/rZ7XD2IVAtBHQbCmNu+blFaZDpF47wEKs98S+tq4ieQY9REjUJK/Q6dqjrpts+PIpel6NFzaAzLhLG2+IKPXRoGSzIRI/KQPhIHuybimv/XYUuHC0iCq3771FYE1VcVeZ6xOZ1a5ja4Hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRmZXFCwumSmLXQwjvRHThU5yBcyjcWZ8ZYYoqniSk8=;
 b=JOzyjoDSQ3KG3ckIZpJqyc858jSyD5vd5qM5/8jbp2lWad8H/6koQeimFKHr8sBujlKOXVRciFKXAhfckTbALQ1F+fMcMgCsQZoAgZQ7rPdeJOz6n23PZiLKZm1oZa5/gA6bv9feg4QcyYUGzEyMi2wDMIZMHXsGQ5/+jiPQzG1R+7qcOSHku777bC7ac7+azmWQFujbuHQiQ15B6w7zmUeVZDc3xvxzsnx9S1yqEkCesQNuNtg7vS8PNr8ndRISPIBG5eQ9fn7yuOotSLcvudMT9AnuULOT48K3zUWYVqMsKFlrMAKDLe6zKczy1ZRQ/Pun9A7lF8udl/LCmMYAYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/58] mmc: sdhci-sprd: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:45 +0800
Message-Id: <20230713080807.69999-36-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 312846ec-be51-4a84-60a1-08db83787831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltSQOnqZIgVizz71ttodLZPPVNaL6MfA+lzxtmHsiOydId2lU+GF+Olp7VJWjVeB6bJYSVs8zYYbjVAVemqZUIwIn0x0SzjK0lAndTaJXDwKzqxnHb6jgO+P32ZKov4o6+wzyhMaYx48eo7+++iJmUwdQQ9hNKtMdsE9LdCeMuo1+G0XcBXygZtpu9PSgzKQI8Okmn1H9JZ8OKJ+wXierUn9OWKvD5nZxEIuVfNzlxSFIZJqzJS/xk0x5+DJ/kHo1N5z03e00Adn6PAkpqjVZd9oBYwro6F4q8oNsw/HOkzcufUMP+GddssoSJNO2jAMgZoDeZ5yqtEvcaqVxFblwYleBRE8qyDd+Kzws6wOthTqKzxrogFPpJmiAd8Wa1XsCf1VuHpSjfPEspEswYDMo2AVQQg7FSeae7aR2NicamW5ZgLIY6JkqxKxlCwEdgqIFVpeBhgrn8RdEuJQWoeCut3AVGVxmgOHJMmrSd4t0Lsm21ypSRRgQTew2n+dscxD1JldnQh5bcIGLk6Hf/+mEN8hGgCIkwk7jyowsuYTXUXjLCowB7pQpqyI8RUydggPNDSBrcBfCSzQLtjcFd3RvJ8KcF1QxVs53PKPP1hiAVwitYcJYCYmchFMG+j2FDYC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5nWmxPNm5xMkYwNmdqVEpIc2VZcXhNdWRIWWl3OGJKY2FJNlBDUFk0S0Vs?=
 =?utf-8?B?VjY0TlJXSnVYZkFEWWo0SkxMeGlBbGRKc25Sd2tmamFBSmxWUjY1ekQ4TzRv?=
 =?utf-8?B?bTdnZ0xtMVBrc0FHakFzZFhWSldNSE1STlVmUlBpVlRuSkxlaVlvRlZ3SElZ?=
 =?utf-8?B?Ulg5aHBwbjZobWk2MGhrVzNhb0p3NGZHUDd3QmRSNUNMVThoQkF6d00ybml4?=
 =?utf-8?B?eWNpc2N6SmVDcERROTIwOUVxSzJFL29YS01ENUM2ZUlUTFZoeUlHMXFJNms1?=
 =?utf-8?B?b2VtcERHMXZtdllYOVd3dld0aXlKckpxNkNVckJaOXFwZ3hBdWZ6OXVLY1Mw?=
 =?utf-8?B?WWZycWdxT1luVVhLd3puckRkakFldHlrT2FCSzUyaGwxV1AyVUlicmFuSWp4?=
 =?utf-8?B?Slp0NW9TOTFHOUNCcEJ3cTBPaDdUdXhtVUFtUHJrbU5JSlRZb3Rqa2hWVXdv?=
 =?utf-8?B?SzcvdDFyK0N1VEV0OExDeVNqekpMQ2RiNHNESWliaG43aXBkZHhMYldneVdv?=
 =?utf-8?B?TmVVdWRWbC9lKzhaeXYvT1gvQmJYaCtnU2RRS284bjNlbkFRWmMrUmZNQUli?=
 =?utf-8?B?dDcvQU13TmdCcWRhQmFvdzFTWStIYWZSRjhqWHRiMWdxM3hOcjVRaFBmTkRs?=
 =?utf-8?B?TlBEQytlV1VmajFiQTM0Q0ZPd1Q0aG5wL3VBVjBLZllYd1BraWtoYlBicWZo?=
 =?utf-8?B?TEg3d0JlZ3EzR2RwSUhOVVdBclQwbVd5aDNzbjdVd3ZYRlFSMTV2ZGNPY21l?=
 =?utf-8?B?TjlrYTJyTmJzL2thcnJkSWRhVGFkS0dQQkpuSmhxdkY1STQyeitTV212T1hu?=
 =?utf-8?B?UkFkd1E1R1lwOHB3TmJsYnlxVkw3aTliT3YwU0UzRk4vVkZIRVlBL1AxaExZ?=
 =?utf-8?B?alEzZFEvYUxYOXVXVjRwVXdGTzBWRTNJYlZIY3JiQVRoZ01CdU16c3FmV1BP?=
 =?utf-8?B?cDdtaW9qOVl0cEdQSXRQSmdaL3NRREt5c01ZTEFXUVllTzI0aUtRbFpDLzVv?=
 =?utf-8?B?aGFKNzlWdEduZHR5WCtKUm1YUURGT1FiVUdaVVJDK1VjVDlKb0ljaXRoaE1O?=
 =?utf-8?B?aTZucVJFUkRkZ2lFMndoT3VEMVpKVVZrY2FsVjZLaXgwUjN1UHE5a2x0K2t1?=
 =?utf-8?B?VnBuU21jcVNlWDRYbUZDdWV6WElObENUUGhBbTZuUjBVRmM5UmRWZXZjTmw1?=
 =?utf-8?B?UkZLallDVGI0WTNpbDMzUkNiUHU0WXBiUlgxbjBsSjBLZjJFOTZneUYrSVNK?=
 =?utf-8?B?RFR6NnUzR2JVR211L3RBTUx4U1BOS0FQdlJTdlc0bWltM0dYdGdEQ2JRcWQ1?=
 =?utf-8?B?aHdiYVFnUnZmd3Y3NXE1U1FId1ZEUVF2NzkyU0htS2d4Tmp6KytEZnJmNStZ?=
 =?utf-8?B?MzQ3OVdUaUhrOUw3b1hlYnY4Zk1ZaXkyOU1lT0RacEhUYi8zdW92SDJoeEZ1?=
 =?utf-8?B?T0xGWU5vd0wwUGZPSExJelZZdUhNUXk3amRwQ3NCSlZSakRsSlZMa2RQdXVi?=
 =?utf-8?B?OUc1MjViUXRRQlNLWDloeWxSYzBTUkE0WEhSVXBvODUwd0JIcmlPSllneitK?=
 =?utf-8?B?WU9FQVN6T2pEbDVGRjFaSlRLeGgxeW5XZ0lBd0xvVmJqcTBVWHhIR2lST2w1?=
 =?utf-8?B?WXorZGtZTm1JZkVnZG9zU3BUUWZIWGNaZklLZDl4THFNWWdCa24yd3h2MGgz?=
 =?utf-8?B?ZFAxUEVkeVQwdmxBOGdESTMvYnp4MWlab29FQms0UGF0MEpVUFN6YVJ0dzlj?=
 =?utf-8?B?STdVTjVlRTRwV1o2Z05vQnZiTmVUbFY3cXh4dlZBeXlGZDQwSDF0cjB0ekM0?=
 =?utf-8?B?US9Vais4SDZCNTF3emU1RzF3M1VWbUhHK1ZXOVkxcXpQZUdkR1JQZ21pRFNw?=
 =?utf-8?B?K3RIOHQ0RTQ2N21VWmg0NlpReXJzdS9pOUZmditoZGlZSTladTFGVzBDNzdH?=
 =?utf-8?B?d1kzaSt5WnpOdm5kMk5raVFJSU4ydU1lc1p1ZmowY1NVNG5uR29Ud2oyTndw?=
 =?utf-8?B?VzhIYjZuaTk4TjhBWWVFSWVpUEMyNzdsak41ejUwZjNrdjJadkw0UkRSbUFT?=
 =?utf-8?B?UjIyLy90WFpYYy9DLy9FaEVSUTNab0VMVjViZmZYRzZHdEt5aXBCSUJlU2FK?=
 =?utf-8?Q?LF/aHLLie9bmWzJfR09mXwynw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312846ec-be51-4a84-60a1-08db83787831
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:24.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE6FkbKXjWPVcOwcgkavleHyXAvExoTkTAloAbgwmgnnch/bgbJVgXnTDB2MEZDTjQhe74wCQ/zlg7/CyV46dg==
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
 drivers/mmc/host/sdhci-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 7f4ee2e12735..379cb3892757 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -720,7 +720,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_sprd_remove(struct platform_device *pdev)
+static void sdhci_sprd_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
@@ -732,8 +732,6 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	sdhci_pltfm_free(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id sdhci_sprd_of_match[] = {
@@ -800,7 +798,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops = {
 
 static struct platform_driver sdhci_sprd_driver = {
 	.probe = sdhci_sprd_probe,
-	.remove = sdhci_sprd_remove,
+	.remove_new = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

