Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036C7AA1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjIUVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIUVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:07:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39097B968
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F060DC433C7;
        Thu, 21 Sep 2023 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695275627;
        bh=IX2NNozeEralTymStiXcxRES9cKVN05ZkAUk7NIBk0s=;
        h=Date:From:To:Cc:Subject:From;
        b=irJ1GqgMq3CJBrhW3HZWJTo21/rT3Pgmo0mDC/IIcKn/ulslZjKRRm5O2ddqwuo4i
         m4mYtBPiV7U+VyrUhiWNedvslZ9088gJrtpxeLjpfGI0dYvIWXZE8Hl52HJl4tpD7s
         yfzyldY1EiBWpFgD1TtMD7YIAIU0Qdk15fpHA+rqCSq6A0/mghe9XVcrGRmNKFVpva
         u/dA9FsqlRJJHc0kIbjoEd7W+CaDBqDKVVVMWiO8En3uk0U51XfDPFAzl/DQPogXnk
         x7eV8tivKTXdRW3unRjcVS4Dfb6cwEVNScIkzAWNaUqoPMt86iiTqM1tiNxEmCjTZ8
         PsN5IfkkdTHUQ==
Date:   Thu, 21 Sep 2023 08:53:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rong Tao <rongtao@cestc.cn>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock test: compilation fixes
Message-ID: <20230921055302.GG3303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-09-21

for you to fetch changes up to 55122e0130e51eb71f5ec62d10525db0468f28e8:

  memblock tests: fix warning ‘struct seq_file’ declared inside parameter list (2023-09-14 10:51:28 +0300)

----------------------------------------------------------------
memblock test: compilation fixes

Fix several compilation errors and warnings in memblock tests

----------------------------------------------------------------
Mike Rapoport (IBM) (2):
      memblock tests: fix warning: "__ALIGN_KERNEL" redefined
      memblock tests: fix warning ‘struct seq_file’ declared inside parameter list

Rong Tao (1):
      memblock tests: Fix compilation errors.

 tools/include/linux/mm.h                 | 4 +---
 tools/include/linux/seq_file.h           | 2 ++
 tools/testing/memblock/internal.h        | 4 ++++
 tools/testing/memblock/mmzone.c          | 2 +-
 tools/testing/memblock/tests/basic_api.c | 2 +-
 tools/testing/memblock/tests/common.h    | 1 +
 6 files changed, 10 insertions(+), 5 deletions(-)
-- 
Sincerely yours,
Mike.
