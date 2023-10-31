Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860D7DD7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbjJaV2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjJaV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:28:35 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88993C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:28:32 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1ef34202c46so9687555fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698787712; x=1699392512;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2Vs5U59vWGPE/rIb3YaRfc5Sccg44ldMyyzedRiPD0=;
        b=PdkjTYmnD1IQBcKxv4ECxoFLCcFBTp7VrIxazADZmzW5lL6/u0vULF1U6QPmMbz3T3
         iyYSo9KIv5Q3/acYXTviOvvcIkk/jcjWB5OVB4eOQiA/vJ7G5EnPWbr2JzC5AKkUZN4L
         G5iX2WVPwaeKlASXBrqW+sAoHrrynN/8HFoWMJ8XrEr/8J+yfJjdQu1YLaSeefTD2mAv
         JAmKMpffXl9KdBs8kl4ZYklKZ13J6yfkV321H5cC+lDvpP8QMmn5t8PDyJzY3uUVCTIy
         MQft8qQNbfAvwr/p0VlONTPZ6UMVMSDT9hcHB+weYVTV/aMEGgX02Ws+rCz+/xR+9+ll
         FHbg==
X-Gm-Message-State: AOJu0YwDwfy/ME8NY6QyLEH6iTBc9xuWeph/kOO5s1PztneioFGEAyTx
        /puLtC1RmyTMEXakkI/WaaACZXczwqwNiEQHpO1DKF7FQyuM
X-Google-Smtp-Source: AGHT+IFOFKRcniiClnO2rx0TvJFg4cAGatIzCYLQgXb3K5w/1/06MgPtajg8U+ntgazohH+QcGR8MTMsBE4PHOJqcKCZkFQE0FgB
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e38d:b0:1f0:15e3:11a5 with SMTP id
 x13-20020a056870e38d00b001f015e311a5mr1181367oad.10.1698787711965; Tue, 31
 Oct 2023 14:28:31 -0700 (PDT)
Date:   Tue, 31 Oct 2023 14:28:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001edf23060909d664@google.com>
Subject: [syzbot] [mm?] WARNING in __gup_longterm_locked (2)
From:   syzbot <syzbot+f2577d8071a92e596253@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    750b95887e56 Merge tag 'drm-fixes-2023-10-27' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bc757680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58203ba9e54216c8
dashboard link: https://syzkaller.appspot.com/bug?extid=f2577d8071a92e596253
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-750b9588.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b80db9192f2c/vmlinux-750b9588.xz
kernel image: https://storage.googleapis.com/syzbot-assets/859893b5032c/Image-750b9588.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2577d8071a92e596253@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 29908 at mm/gup.c:1297 __get_user_pages+0x368/0x3ac mm/gup.c:1297
Modules linked in:
CPU: 1 PID: 29908 Comm: syz-executor.1 Not tainted 6.6.0-rc7-syzkaller-00137-g750b95887e56 #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __get_user_pages+0x368/0x3ac mm/gup.c:1297
lr : __get_user_pages+0x360/0x3ac mm/gup.c:1295
sp : ffff80008a2bbaa0
x29: ffff80008a2bbaa0 x28: 0000000000000000 x27: 0000000000080101
x26: 0000000000000000 x25: fdff000006a5ee40 x24: 00000000000001ff
x23: 0000000000000001 x22: 0000000000000000 x21: fdff000002c45540
x20: 0000000000000242 x19: 0000000020200700 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc53b4698
x14: 000000000000018f x13: 0000000000000000 x12: ffff80008247fee8
x11: 0000000000000001 x10: 5479ecf2eae8e212 x9 : aa1a022e7ff96048
x8 : fdff000006a5fdc8 x7 : 0000000000000004 x6 : f9ff00002a61c000
x5 : 0000000000000000 x4 : fffffc0001f30000 x3 : 0000000000000002
x2 : 0000000000000007 x1 : fffffc0001f30034 x0 : 0000000000000000
Call trace:
 __get_user_pages+0x368/0x3ac mm/gup.c:1297
 __get_user_pages_locked mm/gup.c:1504 [inline]
 __gup_longterm_locked+0x1c0/0xa10 mm/gup.c:2203
 pin_user_pages+0x78/0xa0 mm/gup.c:3377
 io_pin_pages+0x74/0x118 io_uring/rsrc.c:1052
 io_sqe_buffer_register+0x70/0x424 io_uring/rsrc.c:1091
 io_sqe_buffers_register+0x118/0x268 io_uring/rsrc.c:1209
 __io_uring_register io_uring/io_uring.c:4429 [inline]
 __do_sys_io_uring_register io_uring/io_uring.c:4607 [inline]
 __se_sys_io_uring_register io_uring/io_uring.c:4567 [inline]
 __arm64_sys_io_uring_register+0xfc/0xdb8 io_uring/io_uring.c:4567
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x40/0x114 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
