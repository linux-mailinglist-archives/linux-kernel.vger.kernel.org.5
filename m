Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150E7F0F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjKTJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:45:03 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E1A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdXzLxZUJww+/x2DqPDC8zaDB7TUl6Byj4Yps3D7iHgOIOC6bY1cZJCQnlFPuyWucN3FpAjU6foj098wmquUZM3j9oHTap4MHONDFfGxYAwBWTzRcZhEPvAU26BmwNPBNfw1SslO/iKIRfogYdBqCC462iQKBEq2nPL8RlWmILuqWOLpOeq77F9RRFipYmZM9e0DHcPyGgq6jmIt+HLVQ6grgfNYP/8w+vDuaWpk3CLfzI0IgF3k3TcBdBnlP77mhv/dRQiY5JMKeOTRQvCGIhEnVOPoNdjAFhr2WaOIfsNnalF7nQeSFZQOqtFg7Uow6s/clQXcNeQpmJ7dUryEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAzQ59DRbN9IBPvfTnj3BYj+z1yok15X8nyQgFac1BI=;
 b=NUKv8lFFolAZqLmF+R1+8nIu5WRhDf8Tv0Hfkhgv9IDX15knkNSfR0D5fdt8+Cwz8GxNRxQSQnSCgN6O/CkY09qjEQ/9jI0YYuqgN2vrJtX1yHOVugFcMygGHSeQyWjXnMsvpVXdsQN9DEbwt4H9yyByHCh86kIYmYYxvt9PyL3HGuyGQsaCcvIYCPuIbmuILbJfbhA62eTrtf48eeWieAMJU4jZdYaL9rsc01fmGh1vXnh0vbdx4eI2dv50sQcSRrn2wzMWS2yADBiD9mPz2SLU14vxQh9UBP371Q83bKtFpDkgLBfGMP/23VaFQJJr/m43h/BZV0VArMAmiHcq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAzQ59DRbN9IBPvfTnj3BYj+z1yok15X8nyQgFac1BI=;
 b=ECrCVaoFEgZHjTRvjZfPABa66WM/wKy7iVaTchbuIvyGyAWbIxx/ucNC3wqFEPWvtp0TW3xSBFSvIM4tqfkXJOO5TV7rO1oixgRSrxABUdoPq4cur9wkHWJXPXt/5APyuZs5Uojt6m0V7xc6HgTT2+Rvx2Hu1ooKW0JaUChmweiGlmqzAErHKKSL4Ln/EinRWkCWveZhJs4ipdcUQMztGr6d3fezGsXBPqBqLt+oDNYRCXZMJUpAAPCIfNnyCsoOLxaWPFAIQHJyhuYRTTZk/RWems0oihlLTPn420sAG4o/Vdn5iLDoGC3/p8mTQS1PhXndLWaqG5+FVwlqSJht6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6410.apcprd06.prod.outlook.com (2603:1096:400:42b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 09:44:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8064:576b:554f:5246]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8064:576b:554f:5246%3]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 09:44:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: add support for an i_version counter
Date:   Mon, 20 Nov 2023 02:54:09 -0700
Message-Id: <20231120095410.3604801-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e1b56f-a890-4f88-4166-08dbe9ad5920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLgiG7B1vUx0VD2daJGUY4AzfwuKmr8whuCqeqUavrB2PeB7ICEDLCTvuQB2kOatlTcu8mhUT6nadvrvuFSSsFtCxDIGbMZWOftKyXqiBmtfhUYaxhpvG55rHkCIfhSqkbXSybhFKVKkWMm9JiECdmpYTqbaViYbZHWw4KIm2SnzK1ibPm2Tv/9HNa6L4cS7TKsuDptHnUx0H+IbPRroKilFHMIj3uQRbgq+czzuFwOz8r2NxHuEi4Vh/WfHkt0WgTukHOLQ8jcAIsaFIXrlPuJtQMnX9ki9XWT8Nip649GUYO+fYnjdX3LJIkJ/erdj0MZqL9/PacAfKccPV0Tqawu2h4rKjOyLVd+XQ8MWN7IxhW6uNMPPpO61kMQTXiVOXEWYIBCNPOxx9dQ6ejfhzkr6Cv5NS2GZs+QLUUxYQFHmMWL9cQqX5U651DhVrZmy38tHjlcv0F8keaOKIoufsxIwFWCpWBxOYjibojjUP/SfGJqPCc2mA9SKaMdQlYJZG9P0opNiv7CsqaayT3nYcKJvskyRG8VGuNgrQHDbvoWLA3N1VdoJygzuEub/ngp4nhkxJCgjVWwSzkK/fKzTo/fkHLFpvA6HSBEhuyaiJgk4T61lDyi3CwWcVEs0lh3C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6486002)(6506007)(52116002)(1076003)(6666004)(2616005)(478600001)(6512007)(26005)(110136005)(66556008)(66946007)(66476007)(316002)(86362001)(2906002)(41300700001)(5660300002)(38350700005)(38100700002)(36756003)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFv9YuhtgS1/Qm/t9wO5yim+GmerjkEWC1plUNaV2qUfYIkpEbuTNeiGd8tG?=
 =?us-ascii?Q?CyfmEMJDTM5b8rnbw57T/FPzWiAdSAMkmCqExrzRWtkjQ1CsN8/zn4yuEk65?=
 =?us-ascii?Q?eFjovjKBCRNClb0Qqo3JxQJvEnB0f7Eb4G1uwxzf8M+UdHHa6zhys57eECKK?=
 =?us-ascii?Q?appQog0egFzim8oJ8e+Z7RdUygNb/LZTNLr78JDsgFUz46SEqNKvU3bB/iu7?=
 =?us-ascii?Q?aFf7KdMHhprPJuPLq2zlWcsE49J7lHnoQst+3W+MYe0+DbCuY3Y4PV2OVUYN?=
 =?us-ascii?Q?v2AM/lnrSOWYYxjW90ylVAandlIB1EarznFo1nHRNWhE4nj8gutqiw/6Tzjj?=
 =?us-ascii?Q?dNZh1yD533x6orPv75fj0VsRL+Be4hxmedEhgmE+FH23GB5k4yBk+AtS8fnJ?=
 =?us-ascii?Q?SHaE8Zlxq9NcSbluVOhC7Xm0asg/7z9KBdwBTBrBKpT2ro9z4TG+gvKT9IL6?=
 =?us-ascii?Q?qD9KbBHPTVnE0LkyTD5Ge7s2kOtIKeZa6Dzb2RUGpS167s5iBfz8MW/6n8ut?=
 =?us-ascii?Q?odMiPD5ik3RxZunHaG5GrC+qMmNfdKdYqkxLuYLTmpXAyG04KeN0TM/FhRxu?=
 =?us-ascii?Q?Xiso34HZJOndbzwwaOKqyuUhi1xIIlqi4ek0h58vyHx+wcX1i4LxCnwEkv9O?=
 =?us-ascii?Q?B1umPgHK5BqbXSUPDRiWgNQ4Vlh1pMB0XbIB/ziPmQ1mOjzvzsUGazxQwpG8?=
 =?us-ascii?Q?MdUHXmksyKyUDyQ88aWXFI8EUye7gMIlaKsiqc+RhGmNnoiqJIarRZ3P5HFp?=
 =?us-ascii?Q?/Ror9zlGV9M6KDvWmFjGWx1sghgwYhDW7Gf/UYyZ7rf7A1jQ/dbl55QSDM7i?=
 =?us-ascii?Q?ubswtxje4cwqBNocnbC8nmi6MKmgeE++gkt0p5v67/W7vwrUGZoV0yCMg2hd?=
 =?us-ascii?Q?4giBkYe618LIsh2lZOuhejy5tYZjHs0WbVQBBZKrBRwTh0hYRI+Auyq3LTaR?=
 =?us-ascii?Q?xIp+emSlhrX70HHnFaFi5GNvP6qGhKCPNI/cIH5keQ7SsJPu4oBmOERx7SrC?=
 =?us-ascii?Q?LwWFQOOAPdrRMCtM+vUnn0JIRbpSpEn9mwGStZReq/q0m3CjaurKQC9oly5R?=
 =?us-ascii?Q?QNZtXFPaki339XuiqsA1MaWc9tecGzmez1oW0FqEa+maq9YCKy5iO0cek7iq?=
 =?us-ascii?Q?SSLjq3/fDuOG54s56rhbUFnG5NqnwsKGw7Y06334oN/jc5S6xhdY5rBTKRQ1?=
 =?us-ascii?Q?cvrSl9gUWI0/c57GslpwJCgKnELXGC4q8hMjZo055BJC3xH3Deh8XUCbg1JJ?=
 =?us-ascii?Q?Bdr1OX/yWP4h1cAfG9XyXJ2O8Wg6Mg7svswLwDM6OOYZ4molE1KBM8r15yRg?=
 =?us-ascii?Q?C02dUNfYOa2lC37rHSU5S7yl66weXhhOBJgnTg8FAanBP3ESk//kQ+yZhdtI?=
 =?us-ascii?Q?XKjE1RLBcg5eOywczpqPvqHlFzQbPHixCCuIhAC/puoDxDbmkLyZkv+Q1hPX?=
 =?us-ascii?Q?gZt1fyDf4EZs2DOVyqkhmOJieDn6wJctOWND8L/jdB23tNfe/rgc3YxNEUEQ?=
 =?us-ascii?Q?h5zZEJG5LBYZ/XzcBkTCnjMqU36Dqdp7EJOmMNWSc2fjkkaps/QHarSnWG49?=
 =?us-ascii?Q?t+mbs0m6zz996sn7f7WXyUrYrtBWmpyV9Jb2hhGB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e1b56f-a890-4f88-4166-08dbe9ad5920
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:44:53.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3qMGlm+61nQZIqhHmhUa83Ri1QGodXFMfUDdrqnkcNuvzL5LfGmVX1gVn6zJFG54qXFyavY0qKAoZm6yug70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFSv4 mandates a change attribute to avoid problems with timestamp
granularity, which Linux implements using the i_version counter. This is
particularly important when the underlying filesystem is fast.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/inode.c | 1 +
 fs/f2fs/super.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..68fd2ef35104 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -28,6 +28,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/iversion.h>
 
 struct pagevec;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 560bfcad1af2..2604fa4a0704 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -32,6 +32,7 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
+	inode_inc_iversion(inode);
 	mark_inode_dirty_sync(inode);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..2bddccd47e3a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2204,6 +2204,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
+	sbi->sb->s_flags |= SB_I_VERSION;
 	if (!f2fs_is_readonly(sbi))
 		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_sb_has_blkzoned(sbi))
-- 
2.39.0

