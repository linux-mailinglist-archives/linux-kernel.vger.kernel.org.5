Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE334774E37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHHWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHHWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D118DD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E619862D49
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56448C433C7;
        Tue,  8 Aug 2023 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691533470;
        bh=gYj4lnO7cVo7kAqNpPqrV+u9IFgD6+STrYupuOCrD4c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ihhmhKywclVxVuyhD5aiI/LuivvjAt1i9CpaG19Uox1yl+9LxYHBs0PeT2YGpxTkX
         VjDbx5jF6BUyL5kL/rZk8DSSGnGm2w02/iAeEOBzU5KnkbMom1qyfnWPFiBX8SYp1p
         ld8ygSsCpbUFxApka6zZgXJGTdpsoqv8ySngeA3v7bTD7FAnZW5k7WEjOOBwmZShFs
         oBlqLNcQdUIboYypVgUQmrkBy4x+am2T+QjD1jkyjYycHUfTpqzau8G3l2cg8qLE+U
         xHLGRutiP1YRSFqwj1kNq1jdRfxRHvSvCzsf43AqR6sSjbLnu+3qRKjOwrdP3YE9n6
         F/4GNmunrl+/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42FF9C395C5;
        Tue,  8 Aug 2023 22:24:30 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202308081415.A5E80C1B@keescook>
References: <202308081415.A5E80C1B@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202308081415.A5E80C1B@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc6
X-PR-Tracked-Commit-Id: cdddb626dc053a2bbe8be4150e9b67395130a683
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13b9372068660fe4f7023f43081067376582ef3c
Message-Id: <169153347025.20843.6653776651970562650.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Aug 2023 22:24:30 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Aug 2023 14:16:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13b9372068660fe4f7023f43081067376582ef3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
