Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067EA78BC72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjH2Brv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjH2BrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B93188;
        Mon, 28 Aug 2023 18:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0732C60B04;
        Tue, 29 Aug 2023 01:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E802C433C7;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693273626;
        bh=CF0XWUjMeZRG2nr6dMASdIbwU8aN+gpvPo/4vr1ZcVM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=idYtgb+MqPykyqd6bRvIFc/OWO1wujQKS7805KgPBfxbJKBzW9SZHhGRRinInp83Z
         KnuNH/6Q2pdyfVpXXEWbVmFGC3gh05JgXHYmJNACPZO8Ja8KmoquJgsrtEekWZteZZ
         EySPnr3KC/j4/lKSsC9JZm/E2qt7eYl7Ojw5Ojf0GwmYvzSwL8fftcdN3DEk6XWxz2
         ymp2+UoyzOTAjI0KJG59meUtTL9fP1amK17kVQ5pgkbm68gkQ3Z84E+oTshl4LxgAH
         bDpq2MBatPLSI85nu+PR/Cb5aepqXsji+c3KjK2VwkNOXh6eWUIQ9zxtVQLDif+YDY
         CDxwsykHtTCGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56B80C3959E;
        Tue, 29 Aug 2023 01:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jLOQhXnfE2z9OjmYOh=7MPtJ8=OSNSVVAoZ7=brRgqvg@mail.gmail.com>
References: <CAJZ5v0jLOQhXnfE2z9OjmYOh=7MPtJ8=OSNSVVAoZ7=brRgqvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jLOQhXnfE2z9OjmYOh=7MPtJ8=OSNSVVAoZ7=brRgqvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1
X-PR-Tracked-Commit-Id: 422ec6fe2704593c87c14a8ef296d92f6b368c53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccc5e9817719f59b3dea7b7a168861b4bf0b4ff4
Message-Id: <169327362635.21367.4335267997841064817.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 01:47:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Mon, 28 Aug 2023 14:57:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccc5e9817719f59b3dea7b7a168861b4bf0b4ff4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
