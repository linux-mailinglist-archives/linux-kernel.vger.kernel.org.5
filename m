Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8257794FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjHKQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHKQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968CF30C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3D7676F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E188C433C8;
        Fri, 11 Aug 2023 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772304;
        bh=6YgnVkkMTRGCciCd8qtzfc5pyhffPOH2dKIoXa4Siu8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W0XxK50pkTetaDO9uoe3ix3ooC4C1XD1CkwkE9yGxbIAy1q6dz2viti/5QG0VwsIV
         UbkxqBhLnSI9aDu82LSVtOegySFl6VwPkVuW+85RNR5cufeF4J8CMX7OVcvkzz8gxJ
         k/7usdfH0O4ayLnlzZekM/0udET55qxdThHop43zFf5UIhOxX3IEZVWVbUP1+Ij/WO
         rZrF59jI7/X9pG74S4VtYzklGiiP+hRGyz3z6QzIXVUAHcaeOmk/p7Eq0XWFUwzUD8
         RsWHn1IZ+ij3gGDQMH/CsKr9UJAXt4/AxwFV8VYL0ISwGZaCg59Lzmvhn4/upGQuE7
         94/5myJ107mZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A235C3274B;
        Fri, 11 Aug 2023 16:45:04 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty-3+S5X3638GR=DT_PmApzzXS3yHy-OdvnN0xiGvZJUA@mail.gmail.com>
References: <CAPM=9ty-3+S5X3638GR=DT_PmApzzXS3yHy-OdvnN0xiGvZJUA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9ty-3+S5X3638GR=DT_PmApzzXS3yHy-OdvnN0xiGvZJUA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-11
X-PR-Tracked-Commit-Id: fbe8ff726a1de82d87524f306b0f6491e13d7dfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b1b1b74ddb236e7ccf6d11d4c0b642fbe0c66c6
Message-Id: <169177230442.3076.5259500963907324544.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 16:45:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 16:27:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b1b1b74ddb236e7ccf6d11d4c0b642fbe0c66c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
