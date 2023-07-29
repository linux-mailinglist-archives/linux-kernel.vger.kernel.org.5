Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E0767984
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjG2A11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjG2A1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB12D70;
        Fri, 28 Jul 2023 17:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3071162223;
        Sat, 29 Jul 2023 00:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94C3EC433C9;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590431;
        bh=EVHKF0CKHIBvvpIZLn27E4I3ppVATZt3uzuOK9WOLt8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T5J5xGJhbyJhyv20cSS6ejNMWKrOJUtVi1HeOip5FpJXLf08nXbDX/I4pOLO7j2Oz
         ubxos1oCjOaQUX4oEfK56L669MQ8uHQDs/H67QHIJf9I/7zsABuV7Dxo8odPNk6jJc
         hXdoK7OfjBLVui8Pd6ESTEXDUdvn93/Yww86S85KZ6HAjAnvvO9LdS/rdSPxVDo/7/
         1zvsKJYo+javzXjqjH/w2VcA6julpEFzwdvLRxbzwm7zHv0aF9x1Sqv4pScKNqtkTR
         esSf+mTEEXz4/mzL/zmKKFk5CIx7IP47wDVlDq4ZanSgch6XjNYVnBwHxfRkrQTY/g
         GhQ9tNTYA8ECQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E020C39562;
        Sat, 29 Jul 2023 00:27:11 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jRDjoe1Rd4XOQyKvv73AKtKT4wb7mrLe1+q9w1hO9Fyg@mail.gmail.com>
References: <CAJZ5v0jRDjoe1Rd4XOQyKvv73AKtKT4wb7mrLe1+q9w1hO9Fyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jRDjoe1Rd4XOQyKvv73AKtKT4wb7mrLe1+q9w1hO9Fyg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc4
X-PR-Tracked-Commit-Id: 4dd8752a14ca0303fbdf0a6c68ff65f0a50bd2fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3632f42176a9baaa6959c59364c85d71e574c0c0
Message-Id: <169059043150.2110.7449220380066269222.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 00:27:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 22:08:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3632f42176a9baaa6959c59364c85d71e574c0c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
