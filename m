Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7917751B14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjGMIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGMILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E904170E;
        Thu, 13 Jul 2023 01:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmVAHDwaiqwKlLVHOB8WnFhTEFE2Arg2EctR3VoF+V1/3DAhilGsFBcs0CHD4l627EW13T0YcAgV6zmk/crVBcE23gUISQZBSYsuThwpVGnZkmM7AfIxLMSwsGkzsZDFBZzJGgO71J97ZY1wEr74QR/2hYK3h3u14pGQ5grEdA83b+WP6dDjxUHPiJ+Yr30O1tASBXaxkgrAJxTTRDJXqgUBc1zUxq8ueL7wK+9Wm5JjSzpT4G6V0aE3UP/S+Rs5s3RicwwEt1yFpMpk3p4U7te1Heh7ul8gH0LEtkQImLENQGY9Q6D2NC5rIYwFHlr8uiXqlkxcFcvScWKlOuKccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Zc+RUhord8kJyLZmU9Nv573/MVj8Cm1en61bIyoSc=;
 b=MEHRscQUwbp8tDOqNuKItLuudzaj0WChR73gO/RAvQ5Ct+8Gtg60AXEp3I+BC4UjgDS+IgeNif/b79hjFbr4fa3H5RYXpcKGItKdy9K8YIhD4PP9yqUo4HiMauvnyoV02/xO1vz4sUmfmd8Xx85RhHWv0aMIIK0Ono/yd1AtcdzCFg3ermoQZbcEQ1kUeVKWlUh6MX4kuyEASmf4+Q7L+9laIkim4z74MVN4N1s+RzohIZ2wgPYBvAeKRXSRdvU+XCC7onpZUAjPlbuuno5vTwgND6gCilTmcx1Ze1ikreP/hsp0U14U/LOsNXQk+nVUE/w5NqbwPdefxk2eBgTXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Zc+RUhord8kJyLZmU9Nv573/MVj8Cm1en61bIyoSc=;
 b=LdpQQ5Hlw+noFEkUjCy1fK7psim1UmKSvjWTgOxuWOIkXVPsizcGRu3uc10nvq2KuDRTeShNoBWRpYzbv+Q84YgbwyJg5dpbHDFpMPIHkV8Ifuwl6Q6TOH39HhuiuREUBHzCAfqEKEnUw5Lra97OX0oIcGhkxB9+kHiwwDsiwPgTfxhEVpLk7lpw2tIo7MEgXcZLa8u31B8b7EDMld8IZqJVtDbRG1utDLpPzZP02Y2CnKFgFAeY8ax2n6tImSrYi2B0OiwvEeboh8YJnu26b9p0Bt/VmeOXTipQ0aMr+DWeXUYSI+Kqp+mPHRIdPBIZlfLlQvycBjYJunOSIAJWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michal Simek <michal.simek@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/58] mmc: sdhci-of-arasan: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:36 +0800
Message-Id: <20230713080807.69999-27-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 085f05a1-0f6b-4d16-49c7-08db83786e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGasdMuxBnr0K/5SJIaNMGed4URYK7fX/ui1Jd5L7EgJuC+sxvNM4hVspJB2cO8XArQ2OElLBHXwIitRlWFUsvalPahZktS8PO0j8OKmm8n/KoRmgT+as0I8ZYqLYHT83/3+LFuYIHc0fjgnEjOXkW1NjsQX8hX+He/4sVmp+vwx/I/7fBrKDJf7ePe3O6As11Ywdxz7428D1bIx9m4E1EHuAX+Zp9H/e9kd61dvQuIcj7lUwzjooZw0JVHKJCifqBt0GVaYp1KxXf5Ukn21nMmNTZ/p6RU+R6W7HOl5m7kZLVXtW6ilF+x5MYVgJPsIoO/woKESsEXgo9IYlUzKqEZ2P41A3QgijpBOUx1Ki13rqvY7k7GeC9Z2uNXIGe7SvtY+Ps1RDwcRQ4MOOlPp33TYZEI08aLvmKuZjoshMAcYw/yCZLExz/qm0f6zgIEya/A542Is+nWVGg1PQuYrJnHThzCXDRaQq9oZ7ZsnwGCGy9557Re7ndr0jdsnUgjGRNCSwKysO3TZ1CSTbjXLjM12WqNn24CE0y8fS9Rm1YHezewYOpOA05LfehtpMO2e2nHo7EQkQNEXlG8THQpFikBUpgqDBz4rRHMNfIV+Y2Ia2Zb+bnCX+yAm1tWpgYwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxpSHpTSGNRUFUyelFHcG90bkFLK1BpTTRtZlkwZElWVkZvbEhsbHdLQ1Zi?=
 =?utf-8?B?RHg1d2NTc0w1MW0xVVIrOWZTcHNyM2NzSTFlZllHS2JtNUIzQzFvYmRpbTBN?=
 =?utf-8?B?NmkreXRJS3RKd2JBL1BPem9BTXBsRXBZYmFxNFBrdFhwc21KVnlIZGZFWUwy?=
 =?utf-8?B?Mno4T29PT2VmYWFud3AwQ2E1MzBqYXhhYmFKT2NDd0hmQyttSHkyZU1PVzhT?=
 =?utf-8?B?MHJCazhCUjhZaW9EMTYyamM2dWFXcTlGcEswOTJLMmlsSzJqOXNFTmwxT0Fl?=
 =?utf-8?B?N2lGK0dhaTR6QUVpMXhPTjY4ZUZGN1diNDVUV2pldEhxajhteEQwSG1jQ0Y0?=
 =?utf-8?B?dmMrWWU0SU8wZ2NpQ1dNc3dPMEg4MXpCbVdTNHpRa05jbFNYUS96V1MxU2RY?=
 =?utf-8?B?MHVZRVFZREtQb1Z3bTNDK1FSVFUrNzdzc2w3MUh6NzJNT1EzdXZITDFhcXhw?=
 =?utf-8?B?MDRDdGlWd05jTjNYN1pTbitDZW1Uc1QyM0MxMnVOYkU1OERtNDRSWEZlWVNP?=
 =?utf-8?B?dDVkbm5sR2g0NkU1UVhpVmp0VVJuUldRcEJVSFZmcWF3a3NyUWVrVms5a1Jx?=
 =?utf-8?B?NGNaVWpFbnNPTlJVeWc5djNhaU1Qd0NKa3JpNURVVGExNWxZMUdIYm52TVl5?=
 =?utf-8?B?aUQrc1dRS292Z1dvZ3dPVmkwb3ZtdDRPdlR5Kys0SkxuRU5lcWE0RTVMYnBM?=
 =?utf-8?B?UWpzMXlLU1FGMHZUellRUDBGcXBGVDQ4aVpKdXR5ZjNQNExsWjZOZm5OT3dB?=
 =?utf-8?B?QmczdlVJQlI3QmFOMjNlV2JSNTNxSXkrTTM1WmNZcm5rZzFoaTA1OGtxYlU4?=
 =?utf-8?B?UlVOaktoUW9DalJnRzFqMlpQTVlzbEtxOUkrUlA3VEduVFVCbStMZ0pQQmdF?=
 =?utf-8?B?SEQ5Ri96NmRJeWh5V2VGZVY5b3lKWTVTK25rc0kwck1zS215NUI4eFNEcXpL?=
 =?utf-8?B?elpndENIdjNSSkRndHkzSlFGL0FuTm1VSTZmV0FDNWZQTUpqRjlWc1ZmNSs3?=
 =?utf-8?B?SWFZaE5JemZOZDdleWFTRGx1K0MvYnNsRFZ3TFpsTEFZWSs1aEM3c2N1S3FX?=
 =?utf-8?B?R3V0WHlSMFJ6aS9qcXVJRXhZQ1V5LzkrY1h1Z01SSjFBVWNlRHpHT2l0Wko5?=
 =?utf-8?B?bHo0N01XSGNwV2FrdkllY2NncVZ1L0lIb0tUaFpGT0dXb2VWRStRQkFtQm41?=
 =?utf-8?B?UHp2TGlQL0YyY3VOM3BzQ2psM1BneTNHalUvTXgwZVlEanV4Q2dhT0pCVU1Y?=
 =?utf-8?B?VzZPWVlZd3VmdFlYdmVYN0tvUVRCUXZnZUNLSTZZbnAyMVRJdHlUMkNRYmpU?=
 =?utf-8?B?S1UzN3FsOGNhUzJtN2UzN0p6djZOaFkveDVpcFFmTTBaaWpLOHl1WWVKMjlY?=
 =?utf-8?B?TUZyWUUyak5SUXo5QzU5OUgxSVZzRFovZk05MlRoSWRJMi9aQ3huVys5Rndm?=
 =?utf-8?B?Q2xwczZhb0hWK0gxdVdhdXB3V2d5K3hUckJ1R2ZwNWs0NDVJK0N2VkhWVk85?=
 =?utf-8?B?d3hIVXNGWUdyL3lQWUdpclF1K1lYeGoyOXZHcSt4OU91QlBZYWhFQXR6b3ow?=
 =?utf-8?B?a3E4UENraG40alowUUpub0JMajhBWDdCemN4b1c3Nm5nSTZaaCsyV1RLMW41?=
 =?utf-8?B?WDYzTkgycS9tQjd4bmhhRlhhKzlGMUJvNkNHUkMzUExOS2ZrRkNwaXpSQ2RV?=
 =?utf-8?B?bmtOekRqQVJESFg1MlZZUlhUNmhIdnB1V1pMN29RL3oydW0xN0ZXS1NpdE1i?=
 =?utf-8?B?TUFaQnpoOENuejZzcHQrREIrQUIzdzNrcC9Vek12R1hROEh4RDUwMzFYVk1H?=
 =?utf-8?B?QXhMNVNkV3k4dThaSDZ0MGFuNjFoOGtRUGQyMmt4U2FxQk1oaFp1OEtCc0V3?=
 =?utf-8?B?c3BnUEptZTkxRC9iTG5Jc3k5QW9ObVNCSTB0QVZxMmhvRkdFbGhmZzc0SXZ5?=
 =?utf-8?B?SUM3QkJXaTFhV2VUalc5SW9Va1AxTUx0ZlBCd2J6UENMeldaOTh3Qll6ZmpW?=
 =?utf-8?B?VTVPR1piNWo4S3RhQXN2cWtZaWwza01mbXh2NkhlVjhKc3RjOFNYakRnSWJ6?=
 =?utf-8?B?ODdvb29xZU56YXNBRHVnVGJ5M2V1eTdNN0xZTGpsTnpreTE1VTB1dDRDVDN6?=
 =?utf-8?Q?Nfw77IuoyWo8GRKoGtkp3uw4p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f05a1-0f6b-4d16-49c7-08db83786e82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:07.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i8IfN0JknV9vfGcsoyhlFA5ytw4LMMy+QTibe/ceYM5rrX11touec1qEJqRDxPrHqncARjsM5VAzba+3uoo5Q==
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
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 294dd605fd2b..160bab0c437c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2016,7 +2016,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_arasan_remove(struct platform_device *pdev)
+static void sdhci_arasan_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2034,8 +2034,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
-
-	return 0;
 }
 
 static struct platform_driver sdhci_arasan_driver = {
@@ -2046,7 +2044,7 @@ static struct platform_driver sdhci_arasan_driver = {
 		.pm = &sdhci_arasan_dev_pm_ops,
 	},
 	.probe = sdhci_arasan_probe,
-	.remove = sdhci_arasan_remove,
+	.remove_new = sdhci_arasan_remove,
 };
 
 module_platform_driver(sdhci_arasan_driver);
-- 
2.39.0

