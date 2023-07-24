Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195C760197
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGXVza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGXVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CE1992;
        Mon, 24 Jul 2023 14:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2F16141D;
        Mon, 24 Jul 2023 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 885B9C433C7;
        Mon, 24 Jul 2023 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690235725;
        bh=2Wtz/htT5MpLf/NTfCLVY5V/Yr8t4RIdWJm7V5BS6MU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oDgkcvg8cAcOu9XeylnNbu4B39kB3pp6WIkHaAvrS3gsgQ9H+DpAgJGX33WmoH5SB
         XCSF+EPT4jan0EFGALPCTESYTvxw9/bT3wpSDOqizhTAbkT+1mTcBL0Y4UpU9afZEn
         O7+WT4/lLQ1HzEgDsV0BaID4r+gmyYwiy/49DOQUEqtCTk4zKrfSs1VP4mfXFD05WB
         3SdhJ+YGy2BnyCRE1vkBCzg0JcO7b17o6CpAn4NTKnlhyLYa9dpOehJoknjtd3PGrC
         8fhBS/eBsoIwetKAiWQGUdw6Uiw/IM217kCGhXCHY5M611G0n5ZfXGBH0w317aF5F8
         fsHqqdOaCxUWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 718FDE1F658;
        Mon, 24 Jul 2023 21:55:25 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d75dc295e6ddaebc988f5af3ad6d12fa96948f5e.camel@HansenPartnership.com>
References: <d75dc295e6ddaebc988f5af3ad6d12fa96948f5e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <d75dc295e6ddaebc988f5af3ad6d12fa96948f5e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 80b6051085c5fedcb1dfd7b2562a63a83655c4d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
Message-Id: <169023572545.10617.11533993855843312589.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jul 2023 21:55:25 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Jul 2023 15:16:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b5547c51827e053cc754db47d3ec3e6c2c451d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
