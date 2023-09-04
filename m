Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2C791EF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjIDVNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjIDVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:13:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7301F1AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 189B8B80E3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E34C433C7;
        Mon,  4 Sep 2023 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693862015;
        bh=taCG6xAi6L1jhr3txpV3+/HNyUs0znxJFXhIIzXWYNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cXLBiJPmorNxNIxoixgkWwuGnIBT9ImCuSQ9rTHO0nIFq3o1bW7YQmWqE56aTpi6z
         2Z+Slm9rGk/f0ZPwhC+2SBzxNuhebmh/art0gOnntJlMNyjbJskCc8yId8fIEU5eU9
         XbqQMPiFsAEMGVJik+5G3wyEFtN3cExsBd0TvtjsEYh1PCjhOAvddLoAjo9ha4K3tV
         3g7750yGLO2MlcHJGvBXy8/kFPk1wZ5mp1HnNPqRtprhYm1XTIJ7qlNmh/3QLj73sJ
         FJ2YDxvYAQspY43iSVGLIFJr4WClsBk7wuXxyU9PZBDhlBJKFzLaJaS134aNBJJQFi
         Bmp9I1/N57lvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E895C04DD9;
        Mon,  4 Sep 2023 21:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPWumSQVlzdYkSJJ@alley>
References: <ZPWumSQVlzdYkSJJ@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPWumSQVlzdYkSJJ@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6
X-PR-Tracked-Commit-Id: f0f692395353b99a54f7f6e5a8684d73af504879
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c31041e37324e143bee98604bb31481e905b4b3
Message-Id: <169386201557.29740.14634953221170753474.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 21:13:35 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 12:16:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c31041e37324e143bee98604bb31481e905b4b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
