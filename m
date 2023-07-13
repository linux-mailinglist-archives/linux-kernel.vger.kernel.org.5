Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBED1751B53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjGMIPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjGMINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:13:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AE30F8;
        Thu, 13 Jul 2023 01:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RncbgkD3jLy8Z5mDADFUDPT66yOMLh/ObfKVgfWCXhfSFdDhyr+v7csM3n2/I1IeH150MR2JTyske38oQUweEB5l4UwTCayYnVxV2ZLbrb2EeMx+YkBuD5DMUnX48KistLe+xC+9Oi0oUtsh5+ZD7gxZRi8zeNI4Isffxn8o5V7HWsJebEjLPMIh7J9Y0ZWiUqO5On5xwRaR5LYctgkiOU/3PDX4QeytMd4YqwAM90XhRAzwPqSkITmjOs0f+l80dNqID3Ma0kSn0Yevpu+GhI7hmlwR0LqUJVv7/pS0KuyIbLqQt2fYGx9LsQK38rKLDdmzDB70S/UO4/AR2i0qFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzc76DvqbeLdANjdlgr7IRp51JS5qEoM+mpDP8TQFvI=;
 b=bfb6ai7jvmUYgiXL5LrtGdYWriTEEBHYXycqQlQYml6TSpESV9iIYANzdfChhHbrD3jDtUr6vCXw50ei8pIOj9b5ORZ0xRLRPs8tw9MWbwwQoPxecsa4eLPYyin9LSPJSZuT9hBoJcsN7A1/3wuODuRCsgQlnknlML/1BEUA9CBv43mmTZJQkFEcFzmFWgFCtG25bNh8N+QmTRt3E6fLUDenOqi76pf85mTJRJebruEjh9Held39k+NmXdLYetD97IhunuVmSfX84PdofSSYbQuwphp27PgeNJ8J/05Y7IjV0pEYUPyvHH3aevNJhHGEk3XZQQ3778eI+97WHRNV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzc76DvqbeLdANjdlgr7IRp51JS5qEoM+mpDP8TQFvI=;
 b=lv7EkZQjFkhmeR0kOrUTpTz3E0U+EO90ZpKoSP4wOfhfbjKYSJj9scDlIizLKb7EFDlz3W7AH4al3/8JytbBtYLlyx56yyXC8fO466nr86SY7erJ6fuEeycSo0mWFoR8THtJsQkT5oPeu52znljShnd2hZLL7p4EKehP8wK2FTH53QWmVlgQWDttkHjlGdcXG4yLQey/AVmgZ+izVDmYA08gLf0YKVzk6obprrpDV9H60TqczBuQXwRKqXzUETTlC8Ln2jehAd3lwQV68KZPPG/5K90IdwqiNCZFEikTsSRw0Iet1Hgxhv/WRWhMLRuQ+P4u/qld2UBSPf14DRbO3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5984.apcprd06.prod.outlook.com (2603:1096:301:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:10:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:10:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 51/58] mmc: sdhci-spear: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:08:00 +0800
Message-Id: <20230713080807.69999-51-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe3bf47-bed3-4793-50fa-08db83788860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rdlw5NozevH2kuUcFqSbfdDzQfcgYAmJcuY2fo3C38dt3tXIYEFpS7G4Bi8KEXpNWUkePO+QHbEbk4AOODKTaJ8/5PfWPmIBoS43Pz9PZ/bx0E2LgTIEymOqIEku5O5OuVrmGt7GePQA7DweLcDFNYPoXACbxLTUBoCavg6uo79CeHV/dX93+MBWYBbiNfHkGnnfg97GncNObXMciJ5/6Cq2pBN9Q+EAFnS5HsVDVR/LCfYqltnel9oPeaanz3iCsCQi1nxr4YbmPMWkb93jfWJN8c5bM3ThegotTQlvpH5tQwdspr7mKGpPuQFp05F+ebRhN4GmTVtyPHptqr/oUIV165NHlDcjjeG4ittalYYbBFvOJ5RH0Zb6c431/NC9aUMdqaQUYpkgGSxMQxAGcFmGZsItsNSmIpst7+BicNyx9wYVJth3XqsHy5DORAxN447d1BlwnGqFzUY/zpG50KYXZ7NVe3Yq0SGzOdpGWT1Gst7akf62jCa7gxn+xnH9xc4XTLh66THi6tIxJ4fq1wwnYTbm3ysuN6Xx6ngEAeZozeTv/p3TYZx9pG1UzCw+YXnwJ9NahCtvgbuXsHn1BycIoobnfEJ4ffovLkTZBnWqCMJ8YBapHKcDSCOb266Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(110136005)(54906003)(52116002)(66476007)(66946007)(66556008)(6486002)(4326008)(316002)(41300700001)(2616005)(186003)(2906002)(8936002)(8676002)(38100700002)(6506007)(1076003)(36756003)(26005)(5660300002)(6512007)(86362001)(38350700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdPTUFjRVhFeXBjS1ZiM0R6b0tNbUlWa2FQVWpkTi95U0Y2UGVuN3lWcEtH?=
 =?utf-8?B?QWhoZmpFZitNRUNuQmdSRlI5aTRtNlZSMG03cVNEbHRQWCt4VU93WFkxTEpv?=
 =?utf-8?B?d05EcmtrV0lFQnVVelJEeERTMjRVTXM1WlZIZE9RZXI2K2tFaHVpK3RUdng0?=
 =?utf-8?B?NmpxQllBSWhvMTJ1emUvdks1K3NPaWpGRCtjc0Q0dkZpWkwyNmtmWHBKR2J6?=
 =?utf-8?B?K0RRZ3lseWk3S2JWK25VaEF3bGdBQTZ4OFpOTG5qSzlCWFZTUVZoMDMyTnZB?=
 =?utf-8?B?TE82MzhTS2w3K1k3bnhnc3lienEyYmhyRjlLL3U1R0laVHE0eEtEVlZKWUpT?=
 =?utf-8?B?aHQyVU1aVmUyZThBYTFXeUZhdnJpd3gwTWN6NTNTKzRtcXhONTI5VWVHKzdn?=
 =?utf-8?B?MFBkeitaaGd5cHFWTzJtdWZ1QVg5NldacWdUTWxBbG1LUS9KZ1N1U2o4RWQy?=
 =?utf-8?B?N0JVZ0R0R21LTHdjLzlXTWZhZkR2cUJjdXk2M3lCeTJzMlhSVE5qMkpmbUV0?=
 =?utf-8?B?ZzZLbjZzVGZRMGppa1paNVE0Szk5elJVVjNVMkUrUFpsT0IyWWxyU0dTUkda?=
 =?utf-8?B?dDBFc0txcFA2bnQ5NThjYW9OenNMSURPUC9uc1V5TWh1TTlEV0N6eExITlJM?=
 =?utf-8?B?Q3dRYWhIelpIU0pmbGZxdDcyck9RZU1Ed0xFbVpteitSUFI5c2NpakdKa2RW?=
 =?utf-8?B?aCt2akJNYjNITVlJSUJiYW1nMGZCL1VNTHo5bnpoams1SjNZOGErOGhGRWZk?=
 =?utf-8?B?am5KRnc3Mm1mdXFBenlEZjg5M2hvM00wMVVNV1hEWDJEaTFWWFhCNUxBMDAw?=
 =?utf-8?B?aGw2TmFYdHM3OENYdzc5U0xQRllaU0dCWENDWUM0RFoxMmdPNVNhK2ozbjZO?=
 =?utf-8?B?Nlg1a1FQMDF4OVo1d0cvN1RodnZ3dE1YN3NIekJDRXVCQWZjMVVza2ZhV3VH?=
 =?utf-8?B?dGl0MVltTFJNRzlwaFFuMFdXZUtUMU90WlN4SmR0QUx2Z0E2MWpZWnozelMy?=
 =?utf-8?B?bUtYTEw0dWl3eDRiQzN3eW9VTGdGRm4yN3hoV29JZ3JTbUg3eWlKYjNaQ1Fh?=
 =?utf-8?B?VG8xbm1FRFpTVXFkSFhPbnBWWEFRNEQvb05RLzdZN1JLN0l2dTBhaFdpRlRZ?=
 =?utf-8?B?bTE3NXpuZHU0ekNHYVZsbGs3VERwR3kybEJ0RHlYcU9oWjIrc1BXM0p4Vlhl?=
 =?utf-8?B?b055Q0VqSUhPdHpxSE8vQ0pGYjE2MnFzalY3NzJOMUd1L0VZV0FWZXI5dy9q?=
 =?utf-8?B?Y1VQWGdJWUNIT3lZc1RnK29ISVVPei8vYW01SG42U0JvbFkzWXQ3blhWQytG?=
 =?utf-8?B?VVhkbHpJK1FsOEZlTHNpWVhJbDlkVVRJQkl2azlMVVpxdHg3YnZKL0lPZGF5?=
 =?utf-8?B?NTBMM2U0WDZiaFJPQ1hQelQ3dmoxd2I4cmZpU01hQkUrWTJWeXFmbHlBbU9q?=
 =?utf-8?B?UXl3WXpsdktvdXRFcXFSdEtSR3ZrSGFQdU1odVovMkRITWxmZEFJUTBVc01t?=
 =?utf-8?B?eW8wWEZhakhNSVlzWjJsUTdLbFNzRy96TjZEVkRSaUttOVdMUU9zejQvUnRj?=
 =?utf-8?B?d295U0JPYlRDMWdteTJSZUtqdUhPeHhrTDh2NlduQk9HTnozTzFmZmdWemox?=
 =?utf-8?B?Rk5zNkZMZmlMc3orTVBrSllLS2ozbk43TloxS3BSTzh3d1Zna3pYbzhZeFNo?=
 =?utf-8?B?SjdIQ2w2dk8rSERBMUdjYlBraVRCZ3dJUWlRbkNRY1ZCSnFOckpwSmpsbi9k?=
 =?utf-8?B?bkNJa0VMdERVbFNFYXhUR2VOWHBTMVhWZVpMUVFGT3hDZ3R0SThlLzM4REk2?=
 =?utf-8?B?WDRtWWFvTkg2SEd0dVBEYmZvb2tLQU5oZTlvRWRiSDFTTE9STXVMZXlsTHJ3?=
 =?utf-8?B?YnVOcHhYRlBqRUhGblBEYkg3T0wvcW1nbmNTQzcvcnJ3UVNXZlVtQ1dUZXVt?=
 =?utf-8?B?d3RVYUlCdFZDVVFEU0IvUnJxNFdUcnplODJLczlES3loMFNONlF1V1I5RkpO?=
 =?utf-8?B?UThPUTdsRXJwRTJTL0MzN1NuSzJOK3hNcFBWbkpwaUo0ZmpmeXRhOHFDeHVK?=
 =?utf-8?B?cVZKOWtUNEdHV202Sk5PNFpXTmVJRngrY0lCVXRKd1hscVFBSlY2L0tEYnAw?=
 =?utf-8?Q?nszIpay4dVveltDC02OWlDyFL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3bf47-bed3-4793-50fa-08db83788860
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:51.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ogRaHnDfHoIW1pUY7RoplPDUS14SuzOQdwPiQEbyYzg62tL25xFR4DfGk2n/Es+inmxts8ll9jb8Bmo0nA5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5984
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
 drivers/mmc/host/sdhci-spear.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c79035727b20..ec6c7d8e3736 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -117,7 +117,7 @@ static int sdhci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_remove(struct platform_device *pdev)
+static void sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct spear_sdhci *sdhci = sdhci_priv(host);
@@ -131,8 +131,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(sdhci->clk);
 	sdhci_free_host(host);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -186,7 +184,7 @@ static struct platform_driver sdhci_driver = {
 		.of_match_table = of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		= sdhci_probe,
-	.remove		= sdhci_remove,
+	.remove_new	= sdhci_remove,
 };
 
 module_platform_driver(sdhci_driver);
-- 
2.39.0

