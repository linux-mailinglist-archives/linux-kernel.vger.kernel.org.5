Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8E764791
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjG0HD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjG0HCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:02:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA426AE;
        Thu, 27 Jul 2023 00:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Maf8scFMRz58zsHamLKIVJ1UHN7aAfec4z7+lCdxfNAoYK5ceYF4c6W3//mP+eR6INrPK8WxnOpreC0eZXoSDFdLVJ8cE74cxiN+SBSJ+heIAGhplFezBlM07gHwFDYMOU14x6hbgE5il1590KzDUAf5ywo1KeDndOo392xTCPCk2ZKN9x34QLNuihaQ3B/Iu8V3ilz5znP99ThnXGPcnbJqZhWTOLcygmNX5Lhw304AH4XiV7TT8kK7gVvx+vYBIdlNrz9xajTNw+rn0Yvw1bVQltHkhl0lx6p0w+p/z91f23GDeIJf1ryuFeXcurz2CWiYtY5fBISeNmuxR1dv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=mCBl3vwlixRtymJsJAGNcylwF66NTobmJEtffE4OQWnHBLr1tHmgf2aY1WkaTn9BhO+46AZfYEb2PDA1kw160N/azZtCoq3l5CRm+d47olVvtvbRAfMGYNGIsmDJkRufBwdIiWIvXclkO3F7IGzxzqARo1WylINNM/PcHrazoZvoT5BvihSs5Zw0hka6kxa1GNg8o60y3Me6ZsbZE/MY7WGdw7HxYG/+5aN61LTnt75z5lwG4YBigArNCnfK0RSjD7IoC8ALxNFTscRFMVTeWqbMorPBVNcCqL7Xdj0TqRHPj774VtFaklog/hAqNIXnWJpvOkz6mvRRkezb4aEvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnEm4eeaXUww5eDuPQKSh3EIaMee7cr4msQcxUd2bqk=;
 b=WD5kf8K13FJaMws5FU7HZ5YfNmRj658WPEtPVif/AyB74R8nk3+l5Rce92yhiepQ98fNib2lmwgKZIz1YOcuGCvTR6T/tlMrSXtkw2Q5K7sNaJ6BVRr1pZGuCDPzPoQzOxQ51VayIKGGmyvsDW1e761wgKEAP1Qs07HR5wGdmdgVPcu8NqH+L6fdc3VC+0vsG0ZzkSDoRrQCYbFg/0SL56jkr4wbEsksoVVvIP4BJQHuscSvApv3mpbmTg3ZCG0iDq3mYygXEDWamA4Dwi8v8VFiDwi8dtX9R+18cXks5RIUv1ctU36o2e0dFziQInc+WIXQx13tqqJhBXvLd6ANTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 27/62] mmc: au1xmmc: Convert to platform remove callback returning void
Date:   Thu, 27 Jul 2023 15:00:16 +0800
Message-Id: <20230727070051.17778-27-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e47b5ab-dcd2-46ca-2537-08db8e6f57d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23zHms9rPzA/krfBl5bpxKzIMgYbE6zRgrxK/WASAddevcYdp087pvdQo6B8EncpA1WmTU1DSE+sRfnOElAxiJ0bBOZtyW8/3SL7EN1TGqLKUCJP+iyMfeGjYBWAlX2MC7OhO+e/VdeFSwlILOZbV87fvXyPlqpZOxJ5j1nt5zBu2k45HHrUNh15yYxd1ZGcygJQjl2iXNJu6wX8GLK+ldQj60eCaC1J2nt6fyC8/14VpAus54EThZxtOByrrIniGTYaVFDlFpcFTqm9mbLBc/jUjTqaROI0m2HktaD+oz8qs4kosmLUatDfW6Te+qYEsYbJ2Fj+gdcrXl1HsOLLZ57OVbz3GNZgTMbHXBp1tDg43wCsJ6I4GubSm8jwKlWfc85HkXBPjaLdf82BQ/4GHCSGX3WPBwE1XbzuVdgQLiaSCT3UPX7U4pxMj8lHWCctzjhLuMf1VTS0hQU/iaIk5jdgyT1lH4oCbPn51Dl/KP0vLJlqLxrikqty+/o0QURMvtYmGviIrjvydSnhokYwV+qgBtomG4/8eIfgi32weGD3NiWDX9FF17bDV3EOAieWRuoGGMU5v7Jq195qXZZ9n/qheg0RQ+ffJzJiJ/AwuWWpLJ74usZifWnt7FgSmLf3g87hKynhtLu2x4RnXgRvCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(66574015)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVhDZ2lQOHp1aWNybVU0VkNCV3hrZW4xOGtjRTQzL3JxZFJ3NDFnWWU3S0RE?=
 =?utf-8?B?dnZHMlIreDNNRXlpckQvZitvR0RXblF4a1U0MG9SbC9zMDFKdkZ4UUV3MUdi?=
 =?utf-8?B?L1IxbkFnSTZnV0dERGRRYm5hS3VqZ1QzaEE3OHRtQndSMCtCZVc1VFluWFEz?=
 =?utf-8?B?TkVpWXpSK1dsZEEza21ibjBvNEZsdHYxZi9TUkFvNTAzckwyMDg2YjlkM3Rz?=
 =?utf-8?B?Y3hGblZySVVIbmNZdXRhZzI0M0hZaXhZQ2cwMFVNZ0NkRDA2Z1ZmUks5Zmhp?=
 =?utf-8?B?UnhSOGF3Y0p5M1NpUGk2bXdxQWx5OSt5d3JYeDJ3VjdEZjhrclBKMzEwR0Rl?=
 =?utf-8?B?R0VDeVgzTE9MVDMzRTFEbWZLTkl4Vm43SHBuYk9tclczQ0h0SS85RU5EMGFu?=
 =?utf-8?B?WTRPN3l3M1FESms2OGpyeERQZlRVSlVCN0xISGlKeGNaVkRCN1pDSnZGT2M2?=
 =?utf-8?B?NlJ3R1EzNlNoZVVROWh5c3UwdjNOR1Y5UFcvUmk2bjNvempFVXl5K0lQbU01?=
 =?utf-8?B?bXlETEZiVGcySm9oNjdZNlJFNkUrYjJjekNRSlQrMUNGcUFROWtXOUd2MDZL?=
 =?utf-8?B?MG02LzZSRkhxdDhlb1laU0RCS3kxRGZNd0grcHNSUDlxWkRwV0lSN3JBUmc2?=
 =?utf-8?B?ejhIUzh2WGxmbGQzQ2U2SXlxV2VZN3Uza01aMkdIdURVcEIvUlRKVFBtR2xD?=
 =?utf-8?B?clhtZ3NlNUJKNFcvOHdwOHEwZjdpVzdzMHVxUGRnU0VCQkNTTUVzWFBGTkZm?=
 =?utf-8?B?WjMraklhQkhrUDl4UTQ5angyS2hCaXo0Y1NOOXdCbW9PRFd6d0QyOWgrNlNp?=
 =?utf-8?B?QS8vTWs5OEZub3g3QWd1UXJhem53cC9wcFluWXBKRWp4bWdNa1dqd3hlaEZw?=
 =?utf-8?B?RmlkTjBrSFUyTjJvcG1FbWJpa2k0YmhvbGZJQ0V0S09tQ2tJUzczTDQ0TDZ0?=
 =?utf-8?B?M0h1VmFUaU04ckpqSGk1LzJqZk5wdWkwdGhYWmlwSHcxY3Jyb3F5MUpud2Ny?=
 =?utf-8?B?ODhlS3EvZThMZ2lrZDhGbFRtT1l0d2VMWHJaVXo1WXlSaTQ1bWVYY0libksw?=
 =?utf-8?B?TkhoREdFc3J0WitSQWZxVEZ0dDNPSE9WMEpJZTFZYWcyK0FadENLVlIrd2NS?=
 =?utf-8?B?MjNVSjAwKzJuaG9TdDdDcGdCUDA1UEExWVdFY2NlTmprbjRLaGgxUHZMUWZY?=
 =?utf-8?B?M0o4TktRV3pEUTVaWUdYVVpWaktSNWUrNyttYk9KWmdTcFRVNWdpMEIwN0ky?=
 =?utf-8?B?elRCcS9wRFErN3V5clVscSt5bS81MktZMlNLMURobFZOMmhEczdYYzR6VTh2?=
 =?utf-8?B?MWpXQVUvMXJLT1lCZnB3YlRaVmh5U3lLT3hxWDcydEhLQ1ZVaUl2a2FkNjZm?=
 =?utf-8?B?MTBnV2NJUVNPMzNVdTJuRnZpakxQTmJyQmlBQURtc0t3a3pBZXZvUVZ6a21C?=
 =?utf-8?B?dGJ0Z2VxSVJNdHprZ0NCNXRDSlNUNjk0eUh2Ni9XTjZ4c3RSRzFxTnRad1dC?=
 =?utf-8?B?RWZKTGJZTmZUcXg4VldXMHFhdjNlaEZLL1BLUzgvUzE3THBOSkFyenlIbER4?=
 =?utf-8?B?RHhiQ1JxN0JhZTNiYUVuQWlhaEFKcC9BdzNsMGY3UkxubkVPQnBrNThpQVZQ?=
 =?utf-8?B?Q1I1cXU3THl2anZMQnV1ejB4Mng3c1B5N1FsNXRLbG5ad2ppcGtRdW1xMVJo?=
 =?utf-8?B?ZlhJOFNEZW13QnM3ZE5oNlFzN1hWVzhUQldMUFNzTENsT2VSUEhOVFkxTngy?=
 =?utf-8?B?RFlNUURWREpLT3hLWG15NEJRLzB2VlRmWW9QRElmM2tpb2o1dy9na2gza2cv?=
 =?utf-8?B?ZU14MTc1ekt3UGhSZHhMWDI5cFZFMy9KL0k4SzA4SEFXUFVHMGxyejRndis5?=
 =?utf-8?B?cXJ3bEc2OE9zc3ordUE1c2V0ank3REkrQXBmakY5WS9iUVozL0orUW1UbGxF?=
 =?utf-8?B?QlpIZ2xFSWNUS1R3YnI3S2U3NFlxV3NZUnc4OWpUY0ptWitzV2tNYkJUb3dF?=
 =?utf-8?B?OEh3L0ZxUUxYNVZNZ2RNTEZsbnp3R3RkNlBnRlMweHd5cURGMGtHdDBFZlBY?=
 =?utf-8?B?c2NBRjFkSitielpkcW9zSnJUbENjOUNidC9udE9SeHZvLzIwT2J4WURwb0Nm?=
 =?utf-8?Q?2lRp5Gb+kuGPI2wbmEEApYo1A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e47b5ab-dcd2-46ca-2537-08db8e6f57d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:47.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3zkVkISmWyteOi2ZjdkfAqAL7oVwhEpHmFVv8GlBs9UEcKPCeeCEUwbDiAA1PH44JuinlS5VhsOi4LEw0C/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
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
 drivers/mmc/host/au1xmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 82dd0ae40305..b5a5c6a2fe8b 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1114,7 +1114,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int au1xmmc_remove(struct platform_device *pdev)
+static void au1xmmc_remove(struct platform_device *pdev)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1153,7 +1153,6 @@ static int au1xmmc_remove(struct platform_device *pdev)
 
 		mmc_free_host(host->mmc);
 	}
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1185,7 +1184,7 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
-	.remove        = au1xmmc_remove,
+	.remove_new    = au1xmmc_remove,
 	.suspend       = au1xmmc_suspend,
 	.resume        = au1xmmc_resume,
 	.driver        = {
-- 
2.39.0

