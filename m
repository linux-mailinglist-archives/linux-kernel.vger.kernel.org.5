Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E29791F99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjIDWuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjIDWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A9DCA;
        Mon,  4 Sep 2023 15:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C8D601D6;
        Mon,  4 Sep 2023 22:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40DCEC433C7;
        Mon,  4 Sep 2023 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693867810;
        bh=tFlKtuZW8VVGc62Acwwye+3FJhhdq4a8hrpBkw2BSUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Iq6JiecmZkQ0jMCeQb2sa63RRHkjx6OowtiBf2jKfTIHV7f/BhIaC1rIK+pSs9bVc
         kttfaA3o6vA06YS5+ZtvFFODZ9G3TUC6Wfhx641uhdbm3WlaVi8xJ2GdYg18Evh8t+
         72BX3InDfR5/XpEffWvfRRyj7uOOhSGUzcNsIMH5LUDBq7vUOT/qwpa2lgFQs9PSZh
         uY4o21F+jgiHgG0DfyXcFnEWAnAhU3xdOHYHISTxhi/GuhbTvWH1BR3FVXsy2zvKST
         IUlXD3bbpPgKPWmgfpkgFthMqLCJwW9VCmFd7knmW2jZEQKln7ewjxs4b4oyfZ+Mtu
         zdg9LCfZZ82ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26017C0C3FD;
        Mon,  4 Sep 2023 22:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jd9Htp-6duGjtZUsBDFkm26ndmTD9cSG6s_fcF22sP=g@mail.gmail.com>
References: <CAJZ5v0jd9Htp-6duGjtZUsBDFkm26ndmTD9cSG6s_fcF22sP=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jd9Htp-6duGjtZUsBDFkm26ndmTD9cSG6s_fcF22sP=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1-2
X-PR-Tracked-Commit-Id: 19a56a6b747716118539398739b021535eaa8cbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4f9c37f75271d8256a326c938c95733e1fec35
Message-Id: <169386781014.10061.944542098423843971.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 22:50:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 19:19:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4f9c37f75271d8256a326c938c95733e1fec35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
