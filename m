Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF507550FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGPTaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGPTaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E8199
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3EA60DD0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26073C433C8;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689535804;
        bh=5eYCTEorDkbdoPvwrpZy5BH+LN5dP1yqEwvlCrHpi4M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NxnRf9x7Qv3bT3t5hR1e97rTD9WPB5n5Ncpge8PAZ7k8o8alY+EQGTjY70kZGgR2P
         Y0pj4EEzynAMO8Uko2lXfgR1ZPs85/5egvfikGn+9ZZKtLWPUWjbDuAyHN3FIaptb+
         H3vbJbeapgUcE3tNjl6Jdq9ZzNwbbCasE6zPq+tprm///9j1g/8KllCo3OTjlHebU7
         FAi45wIqY1fkBWhM0jrak1Ww0OzGOY7QoZK3tiXcl58trT7iILxP0WhVcrQ+7gNl/+
         fH2aPB4YIrQ4Z5WlpiLlaaIqqz8x7ZsFM79aWYpRPoPMy/9U9ka2BLufUUwtpCdwQh
         2vlUcSOfz+ctQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E955C40C5E;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] probes: 2nd fix series for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230714225423.58bce65b3a6f65acfcc49c97@kernel.org>
References: <20230714225423.58bce65b3a6f65acfcc49c97@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230714225423.58bce65b3a6f65acfcc49c97@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc1-2
X-PR-Tracked-Commit-Id: 797311bce5c2ac90b8d65e357603cfd410d36ebb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b4eef57e6135ebd28de8c6a3e7898e04172a897
Message-Id: <168953580404.22660.7798898449201444129.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 19:30:04 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 22:54:23 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b4eef57e6135ebd28de8c6a3e7898e04172a897

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
