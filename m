Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D87763494
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjGZLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGZLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:12:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD09B;
        Wed, 26 Jul 2023 04:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCW2bkQj+tP6BwA274z0bPCUL586U09fxMCj0bTDc8Xaeyxr5al6PKQEnCVdtckZFNx00EFURVNbFDVjc10UVVkdZt50becBhmmCM/nqakpHLZB7499lz5rAXRPp6fyuUowr3Z2f6zURfOmtCl/AWcTqtIXhkpvCQc2r3SmU0e2jKuMWwaKmd7McWHhAljUdGirzZFm9LAB3vkgJdZYfgiDYpBGDf7vm5NzcDUC/ljneNwLCZNugt8mE5SAzrfCu8gz/yV0lLICONOYsjkMlF3KslkESbfTsaMTldgG41/6bzhObvCQX0Ul7sfef6Eili51oiHBs0OY6zxTTfxHYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=cjkHLKtjgh8Mx615oLne3Pdeg9pXnikFVo5KhSqtu6uylif1W7scfwW0OHqM4LdvK0oVskJCNVa04eOVGzVWQRufjCZKGRd7wsQM5LwDOpn3qNkiw7Mauk8LIhip20aROxekacOoGzGTMML1IHCT++PgMi/FJfiG2M1T+MO+Bz1QwB2ZlbBYBlHkopFoV1Iapzv7BEgh45HtKprmPPC7tbNkuACenqQY6ypENznQWtyxFEAohnUwy6IjTVdeLyOVTLrdG8xErpAlbUYp28Af+TIfSD99LocwWNNaiUox7jwagTlWGdj9c1lp/3a6bajALIY9BXwCuzFfeqi+fYXxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=DnqAPObr7o3AY0P8JvaxwCy3Jh0eeHCm/84qgFkKIo5XPBmqYo+9ZagZnQm+VQKjdAMb7lqA4B1s8xR4IOK6JHhQo6Yhc2eBTXycWe/jqE+ziUw8vJU5PI8Tp1trmPWNQndV4024OLzNgPwJjqG0IIJet86QAV/EE+gueBGx8l+WbnQREqDInJSS5YP+epa/qMFILdmM42KZCmxJ9Whz1Ff9IWh3Dy+yCQ7i0uq2tjxpxZ208zpGudDjub8KjRi+HXc4wyLihKD8OvWYA0ZBQCKzB1B7+th2e0BCpG9ySRODsuEMyWc2CIXzKRAtnRo+HfIHswjcRzhGdolRgY+DoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by JH0PR06MB6722.apcprd06.prod.outlook.com
 (2603:1096:990:35::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:12:22 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:12:22 +0000
From:   Wang Ming <machel@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net-next v4] wifi: ath6kl: Remove error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 19:11:59 +0800
Message-Id: <20230726111209.4096-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|JH0PR06MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ab8901-b911-4bd5-fa9e-08db8dc92f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWmOaqGyipv7gp3pvlyLhWIkvMhT1h5BLOw/TAAN97aWH/aF2NNZPFmNAHygcFlttuHT8UZC/u0rF/4+jgPu8wMTc79IGgRVrdBvul36a4lOtX6CAp4c3rWlFrdqqPB2ERNd0Lyq9RfsDBLjfLWP2XwikIS8+8gwTPU6veWfpdw9GWBeerFRlLiRiMKYrU6A/LsPhkXiLnzkgMXPWNTZPaduhPM4I3tqCc1LuuD8tmSlsGr0m9adgOBdSAeN+pV8K78f9Vr7tmFLT9c4EWrRP7pxAURxWZYY9xi7jbGkQTkwrtzSlzozJHcawcCNz46LRKqbQMpdNdRePKvZT61NvciJv96s+WAG+lA2BwU584ve53PFPue7XgZi1DA3pe3Ytj/2qwYBREpmVRPHkIqglCkdlEzOvz89cxh+xcfN51tWZl5pzLEDU5RU/PvkHNG0l3Rng4ySTkvmH4+wHdxcwnLOeHUbFVZlM7oCb1NOd/NSFE8N2Oy+U+JZ78M/zHxrzMR0Tog/tItkabmqx9Kz1epAhS55MCRR0+kK4SEdLu+EfwucAHjve6OI8ItPZy3agtAiVRBmNQxqbggrB33AF10/m/KUlTUeJt+sxS/5qI90UK+tmWYJqn7XMuQGFIlqw/onJVcn6WU4M3GKLWF3eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(86362001)(36756003)(107886003)(2906002)(478600001)(110136005)(4744005)(52116002)(38350700002)(38100700002)(26005)(186003)(1076003)(2616005)(6506007)(66946007)(5660300002)(6512007)(6666004)(6486002)(41300700001)(66556008)(316002)(66476007)(8676002)(83380400001)(4326008)(8936002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FylmX8upuEXY/48NoQqLwTk6aJ/eB9Ky2f9Bh17EO9ov4x5hOEK1ndjoD5mH?=
 =?us-ascii?Q?ELkUMstoMBGYPrLEs/401h+yAmcurGNEzO0lo+UQY3Yj2j2HBWSKRrYMIRv7?=
 =?us-ascii?Q?eodY9eHJzCyZiiZKA260wsVqAbmWQ7g8QinxtzFMJ824eVDwH5DPdA4VjO5/?=
 =?us-ascii?Q?71wXqzUcpMcdVDLJuLeg73xWA3i35M27MbgjKpKcH/flWoKIE5Yn88NCCQ1v?=
 =?us-ascii?Q?3k9mnl85WMMI78qKLhin2l+SIZr12CwC9nTIRjw6QiZHuGcmq2o6CCHPixBb?=
 =?us-ascii?Q?4ickCczmgZpak9Wa4eqKFiK7ZCCP+pnxsIx9c4B7N3UMTDub2e2y5opPCTDB?=
 =?us-ascii?Q?XDGKhPK+7+DXADaObae/ETnP6WhcHiDK8HszaJphTfz8Uy+d2YgkH+57iHqQ?=
 =?us-ascii?Q?YPU2gdrVn22KexIuh21MqvuXCKDdtUVHRfRqWJdlwEw555c4WqTyksM9oVJv?=
 =?us-ascii?Q?mgkSNK/zdWQ+snf9Cp0u5skCHnn27cWn3DC09t5JqrkEP5MAdrlcLAJHbQ0Y?=
 =?us-ascii?Q?Pde6puYop63LKjai7MOdwE6fygdXh1RpBysb76qd010yGiun2TUuTze6YWAs?=
 =?us-ascii?Q?imAmkaY5/YzWkW2jgGb0hY1T/ast063UEfT0j5XjOWLwVk1PlmUK8lzla4/v?=
 =?us-ascii?Q?dtwX45XOkfG/KEVMbEj9H91wvrMCyHk4nIza9a8J/KPNarJKbNlWK0F8OM91?=
 =?us-ascii?Q?jglML+WZk1urJn7C7nYpwMjPU60SC8n145Kq5AMnsdlZOMYB4o/ta9Zw4cJF?=
 =?us-ascii?Q?69I1oCkZ4macw50HTUYF4nbFFbMfdfpcX02eUf4o/zl9UU4DzVaGXeKjcLPi?=
 =?us-ascii?Q?ClwJQNp97hD6cP4dnkLMO0paGid2tWB3Iq8rnGfVFbqZ/NxtAYLtXqDrRbSb?=
 =?us-ascii?Q?h19zCr0HncMrziyAoL1phs8dIcFZe8jgKiva/gcV87XGmCUV6sfRqc/zbHNp?=
 =?us-ascii?Q?zf/A7lwDMtlW91I3zElIeC6Y0/PoAgtS29pYgipFzk+xtym2eMIm7n5ffxPA?=
 =?us-ascii?Q?cDrZD1CV7ikL9LnvjvRrd3nuZWJJLrMOVfw32tfUf+SpU3sG8oHJNz2sHn+V?=
 =?us-ascii?Q?MpMGWIoUtmgLHYGMOJkxRWlrkgODmmST0M8wpXUT1dvrA2vqTzbP/6F6ChQ5?=
 =?us-ascii?Q?HW4Adyt9PmJqxIYF6EEHdoLcTcu//4Bo5ZkdFF67EaaIn5uKxRAiw6lYrT/1?=
 =?us-ascii?Q?dNxN4+O038rWf1/BszL8Q5EfNe0suElblaEbFa1XOVSdQnjxhVoSHQ2VTj77?=
 =?us-ascii?Q?ERuAVeD/21DVuqXc4+pCRnz/Mffu5uXsbrelzZRBcqViwZMweYp4afkTmTAA?=
 =?us-ascii?Q?uqqKNZxTbsbtWDWm/1a4hg00TzMBB8zYsJY55mpZ7yJE1Ia3b+9319ET1foq?=
 =?us-ascii?Q?/KOGKOLA536GakK0xCzM119i6PmpBrpyaAsYBLRVOLah+GWTiDErEoGGMXtC?=
 =?us-ascii?Q?YNGc3X+cjL8Rm6KdoX8D3VYcd+okxcfI3PZFxduELaP04Q5wZZlhMCk22UYJ?=
 =?us-ascii?Q?mosZ90eD3D36L/8pN3QvNunDSnjz5YPINIpvIV5Xh33GFXwPFHr3laUyH+W6?=
 =?us-ascii?Q?dVzVQplLgKug2GIzI5rwzLhcqNQHLvusEdG5z83g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ab8901-b911-4bd5-fa9e-08db8dc92f11
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:12:22.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YalZge5dZvG1HE/kdBBjc4TJK72CU3xza2JDwjBHKKRCzfosCfreu1EhdfUXbTWTb3Mf6MoLfxxUwTbgB44CQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6722
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

