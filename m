Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9062778A3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 02:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjH1AtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 20:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjH1AtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 20:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22282116
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 17:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CF061594
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87088C433C8;
        Mon, 28 Aug 2023 00:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693183744;
        bh=isLSogShEm+StyBle5cEQXjXtHddLdzVBe/ZdHNg4WI=;
        h=Date:From:To:Cc:Subject:From;
        b=jXthRA8qjPJ4vV3NfTOzbg7kDf8OtWAgJ2Ba/qojw/DmMBoPG3/PS36zVaKdJVG/C
         IfJOiSRcjPQFZX9LCyxnL3qW2s+9ikrq3CE8U/gpkx+vRs14lAWb+jjp34T0ZVaZIS
         TVfajmbqeLaylbUe/XAAd9q0tqBWCUqg1KArg0cK1pcNjMbggz6uMj/MQNsOR2mb1S
         gLLdZv9BLmFX5k4iqb38UDtPwwqISMmf55Ar1QByIC9TczIy9VIsoVXTwzrl46ucQ8
         Vca6kf5BpxMih+fYY87nXJr13DdqNzkS4C6ohRL9nbl7xaVIQaP+7ZTr3QPRrmor4a
         mcLoBJFXIFlYA==
Date:   Mon, 28 Aug 2023 08:48:50 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Ferry Meng <mengferry@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs updates for 6.6-rc1
Message-ID: <ZOvu8n2Js03Oa7lN@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Ferry Meng <mengferry@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 6.6-rc1?

In this cycle, xattr bloom filter feature is introduced to speed up
negative xattr lookups, which was originally suggested by Alexander
for Composefs use cases.

Besides, DEFLATE algorithm is now supported, which can be used together
with hardware accelerators for our cloud workloads.  Each supported
compression algorithm can be selected on a per-file basis for specific
access patterns too.

There are some random fix and cleanups as usual.  All commits have been
in -next for a while and no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc1

for you to fetch changes up to 91b1ad0815fbb1095c8b9e8a2bf4201186afe304:

  erofs: release ztailpacking pclusters properly (2023-08-23 23:57:03 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support xattr bloom filter to optimize negative xattr lookups;

 - Support DEFLATE compression algorithm as an alternative;

 - Fix a regression that ztailpacking pclusters don't release properly;

 - Avoid warning dedupe and fragments features anymore;

 - Some folio conversions and cleanups.

----------------------------------------------------------------
Ferry Meng (4):
      erofs: refine warning messages for zdata I/Os
      erofs: clean up redundant comment and adjust code alignment
      erofs: add necessary kmem_cache_create flags for erofs inode cache
      erofs: remove redundant erofs_fs_type declaration in super.c

Gao Xiang (9):
      erofs: DEFLATE compression support
      erofs: simplify z_erofs_read_fragment()
      erofs: avoid obsolete {collector,collection} terms
      erofs: move preparation logic into z_erofs_pcluster_begin()
      erofs: tidy up z_erofs_do_read_page()
      erofs: drop z_erofs_page_mark_eio()
      erofs: get rid of fe->backmost for cache decompression
      erofs: adapt folios for z_erofs_readahead()
      erofs: adapt folios for z_erofs_read_folio()

Jingbo Xu (3):
      erofs: update on-disk format for xattr name filter
      erofs: boost negative xattr lookup with bloom filter
      erofs: release ztailpacking pclusters properly

sunshijie (1):
      erofs: don't warn dedupe and fragments features anymore

 fs/erofs/Kconfig                |  16 +++
 fs/erofs/Makefile               |   1 +
 fs/erofs/compress.h             |   2 +
 fs/erofs/decompressor.c         |   6 +
 fs/erofs/decompressor_deflate.c | 247 ++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h             |  17 ++-
 fs/erofs/internal.h             |  23 ++++
 fs/erofs/super.c                |  44 +++----
 fs/erofs/xattr.c                |  14 ++
 fs/erofs/zdata.c                | 274 +++++++++++++++++-----------------------
 fs/erofs/zmap.c                 |   5 +-
 include/trace/events/erofs.h    |  16 +--
 12 files changed, 467 insertions(+), 198 deletions(-)
 create mode 100644 fs/erofs/decompressor_deflate.c
