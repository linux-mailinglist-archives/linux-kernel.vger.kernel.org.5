Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C4751E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjGMKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjGMKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:04:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7822D77;
        Thu, 13 Jul 2023 03:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4f7To4+Im+Hy8cceSwzeeP6cmYqqp61PxtAZhLgAU9jCnaM6hBbbnK/AcxI2E/VU5+MtMSLP5SusmzL3nY6fsxt/WeZdD2IUuDa9igK2R8l8+4h8qFpfg0AGEqwxZRKVeNxCCuhJbRfrhtkwYCKztg/A4+J+O9WE3Ud9CbdMeOajMjYxj3r9jVKUlkEyUfPIyDWDzK7h5krRejFG3LRbFScZW3fXIJACkarTsPokZnglE+6rHM9xazt2xZEU0dXwTD5TiVASNAkhzuKxXZr+wWBs4GWD7Rh55WzdNzEThiBX67rcfMmbS05cXmAUt/2i/iztJiF6ewghp8gXn4KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=GY62QE1Vn1WKoASGOp0U7dFrAeTZmCh6q4EbXvcp3EUG5fE5Y7UyQp3N9fPQroHgYnwqOQaJSUpwjF8iI0pjTaql8L1hGOhUIrzdiIye37iCwvZddVMlKrAKAXVDgTZXuujbY3hSEdIoxS3Jp2ICsfd8JiE1bQ/pJO1030VL/SEDjMtOFDD4RPeLEbyMqv8fa+KCFuJT6pmrR68PVJID5TqynE7ehJznxapuun6r3NHPnEL84c4IwUmvRTsTL6ET2gsz0pqfYUHeVaTXgo9zRWSOUL9aAU+5GmRUtuwhP+w1YMpja/GG7ZGxthkibx5CICLUjE3BD/U7o6eHekyPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=T/TGsjv6ab84TbTftfekYRiIrR05qCp4tXQqsG7P5121F7UbeK4Py8Z1M+McRUos6orAM0qTWgFJiB2DVaR44IS8PcuU2T+UFGCCKwqZ7YEnJBri1tSkUMVxbSF3yf3z9FlawtYyfwURD7E1NdkzdRGFcpIqV7y9k5lw4B8GWVMOZTLRApVUPDSaNKnvjIXBMcCGPrg9b7zXKSLUcFubq5U4kiNd48797yQj6bqMiS7XOQBU65AOiNIaOXKuKIZmMBmspuMUh5B8rKdAj8LfbYJ3nSTpsu1b1URzwa0Q2q/6l4WyHGU71jDXys/r3DVbmq70/beAwcbqrwlUpR3zwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SG2PR06MB5156.apcprd06.prod.outlook.com (2603:1096:4:1cf::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 10:04:23 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:04:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Wang Ming <machel@vivo.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, pabeni@redhat.com
Subject: [PATCH net v2] ath6kl: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 18:03:51 +0800
Message-Id: <20230713100404.5096-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SG2PR06MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef88f88-6c24-4adc-0121-08db8388883c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8V7COrDavDZQRo93gBbFI61XcD2pzCmR13t7amrwcaoDQx+K2o+C3wY3rLDA10YiWmit0wkxRU2gF5ZbtXz0SnllTfMsqNVMuJaS1OLSIHlr8qx64Up6Q1m12ilFJ5UKoRG1NlRwTDBl1s9qtlPiLT0MlzNyZndrrMD6H+/MO7QUsYPq4O7G0hXq9noAtiUZE3vT6Az5xM1K5xGR2CRoGP5P2x8USnW0u3c+8bJUaY3F6+8d38+9+oOadYp88AZu6esfvGLX01sLZbut/aiRQPEyqW/UTOMkEx281gkVjwfQ+ubVd40Fu8F4Rk+qAWW+Vw/Sb6LRFBzB1atuvnM4CMUWGc7O1CRBZT4TQhDI8J6k7ev7k6H2yshTR1ncrO/WEfS48hPfM5Oylx6vQEAl1RX+68WjsLVpSlrRojUjiECjdrXOaplRKiLhEcBdE/wYtB8v+sGXT9cMymlOkra87JiPiipAMoKm9tNNR9Gru/kGJ9P3uCdvNJBxa+iKuWVTSIu7LKGXaXL4aW9eh11wMUJ18YUwCaoVq+3ZhpZQkI+PzwzgQfgLZeCnSPZZZlU4JLaB9AsXB4KT2zaUM4ZNfzejtKoz8gX0eEwccWf4+Xfj1KVW86kp/FoZvnQmockO8z3UbwASwUifQuWTksh2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(2906002)(66556008)(110136005)(6666004)(52116002)(478600001)(36756003)(8676002)(41300700001)(8936002)(66476007)(66946007)(4326008)(316002)(4744005)(83380400001)(38350700002)(6486002)(6512007)(38100700002)(5660300002)(6506007)(86362001)(2616005)(1076003)(26005)(186003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?phqUQmTqVEr5idnsd9dbyBwyEAclxOvLdLF6fW2aYZ7NkJVRea8OtXIUGCat?=
 =?us-ascii?Q?XSwCj11XLWJmEU/sGdI7BVwX4WRBwMH9FG+/R4nQcL6hL5eydA/xF3giNY22?=
 =?us-ascii?Q?BR+/nSCUSDcKzT/B+Kzi0YmInJaU3YIptDdKZi/2TvXMen3Pjil9Y+/48aQw?=
 =?us-ascii?Q?GWIunWboFqC7m4KGEZJwQbDE3HPhhKyibZUpvctPe8Qnc5RhWxOlnkNJnAhX?=
 =?us-ascii?Q?4wUc7lPnnGUnXOKyAjHvr7lALe7a0yf2TAXuJ/n7IGx2+1io25fmVlE7v8an?=
 =?us-ascii?Q?qePpugHh7jjGdV2A2w7ZSxW69c7k2znA3wBVK9/TG2BXFjAo+R+woK/+OVD2?=
 =?us-ascii?Q?HR49EIGgDpxx63M7+7u8n9Q67FaPIWrqceNFwfMdKtL+AEGuvUKdzAVWpHMB?=
 =?us-ascii?Q?jKbvTn/AlvlGXj1BW9MtEy3pNLNCKPXb6CZ7yr7RMR8Dh/XYLo48hHtdMbtZ?=
 =?us-ascii?Q?Ss6CjZcaHweB6KCBKOlJ9bfxS0vOjS19Klde/p3LpiNptJJoMC3sRX+khCRA?=
 =?us-ascii?Q?7rPyMEu4k0EQ+PaN1+DZCkiaowbPGZHHZuaJQjhBNVYCYj5idLTCexXJoZV6?=
 =?us-ascii?Q?b6zh+SPEanUZ5LG/23ghONMuUN+G1jsXqHdzD7iFw5POVeHwLdwEW1IwF7dk?=
 =?us-ascii?Q?HCyF+DxKClERufGhgbhM3TSFQ4AvcPBx8esdOnW+akhBW3HXyWlioemXcFFq?=
 =?us-ascii?Q?qmCENTOZc38tL8K+zvCzmj/dtgzG7hzNuKxqr/OupSRH+50WQw+/lVOtQYww?=
 =?us-ascii?Q?N9kglg1yeT6boe8J0UGs8N394Z5hU7cjnqDnHfgapYFcqr7kAS/2um8P6R4Q?=
 =?us-ascii?Q?zwof3g68noUZvmTvUhb6kw7ynQY7KYoL6jhyXqtwgkPwt1JOJlp/UvNBn9Sc?=
 =?us-ascii?Q?BvCLeobVjn4DWCVbhtNO0MVum81ZVoD+MaP96iv9KcNXsK1PrUoXXj7GYJTZ?=
 =?us-ascii?Q?MjffDGTO3IX70fxl8o2yQvopSUCDN7j6+Uz9jcyz5jIGrMKu+mbzq98RY1Tz?=
 =?us-ascii?Q?PXAuiidYwRsG41q1U3EncN6cZCACBbB82ly5Offf8UnVGD3Jq+vtWE7p+Tbh?=
 =?us-ascii?Q?bCunjqjRPuRfKSewp6Fxv7vhjfBPgM4WmMA8R+gb1IJ+xvvB3bZY/1/9P0Vs?=
 =?us-ascii?Q?1i+ZFyEz56TS9DZ7+lgKBT3VQg1jyMv8K3A6AgGduX+EL3dPQ88oWTow6EZA?=
 =?us-ascii?Q?mF3XLwnKH90WfV1Wzu0BjffKy7dpa2YWJFPDhX3f7C9GwW6r1WPhS1K2jjbO?=
 =?us-ascii?Q?fM3czCAE3ra2dj6F4bXfG1FXRdT+KeX3IHiVfnKL/4pPuy0UP0Pbe8EJwyHo?=
 =?us-ascii?Q?zWjpTp/NggYNNhNsIlqXXiWcoigF+pobKZyXtq55zTC3q5ZP2AzNjOhBa6bZ?=
 =?us-ascii?Q?Lkzu15ZKRi+5OYinRhZs7dr2An88Hb6qXjHpCu2FxoKqzJ9JRi2ZjUNwYSGP?=
 =?us-ascii?Q?mWs5zLDTmbkJTMTsXlGfH/E6Li9JHBVFxX1xsh8qy8cY9mJjoRhLSVx5Gx0s?=
 =?us-ascii?Q?B5L7AoEg8uOM8yE5feKzb1a3ts5T2VP6yO6HEcJyUvox4QArRivxygOjAsHI?=
 =?us-ascii?Q?P5k98TKWJ1tuWwXsbJhhBRnwW+klF9UOmTtYW67/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef88f88-6c24-4adc-0121-08db8388883c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:04:23.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uq7UvdbTNYn4YVxK8zVS3EHMC49vnWMykP26pM2SWHH/R5L4ks7qxvgeNTzhpMwKnQhBSc+wX9dAIv/5xAdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in ath6kl_debug_init_fs().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/wireless/ath/ath6kl/debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/debug.c b/drivers/net/wireless/ath/ath6kl/debug.c
index 433a047f3747..b837d31416df 100644
--- a/drivers/net/wireless/ath/ath6kl/debug.c
+++ b/drivers/net/wireless/ath/ath6kl/debug.c
@@ -1793,8 +1793,6 @@ int ath6kl_debug_init_fs(struct ath6kl *ar)
 {
 	ar->debugfs_phy = debugfs_create_dir("ath6kl",
 					     ar->wiphy->debugfsdir);
-	if (!ar->debugfs_phy)
-		return -ENOMEM;
 
 	debugfs_create_file("tgt_stats", 0400, ar->debugfs_phy, ar,
 			    &fops_tgt_stats);
-- 
2.25.1

