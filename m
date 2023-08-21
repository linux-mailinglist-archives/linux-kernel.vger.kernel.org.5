Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3590783030
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjHUSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHUSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:21:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B8DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:21:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3236a414so1669832b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692642066; x=1693246866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMRvtQ0OeEguDDqLUeJcBfQqYljKtL7yUUjmCfDbAp4=;
        b=jc1qHonRZAQUt2+1YpNcR9AwUucjGgltbWERJ+92ideW5UR+jhS7efr9htN6b9NG2P
         ukObyiHRIHDgdhkKXuzYeYW4xR3Z8/r9KrEGQF5jw0xYGnitJJ2M7RqGyiboh1Ar6e2c
         zjoQvifmIUGd1G6NzfxWO9q7+VqnQq9Kdj8xQ9zxB5bIoFKFQXdvi497ai7T1RpYAADn
         r4C2FZkwG8jREwTzmMWaK83S2NTA+oBJT6wUukRuyYzGAtyAzP3ItZfST0aMzn5xCZzP
         UFmn7WspvvaEnVCN5reIb+9lEoE4nY/cxhGXj8o1EGy24eyb3YjU3FASEYYVNvqBxMnr
         +Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692642066; x=1693246866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMRvtQ0OeEguDDqLUeJcBfQqYljKtL7yUUjmCfDbAp4=;
        b=OprtnnAJ+2dG0ooYO2Z99yUaMd94jtZVPP3BByjnZjXD78PH3eYKBU4hwM+Y/UEOIJ
         c4V7ITZXn4/gk3xkzRxWies33BXe441Hzk2nBlIajH5Y0TN5WxrtDqSAQ+z1ctUdf30b
         +Oy687V0mXUxhJbZ0l246tfAA61P6NjGVD9wjxOFB+tD10e5IzwUvxUgO0aPSjN2pzUP
         xKN9B4yjyzvnYA2Aimp7qpHAVoSVbZUqgWPKa8HuVizZwezw8dkN8kqZCyffgV6TBnIq
         aFb7889q3YU7YEkSP/4QC85aQfSwM6LngSki3UoiNoDxucjuTw6HoX7bWuzFBUeozGb9
         eTWw==
X-Gm-Message-State: AOJu0YxlUtzMrOvatOPPt33KyMcPd7czwg0B19rdiPdN2B/NMYazr9I0
        hNPSTSfZ3x7jauJEWa/sexnhDwGZfJzdJQ==
X-Google-Smtp-Source: AGHT+IGoNWVHhpQT09obUTj8KDIZnwB2hziWcFswUWmyzFroKqJvcEKVOIPziKs3wFyhzGuRVLskBA==
X-Received: by 2002:a05:6a20:4425:b0:149:7fea:d88e with SMTP id ce37-20020a056a20442500b001497fead88emr1467914pzb.24.1692642065500;
        Mon, 21 Aug 2023 11:21:05 -0700 (PDT)
Received: from Osmten.. ([103.84.150.75])
        by smtp.gmail.com with ESMTPSA id h26-20020aa786da000000b0067777e960d9sm6432065pfo.155.2023.08.21.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:21:05 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>,
        syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCH] FS:JFS:UBSAN:array-index-out-of-bounds in xtInsert
Date:   Mon, 21 Aug 2023 23:20:24 +0500
Message-Id: <20230821182024.14522-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:622:9
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 3614 Comm: syz-executor388 Not tainted 6.0.0-rc6-syzkaller-00321-g105a36f3694e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0x107/0x150 lib/ubsan.c:283
 xtInsert+0xfbe/0x1020 fs/jfs/jfs_xtree.c:622
 extAlloc+0xaa4/0x1030 fs/jfs/jfs_extent.c:145
 jfs_get_block+0x410/0xe30 fs/jfs/inode.c:248
 __block_write_begin_int+0x6f6/0x1d70 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x314/0x610 mm/filemap.c:3738
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
 do_iter_write+0x6f0/0xc50 fs/read_write.c:855
 vfs_writev fs/read_write.c:928 [inline]
 do_writev+0x27a/0x470 fs/read_write.c:971
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e179f7fb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed4fe4448 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0e179f7fb9
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f0e179b7780 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
 </TASK>

The issue is caused when the value of index becomes greater than the
max size of array. Introducing check before accessing solves the issue.

The patch is tested via syzbot.

Reported-by: syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
---
 fs/jfs/jfs_xtree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 2d304cee8..034a1613f 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -619,6 +619,10 @@ int xtInsert(tid_t tid,		/* transaction id */
 			(nextindex - index) * sizeof(xad_t));
 
 	/* insert the new entry: mark the entry NEW */
+	if (index >= XTROOTMAXSLOT) {
+		rc = -EINVAL;
+		goto out;
+	}
 	xad = &p->xad[index];
 	XT_PUTENTRY(xad, xflag, xoff, xlen, xaddr);
 
-- 
2.34.1

