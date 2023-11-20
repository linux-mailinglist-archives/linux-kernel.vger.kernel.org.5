Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE947F0D03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKTHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:51:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE07B5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:51:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B43C433C8;
        Mon, 20 Nov 2023 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700466701;
        bh=6Dy5lixQag+5xA6J3MfdiClmJxKC1ANcF4CazvLin9s=;
        h=Date:From:To:Cc:Subject:From;
        b=qH/Tr60auyxGVkxJaxwaFjtFeS8eh/bLuYf0dSEc+0IrhpSn0NdDXuXI4fWclzdCc
         NYZjOSuA7HAZp7Q0taRR0FyW2khvO2esrsTCPMKYFk58lz4mLrX+C6Ykfh5ZtSsc6D
         Ulv9Xpkeh/Di5FZ8HdEZQwbLFkux2nr1msChzyDAAhVroljo2CB1Nlwx/F9mRXEWYj
         69eu7+MpLsAWgS1q2i5apGUD1nKhao+R0w3pDBD+hq2R11sT2GDtWh0hw/h+RPOY2r
         1SZjNBttBWEjllfaQplatzvwveiQqF+VWGp/S6/+ae/UYEntlZZWnDfVl/w/TcHL2E
         RaeIZzKAsA7LQ==
Date:   Mon, 20 Nov 2023 15:51:34 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [GIT PULL] erofs fixes for 6.7-rc3
Message-ID: <ZVsQBsV2GFTmy+iZ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these patches for 6.7-rc3?

One patch fixes a regression in fscache mode introduced in this cycle.
Another patch adds EROFS webpages which contains more technical
internals: <https://erofs.docs.kernel.org>.  The remaining one is a
trivial cleanup.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.7-rc3-fixes

for you to fetch changes up to 62b241efff99fc4d88a86f1c67c7516e31f432a3:

  MAINTAINERS: erofs: add EROFS webpage (2023-11-17 19:55:46 +0800)

----------------------------------------------------------------
Changes since last update:

 - Tidy up erofs_read_inode() for simplicity;

 - Fix broken fscache mode due to NULL dereference of dif->bdev_handle;

 - Add the EROFS webpage to MAINTAINERS, documentation, and Kconfig.

----------------------------------------------------------------
Ferry Meng (1):
      erofs: simplify erofs_read_inode()

Gao Xiang (1):
      MAINTAINERS: erofs: add EROFS webpage

Jingbo Xu (1):
      erofs: fix NULL dereference of dif->bdev_handle in fscache mode

 Documentation/filesystems/erofs.rst |  4 ++
 MAINTAINERS                         |  1 +
 fs/erofs/Kconfig                    |  2 +-
 fs/erofs/data.c                     |  5 +-
 fs/erofs/inode.c                    | 98 +++++++++++++------------------------
 5 files changed, 44 insertions(+), 66 deletions(-)
