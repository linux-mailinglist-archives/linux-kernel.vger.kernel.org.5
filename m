Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1B77C1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjHNUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjHNUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CBD1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043E764398
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6729AC433C7;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046222;
        bh=FI6aUE3s5kfOTtgi8ZGZCJWljDK13RF92dXiaXrgLNs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sG/OlfmQon3zkukvQcU7yT25oOPE5z7YhU3eJyRsNTDbvFuQH++IHJoanyaAUbMEE
         ED7D9xcmr9ED4GMfkVw4GnRh4v0yJZ7XyiDPcg4vhfBWZlV5G+9OFFs2P3kvwWgY2B
         sl52FxNR0+baS2RwvtXPzsAFrIHVf3HI3SCcth0lx65sJR+9N/MCoDUkBjBwdeRgFj
         TT55MkIkiB08xAg2BMGYUibauY+1RncY0bLLOAoO59FLkMcQ0LlJrb7dC6j92Y9XO0
         /K3n+ig/2ovD59wpmKxEYbWvdFEpevL22PMlzB2AWfKnFfw5cgj+s+ktWqT5p55ZDs
         msysQFZtAjuuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B01DC395C5;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to update i_ctime in
 __f2fs_setxattr()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169204622223.5033.2752517082147339614.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 20:50:22 +0000
References: <20230719135047.2947030-1-chao@kernel.org>
In-Reply-To: <20230719135047.2947030-1-chao@kernel.org>
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

On Wed, 19 Jul 2023 21:50:45 +0800 you wrote:
> generic/728       - output mismatch (see /media/fstests/results//generic/728.out.bad)
>     --- tests/generic/728.out	2023-07-19 07:10:48.362711407 +0000
>     +++ /media/fstests/results//generic/728.out.bad	2023-07-19 08:39:57.000000000 +0000
>      QA output created by 728
>     +Expected ctime to change after setxattr.
>     +Expected ctime to change after removexattr.
>      Silence is golden
>     ...
>     (Run 'diff -u /media/fstests/tests/generic/728.out /media/fstests/results//generic/728.out.bad'  to see the entire diff)
> generic/729        1s
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to update i_ctime in __f2fs_setxattr()
    https://git.kernel.org/jaegeuk/f2fs/c/8874ad7dae8d
  - [f2fs-dev,2/2] f2fs: remove unneeded check condition in __f2fs_setxattr()
    https://git.kernel.org/jaegeuk/f2fs/c/bc3994ffa4cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


