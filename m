Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A587D3AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjJWPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjJWPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F88103;
        Mon, 23 Oct 2023 08:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 541FBC433B6;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=bUtVoh6YaTR2e9kd3iT8lvGM2BLtR/4vtkRIDHJ3FNY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MUkjNIA1zWr4Q1NAuiy992Ih9icgnKqn0745p5V9X6rY25Da24EBUmgohWr4VwPfE
         zneIrISV9LPC2JBOUwR46yCz4jkX/qX+gtYvKmc6SyfVrl0Yx8tt6O2q6qqJ/riovD
         Et5w+te/cb5Rr3kyITBZmYFsSz51DI06NGhEA2jIgMrgvpU9rUHUNM/AeGMOmMkqT4
         R9rp7cL0AFicWs64L8mMdLPVLxgw3y37hW9iX6zn1MEqMOJIsq5wx82z9tPTdTSe8p
         dQc9fbyCQ5BnE2d9K5d866Su+wcSnnX+1JrCi2j7ZiPZ8fpOK9Lw6Gawes/MCwtAQU
         wkmLQg3SAY2mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AB8CE21EC3;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not return EFSCORRUPTED,
 but try to run online repair
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502523.26537.10004934909406083909.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231019225300.1846362-1-jaegeuk@kernel.org>
In-Reply-To: <20231019225300.1846362-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
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

On Thu, 19 Oct 2023 15:53:00 -0700 you wrote:
> If we return the error, there's no way to recover the status as of now, since
> fsck does not fix the xattr boundary issue.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c  |  4 +++-
>  fs/f2fs/xattr.c | 20 +++++++++++++-------
>  2 files changed, 16 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: do not return EFSCORRUPTED, but try to run online repair
    https://git.kernel.org/jaegeuk/f2fs/c/50a472bbc79f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


