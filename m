Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3724375BCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGUDkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGUDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5DB2736
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C609C60DFA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 332B9C433C8;
        Fri, 21 Jul 2023 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689910828;
        bh=Q51TPPWWwycteTmV51RjTNt/Z003CwT+pqLt6PhyHLg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g843LGc+x8nzdUGnvWhKDN5EED+oJkLq2K/Kbv7u8YKRVHoxCE2FciEtQwn48tS/p
         5QHKYze644GnrHc2oHQOjHjeo7mc/7aY8ssCV7mdQ2Sapkc0nlHkNHrMHAknPh13Nb
         YGKty8n9Si1tzZo+H3aLiJDQU/l4XMRq7mRmTf9n0W0HTydnOEPoiH3VBxQkhCXb7S
         tkhjWFxrYd0qFYi4Mu3kjSlQOzXFk5vVCeE0y0wePwKvJ/6ZShGatim43VQH8wxaWv
         EAZz/GAoS6LsLjbP6z6vXE81Y2YsBcYR4BuDRGao00i1J15U2XI0FyG1b3T8dQNgah
         VA78WtZWghbtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F876C64458;
        Fri, 21 Jul 2023 03:40:28 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txWYVhy+bM9EMBDy3p=vqCE=E_yHPb6GRC_Zx-EN42RSg@mail.gmail.com>
References: <CAPM=9txWYVhy+bM9EMBDy3p=vqCE=E_yHPb6GRC_Zx-EN42RSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txWYVhy+bM9EMBDy3p=vqCE=E_yHPb6GRC_Zx-EN42RSg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-21
X-PR-Tracked-Commit-Id: 28801cc85906ea62043e62c71def7f9daaf1c168
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7e3a1bafdea735050dfde00523cf505dc7fd309
Message-Id: <168991082811.19113.7882791124688893958.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 03:40:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 13:14:05 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-07-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7e3a1bafdea735050dfde00523cf505dc7fd309

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
