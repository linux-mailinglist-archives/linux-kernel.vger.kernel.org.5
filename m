Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF757AED3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjIZMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIZMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDEDD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695732689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nbqEqYzMG8OvMQKPGMsJuelnBP8p4ESu+dJKIU0PfUA=;
        b=ISui3O8/onamUYExM/Bb3ANq8VG3vh7en4aIUBh4XAe6yeraByHzjoFrIBKOKa84eNArKm
        r0CYGPCxxKGnJgWFR1TwfuhwV+65oa8MOjzxOQs4Y043RoYOov1fdy1epaHdp+q1Ue62Lg
        PRPeQN1LCJEttmPA+3uCEaOWC+X9UvM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-c4SVL2rwOACtSwJe3iVwhA-1; Tue, 26 Sep 2023 08:51:27 -0400
X-MC-Unique: c4SVL2rwOACtSwJe3iVwhA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-577f80e2385so11210031a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732687; x=1696337487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbqEqYzMG8OvMQKPGMsJuelnBP8p4ESu+dJKIU0PfUA=;
        b=RfXxh3OmJc07DhyftxMygggsQF8exjHqyoZlPY3152XG1cfOT96nq/M75t8EvIVh8M
         IruFTF53d8wT4EKrKIq/dowdVDjpVuEqEjGU4YufuKovlBUamhMONWmxWFdSUFKrDfi/
         5kn0AiDccsv+VeH42cV05TyhoHCat2vCFTZfbgMWmlzMWZYp8nMMOmqKQ01rbN135Z8X
         TZdmfX/MnIyBD63e+m+BKM+tI+77Rwn9coAg3jmzQDhmD0WgXJrlqCOcHWCKhIUzki2j
         t9BKm6BHwlk8LHnaBYwyV+sw2XcvUa1c+ymxfcwtch7kaoowdYgPKRq4eyTfVSLHnvXN
         qX/Q==
X-Gm-Message-State: AOJu0Ywokb0ZuxlKpOSO7EHN4AtjYqXnFlizu/dFND9OmXtJc1ZPPx0F
        NtdgAs5/pwMIXDTu0MBeaP7PVF7BI2puzI4Q3oDdXa8YaipgHdbqRWdSS64+858/WSiCzUnmhKd
        JaH5GxWZOG+fdV6L+A/cWqXC+
X-Received: by 2002:a05:6a21:3381:b0:160:d030:ae9 with SMTP id yy1-20020a056a21338100b00160d0300ae9mr2043360pzb.25.1695732686818;
        Tue, 26 Sep 2023 05:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEVI/pC34D6pyrHS7ZQQ482FSTT8zWu5lwWdl1pSWAmn+Ta/fvn4yAahbasCU3vyRvqUqqPA==
X-Received: by 2002:a05:6a21:3381:b0:160:d030:ae9 with SMTP id yy1-20020a056a21338100b00160d0300ae9mr2043347pzb.25.1695732686492;
        Tue, 26 Sep 2023 05:51:26 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001c62d63b817sm1701166pld.179.2023.09.26.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:51:26 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: [PATCH] tipc: Fix uninit-value access in __tipc_nl_bearer_enable()
Date:   Tue, 26 Sep 2023 21:51:20 +0900
Message-ID: <20230926125120.152133-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in strscpy+0xc4/0x160
 strscpy+0xc4/0x160
 bearer_name_validate net/tipc/bearer.c:147 [inline]
 tipc_enable_bearer net/tipc/bearer.c:259 [inline]
 __tipc_nl_bearer_enable+0x634/0x2220 net/tipc/bearer.c:1043
 tipc_nl_bearer_enable+0x3c/0x70 net/tipc/bearer.c:1052
 genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
 __sys_sendmsg net/socket.c:2623 [inline]
 __do_sys_sendmsg net/socket.c:2632 [inline]
 __se_sys_sendmsg net/socket.c:2630 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
 __sys_sendmsg net/socket.c:2623 [inline]
 __do_sys_sendmsg net/socket.c:2632 [inline]
 __se_sys_sendmsg net/socket.c:2630 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Bearer names must be null-terminated strings. If a bearer name which is not
null-terminated is passed through netlink, strcpy() and similar functions
can cause buffer overrun. This causes the above issue.

This patch fixes this issue by returning -EINVAL if a non-null-terminated
bearer name is passed.

Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/bearer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2cde375477e3..62047d20e14d 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1025,6 +1025,10 @@ int __tipc_nl_bearer_enable(struct sk_buff *skb, struct genl_info *info)
 
 	bearer = nla_data(attrs[TIPC_NLA_BEARER_NAME]);
 
+	if (bearer[strnlen(bearer,
+			   nla_len(attrs[TIPC_NLA_BEARER_NAME]))] != '\0')
+		return -EINVAL;
+
 	if (attrs[TIPC_NLA_BEARER_DOMAIN])
 		domain = nla_get_u32(attrs[TIPC_NLA_BEARER_DOMAIN]);
 
-- 
2.41.0

