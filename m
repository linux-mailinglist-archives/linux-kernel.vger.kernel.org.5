Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BB751B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjGMIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjGMILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A52D54;
        Thu, 13 Jul 2023 01:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRxSQ2sXQJrNMTmDOK1cM0lEqR18W1eEwqc51AsJdvjo1puZfUhb+3c+ExFx6X1L9KTLrr0TRin4WYKxACl0V84wBdIpB0a+d0kbfyNjmrC3klpcQfi1OyTm/M/yCtLD0Nkl9Pg9wsC0VflKMkJh4ETrW/E83zk+/Dq0zO4104pxLMAx4bNspJ+rp/5++V44GBKLh8VnvpIGxKn9JQMPE5XjF8IuqaXtmVjetoJ+bvjmFjX5fxVuqjCy685b1Rjh6kUhcEHTPh35cYsMmALV/+LjW8bAVI20vXyzTMb2MOHAfVE7GmfLg6eZ0Xqm+R6hPvRyQyWOQsYT2ejpZFJemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=VaR9BbJsQpXKf/dE33l8INQ8gH7TtHVPdxMx0jhc/SzSLH90yRQJ0zDA71lNddCbJMVr9iNMUTtqMQX0dQBwcy/qOoPzDIeh4Fm8ysvWKU63U8WGYDH1DklCo2oQwPz/fKlknm/lc/zt3Sk8IP6vQdX/IlBUdLu8MU3HZu7BJIR2tBWli/g7/qjGJAMQYAoytDDrwOEscx4zj4rsPQywzljmw84Ps+X125sn0mM5gwXNxdN7HmH9N5n8fFXjjxmh7JdsMe4X5HyZb7WmqWb4QJ2em+UzP7VA+xIXhwf1Qs/oSXRpqpfRBRrTnY2gyjW4YEdHi7dDjq1ouoQA6KwJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VnGOYi45hwpGU2pMDgLIc+XDvJEY43fviyLsFSsxj0=;
 b=ef9NQ+oPfGfp88rK7ahUTpN7b4QYPP+GS9CWCj4D3CJ5d920WD80cXbluhuZMBhSeAZARf/TyqOHCBWbvkNayOMolfnFD/2HCKw+RTGaTyLQv1vkYIER2aVm83PNdgYuiCDvyULAUzPCLPssik75mbB42oaX9+6ybcySG1n/ilYIDP3eYMidF6z4vB+LcyYwokM6xqMX9HLaeLhIxrmLPBXBYyiwqbwx68CHN1NglkXE7ceE+OUP3/ql9LdwfqE06LdkHGLBQZ0fPF7GsLiEyDJkbQ3E4vTTOTuKjQv52LNV5Ro8CWgS7mtP07gIoGQYERVkg+EYNBagJm3ZJzRWCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/58] mmc: mxs-mmc: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:32 +0800
Message-Id: <20230713080807.69999-23-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1215bbb-89da-4384-59a8-08db83786a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQ58BziEzNZDDq4Y18OgrvqOB+yvci2h91au2gufegL20AnCAKcNodvHex8HhN75hiOr8URgT7fNI9F8dtFpBYpTLcf7fIbNuPfie+80qxeg2F2RJGs2P4aCimWtoM2mvqLZ5SX+xK1eFNVIxl4xjUsU8xGKdyRm+gOKfaIqfmH1JPjzsOA46LDdsNs3aWlyCz3BSJi5kTsPjnAvCV0/y/U+FADMOnmN+fvbltzb97avULtk7v2GwXDwmIDwRISa48cTKvfmVYe8tRT8k3mw2ovWfObcA8xKVPprCi6novO7HDzqDqZab2ecmjbA6jVzHdm8BAb1YVXs0HWFyREsMa6JVMEO8+NVdpU916Jw9he/lHVvh67O1/JWvzTeAy3G3nwmr67Px2Q9BiQTbYT+YsGdvW7emTin0ndK8glo5BcMGYPn0XU3+BWnZzra+Yr73eq51h2nHvcq51XXMiu9l+gPSsiOX9l3r/Y+BRlLJA+qidH258zmom7m0/RN8htL2SyM1dNaYocECTOEESi3ygA6HmwvdQ5r1ibkRZ9jhYC/5ul2+K2kVglG7GKvrzrktoYFtpE55nggabeikvKWvNAXD62yGigGlaH7/nEDIr11fHdsHh1LBVgRK2AUsU6G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(54906003)(83380400001)(66574015)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(7416002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azV4QlJQdENzR1hhbmVPdk51NXptdThwSHFHa2IrQS9OTTh1WUU1ZzZhWGpD?=
 =?utf-8?B?Q2l0SVZtUnRBRVZhODA4Qy9acll1TmlhSExOWnJZVzE4UG1oS2o5M1VsMkd6?=
 =?utf-8?B?VGpSTGRVanJaa3Irem9WK010aCtvcUJKYUFZTUhOQ28wYUMxVFMzUGQranpR?=
 =?utf-8?B?QVBvanQycGRNMFFGTGk4UHgzNmx6RzBmRm5yaWRDM1B0MU9ITm5nQVp0TTN6?=
 =?utf-8?B?YzJVdy9TSHhHTHdGWFNjN1NMTWNjUXY5OGxRTXBEYWVTQXZ4OS9NdkZ1Sm1N?=
 =?utf-8?B?WFVXek1QdS9xbTZDZWh2QkltOTVGOVFhQ3RzVU0rL3RDTjBmVGQ2OUZxMEpE?=
 =?utf-8?B?bUZhcTk5ME5rVkFPNUtZNjJQYVB5M3QzQVovQVZ2bzF3TjY2aGxoRzBTYkxT?=
 =?utf-8?B?WGFmbUZCVnZxUktubFNOWWFkeFVLOWJWRzh6R2lzSjNwNEJvUVFkSzd3SzdY?=
 =?utf-8?B?bW1PQXhteE5iWHRDQjk3b2R5bUszSkppVE5JejMxRUxWeUswUG1aZnRhcis2?=
 =?utf-8?B?YldzTmppL2JCNXRQS2hHS3pXOUk2cWxYclZqd1lIdlF5ZndjKytUcjlHN05k?=
 =?utf-8?B?YUw1UVFndlQxVzBxTjltdnJkN0JJVmZHS2RMVTR5N21LQk1EUUNDT04xZ1JE?=
 =?utf-8?B?ajBVdjhQTDgwWHV3Vmc3VWFEK0VYQ3paV0hRS2dJQlhLMEJROGE3RUMvRjJj?=
 =?utf-8?B?QnhLQkJDT3JBRDNCM2V4OTBxSEJEYmtBWTNpM2pzby9kZUsrbS8zU2l5RmpY?=
 =?utf-8?B?a21oTW1NOHdqMnhveG1yalc0bzhLTUx2ZnNFbHowWnJJckc1RWRWU0cwOFdq?=
 =?utf-8?B?bVRPRXVxNjFoT2FYdXR5czRMVFg1OEQ2QmNtWmx0QlRNbk0wT2hwa3BEcVl6?=
 =?utf-8?B?cjVYekUxbTlIRFdheWpaRnV4dmZ5VjJTblZEMUlkQXNmbEtwNHlDZXdBZzRa?=
 =?utf-8?B?U0NsSUVoYXhacTNkT2pFVmx1V09zQ1pBVHMyRmhFcFNuaXI3eFJKb3BSakM1?=
 =?utf-8?B?RlZRQUljdlIyLzduZGs3cTRwVEFRc0x6d3kwL0J6OHpzaEpucDU0NXJtYXow?=
 =?utf-8?B?ZUJSSFpBWGcwSTFmRTV5QWpiOTJJZWh6T3RwdEx2V29YMkNOQnZJR1R5WmNr?=
 =?utf-8?B?TUtmNE41ZGJRVVdiYWtVa1RuanQzM1djUFJ4cVd1VXdpTzM4em9RV3IrNm4v?=
 =?utf-8?B?c0NLRVFXOEk2N2NLUUtUTStKK05ZRThya2R0RCs2dDJQaHIyNkhmK3QwM0V0?=
 =?utf-8?B?MTh5NzRvcVZseURlYnA4eTVzY3JZL1cySmVXTnZxTTlqWVAyL1ZzamlIbGFa?=
 =?utf-8?B?cGFMSnNpZjVBeGhrRVlSSzNWVWNTeDNnbjZoVmRHSkEydjlSYlgvWkROMkNn?=
 =?utf-8?B?STVlUjFaWFFCU1hUaHJCcGNVaGVSSmRPeE93SEhvcmJ6ZjdXeXgzS1VhNVpl?=
 =?utf-8?B?VGhFRWRwRTl4VXB2anJCYTVhMCtoY2FpKy94SDVOTmJjOXpRWTJXRWU1M2NP?=
 =?utf-8?B?bnhuSXBnS0pKcG9lS1JJcTlhMEo4dElUSnF3THdhS2hTUThiVUZ1Y1puT2M4?=
 =?utf-8?B?cGorazBFWVUxcXhnOG1nUkc3ekxhVUwzYWl3NWdJZEx3UXV4YmhpbGIvYmwz?=
 =?utf-8?B?NkpEUUlzdTRTUXMrSEV6VkI4SUQrQWt3TENic05YQXlEc0hkSk93dUJTdU9w?=
 =?utf-8?B?dVFrU0NYOUR0L1pFdUgxc3FvQnYvUmsyekZWR1FGcHU5Qzd6WjlsWVI4ZnRG?=
 =?utf-8?B?ZlowWFVRTGJJRXVGN1JuR3NjL1N3TDYyb0pPUjRwZHRMNWdUWnBCVG5DbW15?=
 =?utf-8?B?Ni8vT1F0YnBtTm8zZ1VXdlZ4dEYvanhnZWxEaFlXWXo2TlpycEdOTWp3S3Ar?=
 =?utf-8?B?RnRKcmNYSXBpK3I4Q2g1czU0ODU1Z25UVFJXV1pQempvb0daUEtUNmlHREJR?=
 =?utf-8?B?YkVxS1lDS3k5bys2aDFpNWs3STViK293dnB2U0J6c2tEYmY0SUZKZ3F6RDlY?=
 =?utf-8?B?Znkxa2RDVmtoTC9zOFVYVlorUVMzVGV5UTFVVUFrMi9HM2N4Y0xXSzBLTmxI?=
 =?utf-8?B?bnU5cVVocGVOZkM1ZjliNW5xNFdQczArYW1BcVppNFpDa1NyZlpOQzFnYmk0?=
 =?utf-8?Q?gw1+kqTzlsiAofC/ynz8fu6Hz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1215bbb-89da-4384-59a8-08db83786a94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:01.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3NzEQxLTLgWWDGGFegUpNfMXGa2qGnPAC6qjy50q2B/Z1lPKpT1/jCzbSLIFzlWBvDf0nXvf2nujgIeSHkClA==
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
 drivers/mmc/host/mxs-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 8c3655d3be96..9abfb169464b 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -674,7 +674,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxs_mmc_remove(struct platform_device *pdev)
+static void mxs_mmc_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct mxs_mmc_host *host = mmc_priv(mmc);
@@ -688,8 +688,6 @@ static int mxs_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ssp->clk);
 
 	mmc_free_host(mmc);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -717,7 +715,7 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
 
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
-	.remove		= mxs_mmc_remove,
+	.remove_new	= mxs_mmc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

