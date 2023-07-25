Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D94761DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjGYPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGYPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:54:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F94211C;
        Tue, 25 Jul 2023 08:54:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so9215311fa.2;
        Tue, 25 Jul 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690300467; x=1690905267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2ueYrBi52W2OkGXaF73xpgZBQIsvgeSihX41z0L7xE=;
        b=L+StV56SO8Hq4MRlBfv5ewD58CUtuNhf3SladD8jctRRcL8zbKOJsdIzyNKM0XJ804
         jLH3O4VhCEmWK1u6tUPh5jf0YG5dMHLu9yHparAuZpXH7rsAT9ZVHUMHcYtHDZzASR7b
         3i3BXSwCf4JHyFWVVa5ojk+GqQLWDg4r1e1sxOQ1Tn++Guxd10G9SGo4Xr0rv+jmzODJ
         WVegOTzRbBVIglLKAn1sVUe7mfWQE0B9vb0drVotj5vI5YJeJz4hy+Qy7bpDfsXJd/ZN
         KrjAhhPwLx0XzQ/eK8ueSW9CGP3K9LXg87Hg2jeC3yiKtAJuuqB1/NxOePbT6bwnYdf8
         cGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300467; x=1690905267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2ueYrBi52W2OkGXaF73xpgZBQIsvgeSihX41z0L7xE=;
        b=U5tOeiApvtXPUNKyUKPMiW91jq1up57L2acjNAVzaFrJoKFQGC+Pfm27VAw1PWyTGz
         cDYk9vzPWGSCXhx4tFA0KUHZ9fxJThlPqcfGQ0zVF+/91P7tMuGX5whAmm81HY14AUcM
         q6glbYwj+FuY/BHD9uymKB2sKF0wRBBjC+gwWTy/x40bavNhb5AEM+5+4XmHuiUUoAEV
         9V37ykm/vMGMU+2eKK60GkswBVS4KRnwauP+ff05cWlI1FWAhb3rLrNCLxg7pSPr3nk1
         DhJVN6J3S/MamI9grH6/9A0G7T+BDJRWrN/yM85BY+XiiDAuAit8EEKyeEdOxcuQv0AR
         6ZoQ==
X-Gm-Message-State: ABy/qLa8bsOrQsgQ5h/9by74AkAl0nk++htX3e+qFq6GLu1wgYc868VA
        ufW5funMwA1yf49SFuDba40=
X-Google-Smtp-Source: APBJJlGFsUL2NLGBfql/tuKTnFjUD7SzrJRbhKHlGxQWMzvZUxuoklAu4R38OUCt1alorXvn+snuBQ==
X-Received: by 2002:a2e:99d9:0:b0:2b5:80e0:f18e with SMTP id l25-20020a2e99d9000000b002b580e0f18emr8957085ljj.3.1690300467033;
        Tue, 25 Jul 2023 08:54:27 -0700 (PDT)
Received: from localhost.localdomain ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e8618000000b002b96a3a87d5sm3510747lji.98.2023.07.25.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:54:26 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp size limits
Date:   Tue, 25 Jul 2023 18:54:04 +0300
Message-Id: <20230725155403.796-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:
=======================================
Too BIG xdp->frame_sz = 131072
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
...
Call Trace:
 <TASK>
 bpf_prog_4add87e5301a4105+0x1a/0x1c
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run_xdp include/linux/filter.h:775 [inline]
 bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
 netif_receive_generic_xdp net/core/dev.c:4807 [inline]
 do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
 tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
 tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But
tun_get_user() still provides an execution path with do_xdp_generic()
and exceed XDP limits for packet size.

Using the syzkaller repro with reduced packet size it was also
discovered that XDP_PACKET_HEADROOM is not checked in
tun_can_build_skb(), although pad may be incremented in
tun_build_skb().

If we move the limit check from tun_can_build_skb() to tun_build_skb()
we will make xdp to be used only in tun_build_skb(), without falling
in tun_alloc_skb(), etc. And moreover we will drop the packet which
can't be processed in tun_build_skb().

Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
Link: https://syzkaller.appspot.com/bug?id=5335c7c62bfff89bbb1c8f14cdabebe91909060f
Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes:
    V2 -> V3:
    * attach the forgotten changelog
    V1 -> V2:
    * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
      syzkaller repro and missing XDP_PACKET_HEADROOM in pad
    * changed the title and description of the execution path, suggested
      by Jason Wang <jasowang@redhat.com>
    * move the limit check from tun_can_build_skb() to tun_build_skb() to
      remove duplication and locking issue, and also drop the packet in
      case of a failed check - noted by Jason Wang <jasowang@redhat.com>

 drivers/net/tun.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62a..7c2b05ce0421 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1594,10 +1594,6 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
-	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
-		return false;
-
 	return true;
 }
 
@@ -1673,6 +1669,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
+	if (buflen > PAGE_SIZE)
+		return ERR_PTR(-EFAULT);
+
 	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
 	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
 		return ERR_PTR(-ENOMEM);
-- 
2.39.3

