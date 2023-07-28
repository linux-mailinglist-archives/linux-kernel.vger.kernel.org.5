Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA637678B8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjG1W4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1W4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7B3C34;
        Fri, 28 Jul 2023 15:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B386219A;
        Fri, 28 Jul 2023 22:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0CBC433C8;
        Fri, 28 Jul 2023 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690584974;
        bh=Cre2wdEZpRoEnplbJFl7+sMQjerFXpoZhrmBXQo7UU4=;
        h=Date:From:To:Cc:Subject:From;
        b=IheEtuEIPk4/EyE/ONK1cuUnjpmWXEZZj+Ca93CBSRJdZ8LeIq/hip5C7Miu2TJkr
         Ru0cRPRPYvotbnYcDImySzA4+bre5V9fHfNyscqi+tktok6H4464JPxpgV6kUoqkTk
         Qvc5Jz0QoTzuy2DAP4/XHKs/slUtGCBkAjQYqFM8=
Date:   Fri, 28 Jul 2023 15:56:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.5-rc4
Message-Id: <20230728155613.067d922ee303a968d41e857e@linux-foundation.org>
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


The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-07-28-15-52

for you to fetch changes up to 6c54312f9689fbe27c70db5d42eebd29d04b672e:

  mm/memory-failure: fix hardware poison check in unpoison_memory() (2023-07-27 13:07:05 -0700)

----------------------------------------------------------------
11 hotfixes.  Five are cc:stable and the remainder address post-6.4 issues
or aren't considered serious enough to justify backporting.

----------------------------------------------------------------
Andy Shevchenko (1):
      Revert "um: Use swap() to make code cleaner"

Bjorn Andersson (1):
      mailmap: update remaining active codeaurora.org email addresses

Dan Carpenter (1):
      proc/vmcore: fix signedness bug in read_from_oldmem()

Drew Fustini (1):
      scripts/spelling.txt: remove 'thead' as a typo

Feng Tang (1):
      mm/damon/core-test: initialise context before test in damon_test_set_attrs()

Hugh Dickins (3):
      tmpfs: fix Documentation of noswap and huge mount options
      shmem: minor fixes to splice-read implementation
      mm/pagewalk: fix EFI_PGT_DUMP of espfix area

Jann Horn (2):
      mm: fix memory ordering for mm_lock_seq and vm_lock_seq
      mm: lock VMA in dup_anon_vma() before setting ->anon_vma

Sidhartha Kumar (1):
      mm/memory-failure: fix hardware poison check in unpoison_memory()

 .mailmap                            | 97 ++++++++++++++++++++++++++++++++++++-
 Documentation/filesystems/tmpfs.rst | 47 ++++++++----------
 arch/um/os-Linux/sigio.c            |  7 +--
 fs/proc/vmcore.c                    |  2 +-
 include/linux/mm.h                  | 29 ++++++++---
 include/linux/mm_types.h            | 28 +++++++++++
 include/linux/mmap_lock.h           | 10 +++-
 mm/damon/core-test.h                | 10 ++--
 mm/memory-failure.c                 |  2 +-
 mm/mmap.c                           |  1 +
 mm/pagewalk.c                       |  5 +-
 mm/shmem.c                          |  9 ++--
 scripts/spelling.txt                |  1 -
 13 files changed, 197 insertions(+), 51 deletions(-)

