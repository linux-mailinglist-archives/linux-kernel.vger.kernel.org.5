Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6A767982
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjG2A1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjG2A1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52533C22;
        Fri, 28 Jul 2023 17:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455E962226;
        Sat, 29 Jul 2023 00:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE685C433CC;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590431;
        bh=FMbmin9PlXGNKI5v/aRgb51GzQWZZbhyVJftQfBSWM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eIkV1K6viiy6rfExBWcX/GSlP/k7pGljC2H6mXcUK/cR3lWxiVSm1D/pRvPuAQtF6
         xvYAc3UgQXOo3t0jIu0SU/vh4cjkVbwE1A2KVsqwG7RkrTGh1kkyULE1Mg1yF0CsOX
         rQJMz+WgjFtlQjPPJn7ufv7iGCpuG5zqtWs2NsDGtjEbHE0BVbquy3wP+VYSLrmmLF
         OGRZMu9Tgow4B0ts7DxIagT9aFKZjYqtV0uqzn1JllPc9mVZflbqOTLKxXWGPm/bXz
         5KNdMRuFiPqtj0Q8Pv9yAfg2QxwWLY/ZurLWr4dS0dBWmHRI714y7TxCz/uTA2eExv
         1u6oxw2sBH+0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 966BAC4166F;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jnGiQLWci3=-PM-8StYL4Dqa19HJhVLRVhDkvmuosjPA@mail.gmail.com>
References: <CAJZ5v0jnGiQLWci3=-PM-8StYL4Dqa19HJhVLRVhDkvmuosjPA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jnGiQLWci3=-PM-8StYL4Dqa19HJhVLRVhDkvmuosjPA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.5-rc4
X-PR-Tracked-Commit-Id: ac4436a5b20e0ef1f608a9ef46c08d5d142f8da6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20d3f2417b41a04510722144eb9a2d7ab53bd75b
Message-Id: <169059043161.2110.12615534795704744397.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 00:27:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 22:09:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20d3f2417b41a04510722144eb9a2d7ab53bd75b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
