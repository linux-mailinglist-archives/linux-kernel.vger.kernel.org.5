Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8327E8DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjKLBZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 20:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLBZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 20:25:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A22D59
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 17:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1699752316;
        bh=7gwiB8Fg8kqP99lyRxFR15R7ZxKpn9Kg6BeeBha7Nog=;
        h=From:To:Cc:Subject:Date:From;
        b=U9HbrMHLQPVCbvOXtJC6l8819/TsXw5Y3ZlC5JZmahqBfKy9+CGUR4qyDHMCPHxNZ
         Kms8187cb5McX3IAkhnGaIubzGy41do6eHSSsU4sIuL4THuxg9OlliohdkcHLnqbeT
         9D05wv6z6emRbF0pW3Bp8z961yqvymZMdD6C/Q0RsmLAIkU9Yyv+e8QQ7fGP5p6i8N
         O2NrsHsjcOXYO+26pdgT5ZB9euntlvKHkOf/GGxR4DcV2FeuQiL22unuOEU8nS1lYn
         ChEqQe1J6nzf+W29t/rcBh06XNYRzxzjA9W1bRKcVVeQJeaEtqVrCHdBMXqkVazc93
         k0wbhdROlg6JQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SSZcX0JDyz4wdC;
        Sun, 12 Nov 2023 12:25:15 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com, tzimmermann@suse.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-2 tag
Date:   Sun, 12 Nov 2023 12:25:12 +1100
Message-ID: <878r73930n.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull a few more powerpc updates for 6.7:

The following changes since commit 707df298cbde200b939c70be2577b20775fe3345:

  Merge tag 'powerpc-6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2023-11-03 10:07:39 -1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-2

for you to fetch changes up to 644b6025bcaff59737270d812c70302f5a8d4a8f:

  powerpc/rtas: Fix ppc_rtas_rmo_buf_show() kernel-doc (2023-11-07 13:13:45 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.7 #2

 - Finish a refactor of pgprot_framebuffer() which dependend on some changes
   that were merged via the drm tree.

 - Fix some kernel-doc warnings to quieten the bots.

Thanks to: Nathan Lynch, Thomas Zimmermann.

- ------------------------------------------------------------------
Nathan Lynch (2):
      powerpc/pseries/rtas-work-area: Fix rtas_work_area_reserve_arena() kernel-doc
      powerpc/rtas: Fix ppc_rtas_rmo_buf_show() kernel-doc

Thomas Zimmermann (3):
      powerpc/machdep: Remove trailing whitespaces
      powerpc: Remove file parameter from phys_mem_access_prot()
      powerpc/fb: Call internal __phys_mem_access_prot() in fbdev code


 arch/powerpc/include/asm/fb.h                   |  7 +------
 arch/powerpc/include/asm/machdep.h              | 13 ++++++-------
 arch/powerpc/include/asm/pci.h                  |  4 +---
 arch/powerpc/include/asm/pgtable.h              | 10 ++++++++--
 arch/powerpc/kernel/pci-common.c                |  3 +--
 arch/powerpc/kernel/rtas-proc.c                 |  2 ++
 arch/powerpc/mm/mem.c                           |  8 ++++----
 arch/powerpc/platforms/pseries/rtas-work-area.c |  1 +
 8 files changed, 24 insertions(+), 24 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmVQKR4ACgkQUevqPMjh
pYCHnw//bL9g7D/SOM6cLCTFs3INADo4Tvur/Y6KzIywDGMlGAcrScwbfcplfUIZ
vjGuUdJE2VRGsoNBineyovM6njXHhQ48cpgD7smr3giU1Qz3UlrNlzIqO5N23AlO
USHFRT1enP/pv9LelapiVJocVXiqatY+nIhzJjj+yvsVYSI+5Aq+4f83jM0JvHzK
y3yNgQm0xZZy86tOkm4jQZ4UKg5M4Ua92dCxKkgwshC2gsLI+TXIxRaP1PM3NDn8
3FZtrDzj9QR0ABooLDzh5rcndU+Un1VoFJgkzlBBPh3Ad0AQ0xQxOwPAlEicrru+
uEo5/bL+CsHdvd/tgf/x+3zjhNtDCx1p7Onz2Zp/iTzGWNq1BpB356AWSnjCIOdv
neg1kH+t+pMWf5NPOs+Idn6glKXK8eICMW6Mm1xlFzqV6YLObGVSOOzZJ5ehR8nN
OdZ3l+U6KyaEnLmpAhNfbh2cPue56JvnzPINpm5vleSvTN2OaajlMVjunwxt7YJl
MBNVHawaVYLUXXS6gmFo7/0q0QXAjpHYPQOhiLETLsV2vhbF25wmmphbakj63rlH
NokpCxRf0KZ5k0sT3GNhiETFJ0//jbyUgFKAh9PfmIusv0Haqu4/GZgwXy9+cazq
V9kQnQjpeUm3FxcUKRtQ9YZSXGdIuwXsIpy54dfcRtcUF7UX+5I=
=Cqjh
-----END PGP SIGNATURE-----
