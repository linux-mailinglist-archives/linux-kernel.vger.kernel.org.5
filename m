Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4278BC76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjH2Bru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjH2BrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50F18B;
        Mon, 28 Aug 2023 18:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DECF6192C;
        Tue, 29 Aug 2023 01:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F763C433D9;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693273626;
        bh=4dtvkJrl7I7jVc1NttPMS6JN/zyJWC3WYmWJavOPN74=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ciB7dyZZkepFN89xwOBrIV1s7y9PnjpeiZluwAxjGk7qCKYNLQgAEyKPqTDaYBdYi
         SjjTXGk5wkXNhAik0rZHlYP+XQZ0n0kM3PVGUGFk+cj86v2Rc6oY9OTtpCcj4T7r1L
         Eng3vzIhyB87wi/i6ucI7Pb0+9M/ehIuFbAEc6O9H9H1GlX6OCruvdoKpQOD9etclH
         LzYMJvqvU+K27SHhtMrK8E7s6boLbNAKvaPfXls4xgKduR3n5ynRAC6QGm74YdUnwh
         1p/KnbiU4RoqRz6mwCvZKSe1+pRWPnUGZ6NvFKz3Ei5KG6ce39JBQeLTyGDFYNT26q
         NMBbc/vQd5rtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 863E8C3274C;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hWmfVHqaaD5kPiXx-M8-oHFdzwG327FERVPF4RnR285g@mail.gmail.com>
References: <CAJZ5v0hWmfVHqaaD5kPiXx-M8-oHFdzwG327FERVPF4RnR285g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hWmfVHqaaD5kPiXx-M8-oHFdzwG327FERVPF4RnR285g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1
X-PR-Tracked-Commit-Id: d08122864e7d127d3481c97f9e8afda1371e116b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36534782b584389afd281f326421a35dcecde1ec
Message-Id: <169327362654.21367.12924024966744800839.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 01:47:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:59:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36534782b584389afd281f326421a35dcecde1ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
