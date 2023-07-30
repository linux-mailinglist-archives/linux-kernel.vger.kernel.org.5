Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8135776839E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 05:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjG3Dxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 23:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3Dxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 23:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FC172D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 20:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC68F60B8F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28F31C433C7;
        Sun, 30 Jul 2023 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690689218;
        bh=4ChwFuZZ6Aq/CLn1DaDt8xBWmONZB8L9parph7skpKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzMdHitg64LTI29jd/FDjOLvCGwWqqJ0GlTIBgh6gpWYVbSjA0EnTp3zZN8T4JIA+
         Q7B4w1tgVLrOxN304/EVJisFlWpx11iCzr/kKtm6GRFfQVfHHn4ks93w7bTy0xTOju
         SNItbGlm6iamXNkVS/uSBlUw/KTzBVWliRnKQA1g6PZ8CmTIQKZ7tjsLvmAeS1i9ZU
         KqBFqo9+fM56E4WfeX4Bi/zxtLONrAXzTmbqmuN5CMy/q5i0xj/IQTzljEZWgbUgIi
         heYMoq0nkEFwu9y9TvzoKMV/ihy7B8V3e0FYpeltFBnBLPw2MxC4vL1j/KnSYQOwqE
         KcTRHLuN7lG+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15B2EC595D0;
        Sun, 30 Jul 2023 03:53:38 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230729144749.4f8e96ef@rorschach.local.home>
References: <20230729144749.4f8e96ef@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230729144749.4f8e96ef@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc3
X-PR-Tracked-Commit-Id: dea499781a1150d285c62b26659f62fb00824fce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88e123cc0b53e32b0a20700e4815a28895e6b47
Message-Id: <169068921807.25281.13597835857185032789.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 03:53:38 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jul 2023 14:47:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88e123cc0b53e32b0a20700e4815a28895e6b47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
