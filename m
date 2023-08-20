Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32E781E43
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjHTO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjHTO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 10:29:48 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4124230
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 07:25:48 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1bdca574b7fso39015775ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692541548; x=1693146348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5isyP5ddHp+TzLlEcMSxkju05RmqZLUsE2FHguLbe4=;
        b=dgc4JYYTVMCCxhAlXczM6O7IS3xlygtkyUNdDl9DqZaYiD52JM55CGryaER4uUOhoT
         3JOGYglYPt4qXByrPsGdhMXLj/eoMeFiFqmKqhrNpgkxl2wNGfJULkwNgC5ASPWOQNcE
         Xa8PA9c8imvAJWnkiDreFY/h/DmPeLAZN2FiO92HZxFswWLqa4y3iQHfWVqG9Ivo35Ft
         qdB3DnwfC2SH6/YNFiSDSJuKZLhaTaCcc9tbqlrNOqh7X5aLAaPd/zGOhPRBY4I5XftC
         c33XM2uT0P8/saJkjOwF+CfNRwV6fklkTUbVsR10n8+AvetrPaKialA36H42j5MWcbui
         eu+g==
X-Gm-Message-State: AOJu0Yw7OvWXvGNdHJECkAzNpnW1YrJBQe01EtB3sIMttHmY+fqaG03d
        VIRxIzCck6z+M6eN1D5pvAeRhaSmMAxdTc+Jfsc6/PY85VWd
X-Google-Smtp-Source: AGHT+IHpal02TOIZIdpNOi+Q7DWRJ2De8uy3r7KEcJz9UE0DkuBk6UrwL7BzT82hs6aXEIno5XXnM9mFm0ZnaqfY0zQI4yJWfwdN
MIME-Version: 1.0
X-Received: by 2002:a17:902:f688:b0:1b8:c6ba:bf75 with SMTP id
 l8-20020a170902f68800b001b8c6babf75mr2090071plg.0.1692541547877; Sun, 20 Aug
 2023 07:25:47 -0700 (PDT)
Date:   Sun, 20 Aug 2023 07:25:47 -0700
In-Reply-To: <0000000000000fdc630601cd9825@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba9f2406035b8927@google.com>
Subject: Re: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in udf_process_sequence
From:   syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9e6c269de404 Merge tag 'i2c-for-6.5-rc7' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=139aa5efa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ed6bba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c8923a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d01305b8482/disk-9e6c269d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7317878934a/vmlinux-9e6c269d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7333ff86494/bzImage-9e6c269d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2ad8331a86f3/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/049e481cc897/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com

UBSAN: array-index-out-of-bounds in fs/udf/super.c:1365:9
index 4 is out of range for type '__le32[4]' (aka 'unsigned int[4]')
CPU: 0 PID: 6060 Comm: syz-executor319 Not tainted 6.5.0-rc6-syzkaller-00253-g9e6c269de404 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 udf_load_sparable_map fs/udf/super.c:1365 [inline]
 udf_load_logicalvol fs/udf/super.c:1457 [inline]
 udf_process_sequence+0x300d/0x4e70 fs/udf/super.c:1773
 udf_load_sequence fs/udf/super.c:1820 [inline]
 udf_check_anchor_block+0x2a6/0x550 fs/udf/super.c:1855
 udf_scan_anchors fs/udf/super.c:1888 [inline]
 udf_load_vrs+0x5ca/0x1100 fs/udf/super.c:1969
 udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2147
 mount_bdev+0x276/0x3b0 fs/super.c:1391
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f363cae1c8a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 07 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6eac67a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f363cae1c8a
RDX: 0000000020000100 RSI: 0000000020000340 RDI: 00007ffe6eac6800
RBP: 00007ffe6eac6840 R08: 00007ffe6eac6840 R09: 0000000000000c35
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000340
R13: 0000000020000100 R14: 0000000000000c3b R15: 0000000020020500
 </TASK>
================================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
