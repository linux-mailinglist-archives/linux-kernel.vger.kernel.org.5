Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806707DDC17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjKAEgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKAEf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:35:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B9ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:35:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E38EC433C7;
        Wed,  1 Nov 2023 04:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698813356;
        bh=vx0Vtdnjqks3VndXdG5T8xg4RLh5/XDEGWMNvAZ2jjk=;
        h=Date:From:To:Cc:Subject:From;
        b=OkjP2u2YTNSe0CcGUdxP+oWXWvQ5qDIpNM2mmtPSuJLjJDEm8Z3PyI2d6o5/iXB0D
         WTOmAkgZETD0V8tV6yzDEbm4s9Dk6QF+LtemeaM1VjpW0e7mrWau/WT0Cp5jCia32l
         FuqukziPY6Ve2BAHuD6GY3kpL8Tekg8KFjLhLDSzzrVt9/Yjcme13LEHtW+lzWDvzX
         w2jFnEYChCBXVfsI50tlIlD0jzYJ1n94ljj0wFag9WiyIBxDOpKSDl7l/icy6qP/LY
         11ewTZIiMiAuH2is3MyT+9it7uGsDZsE4bbL4eJcutwIArPDkwimxsFPRgtz4Wxck8
         l5AdejQvkKZfg==
Date:   Wed, 1 Nov 2023 12:35:44 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [GIT PULL] erofs updates for 6.7-rc1
Message-ID: <ZUHVoP/682uPjvfj@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Tiwei Bie <tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 6.7-rc1?

Nothing exciting lands for this cycle, since we're still busying in
developing support for sub-page blocks and large-folios of
compressed data for new scenarios on Android.

In this cycle, MicroLZMA format is marked as stable, and there are
minor cleanups around documentation and codebase.  In addition, it
also fixes incorrect lockref usage in erofs_insert_workgroup().

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc1

for you to fetch changes up to 1a0ac8bd7a4fa5b2f4ef14c3b1e9d6e5a5faae06:

  erofs: fix erofs_insert_workgroup() lockref usage (2023-10-31 18:59:49 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix inode metadata space layout documentation;

 - Avoid warning MicroLZMA format anymore;

 - Fix erofs_insert_workgroup() lockref usage;

 - Some cleanups.

----------------------------------------------------------------
Ferry Meng (2):
      erofs: get rid of ROOT_NID()
      erofs: tidy up redundant includes

Gao Xiang (3):
      erofs: don't warn MicroLZMA format anymore
      erofs: simplify compression configuration parser
      erofs: fix erofs_insert_workgroup() lockref usage

Tiwei Bie (1):
      erofs: fix inode metadata space layout description in documentation

 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/Kconfig                    |  7 +---
 fs/erofs/compress.h                 |  6 +++
 fs/erofs/data.c                     |  2 -
 fs/erofs/decompressor.c             | 63 +++++++++++++++++++++++++++--
 fs/erofs/decompressor_deflate.c     |  6 +--
 fs/erofs/decompressor_lzma.c        |  7 +---
 fs/erofs/internal.h                 | 42 ++-----------------
 fs/erofs/super.c                    | 81 +++++--------------------------------
 fs/erofs/utils.c                    |  8 +---
 fs/erofs/zdata.c                    |  1 +
 11 files changed, 89 insertions(+), 136 deletions(-)
