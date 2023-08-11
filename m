Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E66779823
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjHKUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjHKUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DBA30E7;
        Fri, 11 Aug 2023 13:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E75667D3;
        Fri, 11 Aug 2023 20:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21353C433C9;
        Fri, 11 Aug 2023 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691784303;
        bh=V8o+NDqK1NPT6RsvD7EXIlfUi1eIdaL3mISx6uPok2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=apF9jdvXbY2wZ9FV5SEf4JGV2UXxzdTzaoMRobh7WKZB7dld6xK/yzJkK4fwKVDLx
         stfCBZ48QdTRsjjh4ULtEK8HDaOKc5iMpQCIdr9E1xNvFYg05130av21UMlYZipbMM
         Cb99pAM1/MWdCeiZnYxYuLvvUJxpUU/CtVx2akb3zyCAWy/W5rSkXbRH4UEkLYSgiV
         b+zoZmzfR/jDrnaCkYenx40LzaR7hrmasttwKO9cwteCscsffHP9ZZXfRO4BZsqJaJ
         sAoLZ2m20M+gEYWbal5Z5gnZqxF1H0hc5pj1gv1fZC5beCDTeJQixHp3xAN1LzdP45
         5FZDrwwvaPuPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8397C3274B;
        Fri, 11 Aug 2023 20:05:02 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jsb8ezbg9P_HqgY2Q8UqEwRuMUMs=COyiAF-carAYQJw@mail.gmail.com>
References: <CAJZ5v0jsb8ezbg9P_HqgY2Q8UqEwRuMUMs=COyiAF-carAYQJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jsb8ezbg9P_HqgY2Q8UqEwRuMUMs=COyiAF-carAYQJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc6
X-PR-Tracked-Commit-Id: 4778e1288447d9f90d87df07d195dc89e290d973
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9578b04c32397e664bd4643c8b7f525728df3028
Message-Id: <169178430281.22025.10802734537321907881.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 20:05:02 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 20:50:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9578b04c32397e664bd4643c8b7f525728df3028

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
