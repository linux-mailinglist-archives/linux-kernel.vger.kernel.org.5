Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFB77C1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjHNUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHNUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E30109
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15209646E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E803C433CB;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046222;
        bh=6zIrbL56hboc477qzoy7DVouRIPq7ziErvkxVOGb7UA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lhQ4ifN5HS5D7bL6IyaU5Rrgr+RSXiLNAyT2a3Iw9llPZI/ENnZO00VJKnqlLw57Z
         zJ87e2PQmq3LKg/V7nqSx/tfk9E/HxkNMVoi+Cx3EVNCJeCOxbZobFoZ9dPN4EdYVY
         lzSG3ZIU+TdB4p0tGlu+b8B0xhilClvphYXqauvyQKVaCNyUucP1ButmWKX6cm/27z
         nmMlcDWCRn8HGOI7p3NaWJhYoKOq93KAAUkE3t/k2AdjUHULAFt8NpaLBXYAfVVbMn
         AfV6Z2VZQplbFKODPY12YFux0TQXfGblbLpRNdld4kDIPD1XYkRQbDPAHwZi+8yNcP
         3RU4jacSs5hKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44113E93B33;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to account gc stats correctly
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169204622227.5033.2565918262411584066.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 20:50:22 +0000
References: <20230808005949.1790839-1-chao@kernel.org>
In-Reply-To: <20230808005949.1790839-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  8 Aug 2023 08:59:48 +0800 you wrote:
> As reported, status debugfs entry shows inconsistent GC stats as below:
> 
> GC calls: 6008 (BG: 6161)
>   - data segments : 3053 (BG: 3053)
>   - node segments : 2955 (BG: 2955)
> 
> Total GC calls is larger than BGGC calls, the reason is:
> - f2fs_stat_info.call_count accounts total migrated section count
> by f2fs_gc()
> - f2fs_stat_info.bg_gc accounts total call times of f2fs_gc() from
> background gc_thread
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to account gc stats correctly
    https://git.kernel.org/jaegeuk/f2fs/c/9bf1dcbdfdc8
  - [f2fs-dev,2/2] f2fs: fix to account cp stats correctly
    https://git.kernel.org/jaegeuk/f2fs/c/eb61c2cca2eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


