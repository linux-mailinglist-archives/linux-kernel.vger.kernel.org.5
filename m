Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51E760C96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjGYIDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjGYIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:02:59 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD111B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:02:56 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1ad34f55a63so9786322fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272176; x=1690876976;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8NSHuFxdP127UZg90SUwmiWfzCulp2KXUsCKi/Hvj4=;
        b=QxIW/3PN3PnXgTfC9aONoD2BKjK9FePmOLw7H2uBI9aXQgPIJXHFvd5/uF7G45Kl6B
         6tHFjLvtHxkegPn2ioDm6iQSojLfxcCYh1dKW+2KgXrJhVDaYCuU+dONgWfLr787NBys
         YRWyjgQxBCXYMdsr+hfkCEQWkfSwTwH0sWN5m6MdsDrwpzL4IC3A0c99oBezKlwc2lSI
         wgJmhQB28/isHGnfIkhylt8jzDdU0Wuk0y9VkuesZa0T588OHi+SgltsC++oWY+y8tTM
         StBIDM2RTIm8b1sYMN289ZzDF57VTqChK7EAULZNOFIKnLyEX062PaTMHVU/VQwTXjK2
         TQXQ==
X-Gm-Message-State: ABy/qLZHfANAaTJNNHWVbK8SP4/eOglD/YhH++Luvgp1bM4URQef0y6b
        eGMNcT4iA3g71+8PywZThsdjXG1rQRSSuEArQqJCcm+JegYeiArLYw==
X-Google-Smtp-Source: APBJJlHDBrqUV1inq8FuaY05Q12HUFeam2VgxzG7heNvgkMs649b1505R3L+I1LrxzT12/+D/+HJJN0dUiGKsSDxMmg3yDQvVxLO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a98:b0:1bb:6148:7c49 with SMTP id
 dt24-20020a0568705a9800b001bb61487c49mr8450759oab.8.1690272176223; Tue, 25
 Jul 2023 01:02:56 -0700 (PDT)
Date:   Tue, 25 Jul 2023 01:02:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a33bfc06014b28c9@google.com>
Subject: [syzbot] panic: runtime error: floating point error (2)
From:   syzbot <syzbot+a76d93c00034a9fd23f5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b2e452a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=a76d93c00034a9fd23f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13213daea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3b4b06a5f02/disk-46670259.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4db334f36495/vmlinux-46670259.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5977e704aeb2/bzImage-46670259.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a76d93c00034a9fd23f5@syzkaller.appspotmail.com

2023/07/21 06:55:36 executed programs: 1794
2023/07/21 06:55:42 executed programs: 1851
2023/07/21 06:55:47 executed programs: 1914
2023/07/21 06:55:52 executed programs: 1976
2023/07/21 06:55:57 executed programs: 2046
panic: runtime error: floating point error
[signal SIGFPE: floating-point exception code=0x80 addr=0x0 pc=0x561291]

goroutine 22 [running]:
github.com/google/syzkaller/prog.ArgCommon.Type(...)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/prog.go:61
github.com/google/syzkaller/prog.(*ConstArg).Size(0xc9f428?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/prog.go:79 +0x91
github.com/google/syzkaller/prog.foreachArgImpl({0xc9f4a8?, 0xc000fdba80?}, 0xc000873e80, 0xc00107fbb8)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/analysis.go:152 +0x3ca
github.com/google/syzkaller/prog.foreachArgImpl({0xc9f4e8?, 0xc00008aae0?}, 0xc000873e80, 0xc00107fbb8)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/analysis.go:168 +0x2ce
github.com/google/syzkaller/prog.ForeachArg(0xc00028eb90, 0x46734e?)
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/analysis.go:127 +0xde
github.com/google/syzkaller/prog.(*Prog).FallbackSignal(0xc001018b00, {0xc00086d180, 0x8, 0x0?})
	/syzkaller/gopath/src/github.com/google/syzkaller/prog/analysis.go:249 +0x275
github.com/google/syzkaller/pkg/ipc.addFallbackSignal(0xc0005001c0?, 0xc000857bc0)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:321 +0x146
github.com/google/syzkaller/pkg/ipc.(*Env).Exec(0xc00027c630, 0x0?, 0xc001018b00)
	/syzkaller/gopath/src/github.com/google/syzkaller/pkg/ipc/ipc.go:295 +0x359
main.(*Context).execute(0xc0005000e0, 0x0?, 0x0?, 0x0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/tools/syz-execprog/execprog.go:171 +0x146
main.(*Context).run(0xc0005000e0, 0x0?)
	/syzkaller/gopath/src/github.com/google/syzkaller/tools/syz-execprog/execprog.go:156 +0xc5
main.main.func3()
	/syzkaller/gopath/src/github.com/google/syzkaller/tools/syz-execprog/execprog.go:119 +0x5c
created by main.main
	/syzkaller/gopath/src/github.com/google/syzkaller/tools/syz-execprog/execprog.go:117 +0x588


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
