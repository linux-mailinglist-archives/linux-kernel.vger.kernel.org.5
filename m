Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47678AFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjH1MJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjH1MIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:08:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D62C12A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:08:51 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B60951EC00D9;
        Mon, 28 Aug 2023 14:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693224529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=m9qQajt1NMldov11fYodprG1XV0qq4l9ENJTE93EeLo=;
        b=eQPJSmP/RoMSFGATpHzVB3h+JwglbqIsUDAKnc2NG7IFeQFYewNXC9e0VXR84qHQcbiAF0
        8aG8QPtaEtd+B7FftHHJj3TLVPfM9gDjMaKB3/FWyQft0s4P5WMqLaLyIZowYIqsNxhgPF
        0BSU4LZFfUfV9PVKlfwPSATaUQJwwyM=
Date:   Mon, 28 Aug 2023 14:08:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.6-rc1
Message-ID: <20230828120847.GAZOyOT4IQn1XImJz4@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the small SEV pile for 6.6.

Thx.

---

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.6_rc1

for you to fetch changes up to ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2:

  x86/sev: Make enc_dec_hypercall() accept a size instead of npages (2023-08-25 13:33:48 +0200)

----------------------------------------------------------------
- Handle the case where the beginning virtual address of the address
  range whose SEV encryption status needs to change, is not page aligned
  so that callers which round up the number of pages to be decrypted,
  would mark a trailing page as decrypted and thus cause corruption
  during live migration.

- Return an error from the #VC handler on AMD SEV-* guests when the debug
  registers swapping is enabled as a DR7 access should not happen then
  - that register is guest/host switched.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      x86/sev: Do not handle #VC for DR7 read/write

Steve Rutherford (1):
      x86/sev: Make enc_dec_hypercall() accept a size instead of npages

 arch/x86/boot/compressed/sev.c     |  2 +-
 arch/x86/include/asm/mem_encrypt.h |  6 +++---
 arch/x86/kernel/kvm.c              |  4 +---
 arch/x86/kernel/sev.c              |  6 ++++++
 arch/x86/mm/mem_encrypt_amd.c      | 13 ++++++-------
 5 files changed, 17 insertions(+), 14 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
