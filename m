Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284667E726F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjKITnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjKITnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:43:06 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12BF3C14
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:43:04 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28016806be2so1983737a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699558984; x=1700163784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVD34KHKqR3Bhfx+oD2849EgTKoQTRquYzUN6+ZpQWE=;
        b=uYxnRaUiGuQD7caAdt2gO0UtmPxHJgWxaA7SABQXSK11U3kkGjf0vMXUphpQEm7Knm
         opDTpO0rILgG4WdgHbiNEacPiexL+kneqLYKi/HJCoA+n1q0DpWWKvohd29o2NCPqM6v
         plF9zpjFZDG/4DLtC/tB7fpHxntV58QyhuO+xkuKg6zMJdiSqd4AYaf8d8O5OGEldtdS
         osNa/dATbmsMnZvie9HI15N6qsjoA3D5CwWCUnOKo2ygvOjDae38NyWdbkIYSCfJ77RX
         WVVvklSThvBsMf3mzB92e+gLN4GGdwk5cxT+9mLcGuIgIOH4sYy6vM5PrjhaTWyEXHMi
         fFzQ==
X-Gm-Message-State: AOJu0YzbUCqD8D7TSUunuq7IplyhXfAVqdSypsjY2T5/iu2eGbC4NomE
        6qmzCR3ME/C7t/ZX/7E2drfIlbUxFga7Y3ExWROxWCDBjUM8
X-Google-Smtp-Source: AGHT+IGvjKH9YWbCc1VGHDvMcDtQs3CYl6inO3EUNYWhtqXvNMRcbN9yNwdWDQgoB4ZKUk+Oak3KRvTWx9R9T08jhjyZYtNPot97
MIME-Version: 1.0
X-Received: by 2002:a17:90a:714b:b0:280:2830:90c0 with SMTP id
 g11-20020a17090a714b00b00280283090c0mr63075pjs.4.1699558984320; Thu, 09 Nov
 2023 11:43:04 -0800 (PST)
Date:   Thu, 09 Nov 2023 11:43:04 -0800
In-Reply-To: <20231109192355.108550-1-kdipendra88@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000890e560609bd69aa@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_bpf
From:   syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
To:     kdipendra88@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in nsim_xdp_set_prog

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6540 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nsim_prog_set_loaded drivers/net/netdevsim/bpf.c:100 [inline]
pc : nsim_bpf_offload drivers/net/netdevsim/bpf.c:113 [inline]
pc : nsim_xdp_offload_prog drivers/net/netdevsim/bpf.c:189 [inline]
pc : nsim_xdp_set_prog+0x3f4/0x568 drivers/net/netdevsim/bpf.c:208
lr : nsim_prog_set_loaded drivers/net/netdevsim/bpf.c:99 [inline]
lr : nsim_bpf_offload drivers/net/netdevsim/bpf.c:113 [inline]
lr : nsim_xdp_offload_prog drivers/net/netdevsim/bpf.c:189 [inline]
lr : nsim_xdp_set_prog+0x3d0/0x568 drivers/net/netdevsim/bpf.c:208
sp : ffff800097047730
x29: ffff800097047730 x28: dfff800000000000 x27: 1fffe000196b819f
x26: ffff800094eee000 x25: 1ffff000129ddc07 x24: dfff800000000000
x23: 0000000000000001 x22: ffff800094eee038 x21: 0000000000000020
x20: ffff0000cb5c0d18 x19: ffff800097047820 x18: ffff800097047580
x17: ffff8000805c1258 x16: ffff80008030c738 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800094eee000 x4 : 0000000000000000 x3 : ffff80008030c754
x2 : ffff0000cb5c0d18 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 nsim_prog_set_loaded drivers/net/netdevsim/bpf.c:100 [inline]
 nsim_bpf_offload drivers/net/netdevsim/bpf.c:113 [inline]
 nsim_xdp_offload_prog drivers/net/netdevsim/bpf.c:189 [inline]
 nsim_xdp_set_prog+0x3f4/0x568 drivers/net/netdevsim/bpf.c:208
 nsim_bpf+0x5ac/0xaec
 dev_xdp_install+0x124/0x2f0 net/core/dev.c:9199
 dev_xdp_attach+0xa4c/0xcc8 net/core/dev.c:9351
 dev_xdp_attach_link net/core/dev.c:9370 [inline]
 bpf_xdp_link_attach+0x300/0x710 net/core/dev.c:9540
 link_create+0x2c0/0x68c kernel/bpf/syscall.c:4954
 __sys_bpf+0x4d4/0x5dc kernel/bpf/syscall.c:5414
 __do_sys_bpf kernel/bpf/syscall.c:5448 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5446 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5446
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: 96b36ecd f94002a8 91008115 d343fea8 (38f86908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	96b36ecd 	bl	0xfffffffffacdbb34
   4:	f94002a8 	ldr	x8, [x21]
   8:	91008115 	add	x21, x8, #0x20
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38f86908 	ldrsb	w8, [x8, x24] <-- trapping instruction


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1097a35b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=44c2416196b7c607f226
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120c37df680000

