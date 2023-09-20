Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C007A88EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjITPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjITPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CBCA;
        Wed, 20 Sep 2023 08:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76B78C43391;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=2V9YWG2+fo3tZJ+/Ft+3oV7Hjxta8RtJyN+jWzZUn+g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l/9w2KHqp7eJt7mTM0cOiuwP2lI63GUAL/xFaX4K4UXbKN8vCjfLKxRLdoKVKf5BS
         wrzkmACEslSl8FjMYPy1oS/kOoqcaSywjecKTWcNq15FlWunTNRqwMXmS3TZzcyZCZ
         xKMqHaLI9njLD+oo3usQHO1NHk/oI/Dy1qduF/yBIt/lmnwaX5YNzrI/ZYAHifnjK1
         shiYitESoIPaqLl+nRU3oWEeco5R1pBtj70IHE6wfY1MPgXeHLYtJgaKo8VFz2rIA9
         jbqBOlQ+5Y+sYIIwvc0r95gDweg889gvK+eIunn0ZacSsMnjksLvhNa2jzirfIEEaN
         WlyR2mb4NHYFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54F04E1F66C;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: split initial and dynamic conditions for
 extent_cache
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502534.22557.3452572888083664704.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230907210859.3698691-1-jaegeuk@kernel.org>
In-Reply-To: <20230907210859.3698691-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
        syzbot+d342e330a37b48c094b7@syzkaller.appspotmail.com
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  7 Sep 2023 14:08:58 -0700 you wrote:
> Let's allocate the extent_cache tree without dynamic conditions to avoid a
> missing condition causing a panic as below.
> 
>  # create a file w/ a compressed flag
>  # disable the compression
>  # panic while updating extent_cache
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: split initial and dynamic conditions for extent_cache
    https://git.kernel.org/jaegeuk/f2fs/c/f803982190f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


