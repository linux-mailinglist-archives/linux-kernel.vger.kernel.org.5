Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE83C7ED943
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbjKPCWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjKPCWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:22:45 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAE8E;
        Wed, 15 Nov 2023 18:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbMnBCdaVpGuJ8kkKFOGgqVxyXqPHXArbzzl5mcGGLYoQv3JEvM2WJBg2H+TyXGj8sxKMgdwIu3uLNfiCv6nk23IoeA+YyhdJV9NHHvBv5HaJlzToeziHizHGwOZEyBAC6vjtgX/IpgJvvHghkC0a7A2pYLQErWim9buTZS6tpXSymqP3XW1aCfQzGldqq0nu6ZUzv0VB9Rwsn8KORaJzh/854htMcsm3mJABcsS4emDdU9XJelz1OaI4eso620sEM7Bc/YUj+Nm7a8ROWMorUHzIjmIe2OIZmkMqsZ6N6CQAijJkO08jm4/7uWPjkb0qOk5iVVlFyyrMy/cF4kK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7YTB53riFFF/FjPdzA6/S6qLcxJdpfc0Mu33eujvN4=;
 b=goUI2JlDUZYQxpZ1/F7kTY45crBMv3XnB/V2CtCjXAPiNsa6Kqp50jIC9ZPTmNgm8S45Qzx5r0S5oGecmlTkJ0Bbs27hQ3v8nx+QTAeAwaHqXulWWaocAPpkAcwK+9ATPKHBSuS/nGzgO/lOA+p4aIXk/w32XknYNuWgs66YzyeqQpP3vafItYK9oOo7mlh9EH++Q9ISgmC9AZBovy9Zlwulr0MaEv4BuSF/67I0udkJzrd7hNgLye6bYsRxQXeDiGQ0ir694QYqmff5pv6YXRPS0wWG5J2nXel7t/kmPXVrxNDUM9C6C555BRBnf/B0WTIjw7+PzwH7rU+8YHA0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7YTB53riFFF/FjPdzA6/S6qLcxJdpfc0Mu33eujvN4=;
 b=ptowVAi9Gf+TxPK4Q+kBIt0dOjp4+0x6xKjhla4m8ncK999PLsWKQZryXyxgHzEzcGRfzmDSStlwNVm+jcycLrnVJ3ypC3nqjI3fih9jwZZV0Q2/rAELZJqz8WPXMBrP0rM2/I/tCx3P4C0wdgSH1WL3hgn6UmC6dPNAy4/GYJthJ5+KsT54I7G+bhZT9J99fNXqD/MJ8uFtx4I3PP3T0P1kabKQfh6hc1tLRD+8MZVY7JpUeMH4CcH9JvUCgaHcP+priVoZAMI7m7nqhQ8UVi8QtyUNCQITp93qFKoGp1nOWAC4bImDk7Jv6b/E/a7v7LQy8t9afzYTlLyaK4oZVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB6349.apcprd06.prod.outlook.com (2603:1096:101:10e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.36; Thu, 16 Nov
 2023 02:22:36 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%6]) with mapi id 15.20.6954.037; Thu, 16 Nov 2023
 02:22:36 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING [TCP]),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] net/tcp: use kfree_sensitive() instend of kfree() in two functions
Date:   Thu, 16 Nov 2023 10:22:12 +0800
Message-Id: <20231116022213.28795-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 996f7123-83e7-4bc5-1f78-08dbe64ae59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61ahaU19Mzti+DZzwbBeeWYcw22OVoF2hdZb36FL7getHwblg3VYBLQN20pzji/ST1P5vfvLrsLbK3c/LC1MIMdpqDx/PUOQlE3VDzYxvHJA+PoJEs/67ch8asUsA1WQNqkSN9iHnaY/I8eWyuzmlke2Kaa9hbpawSrGAjD0xil6uScvK2uKMlW8hnR87cU5jVM866Bwo/nHQKtSu4pTkEm+F1sOHn2W7GUbQsVI8ITEiytT6yzRGblaEm4cdgaIcsf7MEJnjjZS0+9DK3Nl7YuP6ZQFCiAxwx8eiPf/bNYLBpyV6iQG8pwdaXy9mRuWdP39Ia7TYesG+kuevHSaB5n/Lgv+5TYB0e9mPfpxz4MhAty/xlRQH01Zh7bE5+PQhneFXV5BNY4tGbI+PmXToESWTP9F2cHdo3qp+YqaiIm/78A1nRdtKwIuMPQUkmUjM14az2ksELWzshpBp5kMgmc6ICSiU75FQ2qk1/cYd9WpuD868byF983wXTyM/tWISE+X9IxK8LRsbzJl4wK7NsqRnTvMGYoMrGG211g/NBjZsUFKuugLChEHnWhDnrknLNfcVstXfFRpmLLoQe4DojKN8pBxZqS+bIIKnZ1MzChKIqd8d7B9V4aQ529COpCr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(6486002)(1076003)(6512007)(107886003)(52116002)(4326008)(8676002)(8936002)(41300700001)(4744005)(5660300002)(83380400001)(6666004)(26005)(2906002)(478600001)(38100700002)(2616005)(316002)(66556008)(66476007)(66946007)(36756003)(110136005)(38350700005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Axb9vollz/7FpXy1D6upcKezkthpBkS5kwV+9Cn+VXix6g5MQE21A6r7x0ec?=
 =?us-ascii?Q?DkCUa+UEDCHbzWfkNOOy3u30SNX+Zh+Fn+44WjM9QxpR0rjK2McCCAMTdQm/?=
 =?us-ascii?Q?tIdO46DF3PQGbT1Gtfs2ZscsVi3/pexZW90yuzgnj6/ELTFO30CadM2yCJWU?=
 =?us-ascii?Q?j3dtSsDbYSZn2JrVVj9ITY1lKGrUB/1hRECyhE5yshGtjQd2xAGI/8gFNnY7?=
 =?us-ascii?Q?W3L9HpA/8Il9Wv/n7opfoFAxh37lJi6K/e0h73A18hQPRPsLzY8oYzfK7XW2?=
 =?us-ascii?Q?B/mb32/pFyHo4HGCI756tx3tXT9rjfrCrbavnZwELfRnNzqQYhZk/tHAPFiX?=
 =?us-ascii?Q?7oebc3c47gfAyXdjbq7sHtWletEbhSRwSZPbMO3JczU7FLS7CtXkCgdnJOvn?=
 =?us-ascii?Q?oyPkSAJ7h64eYQLFRNAKzXR9kQI6xtxc+SXYML0WZItPp1CaNKvaWWCWCsam?=
 =?us-ascii?Q?SYi4ncZcv/ipK2LJHDZRsswAxRYjc3XKyqJ2EpbPRKAlDgh951r7eSRsPLXu?=
 =?us-ascii?Q?MWEnzXxF+4iX8alb/bVKIWya/HYvpEHi04UsCOri+Sv2QsXeFDhqrryVzai9?=
 =?us-ascii?Q?bgb/Ejrxi+Z1yY1Y0/UKaQrafCpi5GUl6AxHS7qFxLbqLRR88VfDk9+pt3Ur?=
 =?us-ascii?Q?Dwj1OXFJFUrkPdOVqRxgMte/5RKRdRoEAIlruU+ksKU+5cQ8b26OXJ8ag4K9?=
 =?us-ascii?Q?7wvTHXVcSLlvbt67sNHSE0ESfMQPIDQFAqC9RPgclQfJ8m5uxj2bao/KFfmg?=
 =?us-ascii?Q?uvCXc3MqI9dPKWzLoUWjKy1sfdbp85z5imjd9bLFTy5at7llm0q9Lsbgwd5w?=
 =?us-ascii?Q?dLZdTne1uVsM3nXr775/XiTcNAs3w83EaHEkrDx5KFrcxrb3tlypN0jh/vHJ?=
 =?us-ascii?Q?c1X9ObcijqYiKNKQnyWUkviWnG3j2NzarrQF7ciQxyoNW3NpUq+Sca11xxoM?=
 =?us-ascii?Q?hnRcUnUNVd08G7gKppfCrfGMNuO4ieMy1z1soIsXEyJXWhTF/dwiKFKB9q5a?=
 =?us-ascii?Q?7b8EeWDdrQGwzbVVNYS23LuDt3bQ743NLhegAevkPc0tF2SAjMmKiLjYLbqK?=
 =?us-ascii?Q?hdnqIEYRLh9kvHnpO35aEWn5d+Dti0cJVkfRsyn/Et0nzffLM4lCn738UpgT?=
 =?us-ascii?Q?YLARiZzoVqFtmoYY20wQlrE/n+DmUJEpdk40Q5fUwcM3ycRzwwNR4KmLpJsw?=
 =?us-ascii?Q?umI9GKG4+wcSVwJirdKphnJgfIPpRoaE93ceEn1oCdZc+4sAPYKN4SKxOgXH?=
 =?us-ascii?Q?yuI3cOsIoQ0TEwK+PdkZ0CBQmWLZe5dC+sjQbSMMy1UGWgoUKHg/6arMlBV2?=
 =?us-ascii?Q?ZVbsdRv1r2T1uFKlKIq1fNxnRsnVJwXzZ912Xyl1S20BpEdWXlhaZvbX48Ou?=
 =?us-ascii?Q?TTFsU1FwwzxtpXemRcLpJYj0u5J1eYuFKRWS/ih6oLVvnkDd7oXVIux9E8WG?=
 =?us-ascii?Q?YjrBAtgW00z5xcMEwbxxQgIbtWaBUWL6yaNiLJqVQnvXxyHanuFHAm8sWG6j?=
 =?us-ascii?Q?/PwlCb4vxzjL8+6Ng+LGWMGXIRTRXU3TvXU9Oa4tJJUF+0w5l5f5i5yXHzlY?=
 =?us-ascii?Q?yyyX5GSbh7tzhCjtKw4/bMcuLl+zzbNHe5x0EmH2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f7123-83e7-4bc5-1f78-08dbe64ae59e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:22:35.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHKjm/gj0/tjReDnGHjMiLsHqbVjpLRV5PHlXehFRAoESKY/PHNn6L1FLeWei7w9mOlQ52+oKyVsJ4SVFEqWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private information, so use kfree_sensitive to free it.
In tcp_time_wait_init() and tcp_md5_twsk_free_rcu() use kfree_sensitive().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 net/ipv4/tcp_minisocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a9807eeb311c..83686c7e7ce9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -281,7 +281,7 @@ static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
 	return;
 out_free:
 	WARN_ON_ONCE(1);
-	kfree(tcptw->tw_md5_key);
+	kfree_sensitive(tcptw->tw_md5_key);
 	tcptw->tw_md5_key = NULL;
 #endif
 }
@@ -368,7 +368,7 @@ static void tcp_md5_twsk_free_rcu(struct rcu_head *head)
 	struct tcp_md5sig_key *key;
 
 	key = container_of(head, struct tcp_md5sig_key, rcu);
-	kfree(key);
+	kfree_sensitive(key);
 	static_branch_slow_dec_deferred(&tcp_md5_needed);
 	tcp_md5_release_sigpool();
 }
-- 
2.39.0

