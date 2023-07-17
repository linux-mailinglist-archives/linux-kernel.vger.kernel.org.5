Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7E756AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGQRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGQReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508EBDD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983266119D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03FA2C433C7;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615262;
        bh=l9fnYPUEU4XFFKmH0AcPyY4PDnFuy0+gUPjAep7XsVM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CExiXQ92mVHqzUQ+lKfGH53U6rRbT4nRw4Pzy7cwswWdAUycAHRVY4leCkNFc4+b+
         371vFB60YnA796WQX5YV6gAFm/kAEUV6Xe9JohYvFAFlnEvB1J96uDcpGsOpJOCgQF
         PNT5Z9KO+QQkUPjjhvlfb9kWfdeFEZJ4eDpX2Igw6Kpxym793J8w4pgRgy0NRQQeWE
         E+AtgBeBVi7GiOApuKuPqUTR1PmeBgo+JZ+CAycsk/Q3qpxcdz5n+Z9M/XVDFF+EV0
         W2U7uvjN76zlV4RduEHc3LHJVx/FmccjP2el0/26ZeUGsWW0yWX87lz2O33nkSuz2E
         hTcY1WSJQlMBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D16BCE29F34;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't handle error case of
 f2fs_compress_alloc_page()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526185.4078.17033386338905134361.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230710061058.2303767-1-chao@kernel.org>
In-Reply-To: <20230710061058.2303767-1-chao@kernel.org>
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Jul 2023 14:10:58 +0800 you wrote:
> f2fs_compress_alloc_page() uses mempool to allocate memory, it never
> fail, don't handle error case in its callers.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: don't handle error case of f2fs_compress_alloc_page()
    https://git.kernel.org/jaegeuk/f2fs/c/df19023418cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


