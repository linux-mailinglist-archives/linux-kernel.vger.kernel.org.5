Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A376EF7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjHCQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHCQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7485359A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6804D61E0C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA438C433C7;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080245;
        bh=B/B/iwYde+o5hrsKd2KWu9SZHOApuMVDyPMm+nQQrH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bNw613xkgEGhMVHr6GHQZ1Bc4laeLYRpVe4D+cF8MN3+8sso9bQJo5Cgq9F7eH3qX
         PQZrFpRJbPl4MfpRsukN3GhMQ/VHlTy7lhslTTOFsf8/cd+y0k2N2TW3xLhWC3E08H
         FPC6zWC4ZbxieGj7qpN05DJ57nnlHqnAy+tyfuIdgeJXLVZywQ22Zdl9omgbruYqPP
         wAkqDLCNEba8TTity4mEairQEA/12Y0FmoFFM+i2D+AWiXCPw6PSbrTO50kQtoEkeA
         NSrHMocvEipTeiEcAjqCpUJcEyrCYuAIDjYNa+1Z9n8e8tmUO8ZDM4G1u+QCb8yFHj
         osGZd9JQlZPlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A21FCC43168;
        Thu,  3 Aug 2023 16:30:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMu+q8oCAVG6PqK1@debian>
References: <ZMu+q8oCAVG6PqK1@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMu+q8oCAVG6PqK1@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc5-fixes
X-PR-Tracked-Commit-Id: 4da3c7183e186afe8196160f16d5a0248a24e45d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556c9424e271abff7ada9196007418f7b8431c6e
Message-Id: <169108024565.31872.3627744786111502086.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 16:30:45 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Shijie Sun <sunshijie@xiaomi.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Aug 2023 22:50:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556c9424e271abff7ada9196007418f7b8431c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
