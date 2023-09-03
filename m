Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C982790D9B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjICTEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbjICTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:04:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA0C4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A99B80D08
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0160C433C7;
        Sun,  3 Sep 2023 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693767852;
        bh=maJIoGmUlQJhF2PfsiFznwh7tLaY97PMxoTc9VEJ2GY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bSnGREjLy9rNZWujoXRNz10y8bzVo3k8nzU5/HYtYe6vf+4oGTSaJB7ZWutrUwCzK
         sFZ7jyfBQr7rO68DSJDYl0e6PKY+xegFYAyp7AoJsVlyAbmHJmOADwUJYKDQu/AeFs
         e87MxTOppxoBFOs4lT6dKNV1BgQswFZ4itVCagAINshXfjLC+1sTpu6Q+b37hwHyE3
         y25CBh2AltppPSE1BMwTu7zQxXzJjO8zEbj+pu0MYuccW4OeRtS/1N7dI1f4Ln/yIz
         lWazAdGLfdfzSD1G6hV+TQOV/xWS5i6wecWOdjTgk7TJCFXhb3byxdxz0lK3rAktNJ
         8UaC8tgUXyu5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4CCAE270FB;
        Sun,  3 Sep 2023 19:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230901184136.73b2833e@xps-13>
References: <20230901184136.73b2833e@xps-13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230901184136.73b2833e@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.6
X-PR-Tracked-Commit-Id: 54a3f6e89fbbf12e1e3539a4f977a7536029d780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bac8a20fa39796f5ae5cf73de146c2ba22ad2674
Message-Id: <169376785141.2005.13392186655488153072.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Sep 2023 19:04:11 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 18:42:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bac8a20fa39796f5ae5cf73de146c2ba22ad2674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
