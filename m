Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0C7D3ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjJWPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13ADB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC53C433CA;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=Qr2qJ1m47DDdX9GbktKLz922kAXN4MXJALybWvMfpNE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IufPDlv7a+lFU6I5mBddw8bwm+roi+Fw+YghKAnnBSugnmaThqzqrqtqQ7ZNnOndx
         kDpJAXL0wHA4VHZ25YaWouXO6YDdALGa0ybnGYF6rivcE1wTqYxC1p8R3DN5/fo9UC
         95VE+yrbjI/Xm6nP2UjovzXqfNRpEy5ei/UCP0qa+yZIsny9yO8WOpHv+TqYuIXrMR
         tYTnkoDzRfhLiCMz8Ud14VJp8HgrihRTK1gt7lDp9QTnubdwCT+LcUnuMAKmQJ99YU
         NdeRPCHA1yc+/ox0rWQXr7VSRb1EOHnkUqtIJTJud8dfd3n8/SVrKbd80HAghn8a1c
         IjIhsqc6xaXzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBC00E4CC1C;
        Mon, 23 Oct 2023 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to initialize map.m_pblk in
 f2fs_precache_extents()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502496.26537.15638158417948699715.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:24 +0000
References: <20231007074552.3170496-1-chao@kernel.org>
In-Reply-To: <20231007074552.3170496-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  7 Oct 2023 15:45:52 +0800 you wrote:
> Otherwise, it may print random physical block address in tracepoint
> of f2fs_map_blocks() as below:
> 
> f2fs_map_blocks: dev = (253,16), ino = 2297, file offset = 0, start blkaddr = 0xa356c421, len = 0x0, flags = 0
> 
> Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()
    https://git.kernel.org/jaegeuk/f2fs/c/8b07c1fb0f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


