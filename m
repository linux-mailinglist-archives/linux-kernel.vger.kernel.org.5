Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A47EFB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjKQWIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:08:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B03B8;
        Fri, 17 Nov 2023 14:08:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F67C433C8;
        Fri, 17 Nov 2023 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700258929;
        bh=NEOWloWUbotUNY8eU+l2lgEi5xBr0yxPu9X40CLvS6I=;
        h=Date:From:To:Cc:Subject:From;
        b=KFTQrG8kWtIKss8EwcmegRotfexaBOlduqxE5Bty+bMXAT7k03g34KsNbdLjWaAWr
         ri2KBCd9BQy0WiC7DE0NCNgmVwGwgiZmuGC1b/IT4Sk5qjveC5ZYRH3O5nZnoy43EB
         xXWH/NBF5nzXn2UCUiguVPrTPDvvEac8OPSS37FY=
Date:   Fri, 17 Nov 2023 14:08:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.7-rc2
Message-Id: <20231117140848.02adcf56c301bb3ab85ae75a@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-11-17-14-04

for you to fetch changes up to afccb0804fc74ac2f6737af6a139632606cb461d:

  mm: more ptep_get() conversion (2023-11-15 15:30:09 -0800)

----------------------------------------------------------------
Thirteen hotfixes.  Seven are cc:stable and the remainder pertain to
post-6.6 issues or aren't considered suitable for backporting.

----------------------------------------------------------------
Breno Leitao (2):
      selftests/mm: restore number of hugepages
      selftests/mm: add hugetlb_fault_after_madv to .gitignore

Dan Carpenter (1):
      mm/damon/sysfs: eliminate potential uninitialized variable warning

Helge Deller (1):
      parisc: fix mmap_base calculation when stack grows upwards

Hyeongtak Ji (1):
      mm/damon/core.c: avoid unintentional filtering out of schemes

Muhammad Usama Anjum (2):
      selftests: mm: skip whole test instead of failure
      selftests: mm: fix some build warnings

Roman Gushchin (1):
      mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Ryan Roberts (1):
      mm: more ptep_get() conversion

SeongJae Park (3):
      mm/damon/sysfs: check error from damon_sysfs_update_target()
      mm/damon/sysfs-schemes: handle tried regions sysfs directory allocation failure
      mm/damon/sysfs-schemes: handle tried region directory allocation failure

Stefan Roesch (1):
      mm: fix for negative counter: nr_file_hugepages

 arch/parisc/Kconfig                        |  6 +++---
 arch/parisc/include/asm/elf.h              | 10 +---------
 arch/parisc/include/asm/processor.h        |  2 ++
 arch/parisc/kernel/sys_parisc.c            |  2 +-
 mm/damon/core.c                            |  2 +-
 mm/damon/sysfs-schemes.c                   |  5 +++++
 mm/damon/sysfs.c                           |  6 ++++--
 mm/filemap.c                               |  2 +-
 mm/huge_memory.c                           | 16 +++++++++-------
 mm/ksm.c                                   |  2 +-
 mm/memcontrol.c                            |  3 ++-
 mm/userfaultfd.c                           |  2 +-
 mm/util.c                                  | 10 ++++++++++
 tools/testing/selftests/mm/.gitignore      |  1 +
 tools/testing/selftests/mm/pagemap_ioctl.c | 23 ++++++++++++-----------
 tools/testing/selftests/mm/run_vmtests.sh  |  3 +++
 16 files changed, 57 insertions(+), 38 deletions(-)

