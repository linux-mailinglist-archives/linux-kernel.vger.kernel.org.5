Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A278E0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjH3Ukk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbjH3Ukh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:40:37 -0400
X-Greylist: delayed 5420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 13:40:06 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D62116
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F260B81F57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23724C433C8;
        Wed, 30 Aug 2023 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693422038;
        bh=Duj1KXG32Ug7TR2/e8KqgxbbMQaxXTb7e8rUCH+HZJw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FRhrCvS/9phcJ66DM7ZAvSXWwAYDGnFyyODqKvGr1+jSTrDNV8Aj7Hf+c+0FhV2ZB
         y3F5+svcnmRvPgslonpOajbTYIopUN8aQ0rGI+pzTe7saHrnU8O8eB72pZOf6i0+OM
         JYgOf2rpJuvgOa/qvhhYMOLKco+W8yhUQV0icZwyXiD+qY72S/dcZmSuICaIzS4ldR
         sHTbH6ECAEUt8MbS/r8qxCLzMQwmopms1mKzMEihZhUIbcT7eotYp7peQ7TMo3IVwe
         +88+9e0loxStQ2Ad+ckd48BQAn7tmaEdbHflWFxXSjzAFL39p0jaJufhT7k6bUROGl
         5qYLLjBZI4PQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00AE2C64457;
        Wed, 30 Aug 2023 19:00:37 +0000 (UTC)
Subject: Re: [GIT pull V2] x86/core for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169340012555.478565.16044726088347432378.tglx@xen13.tec.linutronix.de>
References: <169339202558.475946.15795543318941920393.tglx@xen13> <169340012555.478565.16044726088347432378.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169340012555.478565.16044726088347432378.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-08-30-v2
X-PR-Tracked-Commit-Id: b65413768abd27a55af74945aec58127a52b30a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87fa732dc5ff9ea6a2e75b630f7931899e845eb1
Message-Id: <169342203794.19278.3106924677048696987.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:00:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 15:27:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-08-30-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87fa732dc5ff9ea6a2e75b630f7931899e845eb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
