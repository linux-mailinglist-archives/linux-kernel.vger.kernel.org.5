Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD579093E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjIBSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjIBSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7BE5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96B960ADE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0E0C433C7;
        Sat,  2 Sep 2023 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693680505;
        bh=ooYhXhUJhebMJY911YM8WA2u1KeN2SVTdKV8SwQwIh0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qwuEwsTDgbUOTw+pRe+ASIdD63P0znubuEPvC/cffS0vsGZwMneY5wXqJVfulu6ZG
         sJ4vhHkjYA6RsJ0lVtjsj1UhYUFe9fUpijGy+vN6JI1Jf2WUCcwz+RM8P/BnBk4tZK
         eLsT7XLNBai0WbQ6hB9+tMsaTzJdA9GP5zwb3EiDS5culVbpQz8QlBuP8QNFsVHBTf
         a8oHx/rhWDJVmeWGjaY+4IQFvDx7rbhZxhz/iSLJ17L6CjrQvRL3dWFW5XkfTwaBcw
         rF+npX3tO5ntObAyC/GULkOHEq3Oynonx/dBkNjqi2Fj2VYsvVda/BawrlKt5rfKNh
         lRE0WunXBYulg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B50BC595D2;
        Sat,  2 Sep 2023 18:48:25 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes and clean ups for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230902083849.06a23d21@gandalf.local.home>
References: <20230902083849.06a23d21@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230902083849.06a23d21@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-2
X-PR-Tracked-Commit-Id: cbb557ba92f08b945e2cb20b7ab37ef49ab53cdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e021c5f1f612536c2eb9d46206b786c76a01c8e5
Message-Id: <169368050504.9288.15807245393585535702.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 18:48:25 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Levi Yun <ppbuk5246@gmail.com>,
        Mikhail Kobuk <m.kobuk@ispras.ru>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Sep 2023 08:38:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e021c5f1f612536c2eb9d46206b786c76a01c8e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
