Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8177122D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHEUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF6194;
        Sat,  5 Aug 2023 13:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9338660EEA;
        Sat,  5 Aug 2023 20:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F109EC433C7;
        Sat,  5 Aug 2023 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691268358;
        bh=QgSjMbGN5oT+YPU8NxvTKL5L7XEXos7GDLcjhJlYkUI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hhGC5uhqzgXJYYvL3r+lAL/c/VwYg15O5x52IRYzqha+X6wT97Ux+d5G7k1Wn0b7x
         2zBACHvKG3MRNCjNuj3uesxw73suSkufAVzZftIYv/CyphXVtz/XGrjqJshH+78ysn
         qe54r9tI92jmOwa47kgG+o8N+TdO0sVf9MfgEAQu8I8JdDwiP3S23LaUYb2QB08bnV
         h4vKdttxN/7J96Mlw9yApo+R7FnhRRts8DgEwV37m9n4hP+oyoMmrgicbQsKwBSXFI
         WDxl9wPVg/VG5zHljbMovXYMlBKfNc/p+76Uub7aGtU7NLlDT4VzkDETxK12oNmq/T
         /gLEc/ajqBr0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC1CEC395C5;
        Sat,  5 Aug 2023 20:45:57 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 DFS Fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt0UH0Z-nRdEDsFMbE_gj1d8ezcoAhScZoToQckVvT_fw@mail.gmail.com>
References: <CAH2r5mt0UH0Z-nRdEDsFMbE_gj1d8ezcoAhScZoToQckVvT_fw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt0UH0Z-nRdEDsFMbE_gj1d8ezcoAhScZoToQckVvT_fw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc4-smb3-client-fix
X-PR-Tracked-Commit-Id: 11260c3d608b59231f4c228147a795ab21a10b33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6a691685962637e53371788fe2a72b171aedc68
Message-Id: <169126835789.30402.13336993334935190114.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 20:45:57 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Aug 2023 13:55:42 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc4-smb3-client-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6a691685962637e53371788fe2a72b171aedc68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
