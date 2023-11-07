Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B817E3318
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKGCfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:35:36 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C60BB;
        Mon,  6 Nov 2023 18:35:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+JdmvoD42xusxX6P30P5CTqF2PAju2AD2lhsKWvf85KDowP80Oa07y3mE5IAOccLjxs/iih6niL3zlslqZNFuccG3MRCwWa+u+qI7u3AAy2eJrZKIq6W8JzWUJsHgKSZPYNiIOAlZ+h3zYMsusMitBL1rGS8PS+7wI/RtIG/z6K/Wzn35RiiVLBIUXo01niShGrn735RW24eO0KiUkD1MrQwNvizKq0xz3t9NHvYXPJrIew0nm5RmM+nm3jOXLLvR/tevtumd0OtGmxENHTK9bx0cRjmF265FJR66ax/ULp+3GqapaTUkq/qrqRqH+mefiHwg50mWvkZkj4Ioat/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80uQ3xWb63SpZP66uWxq0B/SGvpIMtr0sQbpf5vR56w=;
 b=MzCjhAVmUN19WAT9uDITjLwbNLYFbouqUZ4vSkPwQ0WgojlOeZXigKaV2gW7klx4Uf8VqAN1UBOPmeHj1MXsFHW7Orcb1On9P6cGhJb9H4/MQHt/8dOE4CTagv0jPs9hW1+aLSS+bxJ5zEApYtw2YqVnikZr1w2Uw0bSw2OhvnLboo5pcTBVIT6WHquVeQ1avWpjIxex2QNiJsIj/wdGM3cfLFOEALwndET52AME/38dr/e8N2e11CqNkTlua/W1U8sOxQvuyxdcGzMuOY/yECRxt2GHXY1rj9GSk+GlJMLMugI9tiMO5oVhRi6ceZ8B0CpLz7FRew08UCCWRKHURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80uQ3xWb63SpZP66uWxq0B/SGvpIMtr0sQbpf5vR56w=;
 b=htWrg35Y/cCa8SZZIl0pmA9xzHBT/4KKc2nIt7I8a+Es0v8CkjbD50qWm8GPv/h1wtRQEIt6vD5tlTLJFID6/nckNdFXCmBW3g/8OwT7wVQCdsdorqKyj7lXczho4G8Zc3HyBpvRcbhdMiiNmco/dOshFyY0GiDOsR9CCfcxnqqPUr9L3+uFpZoZyemAfRzyJRKSNSLmgQS7IPq3h/pV0k3hdzrecg7cnf7imbXaFKYsM7OycD+8EYmuoyJg+i+hQ7AwulqtA71TE007pNU2ou1/CHOVB1mgtharhxa269BkJp/9rP4q1+QAJpo9AgPcsh36HA9K+ypxdoZcd98AUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB5421.apcprd06.prod.outlook.com (2603:1096:101:68::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 02:35:24 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%6]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 02:35:23 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING [TCP]),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] net/tcp: use kfree_sensitive() instend of kfree() in tcp_md5_twsk_free_rcu()
Date:   Tue,  7 Nov 2023 10:34:43 +0800
Message-Id: <20231107023444.3141-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e05e36-371a-4515-5ae3-08dbdf3a3040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4XPA0t8/Bu+LHZNzJcKUd6XRLqiiG72c2IXQcMWR+o5Gs60wy6fH7QGP6gobl8NBV2PmUDCV15VZ3V8XYKOcVZFdj7+wUPsYj2V7rFsHOZ3FYg0vCGttSP01PTBvvDtdQcIzV796dGyD0bKt2YsiV269jzSOZ3k5DNTwA50C/KEkPLLiWoSz73JMYKccSmafzbq5h3hGJi+7zBn6Uo/n8F9xOWvF5Nqi28LK6TttSqaME7YwMfQ+FHboC31dB9noTvNXgCAGS1Bqatkj0MwEhyhk8VVy3pG6KuO7s4OxMjjdLvi3Yss9m57BPqbs9f5UNlypxuhWA54D67NnRnECmwLLvxWDEySXSbMH5png+6VH3qwNIq4t/61mrYIe+Lc1t4TLF5O/Y/uFRqV3J5zppGA5lQ+ya4ChGt8J2vdjueS/4R7BjJmD7UGVmjD366/h3qBlnRKLzsDQ0yIAJpGG6/ogkpS1K64pc8CPOLPjgElYv5+p2mLhXAsI2X1ixisNpoVRooGtvWdQreDSu8unvD2o2k2YEfDWI9AB2OcSE7S8Hu034q+Fye2NjlLhj7hChekGIv9f5xlngFD+MesqiVDVl9Q/rS7HCuim0NMJEjaJZi57ZxDttsH1pZpj9Dx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(4744005)(2906002)(66476007)(38100700002)(86362001)(110136005)(66946007)(52116002)(66556008)(6506007)(478600001)(6486002)(6666004)(83380400001)(6512007)(26005)(107886003)(1076003)(2616005)(8676002)(5660300002)(38350700005)(316002)(8936002)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DiY5b+TfqHktvl0PcobMFT/7q6/Xg4OXHduxjREeoHY0dzwoX6CISDXw/pUw?=
 =?us-ascii?Q?cC1fGdRJxg5ZRbgo55S2S+gTuVNSf8pSxgmIDRHOqw1QR0rON/bo5CsiwjjE?=
 =?us-ascii?Q?8FavLkn+SUPbKAdDGJrlBcke/zfd91ZtEh6Ce429xPA5ySEnAZAmaCDxNI2T?=
 =?us-ascii?Q?XtIikmuzpT18v58soo/QfBhAj3/WvE31GOvAphazk8AHnB9uh8wPkCje4FiU?=
 =?us-ascii?Q?wP+7MpbqJk1X1vsKTiNxDpTCWDfRg0tjg1hC+7xLoTf67MFeHxD+ZM1A0h11?=
 =?us-ascii?Q?VpoXCA9Wo2MaI99rsBnG+wLQocXHghdwyJ3X1jU+eWVjlsUdv6sDvGcHcCDO?=
 =?us-ascii?Q?SrFEQcn67mtqEn71KLI09c3k5dLulLglxZ7mJK59p5IZwfw2tciBXUHWmvHw?=
 =?us-ascii?Q?KIr2WkPbKHHzD6X9bYdJDaY5B5RdwW16Pon1kb0gP/DaC2qKbxMW0QxveGEL?=
 =?us-ascii?Q?aGJADOYDSz39/yq2Je5skwPkulBg6TGKBec0X1S+L7JHdt7YHxdlOZYUrWdO?=
 =?us-ascii?Q?yrt23AHsfWWkLqjWP0RI+sZpvB2/Bp1c36dcvizsCCLJc7TZINvU4KuVjegY?=
 =?us-ascii?Q?38/OnVr/BGum/jc75eTxU6PZqF2SjtXcUvh9hh2gbBLHKL9DKKFJK4WgkOIA?=
 =?us-ascii?Q?RxGarL4n0jbEK2//FTXny6GVP4O+FHM4L9zQVS3/i3jSsnGoT54UQpmpgOts?=
 =?us-ascii?Q?U95l4qacgt1cDBpfAt+ILw+KaE85bF4foyxJmVTiqB8J912n4t/wpHnmMVgb?=
 =?us-ascii?Q?ytCT3VxAnq+X8EfXQTw5n5abu3Bm/sKvT7nObeze37s7jq3V7GFmSaxCMln8?=
 =?us-ascii?Q?eQzihjno0DynofEg1C6IHfMnjbNkfCf7DhpEgM0BaAv9LxFZVBKGv46wDPf6?=
 =?us-ascii?Q?SxlxZZ4AeQaX21XaZ3rfqnohkXvojJku3vauAl5j5mbg0uiwx+ffWFTBD4vg?=
 =?us-ascii?Q?FtzxAQeSAhQ9DpsT1fG0EH2/IDJbloz1GbGO+qdrWPq9c/30C0RFF9USMBGn?=
 =?us-ascii?Q?JXGR3pT3lyE8aJpHdhLN47nLZ5cGFAVCVWmS/e3HEwJPh4OHWfSsOj6TjlcQ?=
 =?us-ascii?Q?QUCuBAi6X2874V3syRteDdnqVJr53D+Xy8oces1mf9bopfNiE5TICu1xaHn6?=
 =?us-ascii?Q?GUQnJe09RjE+oP6pQj8bLxhiEa6zItLkQxX7Q3AEjAuhSXuq9qxcExJf7Lov?=
 =?us-ascii?Q?ZxlrkrZzRJRUUeBYCVwvWIiziSOEOnBzuXKvjLODqWf62U0T+zLBNEWAviDZ?=
 =?us-ascii?Q?EiqhPZ3I0WBOyjgf6auwdyLIbc0IQN/f8DPWQ6YrgBiIpR582uXD4HeHbR6K?=
 =?us-ascii?Q?ZJuteMere5BjAAlKZof1pSdLDafHUiZh9HTk4gYThdrOeI1RVZpr6u0Pw+Nr?=
 =?us-ascii?Q?0wUfxDlYIjQDTprNK3Uv88S2ERFV1uu2rGLC+ELlPlaDtiZhc7Z4beB56pnB?=
 =?us-ascii?Q?iPUEShG4WpMo2eum1vwhG35NMgbeH/lZeoj1B3WT+0dpccgg0Wn2kpwUvXW3?=
 =?us-ascii?Q?DNlC4Ya7kV9Fkntua/dGrRxNAknM/CEZtsJwgS0JnLD/a2YRzwmHaJMlkxsH?=
 =?us-ascii?Q?GcLeSRuzbd9K/mFsxlKDkjJIo/gfbsi3DerRUAqs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e05e36-371a-4515-5ae3-08dbdf3a3040
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 02:35:21.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNgD+JpeMvASOF4HSNOOtDTcRTs9fRxIyU3Bpp7FUBLoo/by7z4pPvIAK7GDI4RzUyd2qrxLbVCxJT3eKaGcJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private information, so better use
kfree_sensitive to free it.
In tcp_md5_twsk_free_rcu() use kfree_sensitive().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a9807eeb311c..a7be78096783 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
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

