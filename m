Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F137C7F0009
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKRN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKRN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:58:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673F1AD;
        Sat, 18 Nov 2023 05:58:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443A1C433C7;
        Sat, 18 Nov 2023 13:58:15 +0000 (UTC)
Date:   Sat, 18 Nov 2023 14:58:12 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] parisc architecture fixes for v6.7-rc1
Message-ID: <ZVjC9P0h5mw3ZbnD@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three small additional parisc fixes for kernel 6.7-rc2,
two of those are tagged for stable series.

On parisc we still sometimes need writeable stacks, e.g. if programs aren't
compiled with gcc-14. To avoid issues with the upcoming systemd-254 we
therefore have to disable prctl(PR_SET_MDWE) for now (for parisc only).

The other two patches are minor: a bugfix for the soft power-off on qemu
with 64-bit kernel and a patch from Kees to prefer strscpy() over strlcpy().

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc2

for you to fetch changes up to b8eaae484f79b37c602d112e131475013ab14519:

  parisc/power: Fix power soft-off when running on qemu (2023-11-17 16:54:27 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.7-rc2:

- Fix power soft-off on qemu
- Disable prctl(PR_SET_MDWE) since parisc sometimes still needs
  writeable stacks
- Use strscpy instead of strlcpy in show_cpuinfo()

----------------------------------------------------------------
Helge Deller (2):
      prctl: Temporarily disable prctl(PR_SET_MDWE) on parisc
      parisc/power: Fix power soft-off when running on qemu

Kees Cook (1):
      parisc: Replace strlcpy() with strscpy()

 arch/parisc/kernel/processor.c |  2 +-
 drivers/parisc/power.c         |  2 +-
 kernel/sys.c                   | 10 ++++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)
