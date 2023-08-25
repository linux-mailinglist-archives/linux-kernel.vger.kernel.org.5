Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD788DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjHYRad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjHYRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838A1987
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9CA64428
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F643C433C8;
        Fri, 25 Aug 2023 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692984623;
        bh=NlWpnNVhfRA0pr9OI8zi0gQ3AyEhIqlbLJ1wMzpB2Sg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oxA1YDKhvxvw4v/ezGGdBZGZTjNOsDVddc/YsybZ6kfNlq0opoWqvPGVF5fS0K91U
         gtcQqOmseY1l0+3qJEKPGB/lk7Y9N9OfR/nqtGwWFJlLgtp16L+tnA9FXPfVACKeyA
         dWSt7nKXknNKFVU0Wd6cjMtjo5Es9v/3wc33zAbL7/JvLwsZbSGSrshZyhi1gvMWLC
         nE8f25yrToQKzWyut8Dfv+bt+2n7RCzcrNXpekADk3QmFb7/M5I0WHbX84sAwswViO
         hXj4lms0tDZC/gnmisq7q6XH0hEDp1uzVGmxn6x3JQAdilxHjOkm2ezZ2sPwM0Speq
         N9nHi9Y9MbZpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37E43C64457;
        Fri, 25 Aug 2023 17:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clean up error handling in
 sanity_check_{compress_, }inode()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169298462322.1914.15893111292733724963.git-patchwork-notify@kernel.org>
Date:   Fri, 25 Aug 2023 17:30:23 +0000
References: <20230821152225.4086924-1-chao@kernel.org>
In-Reply-To: <20230821152225.4086924-1-chao@kernel.org>
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 21 Aug 2023 23:22:23 +0800 you wrote:
> In sanity_check_{compress_,}inode(), it doesn't need to set SBI_NEED_FSCK
> in each error case, instead, we can set the flag in do_read_inode() only
> once when sanity_check_inode() fails.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clean up error handling in sanity_check_{compress_, }inode()
    https://git.kernel.org/jaegeuk/f2fs/c/c98879498413
  - [f2fs-dev,2/3] f2fs: fix error path of f2fs_submit_page_read()
    https://git.kernel.org/jaegeuk/f2fs/c/5118697f7215
  - [f2fs-dev,3/3] f2fs: compress: fix to assign compress_level for lz4 correctly
    https://git.kernel.org/jaegeuk/f2fs/c/091a4dfbb1d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


