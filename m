Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0F751AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjGMIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjGMIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:09:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A92737;
        Thu, 13 Jul 2023 01:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TejfADj43lBjstL3ildot/SwrZ6Gp/UDFXlcKf7xoyE0aYWK3WYDgoXIPjY2zmkLyyqyS7dVNe7NvijbPMh771WasgkpbOUDom7w8/ju2PDWigzHH6XCkwNmWtvWOcspIAPxC1TOzhEM4ZQrrfBhOnIHO1e8PlZlda23aPcCAO4TaCFO8zVYhozSVSVLY0cvzNBiz4L/7HyJ3xRBNDaw2oHdnQhgfR6PvHnxcQGRhSkOYR4zY577l/LjpT4/9wza5k9EXKTxOvZu6uc9/5hrOYD+Vv4BbdKI42eDEJqpioWHTejug26qJctNEfoNSvIjqwfSmG4k+aBJixfEgxp2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=mFx1rDDRvLc8UABv53ijL5MtH+PKuqMPwslU5dD0D5uDYmWGKeiS1LnpWq5Y8fp05V65XymrjNPZq30XrF0iMvYwtwHSqMNmvuEpu8V8arZfh261iue5ouWr3dZWIdEDFBEev60mecQ2svWjeitx79sXylhKgrDc/h9pTKhWhor/gPqEb1pBWu7NINGv0MF3V3r1PWWW+NnfDlc9XQ8ycmfRT2oinmr1nxSN4DB/RynvdCaGMfXKY0D6s0tQH1QNHY3+WC+ghl7eqSG6YXll36S6liDnRWtpb1xao3qbMz/WQ0mOyLvk84WdvuGW8QqF9qVATOa0fWmObP4HrTMNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=aBra61OGSzPiF9yHweWn0AmosxD1wTDSV7SphE6cUzBwwlZ8c7KjERNj/+wV/cX3fVielDNOZeRkccphwsjoG9YKO9RGPbaun+tViWzInAb79SYAjyOM3khKWiICJOZZHY0659q+g4lMQfl0rSYc74gwN7vPfJrYB3aWt3txfsd8ZkTMi9pIZZ9GnUYEsgGbi5E7GuLmgQLSa/0NIJ9P16Z6tS5mZblrE2srg/J6CgTUTROmwDHJ6jklmmV7EBJXIlLxAUbram3oPQrOx0nQD8skq2PHVX+P7jRdj2Bd4B0BmpSfUCrVXeVPNfUcj5o+i8+Z99kFWlfpoocxGq7egg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:08:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/58] mmc: litex_mmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:13 +0800
Message-Id: <20230713080807.69999-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b79dfb4c-3bc4-4661-ab21-08db83785602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWG/RqPx1LIcc1A8K7J7w75XRSX/1bmitD74YcfSUwhq/Y/omJFsdQB9AGs7Z2EmI0d4EXmZQnduecg/ExxLDvu0l5eUxvbNpq47UmtdOmwSgnIx3meweMF6/TT55JdWizXvdJ1m7lp/v3nu7ClwyNrTWKkrHgHnu/DaqTrG4daw20VmpvBtDtKhPXYJudZdoFy88ftJKRKMLImX9p0Z2/1pBl1qYEXbeofa2O4d/OmWiv3+ENpTXWTY1o92qBde8+Q04mEmkczyu0ZJq4UAUqQTeyiGrouuqXhATg3AFnKYJPABfSeM6wh4gViutNYbejThYxhusfjnDh9Tqz3tFocAdPf7fpDkBYoS66Iv+VHeN1rohb0KJki913cxUemx/6fxRQXw1Dsn7168/jmgLnD2KEWcgHSshkR/kKbuj3kgDSpUSV7q4pfujubaUsRRODOGzEeiS3kn9eP0DAwB3aX3Bzb3oWQFinM1fKcNvKXMGFhR8p/fhwKkUVj7QbpCwlBQ4QjY4d97YuIQG4/rbnB6wkkTml/mLovmBv/PB9Mc9tvHxXolk6KvF+qclMEOTKn3V17B1o+54UehCUyXQ7+9zH54+cNB8pFYSpRoo3KaKNCZr6+Y73olbTYbyCBN2kMyzUeKhFkFS6NMWamJoljPVnt13tiSlK9IOVJ21L0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(38350700002)(38100700002)(478600001)(4326008)(6666004)(86362001)(52116002)(110136005)(6486002)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(83380400001)(186003)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(5660300002)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JWV2pXK3VXUitMSXFCeENLTUxuczVuRDBRVVJyTUxhYk8vSThlMXlTbmgz?=
 =?utf-8?B?LzZ2VlVoZk1YeHVxdzgvWElxTzI1VllNUXlUUGZZcFVjaE8wUkRhdkljVGN3?=
 =?utf-8?B?eXZqcEZpTDBrWmpibnJtdnQxU2EySXN2QjJlVk5YWGE1b3NjRkZFUDd1dXZ0?=
 =?utf-8?B?OWtGNk10NWVRU3BaZnY2MWtLcWxqWjhQL0tubW0yM09lMlVUNVlZd3FxakhH?=
 =?utf-8?B?TG80MFQyZVBadkVSeTJGZDJMZjEvZlF2YXVqenBqVVkwenE1cnRRTVp1WC9M?=
 =?utf-8?B?MURweWdaWUI4ZnRiOWJIWjhyNStCNjZDbjVmTWVGZ2xseWhoL29xUGR3RStL?=
 =?utf-8?B?WnlQWTdhV1FZM1NGdFJ6Und3SlJSVXZGWFZpWUt6TDh4TEZxWk5mOFZvQlJB?=
 =?utf-8?B?RGkxNHIyTGZjNitxUjhlQkVRQnN2clJrbE12cW9OQVJCdCtnTDdRWC9WM0Jq?=
 =?utf-8?B?TFVPRGlNUkFIaDZRdGRTcHZrdHZUN1ExNnYxTC9JMVY3L2ZrdWR3ZGpqSEc4?=
 =?utf-8?B?TUpWVzFZOGUzU3k5QjAyeFFZNTlMK3U1RWNlREgxK3d6NVZDTFRqSFNLVXdU?=
 =?utf-8?B?czJ3WGNjWVhCdUUzd0luTWZRcm1RS3hqZ0VsU092MWxvZ2NPMFBQNTRZT044?=
 =?utf-8?B?bzNrcFZneGRHNU40Z3FONnpGZmxMcndocXU4K1BteTg5SEpkaDgzUEIrbHhm?=
 =?utf-8?B?SGhMcmVLVEFIR0c1ZU5DaExRNVN3Mm5keEJmWllMZjVqT0FhbkNnSTZLSjVv?=
 =?utf-8?B?WFVZZ2tkNlhvZ2M3OHNBbUZnSm5wK2dZS0hIUGtUbEhNajJtSGpudTREd3Rx?=
 =?utf-8?B?NVpNWEt2L0pyTVREeFYxMnlBR1BDWVdtWmZHUVVOVkErcEFRWXBXZncrREcz?=
 =?utf-8?B?NzRoQW01Ty9uK0xYdWR0cFh6UmRBWFhYY3AxdUR6WjY1VXJjWmQrZXhsTkdH?=
 =?utf-8?B?SlpYbjB6c09ydTRqbHB3MEp3RVB0VVliQXJ5UUJRUlk3RnFQcjZKaVI3T2tG?=
 =?utf-8?B?Z0loWmVkOTVxSjV6b09RMlU0MnllaWxmaGVkc2lMOFBVK01UejMyRGt0elFs?=
 =?utf-8?B?RmRja052Y0xITU93ZmFOMmIyWW15NzRhTzFUbHhycThwbTYxMG5FZEE5b3pL?=
 =?utf-8?B?bVhxMEttTWh6RVBKQ29NVC8yZGQzU3JVM044ejlISEQ1bjBiYjI4RkI2eHBk?=
 =?utf-8?B?a0JoMUxrRkZ0aGZTZ2RZMzg1amZCclU3VE5wbGthSzNnRlo3WlBHTmNNbEww?=
 =?utf-8?B?Q3RWMlpLQlhwOU9sYnJHRGh6MGczRVVjYWFkQ0czTVFyME5sMFJJSG1KUTI1?=
 =?utf-8?B?NngvZkRVRDZ5REUrMG5OQzZMb0paWCtxVUNPa2I5MXF2NXkyZ0tqaXhtaXhi?=
 =?utf-8?B?bHZrc2twV2dzQkpvV3NUVUdLSWxVcGFRb0pobkJWVFVyU2Q4aGRhUFZVZ1ZQ?=
 =?utf-8?B?ODRCQUkyRmdxbmtoZFhoTms3dmUvUXJid045bzhodmtWS1VWMFl2blFjMkQx?=
 =?utf-8?B?b3VxNmMyeDBDQmdxN0MwWFovLzN1aUZNUDgyQVpDSzZpdzh3c1BEaGJvZ2x3?=
 =?utf-8?B?aHF6cmJETTIydEpqVTVhTWhHYVZKcUNSQWs3R0VycyttR2RKNXAzZk1saXlr?=
 =?utf-8?B?Vld3TWd6NG5PZ1k3VnBadG81aWIzMUw0STVDWHhlTGdhbWFlMXVBZTlIWklE?=
 =?utf-8?B?SVdJZkFsNEZZWG1ra0ozaG9Scmd2RTJob0NSYVhPOXRmYy9pYjNwTUZTcU9x?=
 =?utf-8?B?cDFEVVVjeFlZcXRqY2hkdCtoRVRmdHBIdFh2bmdBbzE5TU9nNE5MQUJGUHlz?=
 =?utf-8?B?azcyMlNjdWhiL2c2UEJ1QTMveHB3dmFTS09UZjF4MXNaMWdiUWVoSGhPZkF5?=
 =?utf-8?B?dk43T29WVVA4M1BzbmZWQzI0NXNrN3dMQm9La2w0aUw5aisraXp2NkE1Wmdx?=
 =?utf-8?B?TXdYdnA1THRaVTE5TlpyNHlOcXpveHV3dkRqN3c0cjVMZ042WEIzeHloQnpn?=
 =?utf-8?B?eU1QaCtNc1VhNzZKU0ViL3UrWXNqM3dtMTNlTXl2azZvL0ZXYWxFRUQzRzR4?=
 =?utf-8?B?Um1SQ3pEZ2U3aDdNNmVmVHdUdnl4WDVPdUlhY1QwM09YM0pWVlBsaGNYYkFZ?=
 =?utf-8?Q?ezutktnZqqjc/AFf7PmVXKV98?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79dfb4c-3bc4-4661-ab21-08db83785602
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:26.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezKt5X2WCy6dDk2YAuG4j1wTqAobE7qSLq6wbfTLYYxuEIYdV8wf2muiKKherBqFVPQfBGzwlzYDxooNk2Fwzw==
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
 drivers/mmc/host/litex_mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 9af6b0902efe..4ec8072dc60b 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -629,12 +629,11 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int litex_mmc_remove(struct platform_device *pdev)
+static void litex_mmc_remove(struct platform_device *pdev)
 {
 	struct litex_mmc_host *host = platform_get_drvdata(pdev);
 
 	mmc_remove_host(host->mmc);
-	return 0;
 }
 
 static const struct of_device_id litex_match[] = {
@@ -645,7 +644,7 @@ MODULE_DEVICE_TABLE(of, litex_match);
 
 static struct platform_driver litex_mmc_driver = {
 	.probe = litex_mmc_probe,
-	.remove = litex_mmc_remove,
+	.remove_new = litex_mmc_remove,
 	.driver = {
 		.name = "litex-mmc",
 		.of_match_table = litex_match,
-- 
2.39.0

