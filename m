Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5FC78059E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357329AbjHRFYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357799AbjHRFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE64693
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B5C67935
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77399C433C9;
        Fri, 18 Aug 2023 05:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692335901;
        bh=Wzeqo346ORd+82hsYic/LXIlDoFPY/a8ndi52rdPnPY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mls5yUE5dbEaV/16j+LbBqZrTcIbQcN2MuLlnD/gmrHBuvOAJ1Ns8tWEN1RAu0tmr
         SZ/87l4DuhN2jV/VI4mpEtQQk66f8HN19T4ULIlHOS5k4A3cc/4VatREw4ub/VyvYA
         kaw757mdp3kWojDaAurXuPCR9ITUKcvqiDfiThnWHlbgoF4+dxtWFXFZA+q5oBcxd6
         8VnDHcpq4WtUJ3ibOuJgCF+HHMkJnr3PuXu6TFXWyoYNTadtHX+ctErC8DuffRT5K/
         8UJUDzKVdRIyaDOCr1taEBSnH9uAR29rcdho1pr+gcGQ7AUKCZOBd3L6xnBKDQo0aR
         Q3pk6CmM1p+NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64853E93B34;
        Fri, 18 Aug 2023 05:18:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txN=kOYfE1a4VDrLWz+fvGuhXDuzDo7AK3-DuOEJoO41Q@mail.gmail.com>
References: <CAPM=9txN=kOYfE1a4VDrLWz+fvGuhXDuzDo7AK3-DuOEJoO41Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txN=kOYfE1a4VDrLWz+fvGuhXDuzDo7AK3-DuOEJoO41Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-18-1
X-PR-Tracked-Commit-Id: c611589b4259ed63b9b77be6872b1ce07ec0ac16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ada9c07407d66679967fe5c2cbb7eda2e0addbf
Message-Id: <169233590140.13368.7714490052708786460.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 05:18:21 +0000
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

The pull request you sent on Fri, 18 Aug 2023 07:36:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-08-18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ada9c07407d66679967fe5c2cbb7eda2e0addbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
