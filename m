Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA97908A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjIBQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjIBQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:13:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10032E42
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB0FB80763
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66088C433C7;
        Sat,  2 Sep 2023 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693671199;
        bh=0HEKnre4GBWR1d/7DO5heVEwsoDzfSe/oxI5434Pmpk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vNjiYInu+Ed+oCOzjRX9CsJqsu1p+5qE5CKqjMbyQHXEWxjd7HoNUBRPmerr+7TNo
         Gt8API8qFaLn65a+hMPn8X1wIgoncvxWp5NxoEYvwVf1g94R77kkkupyB9jtdEqA3L
         Jg7Y9W7kfQ/7Q5rqPCzPWXUDScMkRf0s4QhpZuJ08f+qg0+NywgR0VI9x5J2G/l3g/
         mu7x38OBfXNThjcPa77PiJhqdNk1p9ctKi8o+TZ4TaOXQMC7LsVscfnj+jgSfvuSW6
         LK+z5P4pRa+puhZtlCxE69XNBYaVgJXioD4MsJIBxo5a8aUs8cqP9xZfJR4PDQ3yX7
         QQUBhvJZY2mgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44D48E26D49;
        Sat,  2 Sep 2023 16:13:19 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPMJ7rJd7VzhBpl+@gmail.com>
References: <ZPMJ7rJd7VzhBpl+@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPMJ7rJd7VzhBpl+@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-02
X-PR-Tracked-Commit-Id: 0d6b35283bcf1a379cf20066544af8e6a6b16b46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c39cbc5b604c7282f210c4a3a743c9f026ed8002
Message-Id: <169367119921.31473.14840179830245660281.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 16:13:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Sep 2023 12:09:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c39cbc5b604c7282f210c4a3a743c9f026ed8002

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
