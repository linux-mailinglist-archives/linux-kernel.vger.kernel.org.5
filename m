Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673AE78BAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjH1WQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjH1WPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C89189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE8761CD4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67128C433CD;
        Mon, 28 Aug 2023 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260952;
        bh=kQDh9wOjQogc1SJT0zntAshTb9pflhnYEh7hg8UEeQI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bRkZDx/OtXlPS2ckRtpoPn7daLRniOo14SwwNyDjYxCv2hn2Z4dBqg7THzLRQS72x
         S4Sbhr6+NH6Ziz/buqzXoGJ835PxsCvR+QawhqJBg2zoj60ufXdQFgMk4Ak+3qdtv9
         wbU9PDCkB5W3mse5vrRW4tR/wVQtIqBIjvl3gkpGyLmOSy35bD/O8WLERQ2FIaYH3f
         6/4yCUdQjPnWY0fDpc1MimRcwGkpsJVkF60b6qdoKSQCGV9OZgYwpmg2dYvJMibqia
         6PTets4VRwEhNFZVzaRlZ+0Q0Ix7pPbfn3Hb9p3tE8AY5Ndn6GUL+sW7vBW3FWMFRN
         DxeYDUG3SYGsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52670C3959E;
        Mon, 28 Aug 2023 22:15:52 +0000 (UTC)
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v6.3 (to
 complete the set for v6.6)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8016ce16-e049-4e27-9f98-29c52bb60145@paulmck-laptop>
References: <8016ce16-e049-4e27-9f98-29c52bb60145@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8016ce16-e049-4e27-9f98-29c52bb60145@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/clocksource.2023.08.15a
X-PR-Tracked-Commit-Id: 233756a640be811efae33763db718fe29753b1e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b98af53cb07a69a08ffd8cca29a449f1e7de4837
Message-Id: <169326095232.8741.6181687043110226160.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:52 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, x86@kernel.org, feng.tang@intel.com,
        tglx@linutronix.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 18:21:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/clocksource.2023.08.15a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b98af53cb07a69a08ffd8cca29a449f1e7de4837

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
