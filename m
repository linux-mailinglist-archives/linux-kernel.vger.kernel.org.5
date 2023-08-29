Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1778BC77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjH2Brt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjH2BrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB37184;
        Mon, 28 Aug 2023 18:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34E06168B;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4554CC433C8;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693273626;
        bh=63Eb/9Zv8bMEzGEjklZL29OFlqOR10uunI+LHmGwChE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YrJwrOf257XUhQ9IqdBcx6B/fu6HSbZC85cJbOynY3V29XilEugo8B/j2t4q9/D3A
         CKkoqd0vZmrhzXLgCDbnO6PdMtRkxYJnCkdOAKfY0OdScy9LSFSiDG3kAaU5qgbnuu
         MjeVgtXTQwLjkOAReihMi7q1ZkOu97HoCxfKalXNjb+C/jbwKg7+ilVucC+Sw49ghr
         IczbBPZtDa5zTv6GEZWspWf/o2VE8+sDHMBmTSUpokwRfKoaQyZvLacp7Lhu1SO8VY
         CQ57Bpd62+3Dedh8VhHiQV//UMTbqWEMYSgc6GSEf0ztyZZD8j3dWLK1U8voa5EQE+
         hyT8283+gWROg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AAAC3274C;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hsVwQ+F1NN5OfY7HG7tPcbcZi_X2SdgWXfF9ExW6r3hg@mail.gmail.com>
References: <CAJZ5v0hsVwQ+F1NN5OfY7HG7tPcbcZi_X2SdgWXfF9ExW6r3hg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hsVwQ+F1NN5OfY7HG7tPcbcZi_X2SdgWXfF9ExW6r3hg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc1
X-PR-Tracked-Commit-Id: b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 330235e87410349042468b52baff02af7cb7d331
Message-Id: <169327362616.21367.15371142110241185329.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 01:47:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Mon, 28 Aug 2023 14:55:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/330235e87410349042468b52baff02af7cb7d331

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
