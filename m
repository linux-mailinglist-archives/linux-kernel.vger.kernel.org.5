Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B17EDC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKPHk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjKPHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:40:11 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0051BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:40:06 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a82f176860so5296857b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700120405; x=1700725205; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XYrQdmJabhQq1WXoge8RXAC/vRLuqHvLCc6AkfpfcU=;
        b=Paufe/g60KuMS40fbWgXfV6aj8gu+F7YOANBMWxxXHdCTyVFqNklPqfvoBO5yAuddB
         OPLHMX/JShjvCkVApgcQHDPnREbUvHKQqEz5/bx8MSKq0S5dzWlx705PgSvnVF1EecxX
         ArNtI79qJ3rI0zLtXNMgQIJF0Cky1mKxm5fy1Gcw32wvXwPZWMVBWT8UlwUGeKtwGlpZ
         6892QV/H3tSJ9TqU7Dar80/TnGzkFc3S3/VY9SntHHn2PflpVOatbKUV0toGccfLvaL8
         0/LRFwkq/tCFLz4ZpTlBzg/3PJHlV1q9eYFFxWhq7W6zJS060FlXAxQuPZ7CVnUaEVRP
         0RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700120405; x=1700725205;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XYrQdmJabhQq1WXoge8RXAC/vRLuqHvLCc6AkfpfcU=;
        b=StVRShBBBDGN4GLb6A29SIy0YXjoECyKRtBUSakZpgd6WHtQu74jRisIuIsbCO+NKL
         vDNbnpjxo0UAJHIWIbvVnFy2e8lUlJzK7L7hQLfp8YpgOp3oDqDE5U6BV3BaMDntdt6c
         /GnvfqK8UqjPnVvEpbA1K9Prmfyw+1vfpbtvvdOGsiYYzUIQ7/L5YUYy08itBtzN6/eO
         ZyhyU+QT0yfL97k/xRixYP3YEYk0gfUU+ounxF9IB6XqS4ArDjbYLYhmt64kAxiP170V
         r33EreCRLXh2COtvA90BgFnqJSR/2zCdQHn2JuWUDVIrL7zR4338G6CyizPrgju1jww8
         qSxg==
X-Gm-Message-State: AOJu0YzB21FGQWpJj5/29dtklUqLI5k3Dgbqsha2R+vEk6nP2zpzn5gW
        UeHcd8/ak1k0UAqIGl10QL0ZyQ==
X-Google-Smtp-Source: AGHT+IEo5B/VhZW5obgiD5HYKqE738NPiAOf7BmZyJeNGSUUZxxyApujezlldFz6BcWvP9gOv0vP3w==
X-Received: by 2002:a25:d3c3:0:b0:da1:13b7:8a87 with SMTP id e186-20020a25d3c3000000b00da113b78a87mr15185339ybf.15.1700120405134;
        Wed, 15 Nov 2023 23:40:05 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d131-20020a254f89000000b00d9a4aad7f40sm757225ybb.24.2023.11.15.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:40:04 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:39:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        jose.pekkarinen@foxhound.fi, willy@infradead.org, jannh@google.com,
        hughd@google.com
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 __pte_offset_map_lock
In-Reply-To: <0000000000005e44550608a0806c@google.com>
Message-ID: <c659f5c9-5e4f-0aac-7d1c-ee3be4740a0d@google.com>
References: <0000000000005e44550608a0806c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    78124b0c1d10 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=111b0e71680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f27cd6e68911e026
> dashboard link: https://syzkaller.appspot.com/bug?extid=89edd67979b52675ddec
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b8e671680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a9df5680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bd512de820ae/disk-78124b0c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a47a437b1d4f/vmlinux-78124b0c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3ae8b966bcd7/Image-78124b0c.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address dfff800000000004
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000004] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 7952 Comm: syz-executor682 Not tainted 6.6.0-rc6-syzkaller-g78124b0c1d10 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
> lr : lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
> sp : ffff800098f26d40
> x29: ffff800098f27000 x28: ffff8000808df4bc x27: ffff7000131e4e18
> x26: 1ffff00011c340b9 x25: 0000000000000000 x24: 0000000000000000
> x23: ffff7000131e4dd0 x22: 0000000000000000 x21: 0000000000000000
> x20: 0000000000000000 x19: 0000000000000022 x18: ffff800098f27750
> x17: 0000ffff833dafff x16: ffff80008a632120 x15: 0000000000000001
> x14: ffff80008e1a05d0 x13: ffff800098f26e80 x12: dfff800000000000
> x11: ffff800080319468 x10: ffff80008e1a05cc x9 : 00000000000000f3
> x8 : 0000000000000004 x7 : ffff8000808df4bc x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000022
> Call trace:
>  __lock_acquire+0x104/0x75e8 kernel/locking/lockdep.c:5004
>  lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  __pte_offset_map_lock+0x154/0x360 mm/pgtable-generic.c:373
>  pte_offset_map_lock include/linux/mm.h:2939 [inline]
>  filemap_map_pages+0x698/0x11f0 mm/filemap.c:3582
>  do_fault_around mm/memory.c:4525 [inline]
>  do_read_fault mm/memory.c:4558 [inline]
>  do_fault mm/memory.c:4705 [inline]
>  do_pte_missing mm/memory.c:3669 [inline]
>  handle_pte_fault mm/memory.c:4978 [inline]
>  __handle_mm_fault mm/memory.c:5119 [inline]
>  handle_mm_fault+0x326c/0x49fc mm/memory.c:5284
>  faultin_page mm/gup.c:956 [inline]
>  __get_user_pages+0x3e0/0xa24 mm/gup.c:1239
>  populate_vma_page_range+0x254/0x328 mm/gup.c:1666
>  __mm_populate+0x240/0x3d8 mm/gup.c:1775
>  mm_populate include/linux/mm.h:3305 [inline]
>  vm_mmap_pgoff+0x2bc/0x3d4 mm/util.c:551
>  ksys_mmap_pgoff+0xd0/0x5b0 mm/mmap.c:1400
>  __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>  __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>  __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> Code: b006f948 b943a108 34000208 d343fe68 (386c6908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	b006f948 	adrp	x8, 0xdf29000
>    4:	b943a108 	ldr	w8, [x8, #928]
>    8:	34000208 	cbz	w8, 0x48
>    c:	d343fe68 	lsr	x8, x19, #3
> * 10:	386c6908 	ldrb	w8, [x8, x12] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

Okay, let's try again by replying to the full orginal report
(see thread Matthew linked to for discussion leading to this):

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b85ea95d086471afb4ad062012a4d73cd328fa86

Subject: [PATCH] mm/pgtable: smp_rmb() to match smp_wmb() in pmd_install()

Not-Yet-Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memory.c          | 2 ++
 mm/pgtable-generic.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..8939357f1509 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -425,6 +425,8 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 * being the notable exception) will already guarantee loads are
 		 * seen in-order. See the alpha page table accessors for the
 		 * smp_rmb() barriers in page table walking code.
+		 *
+		 * See __pte_offset_map() for the smp_rmb() at the pte level.
 		 */
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
 		pmd_populate(mm, pmd, *pte);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4fcd959dcc4d..3330b666e9c3 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -297,6 +297,11 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		pmd_clear_bad(pmd);
 		goto nomap;
 	}
+	/*
+	 * Pair with the smp_wmb() in pmd_install(): make sure that the
+	 * page table lock and page table contents are visibly initialized.
+	 */
+	smp_rmb();
 	return __pte_map(&pmdval, addr);
 nomap:
 	rcu_read_unlock();
-- 
2.35.3
