Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9967E763557
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjGZLkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjGZLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DD3A80;
        Wed, 26 Jul 2023 04:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENAkyAQJqVBMuo5xFjgbqoSpmrqHoG1l1AG5Wi11zCBbcMpcJva6as4nmGLhN9J8gJDv0/qMv2Dzfxx7adnoVvopCqhUyXKiLRJOf4B3KJJkwUWEQPojraqt3OsEyCCWMbcflTgnRpNbReRF2Hq1AhH++ky1/oKb+WwG+uiAx2WWC3cTYSoq9clkhK7xZaWFlXqfeujcq8p5NReL20/G2DXABizm4/xnIeVyhE5xfptt8S7RLu5pjDVXG1j7fVDbDr9cHKFD3FLReR+J4RPCmsyKEZhKlkhtZ+ZPljFcpz/XhbwV6p3o9gVWFK6jYTwKsDXhPiNloVlAGiTUeK/I+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEqLmhRkcdEd8su+d1qa6gyjoGA3Q9/s31q63uuIvl4=;
 b=AZ360VqkLQAZMIFGIU4zWIe7zgw7hnmOuK4kclKVZGz5GulBEam5Or9+mDoGczZ6gzD99tHZ6OZzqPUTV+h/5lObRcxUvnz4R1LTpgkRnWCB/1jusFjDaN8WlOvDZkfkMVhjwthv/Rd7/8nYYrwJyx5KwCsJQaVtyQMhO0eB2m9CtFNoCtFzFO7+EAvGolI5PI7vjghI446xu3KlcETQ55B4+3zkikNcsuwOQXS2IJDSMyV49cPmEvUDN4vvNkB69AdH+zleFAj/zus41LBTXWO1/7qL65R4h6p6JdAegZ23UqGfkZJYbRoHQjK+xc0asy+LJbQaULLaREbfHWxu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEqLmhRkcdEd8su+d1qa6gyjoGA3Q9/s31q63uuIvl4=;
 b=Ek/CflMJdMRjXmcZM8wl+gfHQstk+Mc4975ActrSbuCIaxKFJATEWdtUkVaee36P+GrdviROoBDlUet8tYfuFqaVMoypNM2pq/aCCjQ6bn2sQxzhzwoBcMXEyIumumvElx2IYGc0YFMY2Lf40XNwuO7OZ8H5YOzvFiY7MRu7Yxz1T4r9Z6RybZxhut+VZJpA7LCRP3pUbPyI83XWTPqchWLFvybBzcwSCh/sklM6Z4WMRadGRMZEZS9Yrnd6EM+Dgpxdn8lu7kREJWK80n/Sm/JdXH0DWZ0Ps1eK9ceFSoNro5J9gwccEJ4kgQMrkUrukh9tehkuc+HR4NKOsI3E2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/30] usb: ohci-nxp: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:05 +0800
Message-Id: <20230726113816.888-19-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d13fee-49cc-496a-fbb7-08db8dcce522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rmRPyfu96d3Fnsd0rLyYjVacSQayIIKxzTAETJF/y22CcnB2AOlsKRvk/M/nZlzOpV9cq4od/UbT9Etyrz4CSmCs88JhoNJvQ3dtmRJeMDVGztvCKq28Eez83cAKe92KYqlz3sdosf0M5jkTFztw0iYkHCLoZN7FAy7Bc2wAL4UBdhqgZE3rcZi251+yinvi/wwjwSC0N9JS9wuos0NNkjW8crRfNluhkklY7lAN2I+TEP7cjLDEk3ZjGqelQEvvK2G0vtKiCGFztiIA1P0QupISGdHvLpgeSkPTqhc0keTQH+EuvLLFGG4GBs+w2lMdLF1W2zL3YrwclZoWs3qXZ0k4WzOF5hW3DIsxWHmr4Cgy/44yB5AeLlI28GxPqGmCrzjYczcJZcp7ghZwndeucw50wvozIrzU4PqKksCjxkQBWlzJMtTSzaGgzcEtbH0sqV+vpBbqrMGEc03r60UQOZE8Qs4Zw1laL8uNzVGJ8AYE9PftvFGC/OrYc+YfQdWzI/4HnsoagXoL3GF5+WaOcUHQD8TKx7GhFvMHbkPx+Lywb9PbE+yjnVuwys4bfE7Cwe64i6IsFmi9tx48GKpnk1sM3c/mqZ1AJQ07CYRT1ojOs9eI/HslhfCj3C68Nbt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xcrk91cwWyGnEsos2m9YILslgHyo9s7cfbwn+7Gt3ENdXHaHt3Plu6xU24qa?=
 =?us-ascii?Q?c+uoK4yw6fm78RD2mDoyaP+EilTc2Gq/kLGpme8vL151LxiTx6CB2V9kRsm+?=
 =?us-ascii?Q?FTt9Xa2JBlL3YYAheXtr8NDJl1pRQHEHMJklADurB7jKl38IBhzXp/WZ5AzI?=
 =?us-ascii?Q?zIRGzBtEZlQmCi2F9iPZBbiICPOjJKZ8LZKBKsIILXW4u0DlSaaA2KeHAKWF?=
 =?us-ascii?Q?L8UaTXMWa4FzbOAlvwJ1M5qm5dWDgJ35wv+AUc0dRsHkSvAL+jav3k/R6Dd+?=
 =?us-ascii?Q?SkOIrBPqTuAfs6BMrvnCuooKCsKB8J3NY7gKPo1efBnOW9HZHxGDwqDWn/rV?=
 =?us-ascii?Q?DPzepCsZzz+EJx0dGRnzPbUctfs5xa3yRIxKfYRZDsupvMXkaZ51LCMy9+1e?=
 =?us-ascii?Q?KBXCKAnDCmskyJOSCBoxp5T3AaPL+v8PxcRqisgr5yzebJOR5r2gkWr0msXs?=
 =?us-ascii?Q?+S8Fn7rD/rY76sQLrzQ/3kfndmUsj+4OxeViA2YmdDYb8Q90ZioySUM4pXdq?=
 =?us-ascii?Q?qesj8MjQrINdAwNNRDQxMDRQf5iWK2NK3N8Qzigv5KAreF3Hs7Uulaoul3WR?=
 =?us-ascii?Q?DkJPW31oLGeRet9KeuCYb0M/1XzA+N9EGNCFEvQPsNO+beYcIbavzTIONTBJ?=
 =?us-ascii?Q?RneKGwMVfxRfw49GMenBJId9oCh1+UgLxor19oC2UaZUGdeA1x/JzsXRXSS7?=
 =?us-ascii?Q?ynko0MyqNfTnR4GzJJpAg3XOWe6FqH7CEE+rD4y0/NEo782SuALaZKB7p9jc?=
 =?us-ascii?Q?m3i3/l/JrQMx9jzWdGcZHZABHiMlaokE/Imbm8TixcRAMFuavFQoI6j/hYov?=
 =?us-ascii?Q?fW08f0jjIAI6dySyE4l9/cwxJl5fdf9jbR0rMnb44uzPuJQhlbuQU34a1dnZ?=
 =?us-ascii?Q?E8DLQgxSD4C9HOoSv5+lubdP7p9dw625R/d3iADTg2+YTJ6S+LNSjLAoyHDI?=
 =?us-ascii?Q?njj7WZ+DiPE4cGZCYJLEuhBrXQX0XLRgVcnO3F3BWt1rMEltQczzBrrBMSRK?=
 =?us-ascii?Q?w//UXxEy6dtof3mp5kWyl2zSvOQ53pcRWsrf7fZTe0tvIoPMYiZoHijUpp4t?=
 =?us-ascii?Q?zLmI3hrBNTLd4zGMmaG+VFFDcM4Cf7e+lCWeybMfO6exXrDs/q0zRDfheLUl?=
 =?us-ascii?Q?T4JYWBSXOSmlySpyX8iDo/UfGI8WUyANvg0KsUjpE422/FDHnrhPU6XHIG9D?=
 =?us-ascii?Q?CeEmr4/ZuoqT87wY4qqublrSEXz4ktgvVC8si8JW+eOs4hMnQQnodJMksS85?=
 =?us-ascii?Q?NnVRFS93JDi8PS3M8aNrUoukxLU0gjuVvU0zkKM+24+rRAueaRhaSNAM/E4k?=
 =?us-ascii?Q?gL6etH1jJhjG7CruN+S9U74MtlC6p+h/ZudQCvGM2bQXTdFiE1Fr2e7iMLT2?=
 =?us-ascii?Q?WeV3eSKiflVcLlAhvy84dlY+MaxXPg/0Zs4+w8bIl9AeQVtyD7QJEmpSSg5c?=
 =?us-ascii?Q?MCuANSZT2ELZvsjjnoyGZThLm1C6ote8rPsZzY+VdOtuXXaIaeHPnqnSLukT?=
 =?us-ascii?Q?q6DZtuVJoVbzoqEiLOTxdeDGKfDmstyeKYZChMJXAHEv+V76jnt6B2CO7vEb?=
 =?us-ascii?Q?PXOuRKni6r3Uj3AKmSYpNAnyLTEzzYU9qJZmpFm6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d13fee-49cc-496a-fbb7-08db8dcce522
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:56.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWNgcza4MtvIW2cSuVl3rm8Wpc5HYFLpib39QFq1ih4qSIqKaXmL0GvKwQ+EG/c035NbSfUQPBQd28WRzf+p1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ohci-nxp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index c04b2af5c766..8264c454f6bd 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -202,8 +202,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 		goto fail_hcd;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto fail_resource;
-- 
2.39.0

