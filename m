Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A6779822
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjHKUFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjHKUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BA530E8;
        Fri, 11 Aug 2023 13:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0843667D4;
        Fri, 11 Aug 2023 20:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC9AC433AD;
        Fri, 11 Aug 2023 20:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691784297;
        bh=nSnSR8oLOzGq85rxD/nWXB7lE4izqLYhjSRU7KH6FIU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BygXb0SzS868ACBzb7DstxUt6t0AEfVd9Elwv5axNdBJeMC7q/tUnFeGUCJSDb7Er
         C32i/dJTpebLSEe7cQ5KvfYKXvIYeXUK6YqOraYHFVD4h4CX/nL5Xph+rCZhpRhXIa
         VJcQETP8zpVn2dF6CoxJtnNDTAHpZRpRFK56kItrlFIYAs3ELe7Hco30d+HMSTevtW
         McrfUKxe4o1bC48tcX/AMokst81WUFcwUQU5McfGqrDVLMTxILhQ2D/pb/7oSuGkn6
         kbrgqrCdBaKPnipYbH6WQLuqIQAKXPFrs+2hWMb51e0izN9EELIfJZsf476qs/DRmK
         /EvrWwRvp0n5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EA1CC3274B;
        Fri, 11 Aug 2023 20:04:56 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ik0R89HH2fMGV9YP=Poc+5fyjpSkFcMYLU-wSFEVcttg@mail.gmail.com>
References: <CAJZ5v0ik0R89HH2fMGV9YP=Poc+5fyjpSkFcMYLU-wSFEVcttg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ik0R89HH2fMGV9YP=Poc+5fyjpSkFcMYLU-wSFEVcttg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc6
X-PR-Tracked-Commit-Id: 56fec0051a69ace182ca3fba47be9c13038b4e3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29d99aae13cf2713b85bc26a37921e231676ba48
Message-Id: <169178429664.22025.2918340895254967873.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 20:04:56 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 20:53:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29d99aae13cf2713b85bc26a37921e231676ba48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
