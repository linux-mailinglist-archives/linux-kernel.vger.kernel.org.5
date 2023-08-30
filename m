Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0596878E1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbjH3Vxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjH3Vxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A328F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D9263CD3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7C17C433C7;
        Wed, 30 Aug 2023 21:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693431646;
        bh=2YqB2pheC0MTEY+s9TZ1CUVqBOPY3yxPNIM6CbS6sgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RsV8EKSx4Niu1BJnyTQgQVoHwXERGczOEMTzRH12eE3UycVT4kuVfVeKyrIPFWG0M
         ap8UZ5CzemaIFQ68x9rqxyDbl1DR4VBYQT8zyJxzNQ6F+k6JLvrw1B6JP1nCLkWgzk
         LpT94FmA/PyT8YKnR/tXWp6NZxpJFVs1MtkUCOPMRXzV+DKzJI1g9UeKhf4rQKEIcg
         G1pK9y1AbZJvueglGOyAO2DmFADQYwZxEvNrX+2pxFQjZrPkREs0Eah6FBa0WlApJD
         nHhC66hUCZLCOIBZlICDqAY2gSH9KukiNflwBq46xsf5OwDWEKVPb4zw/yFsVZZj6t
         n10fLvKzwTwVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B43E7C64457;
        Wed, 30 Aug 2023 21:40:46 +0000 (UTC)
Subject: Re: [git pull] drm for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw+0kKGEnCnCTmv8soNA_Kh13DoGs-G-TF7d_kOXWzaGw@mail.gmail.com>
References: <CAPM=9tw+0kKGEnCnCTmv8soNA_Kh13DoGs-G-TF7d_kOXWzaGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw+0kKGEnCnCTmv8soNA_Kh13DoGs-G-TF7d_kOXWzaGw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-08-30
X-PR-Tracked-Commit-Id: 3698a75f5a98d0a6599e2878ab25d30a82dd836a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 461f35f014466c4e26dca6be0f431f57297df3f2
Message-Id: <169343164671.19418.11925741247385922668.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 21:40:46 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 11:03:03 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/461f35f014466c4e26dca6be0f431f57297df3f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
