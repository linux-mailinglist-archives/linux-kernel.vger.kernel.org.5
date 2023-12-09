Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6742280B3F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjLILYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:24:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93D10D8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 03:24:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29652C433C7;
        Sat,  9 Dec 2023 11:24:24 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.7-rc5
Date:   Sat,  9 Dec 2023 19:23:17 +0800
Message-Id: <20231209112317.1542046-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-2

for you to fetch changes up to e2f7b3d8b4b300956a77fa1ab084c931ba1c7421:

  LoongArch: BPF: Fix unconditional bswap instructions (2023-12-09 15:49:16 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.7-rc5

Preserve syscall nr across execve(), slightly clean up drdtime(), fix
the Clang built zboot kernel, fix a stack unwinder bug and several bpf
jit bugs.
----------------------------------------------------------------
Hengqi Chen (3):
      LoongArch: Preserve syscall nr across execve()
      LoongArch: BPF: Don't sign extend memory load operand
      LoongArch: BPF: Don't sign extend function return value

Jinyang He (1):
      LoongArch: Set unwind stack type to unknown rather than set error flag

Tiezhu Yang (2):
      LoongArch: BPF: Fix sign-extension mov instructions
      LoongArch: BPF: Fix unconditional bswap instructions

WANG Rui (1):
      LoongArch: Apply dynamic relocations for LLD

Xi Ruoyao (1):
      LoongArch: Slightly clean up drdtime()

 arch/loongarch/Makefile                 |  2 +-
 arch/loongarch/include/asm/elf.h        |  2 +-
 arch/loongarch/include/asm/loongarch.h  |  5 ++---
 arch/loongarch/kernel/stacktrace.c      |  2 +-
 arch/loongarch/kernel/unwind.c          |  1 -
 arch/loongarch/kernel/unwind_prologue.c |  2 +-
 arch/loongarch/net/bpf_jit.c            | 18 ++++++------------
 7 files changed, 12 insertions(+), 20 deletions(-)
