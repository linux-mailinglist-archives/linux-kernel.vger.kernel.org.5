Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2B756AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGQReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGQReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7BB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898236119C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E3CC433C9;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615261;
        bh=5HpakzjV7y6m8RmvEp04Fq3yRPY3dfvIkBk0s3tcWlg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A0PCzUy2hKyp0/eCHJtqvlxRS3KMOBo+xPHYvMGvdiz7FveMpMvRsDnhGbGKYSTYZ
         9C1yZsFAe7q0XIWpJdtPdWZ8GlK+KIo6KsyDf3mCzyKw5azLGnT4c1MivKKGu/1KTv
         hyT2k/V7+NuMQNSAmEAOEgJD07e5kGRRpw/5KM8KNI33s0PBQycyC4vqGzrk4YBDb6
         9IXKV867emtA1BOycbiD+LheonA5prN2hHIZqAko1jmJJs/9z6r/7G1O8wEUVVk3f+
         xFyg9tFYWLQfl2mt1FlHhkBtAI45GjXACvmyADXWWWz9NSE1U5dOB4SsuPnx2da8lR
         4I7zXfp9kDqQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF3A6E29F32;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: allow f2fs_ioc_{,
 de}compress_file to be interrupted
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526177.4078.6277797285337568603.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230711200806.4884-1-chao@kernel.org>
In-Reply-To: <20230711200806.4884-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Jul 2023 04:08:05 +0800 you wrote:
> This patch allows f2fs_ioc_{,de}compress_file() to be interrupted, so that,
> userspace won't be blocked when manual {,de}compression on large file is
> interrupted by signal.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: allow f2fs_ioc_{, de}compress_file to be interrupted
    https://git.kernel.org/jaegeuk/f2fs/c/eb0e30a6f8a7
  - [f2fs-dev,2/2] f2fs: compress: don't {, de}compress non-full cluster
    https://git.kernel.org/jaegeuk/f2fs/c/10c7134ee440

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


