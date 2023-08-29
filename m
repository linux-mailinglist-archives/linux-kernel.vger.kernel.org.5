Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CEF78BC12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjH2AYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjH2AXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766610B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C35062CBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9BA5C433CC;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693268625;
        bh=MUXZHvdaVoEpmf9qIbbKliBXseIbh5Lr/5ncZK0eOGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AdDzsZ7HwF+TcATuuRS2RXkjFaQHI+P/6p+ylvRw4lhRx0K94ux3gMerz6NQnIb8t
         1eMUAjUvVBl6LWSPM2DPe8/zDhmkJPm2wS1ZvAZm9/0Zbn0uvnlxLAK3NxHdAjeoGB
         EMpL5hPf17f5g4oitH97ZWrU1x26UuwDSjdysqC2eztCvPYM4QP39W9KRBX7kvW55Z
         9QUaTRvfGb+l4K6a34T4mXNeRFYkSNQSduUixgxR0aS8sNlN2Po8z9Uy5LGxygWg0W
         kO4ScUlU8uEm6sJybaDCDFQJn9PCUXxSe/NGjGSw2S/app/g7qAxIbhTILwzX+bEc6
         pEPv9Ff/2Vn3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6F57C3959E;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO0NgNfvvS9oVUVW@gmail.com>
References: <ZO0NgNfvvS9oVUVW@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO0NgNfvvS9oVUVW@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-08-28
X-PR-Tracked-Commit-Id: 2f88c8e802c8b128a155976631f4eb2ce4f3c805
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ca9a836ff53db8eb76d559764c07fb3b015886a
Message-Id: <169326862581.9848.10816016350044866140.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:23:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 23:11:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ca9a836ff53db8eb76d559764c07fb3b015886a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
