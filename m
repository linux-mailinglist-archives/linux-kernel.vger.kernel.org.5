Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A77791ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjIDVIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIDVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3301AB;
        Mon,  4 Sep 2023 14:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9193860B42;
        Mon,  4 Sep 2023 21:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72F8C433C8;
        Mon,  4 Sep 2023 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693861700;
        bh=cdgfiBNEn9HoKjZTlY823JkzNVlwsy/UoHPnZDeIZnY=;
        h=Date:From:To:Cc:Subject:From;
        b=h65czxsX8xTPS8zeDvROjj1f0F7nBX0j/QQ6dkmOhLLq4Qaq21Iknvs4mKLMY3w/v
         +PmzM9sSP3pV1Fb65e1oWrkFFAaiFC535MhnMdIgWtL+IVChqqZA2plHMOCpP8LBjo
         k2qTPCmCRXiT27yzlWOE6z2sAFGKdE6gQftoHGXc=
Date:   Mon, 4 Sep 2023 14:08:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] remaining MM updates for 6.6-rc1
Message-Id: <20230904140819.b49a4ff6366047ddcb2d9b1f@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this small batch of MM updates for this -rc cycle,
thanks.

The following changes since commit 52ae298e3e5c9be5bb95e1c6d9199e5210f2a156:

  maple_tree: shrink struct maple_tree (2023-08-24 16:20:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-09-04-14-00

for you to fetch changes up to e68d343d2720779362cb7160cb7f4bd24979b2b4:

  mm/kmemleak: move up cond_resched() call in page scanning loop (2023-09-02 15:17:34 -0700)

----------------------------------------------------------------
- Stefan Roesch has added ksm statistics to /proc/pid/smaps

- Also a number of singleton patches, mainly cleanups and leftovers.

----------------------------------------------------------------
Baruch Siach (2):
      rmap: remove anon_vma_link() nommu stub
      MAINTAINERS: add rmap.h to mm entry

Jiaqi Yan (1):
      mm/hwpoison: rename hwp_walk* to hwpoison_walk*

Johannes Weiner (1):
      mm: page_alloc: remove stale CMA guard code

Miaohe Lin (1):
      mm: memory-failure: add PageOffline() check

Stefan Roesch (1):
      proc/ksm: add ksm stats to /proc/pid/smaps

Waiman Long (1):
      mm/kmemleak: move up cond_resched() call in page scanning loop

 Documentation/filesystems/proc.rst |  4 ++++
 MAINTAINERS                        |  1 +
 fs/proc/task_mmu.c                 |  6 ++++++
 include/linux/rmap.h               |  1 -
 mm/kmemleak.c                      |  5 +++--
 mm/memory-failure.c                | 21 +++++++++++----------
 mm/page_alloc.c                    | 21 ++++-----------------
 7 files changed, 29 insertions(+), 30 deletions(-)

