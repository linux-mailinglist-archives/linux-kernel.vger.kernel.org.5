Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F8378B968
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjH1UPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjH1UOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DAD9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1562640AF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C09DC433C7;
        Mon, 28 Aug 2023 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253691;
        bh=wbHBRHb6D+uTXECeXtEURXJYx9mDNRJcL/T3j5xoIfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N5IGh46573RNnfqsfGVpP/DxrkzJuCYcVX5Q8N2u7a3E7YF9g/I09FU29+et3zrVM
         quCZ1GD0l4VZeYnzdkR0Ut9YTai1yruMrpKdDvbwWLLLWaJ6p1QbkHJGDEEiZL85nv
         yvjcexNBkjLbKP6hRJSc10ekGhngjaCu8No5ereqnjrDdw01OE2+hb7QXwhNprjbP0
         h7Hj8WwTV3z9oabbaw0sN6LBmFBsTfyxPXhfCRHicdmjui7GgStjT5oSV6dVmrQ0Of
         nIhVYqSk/9qGbbiPRoiHZqGaAA4SI4co86W4dLtggSTi9h7ZrFTHGoS3HuVp78eYVS
         UzjYtxdwihUiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37CE2C3274C;
        Mon, 28 Aug 2023 20:14:51 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202308281112.3C1EB9E@keescook>
References: <202308281112.3C1EB9E@keescook>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <202308281112.3C1EB9E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc1
X-PR-Tracked-Commit-Id: 46822860a5a9a5a558475d323a55c8aab0b54012
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b03a4342142be0c608061a91fa52ec21f6853152
Message-Id: <169325369121.5740.6566572553752551817.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:14:51 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Drewry <wad@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:15:48 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b03a4342142be0c608061a91fa52ec21f6853152

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
