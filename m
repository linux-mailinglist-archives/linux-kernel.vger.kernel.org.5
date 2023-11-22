Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9847F49FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKVPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKVPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:13:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BD1B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:13:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6B9C433C7;
        Wed, 22 Nov 2023 15:13:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.7-rc3
Date:   Wed, 22 Nov 2023 23:12:45 +0800
Message-Id: <20231122151245.1730120-1-chenhuacai@loongson.cn>
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

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.7-1

for you to fetch changes up to c517fd2738f472eb0d1db60a70d91629349a9bf8:

  Docs/zh_CN/LoongArch: Update links in LoongArch introduction.rst (2023-11-21 15:03:26 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.7-rc3

Fix several build errors, a potential kernel panic, a cpu hotplug issue
and update links in documentations.
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Implement constant timer shutdown interface

Huacai Chen (3):
      LoongArch: Add __percpu annotation for __percpu_read()/__percpu_write()
      LoongArch: Silence the boot warning about 'nokaslr'
      LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL

Masahiro Yamada (1):
      LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi

WANG Rui (2):
      LoongArch: Explicitly set -fdirect-access-external-data for vmlinux
      LoongArch: Record pc instead of offset in la_abs relocation

Yanteng Si (2):
      Docs/LoongArch: Update links in LoongArch introduction.rst
      Docs/zh_CN/LoongArch: Update links in LoongArch introduction.rst

 Documentation/arch/loongarch/introduction.rst      |  4 ++--
 .../zh_CN/arch/loongarch/introduction.rst          |  4 ++--
 arch/loongarch/Makefile                            |  3 +++
 arch/loongarch/include/asm/asmmacro.h              |  3 +--
 arch/loongarch/include/asm/percpu.h                | 11 +++++------
 arch/loongarch/include/asm/setup.h                 |  2 +-
 arch/loongarch/kernel/relocate.c                   | 10 +++++++++-
 arch/loongarch/kernel/time.c                       | 23 +++++++++-------------
 arch/loongarch/mm/pgtable.c                        |  4 ++--
 9 files changed, 34 insertions(+), 30 deletions(-)
