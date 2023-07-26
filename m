Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29863763583
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjGZLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjGZLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:42:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB22D63;
        Wed, 26 Jul 2023 04:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us6OPZIYqSXfaduTgjGpk0KgUXcWkmrvnKz45HxiCGYFRmO+PxbVNyThCOKS2WzcAGEeTAiKTQqIA+S59O1qug3Fm02zEJG1RIBY6YY8CYc8KN5FPNM7RbWMp56uE5mGK5tjkfng6wgOxlRXVD/vq9S0yDC/Wpvd9eK9r3ikH1p1cFUyDr6LgvNcJDsRJ9eDmaaWgjgYEO94J6lRJqZM8owgWYk8RJhDTHL2ZgoofFIqB3HoEoS8b71XLvFM2K93/mE9VAXdu6rFCBG1LlDqN9Q0PXtlWMXYCrRKQEcAYD2BEDoT4AXlyEUreauASKG1IXFOmx10vtL3aKmnW+Kf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHaq5Y6J4d2EPi8H/aWjaEASSHYIEugpZzwedGsCR5U=;
 b=lw7uM7RK0xXoWOHZT76hUpteBmVC+kd23+zGGaW050ZYrsKzlpCllmjzbidDL9CXKAzlIamKIYxO/bKiA+78VEs/WkHeLPfgoqLHfduvqS+ZCors8lg7My9VOqJz7WmAHJHxGovBBYjo7As57QIWstMAM6uN/wjWyzOg44mt29VoGbhjbbag9BWaPXTIGcPDF51MDCswSLitD5S1dsOCzCCXFC9lZkAwNl5Lvo379J26tMmcpT6WnrV/0gCMtMrLtG2w3jhuikem0kxg8VkB5uQQHmjZQnONF6EHQwst5eKmf5W03Ob4yF+Tp4iL0xjvJxNbc/gb+5ukGA5QEwSwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHaq5Y6J4d2EPi8H/aWjaEASSHYIEugpZzwedGsCR5U=;
 b=VO+V52MKzIbodJa3u8O+TM6kt/74Eg3tIybSf1sJssLdABNnfBcuU+8s2X6ApjOiLwInosVxOiqKHsZO2dykQ+LmFyLzWykwYndBIv0N1tGMfQR8rQ38Xc6G8/g4CIkE8jrR8z1Eax7P2zyKuqIoc6dai9Sbr00HoExux9N48P60UGb9/4VHsvYqfLVXxup5RIAc+c8JoqIGL7Nhb/ySi4yMFBwrqI85t5vQny1LkCIzRSiiwPU2oW2HEyl/7+cNsW+zJWFzxPh1AMKcOByrkSvfdHp6fispejcdAKG4/YHcnTH22W6ws6l8YAVktR+Icg7JX7/2so8pqW9FOJ+dQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:38:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/30] usb: ohci-exynos: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:03 +0800
Message-Id: <20230726113816.888-17-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40d80bdc-55b9-45b8-bca4-08db8dcce2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKbsr7/y0ChOi0kZ3iTzrhfktCEl6lQzvkTWSPKFh2M/25E4zIdnO8E1oAqzThjMXkz1spXXWi0hXipps3aKHefit+Lzji727IqmMEfJ3a+XVqPL0ZXq5MjIeVtXpD4tSzwWMHaWJCOpT89czNBmDItuX52RYyGmiTu1dpjnXiRPX72OsH3TUGR8MHKiJ2RILlLitJslO2LQZo9zfC0n7yTuL34YynGtbdqHkNOsvLFWmi5QpiWbtujWsg3R6TOfW5SYc0VA6X4q5CkOIlAmBy3GaZnZbN7Bj7PMzWvY44pSmq9rnmsSgfYxE5pDqd6hkjheX3Xf/blE7cYuM8bE/wzjuMHa8n47qDeRsSrRVnk0jp6L6I+7VWTCU/aIfOmGZL6jiiuSxuY3PiwG4WRyB3EiRQOmVuzx1ljVDVDz2kqnFuKTCCzMQz5v1bnWb2AFbfHSzoFtDlVZfzbtT80Q2hkBlf+vwLlUEQd5ehzzgX0LvntGkn+h9xstik255NWTBKA/omIybVaXHedZmSAn9niLT/P2ih4BpCs6nzCdduGr1kpWgoyC0HwNRTveo8HvbCyzAblQw37ttq15U6KfDXXZkXE7uBtukCsD49wN9SRgjGQsuw6E+1WLSzCy35FB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3UYhuI6jvpT4A8GWYmVhEXUSEQ2TYXsW/9obrMWVkLvn9wuDUk98MbOeGWM/?=
 =?us-ascii?Q?R3sJGLzz7w81CokJzFzMPBeSnt8j+YIWF/yNA3cgrzj1PLqPMs4D308gf7Rg?=
 =?us-ascii?Q?lTITn3BqeQKHG69RzT9ay/ziGq9rXAKK2MEpVZUz+h53H8O3KZq9/XxO91pX?=
 =?us-ascii?Q?p0J1A0QhRgp0/oSFl9gI2YJfpcPAGSjemJEAcY7Y60kAc80lUTlMhjiUaRhm?=
 =?us-ascii?Q?840CStm6TLXqe8lZs1c9NcuaFccZGqmhzJ3PXz+EYi9woaqEFMIR3ew9lf3v?=
 =?us-ascii?Q?rcOBUiv/Zsp4SAo6inOvMTc6JImAoa9Z6Q72Kr+Jk1MV/OWvAIsSSfjFZmHE?=
 =?us-ascii?Q?LjbnBoLqDViSaBvbhCilMHjpFUKLtRbGltHb9pvjUIEL20E94bF8yWyMq7zO?=
 =?us-ascii?Q?wu0UyTeH1cVm8kNWKyUIzgQfkqfyuckfJm3BG9aduSBVI5I1cWg+CzFW3dGd?=
 =?us-ascii?Q?qchOvzuHtTX9LthMWKCXuitEsmGF6BW+68udx1VZppDggenIWqEGt6EHX1lg?=
 =?us-ascii?Q?v+pB9RTjEMhhLLYAzF+Q1EGbRCM4Re9nCcq1NAT1ezWWbVhuIGhFxKaLsV0J?=
 =?us-ascii?Q?L4He+3D1NiWil/2PjlVfRybBpQaFe96iUZuEue3tRqq94jvdlbCuWeN2q+qu?=
 =?us-ascii?Q?hA3bbK8wfksaqdZhUF0M8SdtdaovLTq/Sp4KcQu4ugzpRd45Z+gNvMgGvAfk?=
 =?us-ascii?Q?mcozM45uB+BGbDEx7hlcNwtWNlkK1s/hj2gbc32/8t1hrJJbGNDlIc+Ff3KY?=
 =?us-ascii?Q?BxhqsEEuvif1FBfduU90qm1Fd93SIRKyXi4UowjqE1peFZCkjZMR6/wgltO/?=
 =?us-ascii?Q?+PxBg7lJW71pWAXb+rf7k8ihSvUp4sNHx2tsJeOvgTDaylI2sToRTOsHG6ke?=
 =?us-ascii?Q?3A36LjNiNr6O8xSLSoPwyCYdfid60p9Psb1RumTa6ILnpnfAT8clBB/vgiLl?=
 =?us-ascii?Q?7Ki6whRlh7BlRQhPYckZ1tvhCCJX+4xmx23Fv0UlKE0PCfFHenCv9L2BGkbl?=
 =?us-ascii?Q?/WXWFzHx5OPNUwqo4lbTHFFTTRGy42AJVNb8KJIZkse2nDer1fIeYp2GXZch?=
 =?us-ascii?Q?BK1Mblf8kTFHYdyaDai9KVuvkEYmkGkksjDWld9JMd3ihfuqIoRfjXjACZQq?=
 =?us-ascii?Q?stMsgWX3ssNUUtphlNdEW4WSSB0uaYEQqakJGuuA8WEqf44T6rtqmbR85RSP?=
 =?us-ascii?Q?qQka9SGgbzMBfALruOfQVjRr4LCNEdx8f9MAOaEtdv2LVifvyFI5RBrZv2CL?=
 =?us-ascii?Q?h+zCL/DhE1e3ceLKLyMVEuICru9mt09JS3MLY098SMNtvV7lcSo/dV/RX6QW?=
 =?us-ascii?Q?5Kbokg2qj5gXphMnO71sLeiIowrDm/cH1QVvmG09DC+g8pAKTWusiX7zdtIN?=
 =?us-ascii?Q?5VCWDnNZuYU3jXcEYA3fkxSiROFP5ARpZr7oEc/jMTXHV/ZMqV58qath+1g0?=
 =?us-ascii?Q?NZFafAMtZpLyI3C1HXeMjDXf0TXsOT+i+pGKmnrxwztmTfJK8AP+yogAjBOm?=
 =?us-ascii?Q?9kIckIYHy0lSTruHqW1yjnW7q7VQvYxD0M5wteVS6E0kOzUSps0jMR1ErL4x?=
 =?us-ascii?Q?1I/6LR23Fno4kKhY95nRfPoAfhZDO7Ej/lZW+5+g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d80bdc-55b9-45b8-bca4-08db8dcce2df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:52.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRNWanw7798jXNXNMmkjhQf83PRUFjlRxatiK0/Eto4S5JCst08G6iCFM51303O3fWYlzdv0UyqH6szN0QfPAQ==
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
 drivers/usb/host/ohci-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index ab31c459b32d..20e26a474591 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -149,8 +149,7 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_clk;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto fail_io;
-- 
2.39.0

