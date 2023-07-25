Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A49761A78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGYNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjGYNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AE1FFC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3875461721
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33D9C433C7;
        Tue, 25 Jul 2023 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292927;
        bh=LXLUgJ1b5ben7ymSJZl38ByQpuIQlrctk2lq9h4zXpU=;
        h=From:To:Cc:Subject:Date:From;
        b=uTHwM1bcsk7ifY1XPOoPcsWVMse/ijuNBGh/1QQKjEDI+cJ8le6wD83Z+x5LhqGQL
         poEc9do4ezqpHqFc3xKjGZxfLI8xNGEadr7nqK0dGJVqdh+CWSIWq0rEMEik/Ae//G
         +MhREgsLG+E+0OhANWewLw6+GwHNlsjm8D6bfM2SCuTpQPDEZDpnVcX5/EH785qopd
         B9Cga0RtLjStn3U+nC3Hrtyk9kaXAdVfkE/GaFKmpKHXzwbk7YKYfVAU1gWYdPZYk/
         wsLRMBDDo0DoxLY43yUQvVcY0DoKDyeXiu6MhsoMoGWg9KZSLOPuGX+gMmCQaHcj5M
         loY+8Pzn20+pg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/5] remaining x86 -Wmissing-prototype warnings
Date:   Tue, 25 Jul 2023 15:48:32 +0200
Message-Id: <20230725134837.1534228-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Most of the patches addressing -Wmissing-prototype warnings were
already merged, including 16 of the 20 x86 patches I sent before,
and all except 10 other patches that I need to resubmit to other
trees.

I checked that these five are all still required and that there
were no remaining comments I needed to address.  Four patches
are from v1 of the series, the last one was sent separately
last time, and the contents are unchanged from the original
submission.

These patches have passed a few thousand randconfig builds with
the warning enabled.

Link: https://lore.kernel.org/lkml/20230516193549.544673-1-arnd@kernel.org/
Link: https://lore.kernel.org/lkml/20230519094035.11259-1-arnd@kernel.org/

Arnd Bergmann (5):
  [RESEND] x86: apic: hide unused safe_smp_processor_id on UP
  [RESEND] x86: avoid unneeded __div64_32 function definition
  [RESEND] x86: qspinlock-paravirt: fix mising-prototype warnings
  [RESEND] x86: purgatory: include header for warn() declaration
  [RESEND] x86: alternative: add __alt_reloc_selftest prototype

 arch/x86/boot/compressed/error.c          |  2 +-
 arch/x86/boot/compressed/error.h          |  2 +-
 arch/x86/include/asm/div64.h              |  2 ++
 arch/x86/include/asm/qspinlock_paravirt.h |  2 ++
 arch/x86/kernel/alternative.c             |  1 +
 arch/x86/kernel/apic/ipi.c                |  2 ++
 arch/x86/kernel/paravirt.c                |  2 ++
 arch/x86/purgatory/purgatory.c            |  1 +
 kernel/locking/qspinlock_paravirt.h       | 20 ++++++++++----------
 9 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.39.2

Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: linux-kernel@vger.kernel.org
