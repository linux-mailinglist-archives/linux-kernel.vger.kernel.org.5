Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BE7908BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjIBQxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C4E40
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693673547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tZnuggjXiPxxrN0LJKuKy2l1BGtNDFo8WO5oMG65CzU=;
        b=GQsbTVyB0iGLohSVJRmqCbVNttqO9sQAAfMna8hiY3Ocw8A2tux/y/hAeCZ/QUZFIJR/7n
        obPWala1CtD80pj9Ubk3IpRyzbQ6QkVtnr/IyxngKTjWQQ16T+hLfpuC7IJHOhfW0TR0Tq
        R2v5CjI1qbynwvDG58Us5yDk4Y3t1P4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-z8r8zl5RPaG0bWqnaNi9gA-1; Sat, 02 Sep 2023 12:52:26 -0400
X-MC-Unique: z8r8zl5RPaG0bWqnaNi9gA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-56f75ec7ca9so56135a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 09:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693673545; x=1694278345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZnuggjXiPxxrN0LJKuKy2l1BGtNDFo8WO5oMG65CzU=;
        b=dDPQ4HOz6TKGddGD3JnqEv0/7opBWX34mUGbeHdUtzZfT1T36mFMypbPreeEERraZ2
         6nzMCfdpY0odg1WXYFpy6LjTiG6n3/cYEVCSpxJK5+RVoZVO/TqYlqEa4C5y766FqoV3
         4n2qGSf9z5dvnm7BnpaM5yAEQ1EUdNj7ax775jaxWpZ7Hqg9edoFX6giAcsImyb5ewHU
         7+/V/iSak5EL/hTZLSP7WdqShiexoZkGTtU+vXO9pZMubEecTJcdHMNG5I29mX2yBntg
         IpqpesObrCfOfnHGRvXVoKUSL0+X+DcS3cDeyr74PH0HuDoChq9z+NZ+mpN0zuVM/TTD
         nU3g==
X-Gm-Message-State: AOJu0Yx9MuUFX4V6Q3Lq7ZQIXsm107mN+aiTxne5FQex+7R13tBA/Wza
        nBaDcB5BVgNyWaybGovN5jmyxv6B/Ed8A3eq9enPKVFsEtMAw7cbgIB813PK9yFy654tiGsRgvh
        9cPZxRlkUzKgoKaQWtmNs0/pk
X-Received: by 2002:a05:6a20:728e:b0:149:7fea:d88e with SMTP id o14-20020a056a20728e00b001497fead88emr7866470pzk.24.1693673544983;
        Sat, 02 Sep 2023 09:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAAbHUxNQwq8p+UPawwfWP3/BHApDvAuwx7oX4BXx18Uo4sD3lzf4FxsnqstM/GwwZl3J+Hg==
X-Received: by 2002:a05:6a20:728e:b0:149:7fea:d88e with SMTP id o14-20020a056a20728e00b001497fead88emr7866454pzk.24.1693673544724;
        Sat, 02 Sep 2023 09:52:24 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id t29-20020a63955d000000b0056a36ac322dsm4828323pgn.4.2023.09.02.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 09:52:24 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Subject: [PATCH net] kcm: Fix memory leak in error path of kcm_sendmsg()
Date:   Sun,  3 Sep 2023 01:52:16 +0900
Message-ID: <20230902165216.1721082-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a memory leak like below [1]:

BUG: memory leak
unreferenced object 0xffff88810b088c00 (size 240):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

In kcm_sendmsg(), newly allocated socket buffers can be added to skb->next. If
an error occurred and jumped to out_error label, those newly allocated socket
buffers can be leaked. This patch fixes this issue by remembering the last
allocated socket buffer in kcm_tx_msg(head)->last_skb.

Link: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb [1]
Reported-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 393f01b2a7e6..34d4062f639a 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -939,6 +939,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (head != kcm->seq_skb)
 		kfree_skb(head);
+	else if (copied)
+		kcm_tx_msg(head)->last_skb = skb;
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
-- 
2.41.0

