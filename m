Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFF7629DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGZEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGZEE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:04:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6046844BD;
        Tue, 25 Jul 2023 21:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDi44R6Md9yq3qOWSMrz6qhSuchzdVKpi2j2QJmVK5Hch2p+vgCrQqMTPo+txgvUoNsjRe6HIoNXp/Ayi6500ROkb+CRhhafDUBpemKHHOqib4zu3yKEGtV60C6NqlEncj2F7jVJYARTMDLau2d9JgjjLkjmxmw3M9646nFFIgdN3M8o7oZWPd7RNNsUkfK0UEW2gjrP7/WT4ZktPKckr0xou1mgcZp4dHgGsBV6pXSGvUigBlDjT0Il/WcpoEoszbdawRSpdSGmE99mrE+Qpia1REU5PZ61112t40Q7R+oZ+XXe2LqetxUZfD4j4tYwz0NqqvQoGuAEGjFdO6P8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=Wdi9oykchzSYOHzFakbeSpINkVgKy+QTw5Q5GrYzXQO+311YkJdUIde5EyBvtYmHbFODMe8YCaO5FT2mMDH/RutSzRaByL4O4zLwU/qhvuYnxB3l0BTbiX+dZkRUeiHK9EOsbSB4ciKCPVvzGAVKrUvij/q6fV2GmeLmMhrrY4/967wv+iyfOkYjDYmM22buAAZV3finv6OpMpHEVtrJ+3qsnS8yHalgdtdUdKlIJquZsGluJ2iMyMJG9mu8VpeLy4BMuTtkjTHZ1S7JFtTcttCEHBFCOeYUVRri25X4IA2rvJM7SrvkdjuTcP1DBBV/a4/gKYOusuJIrDnThzI+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=JQwIM4Gq0O6mme9RE1jswUqf6RS9Szf75iyXc4rFsf1GN598M8FWYshlwrSAk7iIs/8Q9jdtnGhdxh0lfnCBD/IW3MvKsQ6ZEpWKl92Zv6brRuzOHs97X046PJmVydWVKUGaKGuWm8KZZd9CNTr7kx4ofhQCALvFq5ITmS+0QhSSQqX51et0WwVW4BkAH/T72IAy8kdfaH2JiQ/cxLGz/QYFqc38fk1nt+CEvpynkg+nhPbneapL6kOb156wxOSg0/5R4ov6qwW944oZBPVC6NkrT2PorR5nC+FoFmkVcUROxWgpAikskf40AiNzC4zmuVHJMjTLIuKcA2GKvWm5zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3934.apcprd06.prod.outlook.com (2603:1096:400:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 04:01:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:01:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/61] mmc: meson-mx-sdhc: Convert to platform remove callback returning void
Date:   Wed, 26 Jul 2023 12:00:02 +0800
Message-Id: <20230726040041.26267-22-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a4784e7-2cf4-4011-9701-08db8d8d0231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1qcFDg4jJKOW6mioWJDixaMChjEwPeXpm+RJCxZaz9gpykywkHSggCpOGZqtWASx3iVPhkLfB9sFW9L5zttE3QcUWSSXy182mbpT3lDgz0G+Xm4SVsvp7+zIA72fs3+q8Gy3tX+uqgPwyWvLnq0IwkxTjhOsFYfwXaFSk6mOcgSxm6sSppcpW04hcm0QGIoxk0wiPgCL4fMdwABI61sf/YpShMKdDjVLzcx7OPAjuJAbxy+hQ9TbPtza5ANqnVkspjUYplDB6YbSBUHkSu+Hqq5VFuMrp0BDJJuo83SgDpkrsA6AU4dkB/lR+U4cFY1zSBgHFSgdqyB+94aopS6u1EptVzStgIehkDXXIMn6615SIyRsS7zxeXks3bKlqG/cNco3m3qEYl7pGDConyoOz4/klbYXcOdHn++OO4iuVTD/+IWUEzSBU9YQtXehD7rZAfpR+8mB6+FhJBIjakBzhvH0IdG2lci8FPSj3yQfyyvb52MuKwXNWnQ4iPMIqWsMlZtswOO6lznJu+wSIg1fitz2KpHmQ7z+886afI8cgp/a/NF1CYD9T8QIM9qHYgxiKtR8gilJ4Bm2Qtigcs+InDjeRU/blZe9qi2MtKBAsW/3rgMdFtRTXcZa7lXC0Gx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(38350700002)(86362001)(36756003)(8936002)(8676002)(5660300002)(478600001)(110136005)(6486002)(52116002)(54906003)(66476007)(316002)(4326008)(6666004)(2906002)(7416002)(6512007)(1076003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dSsvbyttNmtUVU50NlV4TE15TzNhTGhRL05NaUtHM29zbWxSOG1xYVVZSTg4?=
 =?utf-8?B?UmxMcFU0NXJIL2NlVHdnQkhlVG80NGFERWFqQTNJb1V2cWtVbEVMa0V1U0tQ?=
 =?utf-8?B?S1poZE1ZQ3pNNTV6emc2Ti9kK2pNK0lVcUFrcExrbU1pUGpmNDNjNTF3SUFV?=
 =?utf-8?B?K2dVdU13VVhQcXdjUjh6UjVwU1V0VnpTOCtnY1hhOXZFVUFCWTVRM1oveE1V?=
 =?utf-8?B?d2F5ZkVEa1Z5eTdabFpLcGlHY01hYjl3T0dLL0UzOGppVlYwUlM3MzByOEM1?=
 =?utf-8?B?eHI2RlpXbkovNHB5M3ZGS2FDSEZaWjU3SnB3Zm4yVGg4WFMxWGVFRlJxeURX?=
 =?utf-8?B?a29DVWs1N3J4djhHVjRiWkJmcDdFeWNrdDdGRC9FUEN6NmlvRURyYzI4NDBH?=
 =?utf-8?B?Ryt0bHcwamVDSzhqM0VBU2FlMDRySVlycVVDVmZzcUR2MDZKald0SHRPbndQ?=
 =?utf-8?B?RkR1R20xK29kRDJ4eFhoN01pRkR0bEZNZmxPRU1zU2ROSlRqRTVxV3pTZ3E0?=
 =?utf-8?B?SEFHYTB3TVArajIxM05wYTczeWh1czNGRzV2M1VMeFVZT0VoQmZVOEUxVXVZ?=
 =?utf-8?B?RjkzclJVczN0QW4vTXhaTmE0TGEwVzgwRm1zVWttWnNPTkdpaEZmVjZvelRO?=
 =?utf-8?B?VmdpTHE1ZnFaaXJkd0lUR0RWSnYzUmk1VGozYVRsU1R1d29tTFlaVXZRZUIr?=
 =?utf-8?B?dEVUQ3NZc2pZZGZSSEtLaWUydXgzV3luRW8rVURiSjVIYUZMTzV2VXZFNmxU?=
 =?utf-8?B?dm4zb0UxcDh0SmVMSVJlRW5LRm9YMHBzOUVHM0I3WmdGeXRNQ2FiVlh3NU4v?=
 =?utf-8?B?K2VpVVd6MkhPZUFhNmpHYkdmL283d3k4dlZsbmxnT1ZZMjVEa2ZxSW9Vc21G?=
 =?utf-8?B?YW9EQzIraktBcGVEVmJ2cUdjdnBCSjlOL2JsckhaWlhVMDZzUkZHWUxvaW5q?=
 =?utf-8?B?NkF0djZSbStiZlc5TUZMNlBLc0NKWEkzMjZYV095Vm5reVQ4dk9UMFRQU0pq?=
 =?utf-8?B?TTU3M1B6cVZPUVE4a1dyS2xHaHp6dndVL2taQVI3VEpXRmJRZ0R4YmhJSkJO?=
 =?utf-8?B?eU1EckJEVXNvU2FHT2NOVWhSSFlheGVjcmFlSU50bzhWYkVITHRmY0NmUUxY?=
 =?utf-8?B?VUVCbURkclNZTUF6QUhIR0JCRURkakwxUnN5aEVnTWJPTzNoWVFDUERNMEU1?=
 =?utf-8?B?NThyUDJ3dkpiOFRvL0RXdkE2MkVFL2doYmRSckNkcHhFM0hEZW44RzI5TDVl?=
 =?utf-8?B?aUF6UXEzSVE5OWxjSzA4QmZmOWR4ZmhZdmd3RklwKzRBaTh3WW9pVDRGbGF6?=
 =?utf-8?B?L0F1VHltWUJCdksvK2owenYyaEZGcSs3d2lhdldYeklaUDhzdDRiRE9ER0V1?=
 =?utf-8?B?eXEya1VPWUhvaWM2Yk1uN0N2VzZXRE9jem5VS2RLRW5Cd3BZZ2NHbEVoUXdj?=
 =?utf-8?B?TWlXK29vREtPTGpYdDRVbitoeXk0aXJsSGxLcWE3UWZHZHMwTmMzdHpDZHJk?=
 =?utf-8?B?Ni9jSngyelpVVVc0UHhIb204OXVVV1NGdG9udGFXWUE0S1l1VUxXZzNYYUJ4?=
 =?utf-8?B?N2RES1Z2Um03T1dKRjJoRWxxbWVaakJSVHdqVGNCK285eWV6VjVKRG1ZclRz?=
 =?utf-8?B?VTVNYkFRTkpER0tnM1Z1WTdwRmU5WlhVMU9yMXZUMUlDSDhPZHRpMVBPY0M4?=
 =?utf-8?B?eXA0dUlueUNsN3Z4RHNQNEcrU3JQZ2RiSVNqL3FOcTVtTGhwZDFmRmViNDln?=
 =?utf-8?B?c1dnRFVjemVVeGFkak5OWTk4L2FydjBwYjJ4UkF1Q24yZnFrdkFnUjBhTUJC?=
 =?utf-8?B?NWFaekNqVDZFSGd2NVMzYlE0ZWh2RzFXM2FBclo3cS9ndGhGT3ExV2ZwdDdx?=
 =?utf-8?B?c3VZMEtidi9tMHhZRHQ1NXl1NForS0tHVUh6Wld1ays5QmVNNTlxMEFtQzVL?=
 =?utf-8?B?MnZqTVFzS2crRHRvUlZmdHVpZlBQWmt3Yk1JWlE1L2hoa2ljMGRFb2lVSk11?=
 =?utf-8?B?dmpLRGxpV1RvSzJ4QWl0M3dtV1VCQ3YwaFRIYmRHd0t0RUt0OTF5eHJWM1l0?=
 =?utf-8?B?UjFMd3kySHBER2tSSjZxcTJPcmdlYzUvVnZKZlo5Ym8vZkh1UDR6dmFFSUpm?=
 =?utf-8?Q?jNz948tyFN2YRLfvIcBX3bfz3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4784e7-2cf4-4011-9701-08db8d8d0231
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:37.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9W3+n35eQ3N8Ur8wrxX6ggzqLhKuGP3SpdFsoFfkefJyLzixS55vNNXwmcOWg1W/mb/KM3iq2g4g1bs6YBtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3934
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
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 97168cdfa8e9..528ec8166e7c 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -880,7 +880,7 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_mx_sdhc_remove(struct platform_device *pdev)
+static void meson_mx_sdhc_remove(struct platform_device *pdev)
 {
 	struct meson_mx_sdhc_host *host = platform_get_drvdata(pdev);
 
@@ -889,8 +889,6 @@ static int meson_mx_sdhc_remove(struct platform_device *pdev)
 	meson_mx_sdhc_disable_clks(host->mmc);
 
 	clk_disable_unprepare(host->pclk);
-
-	return 0;
 }
 
 static const struct meson_mx_sdhc_data meson_mx_sdhc_data_meson8 = {
@@ -925,7 +923,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_sdhc_of_match);
 
 static struct platform_driver meson_mx_sdhc_driver = {
 	.probe   = meson_mx_sdhc_probe,
-	.remove  = meson_mx_sdhc_remove,
+	.remove_new = meson_mx_sdhc_remove,
 	.driver  = {
 		.name = "meson-mx-sdhc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

