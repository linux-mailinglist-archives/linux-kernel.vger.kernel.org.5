Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2E752EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjGNBou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGNBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:44:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4D30C8;
        Thu, 13 Jul 2023 18:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgpKvthr6UiXDw8I2bd1HBYI8s60IiKGuhnATKMhy/Kl6vCgdWrQB/rRNLiiu7wEXUo0Sw5SyujHYMK+SNZm85p/WiVsKJVFZ0MFoQhUhdV2bRTDdmV4OGXeaGrP/w9Gepsg0HyKjUORCoKEBJNs8+WdOV4w81QuM9I1PzTfE7vapPqmx+aySGGYElGpxCguhluECsGBCXcB4zTvJOsoLhEH5lxvgqr2aghghWAnqAVh/mir3IiZEme7nbRBfPEXcBj5hCJ6eLT/IGBd7v26TxfXvQQZS+J+y9dWvCHghAD2YWiyu8ZGq3vUkH5mHzSo/F1KLWT6Q3oiH6iS7P4o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=H0HSnMr5sRFJWUNKF6Z6QYDPr0q9lOLP+53PbpidLpllCWP0sEXLGgEJlhZIzxyX5BlXLJyhMQKpcWitacq2xK08sLfnB6YQCVE7Q9bsIx6ojIYCquRjOZyslsh8cwZ7VUt32TNMzOxdyYMMrSfOIkDuYG7z5VRSchNEIO38rut6FDEVUTVJIWO+rGNb8iYlkOwr4+Rz3niPSrJBaQvHRq1++ynL2zqeTwh/wwMwv/FF5hcdn2OJDyozn3pev8OWHm/1aNmmyrZ0SgIVEm+k6xlQGrZ8LlqfiQpg15tEPIXfte4pQHbzheJ+7lbNlvFaom4L9rmZo9zbavAUuDIp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JygoujT0HJMPyhBYZRZGKaebtH3lUlWTp8CsN8SMKSw=;
 b=FwIQzF5odiALTDfg1/499u3+C7eK4Q/PmkrA+6FiyIqBy3YkKBsa2trkz7pBK/5c7qEP5MVY32ZssNVLNReiG+ytFnkeMzAYxLLfcYibEHm6tdcdq1iNENQg00oFy0+54PSj9P0sqDDNRfbfqvAP+mZS/sGtSyVXTXheVhD2z+NLXJHGJvdESV22powZbmo6CcwQCB1VRv4dUm4a8fsp001U9O10LZKOvmk7o3dLi9x81oK5i6ty1oD0YfoVqCPTheWST3JxRScmuaGaPjuWUUTawfAnTHPvA+KEgBXKEXWf1KObOAQd1eFtITtipiZUmr16jIk5VFJbiG08UcrTdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEYPR06MB6822.apcprd06.prod.outlook.com (2603:1096:101:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Fri, 14 Jul
 2023 01:44:11 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 01:44:11 +0000
From:   Wang Ming <machel@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Wang Ming <machel@vivo.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, quic_jjohnson@quicinc.com
Subject: [PATCH net v3] wifi: ath6kl: Remove error checking for debugfs_create_dir()
Date:   Fri, 14 Jul 2023 09:43:15 +0800
Message-Id: <20230714014358.514-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEYPR06MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7ed67e-4147-4dae-f200-08db840bd252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRP3Qr32uTxfMWLDnqzi+RwXS0EIFfQ6QhHowtIF82pV4nX1NuLPlkjTsQs4mStcIq5A6NJmpccplugRKoArOxBbzs1bvU7I132vPIe1712wYymBYyq2mfg9ZY1OJnjPzpEx083CgU4+UZ4+J8fpisD5K9fGwn4nku5q+9c8Lc1f9gQc5l0IGkAkdRoOeo0fEwh8vEt2H8dESzIi8HMFTVinHBWCBrId5tcA1I3w6+l4cHlVcVsHoavig3vAmVD7zBJrO3rcQ5r5kZoL3K5BcC469FzzKJQjTGvWgKWOo1soBG49wi61EYtEC+RD0iXmsJwVgyNSmTOaeMhPS2UCnoHy+Ob/cKqj8VNBRXRWuSKuxflUrnY3o7GZlDWJioBivDCHsLl+gn2vWyRyBlmdiE2A3qV312FEQjKc2l4JxxGhU3TzyZkdHnTzJTrkwoKqBzvywlVUzPYqCswWk3vDKrMOUvD1F7o9judAjwaQUUvNyKP/ixFw0zpyPoMBr8S1zp6g5qSOFdDtsSUpvp6C/AYS4+Ks798IYfQyDGIkMOe0sgZbHjUXzXucaCRSlOJbLQgiUGC9gBBcazQvJV60qNUpgz6M29qCYE+aZZCk22ISsTo7eHtIRv8YtKwmWRuEv3Swxw/XTxG4BwYAOCWiBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(2616005)(38100700002)(38350700002)(41300700001)(4744005)(316002)(2906002)(8676002)(8936002)(5660300002)(66946007)(66476007)(4326008)(6506007)(66556008)(6486002)(52116002)(6512007)(83380400001)(110136005)(36756003)(86362001)(26005)(1076003)(186003)(478600001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8s0WGFZ3UjdJAHiufZfzgI40RmktPFrEHgewvVlMjIGTzi6QmhGvvBa2Pjl5?=
 =?us-ascii?Q?zSL4B80PRGUejyaW9AEIbObRv3DQrw/ZoeALmUWVq5Z8qqqlpYYWokcw+s92?=
 =?us-ascii?Q?AAI2dYAWOxPvSaryRfjBcTJ9xnstDR3QAgleZH9hKqUogrf1/32DVLSywRJT?=
 =?us-ascii?Q?PFsG3tfdUjfzupvlpxnlKX/vSkwXrITTi2aNCD5kpeqlmq44EBUcrlKO24zj?=
 =?us-ascii?Q?0BcXc0us/vHE9uEBOCcjA3L2JWCYyEajYY93IT9IXyRJQHK5Oxobed+hxb6o?=
 =?us-ascii?Q?P4u3H918F5POeXI2m3s1Dc8qC6LwHgnIjKpLEcYlA56vpzot6SijcymxicLB?=
 =?us-ascii?Q?EzC6fniI/KekkhH9LwNOB39fW/bgc19gzHac2/8jd68ZEiVVOp91qVFT0or+?=
 =?us-ascii?Q?uEBIkRDzruVF3xfYhL3nOcR6BPU4bf/pN5nSX2yCfSPlIof6PwM8UEJMw6tW?=
 =?us-ascii?Q?8k3pt7YAK7GsUqRiDP81/QQwadVR12JOl8vfzLETkoAYKBb9bjQ3DopqPUx7?=
 =?us-ascii?Q?vmEQxtTsJUxDXK1K1szHef1GsJEsATsMh6UAt165RwHGDnRA48QfJV2pA7Ut?=
 =?us-ascii?Q?xNFCT2BW6LIusJjtRSZCi3LDk4rQDOkji79YSC+4jmbdO2bsKV4Mtm+8++zi?=
 =?us-ascii?Q?S3zYuAr4ZAL7VfTLW2XVsLFPcVht4b3BCAvNjIXW/xaRYI9EZbrHC8c7Kz65?=
 =?us-ascii?Q?RZz5am3oVpB/L5KikizmAY1afi/AQX88LQ/NGThy0gIxhJ5mgpZsSY2nPCG2?=
 =?us-ascii?Q?5gm2t8zGt/tbSmIu7TNYB+4vcaawaxNK/chc/h16tJGuQmn1TPova/tXxpvA?=
 =?us-ascii?Q?Jt03RBFsJrAid0lljY64K2vqRv60OR5SMSkZdJRGbeodut7FBYZJUQu5B3j5?=
 =?us-ascii?Q?P2zUBKEhWVWNah6ZszFBtnkfLzovoitAYBMeU1xG92+EkASTiVPpMYWyZdit?=
 =?us-ascii?Q?coaDfVoXTyeIoAZWVTvLlt2CnRKEA3uup5eNm3GB7rxpsoDiCm5YkQ3+ZTOi?=
 =?us-ascii?Q?mFEaDHxeS9hJNID1i3luWmoSppfzaC/WsVWc+GzW4c1budEvFsTEQLYQ8gK6?=
 =?us-ascii?Q?bShCGg7GG8/Ld/K/SeO10vccMELKBZp4+tkkd3SalhUwTmQyA0Q4GPxUF1K6?=
 =?us-ascii?Q?4Ain6pvz4kkCfGrEMt4X9Qda9ZzS5bvXnvBnJl6YUmcBIdhdzvmdpAVVNSUP?=
 =?us-ascii?Q?/CHw5utWvz8ij1ZSB39J1e6a5vqIODsbbbnWxn3aAZIDQsI/EoDkylBsBTjl?=
 =?us-ascii?Q?5sL+vWXmmvtNc3PqqrOBSmpqznvNtWhOXHGzjElpBEeSEHkVYf+n6grBAVZh?=
 =?us-ascii?Q?WQn1uigUCHHx5R5G+1pomu2iA2BjZ8Zarhf0W86Hy/BQLub2grOS5iFvt7j1?=
 =?us-ascii?Q?RoX1JD6yw+mXU21weLykswM31WzqSSdY1l/Lu4k6D3X3WMEa0I6THXT807jc?=
 =?us-ascii?Q?L1d7gr32an2SN1kCxZfHFYN+C5mOjsIKDJZZnXwT9UNw1ZQJ/S+wCjA25FwC?=
 =?us-ascii?Q?4J0Yz/cV+7+c2JwKQjqPKEg9qkH6HBTjqFaSkeqrYAi1sDqrJtwBCgpLRccv?=
 =?us-ascii?Q?2vCZuO8VLnylIYAMmiUIg3AXkkZvCR/NRZEJO95j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7ed67e-4147-4dae-f200-08db840bd252
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:44:11.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVFmc/tBeslZEK9nCpB4QH3vUJ+AB0IILlgUz53sUlR++NdNBdaYW7f/p+bCW8UQOCPJBOxv+wPGKyv9SKzcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

