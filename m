Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695757516D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjGMDgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjGMDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:36:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879F1FEE;
        Wed, 12 Jul 2023 20:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHmkGBiTLxQ5/KO8G/rWtLtorNDGd8dQ9+TwSa1suQFGh0AiRC0jemggTR5ONnHbyQsRy1ANXI1zBt8u0sn3RwdfjyGAp2/Ke9ukQWgK+C7qPveXT03ZG28TLQgFG0V9+HPseGVep8wkX339ItUe55m+/5H84lEu9714PvhDXo/O5jRY5n7gI12y6DWsezJngE0m9WLliksJnW5vNR0ry0aRJUhPbCptbgiPECqwAe/1Lvhy053eqK2jGql45/9e260666jrOUtD4G1zqybtGekezAKh5yysTaU9/sKnux2o1BoGXxkMKqrFwoscu0pu7oABKWly3xLbBPEwNNDyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc9YVJilcupA9pmwEo5AjWmwYra46BWwjKr/918sM9I=;
 b=bfQxCYMg6lbaO2csilyEhpuVCU9lYjBYrBf5egqozVfLuGQGQx8mxnb3qBBWIndZjf3MgA2HRExT0Cp+dWYvjs81NkEnj4u6fB3ms4G36+/P9nT+cvN3cgrpaTHusf+0hbRScR0vJRVJS1U2XvTZRjOyHj6at0VD/bSufyYPFDRU8IEdLNP8d66mMr2MyO4Q3Lo7TH7/EmIBxQRx3ALFUPZ3pJQQEBtUyg/+DySFKUaWcTOq0g5b6mj+z2LNTcH1ix91gsCJGnHem8+u3JE+UaCCxBYRpFewAfb7EKt1QC8IeNfdzBIld3Pv+WE0NkCrD2JTEPqeTC1P0LM3VtN4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc9YVJilcupA9pmwEo5AjWmwYra46BWwjKr/918sM9I=;
 b=GnHxu4gN2BVH7VuXw8VhaIPtRMk2QUXMdtrwjKrfkGOc15W6ff5dGv+2oQ+oSlHXiDd33KKKWkbI0JSumVoi7IyMYETizoCo+FFhrllB8otKAzR+GxZAwol9G7UYnJKga+tfJ1c45GlPeNNlYiEDxwWBBNlk7WKwK7zd4V+FZdoUfxMc9+VtwNqGfOPJ01FF437t1sbt59TSoJXtkRD7Zg3QIU7/IWKvmb8wazhNJ8QzmooCDu5TWlcSn4oEaC+xK1TjtgAZN6oxw727rTNjPHuS0s5xoB2CmLX4ESNzHDWBXYb64vPCa2cMos4m18h2DNiWz7rRNlE0RPZlSZ1kbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Thu, 13 Jul 2023 03:36:17 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 03:36:17 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yufeng Mo <moyufeng@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v1] net:bonding:Fix error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 11:35:54 +0800
Message-Id: <20230713033607.12804-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: cf575fd8-ac0d-47df-628c-08db83525098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6dAVVfkoRUBMkU0X1fVZmi8tSKPMeAaZFPxrato3BKHxDbWZE3ltMFLBSIJ5TUTun2ZHznexeUIAsyF7H0qRKhBJsXghRTT2XwLiRhcmfa1j883syHSzhjJzXDADuzx5Ne+xY+pZ2vzIFFiBeCehx/gQAIa4wiZvFm6SAtIddulTW+S0XZefv2lfrjgq84NcNkbJBBBU9WL9K2amB2jc+2mAQyKO2sYY/cfAFjcoVv2hoSJE+oiZo1ZOl08ZjHlUIXaGWQtdWiB7R7bwwWYABqY1vheN1CCdVsk6V4ChnngerLVNSBMbcb/sQoqR/IdeQMB4A+NnphDhWJ+sgVYcI4GqIK5to/iLx4qwTsq1GFW6dzpcYsYY4FEv+NGUUoT+bgyjQlVUp1ZoO1hy8EraE8Wdro8AIFEU7O0BPaJmFAXkdeQGLL04IFevIOfi9getrDRgSAhQr3vOrTEMBOmxaoItG43Tv45uMP39uNFD1JdVTgXo8c53mcqW5v5TXdcp8h09Fc9OOwwEgeNOx9BqY4Z08xe12WENIIA575yLgZsLoDqyVHWpfHT6XcuraOP3ioObH6t9aptxw3dDQAovv3LV57pYHPQvHGKTfB3QrFxDwBOpr2Y0LTXgHC7kT7k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(186003)(4744005)(36756003)(2616005)(2906002)(41300700001)(83380400001)(7416002)(26005)(6506007)(1076003)(5660300002)(107886003)(8936002)(8676002)(921005)(110136005)(6486002)(66476007)(66556008)(66946007)(4326008)(6666004)(52116002)(86362001)(478600001)(38350700002)(38100700002)(6512007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34KInPvA0g6483uUp/FL/ePs3lWa4tlZ1KTqgyKBctdzPD7DSdIEUm8i9Wtj?=
 =?us-ascii?Q?WEd3dH0yNYwkewHRoFFb0NsAOYUNUmEOjR4sgPakD0UCgCA7dJGiSf4wHIKV?=
 =?us-ascii?Q?FyGpNRYxPVB3KZahRClzksemaoVpXToJPrn1yn/t40eCH+pJv+ngbarJbPLI?=
 =?us-ascii?Q?hfAIkvA1jjmwjcWj75RZIcvYqc8iZ7qo/wfgqHfDbv1YbdwrpzUXCm0UIfus?=
 =?us-ascii?Q?6jRmhLwEXBMDDc3w+oW4xW/fTf0mRIZeBTk3gOO0ONVhJHIPEtyAcQ37RB1Q?=
 =?us-ascii?Q?29w0yGz8UEJILvdwEEjPcSFdxQPdZaVAxEK9t2fYtK5ZEnCSM0MIUE8X9PjY?=
 =?us-ascii?Q?qIMKLyegtNEEGVjOu/Z2P23AI5Z0RkxQa3HP43nv98zNXhH/6xH6+ipoXr2N?=
 =?us-ascii?Q?V7qUW5r2BG6d1ePSP7e5FTIrTWEVhnEnhzdADy8FiiyiNTUfaBde/GAXS1sT?=
 =?us-ascii?Q?P0jx9zD4cRjnjv18TBIms7z5M5In4qZX1pZooVwgdManfngFyXdYdvf0YvbI?=
 =?us-ascii?Q?pckm/d+aTmOc36yrMSeUTLEj6EZUVOO9i6ls13ND0RPejWusrIH2nOB50ZWD?=
 =?us-ascii?Q?F+g1CFhb00Mpr7poBCQWcmg6ywtFD2IKScO5S8XcQDA5quIusDisBs2C5cvM?=
 =?us-ascii?Q?1wV+9aQLNTeuGgQq8oA9KtsWIPs6Ny/N2SaEkJRa1Fr+bnMT+1p+GXyj67hc?=
 =?us-ascii?Q?Zt4oR2c0G9BgNnGUQc5Cb3LABPGHNsBCTRMAJTP1TE56bg+xps+7f/O6LXE7?=
 =?us-ascii?Q?kktkc2WWEQ9Xz1Z5cauEWqBW4zoolVLMqmNBx/11NhK8xxPBQTah7scNU6wO?=
 =?us-ascii?Q?QgIGxmQiyfIIfs8Y+/BmnrchQG8epL/U+3LiZRn8Ek7oybzyzRZNXP9ug4MH?=
 =?us-ascii?Q?wwsO5oUZI5BCy1wscUNO2uPPX/LxTvbPGsg7nzc5CmYNA9YXesUAtyDZzvHL?=
 =?us-ascii?Q?KG0xxN97/v1Qrs+FTPaVckzCTAMybP8CO8Qzx1km8j0aNozxhbnBbmEwQq7K?=
 =?us-ascii?Q?RGQPikl0ZTbP4n/iaHN7KBAP2ZOYuvZQHT/jfVW9hMpvEY572bEqM3IWAsoY?=
 =?us-ascii?Q?GvKaeypQEdlXIsOSSTWAy98+bho226eSD0VkbTq6OSeddtws42HrC6Zqbd1v?=
 =?us-ascii?Q?3z4Og06HZ9wbBAPS+a/rSG1ZDjwtxa5cyPNYqWPqWSVvjwbY3926SdujEkPb?=
 =?us-ascii?Q?jA+hka5qjv+7TJrdYbDeJK9CicduKkT40iTfIRTRw/hdpdmWBs/mGQRk1boJ?=
 =?us-ascii?Q?nD+9vefS6uE60Oxmr4aTOzWRUenAiK+vhp2W0xc9M3ZNe2hkSmsMIGwFyXaa?=
 =?us-ascii?Q?yLNPLSD1Fu8zIeqGlfmHJbT6HQMS0nLorAzC7J8PRjYsn16l1Sxu1DorR/FN?=
 =?us-ascii?Q?aIdexPFZFxyLx+RQINW1fSv88oql32mNDm6GUPYKRQbqv5yyteb1ox9D4sJ0?=
 =?us-ascii?Q?6XGqXo/bKhnfZWWfZhWmE9titrutxQ2oNXB8M2ZjCJwiCWh5CP/SRmW+vpVn?=
 =?us-ascii?Q?MCfxlV8lqHqZoaG3gKmLJFdN1GhQqFw/ksKJeh3xX9y8DpnanceIaST8OY3A?=
 =?us-ascii?Q?LDSq/G3V2lwI/ZSQWzhrucA2/705pRCXLFZcg3ri?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf575fd8-ac0d-47df-628c-08db83525098
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 03:36:16.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dtRJZXkCtCb2A1YQfW+7o9udPN6R1WBwMxIQL9ugk8h26i5Sdyw9bRuFeAEoP9VWHGlCGbPhW1u4JHrpJoVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in bond_create_debugfs() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
---
 drivers/net/bonding/bond_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 594094526648..d4a82f276e87 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -88,7 +88,7 @@ void bond_create_debugfs(void)
 {
 	bonding_debug_root = debugfs_create_dir("bonding", NULL);
 
-	if (!bonding_debug_root)
+	if (IS_ERR(bonding_debug_root))
 		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
 }
 
-- 
2.25.1

