Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02247794FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHKQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjHKQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9230CD;
        Fri, 11 Aug 2023 09:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D241676FD;
        Fri, 11 Aug 2023 16:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC142C433BA;
        Fri, 11 Aug 2023 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772306;
        bh=6n3Ven9/umLenADQGuKv85FE9FxGxDmzWg1SVuJW5jQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NEuKYp1tgUc8goR7b9uFVn0szkrgxu3+jqRCXeUsyl/dJoHdawg4+w2aXlPQM9n4s
         34L07ILRl9XUzmuNl4xCRQ9l6RF5qRErWxk7VQiCo+u3/ntrTZMdSGiTIq3w8EUMPM
         3TUyEIcKpOEON9Ir04tc/R2L2WvuzkfSiCqVPu0zSqpNtu/klbdur3MLJaBASujvBJ
         MUJN/AYoptajUI43OPl/001Cxbx1RUAIF3HDh31LUOq8ZnG8q78tVTUnTgsd+kiFfM
         mh9pwabY6d3GzEemoxj8jLzgoO3w4MWTfoNst5TTmBuKboTgMrqVTg5vw78F/NLZOn
         cvcD2u/EfEeiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB00BC3274B;
        Fri, 11 Aug 2023 16:45:05 +0000 (UTC)
Subject: Re: [GIT PULL] cpuidle-psci fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230811113734.158421-1-ulf.hansson@linaro.org>
References: <20230811113734.158421-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230811113734.158421-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/cpuidle-psci-v6.5-rc5
X-PR-Tracked-Commit-Id: 12acb348fa4528a4203edf1cce7a3be2c9af2279
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a5482c284e09423face5a7ef571b85185f43a48
Message-Id: <169177230582.3076.11246164681784207913.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 16:45:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Wing Li <wingers@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 13:37:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/cpuidle-psci-v6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a5482c284e09423face5a7ef571b85185f43a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
