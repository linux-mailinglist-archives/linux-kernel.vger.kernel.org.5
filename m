Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6178BC10
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjH2AYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjH2AXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CE107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A94386334C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13657C43395;
        Tue, 29 Aug 2023 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693268626;
        bh=M7E07f7Fs6obSRFQhWhKoBOOkVkx2hLghWh2Ox+4W78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ktwxE1wAH6xsMHPExkUzsgCmgA+6RdpA/sxFnyqYSxqLtX1ZKSdZU5crFQIksEfQC
         OOhEWGt/n/Cqg9cxqO4aKkRUHrKxWhxsUKEq+nzundvdCe6f1wFh66+qc7mKf0t3Lq
         o+tQhrD+8IAHSOS0tbKsVUGcDQTj157dHmZKW71Y74MfdC6pEoOiUHTUn+QEDixs1p
         HMUsScwgC9rhdSh6OglPUcwcuxnmOpPrzORdlAnF92qs+9Zl2ac79qmtdtPpN2C+nG
         9hv5ABl6hQpOhlKg9g8TQkacbXQgNCJe8AJYOPZLPekCM9Dw3MIl+Jq3alXNdT3xqd
         //slwrRCi4N4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1746C3274C;
        Tue, 29 Aug 2023 00:23:45 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO0OuPfs0bMddVTW@gmail.com>
References: <ZO0OuPfs0bMddVTW@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO0OuPfs0bMddVTW@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2023-08-28
X-PR-Tracked-Commit-Id: 212f07a21622cbd4bb271b558b2d3ae0652e9875
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97efd28334e271a7e1112ac4dca24d3feea8404b
Message-Id: <169326862598.9848.12522714921336357824.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:23:45 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 23:16:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97efd28334e271a7e1112ac4dca24d3feea8404b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
