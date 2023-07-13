Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE37751B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjGMIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjGMILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:11:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD322D77;
        Thu, 13 Jul 2023 01:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRGMwM0JKd+H5GT+yki5nztO+hhO0VG/75ghU50IMStwQK5s4bd3MFQuJuf/URwTBZ04U+S/KR8hDnJM5EbCnVo7ju+EN+pSyBCGwc14SU4hqI74iKtrnhfL7KB4pcsKdraxDTytOMnZXQ/eyQlcHS+1jW0gp4Y3b1rURr/By49aFf2eNoiIydnIrwZLZ/gkSgFqrBOg3lFIlLwh6qsSm4LBJc8MYUvTlP6J222FPCg4GXmTQZGDEfQts36Lc0Bwp7k9+wuto4sBGKMM2LUk8uO4EkmA7R0ckJz56F96rsv8REKQn14qPrOTsMxR8W5MhsycB0yzo53V9VSGzqsyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPvk0BJvyiqypQQEM9Xxs52SCa2gV2Is6nfaORO6Mdg=;
 b=gPMMnw+GKOExmdo0smoZA2SGtONWKOzBRrvo4r3xkEtqJQ7KLHPLu3nwE8fXRJ7WARtnC2wZix9Ds+q7yu0qXnZuHe/NU0VruLhLh0HmDPNPeQoGCEujH09lBxQUNPQ0blTrdQkTEsFDPgQZwev/IbkEaHzA/aEyYZnt6Jmr4QjxQl2GIsWIkR2UyF6P3jxlFSgLAYJH7b673gG5F+w3mbtABmWkv9nIhuddmuRz+RZBfQcgFMCa5dNuffI93vpCcASvjnWDo5OVxCU2egNZ0kMxBQ9e9xRlaQVouwnZTzNH3uGvq4xLS2QBrzUgdUvSyvwauCaej66OQZCko5jD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPvk0BJvyiqypQQEM9Xxs52SCa2gV2Is6nfaORO6Mdg=;
 b=g4rgt97HIo5oSIjhuUJ1sEbaUzgdgI7EBSPTrjlmOFrMwaAhjK39oz4KGcJbsVmzddBIfmug27msDutCxvFcVGnWWKfSh/z3kFn5n4kRUDGGQQKBZb0B/b80eN78LRR/kIfJ4swG8X74mlW83+AeHoj+/KxV+9IfNseQf2JEuzEPvLO+OGDoiR2bC51H0zrihsMSPwnAOOvltwzjaLKLLYaI+FWsujqSXniPvd6pVCIb/gNXKMv/BN7QFwx6apAhQmQvpOvKxbX+8Y+sMxOBZJ6TDAogu0KbVVbHW5Qp47nTYOdjJjvQGnscxu9onAwCwdi54Q8Vtl5Yuy5bZY92MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4409.apcprd06.prod.outlook.com (2603:1096:4:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:09:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:09:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/58] mmc: pxamci: Convert to platform remove callback returning void
Date:   Thu, 13 Jul 2023 16:07:40 +0800
Message-Id: <20230713080807.69999-31-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a5bc45b-c5a0-4143-7862-08db8378724c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hk9erT/2dc6ezq8GqU85AE7qNsDVeqgQAlTavcg9QBfVb3JDmN6L3fGrdCl86ZaXT8TZETTW3S3mpHaA89OYm+eFWtZ1Ck5s/Y0Hp+2gVqqqBNVVKswzKQMgIaG3HbEMXd+fSDsWXE4TmjFwOrMEoAuAt5FRwM1xUGNwmwOYj4PBStv2b0RySEPiLSHB0Im6+ut92oUhtjtcM1mYWjr6V0LrvsNJmcuVHmRKTOW5XDI6wZxjJttlh7T3HUzG/JcouFrOhR3Gwi/S+09UUMzVTEVRuvMqgGr0ia3fTr7SNRqQ7eiB2nzpt1S0FtshWzpOp3+VQC2Per5fY68ETvAejQtUvPX74+MIMVTAtorfQjVsBwvetX5ipvO2AgCrTFf0jI8aDySOWRHgGtINt8MMj+d+UlBUeiFQ17DYOH5C6rGecnsLxVyLzxQixNadzdgoXI7/k/GjI+SrCzAjHn5jX0tYGBLBDQjUDgyZpHElrg59WWPyqJmXhnFH3pyL9KIkbhjVzIxNXYg6MBhxgZnKbokfgCkyiQzw0RPcaUt4P6WWsnL76MXDrmq8l8LR7CAq9abqPkhewuEEzc9O4yb84VDrqbBH87WLprqsUPOL460PazvS6LkrbCl4Z3PD3mCs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(54906003)(83380400001)(2616005)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(6512007)(38350700002)(38100700002)(6916009)(4326008)(66946007)(66476007)(41300700001)(316002)(8676002)(5660300002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpNcjVvWmdwNU9sdytWWGtERzhBUGZ4Nkt3RDByK3ozUnFsSjlnYm43U1Ur?=
 =?utf-8?B?bnFZMUpHVlhrdDJsblRwL1FwaGEwKzJUVklGdEY2KzN6VzlZMDhjb1BTcXFU?=
 =?utf-8?B?T0oydXliZ3NHS3dYc1NDOTJLa3kzUHUxMm85M2dpM2NIeWV0N0FBUDdHV212?=
 =?utf-8?B?WmpIdlNVQ3JRTTdhYVltNFIxVnd1ZHBzTkc2NmZnT2NQVzBQeURCU0N3TUx6?=
 =?utf-8?B?TGI1U1J5Vnk2azcyL292NVlGQ2JPL1FuekM4TmloTWVMY290QVFDemJHbDFD?=
 =?utf-8?B?UEdGTG1yV2lBRDA4amFKUjlpbWxDRGlUdGtUMTAxM2lmWFl1Z0xDR0kzQWFQ?=
 =?utf-8?B?dkl5Tk5XRFVTa2hqdlYxL1JEUHQ5dUlHbzhXcElpQ2JsUVFsMHB0UE5lVXRz?=
 =?utf-8?B?SnBaYlFzanYvUVA2elQyMEQ2RmJ2aXJ4M0gzeTl2SVFVQkhZUDE1N0RMekV2?=
 =?utf-8?B?VUhpNVN5Ykg2TDZyalRLVTlvME5RTG95Um1oUGVGWUd5M292TWxNbWY1YThL?=
 =?utf-8?B?SkdFZkxhV1hMVkNORFUyVnl1VUswTTdGNlBrUWtrMFRBSExwNEVVOUdMbG9v?=
 =?utf-8?B?dWJSaDg0N1ZLaHpsYmdhSjIyUXdoWnpuMlVYS2FKVktSSE5vZkJ1bjViZG10?=
 =?utf-8?B?a2E4dlZoWjMrdWd3VVppakNLZmNPako5MXBZVk5FVURyVWw4Y3dRN0NoTXZW?=
 =?utf-8?B?OE5xVVhxRG5GbXVocCtYZS9kMjE3dnJ6OTk4VDlPbGxDMFBrbWxyazZoSVJH?=
 =?utf-8?B?WUM1Q00zdC82MlhJYURQQjRGaEFEc2RkSTRnOUpIZEZWRURxMTV1VC91N3h0?=
 =?utf-8?B?KzJBZUduVlhoZ2g2VThmK21wN0lwcWo3TU5HT0xlMHlEYlVnZi93MWkyT3Zh?=
 =?utf-8?B?YWs5MFdua3c3eGIvUmpQNm9GSGRmS2JndU4wcktnM2Y0am5Ta0Y0b0EwTk9X?=
 =?utf-8?B?eUcwQkI3cEdoM0dPaCs2c0g3V3hQNDN4c1VCWlNaanR6TmFmbE92UnljeC84?=
 =?utf-8?B?YktPNWdoeWpzbFUxbWdDV0lDaUFVSHZsS25NZ0lPRW5EUGxvYXh1cXJsckhR?=
 =?utf-8?B?ZDZma1MvaGxNZUNIMVByMzhSN2RGSTlmV3FwWXpaamZDZVhjcUNMcXFrclJZ?=
 =?utf-8?B?bUphd0ROcmlnOFMzbWZ0VS9nd1pDTU0rKzB2bGNXbXZBSmFSUGNvOUU4STMy?=
 =?utf-8?B?UTFJQ3RPMjUvUUp5cTZyYnF1U2dqdXZReEI1QzExQk9la2p5eXl6VWFYN08y?=
 =?utf-8?B?YllDVFQ2S1NwNW85ZXI5ak5FbVJTVDM4ZTdVSUtudmpUYzJEMzR5U1R5NXZx?=
 =?utf-8?B?dnNON2grRXZxMGVTU0dRek5WeHFBR1lmYWt0RnFBUGxrSmVlNlRycFVBMGhP?=
 =?utf-8?B?OGhGZkhyU0VJL2w0Y3pvUmh3cmo5VmJ5MkJ4VENqZmU2VTdzR0E0R3FYZE9y?=
 =?utf-8?B?SUF0OVVYMmltM1lRZzFyRGNRZytBT3o0UXZKTjZSNGxJbUt3VHpmNUZSVkF0?=
 =?utf-8?B?UEVqQ2pJNE5IZFhRbkcvQThyaC9TTm9xdG1IRElPYjVLUitHOW9EaXJqbnZ1?=
 =?utf-8?B?UTN0KzhEUHZ2REx3WXNEWU9RMmtDcWdKc2ovNDAxN2FUM3V1YVBpOS9PbjJL?=
 =?utf-8?B?eDdpYk43cHZkSTJnTWJ1R1lmSDl5aWYyT0pzSkNvYmJTTzhwbmhZRjdKRUZJ?=
 =?utf-8?B?U2wzOVBsMnZYbytvL2R2bDVzNFRPeGNIMWY5L3ZLN3dURWRXZTJTT1R2VTFv?=
 =?utf-8?B?THJXaG05M3J2NDRML2kzeXRRR0JDMFRRTUZORURrbEpmREQ0ZGhNZWt3a1gv?=
 =?utf-8?B?RFdmVHRGVjl6cUs5UHRPbmVyOHR3VU14NzloM0c4bUw2azJKbVNsUVhhK25H?=
 =?utf-8?B?cUwzYXhJMk1rUHFtd2htQmhoWjBVZzh3SDJTUWJQMGk2SS9UcmlweUltSW55?=
 =?utf-8?B?eXBNS21iR0haYVVKb3BUYW1uVFBuTzdjN003cjRla3hMd1A1cjZucmlvTy9Y?=
 =?utf-8?B?aFhnK2tDamFoL3BDY0RhYjMrb3gza0UwRkJoanJuQVJsNlp2M0l2Wlgxd0tI?=
 =?utf-8?B?QTlDZURIYzBxMUZ6RXN6d0ZsNWZYSGZsaTY5QXlsNnM5YjVTaVJGaHZkbEVr?=
 =?utf-8?Q?5TYjPzUPNfux9pCvtSsAMIbRd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5bc45b-c5a0-4143-7862-08db8378724c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:09:14.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiIx/a69hJ0NdlU/3r9hqmn6Il+0J4Qi9KJtg0hJhS4IdAJf5+4FJ28A81P3HQN74LggdiWMu6M4P6AvcghvvQ==
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
 drivers/mmc/host/pxamci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2a988f942b6c..af17df545582 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -784,7 +784,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pxamci_remove(struct platform_device *pdev)
+static void pxamci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -808,13 +808,11 @@ static int pxamci_remove(struct platform_device *pdev)
 
 		mmc_free_host(mmc);
 	}
-
-	return 0;
 }
 
 static struct platform_driver pxamci_driver = {
 	.probe		= pxamci_probe,
-	.remove		= pxamci_remove,
+	.remove_new	= pxamci_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.39.0

