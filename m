Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E537F27D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjKUIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjKUIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:47:12 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BBC199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci2fjush3uHy2eHrR4KMEL7OPv45k7sEvXP4HEDwRlymTV6sx29lC460E4PmOEfyJDjFLxhop7hIGqlyyooFT64i3A8rWXSYQ3x+PrXjHm2j8NvzS1Nw9kSZou2MDU+sEVrMS+tVRBbPb1MxOMJ+OFq0orTxhqQKteVng3ebt+gMZMWx5ybnEACpBwXg8CYVddOnKMc4p9xvUMMWOgQFa2DHGhz5pOTsMz1wY9eZUQYoT+eHjWQZxX4yQVXcI0yhnNC1zDjmo2gusMEhlVfmMZuElNex+n6QHHmI26iomKWXpyWJcjl8bhNVkTtJBW8sVSyJZtRFLcxlOlVtEi2Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1jKzEvgvT1xkpQeOmtQYxQ49es/Ht9A/RtNWtHmNZ4=;
 b=VLCmUgL/avC7vfn6DmFa3Nn6RoShaKYfvsdQqcl3v0XYLbhhI6ACfjQYdbTXSj02oO/n8JrU13yIvRqBIiB/YXgVhkJBUYnQIlKbt+jClDphZdmD2h4p+2m9753GK/BevyMyvE4f2BogMvfzWqx3ThGwBB4+BOCc85N59XqmBqKdLISRl8Z6rtLMUNYdd2yV4TOnFYJdeXql4AjMk5mvBg4P+viEeH7QNypRHVgPUv1nZdW79Cfwdcu9GNLCo/0N0i83t44KE5H6OGi5e+qf/2B+8lvL25JdLhwNRvyzS4i7ITGaWQacgpeqYNgVAzpm8pY7AQV3vzft/g0eQ6Dbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1jKzEvgvT1xkpQeOmtQYxQ49es/Ht9A/RtNWtHmNZ4=;
 b=mE8aMExBBVw0CZ3ESwN/tK4mB0gNugE75EOWAktq79bGZwqI277C6FZavJ3OsLBtNQBv31VmwtMt9TZf4qPw5pvmWFl/pMxdgb9nWRSywYMUL2LJ7Go9oYrlwxcP8chr0hWRqiX0BUZiuxy/uIL3WDN2EFK1EYD1NASrCKSyL178n+/VoUZziEVx4/WfoMBko3Vs0SWmykrE2KLc4syl/IkdB/sSFhvhRW3HimiLOY7CC7/RFGvfCUCbtDqenVT4un8Z5x1eY021GsEzPzqMSYks3MnAhpYOHuLzbp36IsTgu5XXV3TiDYpFI8NC4lzimV8LW+tGTIRDnfkXdIA3zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by TYZPR06MB4127.apcprd06.prod.outlook.com (2603:1096:400:6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 08:47:01 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 08:47:01 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 2/2] dm verity: don't verity if readahead failed
Date:   Tue, 21 Nov 2023 01:55:29 -0700
Message-Id: <e18ec7ad7449f2aba885b93467005848745f4853.1700555778.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700555778.git.bo.wu@vivo.com>
References: <cover.1700555778.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PS2PR06MB3509.apcprd06.prod.outlook.com
 (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|TYZPR06MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d432032-10af-4a18-d72e-08dbea6e6d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HawtCY3vSSeuxSf5+LAIyoTq+P71LClA+OTpQH1f2qBLAqCx5mOI6naWBaza8eMt0tVTARjE5iI/87/MsVvxLLnD2eC/SXuAh3Z59WuWssj8zv0AUZrVbC73iJ0xoP8uo4n1VneSgsq3wp3SvBjYm99oZAX//D72zV62O7wd5npQodt/POoh/ZX8t8OAdF3ssaY+InVlnozvljby1uSNsMCbw+mKeoC0+Gb3Q9H4TyDU/QZv7Yl0CY1wMg/AFiHq9NL+75kh03o7vdp4Pww0jb0ivZguQbTE9VF+0m3Yn0JSs2GtiIQbaMzmt1WNtOjSo4LLUesSrcMMZRCrLtuRrLumHSPaCTF21vdeKtj4KlUPnjh2HHLMdItIO+fE6bh/8y3ReJvwSVpXxCfgo01P0ZCVOxmomjB0wAZqd2OCfWOjB7RlTUx8uevzuXu1Y4mP813c8s1EjDwDTW9qs+iqz2frlEmUQg6+5BOwRBf/0OLPJLZetSaARuJUm2yyFHY8UEhCO76nvDCiXWKB16pkfqI98Ha9Nw0nM0/lU2SUI/+aX/rESVTNo5unQk3L1McZfKihk6g9IZ1pRfqHbZ6FQGZBe2ljnYUb97ri0+4zHdagxJcgBmDeGdOEx/PY0RE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39850400004)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(110136005)(54906003)(66946007)(66476007)(66556008)(36756003)(52116002)(6512007)(6666004)(6506007)(2616005)(26005)(107886003)(6486002)(478600001)(38350700005)(38100700002)(83380400001)(86362001)(2906002)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kHQxOKA//8tBgx5jtF6Nh5l34U+UqkCdi3+Hl95+xS5aLZ7LWjUCsSPRAMRc?=
 =?us-ascii?Q?fkShwsMuz5H20H4KjP3Gcn93q4uLXdCH9DPbpdWmp7lHw4LWPk2b0fm2QJtv?=
 =?us-ascii?Q?zD9mjSkQ32c6Mcs0lnbmQgHULXlDXmIRVL4lHmrCOXO2mRnJy6lnLVM1sbwF?=
 =?us-ascii?Q?wPD0JWz+SAyD+j/mIrjao/tVeJtw9TcXsznG0kKokJFVdtzRTJXi+L5wZw/z?=
 =?us-ascii?Q?RhCtdbb+XhHD8GSE1roBWduVn76Mmz2VKLQp1jxf9wvwWwXqoF4+cA9ibTYv?=
 =?us-ascii?Q?FmqpSdRLJdYa4oF4d1RYb6aytVrjNiAmYnO28tqPQrgYneZJalxQ1mr6vWt3?=
 =?us-ascii?Q?AMmYePXma896htF9i1SjaxAhmchEJeoj5hH2OWz88BE17kRJtI73pFI1yiff?=
 =?us-ascii?Q?QVydgbYGiBuwHnZgcVfwY3/DcqUFljnGpU2M/VaEZ7B40s0puD5cXsyDA4gF?=
 =?us-ascii?Q?ApVgPsuHsoCFaDEBymn/oArDNv2G8+VkguhaqQg+QRTPZ5Kpw/kILYJs86UI?=
 =?us-ascii?Q?yq8JWAKGhK2A3JWcC073NKOGs5VoEu2BAgV8pnO+bWNkbfFo3mYO/DzO2r6M?=
 =?us-ascii?Q?CEQ9I0t3ytICNs6JaF00jC93qjUzFvSdS3HcyWUPYSqhtyBOPROPt0xTw8wN?=
 =?us-ascii?Q?nD2daCjxhw8oirRtzMb/ArCtEk2LtyfTYWVPp8UkmWYT0dfAk671rDQACpBw?=
 =?us-ascii?Q?vTr4+KVpcC2A3xwAWpACwrcZX631jDEMf3LFq6vdDA10cLtXt7V3VAHxZMda?=
 =?us-ascii?Q?bN1lNmz/mdBslq6OOVzkOp3KjZ0770bvZDIq6CQssY6hagLQXyTzkFCO20jb?=
 =?us-ascii?Q?HYgtyuX5a3rAr7zKHlyQBAm5T+sDq2/AVC3aZiLZeGJZQpi62UrowRZnygIp?=
 =?us-ascii?Q?XqUd6HanZqW351FZ/tS4gHViQJhZ6PK85N+cxWfONpuj9aL5wQ6JsMZnAM+p?=
 =?us-ascii?Q?OXlosaW+AhH3CxpAgRFrTzaayv53cxaRrIQrLECI073QxpZ5ViVQW9tksVuG?=
 =?us-ascii?Q?nDx2KWb4QVjkzTxROoZG/8con0WEYBLaYi4eQCyyZWQr40ikrZ5dxm2iQquS?=
 =?us-ascii?Q?66/1DD6KLpgshaOnM4n3pjQp6mwXfIRBkD34nKYFmejWtatdhXWNl5LjK1Lw?=
 =?us-ascii?Q?aAA85Dd0CokY4V50tOlOvB0vvNwPkJON48K5IEvyUHeAKc7SyqFeo6E8Bod1?=
 =?us-ascii?Q?36oxaFAiwvUVCOA+AJGrtyadRCkETxIYChMno+hwQ63/HXKD4eQOoKldt6Zq?=
 =?us-ascii?Q?YNjIUdnkFOqA9uXQy8iVixpZ1iAMVvWq3OsCHkNSj76WzL1ANNDD4ffA5M9i?=
 =?us-ascii?Q?pFcO4aQj3D+QBTAixR7VDL81j7vn3juUgDKslxKtLEpztzLV1efEPlhGLUpt?=
 =?us-ascii?Q?KvKTVQj2xBpOnlohJ84A020swExpsW9CgPruddv1Aoi9qwe8EhZo9i0ouJLj?=
 =?us-ascii?Q?81UZUYn7ZjBrkVu3HyvOjiE+cdCLcDd04ZatMZlBnSSuuxAmhZQFtLJk1kJC?=
 =?us-ascii?Q?Am78i+yjx4x0cR3IoFiiIVrYZGKN8pUWykP3lEU88nZQKEpUDHLgwnpblnSu?=
 =?us-ascii?Q?KWXzEpj2R9/E8YcTcB7PqjuG4Mb8quhoOWu1bivd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d432032-10af-4a18-d72e-08dbea6e6d88
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 08:47:01.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0jWMWJjjtI5Yfp/n9IkXjl6gxZ4TG9i+WCBbtZG9tUxVI7owFufb3B1AOfrpOjs7PlE/7YO81PzSQZwzp0yNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found an issue under Android OTA scenario that many BIOs have to do
FEC where the data under dm-verity is 100% complete and no corruption.

Android OTA has many dm-block layers, from upper to lower:
dm-verity
dm-snapshot
dm-origin & dm-cow
dm-linear
ufs

Dm tables have to change 2 times during Android OTA merging process.
When doing table change, the dm-snapshot will be suspended for a while.
During this interval, we found there are many readahead IOs are
submitted to dm_verity from filesystem. Then the kverity works are busy
doing FEC process which cost too much time to finish dm-verity IO. And
cause system stuck.

We add some debug log and find that each readahead IO need around 10s to
finish when this situation occurred. Because here has a IO
amplification:

dm-snapshot suspend
erofs_readahead     // 300+ io is submitted
	dm_submit_bio (dm_verity)
		dm_submit_bio (dm_snapshot)
		bio return EIO
		bio got nothing, it's empty
	verity_end_io
	verity_verify_io
	forloop range(0, io->n_blocks)    // each io->nblocks ~= 20
		verity_fec_decode
		fec_decode_rsb
		fec_read_bufs
		forloop range(0, v->fec->rsn) // v->fec->rsn = 253
			new_read
			submit_bio (dm_snapshot)
		end loop
	end loop
dm-snapshot resume

Readahead BIO got nothing during dm-snapshot suspended. So all of them
will do FEC.
Each readahead BIO need to do io->n_blocks ~= 20 times verify.
Each block need to do fec, and every block need to do v->fec->rsn = 253
times read.
So during the suspend interval(~200ms), 300 readahead BIO make
300*20*253 IOs on dm-snapshot.

As readahead IO is not required by user space, and to fix this issue,
I think it would be better to pass it to upper layer to handle it.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/md/dm-verity-target.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 42b2483eb08c..d242e50ec869 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -668,7 +668,9 @@ static void verity_end_io(struct bio *bio)
 
 	verity_fec_init_io(io);
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
-- 
2.25.1

