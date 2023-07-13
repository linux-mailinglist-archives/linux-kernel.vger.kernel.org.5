Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85938752C51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjGMVll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjGMVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B01FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C95A61B7F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0745CC433C8;
        Thu, 13 Jul 2023 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284491;
        bh=zGzXoM0u04bgU98YlFEDAFt+ZgG3JOfNU4FRvqkvpW4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UuCYnx35ZBqO0FTru00ZbUPsPYxVIGrf+34R1b41M8oxpz9T9nqXhwZj8/M+G4Q92
         ql1LTN7v5O9hVTlzNvbyB4RgjYKVTRHC/SvLszDPT/5gsoQPEqMmjzKDXxGUqXE7FR
         3Tgw9eOO5+kf0IqR7wu94lHHhqDuzldP4ynHWs8N7F3kdEeYom/1umr2T1uXRkSSvr
         hKPDBGgq/jfjxrLGzpb6sx1bDEndPpUZPKzXu4nD5qCfQ/oC0nFNT/g0as1/UZaFl2
         oWyFlDeqnHLOPrrox4yl/p9281jp9SAoKOPDzqEZ9NplKVvLbEgnCRcEHXp6DRFmxU
         sMDt3MVskDqeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9B83E29F46;
        Thu, 13 Jul 2023 21:41:30 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZLAX9WApf3wGm5Q+@debian>
References: <ZLAX9WApf3wGm5Q+@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZLAX9WApf3wGm5Q+@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes
X-PR-Tracked-Commit-Id: 18bddc5b67038722cb88fcf51fbf41a0277092cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b810bf037e524b54669acbe4e0df54b15d87ea1
Message-Id: <168928449095.12038.10202336583193139465.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:30 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jul 2023 23:27:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b810bf037e524b54669acbe4e0df54b15d87ea1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
