Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8E754277
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjGNSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjGNSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B29270A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C2E61CEA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 885F5C433C7;
        Fri, 14 Jul 2023 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358749;
        bh=mMTJnIUl0Ox4s3zJ8S50GDtIkriWNwEZTt9R8QIGuD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gJmU92OcKsrZvBjxBWlQL+GVOYH4c7fVM1cygpF0FmGJLSYF9pxJAt5TzFkteY3R0
         BLl9oG6iweWOk7xndgEDCdmxZ9REJqQjBMevcFWS7UmcKPG5qmtoomazGAz7K5ArHw
         8bj9rsO7QT3XKUHFIuuIK9T8InHhEmUa19ZLdqS1MK2M3cJa37dGRjy9GPMzh9+upk
         +iP8fcMtwV7uQQt3GG8nULXbFquh7yf3wWiEI/8buo+UbD5JuMQOpIdb66Ppz7Z98Z
         jYVA4IkZ4X5rtsL6AH7VEXPw3OJanndfRtS4E5Xjif1rCrW4uFi/cWKb1chTAmca78
         5LuKNInbg6J0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 751C3E4508D;
        Fri, 14 Jul 2023 18:19:09 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-c0a9115b-10ec-4bf0-8c4f-af009c34423f@palmer-ri-x1c9a>
References: <mhng-c0a9115b-10ec-4bf0-8c4f-af009c34423f@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-c0a9115b-10ec-4bf0-8c4f-af009c34423f@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc2
X-PR-Tracked-Commit-Id: ab2dbc7accedc2e98eb7d8b8878d337e3b36c95d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2772d7df3c93f15e5b2119bd9e14724db6a21a04
Message-Id: <168935874947.6403.5064105455791400018.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jul 2023 18:19:09 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 06:58:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2772d7df3c93f15e5b2119bd9e14724db6a21a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
