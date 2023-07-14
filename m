Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A00754261
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjGNSNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjGNSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8053AAB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC0C61E02
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBD6AC433C8;
        Fri, 14 Jul 2023 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358286;
        bh=DWqcNf1a7AJvPYwW1a7bvmef79UycEwhJtXh0d6CM6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=htrJjd8zMxuRtoxhg5R11t+6WHWdHhfumFBCssLHgz9OfJHp9dzUDCBB6KoiovhS+
         ySz+gs/4h1ugCyUvioUvDq+iF4FTQ00S3FDqouCWzZh/WRC7xKC2dyFx3PcEsP0XHK
         l9Z466wB4182/3wpjV6XKMu3lHkk8qVSl65vgGOsGN/XjBmW2IK7lgZLDbuKPosH2s
         Nqp91PH8kJgs07hfwUC77Yft8k/f+nK+yaJ9ijuv7A3IR7hojxtVuv2hc0Sp8nLLCA
         3z8nZG8JLI+QXOOxIIIA59DcD67fgEkIKqu+JCpwzxvCxny26JCM4hr0E674pgCX9o
         r03AKdVcVQrTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8F34E4508D;
        Fri, 14 Jul 2023 18:11:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txdhgYF63eL7VMpc3gmnvCz=gnxLW=HwTRNHNU8geU5Ww@mail.gmail.com>
References: <CAPM=9txdhgYF63eL7VMpc3gmnvCz=gnxLW=HwTRNHNU8geU5Ww@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txdhgYF63eL7VMpc3gmnvCz=gnxLW=HwTRNHNU8geU5Ww@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-14-1
X-PR-Tracked-Commit-Id: 38d88d5e97c9032ebeca092b9372209f2ca92cdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a97a2993e7e7392292323fefc46d79bf9633e44
Message-Id: <168935828668.1072.11622789745511450148.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jul 2023 18:11:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 14:39:37 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a97a2993e7e7392292323fefc46d79bf9633e44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
