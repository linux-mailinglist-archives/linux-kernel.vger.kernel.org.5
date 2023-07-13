Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F68751B03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjGMILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGMILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECC3A9F;
        Thu, 13 Jul 2023 01:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtbjwi3bMJ4PT157X+c31FpdqBN4rR2m/DZ3uPjim/3Dw9LH3zOn9/Qsreaw8QTmtZOs1/CNtSLcSp9HWmcJIQRiF6cooU4aKfmw9KXgYjB5FWJaiEh1NY+lKjgZG3qtR9oipfqjlVMOxV8XVoVuqpk5U7523EkpZRs+pWijh6JpqtFhNSlwiY4jjMZCsBD+gTbBzd7wDE4mwEncP1F5VI12kDBMOlhMdlXj3E6o5VZXwpdlSd0VgOOCGJDPcp3zcRhpXJNJ60davHID1bqAG+Kfh4l4XQQKFu6Y6mTVk2u8cCUVhy5ECPaMnTJ63gDLt85ZYrjO5vhvGSxSCwLSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=TOssskRK/ma4nVIGmiYZG/oj7cyb10LBspc79lqClUS8cg4j2aO8T2fP2vM5Ns10j6cACCQ/mhtAFg6FoxpNbrznkR7HaRdU2fxErMtX/NRqWqGYd0AMvaTtyqo8Ib3wrGMYQNcrSL/wnlPQQuOY6e0j/X1DZarJrvOFtUkyFHYWZQpC6jRtIdABfWMsV3EjGQR2lAPjMAa2PWQEN0el3roTq0EGqWm1ZrmjI+CeRtsu7FiVEsRFPp/BDHCxoBJ0u8NeWNUIKDq01Y3u2/qKQZE9awbOppqrtIVbwiYTtVH8Rz+oEeH9IaOXYUlrcDKQv7DrhuQCvuNaLH/sFDAhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFCZMSRT/SLHSwmQ+mf73xOp7pZuv/jxv4saUj/q9f4=;
 b=anh1d1P40Ys2f2eK+reDjVm8aviLTejyDj/1BGkUz8jU51qTdSCEnuqgNCgSn9IZx5uqJm8MYlBpnYvaqaj3gq0/SaV8zS+1RgPYIBPO8C9KQ4vZemZ0FPANehYr9x07ZrlRzKyIqhRYvydZ0fi1iy16Moi93R7p2SkuZxtFobrU97n7BfXuIkUrHSSX3o8SDiIp1w06naZzSomFB5Vdh0v50bJYjNtPh+gWl56xAK95z7ZTXkkWTAO1rqXo5uaIQf/ka2Mf0UjO6cpquQhoijKY0/ltA+6MMNO9p2XJK8yRP7Ms5T+j2Isy1v34VmVB9S3HED/Pd3R2ATpuI2XA5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:08:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:08:57 +0000
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
Subject: [PATCH 21/58] mmc: meson-mx-sdhc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:30 +0800
Message-Id: <20230713080807.69999-21-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26ac4f88-73a2-4056-8e1f-08db83786866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYXkFKu6vfoxGuLAAbTHGhRVYtaUH2pyuqXtBWPLqy1bTD3jB4saY1QLmPa4r/e+H8BZxNtvOULaMT7+zlF3cof5cGwf2LwDRI2c1RFyeuSEfB9KQ+1QIwYo3BrmiazasE0cB6WiEtV02Jzjrb/XgKviyyHYMIvz/oN9qNODhBZa+B4kzyVzN+iNIIpolY+7tOaAwnV/+Ux+dmYB27cMcph/nshKbe3MrLktDqLBxPfMFmfPDhtLvAMymSJq49AOOJc+aYdBvU/Yvit+O0+tf1ryvtyTdjZ6WC6VVlp/zs1Nf31miBrMbMQ5ikwY2ZYuMaWwdTUhd++vvdym38sGmiQTfi5oS2qZVV1RIGVlgKV3SvEu5pY/vWZ6zeYiGzz6LOl/d/0F7xAk0+XB01pFClTB+grBEwbBPxnhfWB+0emEvVxxww9hTg/pyS0u7awj0s+0cOeRNnL7jGA4+187ze0RLP4qspg78MC1Vyq9eIvVqIrjvR1ZfuZWzRRhZy6vRZJjndAPM0n5pBdZWjagbVi7XSlThz897GkGtYToMu/vw4p4naFXeb4DjDmwdPAEXQbIpLrm9f2X5sOcAJU3uVkpAreZhXVZCp+NYs6gBhPIMpYDFdA0x6dAanpt2u2f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(7416002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE9QYTZ2VWxPTk5sRTk0NUx0ZERjTVJFODRYNzRyTDdKMnlqb2FZeHRLdHV3?=
 =?utf-8?B?d1NETUxVZmdkL1gvR2JKUll5QktMR05BZ2txSWtaZTloUVJYK0YwTkhUd0xj?=
 =?utf-8?B?THlrU3ZGdmJOeGNYcFphczN0UWVCUmxxSmtjZnRqV0I5bk5XV3Y3M2VpUHRk?=
 =?utf-8?B?WnpHNWVycFdIWUxWak5BZjRRc3Y2NzNiOTBGdkRHZVhGSkk1Q0Q3dGd3S2dW?=
 =?utf-8?B?WS8yQldSS1BDQVBuTjhFaS9zZ0JTNXhWK3JtZGZGdkNSajBHdmFaQnJndk45?=
 =?utf-8?B?VE9zdFJXd3Z1eHhRUDlSNHJGV1JVcXZpNmZpblVJV091Mkthd3oyaTFXSytW?=
 =?utf-8?B?a0oxUmxXMHV6bnJiMHNqejdSelExQ08ySWdvQkoySnUwang5QUp4OFYxd2VI?=
 =?utf-8?B?cVZkWllnR2Qveng0eFFTYVRsRFBhWXVPUjNiTGxuNFBsT0M3WnZpZndpUDIr?=
 =?utf-8?B?MEJROVlsR1JmTkpPOHNKVnNTdWk5SGFiazlIY3RsMGp3WjExaXJsQjh5bGNr?=
 =?utf-8?B?VTdYMXc4L1NoeDdIK2dNQkVZbVdXQ1dxWHpZNGlzdmZhU3NKbmhFZ25rQkxy?=
 =?utf-8?B?QXRtaElXbzFTNW05ZWVQbksrOHB5RTR3Z2ZINTVIVWxqS1RTQ2RNemtEQ1dN?=
 =?utf-8?B?d2dpQXZ6SW5GQmhSNzY5UE9GRENwL3lDWHI2bFhvRlJvRHJienp0NEhseXdD?=
 =?utf-8?B?ekJ0bVg4SkhpOVhJd1lHM0dhdTlveG9Tb2pORTBVMzQ1cnBLRklLUDFuOWhD?=
 =?utf-8?B?UHhCVmtGeUYzZkc4RU93T2EydG96dDRCU2JjdHlwa0ZRcEtiYmNxLy9XUThH?=
 =?utf-8?B?UkQyMDNMVG44UFFyUndGWDZ4V3NsRjR0Qlk0cHZ4YlBlLy92T0lwOHBtZ3J4?=
 =?utf-8?B?QlhPZFExMTQrSVNXZnlDYzM0Q2duN0NaTkhMODhoV3lkOVpGZTVJbkZkUmZo?=
 =?utf-8?B?MGZVV1FrZUdPaFpmQ21HWXZxSDFGVGozL0xiTkJsOGZ4L1RIUndoMm5kblNO?=
 =?utf-8?B?T2NIaklpWVFpbWdCS1hReUcvTmR2aGJnSnVrb1lKR0t6TWd1cGRKZ29NUGZy?=
 =?utf-8?B?UjBzS21Mb3FSN3RwaEdBRTJWb1VPMm1JK25rUjdPSEc0MVJqb0Y3WHBONHNv?=
 =?utf-8?B?MFdCS2t5Lzd0dEVWNnFCNCtjYmo1YXVlSmc4NDU5N1IyT095L1VmM2tpWTR5?=
 =?utf-8?B?ejVSRllIWm9Sc3FPQXFZRS9pTjVkQnBiNXV4WVV2VThObmdxR0NCYjV3aXBI?=
 =?utf-8?B?ZnZZbGxXdjVkVXVpVUxTL015ZERhT0tEMTFFdlpRNVB4QVF0dHFYVzEvMFNl?=
 =?utf-8?B?Z2xobzZhUU16QnFjNTh5WE5oV0NzSWJUYmxRQjJYUlVja09Mb3N5UGcyYndI?=
 =?utf-8?B?a3I5Z0JaRFB3RCtYL1ptV2lhZVhKdTgyRTV2Q1d6RVFSc3hHQUVxQzNEZUVC?=
 =?utf-8?B?UXdDWFUwMzVPS0JxbFRYNHhZYjA0aHNUdTVWdU4yMDRNUXIxeFVEZ1NCcjI0?=
 =?utf-8?B?dE1icDYvVUdtcUo1MmtmT3BCMkZybTg3cFdualJMbEplVU03VzVPN0lQYlNa?=
 =?utf-8?B?eUsxeXlmQkdhL1dINGk5UkIranY1Nzg2Y09kZ0hrQ0FnQllibCthcmFjcFlx?=
 =?utf-8?B?Nk1TZ1dvNzhJVmpzOVRlRHBZRERNK2lBTm4yT2tjT0QyT2NSZDZiV1M4enFx?=
 =?utf-8?B?WmIxOXpjUHJmY2pld3FvSlNJVVgwd3hGSDVEVWt0TzJBS0NaTEJVMk9EenRO?=
 =?utf-8?B?dWJFelI1WFluUG5pb0twR3J4MVkvRUJwbjcvc2RybXpMRHlkSldvVlhzVmd3?=
 =?utf-8?B?UUNVWERyTEszNitFVHpnRUpLMU14bFdGdGpOZ3ZqWHIrbGMzVGVEUG8yZjhP?=
 =?utf-8?B?UWFQby9rUnBXRWViaHlxQUdqVGIxNVJzdmZBU09IT3F3M29QUDEyTDR6WTVu?=
 =?utf-8?B?V0w4ZWNBUkQ2ZnNSYmMyZm1LZTR1MStoaHNIem1vN0hGTlg1aENFV0IyUjBR?=
 =?utf-8?B?VFZqVVpoWVdhWk40S3VjeUgvN0E4d2tzbWZSckxRTHcrbUJQRDhIejlZWktL?=
 =?utf-8?B?OVpjR3JhWHFPc0ErdWxHb01yMUpRVmNPMHE2bU5hWWt0VTVHeU5GcTk3R05H?=
 =?utf-8?Q?ncEPKcqsxctS9MFgy27bvatRj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ac4f88-73a2-4056-8e1f-08db83786866
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:08:57.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oADOEEbwers0GpVImxfn3JrdK9DSumw8CGWp153sXMLqZfzsJIw3Xmm24bRd01Nev1vZr8kLhDQWB4h+6IwEaQ==
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

