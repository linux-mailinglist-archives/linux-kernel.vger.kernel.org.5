Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64278A55D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjH1Fmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjH1FmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:42:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC911127
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:42:12 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-154-102.46.114.pool.telefonica.de [46.114.154.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 161F31EC00F4;
        Mon, 28 Aug 2023 07:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693201331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=xnozUyHr8EOFA7rgGCGq01eGVKOoNhC3d7OoxZqRxUA=;
        b=C6t59e7vQ0zGL/IGkTdHjPDgdEBfj2FbokCPlsN6wWBNQf2tWfjfKWj4aSxxxvAnBJ6M9L
        pSzlAalUPZyue7T1Txstx5ib1uo7nMIUZFk60gp3mC+OOd3nRKtabYMbBCB/Jo1wS6CdRb
        h1Xh4saw3B6lVBCMtgEwlUh/DxSK8ak=
Date:   Mon, 28 Aug 2023 07:42:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.6-rc1
Message-ID: <20230828054215.GBZOwzt/7NYwNRtP3U@fat_crate.local>
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

please pull some miscellaneous tip updates for 6.6.

Thx.

---

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.6_rc1

for you to fetch changes up to 1393bc8c6a3311bf6496e704c59870e0fc44a2c3:

  x86/uv: Update HPE Superdome Flex Maintainers (2023-08-11 09:02:39 -0700)

----------------------------------------------------------------
- Add PCI device IDs for a new AMD family 0x1a CPUs and use them in
  the respective drivers

- Update HPE Superdome Flex maintainers list

----------------------------------------------------------------
Avadhut Naik (3):
      x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
      hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
      EDAC/amd64: Add support for AMD family 1Ah models 00h-1Fh and 40h-4Fh

Justin Ernst (1):
      x86/uv: Update HPE Superdome Flex Maintainers

 MAINTAINERS               |  4 ++--
 arch/x86/kernel/amd_nb.c  |  8 ++++++++
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 drivers/hwmon/k10temp.c   |  8 +++++++-
 include/linux/pci_ids.h   |  2 ++
 5 files changed, 34 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
