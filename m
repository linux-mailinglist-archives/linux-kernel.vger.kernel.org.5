Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5ED752C54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjGMVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjGMVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EBD30DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFB261B89
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1E25C433C7;
        Thu, 13 Jul 2023 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284504;
        bh=N5Nz11LXohtOUXnM3mLQqTjehlhSWxttP+P8tUynKzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OreZpPlMq3HlAbKrhkwLzYCbqwGJcUCzU2Kv6oHIC8OgczDxWWGHcNGBSzq+/XqVv
         0Dld40ZcWB78JZitd+94rQZtPokpVWJez5JWZdTwGbL9+CAVYP0D1Mh2YcfvlsTkWu
         AL+spMw4Dr5hSVgDatxQ69cwluzuQpAjYmon2HUn2fqWxQQDdhWrOoS50sDr3d9ntD
         zufxtgpgD2bDkvBYqYBkSz011W910W8LQGF76xkBWFDk80Cs9s8/SuoiWbkctttYyV
         TfdjaxQm0QURhRUevr2dvPCdvth9ikjOL8jq1vFhUOfk4xE3HZjPsj0nMPSUYVsFv/
         NSKq8aOpVA+8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE7FDE29F42;
        Thu, 13 Jul 2023 21:41:44 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230712181740.7c5fb0c8@gandalf.local.home>
References: <20230712181740.7c5fb0c8@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230712181740.7c5fb0c8@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc1
X-PR-Tracked-Commit-Id: bec3c25c247c4f88a33d79675a09e1644c9a3114
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6018b585e8c6fa7d85d4b38d9ce49a5b67be7078
Message-Id: <168928450477.12038.10194404325501134976.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:44 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jul 2023 18:17:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6018b585e8c6fa7d85d4b38d9ce49a5b67be7078

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
