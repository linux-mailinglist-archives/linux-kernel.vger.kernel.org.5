Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95E78BC13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjH2AYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjH2AXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60C107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AFB61426
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75D47C433C7;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693268625;
        bh=Hywew1nhL5GyURa0orMld8dRrzcHudqSyeXlnvmhjSU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pUNeNshZ6bZwxa3GlFS6rkQkt3IPbr4oaARw8NiPkd3X4F95VRqSoB94Mv0VaDCwb
         cNNUYe1wp9WIk8gXs1tu7YI0AEQfG42wVlc6lyuYMJBXnSGCvkFj5jI4KJIuZ6xj5o
         mmG7y34LSqfoHblmwZJzsxM616BzXYn8z+GCrOnhA961fK1+0oZV9iVj33u/pQR2p6
         fvXEp7O+RWB2TE4iUax6tGreWOPY/fMR63Yr94xSUrr8GnqameAm3Ogti6BWbcWkOz
         J2QQewm3meC+mTkH6a1kVCskq0Pp2E8YVip98dbxet+tBiFklaCmxRV+cuoOu3hqgL
         6ZX9izvQEJyEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 623E5C3959E;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO0EwqEtfg/iczDM@gmail.com>
References: <ZO0EwqEtfg/iczDM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO0EwqEtfg/iczDM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-08-28
X-PR-Tracked-Commit-Id: f66c538098b61e2eb596bb88fae90dbd2cebb378
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d637fce03462821127892d7c2bce9ec432ffe7aa
Message-Id: <169326862539.9848.11833773654974135015.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:23:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 22:34:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d637fce03462821127892d7c2bce9ec432ffe7aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
