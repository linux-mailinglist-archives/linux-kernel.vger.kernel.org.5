Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE87F0223
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjKRS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:57:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F1AF;
        Sat, 18 Nov 2023 10:57:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1606C433C8;
        Sat, 18 Nov 2023 18:57:35 +0000 (UTC)
Date:   Sat, 18 Nov 2023 19:57:33 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Kees Cook <keescook@chromium.org>, Sam James <sam@gentoo.org>
Subject: [GIT PULL v2] parisc architecture fixes for v6.7-rc2
Message-ID: <ZVkJHUynkuBxVb7S@p100>
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

This is v2 of the pull request with the changes to the prctl() patch
as requested by you.

On parisc we still sometimes need writeable stacks, e.g. if programs aren't
compiled with gcc-14. To avoid issues with the upcoming systemd-254 we
therefore have to disable prctl(PR_SET_MDWE) for now (for parisc only).

The other two patches are minor: a bugfix for the soft power-off on qemu
with 64-bit kernel and prefer strscpy() over strlcpy().

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc2

for you to fetch changes up to 793838138c157d4c49f4fb744b170747e3dabf58:

  prctl: Disable prctl(PR_SET_MDWE) on parisc (2023-11-18 19:35:31 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.7-rc2:

- Fix power soft-off on qemu
- Disable prctl(PR_SET_MDWE) since parisc sometimes still needs
  writeable stacks
- Use strscpy instead of strlcpy in show_cpuinfo()

----------------------------------------------------------------
Helge Deller (2):
      parisc/power: Fix power soft-off when running on qemu
      prctl: Disable prctl(PR_SET_MDWE) on parisc

Kees Cook (1):
      parisc: Replace strlcpy() with strscpy()

 arch/parisc/kernel/processor.c | 2 +-
 drivers/parisc/power.c         | 2 +-
 kernel/sys.c                   | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)
