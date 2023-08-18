Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2845781253
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379277AbjHRRtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379189AbjHRRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9FA3C0F;
        Fri, 18 Aug 2023 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F349762BDB;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 628E0C433CA;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380919;
        bh=QPyR9vJ6RvOooAfTkyaKbLAzT9OQXrO2KuRanN0BA7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PdbmcgoKqo0eRpdMcOAbBr0xssmbu0AZwEkX7UBWRUmQkXZUp2nABRSYIyFTgxgjg
         ahmctSzrUWh3MoVzVaTGjTiEHr9iKq86T+5iFNgOJORKWkq9iMLSrvooWfszyQ6tQO
         MbogUqiFh5KU7j+86nZTRZpFm5uoSBC6SObA5bUZ+N9a8AcGfv+vplyUk4BNAdIOLl
         Z2RSe0wGteMvYIwnzZbv7I+/pp5aMYcbnegvPuq8JuhQY4zQNPtYuwEfAxU0SsGfYj
         Yjwwwya3i5EArJyaFUaYe2aVSHUv9LAWXFY52lF0c8gL4xDfysKCDaAKEIcIjk4thW
         z7ywRe1gyPyag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F29AE93B34;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYq=Ep4ji=Vy9k8X8cXE9_9gTS5T6eK_uP1M58v21sWbQ@mail.gmail.com>
References: <CACRpkdYq=Ep4ji=Vy9k8X8cXE9_9gTS5T6eK_uP1M58v21sWbQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYq=Ep4ji=Vy9k8X8cXE9_9gTS5T6eK_uP1M58v21sWbQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-3
X-PR-Tracked-Commit-Id: 9757300d2750ef76f139aa6f5f7eadd61a0de0d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f33fd7eb209acf8f6d698fc7979af9e5815271c3
Message-Id: <169238091932.10816.11349110193999027329.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 17:48:39 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ninad Naik <quic_ninanaik@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Aug 2023 10:16:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f33fd7eb209acf8f6d698fc7979af9e5815271c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
