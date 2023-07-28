Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F2767110
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjG1PvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjG1Pu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47399421B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E8A62185
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEBC433C7;
        Fri, 28 Jul 2023 15:50:53 +0000 (UTC)
Date:   Fri, 28 Jul 2023 16:50:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.5-rc4
Message-ID: <ZMPj2vX57s2hrNqk@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64/ACPI fixes below. Thanks.

The following changes since commit d4d5be94a87872421ea2569044092535aff0b886:

  arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes (2023-07-21 11:11:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 003e6b56d780095a9adc23efc9cb4b4b4717169b:

  ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info() (2023-07-28 14:50:50 +0100)

----------------------------------------------------------------
A couple of SME updates for recent fixes (one of which went to stable):
reverting the flushing of the SME hardware state along with the thread
flushing and making sure we have the correct vector length before
reallocating.

An ACPI/IORT fix to avoid skipping ID mappings whose "number of IDs" is
0 (the spec reports the number of IDs in the mapping range minus 1).

----------------------------------------------------------------
Guanghui Feng (1):
      ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()

Mark Brown (2):
      arm64/fpsimd: Don't flush SME register hardware state along with thread
      arm64/sme: Set new vector length before reallocating

 arch/arm64/kernel/fpsimd.c | 5 ++---
 drivers/acpi/arm64/iort.c  | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
Catalin
