Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DEC7F3F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjKVIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjKVIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:03:05 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2062.outbound.protection.outlook.com [40.92.52.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF5DA4;
        Wed, 22 Nov 2023 00:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcAh0th6Yn953mf/SJO7vCti0Nneyir80PdfL09yr6QCE94PJoWo3PJ9mAsyFEjAfdNA7gJLTYuvF1dHC3WXmKRU1qBbczhpOiNvJMiNDTbOkWiO1tpdCrVpNgBfPC/lnU0lW6tuc8/a7NRFacYV8/c7GsFRnLEPZ4vOTkiHXtDNAgEQ/3vEcv0DySbL0u+1VB9fvQINgFU3cshI0xzG2e2Y1woWTqdBkrVi7WWNlDu/hFJc5h2UfMTuCoc59mzKdo/PaMMZ1Xt32iAi1J7YDT2qlKO9bJO7Ytp+wXgBMhLjLh1Nhmb1K6Wx+B5KHyrLLNEc7zMJo6EbAPEWPflVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQQEaRF8A8rVOdlFT+IbAIFqlh6jkpp+C/3unJXSeT8=;
 b=Crygxv/t5/hIKCOzn/f+tbvN7365DD+OF9sn6Sm3rXkc5BCmLJTlnK4HSniF/232fPow1zpvXl41qud69ni2cR9i/ouaXG0hL11L56xgnsb1/GqLeKwqD8HvaJ806E7hbFQ7B0GWmkLGG4mSG0A7x8/jtiuR6HTg2LbWtSQcGuDOIyfkCNYlSYfeWtsdrJ0LDICU1RDekzpYaLTswV3fPKk3lzMFN4Y9M/PU2PXljWQ/E1xY+5H+3oda6S37v8K1MDPYR1ucimmlNzu8dFDMEhqOYoevLLDKPE2XPRPPQE9EeBJq9A2ZWKzZPZfS7VGTMNSIFCp/UbJSXDdTZEi7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQQEaRF8A8rVOdlFT+IbAIFqlh6jkpp+C/3unJXSeT8=;
 b=Y7aCcm6UTW83RAoACYkt1oB+xCZGQgOTg73N5oRdvsKRFHM6oz0YPyDPlwcs347gDoa+GG6gMhd7XmuGOutwf21F65Zn8khdMAfnm9fYyWyf5N11G84ROD2LU4vtZYN7/m7Kt6Hzfmqi1QqaXG8oRjC2CMXID7nroqbjcSXQTuOfTshWFht4h9+t+RY4Vol1ihrL3QnbMlCBx6bJ/yF/qL095joKKdtlaGknSeoGnx2evAIasx5zKz6EZmcHKbijsXpZSnRgn3/jvAGgRH3lYHiaRCMgi1FT+DjsyMpxFWVFb+jFkFC3RU3t3GFct1RWMbLnUobKxrx0J9b34rFh0w==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by SI2PR01MB4107.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1a2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 08:02:56 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::5074:605e:7b60:3ad4%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 08:02:56 +0000
From:   Yaxiong Tian <iambestgod@outlook.com>
To:     michael.jamet@intel.com, gregkh@linuxfoundation.org,
        andreas.noever@gmail.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com
Cc:     tianyaxiong@kylinos.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt:debugfs:Fix memory leak with using debugfs_lookup()
Date:   Wed, 22 Nov 2023 16:02:43 +0800
Message-ID: <TYZPR01MB478461E6616835634D0718F8D5BAA@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [UdxTRkg3KOulvY7VZBKJUGA/4qo4YCIB+yfNLU+rzA0=]
X-ClientProxiedBy: TYAPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:404:28::35) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <20231122080243.210515-1-iambestgod@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|SI2PR01MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e78b29-1b93-4a91-cd78-08dbeb316f87
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHNu73SeTMP8j3aLxqxbV9qVy/Rv3BtFKnb7squUrG+rzqh9+ZQu7WiIAZ74Qi51vpCXaQUJR27yakIBty0ORJciVI7cY8G554GHO4KoYy4WVEvyuu9IAENuHsoZV3SeC6CJoJIyqt+QVlmeHQmP5lcZlEINcbKwZDjNCpt78jhdhySAlBpTd3oFVv+lTJYg6vTCWTnG5rtyamYpjXlgQ8YuwS019KnMaz+cbAbLwQO+vZDE146cuMqZLSE3/x7lmR262kLDkmXzm9hsunaLIfX1s7D6ZFAvxXLTzpRnAc3fFhyyM0WfG8vogbU5x5ZgaVy3Jnn47bnEUmiOO8zQr93Y4G1p+ibi49kKKdPwE09w7fF/xykFNPuFtc+pZW0hdDbmQaB5HQslFSE/uGsbC3SjRYfjh3iYkRxNlZ+LAnar+Xf3dm+lD+ocyMAiEE3oQkHscE2gEJEYFUYWTyUAvuawsvnX1uA16US7mBzuM8S9W9F96nQwDsmZU8e6+6v3zvthBbf1d5l2yHf9Bve+Y1a7q/Z0lyOW3R1O+CDQj7krmqU3qrvX5nFDwDcGCI7p
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6KbZPrwiej4skaGMc187e0LsVXaH3hPoUm5gP3cdtrQr6gYfwzoS6JvfjVb?=
 =?us-ascii?Q?2pIaHqRX/gMCOMYdjbtF8EESd/JFPCMfZNN/9IhUAdSb0ZfDH6Z5dcaG/9Qe?=
 =?us-ascii?Q?vEEUuDYrtC6kycUGVJtMxYk+a3OXRKu/nr3mQRwo8gSTWaCrn3LTnP4ZNUu+?=
 =?us-ascii?Q?3j5qyA59mZL9n4YpWLQfSpuvGycgF8p0OBOEX8n5SlpjZhuAE7JStacMnCu6?=
 =?us-ascii?Q?mIgA3r7ZTEPqFALqUqdOEJGLa+q2fZumEYoyZSBvTp+S4yFGdWakoRAXoAs0?=
 =?us-ascii?Q?xvXJu2t7aw+Ef3H0HAuj7riP2qa1KQrWv8wqX4sPCbT+mJ1BNIlbAxSOX54U?=
 =?us-ascii?Q?vH/hYv4aWYsEjZkHbkGF4YVGSttZY/1A2QBYU/likNFlZlJgxopt+zXtHVj1?=
 =?us-ascii?Q?efi8Nbc9D9ixRd8++LPm7wvgXzxoO+PsSivqmZ8dJ4yPl3JUigHfRa6Wx+ed?=
 =?us-ascii?Q?er4x1lGaZWkEachF+JWdHaNcJJrnBFACMcCt7e5Jr4qF9s6Ql1qf7KSuBuMh?=
 =?us-ascii?Q?o+M8c2fkaUj1pNUW+jHo3lyrh9PgHQ+P/0IeWC+HntumqfNV7fqjfya1mr2g?=
 =?us-ascii?Q?eZLRR7bpzO8v1JjsLRDaXEHWnui5FfaGNNjj21nipvlzXBjayfciLn6ZWZjR?=
 =?us-ascii?Q?rYPF6l7ltFqPoh9pRxzgxnGjtCQOx2YT5HpevXa8AQ4f8YO5daJiD9gyoPPz?=
 =?us-ascii?Q?7xQZ7c1/ONDN1WGODFuu2Ohq3HCdaaM3V2iJo13ipCP6p2ZmCFid0Jtr9G8e?=
 =?us-ascii?Q?bRoykVfwOEW9ZCK2C0B0miL1RCGBrgbENIw2gjIdU6ii7XN2a2WUkfb/FlaI?=
 =?us-ascii?Q?IC6rUUes4iTP1N56Jc46voWx4TsrmNCqJEN+lgC9PZIOz8gfkDBQA8ciWPJS?=
 =?us-ascii?Q?LIwjpMTtVPpJlVb0Zs+HgoObK+8g4BkHCBFiJ44tYCJpYN3uBGHHniH70Tjq?=
 =?us-ascii?Q?goc23Q5qfVGq1tg6zmXSJJ6dxhtPruYp0RmvSSMMXT5yQRLuc/cHcjpbHV4J?=
 =?us-ascii?Q?KI28nbja6vLk6YqdiPAsj7cH41xvr8Bv4HQhso3oO5SCWyiMJ+84V8LvYtaJ?=
 =?us-ascii?Q?Wg8zDvpNIRLIWxu84GdWkjqAsXRKzi5wSA+n51VU19DHvpIw3c18+ZBkcW1e?=
 =?us-ascii?Q?2WUNZSMlIOtUtqwHqGVbhgBMBEY9l/VV0wucfqu+cWCTBDeyH8fepzgH848Z?=
 =?us-ascii?Q?kh48CmZC0wVebt8kh/TZO7n+3yzWXpJIvgQrJMEhN784c0+AZM+6eUWW28s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e78b29-1b93-4a91-cd78-08dbeb316f87
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:02:56.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

As Greg said,When calling debugfs_lookup() the result must have dput()
called on it,otherwise the memory will leak over time.
So just call debugfs_lookup_and_remove() instead.

Fixes: d0f1e0c2a699 ("thunderbolt: Add support for receiver lane margining")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/thunderbolt/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index c9ddd49138d8..e324cd899719 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -959,7 +959,7 @@ static void margining_port_remove(struct tb_port *port)
 	snprintf(dir_name, sizeof(dir_name), "port%d", port->port);
 	parent = debugfs_lookup(dir_name, port->sw->debugfs_dir);
 	if (parent)
-		debugfs_remove_recursive(debugfs_lookup("margining", parent));
+		debugfs_lookup_and_remove("margining", parent);
 
 	kfree(port->usb4->margining);
 	port->usb4->margining = NULL;
-- 
2.25.1

