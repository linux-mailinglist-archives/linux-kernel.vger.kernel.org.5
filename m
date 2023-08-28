Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FA78BAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjH1WQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjH1WPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92612F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8A963311
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11284C433C9;
        Mon, 28 Aug 2023 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260952;
        bh=PImTRsD6wUOauBFkEcDxnvDgIaQBPtv3iK2qyz6xlic=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gus5LGGyN7HSKyEG2o/l2PLzpnjYGXQnro1bMvcCWkL048YWaKku1SYF13NtaZn69
         gYnAKXdojC+W2OogbqhbaxDitjhovnWi4TtVzf9pB8nD5lXAQ5Cxz468eTSEH4WJaQ
         UklTAn5uAxxAomRBTHCh+pRmrMvoiX++Z944il4wGfagpgiXLjnLhk0snvthKnyF4D
         ISuzpA25/5Uv68aKZOc9Qftyzv18/rBu6yftI4W/SzWSTD1QDPz/5/7SQayOcyRYf3
         28Q89K12JIoaFFwf1i9h9PDc/tadjxTO4ily2cUbsTF0NdhKksZDBkaihwQlXElXHe
         Lm7hNLlmupl8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDDAFE26D49;
        Mon, 28 Aug 2023 22:15:51 +0000 (UTC)
Subject: Re: [GIT PULL] CSD-lock diagnostic changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5a9cbe81-e583-4a96-81c4-396fd14fde96@paulmck-laptop>
References: <5a9cbe81-e583-4a96-81c4-396fd14fde96@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a9cbe81-e583-4a96-81c4-396fd14fde96@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.07.15a
X-PR-Tracked-Commit-Id: 0d3a00b370424f5f1b9fd037bc8a4a3e7cbf0939
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b324696dce7a5b1be11c16cbba6ac6643dadd364
Message-Id: <169326095197.8741.3928930433952142205.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:51 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        imran.f.khan@oracle.com, peterz@infradead.org, jgross@suse.com,
        vschneid@redhat.com, yury.norov@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 15:17:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.07.15a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b324696dce7a5b1be11c16cbba6ac6643dadd364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
