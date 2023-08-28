Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6578B64B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjH1RVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjH1RUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00F4120
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7599F64E12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D49B1C433C9;
        Mon, 28 Aug 2023 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693243222;
        bh=FQYXoInQBlr/f4+an2RbMCBOGFxOn2Mjxfz/Bo5FuFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ca1KH7F9oT0N8788aWwh71ULUQciMywnLtvl90psB/ZuZjnXklvA/9yWsjexwouFS
         yGOFqakHhBN0qJszeI1PNz1cw0p2Xu2NJWuTIRG3k8nhyTNUkDdGLp1cWUVD60GxYP
         9YEYitBK2YdUU+J5D5QiYpMvKagfYy2m6HavF18FZyw1rfatYVPNeIotfW6ek9N00s
         7HeiMO4DqHl7aObkuiCig4Fl0vU/YIBwPVxgDj6iuqiPm3iBAaxlqIyEqf5DTbo88x
         vGGYb+vkq0Xocu1DB5FOtAB77zblnzpbECbWOwYoXY/dap0VhOo4vQhLoZJE5BbT74
         y0O2Vr4dgqVNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B89AFE301F2;
        Mon, 28 Aug 2023 17:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use finish zone command when closing a zone
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169324322274.341.6890205068394202418.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 17:20:22 +0000
References: <20230824160832.3195155-1-daeho43@gmail.com>
In-Reply-To: <20230824160832.3195155-1-daeho43@gmail.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        daehojeong@google.com
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

On Thu, 24 Aug 2023 09:08:31 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Use the finish zone command first when a zone should be closed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/segment.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use finish zone command when closing a zone
    https://git.kernel.org/jaegeuk/f2fs/c/3b7166121402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


