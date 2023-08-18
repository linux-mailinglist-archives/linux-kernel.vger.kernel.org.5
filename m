Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF68D7812DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357051AbjHRSZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379462AbjHRSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE22D7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3EC62EEA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF2FC433C8;
        Fri, 18 Aug 2023 18:24:53 +0000 (UTC)
Date:   Fri, 18 Aug 2023 19:24:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.5-rc7
Message-ID: <ZN+3cmX+pGEqCNrb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64/SME fixes below. Thanks.

The following changes since commit 69af56ae56a48a2522aad906c4461c6c7c092737:

  arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE (2023-08-04 16:18:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 2f43f549cd0b3164ea0345e59aa3958c0d243383:

  arm64/ptrace: Ensure that the task sees ZT writes on first use (2023-08-17 19:00:03 +0100)

----------------------------------------------------------------
Two more SME fixes related to ptrace(): ensure that the SME is properly
set up for the target thread and that the thread sees the ZT registers
set via ptrace.

----------------------------------------------------------------
Mark Brown (2):
      arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
      arm64/ptrace: Ensure that the task sees ZT writes on first use

 arch/arm64/include/asm/fpsimd.h |  4 ++--
 arch/arm64/kernel/fpsimd.c      |  6 +++---
 arch/arm64/kernel/ptrace.c      | 20 +++++++++++++++++---
 arch/arm64/kernel/signal.c      |  2 +-
 4 files changed, 23 insertions(+), 9 deletions(-)

-- 
Catalin
