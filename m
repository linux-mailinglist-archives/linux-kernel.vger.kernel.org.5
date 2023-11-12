Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F97E8EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKLHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:01:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E62D6B;
        Sat, 11 Nov 2023 23:00:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC2BC433C8;
        Sun, 12 Nov 2023 07:00:55 +0000 (UTC)
Date:   Sun, 12 Nov 2023 08:00:52 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.7-rc1 (part 2)
Message-ID: <ZVB4JP/NpxqHCb7a@p100>
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

please pull three small additional parisc fixes for kernel 6.7-rc1.
The first two are tagged for stable series.

- Include the upper 5 address bits when inserting TLB entries on a 64-bit
  kernel. On physical machines those are ignored, but in qemu it's nice to
  have them included and to be correct.
- Stop the 64-bit kernel and show a warning if someone tries to boot on a
  machine with a 32-bit CPU.
- Fix a "no previous prototype" warning in parport-gsc.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit be3ca57cfb777ad820c6659d52e60bbdd36bf5ff:

  Merge tag 'media/v6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2023-11-06 15:06:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1-2

for you to fetch changes up to a406b8b424fa01f244c1aab02ba186258448c36b:

  parisc: Prevent booting 64-bit kernels on PA1.x machines (2023-11-10 16:17:32 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.7-rc1 (part 2):

- Include upper 5 address bits of physical address in iitlbp
- Prevent booting 64-bit kernels on PA1.x machines
- parport-gsc: mark init function static

----------------------------------------------------------------
Arnd Bergmann (1):
      parport: gsc: mark init function static

Helge Deller (2):
      parisc/pgtable: Do not drop upper 5 address bits of physical address
      parisc: Prevent booting 64-bit kernels on PA1.x machines

 arch/parisc/kernel/entry.S    | 7 +++----
 arch/parisc/kernel/head.S     | 5 ++---
 drivers/parport/parport_gsc.c | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)
