Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4D77AA37
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHMRIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHMRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70913E6C;
        Sun, 13 Aug 2023 10:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E50E6122F;
        Sun, 13 Aug 2023 17:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D928C433C9;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691946498;
        bh=SqU9dI9BD0GGaVfLh8OdK7S4mq+lK0mFlhVOaHfKzas=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WtUmgOPdevxO1WAQm5HMeuoa5HNHfCDXWXzml8EsFI2BdSVWEieCArAKfFRvmM5Rg
         L5SNrCFQArIaweM1M53medEqiMtOmcytazY8thNql2xYa5esGnklcr6nw9Et6klXf3
         JUg51xZdaF8PoogFU86gzLM6WBe9CP/Kos+BhoEq5Gzi+It7M/WVPRTr8RRZlQtfII
         xjRqr/ug9ekKOmjw5fDgD2YHRqn1DetNd+VjY+FBf800XxHLd2LbNGJMCW/6Rkzpuo
         SaBKtCKdL4ktDDVaQoR3IZKT5sODU3YFfohCAcbtDYz5ReBL5EjxuJ0x8gHEJ+obkR
         LbrP3BGa8cZZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B0A5C3274B;
        Sun, 13 Aug 2023 17:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARMSv2B8WJ+rZZXeHCCWtcREn_XZuH5qgZNr8wavWR3cg@mail.gmail.com>
References: <CAK7LNARMSv2B8WJ+rZZXeHCCWtcREn_XZuH5qgZNr8wavWR3cg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARMSv2B8WJ+rZZXeHCCWtcREn_XZuH5qgZNr8wavWR3cg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.5-2
X-PR-Tracked-Commit-Id: 6ccbd7fd474674654019a20177c943359469103a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c75bf7e4a0e5472bd8f0bf0a4a418ac717a9b70
Message-Id: <169194649830.27578.10864976613900096013.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Aug 2023 17:08:18 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Aug 2023 19:16:31 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c75bf7e4a0e5472bd8f0bf0a4a418ac717a9b70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
