Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A07CC8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJQQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:22:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2037.outbound.protection.outlook.com [40.92.75.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC01A4;
        Tue, 17 Oct 2023 09:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsidnMIHUykPYc8/mxvWl8CoDYWJPb7gstIt+KappnqKLZvU86OCe42JcEFfavpfyANnJc/Dy8Wl2rn9HAd0Ehg9XygY0lP+zEUwWlStGMYnUWOZESErA0Q6GGcS13h8OkypYirw0w5yD+RoZz7iO8/AYQiai97oz+v61AlwIScgwli4IA905Xih6YS+8y/c0ePq2PkNg2buQBuRxRnN67VaFEzr/ogx9SuGm+HRHMMQsXm/0WgjIYrjJ2H5AHtGfC+SDft9HHobYND7VJI6F9JexZLANj1S9gFOmrXrsYBKAia8pycY9iHMdO/mrZCQ6MkU1E5Ws666+KWZi+UZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDRqOekf0qd4P/DQTcQIPmfho3vMDf5sI5B6cunmMHI=;
 b=OYuH9whVBKQFUxnEgJakKiT/PTuLcNQsmHxirR9FHktMz2Kwff504mK0tOjfRIF9SCPu8UxoGfDKifyBvb5gaWPFQVIy7TG/1sAYYsCb3DNEtOEWhqcCoJz9Qzy0HaVxDIKuTabjt2eYH6LgWzoWWHjjEYWMBDqGE77ceRSyBRCsG4tvUn68cTrLINaXwNBDZ58lvdj+aQenc274k8H27KhQuXoTP7FeecW6L16ruv8E8HW2dj8nXx1T4i8vjzXTaenSa8pB4XdbLA8FPESiCMKs32LJdmECGEoePqNu6DSh2V7g7BReff56syg+g34xL/JGr1He/BPZ/tm5rqf82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDRqOekf0qd4P/DQTcQIPmfho3vMDf5sI5B6cunmMHI=;
 b=uxfapWGF8nd2m6ItjbS3YSBt8YDG8fvYla0P0gqKo1Y4YBtiE0qtkSRI8SDEsSf/W7D+Oz1Cs9eRaNxX50jCjksfXJAU8+fWyiWwHbv5YMAUiWwAZwLWuSq2xv625ZNNhcx1JwdRWUyA2MSljzmq6dUg6bzphraaS9k91+NfynMCG+sPTwtaF5wOlPRRaS96Cqs6yICHzngXTn1TrxU2srWXuL2rQgxGczm3ZLO+wgC0ziawESXGS69xfYZZvG5xLVCCUipDsGC4er3urcEW2NKuWTkJ20R7bdpG23OaEtj8gj2UibdU7liUCENtu0LBJ8flNwbtWsSIEVFUSWEZbw==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PR3P193MB0553.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 16:22:53 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:22:53 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Subject: [PATCH v2] net/tls: Fix slab-use-after-free in tls_encrypt_done
Date:   Wed, 18 Oct 2023 00:22:15 +0800
Message-ID: <VI1P193MB0752321F24623E024C87886A99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [l4mhqtjJiDvTyGcARR2Dbgu+eyvxvniW]
X-ClientProxiedBy: LNXP265CA0086.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::26) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231017162215.20484-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PR3P193MB0553:EE_
X-MS-Office365-Filtering-Correlation-Id: f70fa696-fbd1-4989-9c1d-08dbcf2d4f69
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvvpteJGpr3dRZvuYHCactD6WD/sIwC8auKsqtOe2BAa48PwhSPHCQNaLiT9Bw7qV+H0roClitVOYjpPg3EKt7ji+z5lwoAf20iBziUfVKOykzNNnfXZfsQIm5TepY7B8PVHqeueSjPSli0HxvBgA9OzWG7MRRakeV9M6H/+mvW19p5Od3gHnhv56Q/1obrrsVmtYnfwtOH5MqDofnmG/BlRD5+E8YAS0jE/+Ripb6gp3qESPUDHM1j18Kc9LJk2AFFSYJWCxIDhYPOEc5wxoDJAekXoG8eElSe4wonrXtWpmwESlwnLVve4YNRE6T+GtaVgAJuDw0mvB/nE+t87bN3Dvkc4kPlRa1KWRLHPmFv6IgacUaX6n2EKVxqHB/iPuqUKCC72FilWlxXB0/hydrzbQyJLD9x7cVbBEt3Lqe1geQm3ksj+StXjBWVjhXARe4KSmrkVuGEfgug7pjCL9+8rJXvfFYp2G+ZiBcnyxynFT4sdRsya7mXTfA3UaZfpgq4kNoLFEkPy0VBbMxoUQow5buejBYtxgofcMAoZNWCLZ9jlFWYHQ7KWiago0mzlnhfoDBUhZVAjBnFlAOzOqZEreSofQLls6gRLDW7Etvo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?og+5c227dqG1JjGvwMb31JYgjRoAZXAjDTzlcDSR/H3zJFBaXC62o56ussvb?=
 =?us-ascii?Q?MzQjcxEQvs1HAbKOCmx1jcSkEgV5BVkCrz4nAgAHTt6W2Yw0pUqu7IHYSh+F?=
 =?us-ascii?Q?eKyPJJK1Drxe5qh4pj3bzTqFNgaZhWmrYAOUJ0xSUlMXGOP1zqnOCgmDkvYj?=
 =?us-ascii?Q?PBayeBgWVAqMwGUGqKG71aTb4lpwg2U+uthQ7FKeQNqVL72yg1ZdYeYKk+Wa?=
 =?us-ascii?Q?uXi+Q0crKVNC57O04y0bNzySGRdNTqVZMfpFgaMiN7gd7wymwDnN2oObEjJC?=
 =?us-ascii?Q?z9XSzKyhDG/4cJrhNoV/n4t/vqYJmSBSkwcKYZ0gP+PC479KRik4Odx3hYOV?=
 =?us-ascii?Q?zzPIciqlk+9+yNuGuNttNRFGggxucwlINTcqqQmciirLvMhe0aM+MtPJUQ3k?=
 =?us-ascii?Q?rde76Uf1Y+oGuY6TtM8dn87kbLAYYWr9WQl34S3mF9vyHBe7I5hRFBb6QLX2?=
 =?us-ascii?Q?bpAUxuCeNLCB01aPqMovgH+YlC0K22Akd2HW9EQi7NMhgczl9lsejmHDh9gK?=
 =?us-ascii?Q?MV53SGESMrFj3Npk3FLprmJKhJ4nNnjTdFbYYaoERebI1TNo19Ze0t+31L6i?=
 =?us-ascii?Q?HfldUSqo/jqKxJnmC0MdXM9+ltMNlsaWL723pec/WBoGzRLWPxRawVEjjJP1?=
 =?us-ascii?Q?OtrdOxHGECOa5gnpfqmdcts5rGqLA340V7p9qSLNPl+LeRYAOKG5bp+JcaUD?=
 =?us-ascii?Q?nczKKEfkQ2YGJndC6kU8ljtSTS+xgKJm8giNW8uonbxkqe9H80gui6NHqOkx?=
 =?us-ascii?Q?l1BWRKVyWeVFLi5/Mxg/tQ0EsTs63ORNwDiHIQrAQDivYX13dmKE2xN+d4Gi?=
 =?us-ascii?Q?ukySfh1RLk+nirFCf1qQjEKZYWjFHRo8DbuexBDlBPZgkcSszisVkTieNiBk?=
 =?us-ascii?Q?69DHqnQh5K9aFDiCGos2W4oKgLH9xWK3kSVbucZfcPmN3ZjyXrbTO7hCLovD?=
 =?us-ascii?Q?UTxw2/nw3oPqkRRxvSFuHdttO7VcmBFA96nyMymD0g3sczKiUrsQ5kn3Shr5?=
 =?us-ascii?Q?YA3zDD5oJKGQ54InabgL+KhcSt2fzFrnKpIaYzX2gjHCs2Al70rq5bx/7cfs?=
 =?us-ascii?Q?UvzjHRubgOsQuKjw5wyXXudhUeRrJuF0oyMbSjOEgRQs7XKyfj99uTrvSgkQ?=
 =?us-ascii?Q?Qf41nN6iMhrxdU6kQMeUs0ubmd82a2zC4NnjetXoGrjWvCoxAfJZd29/uRLW?=
 =?us-ascii?Q?2BsSJQ9IpBtxSGg2Oc35ebvKlC+S+wAWludxOkoZEkS0hMcSy7M/VELIdwo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70fa696-fbd1-4989-9c1d-08dbcf2d4f69
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:22:51.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation, ctx->async_wait.completion is completed
after spin_lock_bh, which causes tls_sw_release_resources_tx to
continue executing and return to tls_sk_proto_cleanup, then return
to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
the entire struct tls_sw_context_tx (including ctx->encrypt_compl_lock).

Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
will result in slab-use-after-free error. Due to SMP, even using
spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
attempt to hold ctx->encrypt_compl_lock again, therefore everything
described above is possible.

The fix is to put complete(&ctx->async_wait.completion) after
spin_unlock_bh, making the release after the unlock. Since complete is
only executed if pending is 0, which means this is the last record, there
is no need to worry about race condition causing duplicate completes.

Since tls_sw_release_resources_tx freed all un-sent records in the
ctx->tx_list, subsequent schedule transmission is meaningless, and
the entire struct tls_sw_context_tx has been freed (including
ctx->tx_bitmask and ctx->tx_work.work), continuing to execute
subsequent code will cause use-after-free, so return directly.

Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V1 -> V2: Fix possible use-after-free caused by test_and_set_bit

 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 270712b8d391..b21f5fecc84e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -441,6 +441,7 @@ static void tls_encrypt_done(void *data, int err)
 	struct sk_msg *msg_en;
 	bool ready = false;
 	struct sock *sk;
+	int async_notify;
 	int pending;
 
 	msg_en = &rec->msg_encrypted;
@@ -482,10 +483,13 @@ static void tls_encrypt_done(void *data, int err)
 
 	spin_lock_bh(&ctx->encrypt_compl_lock);
 	pending = atomic_dec_return(&ctx->encrypt_pending);
+	async_notify = ctx->async_notify;
+	spin_unlock_bh(&ctx->encrypt_compl_lock);
 
-	if (!pending && ctx->async_notify)
+	if (!pending && async_notify) {
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
+		return;
+	}
 
 	if (!ready)
 		return;
-- 
2.39.2

