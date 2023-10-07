Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF50C7BC99B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjJGSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911493;
        Sat,  7 Oct 2023 11:53:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F4EC433C7;
        Sat,  7 Oct 2023 18:53:18 +0000 (UTC)
Date:   Sat, 7 Oct 2023 20:53:15 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.6-rc5
Message-ID: <ZSGpG0hwU9O5S9vD@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two parisc fixes kernel 6.6-rc5 which fix
* randome memory faults on pre-PA8800 CPUs, and
* boot issues.
Both patches are tagged for stable series.

They have been in for-next since kernel 6.6-rc2 without
any issues.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc5

for you to fetch changes up to 914988e099fc658436fbd7b8f240160c352b6552:

  parisc: Restore __ldcw_align for PA-RISC 2.0 processors (2023-10-07 20:30:16 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.6-rc5:

* fix random faults in mmap'd memory on pre PA8800 processors
* fix boot crash with nr_cpus=1 on kernel command line

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix crash with nr_cpus=1 option

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

 arch/parisc/include/asm/ldcw.h           | 37 +++++++++++++++++---------------
 arch/parisc/include/asm/spinlock_types.h |  5 -----
 arch/parisc/kernel/smp.c                 |  4 +++-
 3 files changed, 23 insertions(+), 23 deletions(-)
