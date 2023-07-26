Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E079A7629B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGZEBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGZEBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:01:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FC26A5;
        Tue, 25 Jul 2023 21:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMep3FonivACgSzPK+gHB4L4PwO4bp7pZIEgfg/sfcDlBCSY8y3RMtFxbDyPxhv7gs+nElSwJfcoSGyzVC44GnDVvs1dRkwO8bVjPxFW3BHuRR1Ogzw746sOdrj8YPjQivGO6OZ4TkmHD7GUdx1vHBUUHSUBjiYi6twZxM8ivkjBRHQNHpNKTfmeS7oWYSBTJK6/CwqOpD2/CIB20mzE+GRXr1xl95KIHm4tdpCkKiNO4lwuXorLmpPlb/JQFhwCyuoW3Wn/eJLjG0QEqfgUzPsaxfqZ/CG7yaqjUhXJx8BYRUUSZOGGffJLOMdQhD/pwtDC4pzsv/aSOqQ/QChbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=Z+/+gdUtFxIL/0DUNMrFmH/oZLMxWX6V4m6hN5On+3YHxI0meneUh25gS03iVd+ErjUSswQR4TRkeM0k74FNm90UWtpscN5TATIOUcm9tRVSsCVrJR9E7ZghLx/4AoLSW9dxnjzy5Tx/4nQ1maWbDaKqj5fbHn/Ox3Ea/GZiTLgm7p+OzF7WdDfBLrISS4uGAF9lYQ2HP5py81c7PZ4eEQnbWWcs4+GLjF4JnnTToUxiVmvpVfGoNwjzvpjYRyP8zDYsbzcvt/O/P1stmOtrfngln/48o2PdiesufXORPLKY4aTwVXsJMS8I9wOoNSe56eh5xyFJtnxKf9nLfGt6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/FjFXOniG69N9nJR/0wcardmXaPuoPDf1/5LYlD30c=;
 b=PmsyaZ7JH27nwgeQuzanaD3MbWTI/Ej//oc18UB+/BkefVCHHkZbHxtL1UaIvJVlYp2pT/Tmb+a60fj+zzeaepeGuRyBlV4D3KmL1ZwPi7gQWkuorYDf9VWdfxvmYY3FUhAZUCL2kX98uM4YizhrYN3ICUU9had4FCfWFOBtUlpDJTGPnKInX+4Lovxeda7l1J2ztidFgOihdh60HQFzKVqQKdXoR07/wG2+Xoy2HIdEXU+4NNi/SFObCJ/ScFRUXVk7hTHmN5L1i2ZWrcacpyCZ+USztqv5WHKAumjT3QbwORll1zO+4byPWroQUmCxFPJupDMF0Ntgd7VgpED5EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:01:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/61] mmc: litex_mmc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 11:59:44 +0800
Message-Id: <20230726040041.26267-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 8790577c-d439-41fb-1f0b-08db8d8cee49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffd3mD2VrfUdkopFRFpkxDyruaSNi1SrEfvteXGEKFwjJaFDL6wfKLIuiZNzkn41AcOQxOxFznk7UEIUmiMwQ5cCAio0I1ZDCr5acLxgBxH+GhdP1Qfulf0TWaAowJz8lwubTTBsSzGdKixS5OIJI0rTMF2Hw5l/KQJhOevy/tHwXE8ZkVS7Mnfrwy9jdKmjFU31aAdViPj4mx6ARG/6XDnO/Hr3EvnRnxjCMPvLk0yFOkn3xjmawgNO0GXwIcI2yGQx1lVJoNT3127mGHqjW5H2eIS8OKVbaW7MfZ6H9Z4HqLhhQeMCPLfFewGUf+t/NlCqq6gQRPWjo6/aFuzdblQJFVaOlmQe1Y/k1VJZCORSdie/mkonjstBmXNR+ZpYGHSanyZIlvvaLs1Gb/jcPmUE8TCXREacl3izx89Vkp7k5Au7amnEBWifooKGd4a9kOJN212eygidB41Uiv/DxCIYyP4CkLpt7V0/mtXf9YzxzMurs3kOYn9jwUsQG/JkTMP4JUk+qNHBUtTgDclOXCwdXQEVENZpk5RUztVkVGFttj2n7wdiOkIT5vuOlSnKEsnHhoMKdeV4NttwjdDGUuS5Q49EoQjUG2ajCaHs9KXsOSeLZbVkUG+6zlAXLN2l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEMvdDlLayszVlJIUmFUTXlKUWp1b2ltMWVyVlZ3c25OS3VBVGhkYWVHVWtU?=
 =?utf-8?B?NWVJU0xLUVpKU2FDa0VTNno2dmRqa2l2ZDVwVVlDQ1V3WDFDRmk4c0dJSDZO?=
 =?utf-8?B?cWVJRWlzcFRObkFlR1krZWtkYUdCS1FveWRzblg2R2kxR21HU2k5QXNPTVI4?=
 =?utf-8?B?SURHUEZxK09xM1VQRzJweUFLZG51ZFpEVlM0dGw4UjVpSGUvYUxyNUZuUVYv?=
 =?utf-8?B?YnFaYXFWMkpVTjFhYkRNWnZCV0JXaVR2aGZ6dTVwajRJWWdIVm52NEpicHhu?=
 =?utf-8?B?WXVDWWd6cVB5T3lhcGVzQVU1SFlxY1VWQ3lncGRxcVdPeE52ZU8rV3IraDJK?=
 =?utf-8?B?NFg1U2dUejVYbHoxZ3BOZHNmV3hLQmx6SVdZSU9xUXdldllibWR6clJEblhX?=
 =?utf-8?B?ZVdHRlViQnpUSS9tcDMrTkhPVjNlNVNmQ08zeTBHSnZDTWcyM3JSY2NVVjRt?=
 =?utf-8?B?VlRQcG1BQnFXUWNiN3FNNkpBVWFNWmlmb2RFOTJnZU5tVXppdjd3S3laQ1pa?=
 =?utf-8?B?V2xnVVQ4VDRoYmllb3VsSkNrWG5Pb1BiR2dvbDVFZGVKMnVmU3ErcEduOTUy?=
 =?utf-8?B?aHg4Zll3V1lIMDFNNC8veTZsaW8xM1p0c1JEb05XOUlHeWFMNlZKNnE4SjZM?=
 =?utf-8?B?b3Zab09za3dpR2tkL0o0WkpZWXNBSk1sUHhhOUZ5Nm5qZDRjM01xdHpBWFVE?=
 =?utf-8?B?QlJaQzdIME1EYjZ2TC9DaVRWWU12dUZaQlVkUUlQNVV1ci9QRFVjTGxqdWlx?=
 =?utf-8?B?cFFNMG9ldk1wREVQbmN3eGZCZWpOWWF6WmIzOC9aTTE1NHIxS2Fyc0JueVdu?=
 =?utf-8?B?c2M4RlMvS0hLV1Vjem5TVys2TVEranllNjRYUWNSNURQT1JUc3cxZlBhSWdN?=
 =?utf-8?B?OEYzdHZ4QjhiYVhoaWJjZGNSSGFvYnduVEY3OHUzT2swNWF0NEZOcFpXVlNx?=
 =?utf-8?B?Mmh5aldsdDUvWjBjemJndDd0ZjNvSWVyZVN3UGs0TGsvekZjS25aQ1ozYzZs?=
 =?utf-8?B?U3ZvRVF6WTVkeTlhaHNaVEVaWVJnV3J1bVlsZk5NS1lOcE4xWGNnNGlOQ0pv?=
 =?utf-8?B?TjFWejZKMnlyY1BVb0M0TDRtNVo1c2pBS0s5VjdZbHRqYVYxOUd2ckVYbElU?=
 =?utf-8?B?dXZFUForWEMyWW45SkJOZUFHWU1LdVorR3JTaUpnamZCdnJLQndWWGJidHBC?=
 =?utf-8?B?SCtMaVVrakVpR3QxMEc0ZHVldkwrSVd2RFMyQVpsYnNzWjZoeG1DU1JkTnJO?=
 =?utf-8?B?a2JkZFQrd2RJQXZOSHhVcXp1S2crMnpJSXZWMGV4Ry9zMmRqS2NIT25abklr?=
 =?utf-8?B?ZmlOdXFDUFc2VWJMUURxQTI3ZWF2OU1hY3hBdCtCM1ZmOGJocTdLOXAzVWdn?=
 =?utf-8?B?ZE4xZHRuby9wV3FtcStmLzd3SURwRU05UjExTXBvQUV1TzV4a2NIa1Nib3p1?=
 =?utf-8?B?S3ozd1h0NktRMFhLN0h0cGczd08rN1lwWWtGWUZ4VmVKVzNQNktqTDJ5UlF6?=
 =?utf-8?B?UkM0eGR1TkwwYWh0SmlFVlZ0TVV1UVVIakFQQ3dEWHZOayt2aXlaWFUzeWRy?=
 =?utf-8?B?c0diT1FUWkVRTXQ0VGNIY0VNY044bjg1SGNpQkJ3ZGt4YmNIQU1KRk5rTi9E?=
 =?utf-8?B?VllsbDErQTU5QUpMU1F4QXk0cnRHTXQ4cnRWVVpIZmx3VmpvR0UyR0QxMjB1?=
 =?utf-8?B?d3ZWV3p4UVdXc2ZpQTYraUYxYVBFaVR1NmxVY1c2cERiYXhoODJPemlHZTEv?=
 =?utf-8?B?ZklRUVFOMmpJZ1ViOUJHNG5YUDB2T3VqMVJ2WG44VU1Rb2ZkYlk4L3JQVkdq?=
 =?utf-8?B?YlJkVmZsaHhDQ2ZGMGRIdVZUWDhYUVJxK0UvQTdrZUlWVjhleVhxelhxSE9Y?=
 =?utf-8?B?dG4xR1VpS0FleWRudnhvSHhqWlFSS0JsK3BWN3FNZTFQbjBybEtidHc1Y3RT?=
 =?utf-8?B?Vm1LYWtVUUF0TEI4OUFkNnc2d0dmcTZ6clY1bVkyc3UrRGMvRUMzU3djVTY0?=
 =?utf-8?B?dGQ5a3dSUENiMTl6WE1WallBNHpnOCtGMzR5WUYvWVoxR0Z1Si9jYW53Tm92?=
 =?utf-8?B?TE81M1pBalhWaFZrWUlYd3prV2xEbVVFNEYvUHRFV3ZDWlpWZnNpRTVNNEJn?=
 =?utf-8?Q?5CVSgAEzV00faQVmTEWgLsmrA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8790577c-d439-41fb-1f0b-08db8d8cee49
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:04.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQwbqI8mJQsWFR/fXQ/enZJDZSTKqJ8204YniEcowyJjVrASTPlH2Vi3OgVYVn4sC9ko+qzSTZUNcOrEEkBoFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

