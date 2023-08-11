Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8647798B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHKUsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHKUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D022D52;
        Fri, 11 Aug 2023 13:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0149675FE;
        Fri, 11 Aug 2023 20:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED428C433C8;
        Fri, 11 Aug 2023 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691786890;
        bh=qhTFdjxCxVJxM4HGWoRhYc9brbBxHaXHd0/cvVDJXaM=;
        h=Date:From:To:Cc:Subject:From;
        b=gFVcEykZwaXbakvfjYBLTY7wsr7KqVzn6Bs1hclxgZOEuoDhLP9ADOTo+NdmOha+q
         iLZkN1CR3bH1gwTQz12JX7BfH6p7a7nJEaK+Xx/+GMWuy1gID3xIJtAGabRCn8k0Vd
         YdUyIFkJgK6Oh43GOs7fwNTuvPQcShAHrktaO1xo=
Date:   Fri, 11 Aug 2023 13:48:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.5-rc6
Message-Id: <20230811134809.5f1e6cfc690baaf796ff4072@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-08-11-13-44

for you to fetch changes up to 5f1fc67f2cb8d3035d3acd273b48b97835af8afd:

  mm/damon/core: initialize damo_filter->list from damos_new_filter() (2023-08-04 13:03:43 -0700)

----------------------------------------------------------------
14 hotfixes.  11 of these are cc:stable and the remainder address post-6.4
issues, or are not considered suitable for -stable backporting.

----------------------------------------------------------------
Andrew Yang (1):
      zsmalloc: fix races between modifications of fullness and isolated

Ayush Jain (1):
      selftests: mm: ksm: fix incorrect evaluation of parameter

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

David Howells (1):
      crypto, cifs: fix error handling in extract_iter_to_sg()

Johannes Weiner (2):
      mm: compaction: fix endless looping over same migrate block
      selftests: cgroup: fix test_kmem_basic false positives

Liam R. Howlett (1):
      MAINTAINERS: add maple tree mailing list

Lorenzo Stoakes (1):
      fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions

Miaohe Lin (3):
      mm/swapfile: fix wrong swap entry type for hwpoisoned swapcache page
      mm: memory-failure: fix potential unexpected return value from unpoison_memory()
      mm: memory-failure: avoid false hwpoison page mapped error info

Mike Kravetz (1):
      hugetlb: do not clear hugetlb dtor until allocating vmemmap

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

SeongJae Park (1):
      mm/damon/core: initialize damo_filter->list from damos_new_filter()

 MAINTAINERS                                |  1 +
 fs/nilfs2/inode.c                          |  8 ++++
 fs/nilfs2/segment.c                        |  2 +
 fs/nilfs2/the_nilfs.h                      |  2 +
 fs/proc/kcore.c                            | 30 ++++++++++--
 lib/scatterlist.c                          |  2 +-
 mm/compaction.c                            |  8 ++--
 mm/damon/core.c                            |  1 +
 mm/hugetlb.c                               | 75 ++++++++++++++++++++----------
 mm/ksm.c                                   |  2 +
 mm/memory-failure.c                        | 29 ++++++------
 mm/swapfile.c                              |  8 ++--
 mm/zsmalloc.c                              | 14 ++++--
 tools/testing/radix-tree/regression1.c     |  2 +-
 tools/testing/selftests/cgroup/test_kmem.c |  4 ++
 tools/testing/selftests/mm/ksm_tests.c     |  1 +
 16 files changed, 135 insertions(+), 54 deletions(-)

