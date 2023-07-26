Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A81763EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGZSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGZSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A741BFB;
        Wed, 26 Jul 2023 11:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298CB61C5B;
        Wed, 26 Jul 2023 18:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8741FC433C9;
        Wed, 26 Jul 2023 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690396974;
        bh=sJn2F9B+51V/6N+ADe2Jxz4ugA0gEnIsxtxnLHrZXmg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C6cvA1Kv3fF/Yz38q3U3b09v+YBQ7qUiivVkW3nt4rhtecuSleAs6OkqnQ4K2+3xA
         pXh6QusW3cuchqTB5xYSsZ6XnPXUfVa/I+kCIxo8a6c8aTCn/yHmaLR9HaHxNgHvIg
         yd24WL9GcptTKsXXv9VfoLo4eAZLAGFFi8aEmvee4RRJkIl/8nYiNfJMC56UcbBujm
         St7Y5PzWt88DYAGnLVUq/Be7/gTmi0Ap8UbCJ0zthRuDHOt7+OksXhoRhb/nkVQr1k
         3eOFZBmJ4+iOLhOh7VgR5c2j4C6CEpwvZN4679b81v1X68x5g4v24WBQf1kImkVM2l
         sX9/765H+dEiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 735E3C41672;
        Wed, 26 Jul 2023 18:42:54 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muSHRKyEq8tuivVSAvDW4ko37UVrKNAfNSveDy09mP=Hg@mail.gmail.com>
References: <CAH2r5muSHRKyEq8tuivVSAvDW4ko37UVrKNAfNSveDy09mP=Hg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muSHRKyEq8tuivVSAvDW4ko37UVrKNAfNSveDy09mP=Hg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.5-rc3-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 536bb492d39bb6c080c92f31e8a55fe9934f452b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f40125c0a160912ee3ac8def2f7de5bacb80df50
Message-Id: <169039697446.1355.8369761950630485655.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Jul 2023 18:42:54 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jul 2023 01:17:12 -0500:

> git://git.samba.org/ksmbd.git tags/6.5-rc3-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f40125c0a160912ee3ac8def2f7de5bacb80df50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
