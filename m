Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA897D9EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJ0RTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjJ0RTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:19:02 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3A1B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:18:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03F5A40E01A4;
        Fri, 27 Oct 2023 17:18:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HllBJUNr44Gr; Fri, 27 Oct 2023 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698427135; bh=qDm3DudrZTAKns1U0BwDxZt3S4WMxDrw0oPKVGLRADY=;
        h=Date:From:To:Cc:Subject:From;
        b=jXNJU0evbHc96bLz+TYpIUlCi2+cNm3qNFckh4MgA642e1wNTkmzs6lbRPt4qum17
         Cx1AHaefc6aGdbi9eRwDnSg1fq0u5y+Y+xm9YhsmXpq0mdujf3FcmbktnV+BSaXtCJ
         +sjrH4BLHo/D/gFxNLLVwD+puVohyMH9O+SK+NI7r0bAXNI/aiTdixa/vXUkCl87oK
         TSgNPqRAzqTfP1azLWGKBGd4hAMgo4+WzL78hoR2NsCpu1P36wP7dq/gP9SQ8K5MP2
         wDbmVdK850I6G/40bzt1geLQr9nQ5slliFJ/SKbWZ4+vJTI9Yb/jzuYe2ZXWJXEpXD
         jaGEI2w+o489Djn+Ep75yHPrGjlxjnbUFRkm+DJ5R6ysV3HwVBVTjs2ZzPlbgiukfN
         J2xMEFS2WtONX3HeY/Ig39p88/tesEkDImRwDcB3T02mpdkqLLzL6nWDRyytfEJpaB
         mx9kmOHgETBawZJKBewLFDqE9XrfemZ46epev5XzK9c6gcAQ15lFiu81EUvXyu/lqJ
         /VVHeMbzYHwYG6vfFT62IayjI+T4zjfs+mlYpCCiQIExcny8D2OdQVoF/eemfAZyWj
         UAcfO648DUeqtpYH7IcPI/RuPvOc7K8MGthZoVWLj6eCMFB6czywJAyuhZo04vI8n3
         jJ5ztMT/baq5zAgTteCYMWJk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8AD340E018F;
        Fri, 27 Oct 2023 17:18:52 +0000 (UTC)
Date:   Fri, 27 Oct 2023 19:18:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v6.7
Message-ID: <20231027171846.GPZTvw9k7KBkOXXONF@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of x86/platform updates for 6.7.

Thx.

---

The following changes since commit f0b0d403eabbe135d8dbb40ad5e41018947d336c:

  Merge tag 'kbuild-fixes-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2023-09-16 15:27:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.7_rc1

for you to fetch changes up to 2a565258b3f4bbdc7a3c09cd02082cb286a7bffc:

  x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs (2023-10-03 11:25:01 +0200)

----------------------------------------------------------------
- Make sure PCI function 4 IDs of AMD family 0x19, models 0x60-0x7f are
  actually used in the amd_nb.c enumeration

- Add support for extracting NUMA information from devicetree for
  Hyper-V usages

- Add PCI device IDs for the new AMD MI300 AI accelerators

- Annotate an array in struct uv_rtc_timer_head with the new
  __counted_by attribute

- Rework UV's NMI action parameter handling

----------------------------------------------------------------
Hans de Goede (1):
      x86/platform/uv: Rework NMI "action" modparam handling

Kees Cook (1):
      x86/platform/uv: Annotate struct uv_rtc_timer_head with __counted_by

Muralidhara M K (1):
      x86/amd_nb: Add AMD Family MI300 PCI IDs

Saurabh Sengar (2):
      x86/of: Move the x86_flattree_get_config() call out of x86_dtb_init()
      x86/numa: Add Devicetree support

Yazen Ghannam (1):
      x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

 arch/x86/Kconfig               |   1 +
 arch/x86/include/asm/prom.h    |   5 ++
 arch/x86/kernel/amd_nb.c       |   8 ++++
 arch/x86/kernel/devicetree.c   |   6 +--
 arch/x86/kernel/setup.c        |   2 +
 arch/x86/mm/numa.c             |   3 ++
 arch/x86/platform/uv/uv_nmi.c  | 104 ++++++++++++++++++++++-------------------
 arch/x86/platform/uv/uv_time.c |   2 +-
 include/linux/pci_ids.h        |   1 +
 9 files changed, 79 insertions(+), 53 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
