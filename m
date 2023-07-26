Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D8763556
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjGZLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjGZLkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:40:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85C2706;
        Wed, 26 Jul 2023 04:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlWH9V0xuTa2plVAVWVv/C4WR3w+X6WNdrGap2r5rcsTqAt50gByDabDE2S+excW2dS5/847q72PG1ejiP5nDULcHS6Qezqqz3G8DK2ocQd0UWAHFpQqto6Do45JFH0RpHOtxFtENJPGM9TyTvNnw3WqCbYrpieGaUcEESxGOn+zZ0wQ72vFKQ6fOyAMfrdTycqrDTM7NmbLEoYTD2VAMroPtdAn6A+3vB79fPKaQdGc6aY0U4kFKT2yPI42gUGBTXkXY9Ow/PMv3dMKl1wzYB60nvjcB2bs/3h3Ll/WVWwVgRoUIaF2XHw7un0WE5uT3K5JvdMytUr+e34Qtc7tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5CJKXQQWPawS2bpZFZYC8QwYBoZBaKKVFJlCbr0Gwo=;
 b=cTVn92UwrhFtwZst11HqzNFYsavC0byIK7Iz7M8Z47aW41juR3gm6Qt6ajC2cFWkVBCMzOdDppBpGO6T6eYM6qkM3/Aa2fqck3n5VPjcahJzT2js/vZ0lqUAtmAzBOkygLLz4TpdVAuNujiHYzK2/iVOGgsI4GW9aCSSbVc+6EFUgxaEyC+KImp7ISInlF+vyISgy5xqo1IM27qG8mvQhfiOU/7ixdZPeueP3EqsK/NDIebsGVJCwK+5jfSyUW21e7MRaFqg38Q22/XhstTPQ2ctFPyVcHRelL+oqZmB9Rt+J4AP2/Q0ykur6f7ZKy60/as258mEANn/Bn0JO/i2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5CJKXQQWPawS2bpZFZYC8QwYBoZBaKKVFJlCbr0Gwo=;
 b=O1CCUMbuFvIoF+J0Rwt9563VdeOBxk3txTDEyDd6segW/CQRbxw6hF7fnLEq+q3/Jey8wuUbOomHGzQFtQqY+jn85fGgdfNNA4d1vPZAVcnuBJv+iWxEw4es5Ex4JZJqB35iYrjx7GQRzvh6f4tc6q7IwGObQh/uBKlmCHoaR1g92ewjWj3oAg3iNoKHSBrIairy/Nh3uoEJVzj7lDv/oL+GJ9RchGSV6Dt13ivp83BIiwebD97CLaEvhYZZG3MAjmYXv4CEb4ueW0i8GwA10KgkW3CpmBx781iso+TjjiR7Ab85/xp4Des7bsoj39phTPkGtOZfLArOQBwHu0QcYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] usb: ehci-platform: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:57 +0800
Message-Id: <20230726113816.888-11-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b39dcb75-0e23-49b7-0182-08db8dccddb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJ5WEgTZAo1HW1eRNtn/6uJok/Sr5qGR54fg4K+YxygjVnbgZfBbfgS0kJAFg3ogVllYVgzax9X1uAnhAFRc+ZLMWA0eU56gNN3m1z+QGQvpTAv3h0AfDcTnDaIFoAXHS8zegxjBx1iwivIPixXw5D9j6lIkN7iphDgioRfZDwhY3dZzy1umr/dHGCaKXdWBxGdaWTtxb3uWaKYlLrmkpvo4GQ0rOclvilyzDXYuOk+L5D815t1prhAP/0TZ9FyTA+ZeqMk6WKzSQN0hBHr3BxWj101CONNS57qEzpEmNAJXPxMxtx0iqS7/Bj0gMrNInm5usiaAkacaZ0zSp1A8SeIZX0t4drY64MTR52qm3lB66Y/i2PWacvfmF/IxROLvvniqJH7S3QSm1v0jb1BCeMd0Z8w6to/fAGBbemxH42vVXvAE4GcpzfEyuMUDQciCppXK/wlNvj9Nw2JAHbJr6xXWEyDTlOqN2LPGtpm//sz6zDkm24mcMDDoCr/7HPLl4jE35+hCSTfVHHPCtBG7SQ4pOa5kvKvx9VYmueEynl4qtLfUZqtvGF4s9A6MN183lXuIiwqgNQDmidBI3hyjvvJ5/2bTAEuwvzUN3UMS/mnHT+/cmi3nTh6od4TQamJv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0y0dMtKYNnd5cWaMop4ppUyZDrqoItzYHtfeCFmpa29oDPpNX1qSjO92POL?=
 =?us-ascii?Q?sZxJZ0DxSHn2gbtvfzRggs71TMYfSvUmy5uxALuz3JPotdle8GHtAbiG816q?=
 =?us-ascii?Q?sDSUw5KHuPzJfbgXl1t3KwPsdeT8IP+lkrzTbrDhTYOPa/XJU2ICczrxwyvx?=
 =?us-ascii?Q?I0A+aRsgNdCSY7h0St6NLBFy+jktc6Q1TNIy8IFoXzyxN0gYoek6MESHAV6r?=
 =?us-ascii?Q?8Pz5AB+YlI7MYEFVzkLsogvMZSy5C87H3DHXaw1s1uk3b6C7jRCCq6iZRs7Q?=
 =?us-ascii?Q?+sfADTqhC22RLma9qxdB0OtlEQtI/xerCqFBHiAoyZFMJNm5r6gdHSZ3D3mA?=
 =?us-ascii?Q?OEm5RMiSYKhcc7kQs446V06Uc+VGTbkJKN4nXnMGuxm69KSB5BiH7Pi5aiI/?=
 =?us-ascii?Q?UHib/Ec/Va1BElUhfYSPKMZiO+y5TXg/hq96pAYyFxQCRn0dtBpxTBD7BNiO?=
 =?us-ascii?Q?MBTpIY3U6LNOxXDDfZoH7ytb3pD1CRFQi75V+OluWJz2HenwULv7gIPn6dBl?=
 =?us-ascii?Q?oePW2uVFQo5Lyw/DCvr0pfaVnOH4o3xxRJkalQjVhMMasfWyyA9xL5C/HCn8?=
 =?us-ascii?Q?og+tlvaLkqOeuxZfsupgursssyf6MndZqGJPFrSNBpoPPIsU+r7/qj4PavYg?=
 =?us-ascii?Q?iKkqw9uwTUTg7gPOyAHgpDS9jo8XYtKFYX4TGXcOosjg6wCRcXJVP41auMqH?=
 =?us-ascii?Q?jROGnnVej/+cBYorEBXT3SLUY6t0ml6drF8cYZjBJ/NA9PqL1K2lEZbJn7jH?=
 =?us-ascii?Q?4A+GYv+DIeTsLioEvT5Fx0rPQTrIai2V1zFsnPMg3Us+aaPdYQQfD2llDIPR?=
 =?us-ascii?Q?np4TuTjc+bC0MPTtKYD9NBCxGVaDdiiJZyaRr/3mNylHqLiRNhFat9IiELFx?=
 =?us-ascii?Q?Oio2YSFhjIV5RaS8GFHDE5jTg92IE7gLUngS5Xxyc64ven32DMA5SaJAmoUP?=
 =?us-ascii?Q?3osZa32Fvsb9Gmrq0bRGpOEpio4W3sNiwxbZhOaxs97nZJ26jJpHByci/yGt?=
 =?us-ascii?Q?zNB8LpHmTMFMe6v6/sUeKV+elCcqgenJDoh6aDkn0srgealDMV7v3nlMGI4U?=
 =?us-ascii?Q?wmo6er61vzBOYLnR9EYEmaJcIeqkN0mZCrC6DMGgsiXcpFx6Vok/xLFfN4NF?=
 =?us-ascii?Q?wi23fUGGb5iQd8YJs1W0/0eKJ0KxtXCn1YivbDJ+nKRNF5j7En5c45NvzvMC?=
 =?us-ascii?Q?hF6eQC2capXR3UYEPAxinbu6dPXudbFmpOtwA8kwiR0n/3c61rdFrnV36ZfQ?=
 =?us-ascii?Q?CzkTdF2vjUuuc3csfN5H+olkqj/hJxOZOAfaRmqOiEF+3yKmJr29kZh3rFGU?=
 =?us-ascii?Q?89fOfeHziXaC20z9gWKdjISXEKDY4pKADOZE50q+vGBahcLKLYtcJK2yyNOH?=
 =?us-ascii?Q?1nMwVTvaDlWn2QsUtIX6LeI3R77KaCSJ5UK0biTV+dkzI7sliHxUmEUt96mX?=
 =?us-ascii?Q?ds2pVx7FOxx7Vgd+rP1BUh6MUO5aOH8L1ldHA4p30CW0p8A6aKd5CuuDNys7?=
 =?us-ascii?Q?rvZERL8aQHoOtzl3EUTvtzWXwaBzV56l490zQk2Oh0V8q6Bsv1+UmZbM+0dR?=
 =?us-ascii?Q?vMU9cc0JAbvzr0HNfRUZoaFGzITWzYV0uPOlV5na?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39dcb75-0e23-49b7-0182-08db8dccddb0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:43.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL/C82tTWq/NKq3elQitheHugNkBX/5ILMjV+4GegpdaN08uh+h3/WdRRnOSBhvXL2dc5L7zvalQPDaOHoyVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/usb/host/ehci-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 83bf56c9424f..98b073185e1c 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -359,8 +359,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 			goto err_reset;
 	}
 
-	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	hcd->regs = devm_platform_get_and_ioremap_resource(dev, 0, &res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto err_power;
-- 
2.39.0

