Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886676352D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjGZLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjGZLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C92696;
        Wed, 26 Jul 2023 04:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch3F4osD06J6rEJNS5pCLGvI3e9c6SvjFtDpGEB4u0wyoIoUvE2lGpNbj8tlYKhxHMK3vFM7eSBSUCMr11TrvM6y4zepd9XwBbdaq86juN+DCQXWuKhIzHj5MbellaTdiiWTbHXlEP/5Qka7/hw/UmpLNqxXYPJKuBzVJy3N69Mn4hgKRtReu45zO5dpWIeN06s4jOg5RBTdlQ257Z2NRZZMLMWroADn/xFZ6In9ovT1ktkIYwR1jP/X/ZPjGOn7xGHietDCYVxyBmRgrJma/D+XhE30lyTH8iuxv3ChVP75JFGquE3Th8UHjWUB2Tb/T1QJHQM3toPHIIiALfbhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Orvuye3fNLN++r+IzvNufcdklaAXxOuN9aUI9dPsr4=;
 b=coDZZWKxauMGEuB3vWACjHA6gA9Cm/MWV7aiVygUBNLq1pvxOx0sQFQW3axQnTSUOKwuHcKbmA4Q7c+///oIp5sOyeuThxZBEcLioo8CKvq7dFOltB3yTdMZvHi4M3+G2k1uyP5yDsgvvd+jn9exNu8pWCXQFKZ3p9OpMYKp/3GdiYrFBDjtB9X0GS628BAf/dzeSuB0SxrZbe6+3DYR90j7Nk71z58OGa9tFp1sOo9Cn03ATxTN5rJw4NN/l/yKW3/mFwMlJT0zsHuaOqN9DCX12TCZtpjUkYrLHp6OYOobgj6HGGoh8cyVHmUKbBHIBCRx3Qk+vgaNH/y7Tqwt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Orvuye3fNLN++r+IzvNufcdklaAXxOuN9aUI9dPsr4=;
 b=Yr5b6/SJKgVvEzTGYN/C8fg3vt50S2OmX/J2sbR0/SkIf8cvyGSfIL0rTIHsgDvJUUnPvXU9JEIf6Idf7NcGB+APy0jhCqn6tYMwXC5j2/WQE+9klAqnQkdV1Kq2ivkZQhXTG+WrS2PAliUgcmFxEthuet+GfzduLWD2Uno1BFfUqM30IJlZhncTlT9gr6yW5OY0jJxFPWcv5qG8oE3UqWtzR2qkzBaGMMnzE/3gqGAwXAcTcLnAQJK3RxlbettLW7YGH6TVAcXaJrh+TDArUFCj98SDjNaW+GrTnvvzBB0aRboQDnpqxbcME0G/QJ7Kqw5qPhmivc7da0F0zYhYQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/30] usb: ohci-at91: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:49 +0800
Message-Id: <20230726113816.888-3-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e465bc-0bc1-4d3d-74fb-08db8dccd5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guJvk17ZqDEBRQdTTrx/LsvAfjJkjiJrSD7sGpr1hvwmkZCpHroEtHWlaQUgRJf5BSrbVbysDxksW3+3/2JR3xadrFybOl7y6XhZ3F75eEAQNRLa1yIg/ZPgyRxxydmUTMpP2ipMSbzLdyjgKQkYPf/aqBSBx1ht3FZ0JbcP4BEmcrlHmNlpDZmBEofS714HCfcOcZAivL7mxJ8rbLny6rHMARAH3P0yQV4S5wsU93nGKYKEiwFaHP1jxyiNX2rF/KyXfzhrAulZ0J6kOGR5A5pCR8oY3TZRU+BSpjK72ZR7gdRADnqTxnVjSK9Uthb5wcotW0XP63knaWtYj3S2LLmKfXqPyTWOusSmJ1fO6EIIc1ElJBkcgr4u6rmO06S6TIbeYwf01YrwALvdejvgDTtZJ5cs9NwF2kH1G+hdccZQcU0vFBJqf7rSNYg0OzT/cdXjhlKr6m2hEl20A0s2steG6pnuLAFKDcDGH2jf30TJLKj+y2GB0O/hsz0FKvFzrDAtXla0WINvSu0VO6BCrbqzLhDmRZb1qw9F7rynsTnxha2qAorstIePziQB6e3UsdK55vco+JM5Hhc90KyTjEArUHp58kuT1OweW6gMvMl/2mZ+ioWBAykAWgelRr+6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSPKvkntmg0hZaKl5rJYWP/cizpUdfrKGplXWZl0Es5i+z/bxS8c+OQTpkXB?=
 =?us-ascii?Q?lMP10IcsVuKaOAILWOI8yFXr6ltG2b7ua/mRqljdoMzXjqcxBIG6gLc0Xypz?=
 =?us-ascii?Q?RoaqDTTtqoVZHyDdVKZwhQKOnMnAls70xjfD3HZ8ecjYzJ/RYmXde08j18ZQ?=
 =?us-ascii?Q?lttVSYgv3jg3OVzi0neSgUWu2fA/+K2oibm6ga5GToDnP9ZhRrxBNAoLQHdl?=
 =?us-ascii?Q?nN5QLjVYmlfTwCF7HwLgspQeYd2TEAiDPhB/z03NsHto3XMxxPmOklv0v+1t?=
 =?us-ascii?Q?G8bXoAF3hEHzFS3LwnMmad1MmSfejZReWdAqyg7xejvYK/eGbWo+kFzmFsUb?=
 =?us-ascii?Q?ueJuM/z4LswN4LT4voKw/5irVwbFdVzDLOY4k34s4Gb3ydtQOjfarAtA727r?=
 =?us-ascii?Q?4WUXRW+Z+Yku8qQBQKLo93QQpkfyEBCYd0WqvG9IrGg1rxfCSwLznpEe2YPZ?=
 =?us-ascii?Q?KAFnMZxfzxQ/HMC7rUjbW3I7lO2Husk73SusTMEZylkxX2IYWbI++EvUkrMs?=
 =?us-ascii?Q?kZdMsDI+/v7bY+h991QZn3UU1tObnLq8Y4/YPK56J+w6IeS9FwJCP01nrEz0?=
 =?us-ascii?Q?W1wdF/jXSoZ8WjpkFtXDb1HiilR6C5/ATv/SdXrTfJFgXfgjoidGsE7Ab4Xe?=
 =?us-ascii?Q?IxDAYt9rzrnhnbm5hmGHK9oouxR5VaT+fpp1zinoE68L5oIedCnbTN2gbWGq?=
 =?us-ascii?Q?OSo4XRGq4JdSDHCxgyfFR2lhPrQLvItW057rZEq1t8JQsfv3lkKAqxW5Tjfz?=
 =?us-ascii?Q?KA50EK8WAu67NpuHN7AdnHm8+R2Vs7aruGfQg6HHpiLF/aP2QspZ+1B+sfm0?=
 =?us-ascii?Q?QWx9l13CVS3McyNmXC8RAfLVMP5oTa9gpptZiNQH+sn1I6QSRolxklEmAoh6?=
 =?us-ascii?Q?iLqMpj2CQ3BMiB4frTVKT5DJDvvey4VJHfbcO1tY6qUfnApEkDdQtXky5K1d?=
 =?us-ascii?Q?/XAFMNFp6/jlwUsfD4aU2t0KGJ2iGs2pu/qnVG3WFivzh6q3XMg3w3jTIU/v?=
 =?us-ascii?Q?cCG5MiVqhYx+OAdmt2R54rTfOZNz+G9SGYgOJXDSjYVG0ABdXLFpd1lGn/x/?=
 =?us-ascii?Q?d6o7Oy3BzlwOM1HQalp4sb1W11JW62noAYi4bAxSj4B/iqgHyR5rj/L7ZKDD?=
 =?us-ascii?Q?sttyinAD6ZsEPmGbA7OfpQumQeIrG0SnnGCmeNepVPrlwVWN4KPdV5L9spXt?=
 =?us-ascii?Q?H2ydDG8R4wmM4ZfhUoxcx4ins6g7xsocOVUzh8AH5qtgXG9ehIZ3/RxwoxCe?=
 =?us-ascii?Q?RiZl5FLT18p1BY+ZuPyVkenf8LipnYblxbPUUNX/mT8M0zV3lA++M/XLThD0?=
 =?us-ascii?Q?BhpD5WecEs5z1fxH9qBkOH5Mi1UPw9n1bb7eeucqV++JAesFMDfh3Ylsm0rn?=
 =?us-ascii?Q?cQiQhCWHFO8efKdRFwmfxFbTvp8SN7ydhc/8Trli6Kzwuf+gPE3sYNIgjQA4?=
 =?us-ascii?Q?xSooxm589nrviiTIvHQ3h+MXdKUqRNDzMhC5CRBfV7/CnAPKdUoLqPPMVLwi?=
 =?us-ascii?Q?TsdJXnceWkgxw5OY6CETiKvuxbYauV+UmZwNFE9eCFB7Q8C+3AmpUr/YImLi?=
 =?us-ascii?Q?qwHnvAi0UcBqRIhdJ5xnxuwkXbbIIvW+U72vlaof?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e465bc-0bc1-4d3d-74fb-08db8dccd5a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:30.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m49CUPI6334We62C+kOOIcxa0Kke6sjVeAB5MTWYXnaeg9SpHWNbXuHKzvz8VYm9JdiV5aZKyBcHHe8VpKv+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
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
 drivers/usb/host/ohci-at91.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index b9ce8d80f20b..f957d008f360 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -200,8 +200,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		return -ENOMEM;
 	ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		retval = PTR_ERR(hcd->regs);
 		goto err;
-- 
2.39.0

