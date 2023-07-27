Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB67647E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjG0HIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjG0HIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:08:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92422721;
        Thu, 27 Jul 2023 00:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYvPRACFFpTo8RdWOw/ZCUzU17TctvwIXVnepEh/7r+Y7qv/4dXYg4I9687kIHp0Yl4diqj3VWrC7sQK81OU4+AHyuGEegh2+whOSahtdVVAwQvmIgGhabLkQ2FHZE3cU7WwXc289ucSzEDOJo8Ujs3Pn+jo1xLimbe0hFha2MrjJSLt/qQ76lHd5P7ZFibaq7AnN5kKYjiTcmlwY4BGx38l2tQQCk1/FZm6tL2lrSSLA/UuH7KaOwA6CJzfjXt32vMBMlmLzlXV1CMtwpFhYS8MmKPSAReeb6t7JHbUe3S16eVB5vFBuFo3gl86PjJQzU89hNAzylQmf5ylAzeADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=jiMJFnUgLNYR+cLOM1eglUa3hXRXBBJKNZNlbBurum2wR63LCCvV/uxMMVZAm8uGJ2bmq7aIymAYHcDkjpJZn1D7/NR4NmF76w0sQEIWaSRDRyl8etLDYg6dMaoAzKujN+SYOciNXEoGcuufZnaP5vSpJsUlaKJZPPrQfPqa0EnyH+OjdQ/TwixuozqpZ5WBshpAuMsJML++MmGrsCi3SM0aOgiBlYb757SXl/k197JHOoBZF3qYHcBYqGIXSNfGj3LNxklPRs3wamE7fCAPl7DEo5QhiAlB1354JuxYRlsLKRy0E02Lghf49ftrMcZf8X4n21BaK72R9thLnL+3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wphu4Q5Iae50th4Q/VjZF6H8HkQGUHhGQ950+qm5eQs=;
 b=HKm1SqQqjoHEi7NFFOkCBfz6B/3Tp7A+dULMC9SBDWABxMe+kWzYshs57c8OMEFS6wXS448Akynjz8oyT+Ks9VFmikqwPbCicacOZUMc25lPI96V05gZiFO7OBYQPgHlWs319gBnLOkSAaA0HS8fL9AmLNg9J1vHVutmPXvUsXIeMCLhtYXytZpo44fcD4aruVGyzv85ig+CpKnZZq+Ry7lO1aysCcZnulBoB5aSCbwHiIIJIR6U8iVAve871nbdJ1HMUoIVafy58je7GCKbRGlhT62KsuAUbfk66zmoV+g48H8xZRR3Ciux7xvdlmHUnYaOBgrCybMbU8EPzyrPTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:02:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Nicolas Pitre <nico@fluxnic.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 52/62] mmc: mvsdio: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:41 +0800
Message-Id: <20230727070051.17778-52-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: cea732c0-8bda-407b-6030-08db8e6f7141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHfwVFATQ4I10s2Ikz2jk3aJ8mka8ADyu/JtYrsxRs8So8utEtxysyquEMsJpjznJhNzkoRFTFm+ZTCrE4/ZHV5aPiUMPqUcn2EuGGPtVXtaMuOZJ/gzGUDqHrp7blKHmeTMxc7Jjzlkq6mkUTnSuF1C0qMO7Stn9jnKMAfQMzn9oeQQXLhn+aSicTJAQ7CDI5uT3zBpVqJRIpcUvtFHAm1wOXtxRulazj/3ttHa2aYtSZ3Bh7/Gl20yhJsstaENeXqDvuLIoJe67RRNamERBOiD/F+0B+VvbRI53mWaHB0fKNH4m+/RGeXX2nb+YboxeOz+EoUE9h/0T/ZG9xltoPC5w1xGtKCzAV2ZrYuarRlrLN7xuAeNRlY4xIfgD5Ph9ZGvYJU8+TYYGZcC7vPsI2JWteYipG51k3dhVEPJfuEhH3v6t6D6AnXPDxO+xAmtF58QKAEL3x4aLeXLHRuCLOljixL64BwAL8XWNimHQLQtK4CuWMzR+XELAyiq8T/idvj+N1KNnoe+90beHZgl4nY360NKHPshGYmGDBVUTDqT7gd383nhsDie1W9HPuQPvKve33br+SU0KbwMGFp8KW8jjzjgGS5kpe0O91lDXkMLwFPVFQgVH/tLTDrrHRta
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(1076003)(26005)(186003)(54906003)(478600001)(6666004)(110136005)(6486002)(6512007)(52116002)(36756003)(83380400001)(2616005)(66946007)(8676002)(2906002)(5660300002)(8936002)(38350700002)(66476007)(4326008)(86362001)(66556008)(316002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZXUVNBZkEySmx2bUI5a1hWdGV2akZENkI1aFFJZEhac3FuUFMrVzV5ZDFy?=
 =?utf-8?B?eDNwQlZmNTg1cWorU3BHOFBjWklTZ2hha2hGUENwbkNOdzVjRVVua3R5L2NB?=
 =?utf-8?B?OUZLWGJINWsyYTVkTFlWejVnNVlISkR3SFRZSWUrTUpsamNPVTRvWGdoVzVs?=
 =?utf-8?B?OEZYeUtNUEhEOE9LWXV2RU56MjRhUFFDREpVK20zcWtycDNNNTZXTjhYdy9q?=
 =?utf-8?B?Qk44L3lNUGpoRzFNT29NRDFWMk94TEo3OGdTRDRuK1ZEeG4zSkhYL2p2NTFk?=
 =?utf-8?B?SVpKdWkwRWtlWUc4ck1PbmxtZUhleTMzeGQwcjlMUXUwSEdWaGdsN200N21r?=
 =?utf-8?B?QkZUK3BLcGg3bkJ4TDhySER5T3Y1Q2VzWXdKeWVka0xoZHE4V2hEbmcrNzhC?=
 =?utf-8?B?MXBqeHRNTC9CQ3RKRzU4RzUwSm9saXZ1RGlYT2o0bS85U24zUGUwOWNqNHYv?=
 =?utf-8?B?R3NnZjRSRFE3VmVBcE9zM0s2UW1Lc0Y4bG9uUjIxT2pGeHNWdkIvZGF4cDU3?=
 =?utf-8?B?UU5qWU9raS94OWtkSDBuSEVBdmtHbEQrbmM2VWYrTnJHMmdnQURKY1JiWGtq?=
 =?utf-8?B?N1I2WUpFZ3FHL0R3dTNnVVpwZTdBMnl6Z0o4eFdwYWxrbGJCTmYvVXRFNHJt?=
 =?utf-8?B?ci90d0FPazdnMG1nV0xzOHN0YnZXSEtmeEFZdWtzNFZSeXZ0SEpzbldIR0VK?=
 =?utf-8?B?OVcvYzV0VVd2SnhmQXJqbzNGLzZPUDM3d1hnZzhpN3BaSHpWNWJHT1N2M0JL?=
 =?utf-8?B?Vy9EQ2hETUtKQWVJd0tGNGdyczZwbk9rNVBJdDc1QTRVWndMalJtTXBkbTFN?=
 =?utf-8?B?SnVpdGZDU05RSGxoY0VLZVNOK2s3V2FlQVBlT2M1cWRMWnVneEFnUWoydzZh?=
 =?utf-8?B?N3pMaEQ0NHpnMENER2ZqT2V6NHIwTmFtdFBaS1NSNGhJYkJ4VXpLRVhia3JN?=
 =?utf-8?B?ZHBZdU5YME11K01TY2d0WmR3OUxiVFdaNTh1bklRZVdlTGEwTjZ2cFRSa0N2?=
 =?utf-8?B?MVZ0d0w5TG1Ob0xEdFlYTlVoTmd6K3Y3NGJCeFE5YkpVYWxxK0FzTnBqVTJw?=
 =?utf-8?B?dlE0ZisxYkFWLyszTi9MbU5RTWw4RTY3ckRJbW9sZFcxcWpLMmw5aXVYOVZw?=
 =?utf-8?B?ZTd3amVlSnF5Wi9Gd2JacWVQeVZ3M0o2dHhNbFhZelVjako4RjZCdkgraFJU?=
 =?utf-8?B?dDRsc2lOVnlXVTZqZTlWNWVHWEdManc0aGNoMXY3Nng2b21KUVBjYTM1cll2?=
 =?utf-8?B?UmwyRnRJeS9oM0N3U1pqSmx2R2NodjFDYVFzYlZrV2pjRW83ZkJsUUVzWUxv?=
 =?utf-8?B?TXBXMEJRcGdJeUFkNGhGTmEzMTZnZDFISmk3TEJzSGt3bW1PTkN6Z29aWnJ3?=
 =?utf-8?B?ZzBtSnlTUjI0NUxiRHpLL2JrYTBURFZ0SVYySGJPUjBLTEJqQU5vQzR0Tmg4?=
 =?utf-8?B?dk5KUDZOM0NidlJQbVNZMEtNTXhZWDc5OEhYUkNaWnFteGRoSjlTWjVtd1po?=
 =?utf-8?B?U2s2NFN6eFRDVko2UnAzR3JWWDNyU1E5b3NMaUx6S29SeGY2S25KemxJODI0?=
 =?utf-8?B?eW02R3IzMTM0bS9Ud21TcC9NNGR1ZWQ3WjZaelMvcGZhRlVNWkJVRDQwRkR3?=
 =?utf-8?B?L3dHV2R0Y05mb2lnUDAvRVFoRy9pZU9CbnE4MEYwYWtaQ2VvTHAyZnp5TGJW?=
 =?utf-8?B?QzQrSUI5bnA0ZmpPZVc1TVlnS3pLSTVOUHVJUWdjVWJrLzNDNHlUQlFlcjg5?=
 =?utf-8?B?WTlLazVpbzZMUHZpeHJ6Uk8rMW1FVUhXc1hKU2xDWFBvUGpJUXR6V2d3eXNJ?=
 =?utf-8?B?NWx6RTUySllMcURUUitXWWtLNFZPKzdwa1lPeHN4R2JuRnM1aUU4RzNXdXVH?=
 =?utf-8?B?WFcrVjNZRWZPdUtnVFNBYVgyemFzcE03K1d6bExITHFUZUlxREhDOTFJVFRs?=
 =?utf-8?B?OU5HOURtTTVZTXh2TGdsZDZjc1d1bnROcWJsOVNMZ2Vpa1JUU2VMdnJLeDAz?=
 =?utf-8?B?ZEdBQVgrV0pHeWp1NkRiOGNGZjhQTEZYK3pURXE4K2ZBbHhaNXBZNGhPMFZJ?=
 =?utf-8?B?WnU3eTRvdjZVVTk2Nm9vd0YwTGZJNXZpTzM2RnVUaFpoNFdMYlpacTlqVXRO?=
 =?utf-8?Q?f+0bgE/BI9Ntvg+xFCJ7iuwz8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea732c0-8bda-407b-6030-08db8e6f7141
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:29.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLbe+Fz8wLrrxX66AiV+uyxHoziXyFi/HsAZUzinrgLH8wn6RigIM2rw/HgF8poHnM1a279ejbWWbrdhd++68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/mvsdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index b4f6a0a2fcb5..ca01b7d204ba 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -796,7 +796,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mvsd_remove(struct platform_device *pdev)
+static void mvsd_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -809,8 +809,6 @@ static int mvsd_remove(struct platform_device *pdev)
 	if (!IS_ERR(host->clk))
 		clk_disable_unprepare(host->clk);
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 static const struct of_device_id mvsdio_dt_ids[] = {
@@ -821,7 +819,7 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
 	.probe		= mvsd_probe,
-	.remove		= mvsd_remove,
+	.remove_new	= mvsd_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

