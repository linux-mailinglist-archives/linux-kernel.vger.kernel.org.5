Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE9763580
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjGZLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjGZLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:42:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BEE2D5E;
        Wed, 26 Jul 2023 04:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+nJLtQDVke/ZuGL/bvAC3oWwz0oURWzW92yP9bOLL6kDYXLhne6mkRpFkwcibA6XZySscsJqZTVZm2v9XaloU8HCxg8HSTc2OGIY8f1/OydjGXE0MD2tUFfThEZ5WraNNJcNLEqJuhjQFIqfSH/agWXtKjqj7+W+SxX97mj2IOZ6UO2xE9EaZdUOlkJDVfUxJyHyKiXuHznaEwRjzW7S2tkYu+Rpw03kig6JwKaUS4SH9CfPRAAF316dcnr4W2+BwCjYN4uGmIi5kex2try1lwJvgK2WshUuCym9RZcx0Dp86nx3nN4eSI6WWIloevyP8Fwf6ko3R4fPIg87PaCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSdfkUbBTBOs/S/Z3/ISwWckYgrW78BZo24eG+DeiMA=;
 b=I4jzExIpRJR1k/uebKUZh8GpRExqm8r7bC8J8N6J1Cb9UUf+bUwEZKV9EP9ki72wZMJYcq1cc6OxsSStZUy8HVPU+tQUiAds9urDc4pBv4nTabbuJpzbYYHXtLE0x3OQ7IOtgbv4VDtn3hHfbBWUhAjPzuk5CK5BCI2Sdk4/TUIE6ZAhKCrWHW9JxHER1GwXFlRoIJ8PHS0krHHeCGBcAyKA2pSLPI1T5j7Ou4ifgwDkhBAQurpphveycUQGGmoLi/sy8mb6+NgGrXHakUVjW67Z87WefoeItQGTfNsVYFlLnCpJY07iCe5rG4XpGa/eDRULFMnqGMn+E7zvTGA0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSdfkUbBTBOs/S/Z3/ISwWckYgrW78BZo24eG+DeiMA=;
 b=HbeHodDccDsZojb87IN8MRhXDU5msGtVLX7Pd3joYzX+iJc6AMYiThRyl8/Jewz5nNA8GmjrHD83bIylW2Gs7EUGZwSQDquvh0fewbLEflC7SiS4Eht0qvTPBnWuOjURIuPQnQAx/QGSoU8/eIj1bxQyqRwYB8dQ+w7iFcbZ5LbC/QetasMWB9uQ5xmea+uJqTiTqp7UWM8yr4xWPNfBfuHjypDTif3Kh7N5WzR1/serqCmOFDT4uID8fZSBqqGliqzgQA9CLkwO3GuByjtkaDZ5LsiBYrdmDiNhqF02ZuCsk2qnAhJJ5V6fD1Ug20fprqFP7HRDsc2EnSJE1T4Cuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4203.apcprd06.prod.outlook.com (2603:1096:4:e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Wed, 26 Jul 2023 11:39:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:39:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] usb: ehci-exynos: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:38:15 +0800
Message-Id: <20230726113816.888-29-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 982df809-adb2-4fba-e33d-08db8dccee3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTAfsTBOgefkkZzEmYcjFjIBysAbBO+0qo6RN8NkPlK1vZzt0M97AZiDi61Df5qqaw0cyE+GXf6nKmpBJjRU2fXopBdHHo0uljA2UPcp05/cr/iSFL2/Lg8gBg7WdUIt/tWMK0fjkKVU1Y/AyaUPwUWoN1pMGbnF+mf5GnykAtFUvrnbYVDeL98UNT12uAgV5umifp4+tJh04b0DBdDVKyZCnYaYL63Ppo1MFKb5A9tg0y87WYMpIHfWxY/g+r0Kc+/Q4VbVi2+1TXkyHl/ymzV9kkfky0u8yNfDAPHVbgN+0G/YL1Mpozs4yK3/gBwQOcxZPlpXtnWb/IU2WkMPbQ/XUAAgYq5K3WYlaTjFdjwP4WN/0LGacD//g+vhTx0lwM+GakDsSvFfqr2s0lM5qlljOG0A85ABeZAsPQGZ6fF391ZmN0FwquR8pg9O4KZVmFVVbznWGv4kJfwMQR6jSUA3ybWamkSyNqo5LG60jReYogb+TqfLd9moIqSNpEBkiRtLKqLc7pRyjyFvN0lXGxRf0RNUunJyaFI7uZdXleItJtSIoWkrrj3nErD7cfzPEXUom6dp2f/qj+8fXxp++QKRt5Y0ckVOiRDqPXDve/rzhZCWGk49SadA6OGWsZE1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66556008)(478600001)(4326008)(316002)(110136005)(6512007)(8936002)(5660300002)(8676002)(6486002)(2906002)(1076003)(186003)(52116002)(4744005)(26005)(6506007)(83380400001)(66946007)(41300700001)(36756003)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRNqctJCoSQe5b+VUWtOF14tZrem5Q8TOQKnHZHMdmJ9cWiMlTElpKoDt/3P?=
 =?us-ascii?Q?09iZLesmO78WkeAndb4dkARcZerYyKrDLRmuOvjag0Udo+QJn0JKAIMlfwQ3?=
 =?us-ascii?Q?16IqiLT++aOh7DxRfqcBSGLpSp8S9LLI6IoqN4N2qAgf58sO+2Dc17k4W4CO?=
 =?us-ascii?Q?Z1BrPrYwz4RuSu05B1YM7Zw/DH9WfXxkGCtZL/pd5e4G4fhMcky7HTGFWUBM?=
 =?us-ascii?Q?XpO9Jn2B/w8qbs6nzSsje/xD6JC0yolMnwJ4cXN7vhrjJdTeAMSvvQM2uKeM?=
 =?us-ascii?Q?YqJE2SO4isigXWwmCKaMFgUPeSh7NkvaMwBhI61lRps0jVneMWJnkHLwBCQy?=
 =?us-ascii?Q?owlRbY7aEfH0/sXCrVOEGDyu2C71p5UOxIZjAfcHEKza/VMEI260Sywdzm4W?=
 =?us-ascii?Q?piQ4CEJ+QKBcHQxFttgEjmCzkjNf2Fp4TBokKs7RgXedfU6gHmBZfFP3P+pv?=
 =?us-ascii?Q?p4KC0+SHQZ3vrD8CvKzNwB9MxBf5M7XlIaPlXz8khrGRwJ5H/fQWqjYujy9K?=
 =?us-ascii?Q?rr/qiQ5V79sycbROsT9g3UEGZLsBDKqFdxeW7gic3ZAkAdh3Xd87QYKkWIp7?=
 =?us-ascii?Q?8L7UPPX6zUslDPqATz03kAtGTvVySCEPPrOLDeyUrTkYnWhCUEiEGQSSaFqY?=
 =?us-ascii?Q?ZxKRgVt7bJ9vN/0P6grEVhOJS+C5Oppv0oVXF/tQ+qVkWtCkNbj67NRVuhT6?=
 =?us-ascii?Q?rC9Ydj3mGOJQEJdxqkqIMGfVn6DEopLe0RLDtMoZfoL62RPvehfd+zXbi7Vc?=
 =?us-ascii?Q?X6L9DBc/LFWdpoS4sq7lLsZKopBlA22V6u0GzgIie1aFObvP6M9p8KWW6PkT?=
 =?us-ascii?Q?Mz4HJfWjDIzfwqnwTCjUU9dql1RXraCoS7pDsEpRCWipCECD8syX8A4+3hcI?=
 =?us-ascii?Q?eAONsQ8HAaElDLCAE59HxdDqvVUtY+vn8WzniC6Mj+arw3DlsVYo+Q6huQXb?=
 =?us-ascii?Q?mM3pvYJ4EtiXpR1PFJPmtHV4+ymFzbei+gh7/jOl82phIusG3F4KtMTo0O5j?=
 =?us-ascii?Q?dvRWnJmHpkPGq8TMIpWBQSgUk59p+oWybc//c22ahn0/mIi/Pepx0RItt3h/?=
 =?us-ascii?Q?2KkIZVzEdIquJG3dabNYtRHlcrWNhB96yB1pU65rN1n5qAf23ZksuoaY3ZdK?=
 =?us-ascii?Q?9t6IOZxrlC8/7ZjK2S7e5WChjDXEr40Cc9al8Zd3psLFzawkPyx3y6LjigXS?=
 =?us-ascii?Q?opFvhM13AB26CKlRR78uQOFJtwiYNn4ysq71RSy0FVCUfh3xMx9+2L9bFn9k?=
 =?us-ascii?Q?MoEyGHT4rtBA2/syube1Wls406syX6Dn0wxJnaNzRxKhXNf69nkibZD4VgaJ?=
 =?us-ascii?Q?tKX8B2M7f+6UYWXZWlUQrFL23PSwXOnne+sjunggsN2c6oYOeCm0IbcPhhwz?=
 =?us-ascii?Q?FAObNuZqGzzjLfXj+OrO5MRrnkblAOoMOF4aos+f1ihOrXShwgxJQgT2m4lM?=
 =?us-ascii?Q?3JXTW/6Cyo/2wqRFR+6axXiU1XxlwMnSe1KQHeVV7vns9GtBZjpI2YGWTuHx?=
 =?us-ascii?Q?ZzVaZT+dcyOb1Xe3pLia9h8fgBGvYUVbb7291gvOguky8SBCKMHdln3H180k?=
 =?us-ascii?Q?gDW6g80GkhOED3qyTVpdlijUvSZl8DdrDGr6/qF9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982df809-adb2-4fba-e33d-08db8dccee3b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:39:11.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAfZwBZ5ERNSg2RdIYErsnTbCHpKixdQZgcfFKoRgr3gpYj2bDHX0FbWBnMAgNt283b7o6FWLz1BEK1a6jOGKQ==
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
 drivers/usb/host/ehci-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 20f8c0ec6810..f644b131cc0b 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -173,8 +173,7 @@ static int exynos_ehci_probe(struct platform_device *pdev)
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

