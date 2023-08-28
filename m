Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0DE78B998
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjH1Ufb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjH1UfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C733109;
        Mon, 28 Aug 2023 13:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FFC64381;
        Mon, 28 Aug 2023 20:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D698BC433C8;
        Mon, 28 Aug 2023 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693254921;
        bh=/Gs5ZWC7H03fXDUJaYco03zxScAlXy7nbxTBCfiJ1Pc=;
        h=Date:From:To:Cc:Subject:From;
        b=oNxB5/ICw5qhqu5/YM3OvPxta4Z2Iw5YHr6HWunhv16KOSx+z8g+JjYs5QMcSs+p0
         s8b1MXapyg6lzCAF0zi8tPQ/371rKALImWKsTSwFZU6RiS3Cr1wUj6pSw5hs82qMNm
         yCf7xmby9W6qCIarc8nIm8EX9hw5S9nKye1fJIsallT6NovrOa6MuOPbYEDhwdHEvd
         5NQt0a9NyHipLIbpJ4GVug8GbrpsFZ6L+Lw7pkN3GNsngIdu9F0xsEbszOrgCkH8C/
         Rn69Kl+SdQunupHm5K3uE66+DpeczxHA3S4p63nTxSqFL/jocelX98LnsUHr/q17zD
         ZbP+Xkr4qS49Q==
Date:   Mon, 28 Aug 2023 14:36:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations for 6.6-rc1
Message-ID: <ZO0FRCAhO5vdQFPA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.6-rc1

for you to fetch changes up to 4d8cbf6dbcdaebe949461b0a933ae4c71cb53edc:

  fs: omfs: Use flexible-array member in struct omfs_extent (2023-07-31 14:55:48 -0600)

----------------------------------------------------------------
flexible-array transformations for 6.6-rc1

Hi Linus,

Please, pull the following flexible-array transformations. These patches
have been baking in linux-next for a while.

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      reiserfs: Replace one-element array with flexible-array member
      sparc: openpromio: Address -Warray-bounds warning
      fs: omfs: Use flexible-array member in struct omfs_extent

 arch/sparc/include/uapi/asm/openpromio.h |  5 ++---
 fs/omfs/file.c                           | 12 ++++++------
 fs/omfs/omfs_fs.h                        |  2 +-
 fs/reiserfs/fix_node.c                   |  5 +++--
 fs/reiserfs/reiserfs.h                   |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)
