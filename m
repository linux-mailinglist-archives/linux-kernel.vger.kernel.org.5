Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4ED7551AE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGPT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjGPT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B42FF1;
        Sun, 16 Jul 2023 12:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E02EC60EBA;
        Sun, 16 Jul 2023 19:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 517FEC433C9;
        Sun, 16 Jul 2023 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689537536;
        bh=19H7MGwPXxxaVCDxcecX1Fyg+WiSLcmiQEcFtiwsg78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uNskXhO25wNQUAf5ZV6lHCMQ6dKlCZIZXkaHMRhgYzTnrzRfI2p7CVR1iB+JAL134
         Bt8q6E0TGNmSoN+4XUvbG0MyTBH9XTTPOLCnZHczM/IG/L7b+jIZdCcr/dwHTm/ei4
         RlgYl+gp0UaHG8+HGro1xH2WeYkx0+oE8tJ5mI5cW+RoynJp+COLSEpFAba0iKz0K5
         pIqoKjtIOjp+yyeRYXF+j5vm/KONCc9D4Eg9PO4yXB9sHmutLkj+NRr3H47wRS3LII
         Up8Z7j6RoqkZiq72fUWml0z/qeEyhIa1VO98AXFG9+0MOoUG0Okop0gAmRrvj1u0fe
         YZOhshXNoow5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F956C40C5E;
        Sun, 16 Jul 2023 19:58:56 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYNOMEUTJ-=N9ZR5w+mAKcTGLCoz7kgUgioC9Ytz9TZKg@mail.gmail.com>
References: <CACRpkdYNOMEUTJ-=N9ZR5w+mAKcTGLCoz7kgUgioC9Ytz9TZKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYNOMEUTJ-=N9ZR5w+mAKcTGLCoz7kgUgioC9Ytz9TZKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-2
X-PR-Tracked-Commit-Id: 04e601f2a71c804422a91df813e19fda5f4b845e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ede950b01922778ade5ba0d0834f25fca4ed1d88
Message-Id: <168953753625.5443.2895896662351482624.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 19:58:56 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 17:26:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ede950b01922778ade5ba0d0834f25fca4ed1d88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
