Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88CE75E587
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGWW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGWW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA31B0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B7360EB8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5991C433C7;
        Sun, 23 Jul 2023 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690151320;
        bh=BuFFaUGF/QAhjIV+z9OXHo/UcGz8rHjz2abdfTd0LDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RfwoMyfUPbOGJBnB7Cxd2UWfBt2nHsKk0BAk0bFQfUto+4f0V5lZ7fQe6mCjmVIgE
         cs1sYweHkhqSwcoOvFTuADz40QNdtSNyFZR3UnPfBvHJvvivIZD424r9PSxU/14Ncx
         bW89r8/0owEEXly+CxAp3FJBUHw+5CozICGuvZ3By6XE9Wjjd7eBoxoSx8LkgZ4dIX
         4vbPaqn71pLYdh+aOpEgAsMESDfMn8FZuAUWfTXsjNzzGy/Bfen5ETDPuPK8wULVKu
         C5DoK5aexZ8Z5E1r05M/jbNyStxCNOcuU0qfWZBY+5UgOQkQDCJuBiCTc100fVmws5
         bB46zsc13d/Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEFC7C595C2;
        Sun, 23 Jul 2023 22:28:40 +0000 (UTC)
Subject: Re: [GIT PULL]  tracing: Fixes for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230723161139.6cb7cf27@gandalf.local.home>
References: <20230723161139.6cb7cf27@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230723161139.6cb7cf27@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc2
X-PR-Tracked-Commit-Id: 4b8b3905165ef98386a3c06f196c85d21292d029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b4e48b8007105695c913348ca11df50260a5ccb
Message-Id: <169015132077.21688.7178525107247807818.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jul 2023 22:28:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        YueHaibing <yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jul 2023 16:11:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b4e48b8007105695c913348ca11df50260a5ccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
