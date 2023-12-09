Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847880B107
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574913AbjLIAdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjLIAdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956F01724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:33:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6555C433C7;
        Sat,  9 Dec 2023 00:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702081993;
        bh=3Z8YdkNLvvbina63xYK5Sl+tNJdnGJfRB2Ip9dtMGMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=r0o8/TKUMJ/Roj1bQ9tBX/3SrKZ/N7tZNY9AsWK9S/roVZ7UYPf489jxogIlZeWVz
         fIWMnr2YwyEBieku7+k7nEXWrK8tufI4rqqYm2GkGxx57v208QL3bbOKBllL/zVcMY
         1D222pM52kJ1qF41PCBs+ZMrtJZzRZbv80NQ6PCaGB42L1tU8ggungF8UmL/bcPPTy
         i4sFiIpwzADjESecIG7d8cmUAdeK2PhLFroCck1muBXJfES60kf95wAVlbgAIL0gTl
         Dfd8rOssktbDR8kg5XOVgcHaRCe5l2wH2i5hRCmt1bTG15DxtBwqdm4f4D/gtSWrg+
         2KirlS1mFICNA==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Pavel.Kozlov@synopsys.com,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 0/5] ARC updates
Date:   Fri,  8 Dec 2023 16:33:02 -0800
Message-Id: <20231209003307.480051-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A pile of accrued changes, compile tested only.
Please test.

Thx,
-Vineet

Vineet Gupta (5):
  ARC: entry: SAVE_ABI_CALLEE_REG: ISA/ABI specific helper
  ARC: entry: move ARCompact specific bits out of entry.h
  ARC: mm: retire support for aliasing VIPT D$
  ARC: fix spare error
  ARC: fix smatch warning

 arch/arc/Kconfig                     |   5 -
 arch/arc/include/asm/cacheflush.h    |  43 ---------
 arch/arc/include/asm/entry-arcv2.h   |  32 +++++++
 arch/arc/include/asm/entry-compact.h |  87 ++++++++++++++++-
 arch/arc/include/asm/entry.h         | 110 +---------------------
 arch/arc/include/asm/ptrace.h        |  14 +--
 arch/arc/kernel/setup.c              |   4 +-
 arch/arc/kernel/signal.c             |   6 +-
 arch/arc/mm/cache.c                  | 136 ++-------------------------
 arch/arc/mm/mmap.c                   |  21 +----
 arch/arc/mm/tlb.c                    |  16 +---
 11 files changed, 148 insertions(+), 326 deletions(-)

-- 
2.34.1

