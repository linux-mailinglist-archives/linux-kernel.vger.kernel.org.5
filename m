Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C977084C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHDS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHDS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE0BA9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24FED620FA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFB5C433C8;
        Fri,  4 Aug 2023 18:56:33 +0000 (UTC)
Date:   Fri, 4 Aug 2023 19:56:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.5-rc5
Message-ID: <ZM1J35gT1jjr96Vh@arm.com>
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

Please pull the arm64 fixes below. Thanks.

The following changes since commit 003e6b56d780095a9adc23efc9cb4b4b4717169b:

  ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info() (2023-07-28 14:50:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 69af56ae56a48a2522aad906c4461c6c7c092737:

  arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE (2023-08-04 16:18:32 +0100)

----------------------------------------------------------------
More SVE/SME fixes for ptrace() and for the (potentially future) case
where SME is implemented in hardware without SVE support.

----------------------------------------------------------------
Mark Brown (5):
      arm64/fpsimd: Clear SME state in the target task when setting the VL
      arm64/ptrace: Flush FP state when setting ZT0
      arm64/ptrace: Don't enable SVE when setting streaming SVE
      arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
      arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE

 arch/arm64/kernel/fpsimd.c |  9 +++++----
 arch/arm64/kernel/ptrace.c | 10 +++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
Catalin
