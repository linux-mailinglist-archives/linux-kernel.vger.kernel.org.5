Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7880D787E06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbjHYCwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbjHYCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A992118;
        Thu, 24 Aug 2023 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADBD649D0;
        Fri, 25 Aug 2023 02:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87FA4C433CA;
        Fri, 25 Aug 2023 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692931872;
        bh=VlCRxD9nDzzF+RomjznN7ndRW1iiqupDpd2rIdlgP9Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AYuBWvXDB/0M+ojL0dTE2wcDS9AEiTeS9q/B3LN9DbVWSUIR2W7oDMXeO/eSx9ozV
         WbmVct9mo23+WYfvrhu2uQjZEjwOtDN5XBmoLitXeDMWPvyD2Hv2MzH594oaa/LxJl
         tfaTLIZcN0Gs7J37UDk62juIZeMXKv5mn3baS6QQS9+6KDXyUL30HfZJIDvPrXf/o9
         7pOCtcQ8qUODMt7QnR68gy/cvli1u8MWEeijZVPOPZC4th3ix85RDTqDOu9+Ru9pzc
         zTBRMBGQHRBH7S59mg4uXizHvpxpJWW3Ss67ZaZc+dbmezONsbU/tJ0wYut2FgWg+V
         Gi0bFmoYh+pQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7217CE33094;
        Fri, 25 Aug 2023 02:51:12 +0000 (UTC)
Subject: Re: [GIT PULL] tracing; Fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824200401.43521a7f@rorschach.local.home>
References: <20230824200401.43521a7f@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824200401.43521a7f@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc6
X-PR-Tracked-Commit-Id: e332938e6fc8117fb9bb1374339cea879b3972d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f9e7fabf8643003afefc172e62dd276686f016e
Message-Id: <169293187246.29499.10798505790897189473.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 02:51:12 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, GONG@vger.kernel.org,
        Ruiqi <gongruiqi1@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 20:04:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f9e7fabf8643003afefc172e62dd276686f016e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
