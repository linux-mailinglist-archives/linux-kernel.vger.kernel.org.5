Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20C27A33C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjIQFDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 01:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIQFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:02:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935B19F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 22:02:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-250.bstnma.fios.verizon.net [108.26.156.250])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38H52ZgM023923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Sep 2023 01:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694926957; bh=DsT89jZ+DfXwhz8PQH/3bdXenHE9hyBUpXJCACKX3B4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Po5t2HJI1FnI65lv1Qz9dkEFilXVjOA3RaIee3TjX0aGPrN2NaQ1NwLZoYvX91k07
         CFx/Yuh6UjPI3jTqo0TmvTDbeX0WPIQdmKMjH86COLuLpD57KD/oDDyQf/wy4r6T9M
         +oMY88MX52bZvbBhLLel4vSx2IwG5+gJhhosX/+kH24rlXysizTsd0ojE3JJ9ryzh5
         OOfFtRgk3EeV198DuVzhHTLnrGCCoO4IaOm+uZkjtUYoVMIH4lams2gRNugS0S5bOE
         d5I48I1CfVIHjsqrpOGj6zMyrzNWVEbkTotubGstPnFvIhfQ3VvTHpUEiBq9h+AO4q
         BDJF/s7F37Tsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F39315C0338; Sun, 17 Sep 2023 01:02:35 -0400 (EDT)
Date:   Sun, 17 Sep 2023 01:02:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for v6.6-rc2
Message-ID: <20230917050235.GA1702062@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 768d612f79822d30a1e7d132a4d4b05337ce42ec:

  ext4: fix slab-use-after-free in ext4_es_insert_extent() (2023-08-27 11:27:13 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc2

for you to fetch changes up to 7fda67e8c3ab6069f75888f67958a6d30454a9f6:

  ext4: fix rec_len verify error (2023-09-14 12:07:07 -0400)

----------------------------------------------------------------
Regression and bug fixes for ext4.

----------------------------------------------------------------
Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Li Zetao (1):
      jbd2: Fix memory leak in journal_init_common()

Matthew Wilcox (Oracle) (1):
      buffer: Make bh_offset() work for compound pages

Ritesh Harjani (IBM) (1):
      jbd2: Remove page size assumptions

Shida Zhang (1):
      ext4: fix rec_len verify error

 fs/ext4/mballoc.c           | 54 ++++++++++++++++++++++++++++++++--------------------
 fs/ext4/namei.c             | 26 ++++++++++++++-----------
 fs/jbd2/commit.c            | 16 ++++++----------
 fs/jbd2/journal.c           |  2 ++
 fs/jbd2/transaction.c       | 12 ++++--------
 include/linux/buffer_head.h |  5 ++++-
 6 files changed, 64 insertions(+), 51 deletions(-)
