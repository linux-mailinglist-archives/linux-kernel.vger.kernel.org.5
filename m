Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88843790447
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351315AbjIAXoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbjIAXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB210F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD6FFCE2529
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16566C433C9;
        Fri,  1 Sep 2023 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693611691;
        bh=XltcMTt6AXcfKOyJdz5mBQ4rvDe8o6gKKU5MZM2zCvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qe/02ovwP4jZ/8Tn+G/rKOKFKMzXUM7MNLBWTwOT4LSmyScYsjGmFikKXxdW5vS20
         0q7Y8EPW0GcxxrDnNvLglUXQWfiFz1v7elehcKXRVkmA7KfXshqYLCKd0GZLwR9v6z
         daCvACKvkOOLmln1KzRnJ3nV0eFK8ktuoYsEXPyxKGTbOu7SznBP6xxBbxZ3/Mhg9e
         rlgCe9R55Yqe1QieZMz17yJ1L4L8m8pZfm39g/e+8l06QSJcu4oc+jnGlEkLAPePSE
         VEBqpn4hEBi0OcASLNtg6kCL8X6NVenbuknpm2J54aibnjWhYLnXt4b8TqbLQYl94I
         96KcWMxZxoCgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01F34C595D2;
        Fri,  1 Sep 2023 23:41:31 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230831115635.1bdea0d7@rorschach.local.home>
References: <20230831115635.1bdea0d7@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230831115635.1bdea0d7@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6
X-PR-Tracked-Commit-Id: 8c96b70171584f38940eb2ba65b84eee38b549ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34232fcfe9a383bea802af682baae5c99f22376c
Message-Id: <169361169099.17309.14552544424193215734.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 23:41:30 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Eric Vaughn <ervaughn@linux.microsoft.com>,
        Sishuai Gong <sishuai.system@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 11:56:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34232fcfe9a383bea802af682baae5c99f22376c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
