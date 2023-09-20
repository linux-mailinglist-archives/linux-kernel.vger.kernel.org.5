Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783D7A88EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjITPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BBAF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53AC4C433CA;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=i6ZrC8twPkdmMTcCFAxDTNOGE1x2JCRDQFyKX/X5q/A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DtHyO333m9sIjpXf28lydAgurEtbjB6KBsVg7OM41DNBwDs7dTY/UjnAXyMBELbdl
         EfpCAqWaF9nB/QsXDKnjYDfSN1EU1VosrluDn/gzDCb6xiySodlt9mnRlH7q6+S799
         kYdP7M8UwqEX1SYZs5xpa9OkBmhAw4c+pPHxQD/nQupvrCtFZWssZs349VKf2oooqF
         rPh9juQJ+UtRG8SljZUdxEUu2wlpGe591a8/S5iqM+JLvRRGN3ek/FWIIDTJh3YaCz
         nwuZN0535iHQp4l9EppFOZaF9IhfpQvpKUMy2SRfRMOs44vLB6KLeJPtStqDwwwHJ9
         RDxxQpr/cBJcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F853C40C5E;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: compress: fix deadloop in
 f2fs_write_cache_pages()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502519.22557.11952566114540568403.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230828140417.2951796-1-chao@kernel.org>
In-Reply-To: <20230828140417.2951796-1-chao@kernel.org>
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

On Mon, 28 Aug 2023 22:04:14 +0800 you wrote:
> With below mount option and testcase, it hangs kernel.
> 
> 1. mount -t f2fs -o compress_log_size=5 /dev/vdb /mnt/f2fs
> 2. touch /mnt/f2fs/file
> 3. chattr +c /mnt/f2fs/file
> 4. dd if=/dev/zero of=/mnt/f2fs/file bs=1MB count=1
> 5. sync
> 6. dd if=/dev/zero of=/mnt/f2fs/file bs=111 count=11 conv=notrunc
> 7. sync
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: compress: fix deadloop in f2fs_write_cache_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/c5d3f9b7649a
  - [f2fs-dev,2/4] f2fs: compress: fix to avoid use-after-free on dic
    https://git.kernel.org/jaegeuk/f2fs/c/b0327c84e91a
  - [f2fs-dev,3/4] f2fs: compress: do sanity check on cluster when CONFIG_F2FS_CHECK_FS is on
    https://git.kernel.org/jaegeuk/f2fs/c/2aaea533bf06
  - [f2fs-dev,4/4] f2fs: compress: fix to avoid redundant compress extension
    https://git.kernel.org/jaegeuk/f2fs/c/7e1b150fece0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


