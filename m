Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B31773006
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHGUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHGUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9CE79;
        Mon,  7 Aug 2023 13:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D71621D1;
        Mon,  7 Aug 2023 20:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 893A4C433CA;
        Mon,  7 Aug 2023 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438433;
        bh=6x1f0CDkPY07PiLmERMbBg0AbE6kPaoNOevutTQlpsU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kq3NK0iHwGA7dWaTY9/KwSdKcbo0/NXa9khrMylmw0zeW/3Lczndrres/GalYAeaz
         QfpoMnzBZGNsajgPx/MCGvgyTg0XkKmegC06/sg2owA5BUpya7+yp3+YNzzOX7qMXC
         H5eLR6550J5ndHYkJqgvZ10t9K5y3qWBVoGk3AYLAaCyX/k9CHBduUZIONOdSFku8c
         EQNnNxJeC/07cD4nyjTZ+O4krJ/v8E1T1WES8cD6lofs7vC35PpRmxWgkMTiXZ9Mh3
         cI6DZRYQCvuSy24qIvWp4abPaR8oAhFF4Kj1YBz8jorNAAXJhn9NM0kneovabArsrQ
         BnOJUuu2J06UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59C1BE505D4;
        Mon,  7 Aug 2023 20:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: clean up w/
 sbi->log_sectors_per_block"
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169143843336.8972.4125102884764821098.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 20:00:33 +0000
References: <20230807195219.371131-1-jaegeuk@kernel.org>
In-Reply-To: <20230807195219.371131-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        shinichiro.kawasaki@wdc.com, stable@vger.kernel.org
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

On Mon,  7 Aug 2023 12:52:19 -0700 you wrote:
> This reverts commit bfd476623999118d9c509cb0fa9380f2912bc225.
> 
> Shinichiro Kawasaki reported:
> 
> When I ran workloads on f2fs using v6.5-rcX with fixes [1][2] and a zoned block
> devices with 4kb logical block size, I observe mount failure as follows. When
> I revert this commit, the failure goes away.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: clean up w/ sbi->log_sectors_per_block"
    https://git.kernel.org/jaegeuk/f2fs/c/f7a177b8690e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


