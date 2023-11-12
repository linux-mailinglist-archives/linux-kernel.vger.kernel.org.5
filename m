Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8E7E8E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 06:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjKLFOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 00:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLFN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 00:13:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81F30C5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 21:13:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3362EC433C7;
        Sun, 12 Nov 2023 05:13:50 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.7
Date:   Sun, 12 Nov 2023 13:12:48 +0800
Message-Id: <20231112051248.272444-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.7

for you to fetch changes up to 1d375d65466e5c8d7a9406826d80d475a22e8c6d:

  selftests/bpf: Enable cpu v4 tests for LoongArch (2023-11-08 14:12:21 +0800)

----------------------------------------------------------------
LoongArch changes for v6.7

1, Support PREEMPT_DYNAMIC with static keys;
2, Relax memory ordering for atomic operations;
3, Support BPF CPU v4 instructions for LoongArch;
4, Some build and runtime warning fixes.

Note: There is a conflicts in arch/loongarch/include/asm/inst.h but can
be simply fixed by adjusting context.

----------------------------------------------------------------
Hengqi Chen (8):
      LoongArch: Add more instruction opcodes and emit_* helpers
      LoongArch: BPF: Support sign-extension load instructions
      LoongArch: BPF: Support sign-extension mov instructions
      LoongArch: BPF: Support unconditional bswap instructions
      LoongArch: BPF: Support 32-bit offset jmp instructions
      LoongArch: BPF: Support signed div instructions
      LoongArch: BPF: Support signed mod instructions
      selftests/bpf: Enable cpu v4 tests for LoongArch

Huacai Chen (3):
      Merge 'bpf-next 2023-10-16' into loongarch-next
      LoongArch: Support PREEMPT_DYNAMIC with static keys
      LoongArch/smp: Call rcutree_report_cpu_starting() earlier

Nathan Chancellor (1):
      LoongArch: Mark __percpu functions as always inline

WANG Rui (2):
      LoongArch: Disable module from accessing external data directly
      LoongArch: Relax memory ordering for atomic operations

 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/include/asm/atomic.h                |  88 ++++++++++---
 arch/loongarch/include/asm/inst.h                  |  13 ++
 arch/loongarch/include/asm/percpu.h                |  10 +-
 arch/loongarch/kernel/smp.c                        |   3 +-
 arch/loongarch/net/bpf_jit.c                       | 143 ++++++++++++++++-----
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |   3 +-
 tools/testing/selftests/bpf/progs/verifier_movsx.c |   3 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   3 +-
 13 files changed, 215 insertions(+), 63 deletions(-)
