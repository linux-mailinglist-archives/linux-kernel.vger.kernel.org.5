Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE79751A37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjGMHrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGMHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:46:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54627B7;
        Thu, 13 Jul 2023 00:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuKYXDyorY0QwBOI/+VlLBpuGtMk9zCtL5+8cztDkyDajbrW6eJ2YLMOF3afTchwS2JA9vZ9IQfQm97/mTUSh88obZyujENmzki0SEzBnAg8TUxaFaMkScAJ6V3a3vZO+j+P5NtvqKKzOn9JF9FKOZ+QZMEICyLEPwMzhIk5uvh5z+BvoxOCpkqaSwUQw2fwHVMJsKzr9ecNwOg0OkH5a6AkfUhwql8aRb9IUZjYk81ua+BFY7f6JI7McOtizoXNHW4EH6AnR3SjU3lYn/d3yP5faNxXS5GssSqOisoWr9vTRbwW6VaGfpUu6YxM3PSI4LPkQi+R+S/aKzA95a59UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFVcN6Z/bvdnA+549n9s8cmHl4AdhVjhKxg3id/pKBs=;
 b=Mf1i6+LIWHSGX3/rDCZ+zayiIEiaRKKgPN6rrcGx01Gr1nlbB1Y/YXNQovq9Mo7cE+7Azocb65DSybtsHdmDopBQXgGT3IbgNJuN3KRLJWX9+QPuTPs+8G8bks7hSgQdyeit7OHyBXVC9uO2jG5sJPzXCQV06GDn5Dx+tuLFZdcRZesQY0lDTBiELhB2BnULKt5bV65xFKGguJkDDR8jQRtoyn9hU+TONSXbQwfl1yb6NZn9zCEhJUMV0wcdomwSPfRNR/2O48qct3M29XYZnJZUcx2qTwKqLc+O5ja3IPnpZ2demhGtH/GQl5q/PScLWEVrwuqHDKDU32jQimLBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFVcN6Z/bvdnA+549n9s8cmHl4AdhVjhKxg3id/pKBs=;
 b=YNoiqYEmqOKKPTWwhyQ3zIKdawSQwhF37EI4vPIz/B8RfNHfoIJKZ3Sbuy1uRjgH3zIi2FvKyWgYythMXDqXIeRo2Bgk9Eu0sGLh1c+DISDM0/FVNhESJv3xfi1+nK4BQPiSJrk8IOrYWWvPlMb90DrXfa1WlFWu2sqHEf2/E0ur+np14+d3bVWjWxttAw5hK3m38jCkJ/Us05Wu2ez7iW5FI3z517yrOBD+Wgr16lOn8xvFcFNJxZIuDTNQ9nwWGuPEfyZnYs31uD5VuhZY6YzsO7/nN2YFSYFNtuTv/Qjcwz7lL23zApM59EUSDyTqkZsjLScGy6ntdItYOXCL0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Thu, 13 Jul 2023 07:46:50 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 07:46:50 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v3] drivers: wireless: ath5k: remove parameter check in ath5k_debug_init_device(struct ath5k_hw *ah)
Date:   Thu, 13 Jul 2023 15:46:32 +0800
Message-Id: <20230713074632.11204-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b4100-a02a-41c8-88cb-08db83755170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zk0rfaKbr2xzOnsQjOR00bYv0yU78RQunqbcJkX8vr1SP/ocYQpD9VnZ3H5Wy+LSUgM8asCX43+HEfV22T2MZVoZXbbhhGW3GW7WTC5ITAciImRvokFdeZd6D3JlGw+dChNRfhOe2a9Xjk0kbmRJ0MSHqQ0GTZbHe2WdewDJqHPkNJSTfjqkLdw6kfkBZpwXaomBup6+Lr9V1PVzvMybsbjU3hR7S0VEFU2Qj7O7UcudUlGSbtqHE16TnOaUd4jfF0Lf7oGCwMKuT9/EhUknjAou88PZn8Akz6XaZVLwp0wKs9O5IGrVGc2bNscRlds9vy7eFg0pidj5pfEaH0JTwMn8AhzjbQQP5m4AK01DE+wO5TNRF5J0UlxnQr7gqiC/0ZpY2q9tr6Lwkwayot6Nle7X4yaHqGOhhpwCxr0TgMEMz/K3IrAVzpwx9rn6WxpBU1PrCqQ/K5bniiTreSsauYckpKqbUyvdmiwsxOxNnyHj9LIsNJqyJnOiopQ2W809lmG9zgsqH6YkYRrODMoD7G9kdJrUK6gu8Dg13XQk06b7PzJplm1lOPjbF2ckVlSrZ6JwJjFJIG7eVH0XIHMQSUq95Iig5POlBy3GFhBGWm3sX0syHUcXS00U3rk/Klp739J6UG+NOyj8VM1+XQdIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(110136005)(186003)(4326008)(66556008)(66476007)(66946007)(52116002)(6486002)(6512007)(41300700001)(478600001)(316002)(6666004)(8936002)(8676002)(107886003)(86362001)(26005)(6506007)(1076003)(5660300002)(83380400001)(2906002)(38350700002)(2616005)(36756003)(4744005)(38100700002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERqN3R2Mp5QXk+px4402XruQk1EU5w0I6g9JPXLB40bwoBcBZMznAnA4qM+v?=
 =?us-ascii?Q?WAJg1M6l9m7xvhuWdcW1r+qFXfp4UBhjdzugZEPXRK08kgggde1hjxHIKkjf?=
 =?us-ascii?Q?YN9/C7n71hI+LXhgDPpbWnvFu/jYhYmN52r+X4uWw5asvrlHiATxpEUTwmRg?=
 =?us-ascii?Q?fAvPPbGP7eQQCI4QXPyAJxj+C0NFyYC7lNuKWPjv5YYSOe4f5e5sCa1MRIxS?=
 =?us-ascii?Q?dG2w38umiWYvUsYQDZNVJibT7mFaAfH3d9kTVUyCN/uWe2vetUNJPXjPdEm+?=
 =?us-ascii?Q?A7j+iiaXONwbRViTcHoZVnT8ulgz44GNnDK/qis1E7XS6DzzhJExY/rPq2Lc?=
 =?us-ascii?Q?BwZYl5mrdhf0A1yVGsFOT5EufrrF+fgNQNU8+GCbIW+hd4oW5DWMSbwtZtnM?=
 =?us-ascii?Q?DAEumKjF/yopysXeHgkfCBWfhgOhXxxGf8M50EcHNm5MwZZFkTuLrUgL4X15?=
 =?us-ascii?Q?NX1OqIH523rW3sLDsoET+9HgyfRJoFWSE5yKmWPt9EbfxX2H/icK5vJ2EZVt?=
 =?us-ascii?Q?555a69HqWecQE0do4oVgeGZEPxUUFmFDB8lvnskljAY65dlS/8BmJdo23Hrg?=
 =?us-ascii?Q?s8MjqjQ9eGAkNcWdK0jrfsKq4qZ9QFI4h25o1Sa+egB+Rwas0+8dqNjp1IXf?=
 =?us-ascii?Q?8Mldh24o+wbJ/otnA99hTs3/b02DmEwyzSp+F1orHkUkiELJWV5HhaD9ARTc?=
 =?us-ascii?Q?8kn4lVCQbUyELbu1z8Bf9BQaWgFbXQ710WjSgaVuwW/JzLGV2Nx/mCW5Imps?=
 =?us-ascii?Q?DkZ6Zj0TMhTboyo3v4rQu1TWBnSDKB9zlq4Arhzz6SB1PncIbGi7jmyyJkaM?=
 =?us-ascii?Q?rngJcQsxF+6SaNXsY5LOF8AJcG7p/FRYo/bbnNJSxp5fCHTlPjejMkVC1uZ0?=
 =?us-ascii?Q?dOnXMWiaiyLaaWS8R/W83u61NnfXOOaX53+lbkXjkvmDHWuIXDAISMxS5V8V?=
 =?us-ascii?Q?C1nd/sIhe1iMH36Wa9+VYlPaA7JD3Y7Kegu+SoBZ7x6rNgSzUMU0n+N7cFvq?=
 =?us-ascii?Q?L31qrB6eB8fHBPDpkQ09WKDJOGOVhvtIk7IOIN1/1KirnvYIMwvpQQMPHaEg?=
 =?us-ascii?Q?1tPs8e2MWk54vQSg3JPWaROPqjlcTROr3MPB6RGA2ILG1Rdf7ctt2nyl2CAk?=
 =?us-ascii?Q?93qOwTJ7FpHX3qQmD6S04XWM8vKgUuPwlLYqP4NYb0LC9DBNAsr5ddD3hL1W?=
 =?us-ascii?Q?aN86Z/OZ93ilT0gtbz2qMjQgpJngFgCWVcuJmPjNReOWSRk5klNLzPqxQPsr?=
 =?us-ascii?Q?HGsA8ZEatJGMCsr5rsfXHW1ktQei9C0z1wXuhkHn9NFOZo8Dnx98XLajsYBR?=
 =?us-ascii?Q?Bk4nE7oa/jTSctcXsSjFgOqYiApm1jAkiTFBqLusiBK8paxxKOR3JS63KVPI?=
 =?us-ascii?Q?CDk+UQiVkCc/CoW42jI7yAMlX2pnFmXfTKJNtOfe0omlxN1XypBzrrewPi2M?=
 =?us-ascii?Q?+UdxBD5Gg5N4LxIW3OZYXfpbRylqbGcTuI8PLLjlAMpvpu/Xth6YLcz/jdps?=
 =?us-ascii?Q?AAahRMuPX8AtH2D4FS5vltJrlRsy0ZaGzjLHhQ+l1PIReYWWp5fsh4y6gnzT?=
 =?us-ascii?Q?/R4DBQuRg27JTJa5gTKfKaw0uCYkpLAknsm+1n/w?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b4100-a02a-41c8-88cb-08db83755170
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:46:50.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKPkHnv3xtjLtNlSV2BOSvlkc6+NxG5e0NeHJVZfsZPZVvH32LgCBsILpADwjTnVkZMuSkP0eI3xiH7RaIX1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() will return early if phydir is an error
pointer, so an extra error check is not needed.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5..ec130510a 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,8 +982,6 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
-		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
 	debugfs_create_file("registers", 0400, phydir, ah, &registers_fops);
-- 
2.39.0

