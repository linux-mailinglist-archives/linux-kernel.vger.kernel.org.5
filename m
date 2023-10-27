Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108F7D955A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjJ0KgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbjJ0KgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:36:11 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440118A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:36:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 69B0B40E01A3;
        Fri, 27 Oct 2023 10:36:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pqili4MRJITt; Fri, 27 Oct 2023 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698402961; bh=lZu8D79HryPdfDRM6OUR2bQ7udyOil3om7m5TCGI91I=;
        h=Date:From:To:Cc:Subject:From;
        b=b4mgjE/aSV1IxLQ5cQjgbSQ6+XjoW/zipeNkvQtPL8sRAoFZuD8nXHc6IJ4VK59Ln
         jFmzXJa/iTZHreNU9/tu6SaWPf4YeYXa9SpyD45BP3JBAdxnApkLCTkcMY4H3m67v3
         cpIs7WTZNR/Xs3tKnVibX0sMVfOKI+b2StejEbPr8Mf9shisbOe9/CBUOwyq+ag+SN
         5hsTWFCHxepEvBePM2aP+MOUqAUyI6+JGlCVcrtwkBlLBKaiPmbiKkJTa3BDKcrw3f
         Fx8YSsO4wOQTLsRbQ0nr1oMeYkLECdckhy1VUz+NrdRBUNpGOUcVGdWz1fTcfNV+dI
         nLE2UWHZkDCcHolb94ud+ktkdL8AkhyDZNvMFsmJW2CaizWGV52gh4aH1Z6KOb1LF8
         lzPZJX7WRcD93uqUydID1kKAfpp17AK9m+rGlk8YmZUyIMdwTyGatDNwXDbIkE5AeF
         F7Psr1wgAPNN3X67X0gl/TafRZTYhTUdk/psjaPFruzavSQrMLiAYyFE7uBBvIcpiB
         0T1EAW8GT5i6YTOP7sF4Wsd68yeyV+nMYtkn78osRX4hrvXN5JGEIhJulIXTHECkBy
         GmesAnfiAKtYCPc7Y2AMvUGeRj/QDc27pqmaH96RlGHQfV1h0e3wk0hm2qpNJvwWeC
         HrUzrmJdOIpi2v49hzHYWMNM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 325CA40E0173;
        Fri, 27 Oct 2023 10:35:58 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:35:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v6.7
Message-ID: <20231027103552.GBZTuSiMcrT5zPb3Z1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of RAS updates for 6.7.

Thx.

---

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras_core_for_6.7_rc1

for you to fetch changes up to 1bae0cfe4a171ccc5f731426296e45beafa096b8:

  x86/mce: Cleanup mce_usable_address() (2023-10-16 15:37:01 +0200)

----------------------------------------------------------------
- Specify what error addresses reported on AMD are actually usable
  memory error addresses for further decoding

----------------------------------------------------------------
Yazen Ghannam (3):
      x86/MCE/AMD: Split amd_mce_is_memory_error()
      x86/mce: Define amd_mce_usable_address()
      x86/mce: Cleanup mce_usable_address()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      | 68 +++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/cpu/mce/core.c     | 32 ++++++------------
 arch/x86/kernel/cpu/mce/intel.c    | 20 +++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  4 +++
 5 files changed, 99 insertions(+), 27 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
