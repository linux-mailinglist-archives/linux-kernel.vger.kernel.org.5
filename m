Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1247BA97A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJESwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJESwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:52:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466290
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7D6C433C7;
        Thu,  5 Oct 2023 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531924;
        bh=OvwK77ltnAZjXJBl59/zk04Rk8MD0OfKyT7xQ223tf0=;
        h=Date:From:To:Cc:Subject:From;
        b=Odg2p3sbjePg9oNS0q6gAl1Xlb/qaf56msGMOsgao/o0Z1eDVBSSP0Gp58DmSgnl+
         zAEp3I5YvLp3t7RdsdtaSMjXz38YiQVSFwAtPYyb+2u0FjvICgOa+7moizl/rRU/8e
         7a0D3T1BCiKI5Sr77Rtf4r3c293M9scyw9sVdYbVy7i/XfV9T6Z+39upO4em6SoUhv
         W1QDx0RJQ7Ijy+ol9CDa9ovaHs1Y0bq5cdLhWXYqhqARjzzE++bW1L6WfUh24ocCp7
         3gB8IyN/Rc3zn1QmrTFymEu71md5p1vEaaDOIXXa3TwPPuY39dhVMdU2a1rsHde/rq
         gfZDI5KmTvEHg==
Date:   Fri, 6 Oct 2023 02:51:54 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [GIT PULL] erofs fixes for 6.6-rc5
Message-ID: <ZR8Fyu+gi7yw6HMh@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jia Zhu <zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these patches for 6.6-rc5?

There are two actual fixes: the one addresses a memory leak issue, and
the other one fixes mount failure of flatdev mode if device tags in an
image are empty.  The remaining one updates documentation.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.6-rc5-fixes

for you to fetch changes up to 3048102d9d68008e948decbd730f0748dd7bdc31:

  erofs: update documentation (2023-09-28 22:40:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a memory leak issue when using LZMA global compressed
   deduplication;

 - Fix empty device tags in flatdev mode;

 - Update documentation for recent new features.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix memory leak of LZMA global compressed deduplication

Jingbo Xu (2):
      erofs: allow empty device tags in flatdev mode
      erofs: update documentation

 Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++++++++++---
 fs/erofs/decompressor_lzma.c        |  5 ++++-
 fs/erofs/super.c                    |  2 +-
 3 files changed, 42 insertions(+), 5 deletions(-)
