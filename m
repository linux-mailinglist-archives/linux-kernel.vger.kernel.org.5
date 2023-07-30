Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581B7768798
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjG3Tnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjG3Tn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC4170D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F5060D3D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCE3CC4339A;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=42wFj7biobuJJrtQGN32X5Cq/BM1591YCr9Bx9GJ18M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y3x1jBkmByh6RWfO0FKkDjXxGY2Is2aHvioJNujBzjvT5lsGslJMkGZiBxClPsM0i
         6u70qV/egRiLTXxlyXHE+xiB91DWkmr8ezkb7AyM0oEUR9kENB6Jx06MjNm4b/3xIB
         yRNfdGeXUT5RsPDORsaya0HyDyVlnRknrW+hsOJH++C03OT8lEAYKbX+1kwwgUoZnj
         Wj7C6B7nwc/A0ze1EuM8U1p2c8kosL46DSGIcOkX+//0nA9TcdfqBcCmDIg01WxIzD
         dDco7TggMQer2udzAr0jtbha4OiTenaP5Ni+qNVjbeDYD68gUYRjTcrsc1rguhSFUC
         mf+Ib5r3XsK9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA6C3C43169;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230731000621.1d34c8638a1285901fb6f9a7@kernel.org>
References: <20230731000621.1d34c8638a1285901fb6f9a7@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230731000621.1d34c8638a1285901fb6f9a7@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc3
X-PR-Tracked-Commit-Id: de02f2ac5d8cfb311f44f2bf144cc20002f1fbbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0b9850e7d53aec13ef12a485e5a301774d9132e
Message-Id: <169074620669.25913.1536788425044305534.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Jul 2023 00:06:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0b9850e7d53aec13ef12a485e5a301774d9132e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
