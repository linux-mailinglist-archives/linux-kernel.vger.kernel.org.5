Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287676759E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjG1Sje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjG1Sj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B917B448C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AF79621DB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0ACBC433C8;
        Fri, 28 Jul 2023 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569566;
        bh=ADG46cY+cROEucJsffbJcdaqD8LPvm3wsKqFrJvr6gE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DgY2gVqToGX6X0nujoqsilfJ37A+XJEdDsMNjnPgI7XqcoSUwpWTM6Sl6+w5oOgy5
         MQTGFHvNk+HewcSwUdxkHL06f4Ly+t+14npAfBizEvcgu9MjEMFhDrhYzQU0yg4zVr
         Pj/kMqKVHmots/AiRPR89g4EPmMrTe71Y+7nmGhixfpKKHTOPY07w+IzvRm0sfS3gK
         TvZ1vvLtZVDai+kwdLnKXxwCpTnRjrlLO8D1Iqr8ql5p30QCLCmsYnprKoES1vAR2V
         ke4hg1zahst6RNeT8x7d11JZfX3IAsYK5/32l3WTZHVh5vEbrlxwOJydJJolqktCYr
         /hM2Kq9ywE7Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CED8C43169;
        Fri, 28 Jul 2023 18:39:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twwk0C6kGQXFZdvEhxnLe7DhnwN8doj_yA3a9S3hs7c1w@mail.gmail.com>
References: <CAPM=9twwk0C6kGQXFZdvEhxnLe7DhnwN8doj_yA3a9S3hs7c1w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twwk0C6kGQXFZdvEhxnLe7DhnwN8doj_yA3a9S3hs7c1w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-28
X-PR-Tracked-Commit-Id: 9a767faa9477ef2a5fee6a0c9d69587b95a885df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17bf3df9af08c5e87c07a92b811b7f9f8034a32c
Message-Id: <169056956657.21363.10709736526382075646.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 12:20:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17bf3df9af08c5e87c07a92b811b7f9f8034a32c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
