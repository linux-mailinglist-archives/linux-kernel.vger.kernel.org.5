Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821777FF95E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbjK3Sa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjK3SaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2E310E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4845C433C9;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369028;
        bh=kQn4AiZUKODpHAH30bUaozR+Aw/LCTbXYBY4J3YyzbA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TrobcIcaVF8EBGiZNo8CpGUs2eqsDE55RGSNEoODBHmc+Dp37KEnvjVN0a4CnvhKD
         tt/Pan86ORM8hme3ANm5YwInrxlbQrhzOVGD/O2WrZCtaqNZ/JedlfgTv3iUxfqdz/
         o2eXKQVwczKj7+wQN7u92H8dLg7vM059wNsZMzSJi/KZQAPQ6m8kNwk3NtaehmO0o1
         bOgNmKrzMbuh/QpioF6yLMTGTgFKjNxCY1olmXI/xOS3Zmk//1A7ZQzUULhCUh4H/0
         jnJhUF/d81jIZSRXXsk+VTicwmUyhMeB8vG+PR2pADlGEMZ9cdaKPr92XbYgVBgiqE
         2sdWXYIrUlEQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF84FDFAA9F;
        Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid dirent corruption
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <170136902871.21709.7868505476251651988.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 18:30:28 +0000
References: <20231128092516.2882629-1-chao@kernel.org>
In-Reply-To: <20231128092516.2882629-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 28 Nov 2023 17:25:16 +0800 you wrote:
> As Al reported in link[1]:
> 
> f2fs_rename()
> ...
> 	if (old_dir != new_dir && !whiteout)
> 		f2fs_set_link(old_inode, old_dir_entry,
> 					old_dir_page, new_dir);
> 	else
> 		f2fs_put_page(old_dir_page, 0);
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid dirent corruption
    https://git.kernel.org/jaegeuk/f2fs/c/53edb549565f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


