Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E0762136
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGYSSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGYSSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55DC1BFA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62CE86185D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE395C433CD;
        Tue, 25 Jul 2023 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690309112;
        bh=zYtH6CG2IdEtHPe8c+pbj+oqan9qklrrACjkggQYQyY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J313+UjxAn02Sga9EFp9856uR7KwuYfmdc5iJYzhq8dP/rdMFzerX1gJt2HIZvJ/H
         FOGMzhNWe/aO1TT+r7r1eu5uvzZaI1WviWPhLOq9dUmcATRIKUNdLVaM+pO1UZss4R
         Fg0PWFinRPzVEp1vIJnBv2c5HV4jMg2A+9H7JLsTQxVRG5cjMlcYtFxENm146iDsIL
         cCwk4bl+680RuoEjtrioIVXw55EmbO41r7p54MsgbfD5rxX9SfXZbkkqbiPzfsOgYw
         v3lSuPm37iPbuW3Seu9AcghxkZXuKvLMq+gCBPWKriwlxwZgH+YjsikwplBniXaye4
         7/1i3pYeO1kUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA2CFC59A4C;
        Tue, 25 Jul 2023 18:18:32 +0000 (UTC)
Subject: Re: [GIT PULL] m68k fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230725065752.1731858-1-geert@linux-m68k.org>
References: <20230725065752.1731858-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230725065752.1731858-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.5-tag2
X-PR-Tracked-Commit-Id: 922a9bd138101e3e5718f0f4d40dba68ef89bb43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af2e19389c2c1d8a299e04c5105b180ef0c5b5b5
Message-Id: <169030911268.3173.11090633824641337351.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Jul 2023 18:18:32 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Jul 2023 08:57:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.5-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af2e19389c2c1d8a299e04c5105b180ef0c5b5b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
