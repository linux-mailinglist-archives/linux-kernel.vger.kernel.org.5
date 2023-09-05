Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B05792FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbjIEUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbjIEUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:13:48 -0400
X-Greylist: delayed 288 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:13:25 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6B1731
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:13:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA3C433B7;
        Tue,  5 Sep 2023 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693940180;
        bh=9MKGXTwg319KKNK+UWnEwTq0UUK4qUJ8SLJdxwTvxio=;
        h=Date:From:To:Cc:Subject:From;
        b=Euf1RUjGSZIC49ti3z4Oh3+6zDdRadLfxrigMmp4JlTz2ncloKciRk3Tp4UUMZx3Q
         34PD2KP63GjfD2ZNdQj7tXTqIIWTg+0e70cNmT1jfl2O4Oax2grctDjezWSAro1uH+
         Pa9J9UKaoCOCwPKj/+GzxChAB6MQP85+xBtyTcGo=
Date:   Tue, 5 Sep 2023 11:56:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.6-rc1
Message-Id: <20230905115619.0df37e92cd7384252d1aa4ee@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 3f86ed6ec0b390c033eae7f9c487a3fea268e027:

  Merge tag 'arc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc (2023-09-04 15:38:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-09-05-11-51

for you to fetch changes up to f4b4f3ec1a310c3de9797271a9c06b7499470d69:

  sparc64: add missing initialization of folio in tlb_batch_add() (2023-09-05 11:11:52 -0700)

----------------------------------------------------------------
Seven hotfixes.  Four are cc:stable and the remainder pertain to issues
which were introduced in the current merge window.

----------------------------------------------------------------
Andrew Morton (1):
      revert "memfd: improve userspace warnings for missing exec-related flags".

Joel Fernandes (Google) (1):
      mm/vmalloc: add a safer version of find_vm_area() for debug

Johannes Weiner (1):
      memcontrol: ensure memcg acquired by id is properly set up

Mike Rapoport (IBM) (1):
      sparc64: add missing initialization of folio in tlb_batch_add()

Tong Tiangen (1):
      mm: memory-failure: use rcu lock instead of tasklist_lock when collect_procs()

Xie XiuQi (1):
      tools/mm: fix undefined reference to pthread_once

Zqiang (1):
      rcu: dump vmalloc memory info safely

 arch/sparc/mm/tlb.c |  1 +
 mm/filemap.c        |  3 ---
 mm/ksm.c            |  4 ++--
 mm/memcontrol.c     | 22 +++++++++++++++++-----
 mm/memfd.c          |  2 +-
 mm/memory-failure.c | 16 ++++++++--------
 mm/util.c           |  4 +++-
 mm/vmalloc.c        | 26 ++++++++++++++++++++++----
 tools/mm/Makefile   |  4 ++--
 9 files changed, 56 insertions(+), 26 deletions(-)

